
import SwiftUI

// MARK: - AppTokens (Equivalent to Kotlin's AppTokens object)
// 包含应用的所有设计系统常量，便于统一管理和修改
struct AppTokens {
    struct Colors {
        static let primary = Color(red: 0x1E / 255.0, green: 0x3A / 255.0, blue: 0x8A / 255.0)
        static let secondary = Color(red: 0x3B / 255.0, green: 0x82 / 255.0, blue: 0xF6 / 255.0)
        static let tertiary = Color(red: 0x60 / 255.0, green: 0xA5 / 255.0, blue: 0xFA / 255.0)
        static let background = Color(red: 0xF5 / 255.0, green: 0xF8 / 255.0, blue: 0xFF / 255.0)
        static let surface = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let surfaceVariant = Color(red: 0xE8 / 255.0, green: 0xEE / 255.0, blue: 0xFA / 255.0)
        static let outline = Color(red: 0xCB / 255.0, green: 0xD5 / 255.0, blue: 0xE1 / 255.0)
        static let success = Color(red: 0x22 / 255.0, green: 0xC5 / 255.0, blue: 0x5E / 255.0)
        static let warning = Color(red: 0xF5 / 255.0, green: 0x9E / 255.0, blue: 0x0B / 255.0)
        static let error = Color(red: 0xEF / 255.0, green: 0x44 / 255.0, blue: 0x44 / 255.0)
        static let onPrimary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onSecondary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onTertiary = Color(red: 0x0B / 255.0, green: 0x12 / 255.0, blue: 0x20 / 255.0)
        static let onBackground = Color(red: 0x0B / 255.0, green: 0x12 / 255.0, blue: 0x20 / 255.0)
        static let onSurface = Color(red: 0x0B / 255.0, green: 0x12 / 255.0, blue: 0x20 / 255.0)
    }

    struct TypographyTokens {
        static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) // Kotlin's FontWeight.Normal 对应 Swift 的 .regular
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let small = RoundedCornerShape(cornerRadius: 6)
        static let medium = RoundedCornerShape(cornerRadius: 10)
        static let large = RoundedCornerShape(cornerRadius: 16)
    }

    struct Spacing {
        static let sm: CGFloat = 6
        static let md: CGFloat = 10
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 36
    }

    struct ShadowSpec {
        let elevation: CGFloat
        let radius: CGFloat
        let dy: CGFloat
        let opacity: Double // Kotlin's Float 对应 Swift 的 Double
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 6, radius: 8, dy: 4, opacity: 0.15)
        static let level3 = ShadowSpec(elevation: 10, radius: 12, dy: 6, opacity: 0.18)
    }
    
    // Material 3 默认尺寸/填充，用于精确匹配安卓行为
    struct MaterialDefaults {
        static let bottomAppBarHeight: CGFloat = 80
        static let fabSize: CGFloat = 56
        static let buttonHorizontalPadding: CGFloat = 16 // Material3 FilledButton 默认水平填充
        static let buttonVerticalPadding: CGFloat = 8 // Material3 FilledButton 默认垂直填充
        static let fabBottomMargin: CGFloat = 16 // FAB 距离底部边缘的默认间距
        static let fabTrailingMargin: CGFloat = 16 // FAB 距离右侧边缘的默认间距
        static let lazyColumnContentBottomPadding: CGFloat = 96 // Kotlin LazyColumn 的 contentPadding
    }
}

// 辅助结构体，用于封装圆角值
struct RoundedCornerShape {
    let cornerRadius: CGFloat
}

// MARK: - Data Model
// 列表数据模型，遵循 Identifiable 协议以便在 ForEach 中使用
struct LiveItem: Identifiable {
    let id: Int
    let title: String
    let viewers: Int
    let price: String
}

// MARK: - RootScreen View
struct RootScreen: View {
    let liveList: [LiveItem] = [
        LiveItem(id: 1, title: "Smartphone Flash Deal", viewers: 1234, price: "$699"),
        LiveItem(id: 2, title: "Gaming Chair Special", viewers: 880, price: "$249"),
        LiveItem(id: 3, title: "Headphones Clearance", viewers: 1640, price: "$99"),
        LiveItem(id: 4, title: "Mechanical Keyboard", viewers: 512, price: "$129")
    ]

    var body: some View {
        // ZStack 用于模拟 Scaffold 的层叠布局：内容、FAB 和底部导航栏
        ZStack {
            // 主要内容区域，对应 Scaffold 的 content
            VStack(alignment: .leading, spacing: AppTokens.Spacing.md) {
                Text("Live Shop Events")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.primary)
                
                ScrollView {
                    LazyVStack(spacing: AppTokens.Spacing.md) {
                        ForEach(liveList) { item in
                            LiveItemCard(item: item)
                        }
                    }
                    // Kotlin LazyColumn 的 contentPadding 底部 96.dp，用于为 FAB 留出空间
                    .padding(.bottom, AppTokens.MaterialDefaults.lazyColumnContentBottomPadding)
                }
            }
            // 整个内容 Column 的外部填充，对应 Kotlin Modifier.padding(AppTokens.Spacing.lg)
            .padding(AppTokens.Spacing.lg)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient( // 垂直渐变背景
                    gradient: Gradient(colors: [
                        AppTokens.Colors.background,
                        AppTokens.Colors.surfaceVariant,
                        AppTokens.Colors.background
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .ignoresSafeArea(.all, edges: .all) // 使内容延伸至屏幕边缘，实现全屏效果
            
            // 浮动操作按钮 (Floating Action Button)
            VStack { // 使用 VStack + Spacer 将 FAB 推到 ZStack 的底部
                Spacer()
                HStack { // 使用 HStack + Spacer 将 FAB 推到 ZStack 的右侧
                    Spacer()
                    Button(action: {}) {
                        Text("+")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.onSecondary)
                            .frame(width: AppTokens.MaterialDefaults.fabSize, height: AppTokens.MaterialDefaults.fabSize)
                            .background(AppTokens.Colors.secondary)
                            .clipShape(Circle()) // 圆形剪裁
                    }
                    // FAB 距离右侧和底部边缘的间距，底部间距需要考虑底部导航栏的高度
                    .padding(.trailing, AppTokens.MaterialDefaults.fabTrailingMargin)
                    .padding(.bottom, AppTokens.MaterialDefaults.fabBottomMargin + AppTokens.MaterialDefaults.bottomAppBarHeight)
                }
            }

            // 底部导航栏 (Bottom Bar)
            VStack { // 使用 VStack + Spacer 将底部导航栏推到 ZStack 的底部
                Spacer()
                BottomNavBar()
            }
        }
        .background(AppTokens.Colors.background) // Scaffold 的 containerColor
        .statusBarHidden(true) // 隐藏状态栏
    }
}

// MARK: - LiveItemCard View
struct LiveItemCard: View {
    let item: LiveItem

    var body: some View {
        VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
            // 占位图片区域
            Rectangle()
                .fill(AppTokens.Colors.secondary)
                .frame(maxWidth: .infinity)
                .frame(height: 160)
                .clipShape(RoundedRectangle(cornerRadius: AppTokens.Shapes.medium.cornerRadius))

            Text(item.title)
                .font(AppTokens.TypographyTokens.title)
                .foregroundColor(AppTokens.Colors.onSurface)

            Text("\(item.viewers) viewers")
                .font(AppTokens.TypographyTokens.body)
                .foregroundColor(AppTokens.Colors.tertiary)

            HStack {
                Text(item.price)
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.primary)

                Spacer() // 将价格和按钮推开

                Button(action: {}) {
                    Text("Join Live")
                        .font(AppTokens.TypographyTokens.label)
                        .foregroundColor(AppTokens.Colors.onPrimary)
                        // 按钮内容填充，精确匹配 Material3 默认值
                        .padding(.vertical, AppTokens.MaterialDefaults.buttonVerticalPadding)
                        .padding(.horizontal, AppTokens.MaterialDefaults.buttonHorizontalPadding)
                        .background(AppTokens.Colors.primary)
                        .clipShape(RoundedRectangle(cornerRadius: AppTokens.Shapes.medium.cornerRadius))
                }
                .buttonStyle(PlainButtonStyle()) // 移除 SwiftUI 默认按钮样式
            }
        }
        .padding(AppTokens.Spacing.lg) // Card 内部填充
        .background(AppTokens.Colors.surface)
        .clipShape(RoundedRectangle(cornerRadius: AppTokens.Shapes.large.cornerRadius)) // Card 圆角
        .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity), // Card 阴影
                radius: AppTokens.ElevationMapping.level1.radius,
                x: 0,
                y: AppTokens.ElevationMapping.level1.dy)
    }
}

// MARK: - BottomNavBar View
struct BottomNavBar: View {
    var body: some View {
        HStack(spacing: 0) { // 使用 spacing 0 配合 Spacer 实现 SpaceBetween 效果
            Spacer()
            Text("Home")
                .font(AppTokens.TypographyTokens.body)
                .foregroundColor(AppTokens.Colors.primary) // 主色
            Spacer()
            Text("Live")
                .font(AppTokens.TypographyTokens.body)
                .foregroundColor(AppTokens.Colors.onSurface)
            Spacer()
            Text("Cart")
                .font(AppTokens.TypographyTokens.body)
                .foregroundColor(AppTokens.Colors.onSurface)
            Spacer()
            Text("Profile")
                .font(AppTokens.TypographyTokens.body)
                .foregroundColor(AppTokens.Colors.onSurface)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: AppTokens.MaterialDefaults.bottomAppBarHeight) // 底部导航栏高度
        .background(AppTokens.Colors.surface) // 背景色
        .shadow(color: Color.black.opacity(0.1), radius: 0.5, x: 0, y: -1) // 底部导航栏的顶部阴影
    }
}

// MARK: - App Entry Point
@main
struct LiveShopApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}