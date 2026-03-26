import SwiftUI
import CoreGraphics

// MARK: - AppTokens
// This struct holds all the design tokens (colors, typography, shapes, spacing, elevation)
// to ensure atomic correspondence with the Android Compose version.
struct AppTokens {
    struct Colors {
        // Defined using hex values for precise color matching.
        static let primary = Color(hex: 0xFF8B5CF6)
        static let secondary = Color(hex: 0xFFD946EF)
        static let tertiary = Color(hex: 0xFF3B82F6)
        static let background = Color(hex: 0xFFF9F5FF)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFF1E9FE)
        static let outline = Color(hex: 0xFFE3D7FE)
        static let success = Color(hex: 0xFF22C55E)
        static let warning = Color(hex: 0xFFFACC15)
        static let error = Color(hex: 0xFFEF4444)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFFFFFFFF)
        static let onTertiary = Color(hex: 0xFFFFFFFF)
        static let onBackground = Color(hex: 0xFF1E1E1E)
        static let onSurface = Color(hex: 0xFF1E1E1E)
    }

    struct TypographyTokens {
        // Font styles mapped to SwiftUI's Font.system with specific size and weight.
        static let display = Font.system(size: 48, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) // FontWeight.Normal maps to .regular
        static let label = Font.system(size: 42, weight: .medium)
    }

    struct Shapes {
        // Rounded corner shapes defined by their corner radius.
        static let small = RoundedRectangle(cornerRadius: 8)
        static let medium = RoundedRectangle(cornerRadius: 14)
        static let large = RoundedRectangle(cornerRadius: 22)
    }

    struct Spacing {
        // Standard spacing values, directly mapped from Dp to CGFloat.
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 32
    }

    // Shadow specification to mimic Compose's elevation system.
    struct ShadowSpec {
        let elevation: CGFloat // Corresponds to SwiftUI's shadow radius (blur amount)
        let dy: CGFloat        // Corresponds to SwiftUI's shadow y-offset
        let opacity: Double    // Corresponds to SwiftUI's shadow color alpha
    }

    struct ElevationMapping {
        // Shadow levels with specific properties.
        // Kotlin's 'elevation' is mapped to SwiftUI's 'radius' (blur).
        // Kotlin's 'dy' is mapped to SwiftUI's 'y' offset.
        static let level1 = ShadowSpec(elevation: 4, dy: 2, opacity: 0.14)
        static let level2 = ShadowSpec(elevation: 8, dy: 6, opacity: 0.18)
    }
}

// MARK: - Color Extension for Hex Initialization
extension Color {
    // Initializes a Color from a 0xRRGGBB hex integer.
    // Assumes full opacity (alpha = 1.0) as per Kotlin's Color(0xFFRRGGBB) convention.
    init(hex: UInt) {
        self.init(
            red: Double((hex & 0xFF0000) >> 16) / 255.0,
            green: Double((hex & 0x00FF00) >> 8) / 255.0,
            blue: Double(hex & 0x0000FF) / 255.0
        )
    }
}

// MARK: - RootScreen View
// This view translates the main UI content from the Kotlin Composable.
struct RootScreen: View {
    // State variables to manage UI interactions, equivalent to Compose's `remember { mutableStateOf(...) }`.
    @State private var fontSize: CGFloat = 23.0
    @State private var syncProgress: CGFloat = 0.3

    var body: some View {
        // NavigationView is used to provide a navigation bar (TopAppBar equivalent)
        // and allows for title customization.
        NavigationView {
            // VStack acts as the main Column for vertical arrangement of UI elements.
            VStack(spacing: AppTokens.Spacing.xl) {
                // Surface equivalent for the sample subtitle line display.
                Text("Sample Subtitle Line")
                    .font(.system(size: fontSize)) // Dynamic font size from state
                    .foregroundColor(AppTokens.Colors.onSurface)
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // Equivalent to Modifier.fillMaxSize() within a fixed height container
                    .background(AppTokens.Colors.surface)
                    .clipShape(AppTokens.Shapes.large) // Apply rounded corners
                    .shadow(
                        color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity),
                        radius: AppTokens.ElevationMapping.level2.elevation, // Blur radius
                        x: 0,
                        y: AppTokens.ElevationMapping.level2.dy // Y-offset for the shadow
                    )
                    .frame(height: 200) // Fixed height as in Compose
                    .frame(maxWidth: .infinity) // Ensure it fills the width

                Text("Font Size: \(Int(fontSize))sp")
                    .font(AppTokens.TypographyTokens.body)
                    .foregroundColor(AppTokens.Colors.onSurface)

                // Slider for font size adjustment.
                Slider(value: $fontSize, in: 16...48) {
                    // No label content needed for visual consistency with the Android version.
                }
                .tint(AppTokens.Colors.primary) // Sets the active track color.
                .frame(maxWidth: .infinity)
                // Note: Direct customization of the Slider's thumb and inactive track color
                // in SwiftUI for iOS 16.0 is not straightforward without using UIViewRepresentable
                // or custom drawing. The active track color is set via `.tint()`, while the
                // inactive track and thumb will typically use system defaults.

                Text("Sync Progress")
                    .font(AppTokens.TypographyTokens.body)
                    .foregroundColor(AppTokens.Colors.onSurface)

                // LinearProgressIndicator equivalent.
                ProgressView(value: syncProgress)
                    .progressViewStyle(LinearProgressViewStyle()) // Applies a linear style
                    .tint(AppTokens.Colors.primary) // Color of the progress bar itself
                    .background(AppTokens.Colors.surfaceVariant) // Color of the track behind the progress bar
                    .frame(height: 6) // Fixed height
                    .frame(maxWidth: .infinity) // Fill width

                // Row equivalent for the two buttons.
                HStack(spacing: AppTokens.Spacing.md) {
                    // "Sync +" Button
                    Button(action: {
                        syncProgress = min(syncProgress + 0.1,1.0) // Increment progress, clamp at 1.0
                    }) {
                        Text("Sync +")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .frame(maxWidth: .infinity, maxHeight: .infinity) // Fill button's content area
                    }
                    .frame(height: 48) // Fixed height
                    .background(AppTokens.Colors.primary) // Button background color
                    .clipShape(AppTokens.Shapes.medium) // Apply rounded corners

                    // "Sync -" Button
                    Button(action: {
                        syncProgress = min(syncProgress - 0.1,0.0) // Decrement progress, clamp at 0.0
                    }) {
                        Text("Sync -")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.onSecondary)
                            .frame(maxWidth: .infinity, maxHeight: .infinity) // Fill button's content area
                    }
                    .frame(height: 48) // Fixed height
                    .background(AppTokens.Colors.secondary) // Button background color
                    .clipShape(AppTokens.Shapes.medium) // Apply rounded corners
                }
                .frame(maxWidth: .infinity) // Ensure HStack fills available width, distributing space to buttons
            }
            .padding(AppTokens.Spacing.lg) // Outer padding for the entire content VStack
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Make content VStack fill remaining space
            .background(
                // Linear gradient background for the main content area.
                LinearGradient(
                    colors: [
                        AppTokens.Colors.surfaceVariant,
                        AppTokens.Colors.background,
                        AppTokens.Colors.surface
                    ],
                    startPoint: .top, // Gradient from top
                    endPoint: .bottom // to bottom
                )
            )
            // Navigation bar (TopAppBar) configuration.
            .navigationTitle("Subtitle Editor") // Title text
            .navigationBarTitleDisplayMode(.inline) // Centers the title
            .toolbarBackground(AppTokens.Colors.background, for: .navigationBar) // Sets the background color of the navigation bar
            .toolbarBackground(.visible, for: .navigationBar) // Ensures the custom background is visible
            .padding(.bottom, 50)
        }
        .navigationViewStyle(.stack) // Prevents split view on iPad, ensuring full-screen behavior.
        .ignoresSafeArea(.all) // Makes the app content extend to the edges of the screen, ignoring safe areas.
        .statusBarHidden(true) // Hides the top status bar (time, battery, etc.) for a full-screen experience.

    }
}

// MARK: - Main App Entry Point
// This is the entry point for the SwiftUI application.
@main
struct SubtitleEditorApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen() // Presents the RootScreen as the initial view.
        }
    }
}
