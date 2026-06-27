import 'package:flutter/material.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status});

  final String status;

  static Color colorFor(String status) => switch (status) {
        'confirmed' => const Color(0xFF10B981),
        'pending' => const Color(0xFFF59E0B),
        'cancelled' || 'declined' => const Color(0xFF94A3B8),
        'requires_rescheduling' => const Color(0xFFEF4444),
        _ => const Color(0xFF64748B),
      };

  static String labelFor(String status) => switch (status) {
        'confirmed' => t.status.confirmed,
        'pending' => t.status.pending,
        'cancelled' => t.status.cancelled,
        'declined' => t.status.declined,
        'requires_rescheduling' => t.status.requiresRescheduling,
        'completed' => t.status.completed,
        // Fallback: title-case any unmapped status code.
        _ => status
            .split('_')
            .map((w) => w.isEmpty ? '' : w[0].toUpperCase() + w.substring(1))
            .join(' '),
      };

  @override
  Widget build(BuildContext context) {
    final color = colorFor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        labelFor(status),
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
