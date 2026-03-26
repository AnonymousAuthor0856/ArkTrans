
//
//  ContentView.swift
//  InvoiceScanner
//
//  Created by YourName on 2023/10/27.
//

import SwiftUI

// MARK: - 1. AppTokens (Colors, Typography, Shapes, Spacing, ElevationMapping)

// Extension to initialize Color from a hex value (0xFFRRGGBB)
extension Color {
    init(hex: UInt) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0
        )
    }
}

// Extension to create a circular path for Canvas
extension Path {
    init(circle center: CGPoint, radius: CGFloat) {
        self.init()
        addArc(center: center, radius: radius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
    }
}

// Data structure for shadow specifications
struct ShadowSpec {
    let radius: CGFloat // Blur radius
    let x: CGFloat      // X offset
    let y: CGFloat      // Y offset
    let opacity: Double // Shadow color opacity
}

// Centralized design tokens for easy modification and consistency
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
        static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) // FontWeight.Normal -> .regular
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

    struct ElevationMapping {
        // Mapping Compose's ShadowSpec to SwiftUI's shadow(color:radius:x:y:)
        // Compose: ShadowSpec(elevation: Dp, radius: Dp, dy: Dp, opacity: Float)
        // SwiftUI: shadow(color: Color, radius: CGFloat, x: CGFloat, y: CGFloat)
        // We use Compose's 'radius' as SwiftUI's blur radius, and 'dy' as SwiftUI's y-offset.
        static let level1 = ShadowSpec(radius: 4, x: 0, y: 2, opacity: 0.12)
        static let level2 = ShadowSpec(radius: 8, x: 0, y: 4, opacity: 0.18)
    }
}

// MARK: - 2. Custom Toggle Style for precise visual matching

struct InvoiceScannerToggleStyle: ToggleStyle {
    var checkedThumbColor: Color
    var uncheckedThumbColor: Color
    var checkedTrackColor: Color
    var uncheckedTrackColor: Color

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label // This is the label, which is EmptyView() in our case
            Spacer()
            ZStack(alignment: configuration.isOn ? .trailing : .leading) {
                Capsule()
                    .fill(configuration.isOn ? checkedTrackColor : uncheckedTrackColor)
                    .frame(width: 50, height: 30) // Standard switch size
                    .animation(.easeInOut(duration: 0.2), value: configuration.isOn)

                Circle()
                    .fill(configuration.isOn ? checkedThumbColor : uncheckedThumbColor)
                    .frame(width: 26, height: 26) // Standard thumb size
                    .padding(2) // Padding inside the capsule to center the thumb
                    .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
            }
            .onTapGesture {
                configuration.isOn.toggle()
            }
        }
    }
}

// MARK: - 3. Helper Views for reusability and clarity

// Equivalent to Compose's Surface for styling a background with shadow and rounded corners
struct SurfaceView<Content: View>: View {
    let shapeCornerRadius: CGFloat
    let backgroundColor: Color
    let shadowSpec: ShadowSpec
    let content: Content

    init(shape: CGFloat, color: Color, shadow: ShadowSpec, @ViewBuilder content: () -> Content) {
        self.shapeCornerRadius = shape
        self.backgroundColor = color
        self.shadowSpec = shadow
        self.content = content()
    }

    var body: some View {
        content
            .background(
                RoundedRectangle(cornerRadius: shapeCornerRadius)
                    .fill(backgroundColor)
                    .shadow(color: Color.black.opacity(shadowSpec.opacity),
                            radius: shadowSpec.radius,
                            x: shadowSpec.x,
                            y: shadowSpec.y)
            )
            .cornerRadius(shapeCornerRadius) // Clip content to the rounded corners
    }
}

// Equivalent to Compose's Box with fillMaxSize() and Alignment.Center
struct BoxView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - 4. Data Model

struct Marker: Identifiable {
    let id = UUID() // Required for ForEach in SwiftUI
    var x: CGFloat
    var y: CGFloat
    var label: String
}

// MARK: - 5. RootScreen (Main UI)

struct RootScreen: View {
    @State private var markers: [Marker] = [
        Marker(x: 120, y: 200, label: "A1"),
        Marker(x: 300, y: 400, label: "B2"),
        Marker(x: 520, y: 600, label: "C3")
    ]
    @State private var scanning: Bool = false

    var body: some View {
        VStack(spacing: 0) { // Main VStack to stack TopBar and Content, spacing 0 to ensure no gap
            // Top Bar (Equivalent to Compose's CenterAlignedTopAppBar)
            Text("Invoice Scanner")
                .font(AppTokens.TypographyTokens.display)
                .foregroundColor(AppTokens.Colors.onSurface)
                .frame(maxWidth: .infinity)
                .padding(.vertical, AppTokens.Spacing.lg) // Vertical padding for the title within the top bar
                .background(AppTokens.Colors.background) // Top bar background color

            // Main Content Area (Equivalent to Compose's Column with gradient background)
            VStack(spacing: AppTokens.Spacing.lg) {
                // Surface containing the Canvas
                SurfaceView(
                    shape: AppTokens.Shapes.large,
                    color: AppTokens.Colors.surface.opacity(0.9),
                    shadow: AppTokens.ElevationMapping.level2
                ) {
                    BoxView { // Equivalent to Compose's Box with fillMaxSize()
                        Canvas { context, size in
                            let center = CGPoint(x: size.width / 2, y: size.height / 2)
                            // Draw inner circle (surfaceVariant)
                            context.fill(Path(circle: center, radius: size.minDimension / 2.5), with: .color(AppTokens.Colors.surfaceVariant))
                            
                            // Draw markers
                            for marker in markers {
                                context.fill(Path(circle: CGPoint(x: marker.x, y: marker.y), radius: 12), with: .color(AppTokens.Colors.primary))
                            }
                        }
                        .padding(AppTokens.Spacing.md) // Padding inside the surface for the canvas
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // Canvas fills the Box
                    }
                }
                .frame(maxWidth: .infinity) // Surface fills width
                .frame(height: 400) // Fixed height for the surface

                // Scanning Active Row
                HStack {
                    Text("Scanning Active")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)
                    Spacer()
                    Toggle(isOn: $scanning) {
                        EmptyView() // No label for the toggle itself
                    }
                    .toggleStyle(InvoiceScannerToggleStyle(
                        checkedThumbColor: AppTokens.Colors.secondary,
                        uncheckedThumbColor: AppTokens.Colors.outline,
                        checkedTrackColor: AppTokens.Colors.secondary,
                        uncheckedTrackColor: AppTokens.Colors.surfaceVariant // Based on visual, light blueish
                    ))
                }
                .frame(maxWidth: .infinity) // HStack fills width

                // Add Marker Button
                Button(action: {
                    if scanning {
                        markers.append(
                            Marker(
                                x: CGFloat.random(in: 80...580), // Random.nextInt(80, 580).toFloat()
                                y: CGFloat.random(in: 150...650), // Random.nextInt(150, 650).toFloat()
                                label: "N\(markers.count + 1)"
                            )
                        )
                    }
                }) {
                    Text("Add Marker")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onPrimary)
                        .frame(maxWidth: .infinity, minHeight: 48) // fillMaxWidth().height(48.dp)
                        .background(AppTokens.Colors.primary) // containerColor
                        .cornerRadius(AppTokens.Shapes.medium) // shape
                }
            }
            .padding(AppTokens.Spacing.lg) // Padding for the main content column
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Make content fill remaining space
            .background(
                LinearGradient( // Vertical gradient background
                    gradient: Gradient(colors: [
                        AppTokens.Colors.secondary.opacity(0.3),
                        AppTokens.Colors.background,
                        AppTokens.Colors.primary.opacity(0.3)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .ignoresSafeArea() // Make the entire view ignore safe areas (full screen)
        .statusBarHidden(true) // Hide the status bar
    }
}

// MARK: - 6. App Entry Point

@main
struct InvoiceScannerApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}

// MARK: - 7. Preview Provider

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}
