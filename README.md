# Apple platform development

Apple platform development in Swift and SwiftUI: iOS, macOS, and visionOS apps using SwiftData, Core ML, Image Playground, Foundation Models, and spatial computing.

This repository is development work on Apple platforms. It is not an Apple product, not Apple-affiliated, and not a credential. It is not a Certiport exam and not Apple Teacher.

The public landing page lives in [`docs/`](docs/) for GitHub Pages. Xcode projects live under [`apps/`](apps/).

## Apps

Each name matches a folder under `apps/`.

### iOS

- [MicroAdventures](apps/MicroAdventures) — MapKit + SwiftUI, filters, floating cards
- [WeatherForecast](apps/WeatherForecast) — custom views, structures, properties
- [OnboardingFlow](apps/OnboardingFlow) — TabView onboarding, layout and style
- [DiceRoller](apps/DiceRoller) — buttons and `@State`
- [Pick-a-Pal](apps/Pick-a-Pal) — lists, TextField, bindings
- [FriendsFavoriteMovies](apps/FriendsFavoriteMovies) — SwiftData, navigation, relationships
- [Alphabetizer](apps/Alphabetizer) — `@Observable`, environment sharing
- [ScoreKeeper](apps/ScoreKeeper) — custom types, Swift Testing
- [Birthdays](apps/Birthdays) — SwiftData persistence
- [GratefulMoments](apps/GratefulMoments) — PhotosPicker, SwiftData, accessibility, localization
- [HikingSurvey](apps/HikingSurvey) — Natural Language sentiment, Swift Charts
- [SignDecoder](apps/SignDecoder) — Vision text recognition, Translation
- [TrailAnalyzerApp](apps/TrailAnalyzerApp) — Core ML custom model in SwiftUI
- [GenerableQuiz](apps/GenerableQuiz) — Foundation Models, `@Generable`

### Create ML

- [TrailAnalyzer](apps/TrailAnalyzer) — Create ML training, `.mlmodel` (folder, not an iOS app)

### macOS

- [ImageGenerator](apps/ImageGenerator) — Image Playground, CommandMenu

### visionOS

- [TunnelOfCircles](apps/TunnelOfCircles) — windows, Grid, 3D padding
- [LabelMaker](apps/LabelMaker) — ornaments, multiple WindowGroups
- [SeaCreatures](apps/SeaCreatures) — volumetric windows, RealityKit

## Open and build

1. Install [Xcode](https://developer.apple.com/xcode/).
2. Open the `.xcodeproj` in the app folder you want to run. For Create ML training, see `apps/TrailAnalyzer/`.
3. Choose a Simulator (or a generic destination) and build. `CODE_SIGNING_ALLOWED=NO` is fine. An Apple Developer Program membership is not required.

## License

MIT. See [LICENSE](LICENSE).
