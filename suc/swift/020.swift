import SwiftUI

// MARK: - AppTokens
struct AppTokens {
    struct Colors {
        static let primary = Color(red: 255/255, green: 122/255, blue: 0/255)
        static let secondary = Color(red: 255/255, green: 195/255, blue: 0/255)
        static let tertiary = Color(red: 255/255, green: 243/255, blue: 192/255)
        static let background = Color(red: 255/255, green: 248/255, blue: 231/255)
        static let surface = Color(red: 255/255, green: 255/255, blue: 255/255)
        static let surfaceVariant = Color(red: 255/255, green: 235/255, blue: 200/255)
        static let outline = Color(red: 188/255, green: 167/255, blue: 137/255)
        static let success = Color(red: 40/255, green: 167/255, blue: 69/255)
        static let warning = Color(red: 255/255, green: 193/255, blue: 7/255)
        static let error = Color(red: 220/255, green: 53/255, blue: 69/255)
        static let onPrimary = Color(red: 255/255, green: 255/255, blue: 255/255)
        static let onSecondary = Color(red: 30/255, green: 30/255, blue: 30/255)
        static let onTertiary = Color(red: 30/255, green: 30/255, blue: 30/255)
        static let onBackground = Color(red: 30/255, green: 30/255, blue: 30/255)
        static let onSurface = Color(red: 30/255, green: 30/255, blue: 30/255)
    }

    struct TypographyTokens {
        static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let small = RoundedRectangle(cornerRadius: 8)
        static let medium = RoundedRectangle(cornerRadius: 14)
        static let large = RoundedRectangle(cornerRadius: 24)
    }

    struct Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 32
    }

    struct ShadowSpec {
        let elevation: CGFloat
        let radius: CGFloat
        let dy: CGFloat
        let opacity: Double
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 4, radius: 8, dy: 4, opacity: 0.16)
    }
}

// MARK: - RootScreen View
struct RootScreen: View {
    @State private var knobPosition: CGPoint = CGPoint(x: 90, y: 140) // 初始位置靠左
    @State private var powerOn: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            // 移除顶部状态栏，增加标题上方的空白
            Color.clear
                .frame(height: 40) // 增加标题上方的空白
            
            // Top Bar
            ZStack {
                AppTokens.Colors.background
                Text("Retro Remote Control")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.onSurface)
            }
            .frame(height: 64)
            
            ScrollView {
                VStack(alignment: .center, spacing: AppTokens.Spacing.xl) {
                    // Knob Surface
                    ZStack {
                        AppTokens.Colors.surfaceVariant
                        
                        Canvas { context, size in
                            let center = CGPoint(x: size.width / 2, y: size.height / 2)
                            
                            // Background circle
                            let backgroundPath = Path { path in
                                path.addEllipse(in: CGRect(
                                    x: center.x - 100,
                                    y: center.y - 100,
                                    width: 200,
                                    height: 200
                                ))
                            }
                            context.fill(backgroundPath, with: .color(AppTokens.Colors.secondary.opacity(0.2)))
                            
                            // Knob circle - 直径缩小
                            let knobPath = Path { path in
                                path.addEllipse(in: CGRect(
                                    x: knobPosition.x - 16, // 半径16，直径32
                                    y: knobPosition.y - 16,
                                    width: 32,
                                    height: 32
                                ))
                            }
                            context.fill(knobPath, with: .color(AppTokens.Colors.primary))
                        }
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    let newPosition = value.location
                                    let boundedX = max(16, min(264, newPosition.x))
                                    let boundedY = max(16, min(264, newPosition.y))
                                    knobPosition = CGPoint(x: boundedX, y: boundedY)
                                }
                        )
                    }
                    .frame(width: 280, height: 280)
                    .clipShape(AppTokens.Shapes.large)
                    .shadow(
                        color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity),
                        radius: AppTokens.ElevationMapping.level1.radius,
                        x: 0,
                        y: AppTokens.ElevationMapping.level1.dy
                    )
                    .padding(AppTokens.Spacing.lg)

                    // Power Status
                    Text(powerOn ? "Power: ON" : "Power: OFF")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(powerOn ? AppTokens.Colors.success : AppTokens.Colors.error)

                    // Buttons Row - 增加按钮间距
                    HStack(spacing: 60) { // 进一步增加按钮间距
                        Button(action: {
                            powerOn.toggle()
                        }) {
                            Text("On")
                                .font(AppTokens.TypographyTokens.title)
                                .foregroundColor(AppTokens.Colors.onPrimary)
                                .frame(width: 80, height: 80)
                                .background(AppTokens.Colors.primary)
                                .clipShape(Circle())
                        }
                        
                        Button(action: {
                            knobPosition = CGPoint(x: 90, y: 140) // 重置到靠左位置
                        }) {
                            VStack(spacing: 0) {
                                Text("Res")
                                Text("et")
                            }
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.onSecondary)
                            .frame(width: 80, height: 80)
                            .background(AppTokens.Colors.secondary)
                            .clipShape(Circle())
                        }
                    }

                    // Progress Bar - 整个条都是红色
                    AppTokens.Colors.primary
                        .frame(height: 6)
                        .clipShape(Capsule())
                        .padding(.horizontal, AppTokens.Spacing.lg)
                }
                .padding(AppTokens.Spacing.lg)
            }
            .background(AppTokens.Colors.background)
        }
        .background(AppTokens.Colors.background)
        .ignoresSafeArea()
    }
}

// MARK: - App Entry Point
@main
struct RetroRemoteControlApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                .statusBar(hidden: true) // 隐藏状态栏
        }
    }
}