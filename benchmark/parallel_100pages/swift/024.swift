
import SwiftUI

extension Color {
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

struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFFEF476F)
        static let secondary = Color(hex: 0xFFFFD166)
        static let tertiary = Color(hex: 0xFF06D6A0)
        static let background = Color(hex: 0xFFFFFCF2)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFF7EDE2)
        static let outline = Color(hex: 0xFFE5D4B1)
        static let success = Color(hex: 0xFF06D6A0)
        static let warning = Color(hex: 0xFFFFA600)
        static let error = Color(hex: 0xFFD62828)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFF1E1E1E)
        static let onTertiary = Color(hex: 0xFF1E1E1E)
        static let onBackground = Color(hex: 0xFF1E1E1E)
        static let onSurface = Color(hex: 0xFF1E1E1E)
    }

    struct TypographyTokens {
                static let display = Font.system(size: 26, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let smallCornerRadius: CGFloat = 6.0
        static let mediumCornerRadius: CGFloat = 10.0
        static let largeCornerRadius: CGFloat = 16.0
    }

    struct Spacing {
        static let xs: CGFloat = 4.0
        static let sm: CGFloat = 8.0
        static let md: CGFloat = 12.0
        static let lg: CGFloat = 16.0
        static let xl: CGFloat = 24.0
    }

    struct ShadowSpec {
        let elevation: CGFloat 
        let radius: CGFloat 
        let dy: CGFloat 
        let opacity: Double
    }

    struct ElevationMapping {
                static let level1 = ShadowSpec(elevation: 2.0, radius: 4.0, dy: 2.0, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 4.0, radius: 8.0, dy: 4.0, opacity: 0.16)
    }
}

struct RootScreen: View {
    @State private var points: [CGPoint] = [] 
    @State private var currentColor: Color = AppTokens.Colors.primary 
    
        let buttonHeight: CGFloat = 44.0 
    let fabSize: CGFloat = 56.0 
    let circleRadius: CGFloat = 10.0 

        var topBarActualHeight: CGFloat {
                return 30.0 + (2 * AppTokens.Spacing.md) 
    }
    
        var bottomBarActualHeight: CGFloat {
                return buttonHeight + (2 * AppTokens.Spacing.md) 
    }
    
        var fabBottomMargin: CGFloat {
        return AppTokens.Spacing.xl 
    }
    
        var canvasBottomPadding: CGFloat {
                                return max(bottomBarActualHeight, fabSize + fabBottomMargin)
    }
    
    var body: some View {
        ZStack {
                        AppTokens.Colors.background
                .ignoresSafeArea()

                        Canvas { context, size in
                for point in points {
                    let rect = CGRect(x: point.x - circleRadius, y: point.y - circleRadius, width: circleRadius * 2, height: circleRadius * 2)
                    context.fill(Path(ellipseIn: rect), with: .color(currentColor))
                }
            }
                        .gesture(
                DragGesture(minimumDistance: 0) 
                    .onChanged { value in
                                                                        points.append(value.location)
                    }
            )
                        .padding(.top, topBarActualHeight)
            .padding(.bottom, canvasBottomPadding)

                        VStack {
                Text("Retro Whiteboard")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.onSurface)
                    .padding(.vertical, AppTokens.Spacing.md) 
                    .frame(maxWidth: .infinity) 
                    .background(AppTokens.Colors.background) 
            }
            .frame(maxHeight: .infinity, alignment: .top) 

                        VStack {
                Spacer() 
                HStack(spacing: AppTokens.Spacing.md) { 
                    Spacer() 
                    Button(action: { currentColor = AppTokens.Colors.primary }) {
                        Text("Red")
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .frame(minWidth: 0, maxWidth: .infinity) 
                            .frame(height: buttonHeight) 
                            .background(AppTokens.Colors.primary)
                            .cornerRadius(AppTokens.Shapes.smallCornerRadius)
                    }
                    Spacer()
                    Button(action: { currentColor = AppTokens.Colors.secondary }) {
                        Text("Yellow")
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(AppTokens.Colors.onSecondary)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: buttonHeight)
                            .background(AppTokens.Colors.secondary)
                            .cornerRadius(AppTokens.Shapes.smallCornerRadius)
                    }
                    Spacer()
                    Button(action: { currentColor = AppTokens.Colors.tertiary }) {
                        Text("Green")
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(AppTokens.Colors.onTertiary)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: buttonHeight)
                            .background(AppTokens.Colors.tertiary)
                            .cornerRadius(AppTokens.Shapes.smallCornerRadius)
                    }
                    Spacer()
                }
                .padding(AppTokens.Spacing.md) 
                .background(AppTokens.Colors.surface) 
                .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity),
                        radius: AppTokens.ElevationMapping.level1.elevation, 
                        x: 0, y: AppTokens.ElevationMapping.level1.dy) 
            }
            .frame(maxHeight: .infinity, alignment: .bottom) 

                        VStack {
                Spacer() 
                HStack {
                    Spacer() 
                    Button(action: { points.removeAll() }) { 
                        Text("Clear")
                            .font(AppTokens.TypographyTokens.label)
                            .foregroundColor(AppTokens.Colors.onSecondary)
                            .frame(width: fabSize, height: fabSize) 
                            .background(AppTokens.Colors.secondary)
                            .clipShape(Circle()) 
                            .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity),
                                    radius: AppTokens.ElevationMapping.level1.elevation,
                                    x: 0, y: AppTokens.ElevationMapping.level1.dy)
                    }
                    .padding(.trailing, AppTokens.Spacing.xl) 
                    .padding(.bottom, fabBottomMargin) 
                }
            }
            .frame(maxHeight: .infinity, alignment: .bottom) 
        }
        .statusBarHidden(true) 
    }
}

@main
struct RetroWhiteboardApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}