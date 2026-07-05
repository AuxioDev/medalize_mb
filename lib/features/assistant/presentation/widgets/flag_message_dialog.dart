import 'package:flutter/material.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Asks for an optional reason before reporting an assistant message.
/// Returns the reason (possibly empty) when submitted, or null when cancelled.
Future<String?> showFlagMessageDialog(BuildContext context) {
  final controller = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(context.t.assistant.reportTitle),
      content: TextField(
        controller: controller,
        maxLines: 3,
        minLines: 1,
        autofocus: true,
        decoration: InputDecoration(
          hintText: context.t.assistant.reportHint,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.t.common.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(controller.text.trim()),
          child: Text(context.t.assistant.reportSubmit),
        ),
      ],
    ),
  );
}
