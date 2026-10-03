import SwiftUI

enum ShoppingCartTokens {
    enum Colors {
        static let primary = Color.black
        static let secondary = Color(red: 255 / 255, green: 111 / 255, blue: 0 / 255)
        static let tertiary = Color(red: 76 / 255, green: 175 / 255, blue: 80 / 255)
        static let background = Color.white
        static let surface = Color.white
        static let surfaceVariant = Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255)
        static let outline = Color(red: 224 / 255, green: 224 / 255, blue: 224 / 255)
        static let error = Color(red: 244 / 255, green: 67 / 255, blue: 54 / 255)
        static let onPrimary = Color.white
        static let onBackground = Color.black
        static let onSurface = Color.black
    }

    enum Typography {
        static let display = Font.system(size: 22, weight: .semibold)
        static let headline = Font.system(size: 18, weight: .semibold)
        static let title = Font.system(size: 14, weight: .medium)
        static let body = Font.system(size: 12, weight: .regular)
        static let label = Font.system(size: 10, weight: .medium)
    }

    enum Shapes {
        static let small: CGFloat = 6
        static let medium: CGFloat = 8
        static let large: CGFloat = 12
    }

    enum Spacing {
        static let xs: CGFloat = 2
        static let sm: CGFloat = 4
        static let md: CGFloat = 6
        static let lg: CGFloat = 8
        static let xl: CGFloat = 12
        static let xxl: CGFloat = 16
        static let xxxl: CGFloat = 24
    }

    struct ShadowSpec {
        let radius: CGFloat
        let y: CGFloat
        let opacity: Double
    }

    enum Elevation {
        static let level1 = ShadowSpec(radius: 2, y: 0.5, opacity: 0.12)
        static let level2 = ShadowSpec(radius: 4, y: 1, opacity: 0.14)
        static let level3 = ShadowSpec(radius: 6, y: 1.5, opacity: 0.16)
        static let level4 = ShadowSpec(radius: 8, y: 2, opacity: 0.18)
        static let level5 = ShadowSpec(radius: 10, y: 2.5, opacity: 0.2)
    }
}

struct CartItem: Identifiable {
    let id: Int
    let name: String
    let price: Double
    let color: Color
}

struct ShoppingCartAppView: View {
    private let cartItems: [CartItem] = [
        CartItem(id: 1, name: "Wireless Headphones", price: 129.99, color: ShoppingCartTokens.Colors.secondary),
        CartItem(id: 2, name: "Smartphone Case", price: 24.99, color: ShoppingCartTokens.Colors.primary),
        CartItem(id: 3, name: "USB-C Cable", price: 19.99, color: ShoppingCartTokens.Colors.tertiary),
        CartItem(id: 4, name: "Portable Charger", price: 49.99, color: ShoppingCartTokens.Colors.secondary)
    ]

    @State private var quantities: [Int] = [1, 1, 1, 1]

    private let shipping: Double = 5.99
    private let tax: Double = 18.50
    private let bottomBarHeight: CGFloat = 220

    private var subtotal: Double {
        zip(cartItems, quantities).map { item, quantity in
            item.price * Double(quantity)
        }
        .reduce(0, +)
    }

    private var total: Double {
        subtotal + shipping + tax
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            ShoppingCartTokens.Colors.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                topBar
                    .padding(.top, 30)
                    .padding(.bottom, 20)
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: ShoppingCartTokens.Spacing.lg) {
                        ForEach(Array(cartItems.enumerated()), id: \.element.id) { index, item in
                            cartItemCard(item: item, index: index)
                        }
                        chipsRow
                    }
                    .padding(.horizontal, ShoppingCartTokens.Spacing.lg)
                    .padding(.top, ShoppingCartTokens.Spacing.md)
                    .padding(.bottom, bottomBarHeight + ShoppingCartTokens.Spacing.lg)
                }
            }

            bottomSummary
                .padding(.horizontal, ShoppingCartTokens.Spacing.lg)
                .padding(.bottom, ShoppingCartTokens.Spacing.md)
        }
        .statusBarHidden(true)
    }

    private var topBar: some View {
        HStack(spacing: ShoppingCartTokens.Spacing.sm) {
            RoundedRectangle(cornerRadius: ShoppingCartTokens.Shapes.small, style: .continuous)
                .fill(ShoppingCartTokens.Colors.primary)
                .frame(width: 20, height: 20)
            Text("Shopping Cart")
                .font(ShoppingCartTokens.Typography.display)
                .foregroundColor(ShoppingCartTokens.Colors.onSurface)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, ShoppingCartTokens.Spacing.xxl)
        .padding(.bottom, ShoppingCartTokens.Spacing.md)
    }

    private func cartItemCard(item: CartItem, index: Int) -> some View {
        HStack(spacing: ShoppingCartTokens.Spacing.lg) {
            RoundedRectangle(cornerRadius: ShoppingCartTokens.Shapes.medium, style: .continuous)
                .fill(item.color)
                .frame(width: 60, height: 60)

            VStack(alignment: .leading, spacing: ShoppingCartTokens.Spacing.xs) {
                Text(item.name)
                    .font(ShoppingCartTokens.Typography.title)
                    .foregroundColor(ShoppingCartTokens.Colors.onSurface)
                    .frame(maxWidth: 120, alignment: .leading)
                    .lineLimit(2)

                Text(String(format: "$%.2f", item.price))
                    .font(ShoppingCartTokens.Typography.headline)
                    .foregroundColor(ShoppingCartTokens.Colors.onSurface)

                HStack(spacing: ShoppingCartTokens.Spacing.sm) {
                    featureBox
                    featureBox
                    featureBox
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: ShoppingCartTokens.Spacing.sm) {
                quantityButton(symbol: "+") {
                    if quantities.indices.contains(index), quantities[index] < 10 {
                        quantities[index] += 1
                    }
                }
                Text("\(quantities.indices.contains(index) ? quantities[index] : 1)")
                    .font(ShoppingCartTokens.Typography.title)
                    .foregroundColor(ShoppingCartTokens.Colors.onSurface)
                quantityButton(symbol: "-") {
                    if quantities.indices.contains(index), quantities[index] > 1 {
                        quantities[index] -= 1
                    }
                }
            }

            Button(action: {}) {
                Text("Remove")
                    .font(ShoppingCartTokens.Typography.label)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: 85, height: 36)
            .background(
                RoundedRectangle(cornerRadius: ShoppingCartTokens.Shapes.medium, style: .continuous)
                    .fill(ShoppingCartTokens.Colors.error)
            )
            .foregroundColor(ShoppingCartTokens.Colors.onPrimary)
        }
        .padding(ShoppingCartTokens.Spacing.lg)
        .frame(maxWidth: .infinity, minHeight: 100, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: ShoppingCartTokens.Shapes.large, style: .continuous)
                .fill(ShoppingCartTokens.Colors.surface)
        )
        .overlay(
            RoundedRectangle(cornerRadius: ShoppingCartTokens.Shapes.large, style: .continuous)
                .stroke(ShoppingCartTokens.Colors.outline, lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(ShoppingCartTokens.Elevation.level2.opacity),
                radius: ShoppingCartTokens.Elevation.level2.radius,
                x: 0,
                y: ShoppingCartTokens.Elevation.level2.y)
    }

    private var featureBox: some View {
        RoundedRectangle(cornerRadius: ShoppingCartTokens.Shapes.small, style: .continuous)
            .fill(ShoppingCartTokens.Colors.surfaceVariant)
            .frame(width: 28, height: 28)
    }

    private func quantityButton(symbol: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(symbol)
                .font(ShoppingCartTokens.Typography.title)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(width: 28, height: 28)
        .background(
            RoundedRectangle(cornerRadius: ShoppingCartTokens.Shapes.small, style: .continuous)
                .fill(ShoppingCartTokens.Colors.surfaceVariant)
        )
        .foregroundColor(ShoppingCartTokens.Colors.onSurface)
    }

    private var chipsRow: some View {
        let chips = ["Apply Coupon", "Gift Wrap", "Save for Later"]
        return HStack(spacing: ShoppingCartTokens.Spacing.sm) {
            ForEach(chips, id: \.self) { label in
                Button(action: {}) {
                    Text(label)
                        .font(ShoppingCartTokens.Typography.label)
                        .padding(.horizontal, ShoppingCartTokens.Spacing.xl)
                        .padding(.vertical, ShoppingCartTokens.Spacing.sm)
                }
                .background(
                    RoundedRectangle(cornerRadius: ShoppingCartTokens.Shapes.small, style: .continuous)
                        .fill(ShoppingCartTokens.Colors.surface)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: ShoppingCartTokens.Shapes.small, style: .continuous)
                        .stroke(ShoppingCartTokens.Colors.outline, lineWidth: 1)
                )
                .foregroundColor(ShoppingCartTokens.Colors.onSurface)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var bottomSummary: some View {
        VStack(spacing: ShoppingCartTokens.Spacing.md) {
            summaryRow(title: "Subtotal", value: subtotal)
            summaryRow(title: "Shipping", value: shipping)
            summaryRow(title: "Tax", value: tax)
            summaryRow(title: "Total", value: total, emphasize: true)
            Button(action: {}) {
                Text("Proceed to Checkout")
                    .font(ShoppingCartTokens.Typography.title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(height: 44)
            .background(
                RoundedRectangle(cornerRadius: ShoppingCartTokens.Shapes.large, style: .continuous)
                    .fill(ShoppingCartTokens.Colors.primary)
            )
            .foregroundColor(ShoppingCartTokens.Colors.onPrimary)
        }
        .padding(ShoppingCartTokens.Spacing.lg)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: ShoppingCartTokens.Shapes.large, style: .continuous)
                .fill(ShoppingCartTokens.Colors.surface)
        )
        .shadow(color: Color.black.opacity(ShoppingCartTokens.Elevation.level3.opacity),
                radius: ShoppingCartTokens.Elevation.level3.radius,
                x: 0,
                y: ShoppingCartTokens.Elevation.level3.y)
    }

    private func summaryRow(title: String, value: Double, emphasize: Bool = false) -> some View {
        HStack {
            Text(title)
                .font(emphasize ? ShoppingCartTokens.Typography.headline : ShoppingCartTokens.Typography.body)
                .foregroundColor(ShoppingCartTokens.Colors.onSurface)
            Spacer()
            Text(String(format: "$%.2f", value))
                .font(emphasize ? ShoppingCartTokens.Typography.headline : ShoppingCartTokens.Typography.title)
                .foregroundColor(ShoppingCartTokens.Colors.onSurface)
        }
    }
}

struct ShoppingCartAppView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCartAppView()
    }
}

@main
struct ShoppingCartApp: App {
    var body: some Scene {
        WindowGroup {
            ShoppingCartAppView()
                .statusBarHidden(true)
                .background(ShoppingCartTokens.Colors.background.ignoresSafeArea())
        }
    }
}
