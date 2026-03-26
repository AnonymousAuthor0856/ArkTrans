import SwiftUI

// MARK: - AppTokens
// 集中管理应用程序的颜色、字体、形状和间距。
// 这使得全局修改 UI 样式变得非常方便。
struct AppTokens {
    struct Colors {
        // 将 Kotlin 的 0xFFRRGGBB 格式颜色转换为 Swift 的 Color(red:green:blue:)
        static let primary = Color(red: 0x11 / 255.0, green: 0x18 / 255.0, blue: 0x27 / 255.0)
        static let secondary = Color(red: 0x37 / 255.0, green: 0x41 / 255.0, blue: 0x51 / 255.0)
        static let tertiary = Color(red: 0x6B / 255.0, green: 0x72 / 255.0, blue: 0x80 / 255.0)
        static let background = Color(red: 0xF9 / 255.0, green: 0xFA / 255.0, blue: 0xFB / 255.0)
        static let surface = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let surfaceVariant = Color(red: 0xE5 / 255.0, green: 0xE7 / 255.0, blue: 0xEB / 255.0)
        static let outline = Color(red: 0xD1 / 255.0, green: 0xD5 / 255.0, blue: 0xDB / 255.0)
        static let onPrimary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onSecondary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onBackground = Color(red: 0x11 / 255.0, green: 0x18 / 255.0, blue: 0x27 / 255.0)
        static let onSurface = Color(red: 0x1F / 255.0, green: 0x29 / 255.0, blue: 0x37 / 255.0)
    }

    struct TypographyTokens {
        // 将 Kotlin 的 TextStyle 转换为 Swift 的 Font
        static let display = Font.system(size: 26, weight: .bold)
        static let headline = Font.system(size: 18, weight: .semibold)
        static let title = Font.system(size: 14, weight: .medium)
        static let body = Font.system(size: 12, weight: .regular)
    }

    struct Shapes {
        // 将 Kotlin 的 RoundedCornerShape 转换为 Swift 的 CGFloat 圆角半径
        static let smallCornerRadius: CGFloat = 6
        static let mediumCornerRadius: CGFloat = 10
        static let largeCornerRadius: CGFloat = 16
    }

    struct Spacing {
        // 将 Kotlin 的 Dp 转换为 Swift 的 CGFloat 间距
        static let sm: CGFloat = 6
        static let md: CGFloat = 10
        static let lg: CGFloat = 14
        static let xl: CGFloat = 22
    }
}

// MARK: - ParcelCanvas
// 对应 Kotlin 的 ParcelCanvas Composable 函数
struct ParcelCanvas: View {
    // @State 用于管理视图内部的可变状态
    @State private var dragOffset: CGPoint = .zero // 拖动圆圈的当前位置
    @State private var parcelPoints: [CGPoint] = [] // 散布的包裹点

    // 辅助函数：生成随机点，确保它们在给定的宽度和高度范围内
    private func generateRandomPoints(width: CGFloat, height: CGFloat) -> [CGPoint] {
        (0..<25).map { _ in
            CGPoint(x: CGFloat.random(in: 0...width), y: CGFloat.random(in: 0...height))
        }
    }

    var body: some View {
        // GeometryReader 用于获取父视图的尺寸，以便进行精确布局和拖动范围限制
        GeometryReader { geometry in
            // 计算 Canvas 实际可绘制区域的尺寸，考虑到内部 padding
            let effectiveCanvasWidth = geometry.size.width - (AppTokens.Spacing.md * 2)
            let effectiveCanvasHeight = geometry.size.height - (AppTokens.Spacing.md * 2)

            // ZStack 用于将 Canvas 和 Text 叠加在一起
            ZStack(alignment: .center) {
                // SwiftUI 的 Canvas 视图，用于自定义绘图
                Canvas { context, size in
                    // 绘制所有包裹点
                    for point in parcelPoints {
                        // 创建一个用于绘制圆形的矩形区域
                        let rect = CGRect(x: point.x - 4, y: point.y - 4, width: 8, height: 8)
                        context.fill(Path(ellipseIn: rect), with: .color(AppTokens.Colors.secondary))
                    }

                    // 绘制可拖动的中心圆圈
                    let circleRect = CGRect(x: dragOffset.x - 20, y: dragOffset.y - 20, width: 40, height: 40)
                    context.stroke(Path(ellipseIn: circleRect), with: .color(AppTokens.Colors.primary), lineWidth: 3)
                }
                // Canvas 内部的 padding，对应 Kotlin 的 .padding(10.dp)
                .padding(AppTokens.Spacing.md)
                // 确保 Canvas 填充 ZStack 的所有可用空间
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                // 提示文本
                Text("Drag to locate parcel")
                    .font(AppTokens.TypographyTokens.body)
                    .foregroundColor(AppTokens.Colors.onSurface)
            }
            // 外部容器的宽度填充和固定高度，对应 Kotlin 的 .fillMaxWidth().height(300.dp)
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            // 背景颜色，对应 Kotlin 的 .background(AppTokens.Colors.surface)
            .background(AppTokens.Colors.surface)
            // 圆角，对应 Kotlin 的 AppTokens.Shapes.large
            .cornerRadius(AppTokens.Shapes.largeCornerRadius)
            // 边框，对应 Kotlin 的 .border(1.dp, AppTokens.Colors.outline, AppTokens.Shapes.large)
            // SwiftUI 的 .border 修饰符行为与 Compose 略有不同，使用 overlay + RoundedRectangle + stroke 更能精确模拟
            .overlay(
                RoundedRectangle(cornerRadius: AppTokens.Shapes.largeCornerRadius)
                    .stroke(AppTokens.Colors.outline, lineWidth: 1)
            )
            // 添加拖动手势
            .gesture(
                DragGesture()
                    .onChanged { value in
                        // 更新拖动偏移量，并限制其在 Canvas 的有效绘制区域内
                        // 20 是拖动圆圈的半径，用于确保圆圈完全在边界内
                        dragOffset = CGPoint(
                            x: max(20, min(value.location.x, effectiveCanvasWidth - 20)),
                            y: max(20, min(value.location.y, effectiveCanvasHeight - 20))
                        )
                    }
            )
            // 视图首次出现时执行的逻辑，用于初始化随机点和拖动圆圈的初始位置
            .onAppear {
                // 初始化包裹点，确保它们在 Canvas 的有效绘制区域内
                parcelPoints = generateRandomPoints(width: effectiveCanvasWidth, height: effectiveCanvasHeight)
                // 初始化拖动圆圈的初始位置，确保它也在有效绘制区域内
                dragOffset = CGPoint(
                    x: CGFloat.random(in: 20...(effectiveCanvasWidth - 20)),
                    y: CGFloat.random(in: 20...(effectiveCanvasHeight - 20))
                )
            }
        }
    }
}

// MARK: - RootScreen
// 对应 Kotlin 的 RootScreen Composable 函数
struct RootScreen: View {
    var body: some View {
        // VStack 对应 Kotlin 的 Column，用于垂直排列子视图
        VStack(spacing: AppTokens.Spacing.xl) { // 对应 Kotlin 的 Arrangement.spacedBy(AppTokens.Spacing.xl)
            Text("Parcel Tracker")
                .font(AppTokens.TypographyTokens.display) // 对应 Kotlin 的 MaterialTheme.typography.displayLarge
                .foregroundColor(AppTokens.Colors.onBackground) // 对应 Kotlin 的 AppTokens.Colors.onBackground

            // ParcelCanvas 实例
            ParcelCanvas()
                // 根据效果图，ParcelCanvas 自身不需要额外的左右 padding，
                // 而是 RootScreen 的 padding 包含了它。
                // 但为了让 ParcelCanvas 内部的 GeometryReader 正确计算宽度，
                // 且其背景和边框能与 RootScreen 的 padding 对齐，
                // 我们在 RootScreen 的 VStack 中应用了 padding，
                // 并且 ParcelCanvas 自身填充其父级可用的宽度。
                // 这里的 padding(.horizontal) 是为了让 ParcelCanvas 的内容在视觉上与 RootScreen 的文本对齐，
                // 实际在 RootScreen 的 VStack 上已经有了 AppTokens.Spacing.lg 的 padding。
                // 经过仔细比对，Kotlin 代码中 ParcelCanvas 并没有额外的 horizontal padding，
                // 而是整个 Column 有 padding。所以这里不应该有额外的 horizontal padding。
                // 让我们移除它，让 ParcelCanvas 填充 RootScreen 减去 RootScreen padding 后的宽度。
                // 重新检查 Kotlin 代码：
                // Column(modifier = Modifier.fillMaxSize().background(...).padding(AppTokens.Spacing.lg))
                // ParcelCanvas()
                // 这意味着 ParcelCanvas 内部会填充 Column 减去 padding 后的空间。
                // 因此，SwiftUI 中 ParcelCanvas 应该直接放在 VStack 中，VStack 负责 padding。

            Text("Visualize parcel movements and positions.")
                .font(AppTokens.TypographyTokens.body) // 对应 Kotlin 的 MaterialTheme.typography.bodyMedium
                .foregroundColor(AppTokens.Colors.onSurface) // 对应 Kotlin 的 AppTokens.Colors.onSurface
        }
        // 填充所有可用空间，对应 Kotlin 的 .fillMaxSize()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        // 背景渐变，对应 Kotlin 的 Brush.verticalGradient
        .background(
            LinearGradient(
                colors: [AppTokens.Colors.surfaceVariant, AppTokens.Colors.background],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        // 整个 RootScreen 的外部 padding，对应 Kotlin 的 .padding(AppTokens.Spacing.lg)
        .padding(AppTokens.Spacing.lg)
        // 忽略安全区域，使内容全屏显示，包括状态栏和导航栏下方
        .ignoresSafeArea(.all, edges: .all)
    }
}

// MARK: - ParcelTrackerApp
// SwiftUI 应用程序的入口点，对应 Kotlin 的 MainActivity
@main
struct ParcelTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                // 隐藏状态栏，对应 Kotlin 的 WindowInsetsControllerCompat.hide(WindowInsetsCompat.Type.statusBars())
                .statusBarHidden(true)
        }
    }
}