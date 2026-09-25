# Flutter Profile Card

A Flutter profile card/profile screen built using core Flutter widgets and a custom visual theme.

## Problem Statement

> Build a Flutter profile card screen using Column, Row, Container, CircleAvatar, Text, and Icon widgets with custom theme colors.

## Project Overview

This project demonstrates a complete profile screen with:

- Custom theme colors and typography
- Profile avatar using `CircleAvatar`
- Profile name, username, role, location, and biography
- Follow/Following interaction
- Message and Share actions
- More Options bottom sheet
- Profile statistics
- About section
- Recent Activity timeline
- Activity detail bottom sheets
- Entrance animation
- Hover and press feedback
- Responsive layout for narrow and wide screens

## Files

### `main.dart`

Contains the application entry point and root `ProfileApp` widget.

Responsibilities:

- Starts the application with `runApp`
- Creates `MaterialApp`
- Disables the debug banner
- Applies the custom `ThemeData`
- Opens `ProfileScreen` as the home screen

### `profile_card.dart`

Contains the main profile implementation.

Responsibilities:

- Defines design tokens
- Stores profile and activity data
- Builds the responsive profile screen
- Handles Follow state
- Handles Message, Share, More Options, and Activity interactions
- Provides animations
- Defines reusable UI components

## Main Flutter Widgets Used

| Widget         | Purpose                                                           |
| -------------- | ----------------------------------------------------------------- |
| `Column`       | Main vertical page structure and stacked content                  |
| `Row`          | Horizontal arrangement of profile and action elements             |
| `Container`    | Borders, backgrounds, separators, avatar ring, and visual styling |
| `CircleAvatar` | Profile avatar with initials                                      |
| `Text`         | Profile information, labels, statistics, and descriptions         |
| `Icon`         | Actions, metadata, activity markers, and navigation               |

## Custom Design System

The project defines three groups of design tokens.

### `AppColors`

The main palette includes:

- `canvas` — page background
- `surface` — sheets and input fills
- `ink` — primary text and main controls
- `inkMuted` — body text
- `stone` — secondary/metadata text
- `hairline` — borders and dividers
- `accent` — oxblood accent
- `accentTint` — avatar background
- `hoverTint` — hover feedback

### `AppSpacing`

A consistent spacing scale is defined from `xs = 4` through `xxxl = 32`.

### `AppText`

Reusable text styles are defined for:

- Hero name
- Role
- Metadata
- Body text
- Section titles
- Statistics
- Detail labels and values
- Navigation labels
- Bottom-sheet titles
- Row labels

## Responsive Layout

`LayoutBuilder` is used to determine the available width.

- At widths of **760 pixels or more**, the identity section and details section are displayed side by side.
- At smaller widths, the sections are stacked vertically.
- The content is constrained to a maximum width to prevent excessive stretching on large screens.
- `SingleChildScrollView` keeps the page usable on smaller displays.

## Interactions

### Follow

The Follow button uses `_isFollowing` to switch between:

- `Follow`
- `Following`

The follower count is also updated.

### Message

The Message button opens a bottom sheet containing:

- A message input field
- A Send button

A SnackBar confirms the action.

### Share

The Share button opens a bottom sheet containing:

- Copy profile link
- Show QR code

### More Options

The More Options button opens:

- Edit profile
- Notifications
- Privacy
- About this app

### Activity

Each activity timeline entry can be tapped to open a detail sheet containing its time, title, and full description.

## Animation

The profile identity section uses:

- `AnimationController`
- `FadeTransition`
- `SlideTransition`
- `CurvedAnimation`

The entrance animation runs for 600 milliseconds.

Reusable press feedback is implemented with `_Pressable`, which combines:

- `MouseRegion`
- `GestureDetector`
- `AnimatedScale`
- `Semantics`

## Key Reusable Widgets

- `_Pressable`
- `_FollowButton`
- `_IconActionButton`
- `_Stat`
- `_SectionHeading`
- `_DetailRow`
- `_TimelineItem`
- `_SheetRow`
- `_SheetHandle`

These components keep the screen modular and reduce repeated UI logic.

## How to Run

1. Create/open the Flutter project.
2. Place `main.dart` in the `lib` directory.
3. Place `profile_card.dart` in the `lib` directory.
4. Make sure Flutter is installed and configured.
5. Run:

```bash
flutter pub get
flutter run
```

## Expected Result

The application opens to a responsive profile screen displaying the profile identity, actions, statistics, About information, and recent activity.

The main interactive elements should respond as follows:

- Follow changes to Following and updates followers.
- Message opens a message composer.
- Share opens share options.
- More opens profile options.
- Activity entries open their detailed descriptions.

## Learning Outcomes

This project provides practice with:

- Flutter widget composition
- `StatelessWidget` and `StatefulWidget`
- `setState`
- Rows and columns
- Containers and decoration
- Custom themes
- Design tokens
- Responsive layouts
- Modal bottom sheets
- Text input
- SnackBar feedback
- Animations
- Reusable widgets
- Semantics and tooltips
- Widget lifecycle management

## Conclusion

The project fulfills the required profile-card problem statement while demonstrating additional Flutter concepts such as responsive design, interaction, animation, custom theming, and reusable components.
