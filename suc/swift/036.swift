
import SwiftUI
import CoreGraphics // For sin/cos

// MARK: - AppTokens Definition

// Dp (Density-independent pixel) equivalent for easy scaling in SwiftUI
typealias Dp = CGFloat

struct AppTokens {
    struct Colors {
        // Helper for hex colors (0xFFRRGGBB format, assuming full opacity)
        static func color(hex: UInt) -> Color {
            let red = Double((hex >> 16) & 0xFF) / 255.0
            let green = Double((hex >> 8) & 0xFF) / 255.0
            let blue = Double(hex & 0xFF) / 255.0
            return Color(red: red, green: green, blue: blue)
        }

        static let primary = color(hex: 0xFFFFA8A8)
        static let secondary = color(hex: 0xFFFFE1A8)
        static let tertiary = color(hex: 0xFFA8FFE1)
        static let background = color(hex: 0xFFFFFCF5)
        static let surface = color(hex: 0xFFFFFFFF)
        static let surfaceVariant = color(hex: 0xFFF7F7F7)
        static let outline = color(hex: 0xFFE2E2E2)
        static let success = color(hex: 0xFF22C55E)
        static let warning = color(hex: 0xFFF59E0B)
        static let error = color(hex: 0xFFEF4444)
        static let onPrimary = color(hex: 0xFF1E1E1E)
        static let onSecondary = color(hex: 0xFF1E1E1E)
        static let onTertiary = color(hex: 0xFF1E1E1E)
        static let onBackground = color(hex: 0xFF1E1E1E)
        static let onSurface = color(hex: 0xFF1E1E1E)
    }

    struct TypographyTokens {
        static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let small: Dp = 6
        static let medium: Dp = 12
        static let large: Dp = 20
    }

    struct Spacing {
        static let sm: Dp = 8
        static let md: Dp = 12
        static let lg: Dp = 16
        static let xl: Dp = 24
        static let xxl: Dp = 32
    }

    struct ShadowSpec {
        let elevation: Dp // Not directly used for SwiftUI shadow, but kept for reference
        let radius: Dp
        let dy: Dp
        let opacity: Double // Kotlin's Float to Swift's Double
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 6, radius: 8, dy: 4, opacity: 0.18)
    }
}

// MARK: - Custom SwiftUI Styles

/// Custom ProgressViewStyle to visually match Android's LinearProgressIndicator.
struct LinearProgressViewStyle: ProgressViewStyle {
    var tint: Color
    var track: Color

    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4) // Half of height 8.dp
                    .fill(track)
                    .frame(height: 8)

                RoundedRectangle(cornerRadius: 4)
                    .fill(tint)
                    .frame(width: geometry.size.width * CGFloat(configuration.fractionCompleted ?? 0), height: 8)
            }
        }
    }
}

/// Custom ToggleStyle to visually match Android's Switch.
struct CustomSwitchToggleStyle: ToggleStyle {
    var checkedThumbColor: Color
    var uncheckedThumbColor: Color

    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Capsule()
                // Track color: primary when checked, surfaceVariant when unchecked (Compose defaults)
                .fill(configuration.isOn ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                .frame(width: 51, height: 31) // Standard iOS switch size for visual consistency
                .overlay(
                    Circle()
                        // Thumb color as specified in Kotlin code
                        .fill(configuration.isOn ? checkedThumbColor : uncheckedThumbColor)
                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1) // Subtle shadow for thumb
                        .padding(2) // Inset the circle slightly from the capsule edge
                        .offset(x: configuration.isOn ? (51 - 31) / 2 : -(51 - 31) / 2) // Move thumb
                )
                .animation(.easeInOut(duration: 0.2), value: configuration.isOn) // Smooth animation for toggle
        }
        .buttonStyle(PlainButtonStyle()) // Remove default button styling
    }
}

/// Custom View for FilterChip to match Android's FilterChip.
struct FilterChipView: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(AppTokens.TypographyTokens.label)
                .foregroundColor(AppTokens.Colors.onPrimary)
                .padding(.horizontal, AppTokens.Spacing.md) // Horizontal padding for text inside chip
                .padding(.vertical, AppTokens.Spacing.sm)   // Vertical padding for text inside chip
                .background(
                    RoundedRectangle(cornerRadius: AppTokens.Shapes.small) // Small rounded corners
                        // Chip background color: primary when selected, surfaceVariant when unselected
                        .fill(isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                )
        }
        .buttonStyle(PlainButtonStyle()) // Remove default button styling
    }
}

// MARK: - RootScreen View

struct RootScreen: View {
    @State private var selectedChip: String = "BTC"
    @State private var progress: Double = 0.6 // Kotlin's Float maps to Swift's Double for ProgressView
    @State private var isAutoUpdate: Bool = true

    var body: some View {
        ZStack { // Overall ZStack for the base background color and main content stack
            // Base background color (Scaffold's containerColor and TopAppBar's containerColor)
            AppTokens.Colors.background
                .ignoresSafeArea() // Extends background to all safe areas

            VStack(spacing: 0) { // Main content stack, spacing 0 to control padding manually
                // Top Bar (mimics CenterAlignedTopAppBar)
                Text("Crypto Market")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.onSurface)
                    .padding(.vertical, AppTokens.Spacing.lg) // Vertical padding for visual height
                    .frame(maxWidth: .infinity) // Center aligns the text
                    .background(AppTokens.Colors.background) // Top bar's specific background color
                    .ignoresSafeArea(.container, edges: .top) // Extends top bar background to top safe area

                // Content area (mimics Column with padding and background gradient)
                VStack(spacing: AppTokens.Spacing.lg) { // Corresponds to Column's verticalArrangement
                    // Filter Chips Row
                    HStack(spacing: AppTokens.Spacing.md) { // Corresponds to Row's horizontalArrangement
                        ForEach(["BTC", "ETH", "SOL", "ADA"], id: \.self) { chipText in
                            FilterChipView(
                                text: chipText,
                                isSelected: selectedChip == chipText,
                                action: { selectedChip = chipText }
                            )
                        }
                    }

                    // Chart Surface
                    ZStack { // Used for applying background, corner radius, and shadow
                        RoundedRectangle(cornerRadius: AppTokens.Shapes.large)
                            .fill(AppTokens.Colors.surface) // Surface background color
                            .shadow(
                                color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity),
                                radius: AppTokens.ElevationMapping.level2.radius,
                                x: 0, // Typically 0 for a simple drop shadow
                                y: AppTokens.ElevationMapping.level2.dy
                            )

                        // Canvas for drawing the waveform
                        Canvas { context, size in
                            let w = size.width
                            let h = size.height
                            let step = w / 30
                            let initialPrevY = h / 2 // Initial prevY from Kotlin code

                            var path = Path()
                            // Start the path at the point corresponding to (x - step, prevY) for i=0
                            path.move(to: CGPoint(x: -step, y: initialPrevY))

                            for i in 0...30 { // Loop from 0 to 30 (inclusive)
                                let x = Dp(i) * step
                                let y = h / 2 + sin(Double(i) * .pi / 6 + progress * .pi) * (h / 3)
                                path.addLine(to: CGPoint(x: x, y: y)) // Add line segment
                            }
                            context.stroke(path, with: .color(AppTokens.Colors.primary), lineWidth: 5)
                        }
                        .padding(AppTokens.Spacing.lg) // Padding inside the Surface for the Canvas
                    }
                    .frame(maxWidth: .infinity, minHeight: 260, maxHeight: 260) // fillMaxWidth().height(260.dp)

                    // Price Variation Text
                    Text("Price Variation")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.primary)

                    // Linear Progress Indicator
                    ProgressView(value: progress)
                        .progressViewStyle(LinearProgressViewStyle(tint: AppTokens.Colors.primary, track: AppTokens.Colors.surfaceVariant))
                        .frame(maxWidth: .infinity)
                        .frame(height: 8) // height(8.dp)

                    // Auto Update Row
                    HStack {
                        Text("Auto Update")
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(AppTokens.Colors.onSurface)

                        Spacer() // Pushes the toggle to the right

                        Toggle(isOn: $isAutoUpdate) {
                            EmptyView() // Hide default label for the toggle
                        }
                        .toggleStyle(CustomSwitchToggleStyle(
                            checkedThumbColor: AppTokens.Colors.secondary,
                            uncheckedThumbColor: AppTokens.Colors.outline
                        ))
                    }
                }
                .padding(AppTokens.Spacing.lg) // Corresponds to `padding(AppTokens.Spacing.lg)` on the Column
                .background(
                    LinearGradient( // Vertical gradient background
                        gradient: Gradient(colors: [
                            AppTokens.Colors.secondary.opacity(0.3),
                            AppTokens.Colors.background,
                            AppTokens.Colors.tertiary.opacity(0.3)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity) // fillMaxSize() for the content area
            }
        }
        .statusBarHidden(true) // Hide the status bar for the entire view
    }
}

// MARK: - App Entry Point

@main
struct CryptoMarketApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}
