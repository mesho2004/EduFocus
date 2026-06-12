# EduFocus 🚀

EduFocus is a premium, gamified educational mobile application built with Flutter. It helps children learn key subjects (English, Mathematics, Arabic, etc.) through fun, interactive games. It features advanced accessibility, including camera-based eye-tracking navigation and a customizable LEGO character shop system.

---

## Key Features 🌟

### 1. Gamified Learning Path 🎒
- **Subject Selectors**: Engaging grid view featuring different subjects, complete with lesson tracking, total completion ratios, and colorful cards.
- **Unit maps**: Subject content is broken down into structured units.
- **Lesson Paths**: Children navigate lesson nodes in a progression-based map (resembling typical games like Candy Crush or Duolingo).
- **Interactive Mini-Games**:
  - 🎈 **Popper Game**: Popping bubbles with target letters or numbers.
  - 🧩 **Matcher Game**: Interactive word/image matching.
  - 🔢 **Sequence/Ordering Game**: Sequencing numbers or letters correctly.

### 2. LEGO Avatar Customizer & Shop 👑
- Earn coins/stars by completing lessons.
- Customize your character in the Profile tab: select from various hats, hairstyles, heads, shirts, and legs.
- Configurations are cached locally so progress is persisted.

### 3. Advanced Camera-Based Eye Tracking 👁️
- Integrated eye-tracking navigation designed for kids with mobility or accessibility needs.
- Front camera streams real-time frames over WebSockets.
- Receives gaze coordinates overlaying a visual pointer (`GazeOverlay`) to select and interact with items on-screen hands-free.

### 4. Adaptive & Clean Styling 🎨
- Complete dark and light theme options.
- Support for Right-to-Left (RTL) languages (e.g., Arabic layout switches).
- Smooth physics, gradients, and micro-animations to enhance user engagement.

---

## Directory Structure 📂

```
lib/
├── core/
│   ├── bloc/          # App-wide BLoC state management (StarsCubit, CurriculumCubit)
│   ├── caching/       # SharedPreferences caching manager & helpers
│   ├── data/          # App models (SubjectData, UnitData, LessonData, etc.)
│   ├── di/            # Dependency injection registry (GetIt)
│   ├── helpers/       # UI/UX layout and styling helpers
│   ├── network/       # Network API integration and clients (Dio)
│   ├── routes/        # App routing manager (AppRoutes, AppRouter)
│   ├── services/      # Eye tracking & gaze inputs (GazeService, GazeOverlay, GazeWrapper)
│   ├── themes/        # Premium light and dark UI themes
│   └── utils/         # LEGO builder helpers and common utility functions
├── features/
│   ├── auth/          # Authentication & child profile setup features
│   ├── dashboard/     # Parent dashboard panel
│   ├── game_engine/   # Interactive mini-game engines and reward screens
│   ├── lessons/       # Path screens & lesson nodes
│   ├── onboarding/    # Interactive slides tutorial walkthrough
│   ├── profile/       # Profile page & LEGO customization dialog
│   ├── progress/      # Streak count, statistics, and trophies room
│   ├── subjects/      # Subject listing and stats progress cards
│   └── units/         # Unit selection lists
├── widgets/           # Global custom UI widgets (Bottom navigation, etc.)
└── main.dart          # App entrypoint & theme/routing initialization
```

---

## Getting Started ⚙️

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`^3.9.2` or later)
- [Dart SDK](https://dart.dev/get-started)
- Android Studio / Xcode for device emulation or deployment

### Installation
1. Clone this repository:
   ```bash
   git clone https://github.com/mesho2004/EduFocus.git
   ```
2. Navigate to the project directory:
   ```bash
   cd edufocus
   ```
3. Fetch the dependencies:
   ```bash
   flutter pub get
   ```
4. Run the project:
   ```bash
   flutter run
   ```

---

## Eye-Tracking WebSocket Server 🔌
The `GazeService` connects to a WebSocket server to process frames and return coordinate mappings.

1. The service connects to:
   ```
   ws://192.168.1.72:8000/ws/gaze/client1
   ```
   *(Update this URL in [gaze_wrapper.dart](file:///c:/Users/hp/Desktop/edufocus/lib/core/services/gaze_wrapper.dart#L52) to match your local computer IP or server domain).*

2. It initializes the front-facing camera on a low resolution.
3. Every camera image is converted to a JPEG stream, base64 encoded, and sent to the server.
4. The server returns JSON messages with coordinates:
   ```json
   {
     "x": 350.0,
     "y": 620.0,
     "blink": false,
     "confidence": 0.94
   }
   ```
5. If the confidence score is high, a visual pointer will guide user navigation in real-time.

---

## Principal Libraries used 📦
- **flutter_bloc**: Structured state management.
- **audioplayers**: Sound effects for game answers and menus.
- **flutter_tts**: Verbal instructions for spelling and letters.
- **camera**: Streaming camera feed for eye tracking.
- **web_socket_channel**: Bi-directional communication with the gaze tracking server.
- **confetti**: Celebrating child victories and completions.
- **shared_preferences**: Local database storage for user settings.
- **google_fonts**: Visual styles and premium typography.
