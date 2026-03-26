import SwiftUI

// MARK: - AppTokens Translation
// This section translates the AppTokens object from Kotlin to Swift.
// It defines custom colors, typography styles, shapes, spacing, and elevation for consistent UI elements.

extension Color {
    /// Initializes a Color from a 32-bit hexadecimal integer, similar to Android's 0xFF format.
    /// - Parameters:
    ///   - hex: The hexadecimal value (e.g., 0xFFA0C4FF).
    ///   - alpha: The alpha component, defaults to 1.0 (fully opaque).
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }
}

/// A struct containing all design tokens for the application, mirroring Kotlin's AppTokens.
struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFFA0C4FF)
        static let secondary = Color(hex: 0xFFB7E4C7)
        static let tertiary = Color(hex: 0xFFFFDDC1)
        static let background = Color(hex: 0xFFF8F7FF)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFF0F0F5)
        static let outline = Color(hex: 0xFFD9D9E3)
        static let success = Color(hex: 0xFFB4E4C7)
        static let warning = Color(hex: 0xFFFFDDC1)
        static let error = Color(hex: 0xFFFFB4AB)
        static let onPrimary = Color(hex: 0xFF001D3D)
        static let onSecondary = Color(hex: 0xFF003720)
        static let onTertiary = Color(hex: 0xFF3E2800)
        static let onBackground = Color(hex: 0xFF1B1B1F)
        static let onSurface = Color(hex: 0xFF1B1B1F)
    }

    struct TypographyTokens {
        // SwiftUI's Font.system allows specifying size and weight directly.
        // Line height and letter spacing can be applied as separate modifiers if needed globally,
        // but for this UI, direct font application is sufficient.
        static let display = Font.system(size: 45, weight: .bold)
        static let headline = Font.system(size: 24, weight: .semibold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let small = RoundedRectangle(cornerRadius: 4.0)
        static let medium = RoundedRectangle(cornerRadius: 8.0)
        static let large = RoundedRectangle(cornerRadius: 12.0)
        static let circle = Circle()
    }

    struct Spacing {
        // Using CGFloat for Dp values, assuming 1dp = 1pt for direct translation.
        static let xs: CGFloat = 4.0
        static let sm: CGFloat = 8.0
        static let md: CGFloat = 12.0
        static let lg: CGFloat = 16.0
        static let xl: CGFloat = 24.0
    }

    /// Represents a shadow specification, similar to Android's elevation.
    struct ShadowSpec {
        let elevation: CGFloat // Corresponds to SwiftUI's shadow radius
        let radius: CGFloat    // Corresponds to SwiftUI's shadow radius (often combined with elevation)
        let dy: CGFloat        // Corresponds to SwiftUI's shadow y-offset
        let opacity: Double    // Corresponds to SwiftUI's shadow color opacity
    }

    struct ElevationMapping {
        // Mapping Android elevation to SwiftUI shadow properties.
        // 'elevation' from Kotlin is often best represented by SwiftUI's 'radius' for visual softness.
        // 'radius' from Kotlin's ShadowSpec is also used for SwiftUI's 'radius'.
        // 'dy' directly maps to SwiftUI's 'y' offset.
        static let level1 = ShadowSpec(elevation: 1.0, radius: 2.0, dy: 1.0, opacity: 0.08)
        static let level2 = ShadowSpec(elevation: 3.0, radius: 4.0, dy: 2.0, opacity: 0.10)
        static let level3 = ShadowSpec(elevation: 6.0, radius: 8.0, dy: 4.0, opacity: 0.12)
    }
}

// MARK: - AppTheme Equivalent
// In SwiftUI, theming is often applied via ViewModifiers or directly to views.
// This modifier acts as a conceptual wrapper for applying global styles if needed,
// though for this specific UI, most styles are applied directly using AppTokens.
struct AppThemeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            // You can apply global environment values here if your theme required them,
            // e.g., .environment(\.font, AppTokens.TypographyTokens.body)
            // For this specific UI, direct application of AppTokens is sufficient and more flexible.
    }
}

extension View {
    /// Applies the custom application theme to the view hierarchy.
    func appTheme() -> some View {
        self.modifier(AppThemeModifier())
    }
}

// MARK: - Reusable Components

/// A reusable button for annotation tools, mirroring the Kotlin `AnnotationToolButton` composable.
struct AnnotationToolButton: View {
    let icon: String
    let toolName: String
    let selectedTool: String
    let onClick: () -> Void

    var isSelected: Bool { toolName == selectedTool }

    var body: some View {
        Button(action: onClick) {
            Text(icon)
                .font(Font.system(size: 17, weight: .bold)) // Font size for the icon, adjusted for visual parity
                .foregroundColor(isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
        }
        .frame(width: 40, height: 40) // Corresponds to Modifier.size(40.dp)
        .background(isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
        .clipShape(AppTokens.Shapes.circle) // Corresponds to CircleShape
        .buttonStyle(PlainButtonStyle()) // Removes default SwiftUI button styling (e.g., blue tint, tap effects)
        .contentShape(AppTokens.Shapes.circle) // Ensures the tap area matches the circular shape
    }
}

// MARK: - RootScreen Translation

/// The main UI screen, translating the Kotlin `RootScreen` composable.
struct RootScreen: View {
    @State private var selectedPage: Int = 1
    @State private var selectedTool: String = "pen"

    var body: some View {
        // Equivalent of Scaffold in SwiftUI: a VStack for vertical layout,
        // with the top bar and then the main content.
        VStack(spacing: 0) {
            // Top Bar equivalent (CenterAlignedTopAppBar)
            HStack(spacing: AppTokens.Spacing.sm) {
                // Navigation Icon (IconButton with a Box inside)
                Button(action: {}) {
                    AppTokens.Shapes.circle
                        .fill(AppTokens.Colors.surfaceVariant)
                        .frame(width: 24, height: 24) // Corresponds to Modifier.size(24.dp)
                }
                .buttonStyle(PlainButtonStyle()) // Remove default button styling

                Spacer() // Pushes the title to the center

                Text("Document.pdf")
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.onBackground)

                Spacer() // Pushes the title to the center

                // Actions (Share Button)
                Button(action: {}) {
                    Text("Share")
                        .font(AppTokens.TypographyTokens.label)
                        .foregroundColor(AppTokens.Colors.onPrimary)
                        .padding(.vertical, AppTokens.Spacing.xs) // Corresponds to PaddingValues(0.dp) and internal text padding
                        .padding(.horizontal, AppTokens.Spacing.sm)
                }
                .background(AppTokens.Colors.primary)
                .clipShape(AppTokens.Shapes.small) // Corresponds to RoundedCornerShape(4.dp)
                .buttonStyle(PlainButtonStyle()) // Remove default button styling
            }
            .padding(AppTokens.Spacing.md) // Padding for the top bar content
            .background(AppTokens.Colors.surface) // Top bar background color
            .frame(height: 56) // Standard AppBar height in Material Design 3 is often 64dp, but 56pt is common in iOS and visually fits.

            // Main content area (Row in Compose)
            HStack(spacing: AppTokens.Spacing.md) { // Corresponds to Modifier.padding(AppTokens.Spacing.md) and Spacer(modifier = Modifier.width(AppTokens.Spacing.md))
                // Left side: LazyVerticalGrid for pages
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: AppTokens.Spacing.sm) { // GridCells.Fixed(2) with spacedBy
                    ForEach(1...12, id: \.self) { page in
                        Button(action: { selectedPage = page }) {
                            AppTokens.Shapes.medium // Card shape (RoundedCornerShape(8.dp))
                                .fill(selectedPage == page ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                                .overlay(
                                    Text(page.description)
                                        .font(AppTokens.TypographyTokens.label)
                                        .foregroundColor(selectedPage == page ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                                )
                                .aspectRatio(0.7, contentMode: .fit) // Corresponds to Modifier.aspectRatio(0.7f)
                                .overlay(
                                    // BorderStroke equivalent
                                    selectedPage == page ?
                                    AppTokens.Shapes.medium.stroke(AppTokens.Colors.primary, lineWidth: 2)
                                    : nil
                                )
                        }
                        .buttonStyle(PlainButtonStyle()) // Remove default button styling
                    }
                }
                .frame(width: 150) // Corresponds to Modifier.width(150.dp)
                .padding(AppTokens.Spacing.sm) // Corresponds to contentPadding for LazyVerticalGrid
                .frame(maxHeight: .infinity) // Corresponds to .fillMaxHeight()

                // Right side: Main document view (Box in Compose)
                ZStack(alignment: .center) { // Corresponds to Box(contentAlignment = Alignment.Center)
                    // Main document card
                    AppTokens.Shapes.large // Card shape (RoundedCornerShape(12.dp))
                        .fill(AppTokens.Colors.surface)
                        .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity),
                                radius: AppTokens.ElevationMapping.level1.radius, // Using radius for softness
                                x: 0,
                                y: AppTokens.ElevationMapping.level1.dy) // Shadow for elevation
                        .overlay(
                            Text("Page \(selectedPage)")
                                .font(AppTokens.TypographyTokens.headline)
                                .foregroundColor(AppTokens.Colors.onSurface)
                        )
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // Corresponds to Modifier.fillMaxSize()

                    // Annotation tools column
                    VStack(spacing: AppTokens.Spacing.sm) { // Corresponds to verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
                        AnnotationToolButton(icon: "P", toolName: "pen", selectedTool: selectedTool, onClick: { selectedTool = "pen" })
                        AnnotationToolButton(icon: "H", toolName: "highlighter", selectedTool: selectedTool, onClick: { selectedTool = "highlighter" })
                        AnnotationToolButton(icon: "T", toolName: "text", selectedTool: selectedTool, onClick: { selectedTool = "text" })
                        AnnotationToolButton(icon: "S", toolName: "shape", selectedTool: selectedTool, onClick: { selectedTool = "shape" })
                    }
                    .padding(AppTokens.Spacing.sm) // Corresponds to .padding(AppTokens.Spacing.sm)
                    .background(AppTokens.Colors.surface.opacity(0.8)) // Corresponds to .background(AppTokens.Colors.surface.copy(alpha=0.8f))
                    .clipShape(AppTokens.Shapes.large) // Corresponds to AppTokens.Shapes.large
                    .overlay(
                        AppTokens.Shapes.large // Border equivalent
                            .stroke(AppTokens.Colors.outline, lineWidth: 1) // Corresponds to .border(1.dp, AppTokens.Colors.outline, AppTokens.Shapes.large)
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading) // Corresponds to .align(Alignment.CenterStart)
                    .padding(AppTokens.Spacing.md) // Corresponds to .padding(AppTokens.Spacing.md)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity) // Corresponds to Modifier.weight(1f).fillMaxHeight()
            }
            .padding(.horizontal, AppTokens.Spacing.md) // Overall padding for the main content row (left/right)
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensure main content fills remaining space
        }
        .background(AppTokens.Colors.background.ignoresSafeArea()) // Apply background to the whole screen, ignoring safe area
        .statusBarHidden(true) // Hide the status bar for a full-screen effect (iOS 14+)
    }
}

// MARK: - SwiftUI App Entry Point

/// The main entry point for the SwiftUI application, mirroring the `MainActivity`'s `onCreate` setup.
@main
struct SingleFileUIApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                .appTheme() // Apply the custom theme modifier
        }
    }
}