# Nomad Travel iOS ✈️

> A high-performance, fluid iOS application built for digital nomads with **Airbnb-grade 120Hz animation polish**, physics-driven gestures, location intelligence, and biometric security.

---

## ✨ Features

- **⚡ 120Hz ProMotion Motion System**: Velocity-preserving spring physics (`NomadSprings`) for card expansions, interactive gesture dismissals, and glassmorphic tab transitions.
- **📍 Location Intelligence & Geocoding**: CoreLocation engine with automatic city reverse-geocoding, distance matrix calculations, and timezone offset detection.
- **🔒 Security & Biometric Quick Unlock**: Face ID / Touch ID authentication via `LocalAuthentication` framework, compatible with free Apple Developer Accounts.
- **🏡 Stays & Co-Living Market**: Interactive MapKit split-screen explorer, high-speed wifi badges (`>250 Mbps`), monthly discount rates, and superhost tags.
- **📶 Live Wifi Speed Meter**: Real-time crowd-sourced latency and speed test simulator built directly into listing details.
- **🎛️ Custom Glass Tab Bar**: Floating frosted glass navigation bar with haptic sensory feedback.

---

## 🛠️ Architecture & Tech Stack

```
NomadTravel/
├── Sources/
│   └── NomadTravel/
│       ├── App/
│       │   ├── NomadTravelApp.swift      # Swift 6 App Entry Point
│       │   └── AppState.swift            # Observable Global Navigation & Filter State
│       ├── DesignSystem/
│       │   ├── Springs.swift             # Physics-based spring tokens (0-jank 120 FPS)
│       │   ├── Colors.swift              # Dark mode glassmorphic color palette
│       │   ├── GlassmorphicCard.swift    # Native ultraThinMaterial frosted glass
│       │   └── Haptics.swift             # Tactile sensory feedback generator
│       ├── Core/
│       │   ├── Auth/
│       │   │   └── AuthManager.swift     # Face ID / Touch ID, Email, & Google OAuth engine
│       │   └── Location/
│       │       └── LocationManager.swift # CoreLocation manager & distance matrix
│       ├── Models/
│       │   ├── Stay.swift                # Co-living listing model & mock data
│       │   ├── NomadSpot.swift           # Work-friendly cafe / co-working model
│       │   └── UserNomadProfile.swift    # Digital nomad profile schema
│       └── Features/
│           ├── Auth/Views/LoginView.swift   # Glassmorphic login screen
│           ├── Radar/Views/NomadRadarView.swift # Live proximity radar view
│           ├── Visa/Views/VisaTrackerView.swift # Schengen 90/180 visa counter
│           ├── Profile/Views/ProfileView.swift  # Nomad ID & settings view
│           └── Stays/Views/
│               ├── StaysMainView.swift  # MapKit Explorer + Sheet + Glass Tab Bar
│               ├── StayCardView.swift   # High-speed wifi stay card component
│               └── StayDetailView.swift # Interactive swipe-to-dismiss detail view
```


---

## 🚀 Getting Started

### Requirements
- **macOS**: 14.0 or later
- **Xcode**: 15.0 or later (Tested on Xcode 26.6 / Swift 6.3)
- **Target OS**: iOS 17.0+

### Building & Running

1. **Clone the repository**:
   ```bash
   git clone <your-repo-url>
   cd nomad-travel
   ```

2. **Open in Xcode**:
   ```bash
   open Package.swift
   # Or open Xcode > File > Open > select the nomad-travel folder
   ```

3. **Build via Command Line**:
   ```bash
   swift build
   ```

---

## 🎨 Motion Physics Tokens

```swift
NomadSprings.fluidSpring          // response: 0.38, dampingFraction: 0.82
NomadSprings.snappySpring         // response: 0.26, dampingFraction: 0.72
NomadSprings.sharedElementSpring  // stiffness: 300, damping: 24
```

---

## 📄 License

MIT License. Built for digital nomads worldwide. 🌍
