
import SwiftUI

// MARK: - AppTokens (Equivalent to Kotlin AppTokens object)
struct AppTokens {
    // MARK: Colors
    struct Colors {
        // Hex values for reference:
        // primary: #FF8C00
        // secondary: #FFC107
        // tertiary: #FFE082
        // background: #FFF8E1
        // surface: #FFFFFF
        // surfaceVariant: #FFECB3
        // outline: #D7CCC8
        // success: #4CAF50
        // warning: #FFB300
        // error: #E53935
        // onPrimary: #3E2723
        // onSecondary: #3E2723
        // onBackground: #3E2723
        // onSurface: #3E2723
        
        static let primary = Color(red: 255/255, green: 140/255, blue: 0/255)
        static let secondary = Color(red: 255/255, green: 193/255, blue: 7/255)
        static let tertiary = Color(red: 255/255, green: 224/255, blue: 130/255)
        static let background = Color(red: 255/255, green: 248/255, blue: 225/255)
        static let surface = Color(red: 255/255, green: 255/255, blue: 255/255)
        static let surfaceVariant = Color(red: 255/255, green: 236/255, blue: 179/255)
        static let outline = Color(red: 215/255, green: 204/255, blue: 200/255)
        static let success = Color(red: 76/255, green: 175/255, blue: 80/255)
        static let warning = Color(red: 255/255, green: 179/255, blue: 0/255)
        static let error = Color(red: 229/255, green: 57/255, blue: 53/255)
        static let onPrimary = Color(red: 62/255, green: 39/255, blue: 35/255)
        static let onSecondary = Color(red: 62/255, green: 39/255, blue: 35/255)
        static let onBackground = Color(red: 62/255, green: 39/255, blue: 35/255)
        static let onSurface = Color(red: 62/255, green: 39/255, blue: 35/255)
    }

    // MARK: TypographyTokens
    struct TypographyTokens {
        // Font sizes (sp) and weights
        static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) // Kotlin's FontWeight.Normal maps to .regular
        static let label = Font.system(size: 12, weight: .medium)
    }

    // MARK: Shapes
    struct Shapes {
        // Corner radii (dp)
        static let small = RoundedRectangle(cornerRadius: 6)
        static let medium = RoundedRectangle(cornerRadius: 10)
        static let large = RoundedRectangle(cornerRadius: 16)
    }

    // MARK: Spacing
    struct Spacing {
        // Spacing values (dp)
        static let sm: CGFloat = 6
        static let md: CGFloat = 10
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
    }

    // MARK: ShadowSpec (for elevation mapping)
    struct ShadowSpec {
        let elevation: CGFloat // Corresponds to blur radius in SwiftUI's .shadow
        let radius: CGFloat    // Not directly mapped as a separate blur radius in SwiftUI, elevation is used.
        let dy: CGFloat        // Y-offset for the shadow
        let opacity: Double    // Opacity of the shadow
    }

    // MARK: ElevationMapping
    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.1)
        static let level2 = ShadowSpec(elevation: 6, radius: 8, dy: 4, opacity: 0.15)
        static let level3 = ShadowSpec(elevation: 10, radius: 12, dy: 6, opacity: 0.18)
    }
}

// MARK: - Pin Data Model (Equivalent to Kotlin data class Pin)
struct Pin: Identifiable {
    let id = UUID() // Required for ForEach in SwiftUI to uniquely identify elements
    var x: CGFloat
    var y: CGFloat
    var label: String
}

// MARK: - RootScreen (Equivalent to Kotlin RootScreen Composable)
struct RootScreen: View {
    // @State for mutable state, equivalent to remember { mutableStateListOf(...) }
    @State private var pins: [Pin] = [
        Pin(x: 150, y: 250, label: "Group A"),
        Pin(x: 350, y: 420, label: "Group B"),
        Pin(x: 520, y: 310, label: "Group C")
    ]

    var body: some View {
        // Scaffold equivalent: A ZStack to set the background color for the entire screen,
        // and a VStack for the main content layout.
        ZStack {
            AppTokens.Colors.background // Set the background color
                .ignoresSafeArea(.all, edges: .all) // Make background fill under safe areas

            VStack(spacing: AppTokens.Spacing.lg) { // Column equivalent, with vertical arrangement spacedBy(lg)
                Text("Retro Group Buy")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.onBackground)
                    .frame(maxWidth: .infinity, alignment: .leading) // Align text to the start (left)

                // Card equivalent for "Live Deals Map"
                VStack(alignment: .leading, spacing: AppTokens.Spacing.md) { // Column equivalent inside card
                    Text("Live Deals Map")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)

                    // Box equivalent for the map canvas
                    ZStack {
                        // Background for the map area, matching Kotlin's .background(AppTokens.Colors.surfaceVariant, AppTokens.Shapes.medium)
                        AppTokens.Colors.surfaceVariant
                            .clipShape(AppTokens.Shapes.medium) // Apply rounded corners

                        Canvas { context, size in
                            // Draw pins on the canvas
                            for pin in pins {
                                let center = CGPoint(x: pin.x, y: pin.y)
                                // drawCircle(radius = 14f) means diameter is 28f
                                let path = Path(ellipseIn: CGRect(x: center.x - 14, y: center.y - 14, width: 28, height: 28))
                                context.fill(path, with: .color(AppTokens.Colors.primary))
                            }
                        }
                        .padding(8) // Padding inside the Canvas, matching Kotlin's .padding(8.dp)
                    }
                    .frame(maxWidth: .infinity) // fillMaxWidth()
                    .frame(height: 220) // height(220.dp)
                    // The background and clipShape are primarily handled by the ZStack's first element,
                    // but adding them here again ensures the frame itself respects them if needed.
                    .background(AppTokens.Colors.surfaceVariant)
                    .clipShape(AppTokens.Shapes.medium)
                }
                .padding(AppTokens.Spacing.lg) // Padding inside the card, matching Kotlin's .padding(AppTokens.Spacing.lg)
                .background(AppTokens.Colors.surface) // Card background color
                .clipShape(AppTokens.Shapes.large) // Card shape
                .shadow(color: AppTokens.Colors.onSurface.opacity(AppTokens.ElevationMapping.level2.opacity),
                        radius: AppTokens.ElevationMapping.level2.elevation, // blur radius
                        x: 0, // No x-offset in Kotlin's shadow
                        y: AppTokens.ElevationMapping.level2.dy) // Card elevation

                Spacer().frame(height: AppTokens.Spacing.sm) // Spacer equivalent

                // Row equivalent for buttons
                HStack(spacing: AppTokens.Spacing.md) { // horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
                    Button(action: {
                        // Random.nextInt(100, 550) generates 100 to 549
                        // Random.nextInt(150, 450) generates 150 to 449
                        let randomX = CGFloat.random(in: 100..<550)
                        let randomY = CGFloat.random(in: 150..<450)
                        pins.append(Pin(x: randomX, y: randomY, label: "New"))
                    }) {
                        Text("Add Group")
                            .font(AppTokens.TypographyTokens.label)
                            .foregroundColor(AppTokens.Colors.onSecondary)
                            .frame(maxWidth: .infinity) // Modifier.weight(1f) equivalent
                            .frame(height: 48) // height(48.dp)
                            .background(AppTokens.Colors.secondary) // containerColor
                            .clipShape(AppTokens.Shapes.medium) // shape
                    }
                    .buttonStyle(PlainButtonStyle()) // Remove default SwiftUI button styling for custom look

                    Button(action: {
                        pins.removeAll()
                    }) {
                        Text("Clear")
                            .font(AppTokens.TypographyTokens.label)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .frame(maxWidth: .infinity) // Modifier.weight(1f) equivalent
                            .frame(height: 48) // height(48.dp)
                            .background(AppTokens.Colors.primary) // containerColor
                            .clipShape(AppTokens.Shapes.medium) // shape
                    }
                    .buttonStyle(PlainButtonStyle()) // Remove default SwiftUI button styling for custom look
                }

                // Card equivalent for "Active Groups"
                VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) { // Column equivalent inside card
                    Text("Active Groups")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.primary)

                    // ForEach for dynamic list items, equivalent to pins.forEach
                    ForEach(pins) { pin in
                        HStack { // Row equivalent
                            Text(pin.label)
                                .font(AppTokens.TypographyTokens.body)
                                .foregroundColor(AppTokens.Colors.onSurface)
                            Spacer() // horizontalArrangement = Arrangement.SpaceBetween
                            Circle() // Box with CircleShape
                                .fill(AppTokens.Colors.primary)
                                .frame(width: 14, height: 14) // size(14.dp)
                        }
                    }
                }
                .padding(AppTokens.Spacing.lg) // Padding inside the card
                .background(AppTokens.Colors.surface) // Card background color
                .clipShape(AppTokens.Shapes.large) // Card shape
                .shadow(color: AppTokens.Colors.onSurface.opacity(AppTokens.ElevationMapping.level1.opacity),
                        radius: AppTokens.ElevationMapping.level1.elevation, // blur radius
                        x: 0,
                        y: AppTokens.ElevationMapping.level1.dy) // Card elevation

                Spacer() // Pushes content to the top, similar to fillMaxSize() without specific alignment
            }
            .padding(AppTokens.Spacing.lg) // Outer padding for the whole column, matching .padding(pad).padding(AppTokens.Spacing.lg)
        }
        // MARK: Full-screen and Status Bar Hiding
        // .ignoresSafeArea() already used on the background color to extend content.
        // .statusBarHidden(true) hides the status bar.
        // For a more robust full-screen experience, also consider setting in Info.plist:
        // "View controller-based status bar appearance" to NO
        // "Status bar is initially hidden" to YES
        .statusBarHidden(true)
    }
}

// MARK: - App Entry Point (Equivalent to MainActivity)
@main
struct GroupBuyApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}