# Build configs

Environment values passed to the app at build time via Flutter's
`--dart-define-from-file`. The app reads `API_BASE_URL` in
`lib/core/config/app_config.dart` (default is localhost for local dev).

## Usage

1. Copy a template and set the real URL:
   ```bash
   cp config/staging.json.example config/staging.json
   # edit config/staging.json → your real staging URL (must be HTTPS for release)
   ```
2. Build with it:
   ```bash
   flutter run                  --dart-define-from-file=config/staging.json
   flutter build apk   --release --dart-define-from-file=config/staging.json
   flutter build ipa            --dart-define-from-file=config/staging.json
   flutter build appbundle --release --dart-define-from-file=config/production.json
   ```

Real `config/*.json` files are git-ignored; only the `*.example` templates are
committed. Add more keys here as new `--dart-define` values are introduced.
