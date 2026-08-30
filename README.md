# Apple Swift development

Apple platform development in Swift and SwiftUI across iOS, macOS, and visionOS.

Work here uses SwiftData, Core ML, Image Playground, Foundation Models, and spatial computing on visionOS.

This is development work on Apple platforms. It is not an Apple credential, not a Certiport exam, and not Apple Teacher.

Xcode projects live under `apps/`. The public site is in `docs/`.

## Apps

### iOS

- **MicroAdventures** — MapKit explorer for nearby outdoor micro-adventures, filtered by category and effort.
- **WeatherForecast** — Simple SwiftUI forecast row with sun/rain day tiles and high/low temperatures.
- **OnboardingFlow** — Multi-page welcome and feature-card onboarding flow.
- **DiceRoller** — Interactive dice roller with per-die views.
- **Pick-a-Pal** — Name list with a random pal picker.
- **FriendsFavoriteMovies** — SwiftData app that tracks friends and their favorite movies.
- **Alphabetizer** — Drag-and-drop tile game that puts words in alphabetical order.
- **ScoreKeeper** — Multiplayer scoreboard with game settings and Swift Testing coverage.
- **Birthdays** — SwiftData birthday list for friends.
- **GratefulMoments** — Gratitude journal with streaks and achievement badges.
- **HikingSurvey** — Hiking comment survey scored with Natural Language sentiment.
- **SignDecoder** — Vision text recognition on trail-sign photos, with translation.
- **TrailAnalyzerApp** — Core ML trail-risk predictions from distance, elevation, terrain, and hazards.
- **GenerableQuiz** — On-device quiz generation with Foundation Models.

### Create ML

- **TrailAnalyzer** — Create ML training data, `train.swift`, and Core ML models for trail-risk regression (not an iOS app).

### macOS

- **ImageGenerator** — Image Playground app that composes recipe and ingredient concepts into generated images.

### visionOS

- **TunnelOfCircles** — Spatial tunnel of 3D-padded circles with depth and color controls.
- **LabelMaker** — Ornament-driven label editor that opens additional windows for created labels.
- **SeaCreatures** — RealityKit volumetric windows for 3D sea-creature models.

## Open and build

1. Install [Xcode](https://developer.apple.com/xcode/).
2. Open the `.xcodeproj` in the app folder you want to run. For Create ML training, see `apps/TrailAnalyzer/` (`train.swift` plus CSV and `.mlmodel` files).
3. Choose a Simulator (or a generic destination) and build. `CODE_SIGNING_ALLOWED=NO` is fine. An Apple Developer Program membership is not required.

## License

MIT. See [LICENSE](LICENSE).
