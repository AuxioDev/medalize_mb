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
- [x] 🟡 CI прогоняет `flutter analyze` + `flutter test` + сборку APK (`.github/workflows/ci.yml`)

### A2. Окружение / конфигурация
- [ ] 🔴 **Backend URL для тестеров.** По умолчанию `localhost` — недоступен с телефонов.
      Собирать со staging-адресом (обязательно HTTPS):
      ```
      flutter build apk --release --dart-define=API_BASE_URL=https://staging.medalize.app/api
      flutter build ipa        --dart-define=API_BASE_URL=https://staging.medalize.app/api
      ```
- [ ] 🔴 Backend staging поднят и доступен снаружи (CORS/HTTPS/health-check)
- [x] 🟡 Env-конфиги для сборок готовы (`config/*.json.example` + `--dart-define-from-file`, см. `config/README.md`)

### A3. Firebase / Push (если push нужен в тесте)
- [ ] 🟡 Зарегистрировать iOS-приложение в Firebase (bundle `com.example.medalizeMb`)
- [ ] 🟡 Зарегистрировать Android-приложение (package `com.example.medalize_mb`)
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
- [ ] 🔴 Поддержать статусы `no_show` и `requires_rescheduling` + переход при `reschedule`
      (см. `docs/backend_api_contract.md`, раздел 1)
- [ ] 🔴 Тестовые данные: врачи, специализации, рабочие места, слоты
- [ ] 🔴 Админ (Django) может верифицировать тест-докторов (иначе доктор застрянет на «ожидании»)
- [ ] 🟡 Перенести правило отмены на сервер (`can_cancel`) вместо хардкода «2 часа»

### A6. Раздача билда
- [ ] 🟡 iOS: TestFlight (нужен Apple Developer аккаунт, $99/год)
- [ ] 🟡 Android: Google Play Internal Testing **или** прямой APK
- [ ] 🟢 Канал обратной связи для тестеров (форма/чат/почта)
- [x] 🟢 Короткая инструкция тестеру (`docs/testing_guide.md`) — заполнить TODO-ссылки

---

## B. Публичный релиз (стора)

### B1. Идентификация и подпись
- [ ] 🔴 Сменить bundle/package с `com.example.*` на реальный (напр. `az.medalize.app`)
      — iOS (`PRODUCT_BUNDLE_IDENTIFIER`) и Android (`applicationId`)
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
