
import SwiftUI

struct AppTokens {
    struct Colors {
                static let primary = Color(red: 0.055, green: 0.647, blue: 0.914) 
        static let secondary = Color(red: 0.220, green: 0.741, blue: 0.973) 
        static let tertiary = Color(red: 0.490, green: 0.827, blue: 0.988) 
        static let background = Color(red: 0.941, green: 0.976, blue: 1.000) 
        static let surface = Color(red: 1.000, green: 1.000, blue: 1.000) 
        static let surfaceVariant = Color(red: 0.878, green: 0.949, blue: 0.996) 
        static let outline = Color(red: 0.729, green: 0.902, blue: 0.992) 
        static let success = Color(red: 0.133, green: 0.773, blue: 0.369) 
        static let warning = Color(red: 0.988, green: 0.804, blue: 0.082) 
        static let error = Color(red: 0.937, green: 0.267, blue: 0.267) 
        static let onPrimary = Color(red: 1.000, green: 1.000, blue: 1.000) 
        static let onSecondary = Color(red: 0.118, green: 0.118, blue: 0.118) 
        static let onTertiary = Color(red: 0.059, green: 0.091, blue: 0.165) 
        static let onBackground = Color(red: 0.059, green: 0.091, blue: 0.165) 
        static let onSurface = Color(red: 0.059, green: 0.091, blue: 0.165) 
    }

    struct TypographyTokens {
                static let display = Font.system(size: 26, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) 
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
                static let small: CGFloat = 6.0
        static let medium: CGFloat = 10.0
        static let large: CGFloat = 16.0
    }

    struct Spacing {
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
        let opacity: Double 
    }

    struct ElevationMapping {
                static let level1 = ShadowSpec(elevation: 2.0, radius: 4.0, dy: 2.0, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 6.0, radius: 8.0, dy: 4.0, opacity: 0.18)
    }
}

struct Product: Identifiable {
    let id: Int
    let name: String
    let price: String
    let store: String
}

struct RootScreen: View {
        let products = [
        Product(id: 1, name: "Wireless Earbuds", price: "$59.99", store: "ShopA"),
        Product(id: 2, name: "Smart Watch", price: "$129.99", store: "ShopB"),
        Product(id: 3, name: "Laptop Stand", price: "$39.99", store: "ShopC"),
        Product(id: 4, name: "Mechanical Keyboard", price: "$89.99", store: "ShopA"),
        Product(id: 5, name: "Noise Cancel Headset", price: "$149.99", store: "ShopB"),
        Product(id: 6, name: "Ergo Mouse", price: "$45.99", store: "ShopC")
    ]

    var body: some View {
                ZStack {
                        LinearGradient(
                gradient: Gradient(colors: [
                    AppTokens.Colors.secondary.opacity(0.25),
                    AppTokens.Colors.background,
                    AppTokens.Colors.primary.opacity(0.25)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea() 

                        ScrollView(.vertical, showsIndicators: false) {
                                VStack(alignment: .leading, spacing: AppTokens.Spacing.lg) {
                    Text("Cold Gradient Price Compare")
                        .font(AppTokens.TypographyTokens.display)
                        .foregroundColor(AppTokens.Colors.onBackground)

                                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())],
                              spacing: AppTokens.Spacing.md) {
                        ForEach(products) { p in
                            ProductCard(product: p)
                        }
                    }
                                        .padding(.bottom, AppTokens.Spacing.xxl)

                    Text("Price Update Log")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.primary)

                                        LazyVStack(spacing: AppTokens.Spacing.sm) {
                        ForEach(products) { p in
                            PriceUpdateLogItem(product: p)
                        }
                    }
                                        .padding(.bottom, 48)
                }
                                .padding(AppTokens.Spacing.lg)
            }
        }
                .edgesIgnoringSafeArea(.all)
                .statusBarHidden(true)
                .preferredColorScheme(.light)
    }
}

struct ProductCard: View {
    let product: Product

    var body: some View {
                VStack(spacing: AppTokens.Spacing.sm) {
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

                        Button(action: {}) {
                Text("Compare")
                    .font(AppTokens.TypographyTokens.label)
                    .foregroundColor(AppTokens.Colors.onPrimary)
                    .frame(maxWidth: .infinity) 
                                        .padding(.vertical, 8.0)
            }
            .background(AppTokens.Colors.primary) 
            .cornerRadius(AppTokens.Shapes.medium) 
        }
                .padding(AppTokens.Spacing.md)
        .background(AppTokens.Colors.surface) 
        .cornerRadius(AppTokens.Shapes.large) 
                .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity),
                radius: AppTokens.ElevationMapping.level1.radius,
                x: 0, 
                y: AppTokens.ElevationMapping.level1.dy)
    }
}

struct PriceUpdateLogItem: View {
    let product: Product

    var body: some View {
                HStack {
            Text("\(product.name) (\(product.store))")
                .font(AppTokens.TypographyTokens.body)
                .foregroundColor(AppTokens.Colors.onSurface)
            Spacer() 
            Text(product.price)
                .font(AppTokens.TypographyTokens.label)
                .foregroundColor(AppTokens.Colors.secondary)
        }
                .padding(AppTokens.Spacing.md)
        .background(AppTokens.Colors.surface) 
        .cornerRadius(AppTokens.Shapes.small) 
    }
}

@main
struct PriceCompareApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}