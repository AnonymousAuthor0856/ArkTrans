import SwiftUI

// MARK: - AppTokens (Design System)

// 定义应用的设计系统，便于集中管理和修改
struct AppTokens {
    // 颜色定义
    struct Colors {
        static let primary = Color(red: 33/255, green: 78/255, blue: 52/255)
        static let secondary = Color(red: 45/255, green: 106/255, blue: 79/255)
        static let tertiary = Color(red: 108/255, green: 117/255, blue: 125/255)
        static let background = Color(red: 248/255, green: 241/255, blue: 229/255)
        static let surface = Color(red: 255/255, green: 251/255, blue: 240/255)
        static let surfaceVariant = Color(red: 233/255, green: 223/255, blue: 199/255)
        static let outline = Color(red: 210/255, green: 198/255, blue: 170/255)
        static let success = Color(red: 43/255, green: 147/255, blue: 72/255)
        static let warning = Color(red: 244/255, green: 162/255, blue: 97/255)
        static let error = Color(red: 214/255, green: 40/255, blue: 40/255)
        static let onPrimary = Color(red: 255/255, green: 255/255, blue: 255/255)
        static let onSecondary = Color(red: 255/255, green: 255/255, blue: 255/255)
        static let onTertiary = Color(red: 27/255, green: 31/255, blue: 34/255)
        static let onBackground = Color(red: 27/255, green: 31/255, blue: 34/255)
        static let onSurface = Color(red: 27/255, green: 31/255, blue: 34/255)
    }

    // 字体定义
    struct TypographyTokens {
        // SwiftUI 的 Font 不直接支持 lineHeight 和 letterSpacing，
        // 但可以通过系统默认行为或进一步的 Text 修饰符来近似。
        // 对于 letterSpacing = 0.sp，无需特殊处理。
        static let display = Font.system(size: 26, weight: .semibold)
        static let headline = Font.system(size: 20, weight: .medium)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 13, weight: .regular)
        static let label = Font.system(size: 11, weight: .medium)
    }

    // 形状定义
    struct Shapes {
        static let small = RoundedRectangle(cornerRadius: 6)
        static let medium = RoundedRectangle(cornerRadius: 10)
        static let large = RoundedRectangle(cornerRadius: 14)
    }

    // 间距定义
    struct Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 20
        static let xxl: CGFloat = 28
        static let xxxl: CGFloat = 40
    }

    // 阴影规格定义
    struct ShadowSpec {
        let elevation: CGFloat // 在 SwiftUI 中，这通常映射到 shadow 的 radius
        let radius: CGFloat    // 在 SwiftUI 中，这通常映射到 shadow 的 radius
        let dy: CGFloat        // 垂直偏移
        let opacity: Double    // 阴影颜色透明度
    }

    // 阴影映射
    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 1, radius: 3, dy: 1, opacity: 0.10)
        static let level2 = ShadowSpec(elevation: 3, radius: 6, dy: 3, opacity: 0.14)
        static let level3 = ShadowSpec(elevation: 6, radius: 10, dy: 5, opacity: 0.16)
        static let level4 = ShadowSpec(elevation: 10, radius: 14, dy: 7, opacity: 0.18)
        static let level5 = ShadowSpec(elevation: 14, radius: 18, dy: 9, opacity: 0.20)
    }
}

// MARK: - AppTheme (Environment Values)

// SwiftUI 中没有直接的 MaterialTheme，我们通过 EnvironmentValues 来模拟
// 定义 AppColorScheme 结构体，持有所有颜色
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
    let success = AppTokens.Colors.success // 添加 success 和 warning
    let warning = AppTokens.Colors.warning
}

// 定义 AppTypography 结构体，持有所有字体
struct AppTypography {
    let displayLarge = AppTokens.TypographyTokens.display
    let headlineMedium = AppTokens.TypographyTokens.headline
    let titleMedium = AppTokens.TypographyTokens.title
    let bodyMedium = AppTokens.TypographyTokens.body
    let labelMedium = AppTokens.TypographyTokens.label
}

// 定义 AppShapes 结构体，持有所有形状
struct AppShapes {
    let small = AppTokens.Shapes.small
    let medium = AppTokens.Shapes.medium
    let large = AppTokens.Shapes.large
}

// 为 AppColorScheme 创建 EnvironmentKey
struct AppColorSchemeKey: EnvironmentKey {
    static let defaultValue: AppColorScheme = AppColorScheme()
}

// 为 AppTypography 创建 EnvironmentKey
struct AppTypographyKey: EnvironmentKey {
    static let defaultValue: AppTypography = AppTypography()
}

// 为 AppShapes 创建 EnvironmentKey
struct AppShapesKey: EnvironmentKey {
    static let defaultValue: AppShapes = AppShapes()
}

// 扩展 EnvironmentValues，以便通过 .environment(\.appColorScheme, ...) 访问
extension EnvironmentValues {
    var appColorScheme: AppColorScheme {
        get { self[AppColorSchemeKey.self] }
        set { self[AppColorSchemeKey.self] = newValue }
    }
    var appTypography: AppTypography {
        get { self[AppTypographyKey.self] }
        set { self[AppTypographyKey.self] = newValue }
    }
    var appShapes: AppShapes {
        get { self[AppShapesKey.self] }
        set { self[AppShapesKey.self] = newValue }
    }
}

// View 扩展，方便应用自定义主题
extension View {
    func appTheme() -> some View {
        self
            .environment(\.appColorScheme, AppColorScheme())
            .environment(\.appTypography, AppTypography())
            .environment(\.appShapes, AppShapes())
    }
}

// MARK: - Data Models

// 股票日历中的日期标签数据模型
struct DayTab: Identifiable {
    let id: Int
    let label: String
}

// 股票行数据模型，需要 Identifiable 以便在 ForEach 中使用
struct StockRow: Identifiable {
    let id = UUID() // SwiftUI 需要 Identifiable 协议的 id 属性
    let code: String
    let name: String
    let price: String
    let change: String
    let positive: Bool
}

// MARK: - Custom Components (模拟 Material Design 3 组件)

// 模拟 Compose 的 Card 组件
struct CustomCard<Content: View>: View {
    let shape: RoundedRectangle
    let containerColor: Color
    let elevation: AppTokens.ShadowSpec
    let borderStroke: (width: CGFloat, color: Color)?
    let content: Content

    init(shape: RoundedRectangle, containerColor: Color, elevation: AppTokens.ShadowSpec, borderStroke: (width: CGFloat, color: Color)? = nil, @ViewBuilder content: () -> Content) {
        self.shape = shape
        self.containerColor = containerColor
        self.elevation = elevation
        self.borderStroke = borderStroke
        self.content = content()
    }

    var body: some View {
        content
            .background(containerColor)
            .clipShape(shape)
            // 模拟 Compose 的 elevation 阴影
            .shadow(color: Color.black.opacity(elevation.opacity), radius: elevation.radius, x: 0, y: elevation.dy)
            .overlay(
                shape.stroke(borderStroke?.color ?? .clear, lineWidth: borderStroke?.width ?? 0)
            )
    }
}

// 模拟 Compose 的 FilterChip 组件
struct CustomFilterChip: View {
    @Environment(\.appColorScheme) var colorScheme
    @Environment(\.appTypography) var typography
    @Environment(\.appShapes) var shapes

    let selected: Bool
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(typography.labelMedium)
                .foregroundColor(selected ? colorScheme.onPrimary : colorScheme.onSurface)
                .padding(.horizontal, AppTokens.Spacing.md)
                .padding(.vertical, AppTokens.Spacing.sm)
                .background(selected ? colorScheme.secondary : colorScheme.surface)
                .clipShape(shapes.small)
                .overlay(
                    shapes.small.stroke(colorScheme.outline, lineWidth: 1)
                )
        }
    }
}

// MARK: - RootScreen View (主 UI 界面)

struct RootScreen: View {
    // 从环境中获取自定义主题值
    @Environment(\.appColorScheme) var colorScheme
    @Environment(\.appTypography) var typography
    @Environment(\.appShapes) var shapes

    // 状态管理，使用 @State 模拟 Compose 的 remember { mutableStateOf(...) }
    let days = [
        DayTab(id: 1, label: "Mon"),
        DayTab(id: 2, label: "Tue"),
        DayTab(id: 3, label: "Wed"),
        DayTab(id: 4, label: "Thu"),
        DayTab(id: 5, label: "Fri")
    ]
    @State private var selectedDayId: Int = 1

    let sectors = ["All", "Tech", "Energy", "Finance"]
    @State private var currentSector: String = "All"

    let items = [
        StockRow(code: "600519", name: "Kweichow Moutai", price: "1687.3", change: "+1.24%", positive: true),
        StockRow(code: "000001", name: "Ping An Bank", price: "12.54", change: "-0.62%", positive: false),
        StockRow(code: "300750", name: "CATL", price: "192.8", change: "+0.87%", positive: true),
        StockRow(code: "601318", name: "Ping An Ins.", price: "44.2", change: "-1.12%", positive: false),
        StockRow(code: "600036", name: "CMBC", price: "36.9", change: "+0.15%", positive: true),
        StockRow(code: "688981", name: "SMIC", price: "56.4", change: "-0.48%", positive: false)
    ]

    var body: some View {
        // ZStack 模拟 Scaffold 的背景色和内容层叠
        ZStack {
            colorScheme.background.ignoresSafeArea(.all) // 背景色并全屏显示

            VStack(spacing: 0) { // 模拟 Scaffold 的 TopBar + Content 结构
                // 顶部应用栏 (CenterAlignedTopAppBar)
                HStack {
                    Spacer()
                    Text("Stock Calendar")
                        .font(typography.displayLarge)
                        .foregroundColor(colorScheme.onSurface)
                    Spacer()
                }
                .padding(.vertical, 40) // 垂直方向的 padding
                .background(colorScheme.background) // TopBar 的背景色

                // 主要内容区域，使用 ScrollView 模拟 LazyColumn
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: AppTokens.Spacing.md) {
                        // 日期选择和行业筛选卡片
                        CustomCard(
                            shape: shapes.large,
                            containerColor: colorScheme.surface,
                            elevation: AppTokens.ElevationMapping.level2,
                            borderStroke: (width: 1, color: colorScheme.outline)
                        ) {
                            VStack(spacing: AppTokens.Spacing.md) {
                                HStack(spacing: AppTokens.Spacing.md) {
                                    ForEach(days) { d in
                                        let active = d.id == selectedDayId
                                        Button(action: {
                                            selectedDayId = d.id
                                        }) {
                                            Text(d.label)
                                                .font(active ? typography.titleMedium : typography.bodyMedium)
                                                .foregroundColor(active ? colorScheme.onPrimary : colorScheme.onSurface)
                                                .frame(maxWidth: .infinity, minHeight: 36) // Modifier.weight(1f).height(36.dp)
                                                .background(active ? colorScheme.primary : colorScheme.surfaceVariant)
                                                .clipShape(shapes.small)
                                        }
                                    }
                                }

                                HStack(spacing: AppTokens.Spacing.sm) {
                                    ForEach(sectors, id: \.self) { s in // \.self 用于 String 数组作为 Identifiable
                                        CustomFilterChip(selected: currentSector == s, label: s) {
                                            currentSector = s
                                        }
                                    }
                                    Spacer() // 使 FilterChip 靠左排列
                                }
                            }
                            .padding(AppTokens.Spacing.md) // Column(modifier = Modifier.padding(AppTokens.Spacing.md))
                        }

                        // 股票列表
                        VStack(spacing: AppTokens.Spacing.sm) { // verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
                            ForEach(items) { item in
                                CustomCard(
                                    shape: shapes.medium,
                                    containerColor: colorScheme.surface,
                                    elevation: AppTokens.ElevationMapping.level1,
                                    borderStroke: (width: 1, color: colorScheme.outline)
                                ) {
                                    HStack(alignment: .center) { // verticalAlignment = Alignment.CenterVertically
                                        HStack(spacing: AppTokens.Spacing.md) { // horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
                                            shapes.small
                                                .fill(colorScheme.surfaceVariant)
                                                .frame(width: 28, height: 28) // size(28.dp)

                                            VStack(alignment: .leading, spacing: AppTokens.Spacing.xs) { // verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)
                                                Text(item.name)
                                                    .font(typography.titleMedium)
                                                    .foregroundColor(colorScheme.onSurface)
                                                Text(item.code)
                                                    .font(typography.labelMedium)
                                                    .foregroundColor(colorScheme.onSurface)
                                            }
                                        }

                                        Spacer() // horizontalArrangement = Arrangement.SpaceBetween

                                        HStack(spacing: AppTokens.Spacing.lg) { // horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
                                            VStack(alignment: .trailing) { // horizontalAlignment = Alignment.End
                                                Text(item.price)
                                                    .font(typography.titleMedium)
                                                    .foregroundColor(colorScheme.onSurface)
                                                HStack(spacing: AppTokens.Spacing.xs) { // horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)
                                                    shapes.small
                                                        .fill(item.positive ? colorScheme.success : colorScheme.error)
                                                        .frame(width: 8, height: 8) // size(8.dp, 8.dp)
                                                    Text(item.change)
                                                        .font(typography.labelMedium)
                                                        .foregroundColor(item.positive ? colorScheme.success : colorScheme.error)
                                                }
                                            }

                                            Button(action: {}) {
                                                Text("Detail")
                                                    .font(typography.labelMedium)
                                                    .foregroundColor(colorScheme.onPrimary)
                                                    .frame(width: 76, height: 36) // height(36.dp).width(76.dp)
                                                    .background(colorScheme.primary)
                                                    .clipShape(shapes.small)
                                            }
                                        }
                                    }
                                    .padding(AppTokens.Spacing.md) // Modifier.padding(AppTokens.Spacing.md)
                                    .frame(minHeight: 72) // heightIn(min = 72.dp)
                                }
                            }
                        }
                    }
                    // Column(modifier = Modifier.fillMaxSize().padding(padding).padding(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.md))
                    // contentPadding = PaddingValues(bottom = AppTokens.Spacing.xxxl)
                    .padding(.horizontal, AppTokens.Spacing.lg)
                    .padding(.vertical, AppTokens.Spacing.md)
                    .padding(.bottom, AppTokens.Spacing.xxxl)
                }
            }
        }
        .statusBarHidden(true) // 要求2: 隐藏顶部状态栏
    }
}

// MARK: - App Entry Point

// Swift UI 的应用入口，对应 Android 的 MainActivity
@main
struct StockCalendarApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                .appTheme() // 应用自定义主题
        }
    }
}

// MARK: - Preview (预览功能)

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
            .appTheme() // 预览时也应用主题
    }
}
