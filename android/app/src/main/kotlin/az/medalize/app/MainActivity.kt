package az.medalize.app

import io.flutter.embedding.android.FlutterFragmentActivity

// FlutterFragmentActivity (not FlutterActivity) is required by local_auth —
// biometric prompts are shown via a Fragment.
class MainActivity : FlutterFragmentActivity()
