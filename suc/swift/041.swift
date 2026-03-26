
import SwiftUI

// MARK: - AppTokens (Equivalent to Kotlin's AppTokens object)
// 集中管理应用的设计系统代币，方便统一修改和维护。
struct AppTokens {
    struct Colors {
        // 使用十六进制初始化器创建颜色，保持与 Kotlin 代码的颜色值一致。
        static let primary = Color(hex: 0xFF111111)
        static let secondary = Color(hex: 0xFF333333)
        static let tertiary = Color(hex: 0xFF777777)
        static let background = Color(hex: 0xFFFFFFFF)
        static let surface = Color(hex: 0xFFF9F9F9)
        static let surfaceVariant = Color(hex: 0xFFE5E5E5)
        static let outline = Color(hex: 0xFFCCCCCC)
        static let success = Color(hex: 0xFF16A34A)
        static let warning = Color(hex: 0xFFF59E0B)
        static let error = Color(hex: 0xFFDC2626)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFFFFFFFF)
        static let onTertiary = Color(hex: 0xFF111111)
        static let onBackground = Color(hex: 0xFF111111)
        static let onSurface = Color(hex: 0xFF111111)
    }

    struct TypographyTokens {
        // 定义字体样式，直接映射 Kotlin 的 fontSize 和 fontWeight。
        static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) // FontWeight.Normal 对应 SwiftUI 的 .regular
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        // 定义圆角半径，直接映射 Kotlin 的 Dp 值。
        static let smallCornerRadius: CGFloat = 6
        static let mediumCornerRadius: CGFloat = 10
        static let largeCornerRadius: CGFloat = 14
    }

    struct Spacing {
        // 定义间距值，直接映射 Kotlin 的 Dp 值。
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 32
    }

    // 阴影规范，用于将 Compose 的阴影参数映射到 SwiftUI。
    // SwiftUI 的 shadow 接受 radius (模糊半径) 和 x, y (偏移)。
    struct ShadowSpec {
        let elevation: CGFloat // Compose 中的 elevation，在 SwiftUI 中主要影响阴影强度或模糊，这里作为参考值。
        let radius: CGFloat // 阴影的模糊半径，直接对应 SwiftUI 的 radius。
        let dy: CGFloat // 阴影的 Y 轴偏移，直接对应 SwiftUI 的 y。
        let opacity: Double // 阴影的透明度。
    }

    struct ElevationMapping {
        // 将 Compose 的阴影级别映射到 SwiftUI 的 shadow 修饰符。
        // level2 = ShadowSpec(4.dp, 8.dp, 4.dp, 0.12f)
        // 对应 SwiftUI: .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.1)
        static let level2 = ShadowSpec(elevation: 4, radius: 8, dy: 4, opacity: 0.12)
        static let level3 = ShadowSpec(elevation: 8, radius: 12, dy: 6, opacity: 0.15)
    }
}

// MARK: - Color Extension for Hex Initialization
// 扩展 Color 结构体，使其可以通过十六进制值初始化，方便颜色管理。
extension Color {
    init(hex: UInt) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: Double((hex >> 24) & 0xFF) / 255.0 // 支持带 Alpha 值的十六进制
        )
    }
}

// MARK: - Marker Data Model
// 对应 Kotlin 的 Marker 数据类，在 SwiftUI 中需要遵循 Identifiable 协议以便在 ForEach 中使用。
struct Marker: Identifiable {
    let id = UUID() // 唯一标识符，用于 ForEach 识别元素。
    var x: CGFloat
    var y: CGFloat
    let label: String
}

// MARK: - RootScreen View (Equivalent to Kotlin's RootScreen Composable)
// 主 UI 视图，将 Kotlin 的 Composable 结构翻译为 SwiftUI 的 View 结构。
struct RootScreen: View {
    // 使用 @State 包装器管理可变状态，对应 Kotlin 的 remember { mutableStateListOf(...) }。
    @State private var markers: [Marker] = [
        Marker(x: 120, y: 200, label: "Store A"),
        Marker(x: 360, y: 400, label: "Store B")
    ]

    var body: some View {
        // 对应 Kotlin 的 Scaffold，使用 ZStack 作为根容器，并忽略安全区域以实现全屏背景。
        ZStack {
            AppTokens.Colors.background
                .ignoresSafeArea() // 确保背景色填充整个屏幕，包括状态栏和底部安全区域。

            // 主内容区域，使用 VStack 垂直排列，并设置间距和外边距。
            VStack(alignment: .leading, spacing: AppTokens.Spacing.lg) {
                Text("Product Detail")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.primary)

                // 产品信息卡片，对应 Kotlin 的 Card。
                // 在 SwiftUI 中，通过背景色、圆角和阴影修饰符来模拟 Card 的效果。
                VStack(alignment: .leading, spacing: AppTokens.Spacing.md) {
                    // 图片占位符，对应 Kotlin 的 Box with background。
                    Rectangle()
                        .fill(AppTokens.Colors.surfaceVariant)
                        .frame(maxWidth: .infinity) // 对应 fillMaxWidth()
                        .frame(height: 160) // 对应 height(160.dp)

                    Text("Monochrome Bag")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)

                    Text("A minimalist and timeless design piece.")
                        .font(AppTokens.TypographyTokens.body)
                        .foregroundColor(AppTokens.Colors.tertiary)

                    Text("$79.00")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.primary)

                    // "Add to Cart" 按钮
                    Button(action: {
                        // 处理添加到购物车操作
                        print("Add to Cart tapped!")
                    }) {
                        Text("Add to Cart")
                            .font(AppTokens.TypographyTokens.title)
                            .frame(maxWidth: .infinity) // 对应 fillMaxWidth()
                            .frame(height: 48) // 对应 height(48.dp)
                            .background(AppTokens.Colors.primary)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .cornerRadius(AppTokens.Shapes.mediumCornerRadius) // 对应 shape = AppTokens.Shapes.medium
                    }
                }
                .padding(AppTokens.Spacing.lg) // 对应 Card 内部的 padding
                .background(AppTokens.Colors.surface) // 对应 Card 的 containerColor
                .cornerRadius(AppTokens.Shapes.largeCornerRadius) // 对应 Card 的 shape
                // 阴影效果，根据 AppTokens.ElevationMapping.level2 进行映射。
                .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity),
                        radius: AppTokens.ElevationMapping.level2.radius,
                        x: 0, // Compose 默认 x 偏移为 0
                        y: AppTokens.ElevationMapping.level2.dy)

                // 地图区域，包含 Canvas 绘制，对应 Kotlin 的 Box with Canvas。
                ZStack {
                    // 背景和圆角，对应 Box 的 background(AppTokens.Colors.surface, AppTokens.Shapes.large)
                    RoundedRectangle(cornerRadius: AppTokens.Shapes.largeCornerRadius)
                        .fill(AppTokens.Colors.surface)

                    // SwiftUI 的 Canvas，用于自定义绘制，对应 Kotlin 的 Canvas。
                    Canvas { context, size in
                        // 绘制背景矩形，对应 Kotlin Canvas 内部的 drawRect。
                        context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(AppTokens.Colors.surfaceVariant))

                        // 绘制标记点，对应 Kotlin Canvas 内部的 markers.forEach { drawCircle(...) }。
                        for marker in markers {
                            let center = CGPoint(x: marker.x, y: marker.y)
                            let path = Path { p in
                                p.addArc(center: center, radius: 14, startAngle: .zero, endAngle: .degrees(360), clockwise: true)
                            }
                            context.fill(path, with: .color(AppTokens.Colors.primary))
                        }
                    }
                    .padding(AppTokens.Spacing.lg) // 对应 Kotlin Canvas 修饰符上的 padding。
                }
                .frame(maxWidth: .infinity) // 对应 fillMaxWidth()
                .frame(height: 240) // 对应 height(240.dp)

                // 底部操作按钮行，对应 Kotlin 的 Row。
                HStack(spacing: AppTokens.Spacing.md) { // 对应 Arrangement.spacedBy(AppTokens.Spacing.md)
                    // "Add Marker" 按钮
                    Button(action: {
                        // 随机生成新的标记点位置，对应 Kotlin 的 Random.nextInt。
                        markers.append(
                            Marker(
                                x: CGFloat.random(in: 100...500),
                                y: CGFloat.random(in: 150...450),
                                label: "New"
                            )
                        )
                    }) {
                        Text("Add Marker")
                            .font(AppTokens.TypographyTokens.label)
                            .frame(maxWidth: .infinity) // 对应 Modifier.weight(1f)，使其占据可用宽度。
                            .frame(height: 44) // 对应 height(44.dp)
                            .background(AppTokens.Colors.secondary) // 对应 containerColor
                            .foregroundColor(AppTokens.Colors.onSecondary) // 对应 contentColor
                            .cornerRadius(AppTokens.Shapes.mediumCornerRadius) // 对应 shape
                    }

                    // "Clear" 按钮
                    Button(action: {
                        markers.removeAll() // 清除所有标记点
                    }) {
                        Text("Clear")
                            .font(AppTokens.TypographyTokens.label)
                            .frame(maxWidth: .infinity) // 对应 Modifier.weight(1f)
                            .frame(height: 44) // 对应 height(44.dp)
                            .background(AppTokens.Colors.tertiary) // 对应 containerColor
                            .foregroundColor(AppTokens.Colors.onTertiary) // 对应 contentColor
                            .cornerRadius(AppTokens.Shapes.mediumCornerRadius) // 对应 shape
                    }
                }
            }
            .padding(AppTokens.Spacing.lg) // 对应 Column 外部的 padding
        }
    }
}

// MARK: - App Entry Point (Equivalent to MainActivity)
// SwiftUI 应用的入口点，对应 Kotlin 的 MainActivity。
@main
struct ProductDetailApp: App {
    // 构造器，用于进行一些应用级别的设置。
    init() {
        // 要求 2: App 必须设置为全屏显示，并确保顶部状态栏隐藏。
        // 在 SwiftUI 中，隐藏状态栏的最佳实践是：
        // 1. 在项目的 Info.plist 文件中，将 "View controller-based status bar appearance" 设置为 NO。
        // 2. 在您的根视图上使用 .prefersStatusBarHidden(true) 修饰符。
        // 此处的 init() 仅为说明，实际隐藏由 .prefersStatusBarHidden(true) 和 Info.plist 共同完成。
    }

    var body: some Scene {
        WindowGroup {
            RootScreen()
                .prefersStatusBarHidden(true) // 隐藏状态栏，符合要求 2。
        }
    }
}

// MARK: - Preview Provider (Equivalent to @Preview)
// SwiftUI 的预览提供器，方便在 Xcode 中查看 UI 效果。
struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
            .previewDisplayName("Product Detail Screen") // 预览名称
    }
}
