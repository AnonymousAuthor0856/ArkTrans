import SwiftUI

// MARK: - AppTokens
// This struct defines the design tokens for the application, making it easy to modify styles globally.
struct AppTokens {
    // Colors used throughout the application.
    struct Colors {
        static let primary = Color(red: 0xFF / 255.0, green: 0x70 / 255.0, blue: 0x43 / 255.0)
        static let secondary = Color(red: 0xFF / 255.0, green: 0xB7 / 255.0, blue: 0x4D / 255.0)
        static let tertiary = Color(red: 0xFF / 255.0, green: 0xD5 / 255.0, blue: 0x4F / 255.0)
        static let background = Color(red: 0xFF / 255.0, green: 0xF8 / 255.0, blue: 0xE1 / 255.0)
        static let surface = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let surfaceVariant = Color(red: 0xFF / 255.0, green: 0xEC / 255.0, blue: 0xB3 / 255.0)
        static let outline = Color(red: 0xE0 / 255.0, green: 0xC0 / 255.0, blue: 0x97 / 255.0)
        static let success = Color(red: 0x43 / 255.0, green: 0xA0 / 255.0, blue: 0x47 / 255.0)
        static let warning = Color(red: 0xFB / 255.0, green: 0xC0 / 255.0, blue: 0x2D / 255.0)
        static let error = Color(red: 0xE5 / 255.0, green: 0x39 / 255.0, blue: 0x35 / 255.0)
        static let onPrimary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onSecondary = Color(red: 0x3E / 255.0, green: 0x27 / 255.0, blue: 0x23 / 255.0)
        static let onTertiary = Color(red: 0x3E / 255.0, green: 0x27 / 255.0, blue: 0x23 / 255.0)
        static let onBackground = Color(red: 0x3E / 255.0, green: 0x27 / 255.0, blue: 0x23 / 255.0)
        static let onSurface = Color(red: 0x3E / 255.0, green: 0x27 / 255.0, blue: 0x23 / 255.0)
    }

    // Typography styles for different text elements.
    struct TypographyTokens {
        static let display = Font.system(size: 28, weight: .bold)
        static let headline = Font.system(size: 20, weight: .semibold)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    // Shapes with predefined corner radii.
    struct Shapes {
        static let small = RoundedRectangle(cornerRadius: 8)
        static let medium = RoundedRectangle(cornerRadius: 12)
        static let large = RoundedRectangle(cornerRadius: 16)
    }

    // Standardized spacing values.
    struct Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 32
    }

    // Shadow specifications for elevation effects.
    struct ShadowSpec {
        let elevation: CGFloat // Corresponds to blur radius in SwiftUI's shadow
        let radius: CGFloat    // Not directly mapped, often combined with elevation
        let dy: CGFloat        // Y-offset for the shadow
        let opacity: Double    // Opacity of the shadow
    }

    // Predefined elevation levels with their shadow specs.
    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 1, radius: 4, dy: 2, opacity: 0.1)
        static let level2 = ShadowSpec(elevation: 3, radius: 8, dy: 4, opacity: 0.14)
        static let level3 = ShadowSpec(elevation: 6, radius: 12, dy: 6, opacity: 0.16)
    }
}

// MARK: - Custom Environment Values for Theming
// These structs and extensions allow us to mimic a MaterialTheme-like system in SwiftUI
// by providing custom color schemes and typography through the environment.

// Defines the application's color scheme.
struct AppColorScheme {
    let primary: Color
    let onPrimary: Color
    let secondary: Color
    let onSecondary: Color
    let background: Color
    let onBackground: Color
    let surface: Color
    let onSurface: Color
    let surfaceVariant: Color
    let outline: Color
    let error: Color
}

// Key for accessing the AppColorScheme in the environment.
private struct AppColorSchemeKey: EnvironmentKey {
    static let defaultValue = AppColorScheme(
        primary: AppTokens.Colors.primary,
        onPrimary: AppTokens.Colors.onPrimary,
        secondary: AppTokens.Colors.secondary,
        onSecondary: AppTokens.Colors.onSecondary,
        background: AppTokens.Colors.background,
        onBackground: AppTokens.Colors.onBackground,
        surface: AppTokens.Colors.surface,
        onSurface: AppTokens.Colors.onSurface,
        surfaceVariant: AppTokens.Colors.surfaceVariant,
        outline: AppTokens.Colors.outline,
        error: AppTokens.Colors.error
    )
}

extension EnvironmentValues {
    var appColorScheme: AppColorScheme {
        get { self[AppColorSchemeKey.self] }
        set { self[AppColorSchemeKey.self] = newValue }
    }
}

// Defines the application's typography.
struct AppTypography {
    let displayLarge: Font
    let headlineMedium: Font
    let titleMedium: Font
    let bodyMedium: Font
    let labelMedium: Font
}

// Key for accessing the AppTypography in the environment.
private struct AppTypographyKey: EnvironmentKey {
    static let defaultValue = AppTypography(
        displayLarge: AppTokens.TypographyTokens.display,
        headlineMedium: AppTokens.TypographyTokens.headline,
        titleMedium: AppTokens.TypographyTokens.title,
        bodyMedium: AppTokens.TypographyTokens.body,
        labelMedium: AppTokens.TypographyTokens.label
    )
}

extension EnvironmentValues {
    var appTypography: AppTypography {
        get { self[AppTypographyKey.self] }
        set { self[AppTypographyKey.self] = newValue }
    }
}

// A ViewModifier to apply the custom theme to any view hierarchy.
struct AppThemeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .environment(\.appColorScheme, AppColorSchemeKey.defaultValue)
            .environment(\.appTypography, AppTypographyKey.defaultValue)
            // Shapes are typically applied directly via modifiers like .clipShape or .overlay
            // The global background is set in the RootScreen for full-screen coverage.
    }
}

extension View {
    // Convenience method to apply the custom theme.
    func appTheme() -> some View {
        self.modifier(AppThemeModifier())
    }
}

// MARK: - Client Data Model
// Represents a client with various details and map coordinates.
struct Client: Identifiable {
    let id: Int
    let name: String
    let region: String
    let level: String
    let x: CGFloat // Relative X position (0.0 to 1.0)
    let y: CGFloat // Relative Y position (0.0 to 1.0)
}

// MARK: - Custom Views

// A custom view for displaying a map marker with a label.
struct MapMarker: View {
    let label: String
    let level: String
    let selected: Bool
    let onClick: () -> Void
    let xOffset: CGFloat // Base X offset from the container's top-leading corner
    let yOffset: CGFloat // Base Y offset from the container's top-leading corner

    @Environment(\.appColorScheme) private var colorScheme
    @Environment(\.appTypography) private var typography

    var body: some View {
        // ZStack is used to layer the marker dot and the label card.
        // Alignment is .topLeading, and then individual offsets are applied.
        ZStack(alignment: .topLeading) {
            let markerColor = {
                switch level {
                case "A": return AppTokens.Colors.primary
                case "B": return AppTokens.Colors.secondary
                default: return AppTokens.Colors.tertiary
                }
            }()
            
            // Marker Dot (CircleShape in Compose)
            Circle()
                .fill(markerColor)
                .frame(width: selected ? 28 : 22, height: selected ? 28 : 22)
                .overlay(
                    Circle()
                        .stroke(selected ? AppTokens.Colors.onPrimary : AppTokens.Colors.surface, lineWidth: 2)
                )
                .offset(x: xOffset, y: yOffset) // Apply the base offset to the marker dot

            // Label Card (Card in Compose)
            Button(action: onClick) {
                Text(label)
                    .font(typography.labelMedium)
                    .foregroundColor(colorScheme.onSurface)
                    .padding(.horizontal, AppTokens.Spacing.sm)
                    .padding(.vertical, AppTokens.Spacing.xs)
                    .background(colorScheme.surfaceVariant)
                    .clipShape(AppTokens.Shapes.small)
                    .overlay(
                        AppTokens.Shapes.small
                            .stroke(colorScheme.outline, lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity),
                            radius: AppTokens.ElevationMapping.level1.radius, // blur radius
                            x: 0,
                            y: AppTokens.ElevationMapping.level1.dy) // y-offset
            }
            .buttonStyle(PlainButtonStyle()) // Remove default button styling for custom appearance
            // Apply the base offset plus the additional offset specified in Kotlin
            .offset(x: xOffset + 20, y: yOffset - 4) 
        }
    }
}

// A custom view to draw a grid overlay on the map.
// Mimics `Arrangement.SpaceEvenly` for 6 lines within the padded area.
struct MapGridOverlayCorrected: View {
    @Environment(\.appColorScheme) private var colorScheme

    var body: some View {
        GeometryReader { geometry in
            // Calculate available space for the grid lines after applying padding.
            let availableWidth = geometry.size.width - 2 * AppTokens.Spacing.lg
            let availableHeight = geometry.size.height - 2 * AppTokens.Spacing.lg

            ZStack {
                // Horizontal lines: 6 lines distributed evenly, meaning 7 equal segments.
                ForEach(0..<6) { i in
                    Rectangle()
                        .fill(colorScheme.surfaceVariant)
                        .frame(height: 1)
                        // Offset from the top-leading corner of the GeometryReader.
                        // Add AppTokens.Spacing.lg for the top padding.
                        // (i + 1) because the first line is at the end of the first segment.
                        .offset(y: AppTokens.Spacing.lg + (availableHeight / 7.0) * CGFloat(i + 1))
                }

                // Vertical lines: 6 lines distributed evenly, meaning 7 equal segments.
                ForEach(0..<6) { i in
                    Rectangle()
                        .fill(colorScheme.surfaceVariant)
                        .frame(width: 1)
                        // Offset from the top-leading corner of the GeometryReader.
                        // Add AppTokens.Spacing.lg for the left padding.
                        // (i + 1) because the first line is at the end of the first segment.
                        .offset(x: AppTokens.Spacing.lg + (availableWidth / 7.0) * CGFloat(i + 1))
                }
            }
        }
    }
}

// MARK: - RootScreen
// The main content view of the application.
struct RootScreen: View {
    @State private var selectedId: Int? = nil // State to track the selected client marker.
    @Environment(\.appColorScheme) private var colorScheme
    @Environment(\.appTypography) private var typography

    // Sample client data.
    let clients = [
        Client(id: 1, name: "Sunrise Tech", region: "Shanghai", level: "A", x: 0.2, y: 0.3),
        Client(id: 2, name: "Delta Logistics", region: "Beijing", level: "B", x: 0.5, y: 0.45),
        Client(id: 3, name: "Oceanic Foods", region: "Guangzhou", level: "A", x: 0.72, y: 0.6),
        Client(id: 4, name: "Horizon Ltd.", region: "Chengdu", level: "C", x: 0.33, y: 0.75)
    ]

    var body: some View {
        // VStack acts as the Scaffold, arranging Top Bar and content vertically.
        VStack(spacing: 0) {
            // Custom Top Bar (mimics CenterAlignedTopAppBar)
            ZStack {
                Text("Client Detail")
                    .font(typography.displayLarge)
                    .foregroundColor(colorScheme.onSurface)
                    .padding(.vertical, AppTokens.Spacing.md) // Vertical padding for text
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56) // Standard Material3 TopAppBar height
            .background(colorScheme.background) // Background color for the top bar area
            
            // Scrollable content area (mimics LazyColumn and other content below TopAppBar)
            ScrollView {
                VStack(spacing: AppTokens.Spacing.md) { // Vertical arrangement with spacing
                    // Box 1: Regional Client Map header
                    Text("Regional Client Map")
                        .font(typography.headlineMedium)
                        .foregroundColor(AppTokens.Colors.onPrimary)
                        .frame(maxWidth: .infinity, minHeight: 200) // height(200.dp)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [AppTokens.Colors.secondary, AppTokens.Colors.primary]),
                                startPoint: .leading, // Corresponds to Brush.linearGradient default behavior
                                endPoint: .trailing
                            )
                        )
                        .clipShape(AppTokens.Shapes.large) // RoundedCornerShape(large)
                        .padding(.horizontal, AppTokens.Spacing.lg) // Horizontal padding from Column
                        .padding(.top, AppTokens.Spacing.md) // Top padding from Column

                    // BoxWithConstraints: Map area
                    GeometryReader { geometry in
                        ZStack(alignment: .topLeading) { // Alignment for MapMarker positioning
                            AppTokens.Shapes.large // Background shape
                                .fill(colorScheme.surface)
                                .overlay(
                                    AppTokens.Shapes.large // Border
                                        .stroke(colorScheme.outline, lineWidth: 1)
                                )
                            
                            MapGridOverlayCorrected() // The grid overlay

                            // Iterate through clients to place MapMarkers
                            ForEach(clients) { client in
                                MapMarker(
                                    label: client.name,
                                    level: client.level,
                                    selected: selectedId == client.id,
                                    onClick: {
                                        selectedId = (selectedId == client.id) ? nil : client.id
                                    },
                                    // Calculate marker position based on relative coordinates and GeometryReader size
                                    xOffset: geometry.size.width * client.x,
                                    yOffset: geometry.size.height * client.y
                                )
                            }
                        }
                        // Apply frame and aspect ratio to the ZStack within GeometryReader
                        .frame(maxWidth: .infinity)
                        .aspectRatio(0.9, contentMode: .fit) // aspectRatio(0.9f)
                        .frame(minHeight: 360) // heightIn(min = 360.dp)
                    }
                    // Apply frame and aspect ratio to the GeometryReader itself to define its bounds
                    .frame(maxWidth: .infinity)
                    .aspectRatio(0.9, contentMode: .fit)
                    .frame(minHeight: 360)
                    .padding(.horizontal, AppTokens.Spacing.lg) // Horizontal padding from Column

                    // LazyColumn: Client List
                    VStack(spacing: AppTokens.Spacing.md) { // Vertical arrangement with spacing
                        ForEach(clients) { client in
                            // Card for each client
                            ZStack {
                                AppTokens.Shapes.medium // Card background shape
                                    .fill(colorScheme.surface)
                                    .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity),
                                            radius: AppTokens.ElevationMapping.level1.radius,
                                            x: 0,
                                            y: AppTokens.ElevationMapping.level1.dy)
                                    .overlay(
                                        AppTokens.Shapes.medium // Card border
                                            .stroke(colorScheme.outline, lineWidth: 1)
                                    )
                                
                                HStack { // Row for client details
                                    VStack(alignment: .leading, spacing: AppTokens.Spacing.xs) { // Column for name and region
                                        Text(client.name)
                                            .font(typography.titleMedium)
                                            .foregroundColor(colorScheme.onSurface)
                                        Text(client.region)
                                            .font(typography.bodyMedium)
                                            .foregroundColor(colorScheme.onSurface)
                                    }
                                    Spacer() // Pushes "Level" text to the right
                                    Text("Level \(client.level)")
                                        .font(typography.labelMedium)
                                        .foregroundColor(colorScheme.primary)
                                }
                                .padding(AppTokens.Spacing.lg) // Padding inside the card
                            }
                            .frame(maxWidth: .infinity) // Card fills available width
                        }
                    }
                    .padding(.horizontal, AppTokens.Spacing.lg) // Horizontal padding from Column
                    .padding(.bottom, AppTokens.Spacing.xxl) // contentPadding for LazyColumn
                }
            }
            .background(colorScheme.background) // Background for the scrollable content
        }
        .ignoresSafeArea(.all) // Make the app content extend to all edges, ignoring safe areas.
        .statusBarHidden(true) // Hide the top status bar.
        .background(colorScheme.background) // Ensure the very root background matches the theme.
    }
}

// MARK: - App Entry Point
// The main entry point for the SwiftUI application.
@main
struct ClientDetailApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                .appTheme() // Apply the custom theme to the entire app.
        }
    }
}