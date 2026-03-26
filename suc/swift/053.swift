import SwiftUI

// MARK: - AppTokens (Atomic Design System)
// This section defines all the design tokens, ensuring atomic correspondence with the Kotlin version.
// All Dp values are directly translated to CGFloat, and sp values to CGFloat for font sizes.

struct AppTokens {
    struct Colors {
        static let primary = Color(red: 30/255, green: 41/255, blue: 59/255)
        static let secondary = Color(red: 14/255, green: 165/255, blue: 233/255)
        static let tertiary = Color(red: 250/255, green: 204/255, blue: 21/255)
        static let background = Color(red: 30/255, green: 41/255, blue: 59/255)
        static let surface = Color(red: 30/255, green: 41/255, blue: 59/255)
        static let surfaceVariant = Color(red: 51/255, green: 65/255, blue: 85/255)
        static let outline = Color(red: 71/255, green: 85/255, blue: 105/255)
        static let success = Color(red: 34/255, green: 197/255, blue: 94/255)
        static let warning = Color(red: 245/255, green: 158/255, blue: 11/255)
        static let error = Color(red: 239/255, green: 68/255, blue: 68/255)
        static let onPrimary = Color(red: 255/255, green: 255/255, blue: 255/255)
        static let onSecondary = Color(red: 255/255, green: 255/255, blue: 255/255)
        static let onTertiary = Color(red: 11/255, green: 18/255, blue: 32/255)
        static let onBackground = Color(red: 226/255, green: 232/255, blue: 240/255)
        static let onSurface = Color(red: 226/255, green: 232/255, blue: 240/255)
    }

    struct TypographyTokens {
        // Using .system font for direct size and weight mapping.
        // Kotlin's sp (scalable pixels) are mapped to SwiftUI's pt (points).
        static let display = Font.system(size: 26, weight: .bold)
        static let headline = Font.system(size: 20, weight: .semibold)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        // Kotlin's Dp values for RoundedCornerShape are mapped to CGFloat for cornerRadius.
        static let small: CGFloat = 4
        static let medium: CGFloat = 8
        static let large: CGFloat = 12
    }

    struct Spacing {
        // Kotlin's Dp values for spacing are mapped to CGFloat.
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 36
    }
    
    // Shadow mapping from Android's elevation to SwiftUI's shadow.
    // Android's elevation is a complex concept that often involves multiple shadows and z-index.
    // For a "Retro Flat" style, a single, well-placed shadow is often sufficient and visually similar.
    // Kotlin's ShadowSpec(elevation: Dp, radius: Dp, dy: Dp, opacity: Float)
    // SwiftUI's shadow(color: Color, radius: CGFloat, x: CGFloat, y: CGFloat)
    // We map Kotlin's `radius` to SwiftUI's `radius`, `dy` to SwiftUI's `y`, and `opacity` directly.
    struct ShadowSpec {
        let radius: CGFloat // Blur radius
        let y: CGFloat      // Vertical offset
        let opacity: Double // Shadow opacity
        
        static let level1 = ShadowSpec(radius: 2, y: 1, opacity: 0.1)
        static let level2 = ShadowSpec(radius: 4, y: 2, opacity: 0.14)
        static let level3 = ShadowSpec(radius: 6, y: 3, opacity: 0.16)
    }
}

// MARK: - Data Model
// Directly translates the Kotlin data class into a Swift struct.
// Conforming to Identifiable is necessary for ForEach in SwiftUI.

struct CodeMarker: Identifiable {
    let id: Int
    let name: String
    let desc: String
}

// MARK: - Custom Views
// Translating Composable functions into SwiftUI Views, maintaining layout and style.

struct CustomTopAppBar: View {
    var title: String
    
    var body: some View {
        // Mimics Android's CenterAlignedTopAppBar
        HStack {
            Spacer()
            Text(title)
                .font(AppTokens.TypographyTokens.display)
                .foregroundColor(AppTokens.Colors.onBackground)
            Spacer()
        }
        .padding(.vertical, AppTokens.Spacing.md) // Vertical padding for the top bar itself
        .background(AppTokens.Colors.background) // Top bar background color
    }
}

struct CodeMarkerCard: View {
    let marker: CodeMarker
    
    var body: some View {
        HStack(spacing: AppTokens.Spacing.md) { // horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
            ZStack { // Box equivalent
                RoundedRectangle(cornerRadius: AppTokens.Shapes.small)
                    .fill(AppTokens.Colors.secondary)
                    .frame(width: 32, height: 32) // size(32.dp)
                Text(String(marker.id))
                    .foregroundColor(AppTokens.Colors.onSecondary)
                    .font(AppTokens.TypographyTokens.label)
            }
            VStack(alignment: .leading) { // Column equivalent
                Text(marker.name)
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.onSurface)
                Text(marker.desc)
                    .font(AppTokens.TypographyTokens.body)
                    .foregroundColor(AppTokens.Colors.onSurface)
            }
        }
        .padding(AppTokens.Spacing.md) // padding(AppTokens.Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading) // fillMaxWidth()
        .background(AppTokens.Colors.surfaceVariant) // CardDefaults.cardColors(containerColor = AppTokens.Colors.surfaceVariant)
        .cornerRadius(AppTokens.Shapes.medium) // shape = AppTokens.Shapes.medium
        // Apply a subtle shadow to mimic Material Design's default card elevation.
        .shadow(color: Color.black.opacity(AppTokens.ShadowSpec.level1.opacity),
                radius: AppTokens.ShadowSpec.level1.radius,
                x: 0,
                y: AppTokens.ShadowSpec.level1.y)
    }
}

// MARK: - RootScreen
// The main content view, equivalent to Kotlin's RootScreen Composable.

struct RootScreen: View {
    let markers = [
        CodeMarker(id: 1, name: "Main.kt", desc: "Entry point for Compose app"),
        CodeMarker(id: 2, name: "Utils.kt", desc: "Helper functions"),
        CodeMarker(id: 3, name: "Theme.kt", desc: "Color & Typography setup"),
        CodeMarker(id: 4, name: "Data.kt", desc: "Repository and model classes")
    ]
    
    var body: some View {
        // GeometryReader is used to get the screen width for proportional sizing,
        // specifically for the button's fillMaxWidth(0.6f).
        GeometryReader { geometry in
            VStack(spacing: 0) { // Mimics Scaffold, managing top bar and scrollable content
                CustomTopAppBar(title: "CodeIDE Terminal")
                
                ScrollView(.vertical, showsIndicators: false) { // LazyColumn equivalent for scrollability
                    VStack(alignment: .leading, spacing: AppTokens.Spacing.lg) { // Column equivalent, verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
                        Text("Project Files")
                            .font(AppTokens.TypographyTokens.headline)
                            .foregroundColor(AppTokens.Colors.onBackground)
                        
                        LazyVStack(spacing: AppTokens.Spacing.sm) { // LazyColumn equivalent for efficient list rendering
                            ForEach(markers) { marker in
                                CodeMarkerCard(marker: marker)
                            }
                        }
                        .padding(.bottom, AppTokens.Spacing.xl) // contentPadding = PaddingValues(bottom = AppTokens.Spacing.xl)
                        
                        Text("Live Terminal")
                            .font(AppTokens.TypographyTokens.headline)
                            .foregroundColor(AppTokens.Colors.onBackground)
                        
                        ZStack(alignment: .topLeading) { // Box equivalent
                            RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                                .fill(AppTokens.Colors.surfaceVariant)
                                .frame(maxWidth: .infinity) // fillMaxWidth()
                                .frame(height: 240) // height(240.dp)
                                .overlay(
                                    // border(1.dp, AppTokens.Colors.outline, AppTokens.Shapes.medium)
                                    RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                                        .stroke(AppTokens.Colors.outline, lineWidth: 1)
                                )
                            Text("> println(\"Hello, Kotlin!\")")
                                .font(AppTokens.TypographyTokens.body)
                                .foregroundColor(AppTokens.Colors.onSurface)
                                .padding(AppTokens.Spacing.md) // padding(AppTokens.Spacing.md)
                        }
                        
                        Button(action: {}) {
                            Text("Run Code")
                                .font(AppTokens.TypographyTokens.title)
                                .foregroundColor(AppTokens.Colors.onSecondary)
                                .frame(maxWidth: .infinity) // Ensures the text fills the button horizontally
                        }
                        // modifier = Modifier.align(Alignment.CenterHorizontally).fillMaxWidth(0.6f).height(48.dp)
                        .frame(width: geometry.size.width * 0.6, height: 48) // fillMaxWidth(0.6f) and height(48.dp)
                        .background(AppTokens.Colors.secondary) // ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.secondary)
                        .cornerRadius(AppTokens.Shapes.large) // shape = AppTokens.Shapes.large
                        // Apply a subtle shadow to the button for a lifted effect.
                        .shadow(color: Color.black.opacity(AppTokens.ShadowSpec.level1.opacity),
                                radius: AppTokens.ShadowSpec.level1.radius,
                                x: 0,
                                y: AppTokens.ShadowSpec.level1.y)
                        .frame(maxWidth: .infinity) // This modifier centers the button horizontally
                    }
                    .padding(AppTokens.Spacing.lg) // modifier = Modifier.padding(AppTokens.Spacing.lg)
                    .frame(maxWidth: .infinity) // Ensure VStack takes full width for proper alignment
                }
                // background(Brush.verticalGradient(...))
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            AppTokens.Colors.primary.opacity(0.8),
                            AppTokens.Colors.surface.opacity(0.9)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            .background(AppTokens.Colors.background) // containerColor = MaterialTheme.colorScheme.background
            // Ensures the app content extends to the edges of the screen, ignoring safe areas.
            .ignoresSafeArea(.all, edges: .all)
        }
    }
}

// MARK: - App Entry Point
// The main application structure for SwiftUI, equivalent to MainActivity.

@main
struct SingleFileUIApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                // Requirement 2: App must be full screen and top status bar hidden.
                // This modifier hides the status bar for the entire window, compatible with iOS 16.0.
                .statusBarHidden(true)
        }
    }
}

// MARK: - Preview Provider
// SwiftUI's equivalent of @Preview Composable for Xcode Canvas.

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}