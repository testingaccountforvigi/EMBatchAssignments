import 'package:flutter/material.dart';

import '../app/app_routes.dart';
import '../app/app_theme.dart';
import '../models/feedback_entry.dart';
import '../widgets/stub_card.dart';

/// Screen 3 of 3. Confirms what was submitted.
///
/// The entry arrives through `onGenerateRoute`, already type-checked, so this
/// screen never has to cast `ModalRoute.of(context)!.settings.arguments`.
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.entry});

  final FeedbackEntry entry;

  String _formatted(DateTime d) {
    const List<String> months = <String>[
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    final String hh = d.hour.toString().padLeft(2, '0');
    final String mm = d.minute.toString().padLeft(2, '0');
    return '${d.day} ${months[d.month - 1]} ${d.year}, $hh:$mm';
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Summary'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.xl),
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 52,
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.risoPink,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    entry.initials,
                    style: text.titleMedium?.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Filed, thank you', style: text.headlineSmall),
                      const SizedBox(height: 2),
                      Text('Sent ${_formatted(entry.submittedAt)}',
                          style: text.bodyMedium),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            StubCard(
              top: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(entry.fullName, style: text.headlineSmall),
                  const SizedBox(height: 2),
                  Text(entry.email, style: text.bodyMedium),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: <Widget>[
                      ...List<Widget>.generate(
                        5,
                        (int i) => Container(
                          width: 26,
                          height: 8,
                          margin: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            color: i < entry.rating
                                ? AppColors.ultraviolet
                                : AppColors.hairline,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        entry.ratingLabel,
                        style: text.bodyLarge?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.ultraviolet,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              bottom: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _Line(label: 'Session', value: entry.track),
                  _Line(label: 'Score', value: '${entry.rating} out of 5'),
                  _Line(label: 'Password', value: entry.maskedPassword),
                  _Line(
                    label: 'Comments',
                    value: entry.comments.isEmpty
                        ? 'None left'
                        : entry.comments,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.mint.withOpacity(0.12),
                borderRadius: BorderRadius.circular(AppSpacing.radiusField),
              ),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.check_circle_rounded,
                      color: AppColors.mint, size: 22),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'A copy is on its way to ${entry.email}.',
                      style: text.bodyMedium?.copyWith(color: AppColors.ink),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            FilledButton(
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.home,
                (Route<dynamic> route) => false,
              ),
              child: const Text('Back to start'),
            ),
            const SizedBox(height: AppSpacing.xs),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Edit my answers'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 92,
            child: Text(label, style: text.bodyMedium?.copyWith(fontSize: 13)),
          ),
          Expanded(
            child: Text(
              value,
              style: text.bodyLarge?.copyWith(fontSize: 14.5),
            ),
          ),
        ],
      ),
    );
  }
}
