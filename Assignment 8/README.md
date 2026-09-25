# 📡 API Data Fetcher with Local Cache

A Flutter app built for **Assignment 8**. It fetches posts from the free
[JSONPlaceholder](https://jsonplaceholder.typicode.com) REST API, displays
them with `FutureBuilder`, and caches the last successful result locally
with `SharedPreferences` — so the feed still has something to show even
when the device is offline.

---

## ✨ Features

- **Live network fetch** from `GET /posts` on JSONPlaceholder using the
  `http` package.
- **`FutureBuilder`-driven UI** with three explicit states: loading
  (animated shimmer skeleton), error, and data.
- **Local caching with `SharedPreferences`** — every successful response
  is JSON-encoded and saved, along with a timestamp.
- **Automatic offline fallback** — if the network call fails, the app
  transparently loads the last cached result instead of showing a blank
  error screen.
- **Status banner** that tells you, at a glance, whether you're looking
  at *live* data or *cached* data, and when it was last updated.
- **Pull-to-refresh** to force a fresh network fetch at any time.
- **Custom, polished UI** — Google Fonts typography, a soft indigo/teal
  color theme, rounded elevated cards, gradient avatar tiles, and a
  post detail screen.

---

## 🧱 Project structure

```
lib/
├── main.dart                     # App entry point, theme wiring
├── theme/
│   └── app_theme.dart            # Colors, typography, component themes
├── models/
│   └── post.dart                 # Post model (fromJson / toJson)
├── services/
│   ├── api_service.dart          # Talks to JSONPlaceholder over HTTP
│   └── cache_service.dart        # Reads/writes SharedPreferences cache
├── screens/
│   ├── home_screen.dart          # FutureBuilder + cache-fallback logic
│   └── post_detail_screen.dart   # Full post detail view
└── widgets/
    ├── post_card.dart            # List item card
    ├── skeleton_loader.dart      # Shimmer loading placeholder
    └── status_banner.dart        # "Live" vs "Cached" indicator
```

---

## 🔌 API used

**JSONPlaceholder** — a free fake REST API for testing and prototyping.

```
GET https://jsonplaceholder.typicode.com/posts?_limit=20
```

No API key or authentication is required.

---

## 🛠️ How the caching works

1. On launch, `HomeScreen` calls `ApiService.fetchPosts()`.
2. **If the request succeeds:** the result is passed to
   `CacheService.savePosts()`, which JSON-encodes the list of posts and
   writes it to `SharedPreferences` under the key `cached_posts`,
   together with an ISO-8601 timestamp under `cached_posts_timestamp`.
   The UI renders this data and the status banner shows **"Live data
   from the network."**
3. **If the request fails** (no internet, timeout, non-200 response,
   malformed JSON, etc.), `ApiService` throws an `ApiException`. The
   `HomeScreen` catches it and calls
   `CacheService.readCachedPosts()` to load whatever was saved during
   the last successful run. If a cache exists, the UI renders it and
   the status banner switches to **"Offline — showing cached data"**
   along with the timestamp of that cached snapshot.
4. **If there is no cache at all** (e.g. first launch with no
   connectivity), the error is allowed to propagate and the
   `FutureBuilder` shows a retry screen instead.

Pull-to-refresh (and the refresh icon in the app bar) simply reruns this
whole flow, always attempting the network first.

---

## 🚀 Getting started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.3.0 or newer)
- A connected device, emulator, or simulator

### Run it

```bash
# 1. Get dependencies
flutter pub get

# 2. Run on a connected device/emulator
flutter run

# 3. (optional) Build a release APK
flutter build apk --release
```

---

## 📦 Dependencies

| Package              | Purpose                                   |
|-----------------------|--------------------------------------------|
| `http`                | Making the REST API call                  |
| `shared_preferences`  | Persisting the last successful response   |
| `google_fonts`        | Custom typography (Poppins + Inter)       |
| `shimmer`             | Animated skeleton loading effect          |
| `intl`                | Formatting the "last updated" timestamp   |

---

## 🧪 Testing offline behavior

To see the caching in action:

1. Run the app with an active internet connection so a cache gets
   saved.
2. Turn off Wi-Fi / mobile data (or enable airplane mode).
3. Hot-restart the app or pull to refresh.
4. The feed still loads instantly from `SharedPreferences`, and the
   banner switches to the "Offline — showing cached data" state.

---

## 📄 License

Built as a learning project for academic coursework. Free to reuse for
educational purposes.
