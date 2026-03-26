
import SwiftUI

// MARK: - AppTokens
// 统一的UI设计系统，方便修改比例和控件大小
struct AppTokens {
    struct Colors {
        // 将Compose的Color(0xFF...)转换为SwiftUI的Color(red:green:blue:)
        static let primary = Color(red: 0.055, green: 0.647, blue: 0.914) // 0xFF0EA5E9
        static let secondary = Color(red: 0.220, green: 0.741, blue: 0.973) // 0xFF38BDF8
        static let tertiary = Color(red: 0.490, green: 0.827, blue: 0.988) // 0xFF7DD3FC
        static let background = Color(red: 0.941, green: 0.976, blue: 1.000) // 0xFFF0F9FF
        static let surface = Color(red: 1.000, green: 1.000, blue: 1.000) // 0xFFFFFFFF
        static let surfaceVariant = Color(red: 0.878, green: 0.949, blue: 0.996) // 0xFFE0F2FE
        static let outline = Color(red: 0.729, green: 0.902, blue: 0.992) // 0xFFBAE6FD
        static let success = Color(red: 0.133, green: 0.773, blue: 0.369) // 0xFF22C55E
        static let warning = Color(red: 0.988, green: 0.804, blue: 0.082) // 0xFFFACC15
        static let error = Color(red: 0.937, green: 0.267, blue: 0.267) // 0xFFEF4444
        static let onPrimary = Color(red: 1.000, green: 1.000, blue: 1.000) // 0xFFFFFFFF
        static let onSecondary = Color(red: 0.118, green: 0.118, blue: 0.118) // 0xFF1E1E1E
        static let onTertiary = Color(red: 0.059, green: 0.091, blue: 0.165) // 0xFF0F172A
        static let onBackground = Color(red: 0.059, green: 0.091, blue: 0.165) // 0xFF0F172A
        static let onSurface = Color(red: 0.059, green: 0.091, blue: 0.165) // 0xFF0F172A
    }

    struct TypographyTokens {
        // 将Compose的TextStyle转换为SwiftUI的Font
        static let display = Font.system(size: 26, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) // FontWeight.Normal 对应 .regular
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        // 将Compose的RoundedCornerShape的dp值转换为SwiftUI的CGFloat
        static let small: CGFloat = 6.0
        static let medium: CGFloat = 10.0
        static let large: CGFloat = 16.0
    }

    struct Spacing {
        // 将Compose的Dp值转换为SwiftUI的CGFloat
        static let sm: CGFloat = 6.0
        static let md: CGFloat = 10.0
        static let lg: CGFloat = 14.0
        static let xl: CGFloat = 20.0
        static let xxl: CGFloat = 28.0
    }

    struct ShadowSpec {
        let elevation: CGFloat
        let radius: CGFloat
        let dy: CGFloat
        let opacity: Double // Kotlin的Float对应Swift的Double
    }

    struct ElevationMapping {
        // 将Compose的ElevationMapping转换为SwiftUI的ShadowSpec
        static let level1 = ShadowSpec(elevation: 2.0, radius: 4.0, dy: 2.0, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 6.0, radius: 8.0, dy: 4.0, opacity: 0.18)
    }
}

// MARK: - Data Model
// Product数据模型，遵循Identifiable协议以便在ForEach中使用
struct Product: Identifiable {
    let id: Int
    let name: String
    let price: String
    let store: String
}

// MARK: - RootScreen
// 对应Compose的RootScreen Composable函数
struct RootScreen: View {
    // 模拟Compose的remember，数据源在View初始化时创建
    let products = [
        Product(id: 1, name: "Wireless Earbuds", price: "$59.99", store: "ShopA"),
        Product(id: 2, name: "Smart Watch", price: "$129.99", store: "ShopB"),
        Product(id: 3, name: "Laptop Stand", price: "$39.99", store: "ShopC"),
        Product(id: 4, name: "Mechanical Keyboard", price: "$89.99", store: "ShopA"),
        Product(id: 5, name: "Noise Cancel Headset", price: "$149.99", store: "ShopB"),
        Product(id: 6, name: "Ergo Mouse", price: "$45.99", store: "ShopC")
    ]

    var body: some View {
        // Scaffold的替代：使用ZStack作为背景，ScrollView包裹内容
        ZStack {
            // 背景渐变色，对应Compose的Brush.verticalGradient
            LinearGradient(
                gradient: Gradient(colors: [
                    AppTokens.Colors.secondary.opacity(0.25),
                    AppTokens.Colors.background,
                    AppTokens.Colors.primary.opacity(0.25)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea() // 使渐变色填充整个屏幕，包括安全区域

            // 整体内容可滚动，对应Compose的LazyColumn/LazyVerticalGrid的混合滚动行为
            ScrollView(.vertical, showsIndicators: false) {
                // 对应Compose的Column
                VStack(alignment: .leading, spacing: AppTokens.Spacing.lg) {
                    Text("Cold Gradient Price Compare")
                        .font(AppTokens.TypographyTokens.display)
                        .foregroundColor(AppTokens.Colors.onBackground)

                    // 对应Compose的LazyVerticalGrid
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())],
                              spacing: AppTokens.Spacing.md) {
                        ForEach(products) { p in
                            ProductCard(product: p)
                        }
                    }
                    // 对应Compose的contentPadding = PaddingValues(bottom = AppTokens.Spacing.xxl)
                    .padding(.bottom, AppTokens.Spacing.xxl)

                    Text("Price Update Log")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.primary)

                    // 对应Compose的LazyColumn
                    LazyVStack(spacing: AppTokens.Spacing.sm) {
                        ForEach(products) { p in
                            PriceUpdateLogItem(product: p)
                        }
                    }
                    // 对应Compose的contentPadding = PaddingValues(bottom = 48.dp)
                    .padding(.bottom, 48)
                }
                // 对应Compose的Modifier.padding(AppTokens.Spacing.lg)应用于整个Column
                .padding(AppTokens.Spacing.lg)
            }
        }
        // 确保内容延伸到屏幕边缘
        .edgesIgnoringSafeArea(.all)
        // 隐藏顶部状态栏
        .statusBarHidden(true)
        // 强制使用浅色模式，对应lightColorScheme
        .preferredColorScheme(.light)
    }
}

// MARK: - ProductCard Component
// 对应Compose的Card组件
struct ProductCard: View {
    let product: Product

    var body: some View {
        // 对应Compose的Column
        VStack(spacing: AppTokens.Spacing.sm) {
            // 占位符Box，对应Compose的Box with size(100.dp)
            Rectangle()
                .fill(AppTokens.Colors.surfaceVariant)
                .frame(width: 100, height: 100)
                .cornerRadius(AppTokens.Shapes.medium)

            Text(product.name)
                .font(AppTokens.TypographyTokens.title)
                .foregroundColor(AppTokens.Colors.onSurface)

            Text(product.price)
                .font(AppTokens.TypographyTokens.body)
                .foregroundColor(AppTokens.Colors.primary)

            Text(product.store)
                .font(AppTokens.TypographyTokens.label)
                .foregroundColor(AppTokens.Colors.tertiary)

            // 对应Compose的Button
            Button(action: {}) {
                Text("Compare")
                    .font(AppTokens.TypographyTokens.label)
                    .foregroundColor(AppTokens.Colors.onPrimary)
                    .frame(maxWidth: .infinity) // 对应Compose的Modifier.fillMaxWidth()
                    // 对应Compose ButtonDefaults.ContentPadding.vertical = 8.dp
                    .padding(.vertical, 8.0)
            }
            .background(AppTokens.Colors.primary) // 对应Compose的containerColor
            .cornerRadius(AppTokens.Shapes.medium) // 对应Compose的shape
        }
        // 对应Compose的Modifier.padding(AppTokens.Spacing.md)
        .padding(AppTokens.Spacing.md)
        .background(AppTokens.Colors.surface) // 对应Compose的containerColor
        .cornerRadius(AppTokens.Shapes.large) // 对应Compose的shape
        // 对应Compose的elevation
        .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity),
                radius: AppTokens.ElevationMapping.level1.radius,
                x: 0, // Compose的elevation通常没有水平偏移，或默认0
                y: AppTokens.ElevationMapping.level1.dy)
    }
}

// MARK: - PriceUpdateLogItem Component
// 对应Compose的Row组件
struct PriceUpdateLogItem: View {
    let product: Product

    var body: some View {
        // 对应Compose的Row
        HStack {
            Text("\(product.name) (\(product.store))")
                .font(AppTokens.TypographyTokens.body)
                .foregroundColor(AppTokens.Colors.onSurface)
            Spacer() // 对应Compose的Arrangement.SpaceBetween
            Text(product.price)
                .font(AppTokens.TypographyTokens.label)
                .foregroundColor(AppTokens.Colors.secondary)
        }
        // 对应Compose的Modifier.padding(AppTokens.Spacing.md)
        .padding(AppTokens.Spacing.md)
        .background(AppTokens.Colors.surface) // 对应Compose的background
        .cornerRadius(AppTokens.Shapes.small) // 对应Compose的shape
    }
}

// MARK: - App Entry Point
// 应用程序的入口点，对应MainActivity和setContent
@main
struct PriceCompareApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}