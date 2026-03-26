
import SwiftUI

// MARK: - Hex Color Helper
// 扩展 Color 以支持十六进制颜色初始化，方便与 Kotlin 代码对应
extension Color {
    init(hex: UInt) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0
        )
    }
}

// MARK: - AppTokens
// 对应 Kotlin 的 AppTokens 对象，定义了颜色、字体、间距和阴影规范
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
        // Kotlin 的 FontWeight.Normal 对应 Swift 的 .regular
        static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Spacing {
        // Dp 单位直接映射为 CGFloat
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
    }

    struct ShadowSpec {
        let elevation: CGFloat
        let radius: CGFloat
        let dy: CGFloat
        let opacity: Double // Kotlin 的 Float 对应 Swift 的 Double
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 6, radius: 8, dy: 4, opacity: 0.18)
    }
}

// MARK: - RootScreen
// 对应 Kotlin 的 RootScreen Composable 函数
struct RootScreen: View {
    // 对应 Kotlin 的 mutableStateListOf 和 mutableStateOf
    @State private var nodes: [CGPoint] = [CGPoint(x: 200, y: 400), CGPoint(x: 500, y: 700), CGPoint(x: 350, y: 250)]
    @State private var currentColor: Color = AppTokens.Colors.primary

    var body: some View {
        ZStack {
            // 背景色，忽略安全区域以实现全屏
            AppTokens.Colors.background
                .ignoresSafeArea(.all)

            // Canvas 用于绘制节点和连线
            Canvas { context, size in
                // 绘制连线
                for i in 1..<nodes.count {
                    let start = nodes[i - 1]
                    let end = nodes[i]
                    var path = Path()
                    path.move(to: start)
                    path.addLine(to: end)
                    context.stroke(path, with: .color(currentColor), lineWidth: 6) // strokeWidth = 6f
                }

                // 绘制节点
                for node in nodes {
                    var path = Path()
                    // radius = 20f, 所以直径为 40f
                    path.addEllipse(in: CGRect(x: node.x - 20, y: node.y - 20, width: 40, height: 40))
                    context.fill(path, with: .color(currentColor))
                }
            }
            // 对应 Kotlin 的 pointerInput + detectDragGestures
            .gesture(
                DragGesture(minimumDistance: 0) // minimumDistance: 0 确保每次位置变化都触发
                    .onChanged { value in
                        nodes.append(value.location)
                    }
            )
            .ignoresSafeArea(.all) // Canvas 也忽略安全区域，确保绘制内容覆盖整个屏幕

            // 顶部栏 (Top Bar)
            VStack {
                Text("Neon Mind Map")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.primary)
                    // 垂直内边距，使其高度与 Compose 的 TopAppBar 视觉上接近
                    .padding(.vertical, AppTokens.Spacing.lg)
                    .frame(maxWidth: .infinity) // 填充宽度
                    .background(AppTokens.Colors.background)
                Spacer() // 将顶部栏推到顶部
            }
            .ignoresSafeArea(.container, edges: .top) // 顶部栏延伸到屏幕顶部边缘

            // 底部栏 (Bottom Bar)
            VStack {
                Spacer() // 将底部栏推到底部
                HStack(spacing: AppTokens.Spacing.md) { // 按钮之间的间距
                    // Cyan 按钮
                    Button(action: { currentColor = AppTokens.Colors.primary }) {
                        Text("Cyan")
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .padding(.horizontal, AppTokens.Spacing.lg) // 按钮内容水平内边距
                            .padding(.vertical, AppTokens.Spacing.sm) // 按钮内容垂直内边距
                    }
                    .background(AppTokens.Colors.primary)
                    .cornerRadius(15) // 根据内容高度 (14pt + 8pt*2 = 30pt)，圆角设为 15pt 形成胶囊形
                    .buttonStyle(PlainButtonStyle()) // 移除 SwiftUI 默认按钮样式

                    // Green 按钮
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

                    // Purple 按钮
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
                .padding(AppTokens.Spacing.md) // 整个按钮行的内边距
                .frame(maxWidth: .infinity) // 填充宽度
                .background(AppTokens.Colors.surfaceVariant)
                // 对应 Kotlin 的 tonalElevation 和 ShadowSpec
                .shadow(color: .black.opacity(AppTokens.ElevationMapping.level1.opacity),
                        radius: AppTokens.ElevationMapping.level1.radius,
                        x: 0,
                        y: AppTokens.ElevationMapping.level1.dy)
            }
            .ignoresSafeArea(.container, edges: .bottom) // 底部栏延伸到屏幕底部边缘

            // 浮动操作按钮 (Floating Action Button)
            VStack {
                Spacer() // 将 FAB 推到底部
                HStack {
                    Spacer() // 将 FAB 推到右侧
                    Button(action: {
                        // 对应 Kotlin 的随机位置生成
                        let randomX = CGFloat.random(in: 100...600)
                        let randomY = CGFloat.random(in: 200...800)
                        nodes.append(CGPoint(x: randomX, y: randomY))
                    }) {
                        Text("+")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.onSecondary)
                            .frame(width: 56, height: 56) // 标准 FAB 尺寸，假设 56dp
                            .background(AppTokens.Colors.secondary)
                            .clipShape(Circle()) // 圆形
                            // 对应 Kotlin 的 ShadowSpec
                            .shadow(color: .black.opacity(AppTokens.ElevationMapping.level2.opacity),
                                    radius: AppTokens.ElevationMapping.level2.radius,
                                    x: 0,
                                    y: AppTokens.ElevationMapping.level2.dy)
                    }
                    .padding(AppTokens.Spacing.lg) // FAB 距离屏幕边缘的内边距
                }
            }
        }
        .statusBarHidden(true) // 隐藏状态栏，对应 Kotlin 的 WindowInsetsControllerCompat.hide(WindowInsetsCompat.Type.systemBars())
    }
}

// MARK: - App Entry Point
// 对应 Kotlin 的 MainActivity 和 setContent
@main
struct MindMapApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}