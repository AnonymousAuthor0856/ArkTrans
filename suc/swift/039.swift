import SwiftUI
import CoreGraphics // For CGFloat and sin
import UIKit      // For UISlider (via UIViewRepresentable)

// MARK: - AppTokens
// 统一的 UI 令牌，方便修改颜色、字体、间距和形状
struct AppTokens {
    struct Colors {
        static let primary = Color(red: 0xFF / 255.0, green: 0xA5 / 255.0, blue: 0x00 / 255.0) // #FFA500
        static let secondary = Color(red: 0xFF / 255.0, green: 0xC1 / 255.0, blue: 0x07 / 255.0) // #FFC107
        static let tertiary = Color(red: 0xFF / 255.0, green: 0xE0 / 255.0, blue: 0x66 / 255.0) // #FFE066
        static let background = Color(red: 0xFF / 255.0, green: 0xFB / 255.0, blue: 0xF2 / 255.0) // #FFFBF2
        static let surface = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0) // #FFFFFF
        static let surfaceVariant = Color(red: 0xFF / 255.0, green: 0xEE / 255.0, blue: 0xD6 / 255.0) // #FFEED6
        static let outline = Color(red: 0xF1 / 255.0, green: 0xC2 / 255.0, blue: 0x7D / 255.0) // #F1C27D
        static let success = Color(red: 0x22 / 255.0, green: 0xC5 / 255.0, blue: 0x5E / 255.0) // #22C55E
        static let warning = Color(red: 0xF5 / 255.0, green: 0x9E / 255.0, blue: 0x0B / 255.0) // #F59E0B
        static let error = Color(red: 0xEF / 255.0, green: 0x44 / 255.0, blue: 0x44 / 255.0) // #EF4444
        static let onPrimary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0) // #FFFFFF
        static let onSecondary = Color(red: 0x1E / 255.0, green: 0x1E / 255.0, blue: 0x1E / 255.0) // #1E1E1E
        static let onTertiary = Color(red: 0x1E / 255.0, green: 0x1E / 255.0, blue: 0x1E / 255.0) // #1E1E1E
        static let onBackground = Color(red: 0x1E / 255.0, green: 0x1E / 255.0, blue: 0x1E / 255.0) // #1E1E1E
        static let onSurface = Color(red: 0x1E / 255.0, green: 0x1E / 255.0, blue: 0x1E / 255.0) // #1E1E1E
    }

    struct TypographyTokens {
        static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) // Kotlin's FontWeight.Normal maps to .regular
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let small: CGFloat = 6.0
        static let medium: CGFloat = 12.0
        static let large: CGFloat = 20.0
    }

    struct Spacing {
        static let sm: CGFloat = 8.0
        static let md: CGFloat = 12.0
        static let lg: CGFloat = 16.0
        static let xl: CGFloat = 24.0
        static let xxl: CGFloat = 32.0
    }

    // Compose ShadowSpec(elevation: Dp, radius: Dp, dy: Dp, opacity: Float)
    // SwiftUI shadow(color: Color, radius: CGFloat, x: CGFloat, y: CGFloat)
    // We map Compose's `radius` to SwiftUI's `radius` (blur radius) and `dy` to `y` offset.
    struct ShadowSpec {
        let radius: CGFloat // Blur radius
        let dy: CGFloat     // Y offset
        let opacity: Double // Shadow color opacity
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(radius: 4, dy: 2, opacity: 0.12)
        static let level2 = ShadowSpec(radius: 8, dy: 4, opacity: 0.18)
    }
}

// MARK: - Custom SwiftUI Components

/// 自定义线性进度指示器，以匹配 Compose 版本的颜色和高度
struct CustomLinearProgressIndicator: View {
    let progress: Double
    let color: Color
    let trackColor: Color
    let height: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                trackColor // 背景轨道
                    .frame(width: geometry.size.width, height: height)
                    .cornerRadius(height / 2)

                color // 进度条
                    .frame(width: geometry.size.width * CGFloat(progress), height: height)
                    .cornerRadius(height / 2)
            }
        }
        .frame(height: height)
    }
}

/// 自定义滑块，使用 UIViewRepresentable 封装 UISlider，以在 iOS 16.0 上精确控制滑块拇指颜色
struct CustomSlider: UIViewRepresentable {
    @Binding var value: Float
    let activeTrackColor: Color
    let inactiveTrackColor: Color
    let thumbColor: Color

    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = value
        slider.addTarget(context.coordinator, action: #selector(Coordinator.valueChanged(_:)), for: .valueChanged)

        // 设置轨道颜色
        slider.minimumTrackTintColor = UIColor(activeTrackColor)
        slider.maximumTrackTintColor = UIColor(inactiveTrackColor)

        // 设置滑块拇指颜色
        slider.thumbTintColor = UIColor(thumbColor)

        return slider
    }

    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = value
        uiView.minimumTrackTintColor = UIColor(activeTrackColor)
        uiView.maximumTrackTintColor = UIColor(inactiveTrackColor)
        uiView.thumbTintColor = UIColor(thumbColor)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: CustomSlider

        init(_ parent: CustomSlider) {
            self.parent = parent
        }

        @objc func valueChanged(_ sender: UISlider) {
            parent.value = sender.value
        }
    }
}

// MARK: - Helper Extensions
extension Double {
    /// 将 Double 转换为 CGFloat，用于绘图
    func toCGFloat() -> CGFloat {
        return CGFloat(self)
    }
}

// MARK: - Main UI Components

/// 包含 Canvas 绘图的 Surface 区域
struct SurfaceWithCanvas: View {
    @Binding var paymentProgress: Float

    var body: some View {
        ZStack {
            // Surface 背景和阴影
            RoundedRectangle(cornerRadius: AppTokens.Shapes.large)
                .fill(AppTokens.Colors.surface.opacity(0.9))
                .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity),
                        radius: AppTokens.ElevationMapping.level2.radius,
                        x: 0,
                        y: AppTokens.ElevationMapping.level2.dy)
                .frame(height: 240) // 固定高度，与 Kotlin 版本一致

            // Canvas 绘图区域
            Canvas { context, size in
                let w = size.width
                let h = size.height
                let step = w / 20 // 20 个步长

                var path = Path()
                
                // 计算第一个点 (x=0) 的 Y 坐标，并移动到该点
                let initialY = h / 2 + sin(0 * Double.pi / 5 + Double(paymentProgress) * Double.pi).toCGFloat() * (h / 3)
                path.move(to: CGPoint(x: 0, y: initialY))

                // 绘制后续的线段，从 i=1 开始
                for i in 1...20 {
                    let x = CGFloat(i) * step
                    let y = h / 2 + sin(Double(i) * Double.pi / 5 + Double(paymentProgress) * Double.pi).toCGFloat() * (h / 3)
                    path.addLine(to: CGPoint(x: x, y: y))
                }
                context.stroke(path, with: .color(AppTokens.Colors.primary), lineWidth: 5)
            }
            .padding(AppTokens.Spacing.lg) // Canvas 内部的内边距
            .frame(height: 240) // 确保 Canvas 占据其父 Surface 的全部高度
        }
        .frame(maxWidth: .infinity) // 填充父 VStack 的宽度
    }
}

// MARK: - Root Screen
/// 应用程序的根视图，包含所有 UI 元素和布局
struct RootScreen: View {
    @State private var paymentProgress: Float = 0.3 // 支付进度状态

    var body: some View {
        // 模拟 Compose Scaffold 的结构
        VStack(spacing: 0) { // 最外层 VStack，用于放置 Top Bar 和内容区域，间距为 0
            // 顶部栏 (对应 Compose 的 CenterAlignedTopAppBar)
            Text("Installment Plan")
                .font(AppTokens.TypographyTokens.display)
                .foregroundColor(AppTokens.Colors.onSurface)
                .frame(maxWidth: .infinity)
                .frame(height: 64) // Compose Material3 TopAppBar 的默认高度为 64.dp
                .background(AppTokens.Colors.background) // 顶部栏背景色

            // 主要内容区域 (对应 Compose Scaffold 的 content lambda)
            VStack(spacing: AppTokens.Spacing.lg) { // 内容区域内部的元素间距
                SurfaceWithCanvas(paymentProgress: $paymentProgress)

                Text("Payment Progress")
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.primary)

                CustomLinearProgressIndicator(
                    progress: Double(paymentProgress),
                    color: AppTokens.Colors.primary,
                    trackColor: AppTokens.Colors.surfaceVariant,
                    height: 8
                )
                .frame(maxWidth: .infinity) // 填充宽度

                CustomSlider(
                    value: $paymentProgress,
                    activeTrackColor: AppTokens.Colors.primary,
                    inactiveTrackColor: AppTokens.Colors.surfaceVariant,
                    thumbColor: AppTokens.Colors.secondary
                )
                .frame(maxWidth: .infinity) // 填充宽度

                Button(action: {
                    paymentProgress = 0.0 // 重置进度
                }) {
                    Text("Reset Progress")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onTertiary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // 使文本填充按钮
                }
                .frame(height: 48) // 按钮高度
                .background(AppTokens.Colors.tertiary) // 按钮背景色
                .cornerRadius(AppTokens.Shapes.medium) // 按钮圆角
                .buttonStyle(PlainButtonStyle()) // 移除 SwiftUI 默认按钮样式，以便自定义背景和圆角
            }
            .padding(AppTokens.Spacing.lg) // 内容区域的内边距
            .frame(maxWidth: .infinity, maxHeight: .infinity) // 填充剩余空间
            .background(
                LinearGradient( // 内容区域的渐变背景
                    gradient: Gradient(colors: [
                        AppTokens.Colors.secondary.opacity(0.25),
                        AppTokens.Colors.background,
                        AppTokens.Colors.primary.opacity(0.25)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .background(AppTokens.Colors.background) // 整个屏幕的背景色 (Scaffold containerColor)
        .ignoresSafeArea() // 使视图忽略安全区域，实现全屏
        .statusBarHidden(true) // 隐藏顶部状态栏
    }
}

// MARK: - App Entry Point
/// 应用程序的入口点
@main
struct InstallmentPlanApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}