# Responsive Multi-Section Flutter Dashboard

A premium, responsive **Product Intelligence / Operations Dashboard** built with Flutter and Dart.

## Overview

This project demonstrates how Flutter can be used to build a polished dashboard that adapts across mobile, tablet, desktop, and wide desktop screen sizes.

The implementation intentionally demonstrates:

- `ListView`
- `GridView`
- `MediaQuery`
- `Flexible`
- `Expanded`
- Responsive breakpoints
- Reusable private widgets
- Custom chart rendering with `CustomPainter`
- Material 3
- Overflow-aware layouts

## Project Structure

```text
lib/
├── main.dart
└── dashboard.dart
```

### `main.dart`

The application entry point. It creates the `ProductIntelligenceApp` and opens `DashboardScreen`.

### `dashboard.dart`

Contains the complete dashboard implementation, including:

- Design tokens
- Responsive breakpoint logic
- Data models
- Dashboard screen
- KPI grid
- Analytics section
- Custom trend chart
- Recent activity
- Regional activity
- Infrastructure summary
- Insights
- Reusable UI components

## Features

### Responsive Header

The header adapts between compact mobile and larger desktop layouts. Mobile controls can scroll horizontally when required.

### KPI Grid

The KPI section contains:

- Total Revenue
- Active Users
- Conversion Rate
- System Health

The number of columns changes according to available screen width.

### Analytics

The Performance Trend section provides selectable metrics and timeframes and renders a custom trend chart without a chart package.

### Recent Activity

A realistic activity feed demonstrates operational events such as deployments, payments, registrations, alerts, and reports.

### Regional Activity

Regional request distribution is represented using responsive progress bars.

### Infrastructure

Infrastructure values include API latency, error rate, active incidents, and deployments.

### Insights

The dashboard presents concise operational insights with semantic status indicators.

## Responsive Breakpoints

The dashboard uses these device categories:

| Device  |               Width |
| ------- | ------------------: |
| Mobile  |           `< 600px` |
| Tablet  |  `600px – < 1024px` |
| Desktop | `1024px – < 1440px` |
| Wide    |         `>= 1440px` |

The layout does more than resize text. Sections change between stacked and side-by-side arrangements.

## Flutter Widgets Demonstrated

### ListView

The main dashboard uses a vertical `ListView` as the primary scrolling surface.

The activity section uses a shrink-wrapped `ListView.separated` with non-scrollable physics so it can exist safely inside the parent scroll view.

### GridView

`GridView.builder` generates the KPI cards. Its column count and aspect ratio respond to screen size.

### MediaQuery

`MediaQuery.of(context).size.width` provides the current width and is used for responsive layout decisions.

### Expanded

`Expanded` is used to distribute available horizontal space in two-pane layouts and to allow row content to occupy remaining space.

### Flexible

`Flexible` allows text to shrink or truncate instead of causing horizontal overflow.

## Running the Project

1. Create a Flutter project.
2. Place `main.dart` and `dashboard.dart` inside the `lib/` directory.
3. Make sure the files are imported correctly.
4. Run:

```bash
flutter pub get
flutter run
```

No additional packages are required for the dashboard implementation.

## Recommended Testing Sizes

Test the application at:

- 360px mobile
- 390px mobile
- 430px mobile
- 768px tablet
- 1024px desktop
- 1280px desktop
- 1440px wide desktop
- 1920px wide desktop

The main goal is to verify that no RenderFlex or horizontal overflow occurs and that the layout remains readable.

## Design System

The dashboard uses centralized private design tokens for:

- Colors
- Spacing
- Corner radii
- Typography

This keeps the interface consistent and makes future design changes easier.

## Technical Highlights

- Material 3
- Dark visual system
- Responsive breakpoint classification
- Constraint-aware layout
- Reusable widgets
- `CustomPainter` chart
- Interactive metric/timeframe selectors
- Semantic labeling for the notification action
- No backend or external state-management dependency

## Learning Outcomes

This project provides practical experience with:

1. Responsive Flutter UI design.
2. Constraint-based layout.
3. Grid-based dashboard composition.
4. Scrollable page architecture.
5. Flexible and expanded layouts.
6. Custom drawing with `CustomPainter`.
7. Reusable widget composition.
8. UI consistency through design tokens.
9. Testing interfaces across multiple screen widths.
10. Preventing common Flutter overflow and nested-scroll problems.
