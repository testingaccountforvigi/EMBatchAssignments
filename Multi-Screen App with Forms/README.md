# Encore — Event Feedback App

A three-screen Flutter application that collects post-event feedback from attendees. Navigation is handled entirely through **named routes**, and the registration form is validated field by field before anything is submitted.

Built as a course project for the _Event Feedback / Registration Form_ brief.

---

## What it does

An attendee of a fictional two-day conference ("Frequency 26") opens the app, registers with an email and password, rates the session they attended, and reviews a printed-ticket style summary of everything they submitted before it is filed.

| Screen | Route     | Purpose                                                      |
| ------ | --------- | ------------------------------------------------------------ |
| Home   | `/`       | Introduces the event, shows the ticket stub, starts the flow |
| Form   | `/form`   | Registration details + feedback, all validated               |
| Detail | `/detail` | Read-only summary built from the submitted data              |

---

## Features

- Three screens wired with named routes, no direct widget construction in `Navigator.push`
- Route constants in a single file so a typo fails at compile time
- Typed route arguments — the `FeedbackEntry` model is checked in `onGenerateRoute`
- `onUnknownRoute` fallback screen for unregistered route names
- Registration validation: name, email format, password strength, password confirmation
- Required-field enforcement on the session dropdown, the rating and the consent checkbox
- Live password strength meter (5 segments)
- Errors appear only after the first submit, then update on every keystroke
- Keyboard focus moves field to field with the "next" action
- Password is masked on the summary screen, never echoed back
- Unit tests for every validation rule

---

## Design

The interface deliberately avoids stock Material styling.

**Palette — risograph gig-poster inks on lilac paper stock**

| Token       | Hex       | Used for                          |
| ----------- | --------- | --------------------------------- |
| Paper lilac | `#E9E4F5` | Page background                   |
| Card        | `#FCFBFF` | Cards, fields                     |
| Violet ink  | `#201A38` | Primary text                      |
| Ultraviolet | `#4B33C9` | Buttons, focus, selected states   |
| Riso pink   | `#FF5C8A` | Accent mark and every error state |
| Mint        | `#2BB89C` | Success confirmation              |
| Hairline    | `#D5CDEC` | Borders, inactive bars            |

**Typography — rounded throughout**

- `Comfortaa` for headings: the roundest of the geometric display faces, with fully circular bowls
- `Quicksand` for body and labels: soft terminals, generous counters, same geometric skeleton

Both are loaded through the `google_fonts` package, so no font binaries are committed.

**Signature element** — the ticket stub: a rounded card with two punched notches and a dashed tear line. It appears on Home as the event ticket and returns on Detail as the feedback receipt. Every other surface in the app stays plain so the stub is the thing you remember.

---

## Project structure

```
lib/
├── main.dart                     app entry, MaterialApp config
├── app/
│   ├── app_routes.dart           route names, route table, onGenerateRoute
│   └── app_theme.dart            colour + spacing tokens, ThemeData
├── models/
│   └── feedback_entry.dart       immutable submitted response
├── screens/
│   ├── home_screen.dart          screen 1
│   ├── form_screen.dart          screen 2
│   └── detail_screen.dart        screen 3
├── utils/
│   └── validators.dart           pure validation functions
└── widgets/
    └── stub_card.dart            perforated ticket stub
test/
└── validators_test.dart          unit tests for the rules
```

---

## Running it

Requires Flutter 3.10 or newer.

```bash
flutter pub get
flutter run
```

Run the tests:

```bash
flutter test
```

If this is a fresh checkout without platform folders, generate them first:

```bash
flutter create . --project-name encore_feedback
flutter pub get
flutter run
```

> `google_fonts` downloads the two typefaces on first launch and caches them. If the app must run fully offline, download the `.ttf` files, drop them in `assets/fonts/`, declare them in `pubspec.yaml`, and swap the `GoogleFonts.*` calls for `TextStyle(fontFamily: ...)`.

---

## Validation rules

| Field            | Rule                                                               |
| ---------------- | ------------------------------------------------------------------ |
| Full name        | Required, 3–40 characters, letters/spaces/hyphens/apostrophes only |
| Email            | Required, no spaces, must match `name@domain.tld`                  |
| Password         | Required, minimum 8 characters, at least one letter and one number |
| Confirm password | Required, must match the password exactly                          |
| Session attended | Required selection from the dropdown                               |
| Rating           | Required, 1–5                                                      |
| Comments         | Optional; if written, 5–300 characters                             |
| Consent          | Must be ticked                                                     |

---

## How navigation works

`routes` handles the two argument-free screens. `onGenerateRoute` handles `/detail`, which needs a `FeedbackEntry`, so the cast happens once in the router instead of inside the screen. `onUnknownRoute` catches anything else.

```dart
MaterialApp(
  initialRoute: AppRoutes.home,
  routes: AppRoutes.staticRoutes,
  onGenerateRoute: AppRoutes.onGenerateRoute,
  onUnknownRoute: AppRoutes.onUnknownRoute,
);
```

Moving forward with data:

```dart
Navigator.of(context).pushNamed(AppRoutes.detail, arguments: entry);
```

Returning to the start and clearing the stack:

```dart
Navigator.of(context).pushNamedAndRemoveUntil(
  AppRoutes.home,
  (route) => false,
);
```

---

## Possible next steps

- Persist responses with `shared_preferences` or SQLite so the summary survives a restart
- Real authentication against a backend instead of a locally held password
- An organiser dashboard aggregating ratings per session
- Dark theme using the same tokens
- Localisation, starting with Hindi and Marathi
- Widget and integration tests covering the full submit flow

---
