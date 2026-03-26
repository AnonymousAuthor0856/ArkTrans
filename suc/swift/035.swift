
import SwiftUI
import Foundation // For sin and Double.pi

// MARK: - AppTokens
// 定义应用程序的颜色、字体、形状、间距和阴影规范
struct AppTokens {
    struct Colors {
        static let primary = Color(red: 37/255, green: 99/255, blue: 235/255) // 0xFF2563EB
        static let secondary = Color(red: 96/255, green: 165/255, blue: 250/255) // 0xFF60A5FA
        static let tertiary = Color(red: 147/255, green: 197/255, blue: 253/255) // 0xFF93C5FD
        static let background = Color(red: 248/255, green: 250/255, blue: 252/255) // 0xFFF8FAFC
        static let surface = Color(red: 255/255, green: 255/255, blue: 255/255) // 0xFFFFFFFF
        static let surfaceVariant = Color(red: 226/255, green: 232/255, blue: 240/255) // 0xFFE2E8F0
        static let outline = Color(red: 203/255, green: 213/255, blue: 225/255) // 0xFFCBD5E1
        static let success = Color(red: 34/255, green: 197/255, blue: 94/255) // 0xFF22C55E
        static let warning = Color(red: 245/255, green: 158/255, blue: 11/255) // 0xFFF59E0B
        static let error = Color(red: 239/255, green: 68/255, blue: 68/255) // 0xFFEF4444
        static let onPrimary = Color(red: 255/255, green: 255/255, blue: 255/255) // 0xFFFFFFFF
        static let onSecondary = Color(red: 30/255, green: 58/255, blue: 138/255) // 0xFF1E3A8A
        static let onTertiary = Color(red: 30/255, green: 64/255, blue: 175/255) // 0xFF1E40AF
        static let onBackground = Color(red: 15/255, green: 23/255, blue: 42/255) // 0xFF0F172A
        static let onSurface = Color(red: 15/255, green: 23/255, blue: 42/255) // 0xFF0F172A
    }

    struct TypographyTokens {
        // Kotlin的displayLarge映射到28sp Bold，titleMedium映射到18sp Medium，bodyMedium映射到14sp Normal，labelMedium映射到12sp Medium。
        static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) // Kotlin's FontWeight.Normal maps to .regular
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let small: CGFloat = 4.0
        static let medium: CGFloat = 8.0
        static let large: CGFloat = 16.0
    }

    struct Spacing {
        static let sm: CGFloat = 6.0
        static let md: CGFloat = 10.0
        static let lg: CGFloat = 14.0
        static let xl: CGFloat = 20.0
        static let xxl: CGFloat = 28.0
    }

    // 阴影规范，用于映射到 SwiftUI 的 shadow 修饰符
    struct ShadowSpec {
        let elevation: CGFloat // 在 SwiftUI shadow 中通常映射到 blur radius 或作为整体阴影强度参考
        let radius: CGFloat    // SwiftUI shadow 的 blur radius
        let dy: CGFloat        // SwiftUI shadow 的 y 偏移
        let opacity: Double    // SwiftUI shadow 颜色透明度
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 2.0, radius: 4.0, dy: 2.0, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 6.0, radius: 8.0, dy: 4.0, opacity: 0.18)
    }
}

// MARK: - CustomLinearProgressViewStyle
// 自定义 ProgressView 样式，以匹配 Kotlin 的 LinearProgressIndicator 颜色和圆角
struct CustomLinearProgressViewStyle: ProgressViewStyle {
    var tint: Color       // 进度条颜色
    var trackColor: Color // 轨道颜色

    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // 轨道背景
                RoundedRectangle(cornerRadius: 4)
                    .fill(trackColor)
                    .frame(height: 8)

                // 进度条
                RoundedRectangle(cornerRadius: 4)
                    .fill(tint)
                    .frame(width: geometry.size.width * CGFloat(configuration.fractionCompleted ?? 0), height: 8)
            }
        }
        .frame(height: 8) // 确保整个 ProgressView 的高度为 8
    }
}

// MARK: - RootScreen
// 主 UI 视图，对应 Kotlin 的 RootScreen Composable
struct RootScreen: View {
    @State private var progress: Double = 0.5 // 对应 Kotlin 的 mutableFloatStateOf

    var body: some View {
        // 对应 Kotlin 的 Scaffold，使用 VStack 模拟顶部栏和内容区域
        VStack(spacing: 0) {
            // 顶部栏 (CenterAlignedTopAppBar 对应)
            ZStack {
                AppTokens.Colors.background
                    .frame(height: 56) // 默认 AppBar 高度
                Text("Stock K-Line")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.onSurface)
            }
            // 扩展背景到顶部安全区域，以覆盖状态栏
            .ignoresSafeArea(.container, edges: .top)

            // 主内容区域 (对应 Kotlin 的 Column)
            VStack(spacing: AppTokens.Spacing.lg) {
                // 用于图表的 Surface
                ZStack { // 使用 ZStack 来应用背景、圆角和阴影
                    RoundedRectangle(cornerRadius: AppTokens.Shapes.large)
                        .fill(AppTokens.Colors.surface)
                        // 应用阴影，根据 Kotlin 的 ElevationMapping.level2
                        .shadow(
                            color: AppTokens.Colors.onBackground.opacity(AppTokens.ElevationMapping.level2.opacity),
                            radius: AppTokens.ElevationMapping.level2.radius,
                            x: 0, // Kotlin 的 ShadowSpec 没有 dx，所以 x 偏移为 0
                            y: AppTokens.ElevationMapping.level2.dy
                        )
                    
                    // Canvas 用于绘制 K-Line 图
                    Canvas { context, size in
                        let width = size.width
                        let height = size.height
                        let step = width / 50.0 // 50 个步长
                        var prevY = height / 2.0 // 初始 Y 坐标

                        var path = Path()
                        // 移动到起始点
                        path.move(to: CGPoint(x: 0, y: prevY))

                        // 绘制正弦波形
                        for i in 0...50 {
                            let x = CGFloat(i) * step
                            // 对应 Kotlin 的 sin(i * PI / 8 + progress * PI).toFloat() * (height / 3)
                            let y = height / 2.0 + sin(Double(i) * Double.pi / 8.0 + progress * Double.pi) * (height / 3.0)
                            path.addLine(to: CGPoint(x: x, y: y))
                            prevY = y // 更新 prevY 为当前 y，用于下一段的起点
                        }
                        
                        // 描边路径
                        context.stroke(path, with: .color(AppTokens.Colors.primary), lineWidth: 4)

                    }
                    .padding(AppTokens.Spacing.lg) // Canvas 内部的内边距
                }
                .frame(maxWidth: .infinity) // 填充宽度
                .frame(height: 260) // 固定高度 260.dp
                .cornerRadius(AppTokens.Shapes.large) // 确保 ZStack 的内容也应用圆角

                Text("Market Trend")
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.primary)

                // Slider 控件
                // 根据 UI 效果图，滑块和活跃轨道颜色为 primary
                Slider(value: $progress, in: 0...1) {
                    // 无需标签，保持简洁
                }
                .tint(AppTokens.Colors.primary) // 设置滑块和活跃轨道的颜色
                // SwiftUI 16.0 无法直接设置非活跃轨道的颜色，这里将接受系统默认样式
                // 如果需要精确匹配，通常需要使用 UIViewRepresentable 封装 UISlider。
                // 为了满足“可不加编辑直接运行”的要求，我们使用纯 SwiftUI。
                .frame(maxWidth: .infinity) // 填充宽度
                .frame(height: 44) // 为 Slider 提供一个标准的可触摸高度

                // LinearProgressIndicator 控件
                ProgressView(value: progress)
                    .progressViewStyle(CustomLinearProgressViewStyle(tint: AppTokens.Colors.primary, trackColor: AppTokens.Colors.surfaceVariant))
                    .frame(maxWidth: .infinity) // 填充宽度
                    .frame(height: 8) // 确保 ProgressView 的外部高度也是 8
            }
            .padding(AppTokens.Spacing.lg) // Column 内部的内边距
            .frame(maxWidth: .infinity, maxHeight: .infinity) // 填充剩余空间
            // 背景渐变 (Brush.verticalGradient 对应)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        AppTokens.Colors.secondary.opacity(0.15),
                        AppTokens.Colors.background,
                        AppTokens.Colors.primary.opacity(0.15)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        // 整个视图的背景色 (Scaffold 的 containerColor 对应)
        .background(AppTokens.Colors.background)
        // 忽略所有安全区域，实现全屏显示
        .ignoresSafeArea(.all, edges: .all)
        // 隐藏顶部状态栏
        .statusBarHidden(true)
    }
}

// MARK: - Main App Entry Point
// SwiftUI 应用程序的入口点，对应 Kotlin 的 MainActivity
@main
struct StockKLineApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                .statusBarHidden()
        }
    }
}

// MARK: - Helper Extension
// 辅助扩展，用于将 Double 转换为 CGFloat，因为 sin 函数返回 Double
extension Double {
    func toFloat() -> CGFloat {
        return CGFloat(self)
    }
}
