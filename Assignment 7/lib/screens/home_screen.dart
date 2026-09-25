import 'package:flutter/material.dart';

import '../app/app_routes.dart';
import '../app/app_theme.dart';
import '../widgets/stub_card.dart';

/// Screen 1 of 3. Introduces the event and sends the attendee to the form.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.lg),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - AppSpacing.lg * 2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: AppColors.risoPink,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text('Encore', style: text.titleMedium),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Text('How was\nFrequency 26?', style: text.displaySmall),
                    const SizedBox(height: AppSpacing.sm),
                    SizedBox(
                      width: 320,
                      child: Text(
                        'Two days of talks and workshops are done. Tell the '
                        'organisers what worked and what to fix next year.',
                        style: text.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    StubCard(
                      top: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Frequency 26', style: text.headlineSmall),
                          const SizedBox(height: AppSpacing.xs),
                          Text('Design and sound, in one room.',
                              style: text.bodyMedium),
                        ],
                      ),
                      bottom: Row(
                        children: const <Widget>[
                          _StubFact(label: 'Dates', value: '12-13 Sept'),
                          SizedBox(width: AppSpacing.md),
                          _StubFact(label: 'Venue', value: 'Hall C, Mumbai'),
                          SizedBox(width: AppSpacing.md),
                          _StubFact(label: 'Seat', value: 'General'),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const _StepList(),
                    const SizedBox(height: AppSpacing.xl),
                    FilledButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed(AppRoutes.form),
                      child: const Text('Start feedback'),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Center(
                      child: Text(
                        'Around two minutes. Nothing is shared publicly.',
                        style: text.bodyMedium?.copyWith(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _StubFact extends StatelessWidget {
  const _StubFact({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: text.bodyMedium?.copyWith(fontSize: 12.5)),
        const SizedBox(height: 2),
        Text(
          value,
          style: text.bodyLarge?.copyWith(fontSize: 14.5, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

/// The three dots really are a sequence, so numbering them is honest here.
class _StepList extends StatelessWidget {
  const _StepList();

  @override
  Widget build(BuildContext context) {
    const List<String> steps = <String>[
      'Register with your email and a password',
      'Rate the sessions you attended',
      'Check the summary before it is filed',
    ];

    return Column(
      children: List<Widget>.generate(steps.length, (int i) {
        final TextTheme text = Theme.of(context).textTheme;
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.ultraviolet.withOpacity(0.10),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${i + 1}',
                  style: text.bodyMedium?.copyWith(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ultraviolet,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: Text(steps[i], style: text.bodyLarge)),
            ],
          ),
        );
      }),
    );
  }
}
