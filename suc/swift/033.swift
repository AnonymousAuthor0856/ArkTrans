import SwiftUI

// MARK: - AppTokens
// Translates Kotlin's AppTokens object to Swift structs
struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFF06B6D4)
        static let secondary = Color(hex: 0xFF3B82F6)
        static let tertiary = Color(hex: 0xFF8B5CF6)
        static let background = Color(hex: 0xFFF0F9FF)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFE0F2FE)
        static let outline = Color(hex: 0xFFBAE6FD)
        static let success = Color(hex: 0xFF22C55E)
        static let warning = Color(hex: 0xFFFACC15)
        static let error = Color(hex: 0xFFEF4444)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFFFFFFFF)
        static let onTertiary = Color(hex: 0xFFFFFFFF)
        static let onBackground = Color(hex: 0xFF0F172A)
        static let onSurface = Color(hex: 0xFF0F172A)
    }

    struct TypographyTokens {
        // Kotlin's displayLarge = 28.sp, FontWeight.Bold
        static let display: Font = .system(size: 28, weight: .bold)
        // Kotlin's titleMedium = 18.sp, FontWeight.Medium
        static let title: Font = .system(size: 18, weight: .medium)
        // Kotlin's bodyMedium = 14.sp, FontWeight.Normal
        static let body: Font = .system(size: 14, weight: .regular)
        // Kotlin's labelMedium = 12.sp, FontWeight.Medium
        static let label: Font = .system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let small: CGFloat = 6
        static let medium: CGFloat = 12
        static let large: CGFloat = 20
    }

    struct Spacing {
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 32
    }

    // ShadowSpec mapping from Compose to SwiftUI
    struct ShadowSpec {
        let elevation: CGFloat // Compose's elevation, often contributes to blur/spread
        let radius: CGFloat    // Compose's radius (blur radius)
        let dy: CGFloat        // Compose's dy (y-offset)
        let opacity: Double    // Compose's opacity
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 6, radius: 8, dy: 4, opacity: 0.18)
    }
}

// MARK: - Color Hex Extension
// Helper to create Color from hex integer, similar to Android's Color(0xFF...)
extension Color {
    init(hex: UInt) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: Double((hex >> 24) & 0xFF) / 255.0 == 0.0 ? 1.0 : Double((hex >> 24) & 0xFF) / 255.0 // Handle alpha if present, default to 1.0
        )
    }
}

// MARK: - Custom ProgressViewStyle for LinearProgressIndicator
// SwiftUI's default ProgressView doesn't easily allow setting track color directly for linear style.
// This custom style mimics the LinearProgressIndicator with separate tint and track colors.
struct LinearProgressViewStyle: ProgressViewStyle {
    var tint: Color
    var track: Color

    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in // Use GeometryReader to get the available width
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4) // Track
                    .fill(track)
                    .frame(height: 8)

                RoundedRectangle(cornerRadius: 4) // Progress
                    .fill(tint)
                    .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * geometry.size.width, height: 8)
            }
        }
        .frame(height: 8) // Ensure the style itself takes up the correct height
    }
}

// MARK: - RootScreen View
struct RootScreen: View {
    // Kotlin's mutableFloatStateOf(500f)
    @State private var spending: Float = 500.0
    let goal: Float = 1000.0

    var body: some View {
        // Mimic Scaffold's containerColor and topBar structure
        VStack(spacing: 0) { // Overall container for top bar + content, no spacing between them
            // Top Bar equivalent (CenterAlignedTopAppBar)
            ZStack {
                AppTokens.Colors.background // TopAppBarDefaults.centerAlignedTopAppBarColors(containerColor = AppTokens.Colors.background)
                    .ignoresSafeArea(.all, edges: .top) // Extend background behind status bar

                Text("Bill Calendar") // title = { Text("Bill Calendar", style = MaterialTheme.typography.displayLarge, color = AppTokens.Colors.onSurface) }
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.onSurface)
            }
            .frame(height: 56) // Common height for a top app bar, adjust if needed for exact visual match
            .background(AppTokens.Colors.background) // Redundant but ensures background if ZStack fails

            // Main content area (Column)
            ScrollView {
                VStack(spacing: AppTokens.Spacing.lg) { // verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
                    // Surface Card - 移到最顶部
                    RoundedRectangle(cornerRadius: AppTokens.Shapes.large) // shape = AppTokens.Shapes.large
                        .fill(AppTokens.Colors.surface.opacity(0.9)) // color = AppTokens.Colors.surface.copy(alpha = 0.9f)
                        .shadow(
                            color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity),
                            radius: AppTokens.ElevationMapping.level2.radius, // blur radius
                            x: 0, // No x-offset specified in Kotlin's ShadowSpec, assuming 0
                            y: AppTokens.ElevationMapping.level2.dy // y-offset
                        ) // shadowElevation = AppTokens.ElevationMapping.level2.elevation
                        .frame(maxWidth: .infinity) // modifier = Modifier.fillMaxWidth()
                        .frame(height: 160) // .height(160.dp)
                        .overlay( // Equivalent to content inside Surface
                            VStack(alignment: .leading, spacing: 0) { // modifier = Modifier.fillMaxSize().padding(AppTokens.Spacing.lg), verticalArrangement = Arrangement.SpaceBetween
                                Text("Current Spending")
                                    .font(AppTokens.TypographyTokens.title)
                                    .foregroundColor(AppTokens.Colors.primary)
                                
                                Spacer() // Arrangement.SpaceBetween

                                Text("$\(Int(spending)) / $\(Int(goal))")
                                    .font(AppTokens.TypographyTokens.display)
                                    .foregroundColor(AppTokens.Colors.onSurface)
                                
                                Spacer() // Arrangement.SpaceBetween

                                // LinearProgressIndicator equivalent
                                ProgressView(value: Double(spending), total: Double(goal))
                                    .progressViewStyle(LinearProgressViewStyle(tint: AppTokens.Colors.primary, track: AppTokens.Colors.surfaceVariant))
                                    .frame(maxWidth: .infinity) // modifier = Modifier.fillMaxWidth()
                                    .frame(height: 8) // .height(8.dp)
                            }
                            .padding(AppTokens.Spacing.lg) // .padding(AppTokens.Spacing.lg)
                        )

                    Text("Adjust Spending")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)

                    // Slider
                    Slider(value: $spending, in: 0...2000) {
                        // No label view needed for this UI, so provide an empty closure
                    }
                    // colors = SliderDefaults.colors(thumbColor = AppTokens.Colors.secondary, activeTrackColor = AppTokens.Colors.primary, inactiveTrackColor = AppTokens.Colors.surfaceVariant)
                    // SwiftUI's Slider in iOS 16 doesn't allow separate thumb and track colors easily.
                    // tint affects both active track and thumb.
                    .tint(AppTokens.Colors.primary) // activeTrackColor
                    // For inactiveTrackColor, we apply a background to the slider itself.
                    .background(AppTokens.Colors.surfaceVariant.opacity(0.5)) // Simulate inactive track color
                    .cornerRadius(4) // Give the background a slight corner radius to match track
                    .frame(maxWidth: .infinity) // modifier = Modifier.fillMaxWidth()

                    // Button
                    Button(action: {
                        spending = 0.0
                    }) {
                        Text("Reset")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.onTertiary) // contentColor = AppTokens.Colors.onTertiary
                            .frame(maxWidth: .infinity, maxHeight: .infinity) // Make text fill button for centering
                    }
                    .frame(maxWidth: .infinity) // modifier = Modifier.fillMaxWidth()
                    .frame(height: 48) // .height(48.dp)
                    .background(AppTokens.Colors.tertiary) // containerColor = AppTokens.Colors.tertiary
                    .cornerRadius(AppTokens.Shapes.medium) // shape = AppTokens.Shapes.medium
                }
                .padding(AppTokens.Spacing.lg) // .padding(AppTokens.Spacing.lg) on the Column
            }
            .background(
                LinearGradient( // Brush.verticalGradient
                    gradient: Gradient(colors: [
                        AppTokens.Colors.secondary.opacity(0.3), // AppTokens.Colors.secondary.copy(alpha = 0.3f)
                        AppTokens.Colors.background,
                        AppTokens.Colors.primary.opacity(0.2) // AppTokens.Colors.primary.copy(alpha = 0.2f)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .background(AppTokens.Colors.background) // Scaffold containerColor
        .ignoresSafeArea(.all, edges: .bottom) // Ensure the background gradient fills to the very bottom, but not top as top bar handles it.
    }
}

// MARK: - App Entry Point
@main
struct BillCalendarApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                .statusBarHidden(true) // Hide status bar for this specific view
                // .ignoresSafeArea(.all, edges: .all) is handled by individual ZStack/VStack components
                // to ensure specific backgrounds extend correctly while respecting layout.
        }
    }
}