# Medyczna Marihuana PL

An informational reference app for medical marijuana patients in Poland. This app provides educational content about legally available medical cannabis strains, terpene profiles, and regulatory information.

**This app does NOT sell, facilitate the sale of, or promote the purchase of any controlled substance. It is strictly an educational reference tool.**

## Features

- Strain Database: 21 strains from 10 producers currently available on the Polish market
- Terpene Profiles: Detailed terpene information with therapeutic effects
- Medical Indications: Common medical uses as referenced in Polish patient literature  
- Educational Content: Legal framework, prescription process, and administration guidance
- Search and Filter: Filter by strain type (Sativa/Indica/Hybrid) and producer
- Age Gate: 18+ verification screen

## Data Sources

All strain data is sourced from publicly available Polish medical cannabis resources including medweed.pl, cannabis-spot.pl, budcare.pl, and official producer information. Data reflects the Polish market as of February 2025.

## Tech Stack

- Flutter (Dart)
- Provider for state management
- Google Fonts (Plus Jakarta Sans)
- Local JSON data (no backend required)

## Getting Started

### Run in Browser (Recommended)

Open this project in Zapp.run - no local setup needed.

### Run Locally

```
flutter pub get
flutter run
```

### Build APK

```
flutter build apk --release
```

## Project Structure

```
lib/
  main.dart                    - All screens and widgets
  models/
    strain.dart                - Data models (Strain, Terpene, Educational)
  providers/
    strain_provider.dart       - State management
assets/
  data.json                    - Strain database and educational content
```

## Disclaimer

This application is not a medical device and does not diagnose, treat, cure, or prevent any medical condition. Always consult your physician before starting or changing any treatment. Information provided is for educational purposes only.

## License

MIT
