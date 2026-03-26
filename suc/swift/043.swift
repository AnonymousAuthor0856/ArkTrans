import SwiftUI

// MARK: - AppTokens (设计系统)

// 扩展 Color 以支持十六进制初始化，方便颜色定义
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

// 应用程序的设计令牌，包括颜色、字体、形状、间距和阴影
struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFF00E5FF)
        static let secondary = Color(hex: 0xFF00BFA5)
        static let tertiary = Color(hex: 0xFF69F0AE)
        static let background = Color(hex: 0xFF0A0A0A)
        static let surface = Color(hex: 0xFF121212)
        static let surfaceVariant = Color(hex: 0xFF1E1E1E)
        static let outline = Color(hex: 0xFF2C2C2C)
        static let success = Color(hex: 0xFF00C853)
        static let warning = Color(hex: 0xFFFFD600)
        static let error = Color(hex: 0xFFD50000)
        static let onPrimary = Color(hex: 0xFF0A0A0A)
        static let onSecondary = Color(hex: 0xFF0A0A0A)
        static let onBackground = Color(hex: 0xFFFFFFFF)
        static let onSurface = Color(hex: 0xFFFFFFFF)
    }

    struct TypographyTokens {
        static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let small: CGFloat = 6
        static let medium: CGFloat = 10
        static let large: CGFloat = 14
    }

    struct Spacing {
        static let sm: CGFloat = 6
        static let md: CGFloat = 10
        static let lg: CGFloat = 14
        static let xl: CGFloat = 20
        static let xxl: CGFloat = 28
    }

    // 阴影规范，用于近似 Android 的 elevation
    struct ShadowSpec {
        let radius: CGFloat // 阴影模糊半径
        let x: CGFloat      // 阴影X轴偏移
        let y: CGFloat      // 阴影Y轴偏移
        let opacity: Double // 阴影不透明度
    }

    struct ElevationMapping {
        // 将 Android 的 elevation (dp) 近似映射到 SwiftUI 的 shadow 属性
        static let level1 = ShadowSpec(radius: 4, x: 0, y: 2, opacity: 0.15)
        static let level2 = ShadowSpec(radius: 8, x: 0, y: 4, opacity: 0.18)
        static let level3 = ShadowSpec(radius: 12, x: 0, y: 6, opacity: 0.2)
    }
}

// MARK: - CartItem 数据模型

struct CartItem: Identifiable {
    let id: Int
    let name: String
    let price: Double
}

// MARK: - RootScreen 视图

struct RootScreen: View {
    let items: [CartItem] = [
        CartItem(id: 1, name: "Neon Keyboard", price: 89.99),
        CartItem(id: 2, name: "Wireless Mouse", price: 49.99),
        CartItem(id: 3, name: "Gaming Headset", price: 109.99)
    ]

    @State private var promo: String = ""

    var total: Double {
        items.reduce(0.0) { $0 + $1.price }
    }

    var body: some View {
        ZStack {
            // 背景渐变
            LinearGradient(
                gradient: Gradient(colors: [AppTokens.Colors.background, AppTokens.Colors.surfaceVariant]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: AppTokens.Spacing.md) {
                    Text("Your Cart")
                        .font(AppTokens.TypographyTokens.display)
                        .foregroundColor(AppTokens.Colors.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    // 购物车商品列表
                    ForEach(items) { item in
                        cartItemCard(item: item)
                    }

                    Spacer().frame(height: AppTokens.Spacing.md)

                    // 促销码输入框
                    HStack {
                        TextField("", text: $promo)
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(AppTokens.Colors.onSurface)
                            .placeholder(when: promo.isEmpty) {
                                Text("Promo Code")
                                    .font(AppTokens.TypographyTokens.body)
                                    .foregroundColor(AppTokens.Colors.onSurface.opacity(0.5))
                            }
                            .padding(AppTokens.Spacing.md)
                            .background(AppTokens.Colors.surfaceVariant)
                            .cornerRadius(AppTokens.Shapes.medium)
                            .overlay(
                                RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                                    .stroke(AppTokens.Colors.outline, lineWidth: 1)
                            )
                    }

                    Spacer().frame(height: AppTokens.Spacing.md)

                    // 总结卡片
                    VStack(spacing: AppTokens.Spacing.sm) {
                        HStack {
                            Text("Items:")
                                .font(AppTokens.TypographyTokens.body)
                                .foregroundColor(AppTokens.Colors.onSurface)
                            Spacer()
                            Text("\(items.count)")
                                .font(AppTokens.TypographyTokens.body)
                                .foregroundColor(AppTokens.Colors.primary)
                        }
                        
                        HStack {
                            Text("Total:")
                                .font(AppTokens.TypographyTokens.title)
                                .foregroundColor(AppTokens.Colors.onSurface)
                            Spacer()
                            Text("$\(String(format: "%.2f", total))")
                                .font(AppTokens.TypographyTokens.title)
                                .foregroundColor(AppTokens.Colors.primary)
                        }
                    }
                    .padding(AppTokens.Spacing.lg)
                    .frame(maxWidth: .infinity)
                    .background(AppTokens.Colors.surfaceVariant)
                    .cornerRadius(AppTokens.Shapes.large)
                    .shadow(
                        color: AppTokens.Colors.background.opacity(AppTokens.ElevationMapping.level1.opacity),
                        radius: AppTokens.ElevationMapping.level1.radius,
                        x: AppTokens.ElevationMapping.level1.x,
                        y: AppTokens.ElevationMapping.level1.y
                    )

                    // 结账按钮
                    Button(action: {}) {
                        Text("Checkout")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.onSecondary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(AppTokens.Colors.secondary)
                            .cornerRadius(AppTokens.Shapes.large)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(AppTokens.Spacing.lg)
            }
        }
        .statusBar(hidden: true)
    }

    // 购物车商品卡片
    private func cartItemCard(item: CartItem) -> some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.onSurface)
                Text("$\(String(format: "%.2f", item.price))")
                    .font(AppTokens.TypographyTokens.body)
                    .foregroundColor(AppTokens.Colors.secondary)
            }
            
            Spacer()
            
            Button(action: {}) {
                Text("Remove")
                    .font(AppTokens.TypographyTokens.label)
                    .foregroundColor(AppTokens.Colors.onPrimary)
                    .padding(.horizontal, AppTokens.Spacing.md)
                    .padding(.vertical, AppTokens.Spacing.sm)
                    .background(AppTokens.Colors.primary)
                    .cornerRadius(AppTokens.Shapes.medium)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(AppTokens.Spacing.md)
        .frame(maxWidth: .infinity)
        .background(AppTokens.Colors.surface)
        .cornerRadius(AppTokens.Shapes.large)
        .shadow(
            color: AppTokens.Colors.background.opacity(AppTokens.ElevationMapping.level1.opacity),
            radius: AppTokens.ElevationMapping.level1.radius,
            x: AppTokens.ElevationMapping.level1.x,
            y: AppTokens.ElevationMapping.level1.y
        )
    }
}

// MARK: - 占位符扩展

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

// MARK: - 应用程序入口点

@main
struct ShoppingCartApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                .preferredColorScheme(.dark)
        }
    }
}

// MARK: - 预览

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}