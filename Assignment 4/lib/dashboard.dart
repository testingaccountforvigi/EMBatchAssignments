import 'dart:math' as math;

import 'package:flutter/material.dart';

/// ============================================================================
/// DESIGN TOKENS
/// ============================================================================

class _Palette {
  static const bg = Color(0xFF0A0C0F);
  static const surface = Color(0xFF121519);
  static const surfaceElevated = Color(0xFF181C21);
  static const surfaceHigh = Color(0xFF1F242A);
  static const border = Color(0xFF262B31);
  static const borderSubtle = Color(0xFF1D2126);
  static const textPrimary = Color(0xFFF4F5F6);
  static const textSecondary = Color(0xFF9AA3AE);
  static const textTertiary = Color(0xFF666E78);
  static const accent = Color(0xFF2DD4BF);
  static const accentDim = Color(0xFF1B7F76);
  static const success = Color(0xFF34D399);
  static const warning = Color(0xFFF5A524);
  static const danger = Color(0xFFF56765);
}

class _Space {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 24.0;
  static const xxl = 32.0;
}

class _Radii {
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
}

class _Text {
  static const display = TextStyle(
    color: _Palette.textPrimary,
    fontSize: 26,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.2,
  );
  static const title = TextStyle(
    color: _Palette.textPrimary,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
  );
  static const subtitle = TextStyle(
    color: _Palette.textSecondary,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1,
  );
  static const label = TextStyle(
    color: _Palette.textTertiary,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.8,
  );
  static const metricValue = TextStyle(
    color: _Palette.textPrimary,
    fontSize: 27,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.6,
  );
  static const body = TextStyle(
    color: _Palette.textPrimary,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static const caption = TextStyle(
    color: _Palette.textSecondary,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}

/// ============================================================================
/// RESPONSIVE BREAKPOINTS
/// ============================================================================

enum _Device { mobile, tablet, desktop, wide }

_Device _deviceOf(double width) {
  if (width < 600) return _Device.mobile;
  if (width < 1024) return _Device.tablet;
  if (width < 1440) return _Device.desktop;
  return _Device.wide;
}

double _paddingFor(_Device device) {
  switch (device) {
    case _Device.mobile:
      return _Space.lg;
    case _Device.tablet:
      return _Space.xl;
    case _Device.desktop:
      return _Space.xxl;
    case _Device.wide:
      return 48.0;
  }
}

/// A responsive two-pane layout: side-by-side on tablet/desktop/wide,
/// stacked on mobile. Uses Expanded so each pane shares width by [flexLeft]
/// and [flexRight] proportions without overflowing.
Widget _twoPane({
  required _Device device,
  required Widget left,
  required Widget right,
  int flexLeft = 1,
  int flexRight = 1,
}) {
  if (device == _Device.mobile) {
    return Column(
      children: [
        left,
        const SizedBox(height: _Space.xxl),
        right,
      ],
    );
  }
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(flex: flexLeft, child: left),
      const SizedBox(width: _Space.xl),
      Expanded(flex: flexRight, child: right),
    ],
  );
}

/// ============================================================================
/// DATA MODELS
/// ============================================================================

class _Metric {
  final String label;
  final String value;
  final String delta;
  final bool isPositive;
  final IconData icon;
  final String footnote;
  const _Metric({
    required this.label,
    required this.value,
    required this.delta,
    required this.isPositive,
    required this.icon,
    required this.footnote,
  });
}

enum _EventStatus { success, warning, danger, info }

class _ActivityEvent {
  final String title;
  final String subtitle;
  final String time;
  final _EventStatus status;
  final String? value;
  const _ActivityEvent({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.status,
    this.value,
  });
}

class _RegionData {
  final String name;
  final double ratio;
  final String value;
  const _RegionData(this.name, this.ratio, this.value);
}

class _InsightData {
  final IconData icon;
  final Color color;
  final String text;
  const _InsightData(this.icon, this.color, this.text);
}

/// ============================================================================
/// DASHBOARD SCREEN
/// ============================================================================

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _selectedTimeframe = '30D';
  String _selectedMetric = 'Revenue';

  static const _timeframes = ['7D', '30D', '90D'];
  static const _metricOptions = ['Revenue', 'Users', 'Conversion'];

  final List<_Metric> _kpis = const [
    _Metric(
      label: 'TOTAL REVENUE',
      value: '\$482.6K',
      delta: '12.4%',
      isPositive: true,
      icon: Icons.attach_money,
      footnote: 'vs. previous period',
    ),
    _Metric(
      label: 'ACTIVE USERS',
      value: '18,204',
      delta: '4.8%',
      isPositive: true,
      icon: Icons.group,
      footnote: 'vs. previous period',
    ),
    _Metric(
      label: 'CONVERSION RATE',
      value: '3.72%',
      delta: '0.6%',
      isPositive: false,
      icon: Icons.percent,
      footnote: 'vs. previous period',
    ),
    _Metric(
      label: 'SYSTEM HEALTH',
      value: '99.98%',
      delta: '0.02%',
      isPositive: true,
      icon: Icons.health_and_safety,
      footnote: 'uptime, last 30 days',
    ),
  ];

  final List<_ActivityEvent> _events = const [
    _ActivityEvent(
      title: 'Deployment completed',
      subtitle: 'api-gateway · v2.14.0 · production',
      time: '2m ago',
      status: _EventStatus.success,
      value: 'Success',
    ),
    _ActivityEvent(
      title: 'Payment processed',
      subtitle: 'Invoice #48213 · Enterprise plan',
      time: '18m ago',
      status: _EventStatus.info,
      value: '\$2,400',
    ),
    _ActivityEvent(
      title: 'New user registered',
      subtitle: 'via SSO · workspace: northwind',
      time: '34m ago',
      status: _EventStatus.info,
    ),
    _ActivityEvent(
      title: 'System alert resolved',
      subtitle: 'Elevated latency on eu-west-1',
      time: '1h ago',
      status: _EventStatus.warning,
      value: 'Resolved',
    ),
    _ActivityEvent(
      title: 'Weekly report generated',
      subtitle: 'Operations summary · sent to 6 recipients',
      time: '3h ago',
      status: _EventStatus.info,
    ),
    _ActivityEvent(
      title: 'API rate limit reached',
      subtitle: 'client_id: 88a2 · throttled for 5m',
      time: '5h ago',
      status: _EventStatus.danger,
      value: 'Throttled',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final device = _deviceOf(width);
    final horizontalPadding = _paddingFor(device);
    final maxContentWidth = device == _Device.wide ? 1440.0 : double.infinity;

    return Scaffold(
      backgroundColor: _Palette.bg,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxContentWidth),
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: _Space.xl,
              ),
              children: [
                _DashboardHeader(device: device),
                const SizedBox(height: _Space.xxl),
                _KpiSection(device: device, metrics: _kpis),
                const SizedBox(height: _Space.xxl),
                _twoPane(
                  device: device,
                  flexLeft: 2,
                  flexRight: 1,
                  left: _AnalyticsSection(
                    device: device,
                    timeframes: _timeframes,
                    metricOptions: _metricOptions,
                    selectedTimeframe: _selectedTimeframe,
                    selectedMetric: _selectedMetric,
                    onTimeframeChanged: (t) =>
                        setState(() => _selectedTimeframe = t),
                    onMetricChanged: (m) => setState(() => _selectedMetric = m),
                  ),
                  right: _ActivitySection(events: _events),
                ),
                const SizedBox(height: _Space.xxl),
                _twoPane(
                  device: device,
                  flexLeft: 3,
                  flexRight: 2,
                  left: _PerformanceSection(device: device),
                  right: const _InsightsSection(),
                ),
                const SizedBox(height: _Space.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ============================================================================
/// SHARED UI ATOMS
/// ============================================================================

class _Card extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  const _Card({required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(_Space.lg),
      decoration: BoxDecoration(
        color: _Palette.surface,
        borderRadius: BorderRadius.circular(_Radii.lg),
        border: Border.all(color: _Palette.border, width: 1),
      ),
      child: child,
    );
  }
}

class _HeaderPill extends StatelessWidget {
  final IconData icon;
  final String label;
  const _HeaderPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: _Space.md,
        vertical: _Space.sm,
      ),
      decoration: BoxDecoration(
        color: _Palette.surfaceElevated,
        borderRadius: BorderRadius.circular(_Radii.sm),
        border: Border.all(color: _Palette.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: _Palette.textSecondary),
          const SizedBox(width: _Space.xs),
          Text(label, style: _Text.caption),
        ],
      ),
    );
  }
}

class _IconActionBox extends StatelessWidget {
  final IconData icon;
  final String semanticLabel;
  const _IconActionBox({required this.icon, required this.semanticLabel});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      child: Material(
        color: _Palette.surfaceElevated,
        borderRadius: BorderRadius.circular(_Radii.sm),
        child: InkWell(
          borderRadius: BorderRadius.circular(_Radii.sm),
          onTap: () {},
          child: Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_Radii.sm),
              border: Border.all(color: _Palette.border),
            ),
            child: Icon(icon, size: 18, color: _Palette.textSecondary),
          ),
        ),
      ),
    );
  }
}

class _AvatarBadge extends StatelessWidget {
  const _AvatarBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_Palette.accent, _Palette.accentDim],
        ),
        borderRadius: BorderRadius.circular(_Radii.sm),
      ),
      child: const Text(
        'AK',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: _Space.xs),
        Text(label, style: _Text.caption),
      ],
    );
  }
}

/// A pill-style segmented control (metric / timeframe selectors).
class _SegmentedControl extends StatelessWidget {
  final List<String> options;
  final String selected;
  final ValueChanged<String> onChanged;
  const _SegmentedControl({
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: _Palette.surfaceElevated,
        borderRadius: BorderRadius.circular(_Radii.sm),
        border: Border.all(color: _Palette.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: options.map((opt) {
          final isSelected = opt == selected;
          return Material(
            color: isSelected ? _Palette.surfaceHigh : Colors.transparent,
            borderRadius: BorderRadius.circular(_Radii.sm - 2),
            child: InkWell(
              borderRadius: BorderRadius.circular(_Radii.sm - 2),
              onTap: () => onChanged(opt),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                padding: const EdgeInsets.symmetric(
                  horizontal: _Space.md,
                  vertical: _Space.sm - 2,
                ),
                child: Text(
                  opt,
                  style: _Text.caption.copyWith(
                    color: isSelected
                        ? _Palette.textPrimary
                        : _Palette.textSecondary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// ============================================================================
/// 1. HEADER
/// ============================================================================

class _DashboardHeader extends StatelessWidget {
  final _Device device;
  const _DashboardHeader({required this.device});

  @override
  Widget build(BuildContext context) {
    final isCompact = device == _Device.mobile;

    final brand = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _Palette.accent.withOpacity(0.12),
            borderRadius: BorderRadius.circular(_Radii.sm),
            border: Border.all(color: _Palette.accent.withOpacity(0.3)),
          ),
          child: const Icon(Icons.insights, color: _Palette.accent, size: 17),
        ),
        const SizedBox(width: _Space.sm),
        const Text(
          'PULSE',
          style: TextStyle(
            color: _Palette.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),
      ],
    );

    final titleBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Operations Overview',
          style: _Text.display.copyWith(fontSize: isCompact ? 22 : 26),
        ),
        const SizedBox(height: _Space.xs),
        Text(
          'Real-time performance across product, infra and revenue',
          style: _Text.subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );

    if (isCompact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [brand, const _AvatarBadge()],
          ),
          const SizedBox(height: _Space.lg),
          titleBlock,
          const SizedBox(height: _Space.md),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const _HeaderPill(
                  icon: Icons.calendar_today,
                  label: 'Sep 1 – Sep 7',
                ),
                const SizedBox(width: _Space.sm),
                const _IconActionBox(
                  icon: Icons.notifications_none,
                  semanticLabel: 'Notifications',
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              brand,
              const SizedBox(height: _Space.lg),
              titleBlock,
            ],
          ),
        ),
        const SizedBox(width: _Space.xl),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _HeaderPill(
              icon: Icons.calendar_today,
              label: 'Sep 1 – Sep 7, 2026',
            ),
            const SizedBox(width: _Space.sm),
            const _IconActionBox(
              icon: Icons.notifications_none,
              semanticLabel: 'Notifications',
            ),
            const SizedBox(width: _Space.sm),
            const _AvatarBadge(),
          ],
        ),
      ],
    );
  }
}

/// ============================================================================
/// 2. KPI / OVERVIEW SECTION  (GridView)
/// ============================================================================

class _KpiSection extends StatelessWidget {
  final _Device device;
  final List<_Metric> metrics;
  const _KpiSection({required this.device, required this.metrics});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    int columns;
    double aspectRatio;

    switch (device) {
      case _Device.mobile:
        columns = width < 420 ? 1 : 2;
        aspectRatio = width < 420 ? 2.2 : 1.5;
        break;
      case _Device.tablet:
        columns = 2;
        aspectRatio = 1.9;
        break;
      case _Device.desktop:
        columns = 4;
        aspectRatio = 1.35;
        break;
      case _Device.wide:
        columns = 4;
        aspectRatio = 1.5;
        break;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: metrics.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: _Space.lg,
        mainAxisSpacing: _Space.lg,
        childAspectRatio: aspectRatio,
      ),
      itemBuilder: (context, index) => _MetricCard(metric: metrics[index]),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final _Metric metric;
  const _MetricCard({required this.metric});

  @override
  Widget build(BuildContext context) {
    final trendColor = metric.isPositive ? _Palette.success : _Palette.danger;
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  metric.label,
                  style: _Text.label,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(metric.icon, size: 16, color: _Palette.textTertiary),
            ],
          ),
          const SizedBox(height: _Space.sm),
          Text(
            metric.value,
            style: _Text.metricValue,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: _Space.xs),
          Row(
            children: [
              Icon(
                metric.isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                size: 13,
                color: trendColor,
              ),
              const SizedBox(width: 2),
              Text(
                metric.delta,
                style: _Text.caption.copyWith(
                  color: trendColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: _Space.xs),
              Flexible(
                child: Text(
                  metric.footnote,
                  style: _Text.caption,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ============================================================================
/// 3. MAIN ANALYTICS SECTION  (custom-painted chart)
/// ============================================================================

class _AnalyticsSection extends StatelessWidget {
  final _Device device;
  final List<String> timeframes;
  final List<String> metricOptions;
  final String selectedTimeframe;
  final String selectedMetric;
  final ValueChanged<String> onTimeframeChanged;
  final ValueChanged<String> onMetricChanged;

  const _AnalyticsSection({
    required this.device,
    required this.timeframes,
    required this.metricOptions,
    required this.selectedTimeframe,
    required this.selectedMetric,
    required this.onTimeframeChanged,
    required this.onMetricChanged,
  });

  List<double> get _series {
    final rnd = math.Random(
      selectedMetric.hashCode ^ selectedTimeframe.hashCode,
    );
    final points = selectedTimeframe == '7D'
        ? 7
        : (selectedTimeframe == '30D' ? 14 : 18);
    double v = 40 + rnd.nextDouble() * 20;
    return List.generate(points, (i) {
      v += (rnd.nextDouble() - 0.35) * 12;
      v = v.clamp(15, 95);
      return v;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isCompact = device == _Device.mobile;
    final series = _series;
    final current = series.last;
    final prev = series[series.length - 2];
    final changePct = ((current - prev) / prev * 100);
    final isPositive = changePct >= 0;

    String currentDisplay;
    if (selectedMetric == 'Revenue') {
      currentDisplay = '\$${current.toStringAsFixed(1)}K';
    } else if (selectedMetric == 'Users') {
      currentDisplay = '${(current * 210).round()}';
    } else {
      currentDisplay = '${current.toStringAsFixed(2)}%';
    }

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Performance Trend', style: _Text.title),
          const SizedBox(height: 2),
          const Text(
            'Aggregated across all active workspaces',
            style: _Text.caption,
          ),
          const SizedBox(height: _Space.lg),
          Wrap(
            spacing: _Space.sm,
            runSpacing: _Space.sm,
            children: [
              _SegmentedControl(
                options: metricOptions,
                selected: selectedMetric,
                onChanged: onMetricChanged,
              ),
              _SegmentedControl(
                options: timeframes,
                selected: selectedTimeframe,
                onChanged: onTimeframeChanged,
              ),
            ],
          ),
          const SizedBox(height: _Space.xl),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                currentDisplay,
                style: _Text.display.copyWith(fontSize: isCompact ? 24 : 30),
              ),
              const SizedBox(width: _Space.sm),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 14,
                      color: isPositive ? _Palette.success : _Palette.danger,
                    ),
                    Text(
                      '${changePct.abs().toStringAsFixed(1)}%',
                      style: _Text.caption.copyWith(
                        color: isPositive ? _Palette.success : _Palette.danger,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: _Space.lg),
          SizedBox(
            height: isCompact ? 160 : 220,
            width: double.infinity,
            child: CustomPaint(
              painter: _TrendChartPainter(
                values: series,
                isPositive: isPositive,
              ),
            ),
          ),
          const SizedBox(height: _Space.md),
          Row(
            children: [
              _LegendDot(color: _Palette.accent, label: selectedMetric),
              const SizedBox(width: _Space.lg),
              const _LegendDot(
                color: _Palette.textTertiary,
                label: 'Previous period',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrendChartPainter extends CustomPainter {
  final List<double> values;
  final bool isPositive;
  _TrendChartPainter({required this.values, required this.isPositive});

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2) return;
    final minV = values.reduce(math.min);
    final maxV = values.reduce(math.max);
    final range = (maxV - minV).abs() < 1 ? 1 : (maxV - minV);

    final gridPaint = Paint()
      ..color = _Palette.border.withOpacity(0.6)
      ..strokeWidth = 1;
    for (int i = 0; i <= 3; i++) {
      final y = size.height / 3 * i;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final points = <Offset>[];
    for (int i = 0; i < values.length; i++) {
      final x = size.width * (i / (values.length - 1));
      final normalized = (values[i] - minV) / range;
      final y =
          size.height - (normalized * size.height * 0.85) - size.height * 0.05;
      points.add(Offset(x, y));
    }

    final lineColor = isPositive ? _Palette.accent : _Palette.warning;

    final areaPath = Path()..moveTo(points.first.dx, size.height);
    for (final p in points) {
      areaPath.lineTo(p.dx, p.dy);
    }
    areaPath.lineTo(points.last.dx, size.height);
    areaPath.close();

    final areaPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [lineColor.withOpacity(0.28), lineColor.withOpacity(0.0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(areaPath, areaPaint);

    final linePath = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      final prev = points[i - 1];
      final curr = points[i];
      final midX = (prev.dx + curr.dx) / 2;
      linePath.cubicTo(midX, prev.dy, midX, curr.dy, curr.dx, curr.dy);
    }
    final linePaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(linePath, linePaint);

    final marker = points.last;
    canvas.drawCircle(marker, 4.5, Paint()..color = _Palette.surface);
    canvas.drawCircle(
      marker,
      4.5,
      Paint()
        ..color = lineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
    canvas.drawCircle(marker, 2, Paint()..color = lineColor);
  }

  @override
  bool shouldRepaint(covariant _TrendChartPainter oldDelegate) {
    return oldDelegate.values != values || oldDelegate.isPositive != isPositive;
  }
}

/// ============================================================================
/// 4. ACTIVITY / RECENT EVENTS SECTION  (ListView)
/// ============================================================================

class _ActivitySection extends StatelessWidget {
  final List<_ActivityEvent> events;
  const _ActivitySection({required this.events});

  @override
  Widget build(BuildContext context) {
    return _Card(
      padding: const EdgeInsets.symmetric(vertical: _Space.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: _Space.lg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Activity', style: _Text.title),
                Icon(Icons.more_horiz, size: 18, color: _Palette.textTertiary),
              ],
            ),
          ),
          const SizedBox(height: _Space.sm),
          // Nested inside the page-level ListView: shrinkWrap + Never-
          // ScrollableScrollPhysics render full extent instead of creating
          // an independent scroll region, avoiding nested-scroll conflicts.
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: _Space.lg),
            itemCount: events.length,
            separatorBuilder: (_, __) =>
                const Divider(height: _Space.xl, color: _Palette.borderSubtle),
            itemBuilder: (context, index) =>
                _ActivityTile(event: events[index]),
          ),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final _ActivityEvent event;
  const _ActivityTile({required this.event});

  Color get _statusColor {
    switch (event.status) {
      case _EventStatus.success:
        return _Palette.success;
      case _EventStatus.warning:
        return _Palette.warning;
      case _EventStatus.danger:
        return _Palette.danger;
      case _EventStatus.info:
        return _Palette.accent;
    }
  }

  IconData get _statusIcon {
    switch (event.status) {
      case _EventStatus.success:
        return Icons.check_circle;
      case _EventStatus.warning:
        return Icons.warning_amber_rounded;
      case _EventStatus.danger:
        return Icons.error_outline;
      case _EventStatus.info:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _statusColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(_Radii.sm),
          ),
          child: Icon(_statusIcon, size: 16, color: _statusColor),
        ),
        const SizedBox(width: _Space.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      event.title,
                      style: _Text.body,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: _Space.sm),
                  Text(event.time, style: _Text.caption),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                event.subtitle,
                style: _Text.caption,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (event.value != null) ...[
                const SizedBox(height: _Space.xs),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: _Space.sm,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: _Palette.surfaceElevated,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: _Palette.border),
                  ),
                  child: Text(
                    event.value!,
                    style: _Text.caption.copyWith(fontSize: 11),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// ============================================================================
/// 5. SECONDARY SECTION — "Regional Activity" (Flexible / Expanded)
/// ============================================================================

class _PerformanceSection extends StatelessWidget {
  final _Device device;
  const _PerformanceSection({required this.device});

  static const _regions = [
    _RegionData('North America', 0.82, '42.1K'),
    _RegionData('Europe', 0.64, '28.4K'),
    _RegionData('Asia Pacific', 0.51, '19.7K'),
    _RegionData('Latin America', 0.28, '8.9K'),
  ];

  @override
  Widget build(BuildContext context) {
    // Stacks on mobile AND tablet since this panel already sits inside an
    // outer two-pane row on those breakpoints — splitting again would
    // over-compress the content.
    final stackInternally =
        device == _Device.mobile || device == _Device.tablet;

    final visualization = _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Regional Activity', style: _Text.title),
          const SizedBox(height: 2),
          const Text('Requests by region, last 7 days', style: _Text.caption),
          const SizedBox(height: _Space.lg),
          ..._regions.map(
            (r) => Padding(
              padding: const EdgeInsets.only(bottom: _Space.md),
              child: _RegionBar(name: r.name, ratio: r.ratio, value: r.value),
            ),
          ),
        ],
      ),
    );

    final summary = _Card(
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Infrastructure', style: _Text.title),
          SizedBox(height: _Space.lg),
          _SummaryRow(
            label: 'API latency (p95)',
            value: '184ms',
            isWarning: false,
          ),
          Divider(color: _Palette.borderSubtle, height: _Space.xl),
          _SummaryRow(label: 'Error rate', value: '0.03%', isWarning: false),
          Divider(color: _Palette.borderSubtle, height: _Space.xl),
          _SummaryRow(label: 'Active incidents', value: '1', isWarning: true),
          Divider(color: _Palette.borderSubtle, height: _Space.xl),
          _SummaryRow(label: 'Deploys today', value: '7', isWarning: false),
        ],
      ),
    );

    if (stackInternally) {
      return Column(
        children: [
          visualization,
          const SizedBox(height: _Space.xxl),
          summary,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: visualization),
        const SizedBox(width: _Space.xl),
        Expanded(flex: 2, child: summary),
      ],
    );
  }
}

class _RegionBar extends StatelessWidget {
  final String name;
  final double ratio;
  final String value;
  const _RegionBar({
    required this.name,
    required this.ratio,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: _Text.caption.copyWith(color: _Palette.textPrimary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(value, style: _Text.caption),
          ],
        ),
        const SizedBox(height: _Space.xs),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Container(
                    height: 6,
                    width: constraints.maxWidth,
                    color: _Palette.surfaceElevated,
                  ),
                  Container(
                    height: 6,
                    width: constraints.maxWidth * ratio.clamp(0.0, 1.0),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [_Palette.accentDim, _Palette.accent],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isWarning;
  const _SummaryRow({
    required this.label,
    required this.value,
    required this.isWarning,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
            style: _Text.caption,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: _Space.sm),
        Text(
          value,
          style: _Text.body.copyWith(
            color: isWarning ? _Palette.warning : _Palette.textPrimary,
          ),
        ),
      ],
    );
  }
}

/// ============================================================================
/// 6. INSIGHTS SECTION
/// ============================================================================

class _InsightsSection extends StatelessWidget {
  const _InsightsSection();

  static const _insights = [
    _InsightData(
      Icons.trending_up,
      _Palette.success,
      'Conversion increased 12.4% this week, driven by checkout funnel improvements.',
    ),
    _InsightData(
      Icons.bolt,
      _Palette.accent,
      'API response time improved by 18ms on average across all regions.',
    ),
    _InsightData(
      Icons.warning_amber_rounded,
      _Palette.warning,
      '3 services are approaching their configured resource limits.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Insights', style: _Text.title),
          const SizedBox(height: _Space.lg),
          for (int i = 0; i < _insights.length; i++) ...[
            _InsightRow(data: _insights[i]),
            if (i != _insights.length - 1) const SizedBox(height: _Space.md),
          ],
        ],
      ),
    );
  }
}

class _InsightRow extends StatelessWidget {
  final _InsightData data;
  const _InsightRow({required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 2),
          width: 26,
          height: 26,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: data.color.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(data.icon, size: 14, color: data.color),
        ),
        const SizedBox(width: _Space.md),
        Expanded(
          child: Text(
            data.text,
            style: _Text.caption.copyWith(
              color: _Palette.textPrimary,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
