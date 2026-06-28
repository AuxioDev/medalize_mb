# Backend API Contract — Medalize

Спецификация эндпоинтов, которые нужны бэкенду для функций, реализованных или
запланированных в мобильном приложении. Сгруппировано по приоритету.

**Общие соглашения** (из текущего API):
- JSON, `snake_case`.
- Авторизация: `Authorization: Bearer <access>`; refresh — `POST /auth/token/refresh/`.
- ID — строки.
- Дата/время — ISO‑8601 (клиент шлёт `…toIso8601String()`, иногда в UTC).
- Списки: допускается обёртка `{ "results": [...] }` или «голый» массив — клиент
  понимает оба варианта.
- Все пути относительно базового URL API.

Легенда статуса:
- 🔴 **Срочно** — приложение это уже вызывает/ожидает, иначе фича не работает.
- 🟡 **Запланировано** — UI/логику на клиенте добавим, как только появится API.

---

## 1. 🔴 Жизненный цикл записи (статусы)

Приложение уже шлёт смену статуса доктором:

```
PATCH /doctor/appointments/{id}/status/
Body: { "status": "<value>" }
```

Сервер должен принимать значения и применять допустимые переходы:

| Текущий статус | Допустимые переходы | Кто инициирует |
|---|---|---|
| `pending` | `confirmed`, `declined` | доктор |
| `confirmed` | `completed`, `no_show`, `requires_rescheduling` | доктор |
| `requires_rescheduling` | → перенос пациентом (см. ниже) | пациент |

Значения статуса, которые рендерит клиент (`status_chip`): `pending`,
`confirmed`, `declined`, `cancelled`, `completed`, `requires_rescheduling`,
`no_show`.

**Перенос пациентом** (уже вызывается из приложения):

```
PATCH /appointments/{id}/reschedule/
Body: { "starts_at": "<ISO8601>" }
Response: <Appointment>   // обновлённая запись
```

- Из статуса `requires_rescheduling` после успешного переноса сервер должен
  перевести запись в `pending` (или `confirmed`, по бизнес‑правилу) и обновить
  `starts_at`/`ends_at`.
- Валидация: новый слот свободен и попадает в рабочие часы/не пересекается с
  блокировками.

**Уведомления (FCM):** при `confirmed`, `declined`, `requires_rescheduling`,
переносе — слать пациенту push с `data.type = "appointment"`.

**Объект Appointment** (текущая форма, для справки):
```json
{
  "id": "…",
  "doctor": { "id","first_name","last_name","specialization","specialization_display" },
  "patient": { "id","first_name","last_name" },
  "workplace": { "id","name","address","city" },
  "starts_at": "ISO8601",
  "ends_at": "ISO8601",
  "status": "pending|confirmed|declined|cancelled|completed|requires_rescheduling|no_show",
  "reason": "string",
  "notes": "string",
  "created_at": "ISO8601"
}
```

---

## 2. 🔴 / 🟡 Политика отмены (настраиваемая)

Сейчас клиент **жёстко** считает «можно отменить, если до начала > 2 часов».
Нужно перенести правило на сервер.

Рекомендуемый минимум — отдавать вычисленный флаг прямо в объекте записи:

```jsonc
// внутри Appointment
"can_cancel": true,             // сервер вычислил по политике врача
"cancellation_deadline": "ISO8601"  // опционально, для подсказки в UI
```

И поле политики в профиле врача (редактируемое):

```
PATCH /doctor/profile/
Body: { "cancellation_window_hours": 2, "cancellation_fee": "0.00" }  // опц.
```

`GET /auth/me/` (профиль доктора) должен возвращать `cancellation_window_hours`.

---

## 3. 🟡 Настройки уведомлений (#5)

```
GET   /notifications/preferences/
PATCH /notifications/preferences/
```

```json
{
  "appointment_updates": true,     // подтверждение/отклонение/перенос
  "appointment_reminders": true,   // напоминания до приёма
  "reminder_lead_minutes": [1440, 60],  // за 24ч и 1ч
  "marketing": false
}
```

- Сервер обязан учитывать эти флаги при отправке FCM.
- Токен уже регистрируется клиентом: `POST /notifications/fcm/ { "token": "…" }`.

---

## 4. 🟡 Услуги врача (#8)

Модель `Service`: `{ id, name, duration_min, price, is_active }`.

**CRUD доктора:**
```
GET    /doctor/services/
POST   /doctor/services/        { "name","duration_min","price" }
PATCH  /doctor/services/{id}/   { любое из полей }
DELETE /doctor/services/{id}/
```

**Публично:** в `GET /doctors/{id}/` добавить массив `services`.

**Бронирование с услугой:**
```
GET  /doctors/{id}/slots/?workplace_id=…&date=YYYY-MM-DD&service_id=…
     // длительность слотов = duration_min услуги
POST /appointments/   { …, "service_id": "…" }
```
В объекте Appointment вернуть вложенный `service`.

> Сосуществование с текущим `slot_duration_min`: услуга важнее; при отсутствии
> услуг используется `slot_duration_min` врача (как сейчас).

---

## 5. 🟡 Лист ожидания с предпочтениями (#9)

Сейчас клиент шлёт только `doctor_id`. Расширить:

```
POST /waitlist/
{
  "doctor_id": "…",
  "workplace_id": "…",          // опц.
  "earliest_date": "YYYY-MM-DD",// опц.
  "latest_date":   "YYYY-MM-DD",// опц.
  "preferred_weekdays": [0,1,4],// опц., 0=Пн
  "preferred_time_from": "09:00", // опц.
  "preferred_time_to":   "13:00"  // опц.
}
```

```
GET    /waitlist/            // вернуть записи с указанными полями + doctor_name
DELETE /waitlist/{id}/
```

**Серверная логика:** при освобождении слота, подходящего под предпочтения,
слать пациенту FCM (`data.type = "waitlist"`); опционально — временно
придержать/предложить слот.

---

## 6. 🟡 Ответы врача на отзывы

```
POST  /reviews/{id}/response/   { "text": "…" }   // только автор-врач
PATCH /reviews/{id}/response/   { "text": "…" }
```

В объект отзыва (`GET /doctors/{id}/reviews/`) добавить:
```json
"doctor_response": { "text": "…", "created_at": "ISO8601" }  // или null
```

Текущая форма отзыва (для справки): `{ id, patient_name, rating, comment, created_at }`.

---

## 7. 🟡 Повторяющиеся блокировки времени

Разовые/многодневные блокировки уже работают:
```
POST /doctor/blocked-periods/  { "starts_at","ends_at","reason","notify_patients" }
```
Для повторов добавить рекуррентность:
```jsonc
"recurrence": { "freq": "weekly", "weekdays": [0,2,4], "until": "YYYY-MM-DD" }
```
(или отдельный ресурс `/doctor/recurring-blocks/`).

---

## 8. 🟡 (Опционально) Серверная синхронизация избранного

Сейчас избранное хранится локально на устройстве. Для синка между устройствами:
```
GET    /favorites/                 // [{ doctor }]
POST   /favorites/   { "doctor_id" }
DELETE /favorites/{doctor_id}/
```

---

## Сводка приоритетов для бэкенда

1. **🔴 Статусы записи** `no_show`, `requires_rescheduling` + переход при
   `reschedule` — нужны прямо сейчас (UI уже есть в приложении).
2. **🔴/🟡 `can_cancel`/политика отмены** — убрать хардкод «2 часа» с клиента.
3. 🟡 Настройки уведомлений → услуги → лист ожидания → ответы на отзывы →
   повторяющиеся блокировки → (опц.) синк избранного.
