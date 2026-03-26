import SwiftUI

// MARK: - AppTokens (Translated from Kotlin)

// 辅助扩展：用于从 Kotlin 的 0xFFRRGGBBAA 格式的 UInt 值创建 SwiftUI Color
extension Color {
    init(hex: UInt) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: Double((hex >> 24) & 0xFF) / 255.0 // Kotlin colors often include alpha in the hex
        )
    }
}

struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFF7B61FF)
        static let secondary = Color(hex: 0xFF26C6DA)
        static let tertiary = Color(hex: 0xFFFF8A80)
        static let background = Color(hex: 0xFFF5F7FF)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFF0F2F8)
        static let outline = Color(hex: 0xFFE0E3EB)
        static let success = Color(hex: 0xFF22C55E)
        static let warning = Color(hex: 0xFFF59E0B)
        static let error = Color(hex: 0xFFEF4444)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFF0B1220)
        static let onTertiary = Color(hex: 0xFF0B1220)
        static let onBackground = Color(hex: 0xFF0B1220)
        static let onSurface = Color(hex: 0xFF0B1220)
    }

    struct TypographyTokens {
        // Kotlin的TextStyle直接映射到SwiftUI的Font
        static func display() -> Font { .system(size: 28, weight: .bold) }
        static func headline() -> Font { .system(size: 20, weight: .semibold) }
        static func title() -> Font { .system(size: 16, weight: .medium) }
        static func body() -> Font { .system(size: 14, weight: .regular) }
        static func label() -> Font { .system(size: 12, weight: .medium) }
    }

    struct Shapes {
        // 圆角半径直接映射为 CGFloat
        static let smallCornerRadius: CGFloat = 8
        static let mediumCornerRadius: CGFloat = 14
        static let largeCornerRadius: CGFloat = 20
    }

    struct Spacing {
        // 间距值直接映射为 CGFloat
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 32
    }

    // 阴影规范，用于 SwiftUI 的 .shadow(radius:x:y:)
    struct ShadowSpec {
        let elevation: CGFloat // Compose中的概念，SwiftUI中不直接使用此值
        let radius: CGFloat
        let dy: CGFloat
        let opacity: Double
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 6, radius: 10, dy: 6, opacity: 0.16)
        static let level3 = ShadowSpec(elevation: 10, radius: 14, dy: 8, opacity: 0.18)
    }
}

// MARK: - AppColorScheme (Mimics MaterialTheme.colorScheme)

// 创建一个结构体来模拟 Compose 的 MaterialTheme.colorScheme，方便访问主题颜色
struct AppColorScheme {
    let primary = AppTokens.Colors.primary
    let onPrimary = AppTokens.Colors.onPrimary
    let secondary = AppTokens.Colors.secondary
    let onSecondary = AppTokens.Colors.onSecondary
    let tertiary = AppTokens.Colors.tertiary
    let onTertiary = AppTokens.Colors.onTertiary
    let background = AppTokens.Colors.background
    let onBackground = AppTokens.Colors.onBackground
    let surface = AppTokens.Colors.surface
    let onSurface = AppTokens.Colors.onSurface
    let surfaceVariant = AppTokens.Colors.surfaceVariant
    let outline = AppTokens.Colors.outline
    let error = AppTokens.Colors.error
}

// MARK: - Data Models (Translated from Kotlin data classes)

struct Coupon: Identifiable {
    let id: Int
    let title: String
    let value: String
    let colorA: Color
    let colorB: Color
}

struct MapPin: Identifiable {
    let id = UUID() // SwiftUI ForEach 需要 Identifiable
    let x: CGFloat
    let y: CGFloat
    let label: String
    let tint: Color
}

// MARK: - RootScreen (Translated from Kotlin Composable)

struct RootScreen: View {
    // 实例化 AppColorScheme 以便在视图中访问主题颜色
    private var appColorScheme: AppColorScheme { AppColorScheme() }

    // 优惠券数据，直接作为常量
    let coupons: [Coupon] = [
        Coupon(id: 1, title: "Grocery Pack", value: "-$5", colorA: AppTokens.Colors.primary, colorB: AppTokens.Colors.secondary),
        Coupon(id: 2, title: "Cafe Bundle", value: "-15%", colorA: AppTokens.Colors.secondary, colorB: AppTokens.Colors.tertiary),
        Coupon(id: 3, title: "Electro Deal", value: "-$20", colorA: AppTokens.Colors.tertiary, colorB: AppTokens.Colors.primary),
        Coupon(id: 4, title: "Fashion Duo", value: "-10%", colorA: AppTokens.Colors.secondary, colorB: AppTokens.Colors.primary)
    ]

    // 地图标记数据，使用 @State 以便未来可变
    @State private var pins: [MapPin] = [
        MapPin(x: 140, y: 220, label: "A", tint: AppTokens.Colors.primary),
        MapPin(x: 320, y: 400, label: "B", tint: AppTokens.Colors.secondary),
        MapPin(x: 520, y: 300, label: "C", tint: AppTokens.Colors.tertiary)
    ]

    var body: some View {
        // ZStack 模拟 Scaffold 的背景和内容层叠
        ZStack {
            // 背景渐变，对应 Kotlin Column 的 background Brush.verticalGradient
            LinearGradient(
                gradient: Gradient(colors: [
                    AppTokens.Colors.secondary.opacity(0.25),
                    AppTokens.Colors.background,
                    AppTokens.Colors.primary.opacity(0.25)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all) // 确保渐变填充整个屏幕，包括安全区域

            // 主内容 VStack，对应 Kotlin 的 Column
            VStack(spacing: AppTokens.Spacing.lg) { // verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
                // 顶部导航栏，对应 Kotlin 的 CenterAlignedTopAppBar
                HStack {
                    // 左侧 IconButton
                    Button(action: {}) {
                        Circle()
                            .fill(appColorScheme.onSurface)
                            .frame(width: 20, height: 20) // Modifier.size(20.dp)
                    }
                    .padding(.leading, AppTokens.Spacing.lg) // 对应 IconButton 的 padding

                    Spacer() // 用于居中标题

                    // 标题 Text
                    Text("Coupon Pack")
                        .font(AppTokens.TypographyTokens.display()) // style = MaterialTheme.typography.displayLarge
                        .foregroundColor(appColorScheme.onSurface) // color = MaterialTheme.colorScheme.onSurface

                    Spacer() // 用于居中标题

                    // 右侧 IconButton
                    Button(action: {}) {
                        Circle()
                            .fill(appColorScheme.primary)
                            .frame(width: 20, height: 20) // Modifier.size(20.dp)
                    }
                    .padding(.trailing, AppTokens.Spacing.lg) // 对应 IconButton 的 padding
                }
                .padding(.top, AppTokens.Spacing.lg) // 顶部填充，确保内容不被状态栏遮挡（即使状态栏隐藏）

                // 主内容区域的 VStack
                VStack(alignment: .leading, spacing: AppTokens.Spacing.lg) {
                    // "Nearby Packs" 文本
                    Text("Nearby Packs")
                        .font(AppTokens.TypographyTokens.headline()) // style = MaterialTheme.typography.headlineMedium
                        .foregroundColor(appColorScheme.onSurface) // color = MaterialTheme.colorScheme.onSurface

                    // 地图区域 Box
                    ZStack(alignment: .topTrailing) { // Modifier.align(Alignment.TopEnd)
                        RoundedRectangle(cornerRadius: AppTokens.Shapes.largeCornerRadius) // AppTokens.Shapes.large
                            .fill(appColorScheme.surface) // background(MaterialTheme.colorScheme.surface)
                            .aspectRatio(16 / 9, contentMode: .fit) // aspectRatio(16f / 9f)
                            .overlay(
                                // Canvas 用于绘制地图和图钉
                                Canvas { context, size in
                                    // drawRect(color = AppTokens.Colors.surfaceVariant)
                                    context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(AppTokens.Colors.surfaceVariant))

                                    // 绘制地图图钉
                                    for pin in pins {
                                        // drawCircle(color = p.tint, radius = 14f, center = Offset(p.x, p.y))
                                        // SwiftUI Canvas 的 Path(ellipseIn:) 使用 CGRect，中心点为 (x+w/2, y+h/2)
                                        // 半径 14f 对应直径 28
                                        context.fill(Path(ellipseIn: CGRect(x: pin.x - 14, y: pin.y - 14, width: 28, height: 28)), with: .color(pin.tint))
                                    }
                                }
                                .padding(AppTokens.Spacing.md) // .padding(AppTokens.Spacing.md)
                            )
                            // 阴影，对应 CardDefaults.cardElevation(AppTokens.ElevationMapping.level2.elevation)
                            .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity), radius: AppTokens.ElevationMapping.level2.radius, x: 0, y: AppTokens.ElevationMapping.level2.dy)

                        // 地图上的 A B C 标签 Row
                        HStack(spacing: AppTokens.Spacing.sm) { // horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
                            Circle()
                                .fill(AppTokens.Colors.primary)
                                .frame(width: 10, height: 10) // Modifier.size(10.dp)
                            Text("A")
                                .font(AppTokens.TypographyTokens.label()) // style = MaterialTheme.typography.labelMedium
                                .foregroundColor(appColorScheme.onSurface)

                            Circle()
                                .fill(AppTokens.Colors.secondary)
                                .frame(width: 10, height: 10)
                            Text("B")
                                .font(AppTokens.TypographyTokens.label())
                                .foregroundColor(appColorScheme.onSurface)

                            Circle()
                                .fill(AppTokens.Colors.tertiary)
                                .frame(width: 10, height: 10)
                            Text("C")
                                .font(AppTokens.TypographyTokens.label())
                                .foregroundColor(appColorScheme.onSurface)
                        }
                        .padding(.horizontal, AppTokens.Spacing.md) // padding(horizontal = AppTokens.Spacing.md)
                        .padding(.vertical, AppTokens.Spacing.xs) // padding(vertical = AppTokens.Spacing.xs)
                        .background(
                            RoundedRectangle(cornerRadius: AppTokens.Shapes.smallCornerRadius) // AppTokens.Shapes.small
                                .fill(appColorScheme.surface.opacity(0.9)) // background(MaterialTheme.colorScheme.surface.copy(alpha = 0.9f))
                        )
                        .padding(AppTokens.Spacing.md) // 确保这个浮动框在地图内部有间距
                    }

                    // "Your Coupon Packs" 文本
                    Text("Your Coupon Packs")
                        .font(AppTokens.TypographyTokens.headline())
                        .foregroundColor(appColorScheme.onSurface)

                    // 优惠券 LazyRow
                    ScrollView(.horizontal, showsIndicators: false) { // LazyRow
                        LazyHStack(spacing: AppTokens.Spacing.lg) { // horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
                            ForEach(coupons) { coupon in // items(coupons)
                                // Card 结构
                                ZStack {
                                    // 卡片背景和阴影
                                    RoundedRectangle(cornerRadius: AppTokens.Shapes.largeCornerRadius) // AppTokens.Shapes.large
                                        .fill(appColorScheme.surface) // containerColor = MaterialTheme.colorScheme.surface
                                        .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity), radius: AppTokens.ElevationMapping.level2.radius, x: 0, y: AppTokens.ElevationMapping.level2.dy) // elevation = CardDefaults.cardElevation(AppTokens.ElevationMapping.level2.elevation)

                                    // 卡片内容 VStack
                                    VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) { // verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
                                        HStack(spacing: AppTokens.Spacing.sm) { // horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
                                            Circle()
                                                .fill(appColorScheme.primary) // background(MaterialTheme.colorScheme.primary)
                                                .frame(width: 14, height: 14) // Modifier.size(14.dp)
                                            Text(coupon.title)
                                                .font(AppTokens.TypographyTokens.title()) // style = MaterialTheme.typography.titleMedium
                                                .foregroundColor(appColorScheme.onSurface)
                                        }
                                        Text(coupon.value)
                                            .font(AppTokens.TypographyTokens.display()) // style = MaterialTheme.typography.displayLarge
                                            .foregroundColor(appColorScheme.onSurface)
                                        // 兑换按钮
                                        Button(action: {}) {
                                            Text("Redeem")
                                                .font(AppTokens.TypographyTokens.label()) // style = MaterialTheme.typography.labelMedium
                                                .frame(maxWidth: .infinity) // Modifier.fillMaxWidth()
                                                .frame(height: 40) // Modifier.height(40.dp)
                                                .background(appColorScheme.primary) // containerColor = MaterialTheme.colorScheme.primary
                                                .foregroundColor(appColorScheme.onPrimary) // contentColor = MaterialTheme.colorScheme.onPrimary
                                                .cornerRadius(AppTokens.Shapes.mediumCornerRadius) // shape = AppTokens.Shapes.medium
                                        }
                                    }
                                    .padding(AppTokens.Spacing.lg) // .padding(AppTokens.Spacing.lg)
                                    .background(
                                        // 卡片内部渐变背景
                                        LinearGradient(
                                            gradient: Gradient(colors: [coupon.colorA.opacity(0.18), coupon.colorB.opacity(0.18)]), // Brush.horizontalGradient(...)
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .cornerRadius(AppTokens.Shapes.largeCornerRadius) // 确保渐变背景也应用相同的圆角
                                }
                                .frame(width: 200, height: 140) // Modifier.size(200.dp, 140.dp)
                            }
                        }
                        .padding(.horizontal, AppTokens.Spacing.xs) // contentPadding = PaddingValues(horizontal = AppTokens.Spacing.xs)
                    }

                    // 底部 Spacer
                    Spacer(minLength: AppTokens.Spacing.sm) // Modifier.height(AppTokens.Spacing.sm)

                    // 底部两个按钮的 Row
                    HStack(spacing: AppTokens.Spacing.md) { // horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
                        // "My Coupons" 按钮
                        Button(action: {}) {
                            Text("My Coupons")
                                .font(AppTokens.TypographyTokens.title()) // style = MaterialTheme.typography.titleMedium
                                .frame(maxWidth: .infinity) // Modifier.weight(1f)
                                .frame(height: 52) // Modifier.height(52.dp)
                                .background(appColorScheme.secondary) // containerColor = MaterialTheme.colorScheme.secondary
                                .foregroundColor(appColorScheme.onSecondary) // contentColor = MaterialTheme.colorScheme.onSecondary
                                .cornerRadius(AppTokens.Shapes.largeCornerRadius) // shape = AppTokens.Shapes.large
                        }
                        // "Explore More" 按钮
                        Button(action: {}) {
                            Text("Explore More")
                                .font(AppTokens.TypographyTokens.title()) // style = MaterialTheme.typography.titleMedium
                                .frame(maxWidth: .infinity) // Modifier.weight(1f)
                                .frame(height: 52) // Modifier.height(52.dp)
                                .background(appColorScheme.primary) // containerColor = MaterialTheme.colorScheme.primary
                                .foregroundColor(appColorScheme.onPrimary) // contentColor = MaterialTheme.colorScheme.onPrimary
                                .cornerRadius(AppTokens.Shapes.largeCornerRadius) // shape = AppTokens.Shapes.large
                        }
                    }
                }
                .padding(.horizontal, AppTokens.Spacing.lg) // Modifier.padding(AppTokens.Spacing.lg)
            }
        }
        .edgesIgnoringSafeArea(.all) // 确保整个视图内容忽略安全区域，实现全屏
        .statusBarHidden(true) // 隐藏顶部状态栏
    }
}

// MARK: - App Entry Point (@main)

// SwiftUI 应用的入口点
@main
struct CouponPackApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}

// MARK: - Preview (Xcode Canvas Preview)

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
            // 设置背景色以匹配 Kotlin Preview 的 backgroundColor
            .background(AppTokens.Colors.background)
            .edgesIgnoringSafeArea(.all) // 预览时也忽略安全区域
    }
}