import SwiftUI

// MARK: - AppTokens
// 统一管理应用程序的颜色、字体、形状、间距和阴影规范，方便修改和维护。
struct AppTokens {
    struct Colors {
        static let primary = Color(red: 0x11 / 255.0, green: 0x11 / 255.0, blue: 0x11 / 255.0)
        static let secondary = Color(red: 0x2A / 255.0, green: 0x2A / 255.0, blue: 0x2A / 255.0)
        static let tertiary = Color(red: 0x44 / 255.0, green: 0x44 / 255.0, blue: 0x44 / 255.0)
        static let background = Color(red: 0xF7 / 255.0, green: 0xF7 / 255.0, blue: 0xF7 / 255.0)
        static let surface = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let surfaceVariant = Color(red: 0xED / 255.0, green: 0xED / 255.0, blue: 0xED / 255.0)
        static let outline = Color(red: 0xD6 / 255.0, green: 0xD6 / 255.0, blue: 0xD6 / 255.0)
        static let success = Color(red: 0x1E / 255.0, green: 0x7D / 255.0, blue: 0x4C / 255.0)
        static let warning = Color(red: 0xB9 / 255.0, green: 0x84 / 255.0, blue: 0x00 / 255.0)
        static let error = Color(red: 0xB3 / 255.0, green: 0x26 / 255.0, blue: 0x1E / 255.0)
        static let onPrimary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onSecondary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onTertiary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onBackground = Color(red: 0x0A / 255.0, green: 0x0A / 255.0, blue: 0x0A / 255.0)
        static let onSurface = Color(red: 0x0A / 255.0, green: 0x0A / 255.0, blue: 0x0A / 255.0)
    }

    struct TypographyTokens {
        // SwiftUI Font 不直接支持 lineHeight 和 letterSpacing，这里映射为基础字体大小和粗细。
        // 如需更精细控制，可使用 .lineSpacing() 和 .kerning() 修饰符。
        static let display = Font.system(size: 28, weight: .semibold)
        static let headline = Font.system(size: 20, weight: .medium)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let small = CGFloat(8)
        static let medium = CGFloat(12)
        static let large = CGFloat(16)
    }

    struct Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
    }

    struct ShadowSpec {
        let elevation: CGFloat // Compose 中的 z-offset，在 SwiftUI 阴影中不直接使用
        let radius: CGFloat    // Compose 中的模糊半径，映射到 SwiftUI 的 shadow radius (模糊量)
        let dy: CGFloat        // y-轴偏移
        let opacity: Double    // 阴影不透明度
    }

    struct ElevationMapping {
        // 将 Compose 的阴影规范映射到 SwiftUI 的 shadow 修饰符。
        // SwiftUI 的 shadow 参数为 radius (模糊量), x (x-offset), y (y-offset), color (含不透明度)。
        static let level1 = ShadowSpec(elevation: 1, radius: 4, dy: 2, opacity: 0.10)
        static let level2 = ShadowSpec(elevation: 3, radius: 8, dy: 4, opacity: 0.14)
        static let level3 = ShadowSpec(elevation: 6, radius: 12, dy: 6, opacity: 0.16)
    }
}

// MARK: - 自定义 View 修饰符和辅助函数

// 用于根据 AppTokens.ShadowSpec 应用阴影的 ViewModifier
extension View {
    func appShadow(spec: AppTokens.ShadowSpec) -> some View {
        self.shadow(color: Color.black.opacity(spec.opacity), radius: spec.radius, x: 0, y: spec.dy)
    }
}

// 用于应用带形状边框的 ViewModifier
extension View {
    func appBorder<S: Shape>(width: CGFloat, color: Color, shape: S) -> some View {
        self.overlay(shape.stroke(color, lineWidth: width))
    }
}

// 辅助函数：根据条件应用修饰符
extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func ifLet<V, Content: View>(_ value: V?, transform: (Self, V) -> Content) -> some View {
        if let value = value {
            transform(self, value)
        } else {
            self
        }
    }
}

// MARK: - 应用程序主题环境

// AppColorScheme 对应于 Kotlin 的 MaterialTheme.colorScheme，通过 EnvironmentValues 注入
private struct AppColorSchemeKey: EnvironmentKey {
    static let defaultValue: AppColorScheme = AppColorScheme()
}

extension EnvironmentValues {
    var appColorScheme: AppColorScheme {
        get { self[AppColorSchemeKey.self] }
        set { self[AppColorSchemeKey.self] = newValue }
    }
}

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
    let success = AppTokens.Colors.success
    let warning = AppTokens.Colors.warning
}

// AppTypography 对应于 Kotlin 的 MaterialTheme.typography，通过 EnvironmentValues 注入
private struct AppTypographyKey: EnvironmentKey {
    static let defaultValue: AppTypography = AppTypography()
}

extension EnvironmentValues {
    var appTypography: AppTypography {
        get { self[AppTypographyKey.self] }
        set { self[AppTypographyKey.self] = newValue }
    }
}

struct AppTypography {
    let displayLarge = AppTokens.TypographyTokens.display
    let headlineMedium = AppTokens.TypographyTokens.headline
    let titleMedium = AppTokens.TypographyTokens.title
    let bodyMedium = AppTokens.TypographyTokens.body
    let labelMedium = AppTokens.TypographyTokens.label
}

// AppTheme ViewModifier，将自定义颜色和字体注入环境
struct AppThemeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .environment(\.appColorScheme, AppColorScheme())
            .environment(\.appTypography, AppTypography())
    }
}

extension View {
    func appTheme() -> some View {
        self.modifier(AppThemeModifier())
    }
}

// MARK: - 数据模型

struct ApprovalPin: Identifiable {
    let id: Int
    let title: String
    let status: String
    let x: CGFloat
    let y: CGFloat
}

// MARK: - 可复用 UI 组件

struct FilterChipView: View {
    @Environment(\.appColorScheme) private var colorScheme
    @Environment(\.appTypography) private var typography
    let text: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(text)
                .font(isSelected ? typography.titleMedium : typography.bodyMedium)
                .foregroundColor(isSelected ? colorScheme.onPrimary : colorScheme.onSurface)
                .padding(.horizontal, AppTokens.Spacing.sm)
                .padding(.vertical, AppTokens.Spacing.xs)
                .background(
                    RoundedRectangle(cornerRadius: AppTokens.Shapes.small)
                        .fill(isSelected ? colorScheme.primary : colorScheme.surface)
                )
                .appBorder(width: 1, color: colorScheme.outline, shape: RoundedRectangle(cornerRadius: AppTokens.Shapes.small))
        }
        .buttonStyle(PlainButtonStyle()) // 移除 SwiftUI 默认按钮样式
    }
}

struct CardView<Content: View>: View {
    @Environment(\.appColorScheme) private var colorScheme
    let elevation: AppTokens.ShadowSpec
    let cornerRadius: CGFloat
    let border: (width: CGFloat, color: Color)?
    let onClick: (() -> Void)?
    let content: Content

    init(elevation: AppTokens.ShadowSpec = AppTokens.ElevationMapping.level1,
         cornerRadius: CGFloat = AppTokens.Shapes.small,
         border: (width: CGFloat, color: Color)? = (1, AppTokens.Colors.outline),
         onClick: (() -> Void)? = nil,
         @ViewBuilder content: () -> Content) {
        self.elevation = elevation
        self.cornerRadius = cornerRadius
        self.border = border
        self.onClick = onClick
        self.content = content()
    }

    var body: some View {
        let cardContent = content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(colorScheme.surface)
            )
            .appShadow(spec: elevation)
            .ifLet(border) { view, borderSpec in
                view.appBorder(width: borderSpec.width, color: borderSpec.color, shape: RoundedRectangle(cornerRadius: cornerRadius))
            }

        if let onClick = onClick {
            Button(action: onClick) {
                cardContent
            }
            .buttonStyle(PlainButtonStyle())
        } else {
            cardContent
        }
    }
}

struct MapPinView: View {
    @Environment(\.appColorScheme) private var colorScheme
    @Environment(\.appTypography) private var typography
    let pin: ApprovalPin
    let selected: Bool
    let onClick: () -> Void

    var body: some View {
        let pinSize: CGFloat = selected ? 28 : 22
        let baseColor: Color = {
            switch pin.status {
            case "Approved": return colorScheme.success
            case "Pending": return colorScheme.warning
            case "Rejected": return colorScheme.error
            default: return .gray
            }
        }()

        // ZStack 的 topLeading 作为 MapPinView 的定位点
        ZStack(alignment: .topLeading) {
            // Pin 圆点
            Circle()
                .fill(baseColor)
                .frame(width: pinSize, height: pinSize)
                .overlay(
                    Circle()
                        .stroke(selected ? colorScheme.primary : colorScheme.surface, lineWidth: 2)
                )

            // Pin 旁边的信息卡片
            CardView(elevation: AppTokens.ElevationMapping.level1, cornerRadius: AppTokens.Shapes.small, onClick: onClick) {
                Text(pin.title)
                    .font(typography.labelMedium)
                    .foregroundColor(colorScheme.onSurface)
                    .padding(.horizontal, AppTokens.Spacing.sm)
                    .padding(.vertical, AppTokens.Spacing.xs)
            }
            // 卡片相对于 Pin 圆点顶部的偏移
            .offset(x: 18, y: -4)
        }
    }
}

struct MapGridOverlay: View {
    @Environment(\.appColorScheme) private var colorScheme

    var body: some View {
        ZStack {
            // 水平网格线
            VStack(spacing: 0) {
                ForEach(0..<6) { _ in
                    Spacer()
                    Rectangle()
                        .fill(colorScheme.surfaceVariant)
                        .frame(height: 1)
                }
                Spacer()
            }
            .padding(.horizontal, AppTokens.Spacing.lg) // 网格线左右内边距

            // 垂直网格线
            HStack(spacing: 0) {
                ForEach(0..<6) { _ in
                    Spacer()
                    Rectangle()
                        .fill(colorScheme.surfaceVariant)
                        .frame(width: 1)
                }
                Spacer()
            }
            .padding(.vertical, AppTokens.Spacing.lg) // 网格线上下内边距
        }
    }
}

// MARK: - RootScreen (主界面)

struct RootScreen: View {
    @Environment(\.appColorScheme) private var colorScheme
    @Environment(\.appTypography) private var typography

    @State private var filters: [String] = ["Pending", "Approved"]
    @State private var activeFilters: [String] = ["Pending"]
    @State private var pins: [ApprovalPin] = [
        ApprovalPin(id: 1, title: "Purchase Order #1042", status: "Pending", x: 0.18, y: 0.35),
        ApprovalPin(id: 2, title: "Travel Request #552", status: "Approved", x: 0.52, y: 0.42),
        ApprovalPin(id: 3, title: "Contract #A77", status: "Pending", x: 0.76, y: 0.58),
        ApprovalPin(id: 4, title: "Budget Change #09", status: "Rejected", x: 0.33, y: 0.72)
    ]
    @State private var selectedPinId: Int? = nil

    var body: some View {
        ZStack { // 对应 Kotlin 的 Scaffold，用于背景色和浮动按钮的叠加
            colorScheme.background.ignoresSafeArea() // 设置背景色并忽略安全区域，实现全屏

            VStack(spacing: 0) { // 主内容列：顶部栏、可滚动内容、底部栏
                // 顶部栏 (CenterAlignedTopAppBar 模拟)
                VStack {
                    Text("Approval Flow")
                        .font(typography.displayLarge)
                        .foregroundColor(colorScheme.onSurface)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, AppTokens.Spacing.md) // 模拟顶部栏的垂直内边距
                .background(colorScheme.surface)

                // 主可滚动内容区域
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: AppTokens.Spacing.md) { // 对应 Kotlin 的 Column 内容
                        // 筛选器 LazyRow
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: AppTokens.Spacing.sm) {
                                ForEach(filters, id: \.self) { f in
                                    FilterChipView(
                                        text: f,
                                        isSelected: activeFilters.contains(f),
                                        onTap: {
                                            if activeFilters.contains(f) {
                                                activeFilters.removeAll(where: { $0 == f })
                                            } else {
                                                activeFilters.append(f)
                                            }
                                        }
                                    )
                                }
                            }
                        }
                        .padding(.horizontal, AppTokens.Spacing.lg) // 应用父 Column 的水平内边距
                        .padding(.top, AppTokens.Spacing.md) // 应用父 Column 的垂直内边距 (顶部)

                        // 地图区域 (BoxWithConstraints 模拟)
                        GeometryReader { geometry in
                            let maxWidth = geometry.size.width
                            let maxHeight = geometry.size.height

                            ZStack {
                                MapGridOverlay() // 地图网格

                                // 审批 Pin 点
                                ForEach(pins.filter { p in
                                    // 筛选逻辑与 Kotlin 保持一致
                                    switch p.status {
                                    case "Pending": return activeFilters.contains("Pending")
                                    case "Approved": return activeFilters.contains("Approved")
                                    case "Rejected": return true // Kotlin 代码中 Rejected 状态的 Pin 总是显示
                                    default: return true
                                    }
                                }) { p in
                                    MapPinView(
                                        pin: p,
                                        selected: selectedPinId == p.id,
                                        onClick: {
                                            selectedPinId = selectedPinId == p.id ? nil : p.id
                                        }
                                    )
                                    // 定位 MapPinView 的 topLeading 角
                                    .offset(x: maxWidth * p.x, y: maxHeight * p.y)
                                }

                                // 选中 Pin 的详情卡片
                                if let selectedId = selectedPinId,
                                   let sel = pins.first(where: { $0.id == selectedId }) {
                                    VStack { // 使用 VStack + Spacer 将卡片推到底部居中
                                        Spacer()
                                        CardView(elevation: AppTokens.ElevationMapping.level3, cornerRadius: AppTokens.Shapes.large, border: (1, colorScheme.outline)) {
                                            HStack(alignment: .center) {
                                                VStack(alignment: .leading, spacing: AppTokens.Spacing.xs) {
                                                    Text(sel.title)
                                                        .font(typography.titleMedium)
                                                        .foregroundColor(colorScheme.onSurface)
                                                    Text(sel.status)
                                                        .font(typography.labelMedium)
                                                        .foregroundColor(colorScheme.onSurface)
                                                }
                                                Spacer()
                                                HStack(spacing: AppTokens.Spacing.sm) {
                                                    Button(action: {}) {
                                                        Text("Details")
                                                            .font(typography.labelMedium)
                                                            .foregroundColor(colorScheme.onSurface)
                                                            .padding(.horizontal, AppTokens.Spacing.md)
                                                    }
                                                    .frame(height: 40)
                                                    .background(
                                                        RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                                                            .fill(colorScheme.surfaceVariant)
                                                    )
                                                    .buttonStyle(PlainButtonStyle())
                                                }
                                            }
                                            .padding(AppTokens.Spacing.lg)
                                            .frame(maxWidth: .infinity)
                                        }
                                        .padding(AppTokens.Spacing.md) // 卡片周围的内边距
                                    }
                                }
                            }
                            .background(
                                RoundedRectangle(cornerRadius: AppTokens.Shapes.large)
                                    .fill(AppTokens.Colors.surface)
                            )
                            .appBorder(width: 1, color: AppTokens.Colors.outline, shape: RoundedRectangle(cornerRadius: AppTokens.Shapes.large))
                            .frame(maxWidth: .infinity)
                            .frame(minHeight: 360)
                            .aspectRatio(0.9, contentMode: .fit) // 保持宽高比
                        }
                        .frame(maxWidth: .infinity)
                        .frame(minHeight: 360) // 应用最小高度
                        .aspectRatio(0.9, contentMode: .fit) // 应用宽高比
                        .padding(.horizontal, AppTokens.Spacing.lg) // 应用父 Column 的水平内边距
                        .padding(.bottom, AppTokens.Spacing.md) // 应用父 Column 的垂直内边距 (底部)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity) // ScrollView 填充剩余空间

                // 底部栏 (BottomAppBar 模拟)
                VStack {
                    HStack(spacing: AppTokens.Spacing.md) {
                        Button(action: {}) {
                            Text("Reject")
                                .font(typography.titleMedium)
                                .foregroundColor(colorScheme.onSurface)
                                .frame(maxWidth: .infinity) // weight(1f) 效果
                                .frame(height: 48)
                                .background(
                                    RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                                        .fill(colorScheme.surfaceVariant)
                                )
                        }
                        .disabled(selectedPinId == nil)
                        .buttonStyle(PlainButtonStyle())

                        Button(action: {}) {
                            Text("Approve")
                                .font(typography.titleMedium)
                                .foregroundColor(colorScheme.onPrimary)
                                .frame(maxWidth: .infinity) // weight(1f) 效果
                                .frame(height: 48)
                                .background(
                                    RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                                        .fill(colorScheme.primary)
                                )
                        }
                        .disabled(selectedPinId == nil)
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal, AppTokens.Spacing.lg)
                    .padding(.vertical, AppTokens.Spacing.md)
                }
                .background(colorScheme.surface)
                .appShadow(spec: AppTokens.ElevationMapping.level2) // 底部栏阴影
            }

            // 浮动操作按钮 (FloatingActionButton 模拟)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Text("+")
                            .font(typography.headlineMedium)
                            .foregroundColor(colorScheme.onPrimary)
                            .frame(width: 56, height: 56) // 标准 FAB 尺寸
                            .background(Circle().fill(colorScheme.primary))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(AppTokens.Spacing.lg) // FAB 的内边距
                }
            }
        }
        .ignoresSafeArea(.all, edges: .all) // 确保整个视图忽略安全区域，实现全屏
        .statusBarHidden(true) // 隐藏状态栏
    }
}

// MARK: - App 入口点
// @main 标记定义了应用程序的入口点
@main
struct ApprovalFlowApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                .appTheme() // 应用自定义主题
        }
    }
}

// MARK: - 预览
// 提供 Xcode Canvas 预览功能
struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
            .appTheme()
    }
}
