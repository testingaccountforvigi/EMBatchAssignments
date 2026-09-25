import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// DESIGN TOKENS
// ---------------------------------------------------------------------------

/// A restrained, deliberate palette: warm bone canvas, near-black ink,
/// muted stone for secondary text, and a single oxblood accent used only
/// where it matters (avatar ring, primary action, timeline, section marks).
class AppColors {
  AppColors._();

  static const Color canvas = Color(0xFFF3F0E9); // page background
  static const Color surface = Color(0xFFFAF8F3); // sheets, input fills
  static const Color ink = Color(0xFF17171A); // primary text
  static const Color inkHover = Color(0xFF26262A); // hover state of ink fills
  static const Color inkMuted = Color(0xFF4A473F); // body copy
  static const Color stone = Color(0xFF8C8579); // secondary / metadata text
  static const Color hairline = Color(0xFFDCD5C6); // borders and dividers
  static const Color accent = Color(0xFF7A2A2F); // single accent — oxblood
  static const Color accentTint = Color(0xFFF1DEDD); // avatar background
  static const Color hoverTint = Color(0x14171717); // ~8% ink, for hover washes
}

/// A consistent spacing scale used instead of arbitrary padding values.
class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
}

/// Explicit type scale for the screen's content. Kept separate from
/// [ThemeData.textTheme] so hierarchy is precise and intentional rather
/// than inherited from Material defaults.
class AppText {
  AppText._();

  static const TextStyle heroName = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
    letterSpacing: -0.6,
    height: 1.05,
  );

  static const TextStyle role = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.ink,
  );

  static const TextStyle meta = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.stone,
  );

  static const TextStyle body = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.inkMuted,
    height: 1.6,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.ink,
    letterSpacing: -0.1,
  );

  static const TextStyle statValue = TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
    letterSpacing: -0.3,
  );

  static const TextStyle statLabel = TextStyle(
    fontSize: 12.5,
    fontWeight: FontWeight.w400,
    color: AppColors.stone,
  );

  static const TextStyle detailLabel = TextStyle(
    fontSize: 12.5,
    fontWeight: FontWeight.w400,
    color: AppColors.stone,
  );

  static const TextStyle detailValue = TextStyle(
    fontSize: 14.5,
    fontWeight: FontWeight.w500,
    color: AppColors.ink,
  );

  static const TextStyle navLabel = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.stone,
    letterSpacing: 0.2,
  );

  static const TextStyle sheetTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.ink,
  );

  static const TextStyle rowLabel = TextStyle(
    fontSize: 14.5,
    fontWeight: FontWeight.w500,
    color: AppColors.ink,
  );
}

/// A single "Recent activity" entry, including the longer description
/// shown when the entry is opened.
class _ActivityEntry {
  final IconData icon;
  final String title;
  final String time;
  final String description;
  const _ActivityEntry(this.icon, this.title, this.time, this.description);
}

/// A single row option inside a bottom sheet.
class _SheetOption {
  final IconData icon;
  final String label;
  const _SheetOption(this.icon, this.label);
}

// ---------------------------------------------------------------------------
// PROFILE SCREEN
// ---------------------------------------------------------------------------

/// The main profile screen. Stateful because the Follow state and the
/// entrance animation both update the UI after the first frame.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  // ---- Profile data (fictional) -------------------------------------------
  static const String _name = 'Mahesh Rajpurohit';
  static const String _username = '@mahesh';
  static const String _role = 'Product Designer & Developer';
  static const String _location = 'Mumbai, India';
  static const String _bio =
      'Building thoughtful digital experiences at the intersection of '
      'design, technology, and everyday life.';

  final int _projects = 28;
  final int _following = 312;
  int _followerCount = 4800;
  static const String _phone = "+91 1234567890";

  final List<_ActivityEntry> _activity = const [
    _ActivityEntry(
      Icons.design_services_outlined,
      'Designed a new mobile onboarding flow',
      '2 days ago',
      'Reworked the first-run experience end to end, cutting the number '
          'of screens from six to three while keeping every core setup step.',
    ),
    _ActivityEntry(
      Icons.rocket_launch_outlined,
      'Published a Flutter open-source project',
      '1 week ago',
      'Released an open-source package for handling adaptive layouts, '
          'now used in a handful of community projects.',
    ),
    _ActivityEntry(
      Icons.groups_outlined,
      'Joined the Product Design community',
      '3 weeks ago',
      'Started contributing critiques and resources to a small, '
          'invite-only community of product designers.',
    ),
  ];

  // ---- Interactive state ---------------------------------------------------
  bool _isFollowing = false;

  // ---- Entrance animation ---------------------------------------------
  // A single orchestrated reveal for the identity block — deliberately
  // not repeated on every section, which would read as generic scroll-in.
  late final AnimationController _entranceController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: Curves.easeOutCubic,
          ),
        );
    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  // ---- Helpers ---------------------------------------------------------------

  String _formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
      _followerCount += _isFollowing ? 1 : -1;
    });
  }

  void _showMoreSheet() {
    const options = [
      _SheetOption(Icons.edit_outlined, 'Edit profile'),
      _SheetOption(Icons.notifications_outlined, 'Notifications'),
      _SheetOption(Icons.lock_outline_rounded, 'Privacy'),
      _SheetOption(Icons.info_outline_rounded, 'About this app'),
    ];

    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SheetHandle(),
                for (int i = 0; i < options.length; i++) ...[
                  _SheetRow(
                    icon: options[i].icon,
                    label: options[i].label,
                    onTap: () {
                      Navigator.pop(sheetContext);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${options[i].label} opened')),
                      );
                    },
                  ),
                  if (i != options.length - 1)
                    const Divider(height: 1, color: AppColors.hairline),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  void _showMessageComposer() {
    final controller = TextEditingController();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.xl,
            right: AppSpacing.xl,
            top: AppSpacing.xl,
            bottom:
                MediaQuery.of(sheetContext).viewInsets.bottom + AppSpacing.xl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Message Arjun', style: AppText.sheetTitle),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: controller,
                autofocus: true,
                maxLines: 3,
                style: const TextStyle(color: AppColors.ink, fontSize: 14.5),
                decoration: const InputDecoration(hintText: 'Write a message…'),
              ),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(sheetContext);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Message sent to Arjun')),
                  );
                },
                child: const Text('Send'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showShareSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SheetHandle(),
                _SheetRow(
                  icon: Icons.link_rounded,
                  label: 'Copy profile link',
                  onTap: () {
                    Navigator.pop(sheetContext);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile link copied')),
                    );
                  },
                ),
                const Divider(height: 1, color: AppColors.hairline),
                _SheetRow(
                  icon: Icons.qr_code_rounded,
                  label: 'Show QR code',
                  onTap: () {
                    Navigator.pop(sheetContext);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('QR code ready to scan')),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showActivityDetail(_ActivityEntry entry) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SheetHandle(),
                Text(entry.time, style: AppText.meta),
                const SizedBox(height: AppSpacing.xs),
                Text(entry.title, style: AppText.sheetTitle),
                const SizedBox(height: AppSpacing.md),
                Text(entry.description, style: AppText.body),
                const SizedBox(height: AppSpacing.xl),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(sheetContext),
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ---- Build ----------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 760;
            final contentMaxWidth = isWide ? 1040.0 : 640.0;
            final horizontalPadding = isWide
                ? AppSpacing.xxxl + AppSpacing.lg
                : AppSpacing.lg;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: contentMaxWidth),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: AppSpacing.lg,
                  ),
                  // COLUMN: the primary vertical structure of the screen.
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTopBar(context),
                      SizedBox(
                        height: isWide
                            ? AppSpacing.xxxl + AppSpacing.md
                            : AppSpacing.xxl,
                      ),
                      _buildBody(context, isWide),
                      const SizedBox(height: AppSpacing.xxxl),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Minimal top navigation: back, a subtle page label, and more options.
  Widget _buildTopBar(BuildContext context) {
    // ROW: lays the back icon, label and more icon out horizontally.
    return Row(
      children: [
        IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Back to previous screen')),
            );
          },
          tooltip: 'Back',
          icon: const Icon(Icons.arrow_back_rounded, size: 20),
        ),
        const Spacer(),
        // TEXT: a subtle page label in the top navigation.
        const Text('Profile', style: AppText.navLabel),
        const Spacer(),
        IconButton(
          onPressed: _showMoreSheet,
          tooltip: 'More options',
          icon: const Icon(
            Icons.more_horiz_rounded,
            size: 22,
          ), // ICON: settings entry point.
        ),
      ],
    );
  }

  /// Splits into a two-column composition on wide viewports (a fixed
  /// identity column beside a flexible details column, separated by a
  /// real vertical rule), and stacks on narrower ones.
  Widget _buildBody(BuildContext context, bool isWide) {
    final identity = _buildIdentityBlock(context);
    final details = _buildDetailsBlock(context);

    if (isWide) {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 320, child: identity),
            const SizedBox(width: AppSpacing.xl),
            Container(width: 1, color: AppColors.hairline), // vertical rule
            const SizedBox(width: AppSpacing.xl),
            Expanded(child: details),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        identity,
        const SizedBox(height: AppSpacing.xxxl),
        const Divider(color: AppColors.hairline),
        const SizedBox(height: AppSpacing.xxxl),
        details,
      ],
    );
  }

  /// Avatar, name, role, location, bio, actions and stats.
  Widget _buildIdentityBlock(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderRow(context),
                const SizedBox(height: AppSpacing.lg),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: const Text(_bio, style: AppText.body),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        _buildActions(context),
        const SizedBox(height: AppSpacing.xxl),
        const Divider(color: AppColors.hairline),
        const SizedBox(height: AppSpacing.lg),
        _buildStats(context),
      ],
    );
  }

  /// Avatar beside the name/role/location text block.
  Widget _buildHeaderRow(BuildContext context) {
    // ROW: places the avatar beside the identity text.
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // CONTAINER: the accent ring surrounding the avatar.
          padding: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            border: Border.fromBorderSide(
              BorderSide(color: AppColors.accent, width: 1.4),
            ),
          ),
          // CIRCLEAVATAR: the profile avatar — no network image, a
          // deliberate initials fallback instead.
          child: const CircleAvatar(
            radius: 36,
            backgroundColor: AppColors.accentTint,
            child: Text(
              'MR',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.accent,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TEXT: the user's name — the single largest text on screen.
              const Text(_name, style: AppText.heroName),
              const SizedBox(height: 4),
              const Text(_username, style: AppText.meta),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: const [
                  Icon(Icons.badge_outlined, size: 14, color: AppColors.accent),
                  SizedBox(width: 6),
                  Flexible(child: Text(_role, style: AppText.role)),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: const [
                  Icon(
                    Icons.location_on_outlined,
                    size: 14,
                    color: AppColors.stone,
                  ),
                  SizedBox(width: 6),
                  Flexible(child: Text(_location, style: AppText.meta)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Follow (primary), Message and Share (secondary) actions.
  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: _FollowButton(isFollowing: _isFollowing, onTap: _toggleFollow),
        ),
        const SizedBox(width: AppSpacing.md),
        _IconActionButton(
          icon: Icons.mail_outline_rounded,
          tooltip: 'Message',
          onTap: _showMessageComposer,
        ),
        const SizedBox(width: AppSpacing.sm),
        _IconActionButton(
          icon: Icons.share_outlined,
          tooltip: 'Share profile',
          onTap: _showShareSheet,
        ),
      ],
    );
  }

  /// Projects / Followers / Following, laid out with a Row.
  Widget _buildStats(BuildContext context) {
    // ROW: places the three statistics side by side.
    return Row(
      children: [
        Expanded(
          child: _Stat(value: _projects.toString(), label: 'Projects'),
        ),
        Container(width: 1, height: 30, color: AppColors.hairline),
        Expanded(
          child: _Stat(value: _formatCount(_followerCount), label: 'Followers'),
        ),
        Container(width: 1, height: 30, color: AppColors.hairline),
        Expanded(
          child: _Stat(value: _following.toString(), label: 'Following'),
        ),
      ],
    );
  }

  /// About and Activity, stacked.
  Widget _buildDetailsBlock(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAbout(context),
        const SizedBox(height: AppSpacing.xxxl),
        _buildActivity(context),
      ],
    );
  }

  Widget _buildAbout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _SectionHeading(title: 'About'),
        SizedBox(height: AppSpacing.sm),
        _DetailRow(
          icon: Icons.location_on_outlined,
          label: 'Location',
          value: _location,
        ),
        Divider(height: 1, color: AppColors.hairline),
        _DetailRow(
          icon: Icons.calendar_today_outlined,
          label: 'Member since',
          value: '2024',
        ),
        Divider(height: 1, color: AppColors.hairline),
        _DetailRow(
          icon: Icons.tune_outlined,
          label: 'Focus',
          value: 'Product Design, Flutter, UX',
        ),
      ],
    );
  }

  Widget _buildActivity(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeading(title: 'Activity'),
        const SizedBox(height: AppSpacing.lg),
        for (int i = 0; i < _activity.length; i++)
          _TimelineItem(
            entry: _activity[i],
            isLast: i == _activity.length - 1,
            onTap: () => _showActivityDetail(_activity[i]),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// INTERACTION PRIMITIVE
// ---------------------------------------------------------------------------

/// Gives any child press-scale feedback and a hover background — used for
/// the Follow button, icon actions, sheet rows and timeline items, so the
/// whole app shares one consistent tactile feel.
class _Pressable extends StatefulWidget {
  final VoidCallback onTap;
  final String? semanticLabel;
  final Widget Function(BuildContext context, bool hovered, bool pressed)
  builder;

  const _Pressable({
    required this.onTap,
    required this.builder,
    this.semanticLabel,
  });

  @override
  State<_Pressable> createState() => _PressableState();
}

class _PressableState extends State<_Pressable> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: widget.semanticLabel,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedScale(
            scale: _pressed ? 0.97 : 1.0,
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOut,
            child: widget.builder(context, _hovered, _pressed),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// REUSABLE WIDGETS
// ---------------------------------------------------------------------------

/// The animated Follow / Following primary action.
class _FollowButton extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback onTap;

  const _FollowButton({required this.isFollowing, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return _Pressable(
      onTap: onTap,
      semanticLabel: isFollowing
          ? 'Following. Tap to unfollow.'
          : 'Follow this profile',
      builder: (context, hovered, pressed) {
        final filled = !isFollowing;
        final Color background;
        if (filled) {
          background = hovered ? AppColors.inkHover : AppColors.ink;
        } else {
          background = hovered ? AppColors.hoverTint : Colors.transparent;
        }
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 46,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: filled ? AppColors.ink : AppColors.hairline,
              width: 1.2,
            ),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 160),
            child: Text(
              isFollowing ? 'Following' : 'Follow',
              key: ValueKey<bool>(isFollowing),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.5,
                color: filled ? AppColors.canvas : AppColors.ink,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// A compact bordered icon button used for secondary actions (Message,
/// Share) with the same tactile feedback as the Follow button.
class _IconActionButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _IconActionButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _Pressable(
      onTap: onTap,
      semanticLabel: tooltip,
      builder: (context, hovered, pressed) {
        return Tooltip(
          message: tooltip,
          child: Container(
            // CONTAINER: a bordered, fixed touch target for a secondary action.
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: hovered ? AppColors.hoverTint : Colors.transparent,
              border: Border.all(color: AppColors.hairline, width: 1.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: AppColors.ink),
          ),
        );
      },
    );
  }
}

/// A single statistic (value + label) within the stats row.
class _Stat extends StatelessWidget {
  final String value;
  final String label;

  const _Stat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    // COLUMN: stacks the number above its label.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(value, style: AppText.statValue),
        const SizedBox(height: AppSpacing.xs),
        Text(label, style: AppText.statLabel),
      ],
    );
  }
}

/// A section title paired with a short accent mark instead of a repeated
/// icon-chip motif — one deliberate structural device, used consistently.
class _SectionHeading extends StatelessWidget {
  final String title;

  const _SectionHeading({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 14, height: 2, color: AppColors.accent),
        const SizedBox(width: AppSpacing.sm),
        Text(title, style: AppText.sectionTitle),
      ],
    );
  }
}

/// A single icon + label + value row inside the About section. No card,
/// no icon chip — separated purely by hairlines and spacing.
class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      // ROW: aligns the icon with the label/value text block.
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.stone), // ICON: detail marker.
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppText.detailLabel),
                const SizedBox(height: 2),
                Text(value, style: AppText.detailValue),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A single entry in the Activity timeline: a dot, a connecting line
/// (when not the last entry), and the entry's content — tappable to open
/// a detail sheet with the full description.
class _TimelineItem extends StatelessWidget {
  final _ActivityEntry entry;
  final bool isLast;
  final VoidCallback onTap;

  const _TimelineItem({
    required this.entry,
    required this.isLast,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                // CONTAINER: the timeline marker for this entry.
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accent,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 1.4, color: AppColors.hairline),
                ),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: _Pressable(
              onTap: onTap,
              semanticLabel: '${entry.title}. Tap for details.',
              builder: (context, hovered, pressed) {
                return Container(
                  color: hovered ? AppColors.hoverTint : Colors.transparent,
                  padding: EdgeInsets.only(
                    bottom: isLast ? AppSpacing.sm : AppSpacing.xl,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(entry.time, style: AppText.meta),
                      const SizedBox(height: 2),
                      Text(entry.title, style: AppText.rowLabel),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// A single row inside a bottom sheet (More, Share).
class _SheetRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SheetRow({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _Pressable(
      onTap: onTap,
      semanticLabel: label,
      builder: (context, hovered, pressed) {
        return Container(
          color: hovered ? AppColors.hoverTint : Colors.transparent,
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.md,
            horizontal: AppSpacing.xs,
          ),
          child: Row(
            children: [
              Icon(icon, size: 18, color: AppColors.ink),
              const SizedBox(width: AppSpacing.md),
              Text(label, style: AppText.rowLabel),
            ],
          ),
        );
      },
    );
  }
}

/// The small drag handle shown at the top of every bottom sheet.
class _SheetHandle extends StatelessWidget {
  const _SheetHandle();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 36,
        height: 4,
        margin: const EdgeInsets.only(bottom: AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.hairline,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
