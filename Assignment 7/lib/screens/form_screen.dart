import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app/app_routes.dart';
import '../app/app_theme.dart';
import '../models/feedback_entry.dart';
import '../utils/validators.dart';

/// Screen 2 of 3. A single [Form] holds registration details and the feedback
/// itself. Validation runs on submit, then live on every keystroke so the user
/// can watch each error clear.
class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirm = TextEditingController();
  final TextEditingController _comments = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmFocus = FocusNode();

  static const List<String> _tracks = <String>[
    'Opening keynote',
    'Type and lettering lab',
    'Sound design workshop',
    'Portfolio clinic',
    'Closing panel',
  ];

  String? _track;
  int _rating = 0;
  bool _agreed = false;
  bool _obscure = true;
  bool _submitted = false;
  int _strength = 0;

  @override
  void initState() {
    super.initState();
    _password.addListener(() {
      final int s = Validators.strength(_password.text);
      if (s != _strength) setState(() => _strength = s);
    });
  }

  @override
  void dispose() {
    // Controllers and focus nodes hold native resources - releasing them here
    // prevents the "setState called after dispose" class of bugs.
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    _comments.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() => _submitted = true);
    FocusScope.of(context).unfocus();

    final bool fieldsOk = _formKey.currentState?.validate() ?? false;
    final bool ratingOk = _rating > 0;

    if (!fieldsOk || !ratingOk || !_agreed) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              !ratingOk
                  ? 'Pick a rating before you send this.'
                  : !_agreed
                      ? 'Tick the consent box to send your response.'
                      : 'A few fields still need fixing.',
            ),
          ),
        );
      return;
    }

    final FeedbackEntry entry = FeedbackEntry(
      fullName: _name.text.trim(),
      email: _email.text.trim(),
      password: _password.text,
      track: _track!,
      rating: _rating,
      comments: _comments.text.trim(),
      submittedAt: DateTime.now(),
    );

    // The model travels to the next screen as a named-route argument.
    Navigator.of(context).pushNamed(AppRoutes.detail, arguments: entry);
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
        title: const Text('Your response'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidateMode: _submitted
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.xl),
            children: <Widget>[
              Text('Register, then rate', style: text.headlineSmall),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Your account keeps the response editable until Friday.',
                style: text.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),

              TextFormField(
                controller: _name,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(labelText: 'Full name'),
                validator: Validators.name,
                onFieldSubmitted: (_) => _emailFocus.requestFocus(),
              ),
              const SizedBox(height: AppSpacing.md),

              TextFormField(
                controller: _email,
                focusNode: _emailFocus,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autocorrect: false,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Email address',
                  helperText: 'Use the address on your ticket.',
                ),
                validator: Validators.email,
                onFieldSubmitted: (_) => _passwordFocus.requestFocus(),
              ),
              const SizedBox(height: AppSpacing.md),

              TextFormField(
                controller: _password,
                focusNode: _passwordFocus,
                obscureText: _obscure,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Password',
                  helperText: 'At least 8 characters, with a number.',
                  suffixIcon: IconButton(
                    icon: Icon(_obscure
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded),
                    color: AppColors.inkSoft,
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
                validator: Validators.password,
                onFieldSubmitted: (_) => _confirmFocus.requestFocus(),
              ),
              const SizedBox(height: AppSpacing.sm),
              _StrengthMeter(score: _strength),
              const SizedBox(height: AppSpacing.md),

              TextFormField(
                controller: _confirm,
                focusNode: _confirmFocus,
                obscureText: _obscure,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'Confirm password'),
                validator: (String? v) =>
                    Validators.confirmPassword(v, _password.text),
              ),
              const SizedBox(height: AppSpacing.lg),

              Text('About the event', style: text.titleMedium),
              const SizedBox(height: AppSpacing.md),

              DropdownButtonFormField<String>(
                value: _track,
                isExpanded: true,
                borderRadius: BorderRadius.circular(AppSpacing.radiusField),
                decoration: const InputDecoration(labelText: 'Session attended'),
                items: _tracks
                    .map((String t) => DropdownMenuItem<String>(
                          value: t,
                          child: Text(t, overflow: TextOverflow.ellipsis),
                        ))
                    .toList(),
                onChanged: (String? v) => setState(() => _track = v),
                validator: Validators.track,
              ),
              const SizedBox(height: AppSpacing.md),

              _RatingPicker(
                value: _rating,
                showError: _submitted && _rating == 0,
                onChanged: (int v) => setState(() => _rating = v),
              ),
              const SizedBox(height: AppSpacing.md),

              TextFormField(
                controller: _comments,
                minLines: 3,
                maxLines: 5,
                maxLength: 300,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Anything else? (optional)',
                  alignLabelWithHint: true,
                ),
                validator: Validators.comments,
              ),
              const SizedBox(height: AppSpacing.xs),

              _ConsentBox(
                value: _agreed,
                showError: _submitted && !_agreed,
                onChanged: (bool v) => setState(() => _agreed = v),
              ),
              const SizedBox(height: AppSpacing.lg),

              FilledButton(
                onPressed: _submit,
                child: const Text('Review my response'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StrengthMeter extends StatelessWidget {
  const _StrengthMeter({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    const List<String> words = <String>[
      'Empty',
      'Weak',
      'Getting there',
      'Decent',
      'Strong',
      'Very strong',
    ];
    final Color tone = score >= 4
        ? AppColors.mint
        : score >= 2
            ? AppColors.ultraviolet
            : AppColors.risoPink;

    return Row(
      children: <Widget>[
        ...List<Widget>.generate(5, (int i) {
          return Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              margin: EdgeInsets.only(right: i == 4 ? 0 : 5),
              height: 5,
              decoration: BoxDecoration(
                color: i < score ? tone : AppColors.hairline,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          );
        }),
        const SizedBox(width: AppSpacing.sm),
        SizedBox(
          width: 92,
          child: Text(
            words[score],
            textAlign: TextAlign.right,
            style: text.bodyMedium?.copyWith(fontSize: 12.5, color: tone),
          ),
        ),
      ],
    );
  }
}

class _RatingPicker extends StatelessWidget {
  const _RatingPicker({
    required this.value,
    required this.showError,
    required this.onChanged,
  });

  final int value;
  final bool showError;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('How would you rate it?',
            style: text.bodyLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: List<Widget>.generate(5, (int i) {
            final int score = i + 1;
            final bool on = score <= value;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: i == 4 ? 0 : 8),
                child: GestureDetector(
                  onTap: () => onChanged(score),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    height: 52,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: on ? AppColors.ultraviolet : AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: showError
                            ? AppColors.risoPink
                            : on
                                ? AppColors.ultraviolet
                                : AppColors.hairline,
                        width: 1.4,
                      ),
                    ),
                    child: Text(
                      '$score',
                      style: text.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: on ? Colors.white : AppColors.inkSoft,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        if (showError)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 4),
            child: Text(
              'Pick a score from 1 to 5.',
              style: text.bodyMedium?.copyWith(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: AppColors.risoPink,
              ),
            ),
          ),
      ],
    );
  }
}

class _ConsentBox extends StatelessWidget {
  const _ConsentBox({
    required this.value,
    required this.showError,
    required this.onChanged,
  });

  final bool value;
  final bool showError;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () => onChanged(!value),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Checkbox(
                  value: value,
                  onChanged: (bool? v) => onChanged(v ?? false),
                  activeColor: AppColors.ultraviolet,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  side: BorderSide(
                    color: showError ? AppColors.risoPink : AppColors.inkSoft,
                    width: 1.6,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      'The organisers may quote this feedback anonymously.',
                      style: text.bodyMedium?.copyWith(fontSize: 13.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showError)
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              'Consent is needed before the response can be filed.',
              style: text.bodyMedium?.copyWith(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: AppColors.risoPink,
              ),
            ),
          ),
      ],
    );
  }
}
