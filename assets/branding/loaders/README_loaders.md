# Cinexa — Loading Animations

Three on-brand loaders, each in three formats. **For Flutter, use Lottie** — it's vector-sharp at any size, ~3 KB, and the smoothest of the three. GIF is included because you asked, but it's the heaviest and renders at a fixed resolution.

## The three loaders

| Loader | Best for | Vibe |
|--------|----------|------|
| **Orbit** ⭐ | Full-screen / initial load | Film-reel dots circling a play button — matches your logo |
| **Spinner** | Buttons, pull-to-refresh, inline | Classic arc spinner with a play mark |
| **Bars** | Audio/video buffering, small inline | Equalizer bars bouncing |

⭐ = recommended primary.

## Formats included (per loader)

```
loaders/
├── loader_orbit.json      ← Lottie (USE THIS in Flutter)
├── loader_orbit.svg       ← animated SVG (great for web)
├── loader_orbit.gif       ← GIF, 120px, transparent
├── loader_orbit_dark.gif  ← GIF on ink background
├── loader_spinner.json / .svg / .gif
└── loader_bars.svg / .gif
```

---

## Option A — Lottie (recommended)

```yaml
dependencies:
  lottie: ^3.1.2
```

```yaml
flutter:
  assets:
    - assets/branding/loaders/
```

```dart
import 'package:lottie/lottie.dart';

// Full-screen loader
Center(
  child: Lottie.asset(
    'assets/branding/loaders/loader_orbit.json',
    width: 120,
    height: 120,
  ),
);
```

Reusable widget you can drop anywhere:

```dart
class CinexaLoader extends StatelessWidget {
  final double size;
  const CinexaLoader({super.key, this.size = 120});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/branding/loaders/loader_orbit.json',
        width: size,
        height: size,
      ),
    );
  }
}

// usage:  const CinexaLoader();   or   const CinexaLoader(size: 48);
```

---

## Option B — Animated SVG (good for Flutter Web)

`flutter_svg` does **not** animate SMIL, so for in-app Flutter prefer Lottie. The animated SVGs are ideal if any part of your project is plain web (e.g. a landing page) — just drop them in an `<img>`:

```html
<img src="loader_orbit.svg" width="100" alt="Loading…">
```

---

## Option C — GIF (fixed size, heaviest)

```dart
Image.asset('assets/branding/loaders/loader_orbit.gif', width: 120);
```

Use `loader_orbit_dark.gif` if the GIF sits directly on the `#1A1426` background and you want a baked-in backdrop; the plain `loader_orbit.gif` is transparent and works on any color.

---

## Tips

- For an initial app-load screen, pair the loader with the wordmark: stack `CinexaLoader` above an `SvgPicture.asset('logo/primary_light_text.svg')`.
- Keep one loader style throughout the app for consistency — orbit for full-screen, spinner for inline is a clean split if you want two.
- All loaders use the brand gradient `#FF5E62 → #FF9966`, so they sit naturally against both the dark (`#1A1426`) and card (`#241B33`) surfaces.
