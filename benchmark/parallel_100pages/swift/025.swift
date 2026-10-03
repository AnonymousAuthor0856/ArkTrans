
import SwiftUI

extension Color {
    init(hex: UInt) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0
        )
    }
}

struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFF00FFFF)
        static let secondary = Color(hex: 0xFF00FF88)
        static let tertiary = Color(hex: 0xFFBB86FC)
        static let background = Color(hex: 0xFF0D0D0D)
        static let surface = Color(hex: 0xFF1C1C1C)
        static let surfaceVariant = Color(hex: 0xFF2E2E2E)
        static let outline = Color(hex: 0xFF3F3F3F)
        static let success = Color(hex: 0xFF00FFAA)
        static let warning = Color(hex: 0xFFFFC107)
        static let error = Color(hex: 0xFFFF1744)
        static let onPrimary = Color(hex: 0xFF000000)
        static let onSecondary = Color(hex: 0xFF000000)
        static let onTertiary = Color(hex: 0xFF000000)
        static let onBackground = Color(hex: 0xFFFFFFFF)
        static let onSurface = Color(hex: 0xFFFFFFFF)
    }

    struct TypographyTokens {
                static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Spacing {
                static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
    }

    struct ShadowSpec {
        let elevation: CGFloat
        let radius: CGFloat
        let dy: CGFloat
        let opacity: Double 
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 6, radius: 8, dy: 4, opacity: 0.18)
    }
}

struct RootScreen: View {
        @State private var nodes: [CGPoint] = [CGPoint(x: 200, y: 400), CGPoint(x: 500, y: 700), CGPoint(x: 350, y: 250)]
    @State private var currentColor: Color = AppTokens.Colors.primary

    var body: some View {
        ZStack {
                        AppTokens.Colors.background
                .ignoresSafeArea(.all)

                        Canvas { context, size in
                                for i in 1..<nodes.count {
                    let start = nodes[i - 1]
                    let end = nodes[i]
                    var path = Path()
                    path.move(to: start)
                    path.addLine(to: end)
                    context.stroke(path, with: .color(currentColor), lineWidth: 6) 
                }

                                for node in nodes {
                    var path = Path()
                                        path.addEllipse(in: CGRect(x: node.x - 20, y: node.y - 20, width: 40, height: 40))
                    context.fill(path, with: .color(currentColor))
                }
            }
                        .gesture(
                DragGesture(minimumDistance: 0) 
                    .onChanged { value in
                        nodes.append(value.location)
                    }
            )
            .ignoresSafeArea(.all) 

                        VStack {
                Text("Neon Mind Map")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.primary)
                                        .padding(.vertical, AppTokens.Spacing.lg)
                    .frame(maxWidth: .infinity) 
                    .background(AppTokens.Colors.background)
                Spacer() 
            }
            .ignoresSafeArea(.container, edges: .top) 

                        VStack {
                Spacer() 
                HStack(spacing: AppTokens.Spacing.md) { 
                                        Button(action: { currentColor = AppTokens.Colors.primary }) {
                        Text("Cyan")
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .padding(.horizontal, AppTokens.Spacing.lg) 
                            .padding(.vertical, AppTokens.Spacing.sm) 
                    }
                    .background(AppTokens.Colors.primary)
                    .cornerRadius(15) 
                    .buttonStyle(PlainButtonStyle()) 

                                        Button(action: { currentColor = AppTokens.Colors.secondary }) {
                        Text("Green")
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(AppTokens.Colors.onSecondary)
                            .padding(.horizontal, AppTokens.Spacing.lg)
                            .padding(.vertical, AppTokens.Spacing.sm)
                    }
                    .background(AppTokens.Colors.secondary)
                    .cornerRadius(15)
                    .buttonStyle(PlainButtonStyle())

                                        Button(action: { currentColor = AppTokens.Colors.tertiary }) {
                        Text("Purple")
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(AppTokens.Colors.onTertiary)
                            .padding(.horizontal, AppTokens.Spacing.lg)
                            .padding(.vertical, AppTokens.Spacing.sm)
                    }
                    .background(AppTokens.Colors.tertiary)
                    .cornerRadius(15)
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(AppTokens.Spacing.md) 
                .frame(maxWidth: .infinity) 
                .background(AppTokens.Colors.surfaceVariant)
                                .shadow(color: .black.opacity(AppTokens.ElevationMapping.level1.opacity),
                        radius: AppTokens.ElevationMapping.level1.radius,
                        x: 0,
                        y: AppTokens.ElevationMapping.level1.dy)
            }
            .ignoresSafeArea(.container, edges: .bottom) 

                        VStack {
                Spacer() 
                HStack {
                    Spacer() 
                    Button(action: {
                                                let randomX = CGFloat.random(in: 100...600)
                        let randomY = CGFloat.random(in: 200...800)
                        nodes.append(CGPoint(x: randomX, y: randomY))
                    }) {
                        Text("+")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.onSecondary)
                            .frame(width: 56, height: 56) 
                            .background(AppTokens.Colors.secondary)
                            .clipShape(Circle()) 
                                                        .shadow(color: .black.opacity(AppTokens.ElevationMapping.level2.opacity),
                                    radius: AppTokens.ElevationMapping.level2.radius,
                                    x: 0,
                                    y: AppTokens.ElevationMapping.level2.dy)
                    }
                    .padding(AppTokens.Spacing.lg) 
                }
            }
        }
        .statusBarHidden(true) 
    }
}

@main
struct MindMapApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}