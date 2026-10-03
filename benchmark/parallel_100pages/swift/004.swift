import SwiftUI

@main
struct FinanceWalletApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0x1F2937)
        static let secondary = Color(hex: 0x10B981)
        static let tertiary = Color(hex: 0x3B82F6)
        static let background = Color(hex: 0xF3F4F6)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xE5E7EB)
        static let outline = Color(hex: 0xD1D5DB)
        static let success = Color(hex: 0x16A34A)
        static let warning = Color(hex: 0xF59E0B)
        static let error = Color(hex: 0xEF4444)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0x0B1220)
        static let onSurface = Color(hex: 0x0B1220)
    }
    
    struct Typography {
        static let display = Font.system(size: 24, weight: .semibold)
        static let headline = Font.system(size: 18, weight: .semibold)
        static let title = Font.system(size: 14, weight: .medium)
        static let body = Font.system(size: 12, weight: .regular)
        static let label = Font.system(size: 10, weight: .medium)
    }
    
    struct Spacing {
        static let xs: CGFloat = 2
        static let sm: CGFloat = 4
        static let md: CGFloat = 6
        static let lg: CGFloat = 8
        static let xl: CGFloat = 12
        static let xxl: CGFloat = 16
        static let xxxl: CGFloat = 24
    }
    
    struct Shapes {
        static let small: CGFloat = 6
        static let medium: CGFloat = 8
        static let large: CGFloat = 12
    }
}

struct AccountCardModel: Identifiable {
    let id: Int
    let name: String
    let balance: String
    let accent: Color
}

struct TxItemModel: Identifiable {
    let id: Int
    let title: String
    let subtitle: String
    let amount: String
    let positive: BooleanLiteralType
}

struct ContentView: View {
        @State private var showBalance = true
    @State private var selectedFilter = "Month"
    @State private var flags: Set<String> = []
    
        let filters = ["All", "Week", "Month", "Year"]
    let accounts = [
        AccountCardModel(id: 1, name: "Wallet", balance: "$2,845.20", accent: Color(hex: 0x10B981)),
        AccountCardModel(id: 2, name: "Savings", balance: "$8,120.00", accent: Color(hex: 0x3B82F6)),
        AccountCardModel(id: 3, name: "Investments", balance: "$15,430.55", accent: Color(hex: 0xF59E0B))
    ]
    let transactions = [
        TxItemModel(id: 1, title: "Grocery Market", subtitle: "Today • 12:40", amount: "-$32.18", positive: false),
        TxItemModel(id: 2, title: "Salary", subtitle: "Yesterday • 09:00", amount: "+$3,200.00", positive: true),
        TxItemModel(id: 3, title: "Coffee Shop", subtitle: "Yesterday • 15:22", amount: "-$4.90", positive: false),
        TxItemModel(id: 4, title: "ETF Purchase", subtitle: "Mon • 10:05", amount: "-$250.00", positive: false),
        TxItemModel(id: 5, title: "Refund", subtitle: "Sun • 18:40", amount: "+$18.99", positive: true)
    ]
    
    var body: some View {
        ZStack {
                        AppTokens.Colors.background.ignoresSafeArea()
            
            VStack(spacing: 0) {
                                HStack(spacing: AppTokens.Spacing.sm) {
                    RoundedRectangle(cornerRadius: AppTokens.Shapes.small)
                        .fill(AppTokens.Colors.primary)
                        .frame(width: 20, height: 20)
                    Text("Wallet")
                        .font(AppTokens.Typography.display)
                        .foregroundColor(AppTokens.Colors.onSurface)
                    Spacer()
                }
                .padding()
                .background(AppTokens.Colors.background) 
                
                                ScrollView(showsIndicators: false) {
                    VStack(spacing: AppTokens.Spacing.lg) {
                        
                                                HStack {
                            HStack(spacing: AppTokens.Spacing.sm) {
                                ForEach(filters, id: \.self) { filter in
                                    FilterChip(
                                        label: filter,
                                        isSelected: selectedFilter == filter,
                                        onClick: { selectedFilter = filter }
                                    )
                                }
                            }
                            
                            Spacer()
                            
                            HStack(spacing: AppTokens.Spacing.sm) {
                                Text("Hide")
                                    .font(AppTokens.Typography.label)
                                    .foregroundColor(AppTokens.Colors.onSurface)
                                
                                Toggle("", isOn: Binding(
                                    get: { !showBalance },
                                    set: { showBalance = !$0 }
                                ))
                                .labelsHidden()
                                .toggleStyle(CustomSwitchStyle())
                                .frame(height: 24)
                            }
                        }
                        
                                                ForEach(accounts) { account in
                            AccountCardView(account: account, showBalance: showBalance)
                        }
                        
                                                HStack {
                            Text("Recent Activity")
                                .font(AppTokens.Typography.headline)
                                .foregroundColor(AppTokens.Colors.onSurface)
                            
                            Spacer()
                            
                            HStack(spacing: AppTokens.Spacing.sm) {
                                AssistChip(
                                    label: "Income",
                                    isSelected: flags.contains("Income"),
                                    onClick: {
                                        if flags.contains("Income") { flags.remove("Income") }
                                        else { flags.insert("Income") }
                                    }
                                )
                                AssistChip(
                                    label: "Expense",
                                    isSelected: flags.contains("Expense"),
                                    onClick: {
                                        if flags.contains("Expense") { flags.remove("Expense") }
                                        else { flags.insert("Expense") }
                                    }
                                )
                            }
                        }
                        
                                                ForEach(transactions) { tx in
                            TransactionCard(tx: tx)
                        }
                        
                                                Spacer().frame(height: 100)
                    }
                    .padding(.horizontal, AppTokens.Spacing.lg)
                    .padding(.vertical, AppTokens.Spacing.md)
                }
            }
            
                        VStack {
                Spacer()
                
                VStack {
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: AppTokens.Spacing.xs) {
                            Text("Total Balance")
                                .font(AppTokens.Typography.title) 
                                .foregroundColor(AppTokens.Colors.onSurface)
                            Text(showBalance ? "$26,395.75" : "•••••••")
                                .font(AppTokens.Typography.headline)
                                .foregroundColor(AppTokens.Colors.onSurface)
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Text("Add Money")
                                .font(AppTokens.Typography.title)
                                .foregroundColor(AppTokens.Colors.onSecondary)
                                .frame(width: 140, height: 44)
                                .background(AppTokens.Colors.secondary)
                                .cornerRadius(AppTokens.Shapes.large)
                        }
                    }
                    .padding(.horizontal, AppTokens.Spacing.lg)
                    .padding(.vertical, AppTokens.Spacing.md)
                }
                .background(AppTokens.Colors.surface)
                .shadow(color: Color.black.opacity(0.16), radius: 6, x: 0, y: -1.5) 
            }
        }
        .statusBarHidden(true)
    }
}


struct FilterChip: View {
    let label: String
    let isSelected: Bool
    let onClick: () -> Void
    
    var body: some View {
        Button(action: onClick) {
            Text(label)
                .font(isSelected ? AppTokens.Typography.title : AppTokens.Typography.body)
                .foregroundColor(isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                .cornerRadius(AppTokens.Shapes.medium)
                .overlay(
                    RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                        .stroke(AppTokens.Colors.outline, lineWidth: isSelected ? 0 : 1)
                )
        }
    }
}

struct AssistChip: View {
    let label: String
    let isSelected: Bool
    let onClick: () -> Void
    
    var body: some View {
        Button(action: onClick) {
            Text(label)
                .font(AppTokens.Typography.label)
                .foregroundColor(isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
                .padding(.horizontal, 8)
                .padding(.vertical, 6)
                .background(isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
                .cornerRadius(AppTokens.Shapes.small)
                .overlay(
                    RoundedRectangle(cornerRadius: AppTokens.Shapes.small)
                        .stroke(AppTokens.Colors.outline, lineWidth: 1)
                )
        }
    }
}

struct AccountCardView: View {
    let account: AccountCardModel
    let showBalance: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
                        HStack {
                HStack(spacing: AppTokens.Spacing.sm) {
                    RoundedRectangle(cornerRadius: AppTokens.Shapes.small)
                        .fill(account.accent)
                        .frame(width: 16, height: 16)
                    Text(account.name)
                        .font(AppTokens.Typography.title)
                        .foregroundColor(AppTokens.Colors.onSurface)
                }
                Spacer()
                Button(action: {}) {
                    Text("Manage")
                        .font(AppTokens.Typography.label)
                        .foregroundColor(AppTokens.Colors.onSecondary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(AppTokens.Colors.secondary)
                        .cornerRadius(AppTokens.Shapes.small)
                        .overlay(
                            RoundedRectangle(cornerRadius: AppTokens.Shapes.small)
                                .stroke(AppTokens.Colors.outline, lineWidth: 1)
                        )
                }
            }
            
                        ZStack {
                AppTokens.Colors.surfaceVariant
                Text(showBalance ? account.balance : "•••••••")
                    .font(AppTokens.Typography.headline)
                    .foregroundColor(AppTokens.Colors.onSurface)
            }
            .cornerRadius(AppTokens.Shapes.medium)
            .aspectRatio(2.8, contentMode: .fit)
            .frame(maxWidth: .infinity)
            
                        HStack(spacing: AppTokens.Spacing.sm) {
                                Button(action: {}) {
                    Text("Transfer")
                        .font(AppTokens.Typography.label)
                        .foregroundColor(AppTokens.Colors.onSecondary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 6)
                        .background(AppTokens.Colors.secondary)
                        .cornerRadius(AppTokens.Shapes.small)
                        .overlay(
                            RoundedRectangle(cornerRadius: AppTokens.Shapes.small)
                                .stroke(AppTokens.Colors.outline, lineWidth: 1)
                        )
                }
                
                                Button(action: {}) {
                    Text("Details")
                        .font(AppTokens.Typography.label)
                        .foregroundColor(AppTokens.Colors.onSurface)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 6)
                        .background(AppTokens.Colors.surface)
                        .cornerRadius(AppTokens.Shapes.small)
                        .overlay(
                            RoundedRectangle(cornerRadius: AppTokens.Shapes.small)
                                .stroke(AppTokens.Colors.outline, lineWidth: 1)
                        )
                }
            }
        }
        .padding(AppTokens.Spacing.lg)
        .background(AppTokens.Colors.surface)
        .cornerRadius(AppTokens.Shapes.large)
        .shadow(color: Color.black.opacity(0.14), radius: 4, x: 0, y: 1) 
        .overlay(
            RoundedRectangle(cornerRadius: AppTokens.Shapes.large)
                .stroke(AppTokens.Colors.outline, lineWidth: 1)
        )
        .frame(minHeight: 120)
    }
}

struct TransactionCard: View {
    let tx: TxItemModel
    
    var body: some View {
        HStack {
            HStack(spacing: AppTokens.Spacing.md) {
                RoundedRectangle(cornerRadius: AppTokens.Shapes.small)
                    .fill(tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
                    .frame(width: 32, height: 32)
                
                VStack(alignment: .leading, spacing: AppTokens.Spacing.xs) {
                    Text(tx.title)
                        .font(AppTokens.Typography.title)
                        .foregroundColor(AppTokens.Colors.onSurface)
                    Text(tx.subtitle)
                        .font(AppTokens.Typography.body)
                        .foregroundColor(AppTokens.Colors.onSurface)
                }
            }
            Spacer()
            Text(tx.amount)
                .font(AppTokens.Typography.title)
                .foregroundColor(tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
        }
        .padding(AppTokens.Spacing.lg)
        .frame(minHeight: 72)
        .background(AppTokens.Colors.surface)
        .cornerRadius(AppTokens.Shapes.large)
        .shadow(color: Color.black.opacity(0.12), radius: 2, x: 0, y: 0.5) 
        .overlay(
            RoundedRectangle(cornerRadius: AppTokens.Shapes.large)
                .stroke(AppTokens.Colors.outline, lineWidth: 1)
        )
    }
}

struct CustomSwitchStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(configuration.isOn ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                    .frame(width: 36, height: 20) 
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(AppTokens.Colors.outline, lineWidth: configuration.isOn ? 0 : 1)
                    )
                
                Circle()
                    .fill(configuration.isOn ? AppTokens.Colors.onPrimary : AppTokens.Colors.outline)
                    .padding(2)
                    .frame(width: 20, height: 20)
                    .offset(x: configuration.isOn ? 8 : -8)
            }
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)) {
                    configuration.isOn.toggle()
                }
            }
        }
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}