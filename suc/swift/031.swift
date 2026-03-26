import SwiftUI

// MARK: - AppTokens (设计系统令牌)
// 统一管理颜色、字体、形状、间距和阴影，便于全局修改和保持一致性。
struct AppTokens {
    struct Colors {
        static let primary = Color(red: 0x02 / 255.0, green: 0x06 / 255.0, blue: 0x17 / 255.0)
        static let secondary = Color(red: 0x4A / 255.0, green: 0xDE / 255.0, blue: 0x80 / 255.0)
        static let tertiary = Color(red: 0x64 / 255.0, green: 0x74 / 255.0, blue: 0x8B / 255.0)
        static let background = Color(red: 0xF8 / 255.0, green: 0xFA / 255.0, blue: 0xFC / 255.0)
        static let surface = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let surfaceVariant = Color(red: 0xF1 / 255.0, green: 0xF5 / 255.0, blue: 0xF9 / 255.0)
        static let outline = Color(red: 0xE2 / 255.0, green: 0xE8 / 255.0, blue: 0xF0 / 255.0)
        static let success = Color(red: 0x22 / 255.0, green: 0xC5 / 255.0, blue: 0x5E / 255.0)
        static let warning = Color(red: 0xF5 / 255.0, green: 0x9E / 255.0, blue: 0x0B / 255.0)
        static let error = Color(red: 0xEF / 255.0, green: 0x44 / 255.0, blue: 0x44 / 255.0)
        static let onPrimary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onSecondary = Color(red: 0x02 / 255.0, green: 0x06 / 255.0, blue: 0x17 / 255.0)
        static let onTertiary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onBackground = Color(red: 0x02 / 255.0, green: 0x06 / 255.0, blue: 0x17 / 255.0)
        static let onSurface = Color(red: 0x02 / 255.0, green: 0x06 / 255.0, blue: 0x17 / 255.0)
    }

    struct TypographyTokens {
        // Compose的 lineHeight 在 SwiftUI 中没有直接对应属性。
        // 对于单行文本，font 本身已包含行高信息。
        // letterSpacing 对应 SwiftUI 的 kerning。
        static let display = Font.system(size: 48, weight: .bold) // lineHeight = 56.sp, letterSpacing = -0.5.sp
        static let headline = Font.system(size: 28, weight: .semibold) // lineHeight = 36.sp
        static let title = Font.system(size: 20, weight: .medium) // lineHeight = 28.sp
        static let body = Font.system(size: 16, weight: .regular) // lineHeight = 24.sp
        static let label = Font.system(size: 12, weight: .medium) // lineHeight = 16.sp, letterSpacing = 0.2.sp
    }

    struct Shapes {
        // 自定义 Shape 结构体，以便像 Compose 一样直接使用 `AppTokens.Shapes.small`
        struct RoundedCornerShape: Shape {
            let cornerRadius: CGFloat
            func path(in rect: CGRect) -> Path {
                Path(roundedRect: rect, cornerRadius: cornerRadius)
            }
        }
        static let small = RoundedCornerShape(cornerRadius: 8)
        static let medium = RoundedCornerShape(cornerRadius: 16)
        static let large = RoundedCornerShape(cornerRadius: 24)
    }

    struct Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 48
    }

    struct ShadowSpec {
        let elevation: CGFloat // Compose 中的概念层级，SwiftUI 中主要通过 radius, x, y, opacity 实现
        let radius: CGFloat
        let dy: CGFloat // y 轴偏移
        let opacity: Double
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 1, radius: 3, dy: 1, opacity: 0.05)
        static let level2 = ShadowSpec(elevation: 4, radius: 8, dy: 2, opacity: 0.08)
        static let level3 = ShadowSpec(elevation: 8, radius: 12, dy: 4, opacity: 0.10)
    }
}

// MARK: - Data Models (数据模型)
// 转换为 Swift struct，并遵循 Identifiable 协议以便在 ForEach 中使用。
struct Transaction: Identifiable {
    let id: Int
    let name: String
    let detail: String
    let amount: String
    let isCredit: Bool
}

struct ControlAction: Identifiable {
    let id = UUID() // 使用 UUID 作为唯一标识符
    let label: String
}

struct NavItem: Identifiable {
    let id = UUID() // 使用 UUID 作为唯一标识符
    let label: String
}

// MARK: - RootScreen View (主屏幕视图)
struct RootScreen: View {
    @State private var selectedNavItem: String = "Home" // 对应 Compose 的 remember { mutableStateOf("Home") }

    // 静态数据，对应 Compose 的 remember { listOf(...) }
    let transactions = [
        Transaction(id: 1, name: "Spotify", detail: "Subscription", amount: "-$9.99", isCredit: false),
        Transaction(id: 2, name: "Income", detail: "Monthly Salary", amount: "+$2,500.00", isCredit: true),
        Transaction(id: 3, name: "Starbucks", detail: "Coffee", amount: "-$5.75", isCredit: false),
        Transaction(id: 4, name: "Amazon", detail: "Shopping", amount: "-$124.50", isCredit: false),
        Transaction(id: 5, name: "Refund", detail: "Amazon Return", amount: "+$32.00", isCredit: true)
    ]
    let controlActions = [ControlAction(label: "Send"), ControlAction(label: "Receive"), ControlAction(label: "Add"), ControlAction(label: "More")]
    let navItems = [NavItem(label: "Home"), NavItem(label: "Cards"), NavItem(label: "Activity"), NavItem(label: "Profile")]

    var body: some View {
        ZStack {
            // Scaffold 的 containerColor 和 contentWindowInsets 0 对应
            AppTokens.Colors.background.ignoresSafeArea(.all)

            VStack(spacing: 0) {
                // 顶部栏 (TopAppBar)
                topAppBar()
                    .padding(.horizontal, AppTokens.Spacing.md) // 内部内容水平内边距
                    .padding(.vertical, AppTokens.Spacing.sm) // 内部内容垂直内边距
                    .background(AppTokens.Colors.background.opacity(0.01)) // 透明背景
                    .ignoresSafeArea(.container, edges: .top) // 延伸到安全区域顶部

                // 主要内容区域 (LazyColumn)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: AppTokens.Spacing.lg) { // verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
                        // 总余额卡片
                        totalBalanceCard()

                        // 控制操作按钮行
                        controlActionsRow()

                        // 最近活动标题
                        recentActivityHeader()

                        // 交易列表
                        ForEach(transactions) { transaction in
                            transactionCard(transaction: transaction)
                        }
                    }
                    .padding(.horizontal, AppTokens.Spacing.md) // contentPadding horizontal
                    .padding(.vertical, AppTokens.Spacing.sm) // contentPadding vertical
                }
                // 在 ScrollView 底部和导航栏之间添加一些间距，以匹配 Compose 的视觉效果
                .padding(.bottom, AppTokens.Spacing.sm)

                // 底部导航栏 (NavigationBar)
                bottomNavigationBar()
                    // tonalElevation 对应阴影效果
                    .shadow(color: .black.opacity(AppTokens.ElevationMapping.level3.opacity),
                            radius: AppTokens.ElevationMapping.level3.radius,
                            x: 0,
                            y: AppTokens.ElevationMapping.level3.dy)
                    .ignoresSafeArea(.container, edges: .bottom) // 延伸到安全区域底部
            }
        }
        // 全屏显示并隐藏顶部状态栏 (iOS 16.0 可用)
        .statusBarHidden(true)
    }

    // MARK: - Subviews (子视图)
    // 顶部应用栏
    private func topAppBar() -> some View {
        HStack {
            Button(action: {}) {
                Circle()
                    .fill(AppTokens.Colors.surfaceVariant)
                    .frame(width: 28, height: 28)
            }
            Spacer()
            Text("My Wallet")
                .font(AppTokens.TypographyTokens.title) // MaterialTheme.typography.titleMedium
                .foregroundColor(AppTokens.Colors.onBackground)
            Spacer()
            Button(action: {}) {
                Circle()
                    .fill(AppTokens.Colors.surfaceVariant)
                    .frame(width: 28, height: 28)
            }
        }
        .frame(height: 56) // 标准 TopAppBar 高度
    }

    // 总余额卡片
    private func totalBalanceCard() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Total Balance")
                .font(AppTokens.TypographyTokens.body) // MaterialTheme.typography.bodyMedium
                .foregroundColor(AppTokens.Colors.onPrimary.opacity(0.7))
            Spacer().frame(height: AppTokens.Spacing.sm)
            Text("$ 1,145.14")
                .font(AppTokens.TypographyTokens.display) // MaterialTheme.typography.displayLarge
                .kerning(-0.5) // letterSpacing
                .foregroundColor(AppTokens.Colors.onPrimary)
            Spacer().frame(height: AppTokens.Spacing.xs)
            HStack(alignment: .center, spacing: AppTokens.Spacing.sm) {
                Circle()
                    .fill(AppTokens.Colors.secondary)
                    .frame(width: 10, height: 10)
                Text("+$234.10 today")
                    .font(AppTokens.TypographyTokens.body) // MaterialTheme.typography.bodyMedium
                    .foregroundColor(AppTokens.Colors.secondary)
            }
        }
        .padding(AppTokens.Spacing.lg)
        .frame(maxWidth: .infinity) // fillMaxWidth()
        .background(AppTokens.Colors.primary)
        .clipShape(AppTokens.Shapes.large) // shape = AppTokens.Shapes.large
        // elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level2.elevation)
        .shadow(color: .black.opacity(AppTokens.ElevationMapping.level2.opacity),
                radius: AppTokens.ElevationMapping.level2.radius,
                x: 0,
                y: AppTokens.ElevationMapping.level2.dy)
    }

    // 控制操作按钮行
    private func controlActionsRow() -> some View {
        HStack(alignment: .center, spacing: 0) { // horizontalArrangement = Arrangement.SpaceAround
            ForEach(controlActions) { action in
                VStack(spacing: AppTokens.Spacing.sm) {
                    Button(action: {}) {
                        // 按钮内部的 Box
                        AppTokens.Shapes.small
                            .fill(AppTokens.Colors.primary)
                            .frame(width: 24, height: 24)
                            .contentShape(Circle()) // 确保点击区域是圆形
                    }
                    .frame(width: 64, height: 64) // modifier = Modifier.size(64.dp)
                    .background(AppTokens.Colors.surface) // containerColor
                    .clipShape(Circle()) // shape = CircleShape
                    // elevation = ButtonDefaults.buttonElevation(defaultElevation = AppTokens.ElevationMapping.level1.elevation)
                    .shadow(color: .black.opacity(AppTokens.ElevationMapping.level1.opacity),
                            radius: AppTokens.ElevationMapping.level1.radius,
                            x: 0,
                            y: AppTokens.ElevationMapping.level1.dy)
                    .buttonStyle(PlainButtonStyle()) // 移除 SwiftUI 默认按钮样式，实现原子级样式控制
                    .padding(0) // contentPadding = PaddingValues(0.dp)

                    Text(action.label)
                        .font(AppTokens.TypographyTokens.label) // MaterialTheme.typography.labelMedium
                        .kerning(0.2) // letterSpacing
                        .foregroundColor(AppTokens.Colors.onBackground)
                }
                .frame(maxWidth: .infinity) // 确保每个 Column 均分空间，实现 SpaceAround
            }
        }
    }

    // 最近活动标题
    private func recentActivityHeader() -> some View {
        HStack {
            Text("Recent Activity")
                .font(AppTokens.TypographyTokens.title) // MaterialTheme.typography.titleMedium
                .foregroundColor(AppTokens.Colors.onBackground)
            Spacer()
            Button(action: {}) {
                Text("View All")
                    .font(AppTokens.TypographyTokens.label) // MaterialTheme.typography.labelMedium
                    .kerning(0.2) // letterSpacing
                    .foregroundColor(AppTokens.Colors.tertiary)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }

    // 交易卡片
    private func transactionCard(transaction: Transaction) -> some View {
        HStack(spacing: AppTokens.Spacing.md) {
            AppTokens.Shapes.medium // Box(modifier = Modifier.size(48.dp).background(AppTokens.Colors.surfaceVariant, AppTokens.Shapes.medium))
                .fill(AppTokens.Colors.surfaceVariant)
                .frame(width: 48, height: 48)

            VStack(alignment: .leading) {
                Text(transaction.name)
                    .font(AppTokens.TypographyTokens.body) // MaterialTheme.typography.bodyMedium
                    .fontWeight(.semibold)
                    .foregroundColor(AppTokens.Colors.onSurface)
                Text(transaction.detail)
                    .font(AppTokens.TypographyTokens.label) // MaterialTheme.typography.labelMedium
                    .kerning(0.2) // letterSpacing
                    .foregroundColor(AppTokens.Colors.tertiary)
            }
            .frame(maxWidth: .infinity, alignment: .leading) // modifier = Modifier.weight(1f)

            Text(transaction.amount)
                .font(AppTokens.TypographyTokens.body) // MaterialTheme.typography.bodyMedium
                .fontWeight(.semibold)
                .foregroundColor(transaction.isCredit ? AppTokens.Colors.success : AppTokens.Colors.onSurface)
                .multilineTextAlignment(.trailing) // TextAlign.End
        }
        .padding(AppTokens.Spacing.md)
        .frame(maxWidth: .infinity) // fillMaxWidth()
        .background(AppTokens.Colors.surface) // containerColor
        .clipShape(AppTokens.Shapes.medium) // shape = AppTokens.Shapes.medium
        // border = BorderStroke(1.dp, AppTokens.Colors.outline)
        .overlay(
            AppTokens.Shapes.medium.stroke(AppTokens.Colors.outline, lineWidth: 1)
        )
    }

    // 底部导航栏
    private func bottomNavigationBar() -> some View {
        HStack(spacing: 0) {
            ForEach(navItems) { item in
                Button(action: {
                    selectedNavItem = item.label
                }) {
                    VStack(spacing: AppTokens.Spacing.xs) { // 模拟图标和文本的间距
                        Circle() // 图标占位符
                            .fill(selectedNavItem == item.label ? AppTokens.Colors.primary : AppTokens.Colors.outline)
                            .frame(width: 24, height: 24)
                        Text(item.label)
                            .font(AppTokens.TypographyTokens.label) // MaterialTheme.typography.labelMedium
                            .kerning(0.2) // letterSpacing
                            .foregroundColor(selectedNavItem == item.label ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
                    }
                    .frame(maxWidth: .infinity) // 每个导航项均分宽度
                    .padding(.vertical, AppTokens.Spacing.sm) // 模拟 NavigationBarItem 的垂直内边距
                    // indicatorColor 模拟，当选中时背景色变为 surfaceVariant
                    .background(selectedNavItem == item.label ? AppTokens.Colors.surfaceVariant : Color.clear)
                    .clipShape(RoundedRectangle(cornerRadius: AppTokens.Shapes.medium.cornerRadius)) // 裁剪指示器背景
                }
                .buttonStyle(PlainButtonStyle()) // 移除默认按钮样式
            }
        }
        .padding(.horizontal, AppTokens.Spacing.xs) // 整个导航栏的水平内边距
        .frame(height: 80) // 模拟 NavigationBar 的高度
        .background(AppTokens.Colors.surface) // containerColor
    }
}

// MARK: - App Entry Point (应用入口)
// @main 宏定义了应用的入口点，使其成为一个完整的可运行示例。
@main
struct SingleFileUIApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}

// MARK: - Preview (预览)
struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
            .previewDisplayName("My Wallet UI")
    }
}