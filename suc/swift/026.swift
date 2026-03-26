import SwiftUI

// MARK: - Color Extension for Hex Initialization
extension Color {
    /// Initializes a Color from a 32-bit hexadecimal integer (0xAARRGGBB or 0xRRGGBB).
    /// If the alpha component is not explicitly provided (i.e., hex value is < 0x1000000),
    /// it defaults to a fully opaque color (alpha = 1.0).
    init(hex: UInt) {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0x00FF00) >> 8) / 255.0
        let blue = Double(hex & 0x0000FF) / 255.0
        let alpha = Double((hex & 0xFF000000) >> 24) / 255.0

        // If the hex value is in 0xRRGGBB format (no explicit alpha), set alpha to 1.0
        // Otherwise, use the extracted alpha.
        self.init(red: red, green: green, blue: blue, opacity: (hex & 0xFF000000) == 0 ? 1.0 : alpha)
    }
}

// MARK: - AppTokens
struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFF38BDF8)
        static let secondary = Color(hex: 0xFFA78BFA)
        static let tertiary = Color(hex: 0xFF7DD3FC)
        static let background = Color(hex: 0xFFF1F5F9)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFE2E8F0)
        static let outline = Color(hex: 0xFFCBD5E1)
        static let success = Color(hex: 0xFF22C55E)
        static let warning = Color(hex: 0xFFF59E0B)
        static let error = Color(hex: 0xFFEF4444)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFF1E1E1E)
        static let onTertiary = Color(hex: 0xFF1E1E1E)
        static let onBackground = Color(hex: 0xFF1E1E1E)
        static let onSurface = Color(hex: 0xFF1E1E1E)
    }

    struct TypographyTokens {
        static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) // FontWeight.Normal maps to .regular
        static let label = Font.system(size: 12, weight: .medium)
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

    struct ShadowSpec {
        let elevation: CGFloat // Conceptual elevation, often influences radius and dy
        let radius: CGFloat    // Blur radius of the shadow
        let dy: CGFloat        // Vertical offset of the shadow
        let opacity: Double    // Opacity of the shadow color
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 6, radius: 8, dy: 4, opacity: 0.18)
    }
}

// MARK: - RootScreen
struct RootScreen: View {
    // Equivalent to `var scrollOffset by remember { mutableStateOf(Offset(0f, 0f)) }`
    @State private var scrollOffset: CGSize = .zero

    var body: some View {
        // Equivalent to Scaffold's main content layout, with containerColor as background
        VStack(spacing: 0) {
            // Equivalent to CenterAlignedTopAppBar
            Text("Glass Doc Reader")
                .font(AppTokens.TypographyTokens.display)
                .foregroundColor(AppTokens.Colors.onSurface)
                .padding(.top, 20)
                .padding(.vertical, AppTokens.Spacing.lg) // Provides vertical spacing for the title
                .frame(maxWidth: .infinity) // Centers the text horizontally
                .background(AppTokens.Colors.background) // Top bar background color

            // Main content area, equivalent to Compose's Box
            ZStack(alignment: .center) { // contentAlignment = Alignment.Center
                // Background gradient for the Box
                LinearGradient(
                    gradient: Gradient(colors: [
                        AppTokens.Colors.surfaceVariant.opacity(0.8),
                        AppTokens.Colors.background,
                        AppTokens.Colors.surfaceVariant.opacity(0.8)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity) // Fills the available space below the top bar
                
                // Equivalent to Compose's Surface
                VStack(alignment: .leading, spacing: AppTokens.Spacing.md) { // Equivalent to Compose's Column
                    Text("Document Reader")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.primary)

                    ForEach(0..<8) { index in
                        Text("This is a sample line of text content number \(index + 1).")
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(AppTokens.Colors.onSurface)
                    }
                    Spacer()
                }
                .padding(AppTokens.Spacing.lg) // Padding inside the Surface content
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 400) // fillMaxWidth(0.9f) and height(400.dp)
                .background(AppTokens.Colors.surface.opacity(0.7)) // color = AppTokens.Colors.surface.copy(alpha = 0.7f)
                .cornerRadius(AppTokens.Shapes.large) // shape = AppTokens.Shapes.large
                .shadow(
                    color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity),
                    radius: AppTokens.ElevationMapping.level2.radius,
                    x: 0, // Assuming no horizontal offset for shadow as not explicitly defined in Compose's ShadowSpec
                    y: AppTokens.ElevationMapping.level2.dy
                )
                .offset(y: scrollOffset.height / 5) // offset(y = scrollOffset.y.dp / 5)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            scrollOffset.height += value.translation.height
                        }
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Box fillMaxSize()
        }
        .background(AppTokens.Colors.background.ignoresSafeArea()) // Scaffold containerColor applied to the VStack
    }
}

// MARK: - App Entry Point
@main
struct SingleFileUIApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                // Ensures the app content extends to all edges of the screen
                .ignoresSafeArea(.all)
                // Hides the top status bar, achieving full-screen display as per requirement
                // Compatible with iOS 13.0 and later.
                .statusBarHidden(true)
        }
    }
}

// MARK: - Preview
struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}
