
import SwiftUI
import UIKit // Required for UIAppearance customizations

// MARK: - Color Extension for Hex Initialization
// Provides a convenient way to initialize SwiftUI Colors from hex values,
// mirroring the Android Color(0xFFRRGGBB) syntax.
extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB, // Use sRGB color space
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }
}

// MARK: - AppTokens
// Centralized definitions for colors, typography, shapes, and spacing,
// mirroring the Kotlin AppTokens object for easy modification and consistency.
struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFF00FF66)
        static let secondary = Color(hex: 0xFFCCCCCC)
        static let tertiary = Color(hex: 0xFF999999)
        static let background = Color(hex: 0xFF000000)
        static let surface = Color(hex: 0xFF0A0A0A)
        static let surfaceVariant = Color(hex: 0xFF141414)
        static let outline = Color(hex: 0xFF2A2A2A)
        static let success = Color(hex: 0xFF22C55E)
        static let warning = Color(hex: 0xFFF59E0B)
        static let error = Color(hex: 0xFFEF4444)
        static let onPrimary = Color(hex: 0xFF000000)
        static let onSecondary = Color(hex: 0xFFFFFFFF)
        static let onTertiary = Color(hex: 0xFFFFFFFF)
        static let onBackground = Color(hex: 0xFFE0E0E0)
        static let onSurface = Color(hex: 0xFFE0E0E0)
    }

    struct TypographyTokens {
        // Mapping Kotlin's TextStyle to SwiftUI's Font.
        // fontSize (sp) maps directly to SwiftUI's point size.
        // FontWeight.Bold -> .bold, FontWeight.Medium -> .medium, FontWeight.Normal -> .regular
        static let display = Font.system(size: 26, weight: .bold)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 13, weight: .regular)
        static let label = Font.system(size: 11, weight: .medium)
    }

    struct Shapes {
        // RoundedCornerShape(X.dp) maps to CGFloat cornerRadius values.
        static let small: CGFloat = 6
        static let medium: CGFloat = 10
        static let large: CGFloat = 14
    }

    struct Spacing {
        // Dp values map directly to CGFloat for consistent spacing.
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 32
    }
    // ShadowSpec and ElevationMapping are defined in Kotlin but not used in the UI,
    // so they are omitted here for brevity.
}

// MARK: - MixerSlider Component
// Reusable component for the individual audio mixer sliders.
struct MixerSlider: View {
    let label: String
    @Binding var value: Float // Use @Binding to allow external modification of the slider value

    var body: some View {
        VStack(alignment: .leading, spacing: AppTokens.Spacing.xs) {
            Text("\(label) \(Int(value * 100))%")
                .font(AppTokens.TypographyTokens.body)
                .foregroundColor(AppTokens.Colors.onSurface)
            Slider(value: $value, in: 0...1)
                .frame(maxWidth: .infinity) // Equivalent to Modifier.fillMaxWidth()
                // Slider colors (thumb, active/inactive track) are customized globally
                // using UIAppearance in the App struct's init() to ensure atomic correspondence.
        }
    }
}

// MARK: - RootScreen
// The main UI screen, equivalent to the Composable RootScreen in Kotlin.
struct RootScreen: View {
    // @State variables to hold the mutable slider values, mirroring Kotlin's remember { mutableFloatStateOf(...) }
    @State private var bass: Float = 0.4
    @State private var mid: Float = 0.5
    @State private var treble: Float = 0.6
    @State private var master: Float = 0.7

    var body: some View {
        ZStack { // Use ZStack to layer the background behind the content.
            // Full screen background color, ignoring safe areas to extend to screen edges.
            AppTokens.Colors.background.ignoresSafeArea(.all)

            VStack(spacing: 0) { // Main content stack, no spacing between top bar and content.
                // Top Bar equivalent: Simulates CenterAlignedTopAppBar.
                // Material 3 CenterAlignedTopAppBar typically has a height of 64.dp.
                // The title text (26pt) is vertically centered within this fixed height.
                Text("Audio Mixer Terminal")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.primary)
                    .frame(maxWidth: .infinity) // Center aligned horizontally
                    .padding(.vertical, (64 - 26) / 2) // Calculate vertical padding to center 26pt text in 64pt height
                    .frame(height: 64) // Fixed height for the top bar
                    .background(AppTokens.Colors.background) // Ensure top bar background is black

                // Content area: Contains sliders, progress bar, and button.
                VStack(spacing: AppTokens.Spacing.lg) { // Spacing between elements in this column.
                    MixerSlider(label: "Bass", value: $bass)
                    MixerSlider(label: "Mid", value: $mid)
                    MixerSlider(label: "Treble", value: $treble)

                    // Spacer equivalent to Modifier.height(AppTokens.Spacing.lg)
                    Spacer().frame(height: AppTokens.Spacing.lg)

                    // LinearProgressIndicator equivalent
                    ProgressView(value: master)
                        .tint(AppTokens.Colors.primary) // Sets the active track color
                        .frame(maxWidth: .infinity) // Equivalent to Modifier.fillMaxWidth()
                        .frame(height: 6) // Fixed height 6.dp

                    Text("Master Volume \(Int(master * 100))%")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)
                        .frame(maxWidth: .infinity, alignment: .leading) // Aligned to start

                    // Master volume Slider
                    Slider(value: $master, in: 0...1)
                        .frame(maxWidth: .infinity) // Equivalent to Modifier.fillMaxWidth()
                        // Slider colors customized globally via UIAppearance.

                    // Apply Settings Button
                    Button(action: {}) {
                        Text("Apply Settings")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .frame(maxWidth: .infinity) // Text fills button width
                            .padding(.vertical, (48 - 16) / 2) // Vertically center 16pt text in 48pt height
                    }
                    .background(AppTokens.Colors.primary) // Button background color
                    .cornerRadius(AppTokens.Shapes.medium) // Rounded corners (10.dp)
                    .frame(height: 48) // Fixed button height 48.dp
                }
                .padding(AppTokens.Spacing.lg) // Outer padding for the content column (16.dp on all sides)
                .frame(maxWidth: .infinity, maxHeight: .infinity) // Make content column fill remaining space
                .background(AppTokens.Colors.background) // Ensure content background is black
            }
        }
        .statusBarHidden(true) // Hides the top status bar, as required.
    }
}

// MARK: - App Entry Point
// The main application struct, conforming to the App protocol.
// This is the entry point for a SwiftUI application.
@main
struct AudioMixerApp: App {
    // Initialize UIAppearance for UIKit controls (UISlider, UIProgressView)
    // to match the atomic color requirements from the Android version.
    // These changes apply globally to all instances of these UIKit controls
    // used within the SwiftUI hierarchy.
    init() {
        // Customize UISlider appearance
        UISlider.appearance().minimumTrackTintColor = UIColor(AppTokens.Colors.primary) // Active track color
        UISlider.appearance().maximumTrackTintColor = UIColor(AppTokens.Colors.surfaceVariant) // Inactive track color
        UISlider.appearance().thumbTintColor = UIColor(AppTokens.Colors.primary) // Thumb color

        // Customize UIProgressView appearance
        UIProgressView.appearance().progressTintColor = UIColor(AppTokens.Colors.primary) // Filled progress color
        UIProgressView.appearance().trackTintColor = UIColor(AppTokens.Colors.surfaceVariant) // Unfilled track color
    }

    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}

// MARK: - Preview Provider
// Provides a preview of the RootScreen in Xcode's canvas.
struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}

