
import SwiftUI

// MARK: - Color Extension for Hex Initialization
// 允许使用十六进制值初始化颜色，与 Kotlin 的 Color(0xFF...) 对应
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

// MARK: - AppTokens
// 对应 Kotlin 中的 AppTokens 对象，定义了颜色、字体、间距、形状和阴影
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
        // 使用系统字体，直接映射 Compose 的 TextStyle
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
        let elevation: CGFloat // 对应 SwiftUI shadow 的 blur radius
        let radius: CGFloat // 在 SwiftUI shadow 中不直接使用，elevation 承担主要作用
        let dy: CGFloat // 对应 SwiftUI shadow 的 y 偏移
        let opacity: Double
    }

    struct ElevationMapping {
        // Compose 的 elevation 映射到 SwiftUI shadow 的 radius (模糊半径) 和 y 偏移
        static let level1 = ShadowSpec(elevation: 2.0, radius: 4.0, dy: 2.0, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 4.0, radius: 8.0, dy: 4.0, opacity: 0.16)
    }
}

// MARK: - RootScreen 对应的 SwiftUI 视图
struct RootScreen: View {
    @State private var points: [CGPoint] = [] // 存储绘制点的数组
    @State private var currentColor: Color = AppTokens.Colors.primary // 当前绘制颜色
    
    // 定义控件尺寸，以实现原子级对应
    let buttonHeight: CGFloat = 44.0 // 底部颜色按钮的高度，根据 Android Material3 默认按钮文本大小和垂直内边距估算
    let fabSize: CGFloat = 56.0 // 标准 Material Design Floating Action Button 尺寸
    let circleRadius: CGFloat = 10.0 // 绘制圆点的半径

    // 计算顶部栏的实际高度，用于内容区域的内边距
    var topBarActualHeight: CGFloat {
        // 字体大小 26pt，近似行高 30pt。加上 2 倍垂直内边距 (AppTokens.Spacing.md = 12pt)
        return 30.0 + (2 * AppTokens.Spacing.md) // 30 + 2*12 = 54
    }
    
    // 计算底部栏的实际高度，用于内容区域的内边距
    var bottomBarActualHeight: CGFloat {
        // 按钮高度 (44pt) 加上 2 倍垂直内边距 (AppTokens.Spacing.md = 12pt)
        return buttonHeight + (2 * AppTokens.Spacing.md) // 44 + 2*12 = 68
    }
    
    // FAB 距离屏幕底部的内边距
    var fabBottomMargin: CGFloat {
        return AppTokens.Spacing.xl // 24pt
    }
    
    // 绘制画布的底部内边距，需考虑底部栏和 FAB 中占据空间较大的一个
    var canvasBottomPadding: CGFloat {
        // Compose Scaffold 的内容区域内边距会取底部栏高度和 FAB 底部边缘位置的最大值
        // FAB 底部边缘位置 = FAB 尺寸 + FAB 距离屏幕底部边距 = 56 + 24 = 80
        // 所以取 max(底部栏实际高度, FAB 底部边缘位置) = max(68, 80) = 80
        return max(bottomBarActualHeight, fabSize + fabBottomMargin)
    }
    
    var body: some View {
        ZStack {
            // 1. 背景色：填充整个屏幕，包括状态栏区域
            AppTokens.Colors.background
                .ignoresSafeArea()

            // 2. 绘制画布区域：用户在此区域进行绘制
            Canvas { context, size in
                for point in points {
                    let rect = CGRect(x: point.x - circleRadius, y: point.y - circleRadius, width: circleRadius * 2, height: circleRadius * 2)
                    context.fill(Path(ellipseIn: rect), with: .color(currentColor))
                }
            }
            // 拖动手势识别，用于在画布上添加点
            .gesture(
                DragGesture(minimumDistance: 0) // minimumDistance: 0 意味着即使是点击也会触发 onChanged
                    .onChanged { value in
                        // `value.location` 是相对于 Canvas 视图左上角的坐标。
                        // 由于 Canvas 视图本身被内边距推移，其坐标系已与 Compose 的 `padding(pad)` 后的 `pointerInput` 行为一致。
                        points.append(value.location)
                    }
            )
            // 为 Canvas 视图应用内边距，以避开顶部栏、底部栏和 FAB 占据的区域
            .padding(.top, topBarActualHeight)
            .padding(.bottom, canvasBottomPadding)

            // 3. 顶部栏
            VStack {
                Text("Retro Whiteboard")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.onSurface)
                    .padding(.vertical, AppTokens.Spacing.md) // 标题的垂直内边距
                    .frame(maxWidth: .infinity) // 使文本水平居中
                    .background(AppTokens.Colors.background) // 顶部栏背景色
            }
            .frame(maxHeight: .infinity, alignment: .top) // 将 VStack 对齐到 ZStack 的顶部

            // 4. 底部颜色选择栏
            VStack {
                Spacer() // 将 HStack 推到 ZStack 的底部
                HStack(spacing: AppTokens.Spacing.md) { // 按钮之间的间距
                    Spacer() // 用于实现 SpaceEvenly 效果
                    Button(action: { currentColor = AppTokens.Colors.primary }) {
                        Text("Red")
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .frame(minWidth: 0, maxWidth: .infinity) // 允许按钮水平填充可用空间
                            .frame(height: buttonHeight) // 固定按钮高度
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
                .padding(AppTokens.Spacing.md) // 底部栏内部，按钮 HStack 的内边距
                .background(AppTokens.Colors.surface) // 底部栏背景色
                .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity),
                        radius: AppTokens.ElevationMapping.level1.elevation, // 模糊半径
                        x: 0, y: AppTokens.ElevationMapping.level1.dy) // Y 轴偏移
            }
            .frame(maxHeight: .infinity, alignment: .bottom) // 将 VStack 对齐到 ZStack 的底部

            // 5. 浮动操作按钮 (Floating Action Button) - 清除画布
            VStack {
                Spacer() // 将 HStack 推到 ZStack 的底部
                HStack {
                    Spacer() // 将 Button 推到 HStack 的右侧 (trailing)
                    Button(action: { points.removeAll() }) { // 清除所有绘制点
                        Text("Clear")
                            .font(AppTokens.TypographyTokens.label)
                            .foregroundColor(AppTokens.Colors.onSecondary)
                            .frame(width: fabSize, height: fabSize) // 固定 FAB 尺寸
                            .background(AppTokens.Colors.secondary)
                            .clipShape(Circle()) // 圆形剪裁
                            .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity),
                                    radius: AppTokens.ElevationMapping.level1.elevation,
                                    x: 0, y: AppTokens.ElevationMapping.level1.dy)
                    }
                    .padding(.trailing, AppTokens.Spacing.xl) // FAB 右侧内边距
                    .padding(.bottom, fabBottomMargin) // FAB 底部内边距
                }
            }
            .frame(maxHeight: .infinity, alignment: .bottom) // 将 VStack 对齐到 ZStack 的底部
        }
        .statusBarHidden(true) // 隐藏整个视图的状态栏 (iOS 16.0 兼容)
    }
}

// MARK: - 主应用结构
// @main 入口点，使应用可直接运行
@main
struct RetroWhiteboardApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}