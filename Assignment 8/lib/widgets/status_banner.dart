import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/app_theme.dart';

/// Small pill-shaped banner shown at the top of the list that tells
/// the user, at a glance, whether they are looking at freshly fetched
/// data or data restored from the local SharedPreferences cache.
class StatusBanner extends StatelessWidget {
  final bool isFromCache;
  final DateTime? timestamp;

  const StatusBanner({
    super.key,
    required this.isFromCache,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    final color = isFromCache ? AppTheme.warning : AppTheme.success;
    final icon = isFromCache ? Icons.cloud_off_rounded : Icons.cloud_done_rounded;
    final label = isFromCache
        ? 'Offline — showing cached data'
        : 'Live data from the network';

    final timeLabel = timestamp != null
        ? DateFormat("MMM d, h:mm a").format(timestamp!)
        : '';

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 4, 20, 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              timeLabel.isEmpty ? label : '$label • $timeLabel',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
