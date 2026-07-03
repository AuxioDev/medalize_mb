# Release Checklist — Medalize

Практический чек-лист готовности к запуску. Две фазы: **A) Тестинг/Бета** (раздать
тестерам) и **B) Публичный релиз** (App Store / Google Play).

Легенда: `[x]` сделано · `[ ]` нужно сделать · 🔴 блокер · 🟡 важно · 🟢 желательно

Связанные документы: контракт бэкенда — `docs/backend_api_contract.md`.

---

## A. Тестинг / Бета

### A1. Код и сборка
- [x] `flutter analyze` чист по `lib/`
- [x] Все юнит/виджет-тесты проходят (`flutter test`)
- [x] Сборка iOS (simulator) и Android (apk) проходит
- [x] Краш-безопасность: Firebase/FCM/locale обёрнуты в try-catch
- [x] 🟡 Mobile CI: `flutter analyze` + `flutter test` + сборка APK (`medalize_mb/.github/workflows/ci.yml`)
- [x] 🟡 Backend CI: Postgres + `manage.py test` (`medalize_be/.github/workflows/ci.yml`); все 139 тестов зелёные

### A2. Окружение / конфигурация
- [x] 🟡 Env-конфиги для сборок готовы (`config/*.json.example` + `--dart-define-from-file`, см. `config/README.md`)
- [x] 🟡 Deploy-конфиги бэкенда готовы: `Dockerfile`, `docker-compose.yml` (web+db+redis+worker+beat), `Procfile`, `.env.example`
- [ ] 🔴 **Поднять backend на хосте** (домен + HTTPS): `cp .env.example .env` → заполнить → `docker compose up --build` на сервере (любой VPS/PaaS). Нужен твой хост/домен.
- [ ] 🔴 **Собрать билд тестерам** с этим URL (обязательно HTTPS):
      ```
      flutter build apk --release --dart-define=API_BASE_URL=https://<твой-домен>/api
      flutter build ipa            --dart-define=API_BASE_URL=https://<твой-домен>/api
      ```

### A3. Firebase / Push (если push нужен в тесте)
- [ ] 🟡 Зарегистрировать iOS-приложение в Firebase (bundle `az.medalize.app`)
- [ ] 🟡 Зарегистрировать Android-приложение (package `az.medalize.app`)
- [ ] 🟡 Заменить плейсхолдеры реальными `GoogleService-Info.plist` / `google-services.json`
- [ ] 🟡 iOS: загрузить APNs-ключ в Firebase, включить Push Notifications capability
- [ ] 🟢 Проверить доставку тест-уведомления
> Без этого приложение работает, но push выключен (init обёрнут безопасно).

### A4. Права и нативные настройки
- [x] iOS: `NSPhotoLibraryUsageDescription` + `NSCameraUsageDescription` (иначе краш при выборе фото)
- [x] Android: `POST_NOTIFICATIONS` (уведомления на Android 13+)
- [x] Имя приложения на домашнем экране = «Medalize»
- [x] Иконка-плейсхолдер (синий градиент + мед-крест) через `flutter_launcher_icons` — больше не лого Flutter. Финальный бренд → см. B5
- [x] iOS: `UIBackgroundModes: remote-notification` (для фоновых push)

### A5. Бэкенд-зависимости (иначе UI вернёт ошибки)
- [x] 🔴 Статусы `no_show` + `requires_rescheduling` приняты эндпоинтом, переходы провалидированы, перенос из `requires_rescheduling` разрешён (бэкенд `medalize_be`, +5 тестов). **Применить миграцию:** `python manage.py migrate`
- [x] 🔴 Тестовые данные: команда `python manage.py seed_data --clear` (5 врачей/10 пациентов/места/часы/записи; пароли `Doctor@1234` / `Patient@1234`)
- [x] 🔴 Админ может верифицировать докторов (Django admin → DoctorProfile → action «Verify selected doctors»)
- [x] 🟡 Правило отмены на сервере: API отдаёт `can_cancel`/`can_reschedule`, клиент их использует (фолбэк на локальное правило). Окно **настраивается per-doctor** (`cancellation_window_hours` в профиле, дефолт 2)

### A6. Раздача билда
- [ ] 🟡 iOS: TestFlight (нужен Apple Developer аккаунт, $99/год)
- [ ] 🟡 Android: Google Play Internal Testing **или** прямой APK
- [ ] 🟢 Канал обратной связи для тестеров (форма/чат/почта)
- [x] 🟢 Короткая инструкция тестеру (`docs/testing_guide.md`) — заполнить TODO-ссылки

---

## B. Публичный релиз (стора)

### B1. Идентификация и подпись
- [x] 🔴 Сменить bundle/package с `com.example.*` на реальный (`az.medalize.app`)
      — iOS (`PRODUCT_BUNDLE_IDENTIFIER`) и Android (`applicationId`/`namespace`)
      > Плейсхолдеры `google-services.json`/`GoogleService-Info.plist` всё ещё
      > содержат старый `com.example.*` id — заменить их реальными конфигами
      > из Firebase Console (см. A3), иначе Android-сборка упадёт на шаге
      > google-services.
- [ ] 🔴 Android: настоящий release keystore (сейчас подписывается debug-ключом — TODO в `android/app/build.gradle.kts`)
- [ ] 🔴 iOS: дистрибутивный профиль/сертификат, App Store Connect запись
- [ ] 🟡 Поднять `version:` в `pubspec.yaml` для каждого релиза (сейчас `1.0.0+1`)

### B2. Безопасность
- [ ] 🔴 Backend prod по HTTPS; убрать `usesCleartextTraffic="true"` (Android) и
      `NSAllowsLocalNetworking` (iOS) — это только для локальной разработки
- [ ] 🟡 Проверить, что токены в `flutter_secure_storage`, нет логов с PII/токенами
- [ ] 🟢 Certificate pinning (по желанию, для медданных)

### B3. Юридическое / бизнес
- [x] В приложении есть экран Privacy & Terms (`/shared/legal`) — **с черновым текстом**
- [ ] 🔴 Заменить черновой текст на финальные **Privacy Policy** и **Terms** (медданные/PHI)
- [ ] 🔴 Публичный URL политики конфиденциальности (требование сторов)
- [ ] 🟡 Согласие на обработку данных при регистрации (чекбокс + ссылка)
- [ ] 🟡 Возрастной рейтинг и «медицинская» категория в сторах
- [ ] 🟢 Контакт поддержки (email/страница)

### B4. Наблюдаемость
- [ ] 🟡 Crash-репортинг (Firebase Crashlytics или Sentry) — сейчас отсутствует
- [ ] 🟢 Аналитика ключевых событий (регистрация, бронь, завершение приёма)

### B5. Дизайн / контент
- [x] Светлая/тёмная темы, дизайн-система, reduce-motion
- [x] Локализация 6 языков; пользовательские строки вынесены в i18n
- [ ] 🟡 Проверить полноту переводов AZ/RU (нет ли английского фолбэка в ключевых экранах)
- [ ] 🟡 Иконка приложения и заставка — финальный бренд
- [ ] 🟢 Пустые/ошибочные состояния просмотрены на реальных данных

### B6. Стор-листинг
- [ ] 🟡 Скриншоты (iPhone/iPad, разные Android-размеры)
- [ ] 🟡 Название, краткое и полное описание, ключевые слова (на нужных языках)
- [ ] 🟡 Иконка стора 1024×1024, feature graphic (Play)
- [ ] 🟢 Промо-текст / что нового

---

## Быстрые команды

```bash
# Анализ и тесты
flutter analyze
flutter test

# Сборка под тестинг (подставить реальный URL)
flutter build apk --release --dart-define=API_BASE_URL=https://staging.medalize.app/api
flutter build ipa            --dart-define=API_BASE_URL=https://staging.medalize.app/api

# Прод-сборка
flutter build appbundle --release --dart-define=API_BASE_URL=https://api.medalize.app/api
```

## Самые срочные блокеры (TL;DR)
1. Доступный staging backend по HTTPS + сборка с `--dart-define=API_BASE_URL`.
2. Бэкенд: статусы `no_show`/`requires_rescheduling` + перенос; тест-данные; верификация докторов админом.
3. Перед публичным релизом: реальные bundle/package ID, release-подпись, финальные Privacy/Terms + публичный URL.
