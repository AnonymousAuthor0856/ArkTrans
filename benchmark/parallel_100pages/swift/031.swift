import SwiftUI

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
                                static let display = Font.system(size: 48, weight: .bold) 
        static let headline = Font.system(size: 28, weight: .semibold) 
        static let title = Font.system(size: 20, weight: .medium) 
        static let body = Font.system(size: 16, weight: .regular) 
        static let label = Font.system(size: 12, weight: .medium) 
    }

    struct Shapes {
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
        let elevation: CGFloat 
        let radius: CGFloat
        let dy: CGFloat 
        let opacity: Double
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 1, radius: 3, dy: 1, opacity: 0.05)
        static let level2 = ShadowSpec(elevation: 4, radius: 8, dy: 2, opacity: 0.08)
        static let level3 = ShadowSpec(elevation: 8, radius: 12, dy: 4, opacity: 0.10)
    }
}

struct Transaction: Identifiable {
    let id: Int
    let name: String
    let detail: String
    let amount: String
    let isCredit: Bool
}

struct ControlAction: Identifiable {
    let id = UUID() 
    let label: String
}

struct NavItem: Identifiable {
    let id = UUID() 
    let label: String
}

struct RootScreen: View {
    @State private var selectedNavItem: String = "Home" 

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
                        AppTokens.Colors.background.ignoresSafeArea(.all)

            VStack(spacing: 0) {
                                topAppBar()
                    .padding(.horizontal, AppTokens.Spacing.md) 
                    .padding(.vertical, AppTokens.Spacing.sm) 
                    .background(AppTokens.Colors.background.opacity(0.01)) 
                    .ignoresSafeArea(.container, edges: .top) 

                                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: AppTokens.Spacing.lg) { 
                                                totalBalanceCard()

                                                controlActionsRow()

                                                recentActivityHeader()

                                                ForEach(transactions) { transaction in
                            transactionCard(transaction: transaction)
                        }
                    }
                    .padding(.horizontal, AppTokens.Spacing.md) 
                    .padding(.vertical, AppTokens.Spacing.sm) 
                }
                                .padding(.bottom, AppTokens.Spacing.sm)

                                bottomNavigationBar()
                                        .shadow(color: .black.opacity(AppTokens.ElevationMapping.level3.opacity),
                            radius: AppTokens.ElevationMapping.level3.radius,
                            x: 0,
                            y: AppTokens.ElevationMapping.level3.dy)
                    .ignoresSafeArea(.container, edges: .bottom) 
            }
        }
                .statusBarHidden(true)
    }

            private func topAppBar() -> some View {
        HStack {
            Button(action: {}) {
                Circle()
                    .fill(AppTokens.Colors.surfaceVariant)
                    .frame(width: 28, height: 28)
            }
            Spacer()
            Text("My Wallet")
                .font(AppTokens.TypographyTokens.title) 
                .foregroundColor(AppTokens.Colors.onBackground)
            Spacer()
            Button(action: {}) {
                Circle()
                    .fill(AppTokens.Colors.surfaceVariant)
                    .frame(width: 28, height: 28)
            }
        }
        .frame(height: 56) 
    }

        private func totalBalanceCard() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Total Balance")
                .font(AppTokens.TypographyTokens.body) 
                .foregroundColor(AppTokens.Colors.onPrimary.opacity(0.7))
            Spacer().frame(height: AppTokens.Spacing.sm)
            Text("$ 1,145.14")
                .font(AppTokens.TypographyTokens.display) 
                .kerning(-0.5) 
                .foregroundColor(AppTokens.Colors.onPrimary)
            Spacer().frame(height: AppTokens.Spacing.xs)
            HStack(alignment: .center, spacing: AppTokens.Spacing.sm) {
                Circle()
                    .fill(AppTokens.Colors.secondary)
                    .frame(width: 10, height: 10)
                Text("+$234.10 today")
                    .font(AppTokens.TypographyTokens.body) 
                    .foregroundColor(AppTokens.Colors.secondary)
            }
        }
        .padding(AppTokens.Spacing.lg)
        .frame(maxWidth: .infinity) 
        .background(AppTokens.Colors.primary)
        .clipShape(AppTokens.Shapes.large) 
                .shadow(color: .black.opacity(AppTokens.ElevationMapping.level2.opacity),
                radius: AppTokens.ElevationMapping.level2.radius,
                x: 0,
                y: AppTokens.ElevationMapping.level2.dy)
    }

        private func controlActionsRow() -> some View {
        HStack(alignment: .center, spacing: 0) { 
            ForEach(controlActions) { action in
                VStack(spacing: AppTokens.Spacing.sm) {
                    Button(action: {}) {
                                                AppTokens.Shapes.small
                            .fill(AppTokens.Colors.primary)
                            .frame(width: 24, height: 24)
                            .contentShape(Circle()) 
                    }
                    .frame(width: 64, height: 64) 
                    .background(AppTokens.Colors.surface) 
                    .clipShape(Circle()) 
                                        .shadow(color: .black.opacity(AppTokens.ElevationMapping.level1.opacity),
                            radius: AppTokens.ElevationMapping.level1.radius,
                            x: 0,
                            y: AppTokens.ElevationMapping.level1.dy)
                    .buttonStyle(PlainButtonStyle()) 
                    .padding(0) 

                    Text(action.label)
                        .font(AppTokens.TypographyTokens.label) 
                        .kerning(0.2) 
                        .foregroundColor(AppTokens.Colors.onBackground)
                }
                .frame(maxWidth: .infinity) 
            }
        }
    }

        private func recentActivityHeader() -> some View {
        HStack {
            Text("Recent Activity")
                .font(AppTokens.TypographyTokens.title) 
                .foregroundColor(AppTokens.Colors.onBackground)
            Spacer()
            Button(action: {}) {
                Text("View All")
                    .font(AppTokens.TypographyTokens.label) 
                    .kerning(0.2) 
                    .foregroundColor(AppTokens.Colors.tertiary)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }

        private func transactionCard(transaction: Transaction) -> some View {
        HStack(spacing: AppTokens.Spacing.md) {
            AppTokens.Shapes.medium 
                .fill(AppTokens.Colors.surfaceVariant)
                .frame(width: 48, height: 48)

            VStack(alignment: .leading) {
                Text(transaction.name)
                    .font(AppTokens.TypographyTokens.body) 
                    .fontWeight(.semibold)
                    .foregroundColor(AppTokens.Colors.onSurface)
                Text(transaction.detail)
                    .font(AppTokens.TypographyTokens.label) 
                    .kerning(0.2) 
                    .foregroundColor(AppTokens.Colors.tertiary)
            }
            .frame(maxWidth: .infinity, alignment: .leading) 

            Text(transaction.amount)
                .font(AppTokens.TypographyTokens.body) 
                .fontWeight(.semibold)
                .foregroundColor(transaction.isCredit ? AppTokens.Colors.success : AppTokens.Colors.onSurface)
                .multilineTextAlignment(.trailing) 
        }
        .padding(AppTokens.Spacing.md)
        .frame(maxWidth: .infinity) 
        .background(AppTokens.Colors.surface) 
        .clipShape(AppTokens.Shapes.medium) 
                .overlay(
            AppTokens.Shapes.medium.stroke(AppTokens.Colors.outline, lineWidth: 1)
        )
    }

        private func bottomNavigationBar() -> some View {
        HStack(spacing: 0) {
            ForEach(navItems) { item in
                Button(action: {
                    selectedNavItem = item.label
                }) {
                    VStack(spacing: AppTokens.Spacing.xs) { 
                        Circle() 
                            .fill(selectedNavItem == item.label ? AppTokens.Colors.primary : AppTokens.Colors.outline)
                            .frame(width: 24, height: 24)
                        Text(item.label)
                            .font(AppTokens.TypographyTokens.label) 
                            .kerning(0.2) 
                            .foregroundColor(selectedNavItem == item.label ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
                    }
                    .frame(maxWidth: .infinity) 
                    .padding(.vertical, AppTokens.Spacing.sm) 
                                        .background(selectedNavItem == item.label ? AppTokens.Colors.surfaceVariant : Color.clear)
                    .clipShape(RoundedRectangle(cornerRadius: AppTokens.Shapes.medium.cornerRadius)) 
                }
                .buttonStyle(PlainButtonStyle()) 
            }
        }
        .padding(.horizontal, AppTokens.Spacing.xs) 
        .frame(height: 80) 
        .background(AppTokens.Colors.surface) 
    }
}

@main
struct SingleFileUIApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
            .previewDisplayName("My Wallet UI")
    }
}