import SwiftUI

// MARK: - AppTokens (Translation of Kotlin AppTokens)

struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFF00FFFF) // Cyan
        static let secondary = Color(hex: 0xFF00B4FF) // Light Blue
        static let tertiary = Color(hex: 0xFF8A2BE2) // Blue Violet
        static let background = Color(hex: 0xFF0A0A1A) // Dark Navy
        static let surface = Color(hex: 0xFF141436) // Darker Purple-Blue
        static let surfaceVariant = Color(hex: 0xFF1E1E4A) // Even Darker Purple-Blue
        static let outline = Color(hex: 0xFF2E2E5C) // Dark Purple-Blue
        static let success = Color(hex: 0xFF00FFAA) // Greenish Cyan
        static let warning = Color(hex: 0xFFFFCC00) // Yellow
        static let error = Color(hex: 0xFFFF4444) // Red
        static let onPrimary = Color(hex: 0xFF0A0A1A) // Dark Navy (on primary)
        static let onSecondary = Color(hex: 0xFFFFFFFF) // White
        static let onBackground = Color(hex: 0xFFFFFFFF) // White
        static let onSurface = Color(hex: 0xFFFFFFFF) // White
    }

    struct TypographyTokens {
        // Kotlin's sp directly maps to points in SwiftUI for basic scaling
        static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) // Kotlin's FontWeight.Normal is .regular in Swift
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        // Kotlin's Dp directly maps to CGFloat for corner radius
        static let smallCornerRadius: CGFloat = 8
        static let mediumCornerRadius: CGFloat = 14
        static let largeCornerRadius: CGFloat = 22
    }

    struct Spacing {
        // Kotlin's Dp directly maps to CGFloat for spacing
        static let sm: CGFloat = 6
        static let md: CGFloat = 10
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 36
    }

    struct ShadowSpec {
        let elevation: CGFloat // Corresponds to Compose's Dp
        let radius: CGFloat    // Corresponds to Compose's Dp for blur radius
        let dy: CGFloat        // Corresponds to Compose's Dp for y-offset
        let opacity: Double    // Corresponds to Compose's Float
    }

    struct ElevationMapping {
        // Shadow parameters are directly mapped
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.1)
        static let level2 = ShadowSpec(elevation: 6, radius: 8, dy: 4, opacity: 0.15)
        static let level3 = ShadowSpec(elevation: 10, radius: 12, dy: 6, opacity: 0.18)
    }
}

// MARK: - Color Extension for Hex Initialization

extension Color {
    /// Initializes a Color from a 32-bit hexadecimal integer (e.g., 0xFFRRGGBB).
    init(hex: UInt) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: 1.0
        )
    }
}

// MARK: - RootScreen (Translation of Kotlin RootScreen Composable)

struct RootScreen: View {
    let stations = ["A", "B", "C", "D", "E", "F"]
    // Standard Material Design BottomAppBar height
    let bottomBarHeight: CGFloat = 56 
    // Standard Material Design FloatingActionButton size
    let fabSize: CGFloat = 56

    var body: some View {
        // ZStack is used to layer the main content, Floating Action Button, and Bottom App Bar,
        // similar to how Scaffold manages these elements in Compose.
        ZStack {
            // Main content area, equivalent to Scaffold's content block.
            // It's a VStack to arrange elements vertically.
            VStack(spacing: AppTokens.Spacing.lg) {
                Text("Metro Planner")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.primary)
                    .frame(maxWidth: .infinity, alignment: .leading) // Equivalent to Modifier.fillMaxWidth() and Alignment.Start

                // Canvas for drawing the metro line and stations.
                // The drawing logic is directly translated from Kotlin's Canvas.
                Canvas { context, size in
                    var path = Path()
                    let step = size.width / CGFloat(stations.count - 1)

                    for (i, _) in stations.enumerated() {
                        let x = CGFloat(i) * step
                        let y = i % 2 == 0 ? size.height / 4 : size.height * 3 / 4
                        if i == 0 {
                            path.move(to: CGPoint(x: x, y: y))
                        } else {
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                    }

                    // Draw the line with a horizontal gradient brush and stroke width.
                    context.stroke(
                        path,
                        with: .linearGradient(
                            Gradient(colors: [AppTokens.Colors.secondary, AppTokens.Colors.primary]),
                            startPoint: .zero,
                            endPoint: CGPoint(x: size.width, y: 0)
                        ),
                        lineWidth: 6
                    )

                    // Draw the circles for stations.
                    for (i, _) in stations.enumerated() {
                        let x = CGFloat(i) * step
                        let y = i % 2 == 0 ? size.height / 4 : size.height * 3 / 4
                        let center = CGPoint(x: x, y: y)

                        // Outer circle (radius 16f in Kotlin means diameter 32)
                        context.fill(
                            Path(ellipseIn: CGRect(x: center.x - 16, y: center.y - 16, width: 32, height: 32)),
                            with: .color(AppTokens.Colors.primary)
                        )
                        // Inner circle (radius 6f in Kotlin means diameter 12)
                        context.fill(
                            Path(ellipseIn: CGRect(x: center.x - 6, y: center.y - 6, width: 12, height: 12)),
                            with: .color(AppTokens.Colors.background)
                        )
                    }
                }
                .padding(AppTokens.Spacing.md) // Inner padding for the drawing content
                .frame(height: 260) // Fixed height for the canvas
                .background(AppTokens.Colors.surfaceVariant) // Background color for the canvas area
                .cornerRadius(AppTokens.Shapes.largeCornerRadius) // Rounded corners for the canvas background
                .padding(.horizontal, AppTokens.Spacing.lg) // Outer horizontal padding for the entire canvas block


                // Card for "Next Departures" section.
                // Implemented as a VStack with background, corner radius, and shadow.
                VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
                    Text("Next Departures")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.secondary)

                    ForEach(["08:45 • Line 1", "09:10 • Line 2", "09:30 • Line 3"], id: \.self) { departure in
                        HStack { // Equivalent to Row in Compose
                            Text(departure)
                                .font(AppTokens.TypographyTokens.body)
                                .foregroundColor(AppTokens.Colors.onSurface)
                            Spacer() // Equivalent to Modifier.weight(1f) or Arrangement.SpaceBetween
                            Text("On Time")
                                .font(AppTokens.TypographyTokens.label)
                                .foregroundColor(AppTokens.Colors.success)
                        }
                    }
                }
                .padding(AppTokens.Spacing.lg) // Inner padding for the card content
                .background(AppTokens.Colors.surface) // Card background color
                .cornerRadius(AppTokens.Shapes.largeCornerRadius) // Rounded corners for the card
                // Shadow applied based on AppTokens.ElevationMapping.level2
                .shadow(color: AppTokens.Colors.outline.opacity(AppTokens.ElevationMapping.level2.opacity),
                        radius: AppTokens.ElevationMapping.level2.radius,
                        x: 0,
                        y: AppTokens.ElevationMapping.level2.dy)
                .padding(.horizontal, AppTokens.Spacing.lg) // Outer horizontal padding for the entire card block

                // Spacer to push content up, equivalent to Spacer(modifier = Modifier.height(AppTokens.Spacing.md))
                Spacer(minLength: AppTokens.Spacing.md)
            }
            .padding(.top, AppTokens.Spacing.lg) // Top padding for the entire content column
            // Add bottom padding to prevent content from being obscured by the bottom bar.
            // In Compose Scaffold, content padding accounts for bottom bar.
            .padding(.bottom, bottomBarHeight) 
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Equivalent to Modifier.fillMaxSize()
            // Apply vertical gradient background to the main content area.
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [AppTokens.Colors.background, AppTokens.Colors.surfaceVariant, AppTokens.Colors.background]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            // Make the content ignore the safe area to fill the entire screen, including under the status bar.
            .ignoresSafeArea(.all, edges: .all)

            // Floating Action Button (FAB)
            // Positioned using a VStack and HStack with Spacers to push it to the bottom-trailing corner.
            VStack {
                Spacer() // Pushes the FAB to the bottom
                HStack {
                    Spacer() // Pushes the FAB to the trailing edge
                    Button(action: {}) { // Button action is empty as in Kotlin
                        Text("+")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .frame(width: fabSize, height: fabSize) // Fixed size for FAB
                            .background(AppTokens.Colors.primary) // FAB background color
                            .clipShape(Circle()) // Circular shape for FAB
                    }
                    .padding(.trailing, AppTokens.Spacing.lg) // Right padding from screen edge
                    // Bottom padding: FAB is AppTokens.Spacing.lg above the bottom bar.
                    .padding(.bottom, bottomBarHeight + AppTokens.Spacing.lg) 
                }
            }
            .ignoresSafeArea(.all, edges: .all) // FAB also ignores safe area for precise positioning

            // Bottom App Bar
            // Implemented as a VStack containing an HStack, pushed to the bottom of the ZStack.
            VStack(spacing: 0) {
                Spacer() // Pushes the bottom bar to the very bottom
                HStack(spacing: 0) { // Use spacing: 0 and then padding for internal spacing
                    Text("Routes")
                        .font(AppTokens.TypographyTokens.body)
                        .foregroundColor(AppTokens.Colors.secondary) // Active item color
                    Spacer()
                    Text("Planner")
                        .font(AppTokens.TypographyTokens.body)
                        .foregroundColor(AppTokens.Colors.onSurface)
                    Spacer()
                    Text("Tickets")
                        .font(AppTokens.TypographyTokens.body)
                        .foregroundColor(AppTokens.Colors.onSurface)
                    Spacer()
                    Text("Profile")
                        .font(AppTokens.TypographyTokens.body)
                        .foregroundColor(AppTokens.Colors.onSurface)
                }
                .padding(.horizontal, AppTokens.Spacing.lg) // Horizontal padding for the text items
                .frame(maxWidth: .infinity) // Equivalent to Modifier.fillMaxWidth()
                .frame(height: bottomBarHeight) // Fixed height for the bottom bar
                .background(AppTokens.Colors.surface) // Bottom bar background color
            }
            // Make the bottom bar ignore the safe area at the bottom to extend to the very edge.
            .ignoresSafeArea(.all, edges: .bottom)
        }
        .background(AppTokens.Colors.background) // Overall background color if ZStack content doesn't fill
        .statusBarHidden(true) // Hide the status bar for a full-screen experience
    }
}

// MARK: - App Entry Point

// The @main attribute marks MetroPlannerApp as the entry point of the SwiftUI application.
@main
struct MetroPlannerApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}