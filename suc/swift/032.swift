import SwiftUI

// MARK: - AppTokens
// 封装了应用程序的所有设计令牌，便于集中管理和修改。
struct AppTokens {
    struct Colors {
        static let primary = Color(red: 0xFF / 255.0, green: 0xA5 / 255.0, blue: 0x00 / 255.0)
        static let secondary = Color(red: 0xFF / 255.0, green: 0xC3 / 255.0, blue: 0x00 / 255.0)
        static let tertiary = Color(red: 0xFF / 255.0, green: 0xE0 / 255.0, blue: 0x66 / 255.0)
        static let background = Color(red: 0xFF / 255.0, green: 0xFB / 255.0, blue: 0xF2 / 255.0)
        static let surface = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let surfaceVariant = Color(red: 0xFF / 255.0, green: 0xEE / 255.0, blue: 0xD6 / 255.0)
        static let outline = Color(red: 0xF1 / 255.0, green: 0xC2 / 255.0, blue: 0x7D / 255.0)
        static let success = Color(red: 0x22 / 255.0, green: 0xC5 / 255.0, blue: 0x5E / 255.0)
        static let warning = Color(red: 0xF5 / 255.0, green: 0x9E / 255.0, blue: 0x0B / 255.0)
        static let error = Color(red: 0xEF / 255.0, green: 0x44 / 255.0, blue: 0x44 / 255.0)
        static let onPrimary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onSecondary = Color(red: 0x1E / 255.0, green: 0x1E / 255.0, blue: 0x1E / 255.0)
        static let onTertiary = Color(red: 0x1E / 255.0, green: 0x1E / 255.0, blue: 0x1E / 255.0)
        static let onBackground = Color(red: 0x1E / 255.0, green: 0x1E / 255.0, blue: 0x1E / 255.0)
        static let onSurface = Color(red: 0x1E / 255.0, green: 0x1E / 255.0, blue: 0x1E / 255.0)
    }

    struct TypographyTokens {
        // Compose的displayLarge对应SwiftUI的Font.system(size:weight:)
        static let display = Font.system(size: 28, weight: .bold)
        // Compose的titleMedium对应SwiftUI的Font.system(size:weight:)
        static let title = Font.system(size: 18, weight: .medium)
        // Compose的bodyMedium对应SwiftUI的Font.system(size:weight:)
        static let body = Font.system(size: 14, weight: .regular)
        // Compose的labelMedium对应SwiftUI的Font.system(size:weight:)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Spacing {
        // Compose的dp单位直接映射为SwiftUI的CGFloat点单位
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 32
    }
    
    // ShadowSpec 和 ElevationMapping 在当前 UI 中未使用，但保留以备将来扩展
    struct ShadowSpec {
        let elevation: CGFloat
        let radius: CGFloat
        let dy: CGFloat
        let opacity: Double
    }
    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 6, radius: 8, dy: 4, opacity: 0.16)
    }
}

// MARK: - CustomLinearProgressViewStyle
// 自定义 ProgressViewStyle 以精确匹配 Compose 的 LinearProgressIndicator 的颜色和高度。
struct CustomLinearProgressViewStyle: ProgressViewStyle {
    var progressColor: Color
    var trackColor: Color
    var height: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in // 使用 GeometryReader 获取 ProgressView 的实际宽度
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(trackColor)
                    .frame(height: height)

                Capsule()
                    .fill(progressColor)
                    // 根据进度值和 ProgressView 的宽度计算填充部分的宽度
                    .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * geometry.size.width, height: height)
            }
        }
        .frame(height: height) // 确保 ProgressView 自身的高度也受控
    }
}

// MARK: - RootScreen
// 应用程序的主要 UI 视图，对应 Kotlin 的 RootScreen Composable。
struct RootScreen: View {
    // @State 变量对应 Kotlin 的 mutableStateOf，用于管理 UI 状态。
    // markerPosition 的初始值 (200f, 400f) 直接映射为 CGPoint(x: 200, y: 400)，
    // 假设它们是 Canvas 内部坐标系中的点。
    @State private var markerPosition: CGPoint = CGPoint(x: 200, y: 400)
    @State private var progress: Float = 0.4

    var body: some View {
        // 顶层 ZStack 模拟 Scaffold 的内容区域，并处理背景渐变。
        ZStack {
            // 背景渐变，对应 Kotlin 的 Brush.verticalGradient
            LinearGradient(
                gradient: Gradient(colors: [
                    AppTokens.Colors.secondary.opacity(0.2),
                    AppTokens.Colors.background,
                    AppTokens.Colors.primary.opacity(0.2)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea() // 让渐变背景延伸到安全区域之外，实现全屏效果

            // VStack 模拟 Scaffold 的结构：顶部栏 + 主要内容区域
            VStack(spacing: 0) {
                // 顶部栏，对应 Kotlin 的 CenterAlignedTopAppBar
                ZStack {
                    AppTokens.Colors.background
                        .frame(height: 56) // 标准 AppBar 高度
                        .ignoresSafeArea(.container, edges: .top) // 顶部栏背景延伸到状态栏下方

                    Text("Transfer Wizard")
                        .font(AppTokens.TypographyTokens.display) // 应用自定义字体样式
                        .foregroundColor(AppTokens.Colors.onSurface)
                }
                .frame(maxWidth: .infinity) // 确保顶部栏宽度填充整个屏幕

                // 主要内容区域，使用 GeometryReader 获取可用空间尺寸
                GeometryReader { geometry in
                    // ZStack 对应 Kotlin 的 Box，用于叠加 Canvas 和底部控件
                    ZStack(alignment: .center) {
                        // Canvas 视图，用于自定义绘制圆形
                        Canvas { context, size in
                            let center = CGPoint(x: size.width / 2, y: size.height / 2)
                            
                            // 绘制大背景圆，对应 Kotlin 的 drawCircle(radius = 260f)
                            context.fill(Path(ellipseIn: CGRect(x: center.x - 260, y: center.y - 260, width: 520, height: 520)), with: .color(AppTokens.Colors.surfaceVariant))
                            
                            // 绘制标记圆，对应 Kotlin 的 drawCircle(radius = 20f, center = markerPosition)
                            context.fill(Path(ellipseIn: CGRect(x: markerPosition.x - 20, y: markerPosition.y - 20, width: 40, height: 40)), with: .color(AppTokens.Colors.primary))
                            
                        }
                        // 应用 Canvas 的内边距，对应 Kotlin 的 .padding(AppTokens.Spacing.xl)
                        .padding(AppTokens.Spacing.xl)
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // Canvas 填充 ZStack 的可用空间

                        // 底部内容区域 (Transfer Progress, 进度条, 按钮)
                        // VStack 对应 Kotlin 的 Column，并设置间距
                        VStack(spacing: AppTokens.Spacing.lg) {
                            Text("Transfer Progress")
                                .font(AppTokens.TypographyTokens.title) // 应用自定义字体样式
                                .foregroundColor(AppTokens.Colors.onSurface)

                            // 线性进度条，使用自定义样式
                            ProgressView(value: progress)
                                .progressViewStyle(CustomLinearProgressViewStyle(
                                    progressColor: AppTokens.Colors.primary,
                                    trackColor: AppTokens.Colors.surfaceVariant,
                                    height: 8 // 对应 Kotlin 的 8.dp
                                ))
                                // 宽度填充 80%，对应 Kotlin 的 .fillMaxWidth(0.8f)
                                .frame(width: geometry.size.width * 0.8)

                            // 按钮行，对应 Kotlin 的 Row，并设置间距
                            HStack(spacing: AppTokens.Spacing.md) {
                                // "+" 按钮
                                Button(action: {
                                    progress = min(progress + 0.1, 1.0) // 对应 Kotlin 的 coerceAtMost
                                }) {
                                    Text("+")
                                        .font(.system(size: 24, weight: .bold)) // 按钮文字样式
                                        .frame(width: 64, height: 64) // 按钮固定尺寸，确保圆形
                                        .background(AppTokens.Colors.primary) // 背景色
                                        .foregroundColor(AppTokens.Colors.onPrimary) // 前景色
                                        .clipShape(Circle()) // 裁剪为圆形，对应 Kotlin 的 CircleShape
                                }
                                .buttonStyle(PlainButtonStyle()) // 移除 SwiftUI 默认按钮样式

                                // "-" 按钮
                                Button(action: {
                                    progress = max(progress - 0.1, 0.0) // 对应 Kotlin 的 coerceAtLeast
                                }) {
                                    Text("-")
                                        .font(.system(size: 24, weight: .bold)) // 按钮文字样式
                                        .frame(width: 64, height: 64) // 按钮固定尺寸，确保圆形
                                        .background(AppTokens.Colors.secondary) // 背景色
                                        .foregroundColor(AppTokens.Colors.onSecondary) // 前景色
                                        .clipShape(Circle()) // 裁剪为圆形
                                }
                                .buttonStyle(PlainButtonStyle()) // 移除 SwiftUI 默认按钮样式
                            }
                        }
                        // 将 VStack 对齐到底部，对应 Kotlin 的 .align(Alignment.BottomCenter)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                        // 底部内边距，对应 Kotlin 的 .padding(bottom = AppTokens.Spacing.xxl)
                        .padding(.bottom, AppTokens.Spacing.xxl)
                    }
                }
            }
        }
        .background(AppTokens.Colors.background) // 整体背景色，在渐变未覆盖区域可见
        .edgesIgnoringSafeArea(.all) // 忽略所有安全区域，实现全屏
        .statusBarHidden(true) // 隐藏状态栏
    }
}

// MARK: - App Entry Point
// 应用程序的入口点，对应 Kotlin 的 MainActivity 和 setContent。
@main
struct TransferWizardApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}