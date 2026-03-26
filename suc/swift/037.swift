import SwiftUI

// MARK: - Custom Hosting Controller to hide status bar
class CustomHostingController<Content: View>: UIHostingController<Content> {
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 确保视图背景正确设置
        view.backgroundColor = UIColor(AppTokens.Colors.background)
    }
}

// MARK: - UIViewControllerRepresentable for Custom Hosting Controller
struct StatusBarHiddenView<Content: View>: UIViewControllerRepresentable {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    func makeUIViewController(context: Context) -> CustomHostingController<Content> {
        return CustomHostingController(rootView: content)
    }
    
    func updateUIViewController(_ uiViewController: CustomHostingController<Content>, context: Context) {
        // 更新内容
    }
}

// MARK: - Main Entry Point
@main
struct BudgetPieApp: App {
    var body: some Scene {
        WindowGroup {
            StatusBarHiddenView {
                ContentView()
            }
        }
    }
}

// MARK: - App Tokens & Colors
struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0x4A5568)
        static let secondary = Color(hex: 0x718096)
        static let tertiary = Color(hex: 0xA0AEC0)
        static let background = Color(hex: 0xF7FAFC)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xEDF2F7)
        static let outline = Color(hex: 0xE2E8F0)
        static let success = Color(hex: 0x48BB78)
        static let warning = Color(hex: 0xF59E0B)
        static let error = Color(hex: 0xF56565)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFFFFFFFF)
        static let onTertiary = Color(hex: 0x1A202C)
        static let onBackground = Color(hex: 0x1A202C)
        static let onSurface = Color(hex: 0x1A202C)
        
        // Gradients
        static let gradient1 = LinearGradient(colors: [Color(hex: 0x63B3ED), Color(hex: 0x4299E1)], startPoint: .top, endPoint: .bottom)
        static let gradient2 = LinearGradient(colors: [Color(hex: 0x4FD1C5), Color(hex: 0x38B2AC)], startPoint: .top, endPoint: .bottom)
        static let gradient3 = LinearGradient(colors: [Color(hex: 0x667EEA), Color(hex: 0x5A67D8)], startPoint: .top, endPoint: .bottom)
        static let gradient4 = LinearGradient(colors: [Color(hex: 0xED64A6), Color(hex: 0xD53F8C)], startPoint: .top, endPoint: .bottom)
        static let gradient5 = LinearGradient(colors: [Color(hex: 0xF6AD55), Color(hex: 0xED8936)], startPoint: .top, endPoint: .bottom)
    }
    
    struct Typography {
        static let display = Font.system(size: 36, weight: .bold)
        static let headline = Font.system(size: 24, weight: .semibold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 16, weight: .regular)
        static let label = Font.system(size: 14, weight: .medium)
    }
    
    struct Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 48
    }
    
    struct Shapes {
        static let small: CGFloat = 4
        static let medium: CGFloat = 8
        static let large: CGFloat = 16
    }
    
    struct Elevation {
        static let level1: CGFloat = 1
        static let level2: CGFloat = 4
        static let level3: CGFloat = 8
    }
}

// MARK: - Models
struct BudgetItem: Identifiable {
    let id = UUID()
    let name: String
    let value: Double
    let gradient: LinearGradient
}

// MARK: - Root View
struct ContentView: View {
    // Data
    let budgetData: [BudgetItem] = [
        BudgetItem(name: "Housing", value: 1250.00, gradient: AppTokens.Colors.gradient1),
        BudgetItem(name: "Food", value: 480.50, gradient: AppTokens.Colors.gradient2),
        BudgetItem(name: "Transport", value: 210.75, gradient: AppTokens.Colors.gradient3),
        BudgetItem(name: "Entertainment", value: 150.00, gradient: AppTokens.Colors.gradient4),
        BudgetItem(name: "Utilities", value: 320.00, gradient: AppTokens.Colors.gradient5)
    ]
    
    var body: some View {
        ZStack {
            // Background
            AppTokens.Colors.background.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Bar - 从屏幕顶部开始
                HStack {
                    Spacer()
                    Text("Monthly Budget")
                        .font(AppTokens.Typography.headline)
                        .foregroundColor(AppTokens.Colors.primary)
                        .padding(.vertical, AppTokens.Spacing.md)
                    Spacer()
                }
                .background(AppTokens.Colors.background)
                
                // Scrollable Content
                ScrollView(showsIndicators: false) {
                    VStack(spacing: AppTokens.Spacing.md) {
                        PieChart(items: budgetData, strokeWidth: 20)
                            .frame(width: 240, height: 240)
                            .padding(.vertical, AppTokens.Spacing.lg)
                        
                        // List Items
                        VStack(spacing: AppTokens.Spacing.md) {
                            ForEach(budgetData) { item in
                                CardView {
                                    BudgetItemRow(item: item)
                                }
                            }
                        }
                        
                        // Bottom Spacer for content padding
                        Spacer().frame(height: AppTokens.Spacing.xxl + 80)
                    }
                    .padding(.horizontal, AppTokens.Spacing.lg)
                }
            }
            
            // Bottom App Bar & FAB Overlay
            VStack {
                Spacer()
                
                ZStack(alignment: .top) {
                    // Bottom Bar Background
                    HStack(alignment: .center) {
                        BottomBarItem(text: "Home", active: true)
                        Spacer()
                        BottomBarItem(text: "Reports", active: false)
                        Spacer()
                        // Invisible placeholder for FAB space
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: 56)
                        Spacer()
                        BottomBarItem(text: "Goals", active: false)
                        Spacer()
                        BottomBarItem(text: "Settings", active: false)
                    }
                    .padding(.horizontal, AppTokens.Spacing.lg)
                    .frame(height: 80)
                    .background(AppTokens.Colors.surface)
                    .shadow(color: Color.black.opacity(0.1), radius: 15, x: 0, y: -5)
                    
                    // FAB
                    Button(action: {}) {
                        ZStack {
                            Circle()
                                .fill(AppTokens.Colors.primary)
                                .frame(width: 56, height: 56)
                                .shadow(radius: 4, y: 4)
                            
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(AppTokens.Colors.onPrimary)
                        }
                    }
                    .offset(y: -28)
                }
            }
        }
    }
}

// MARK: - Components

struct PieChart: View {
    let items: [BudgetItem]
    let strokeWidth: CGFloat
    
    // Helper struct to hold computed slice data
    struct SliceData: Identifiable {
        let id = UUID()
        let start: Angle
        let end: Angle
        let gradient: LinearGradient
    }
    
    // Compute slices based on items
    var slices: [SliceData] {
        let totalValue = items.map { $0.value }.reduce(0, +)
        var currentAngle = Angle(degrees: -90)
        var result: [SliceData] = []
        
        for item in items {
            let sweep = Angle(degrees: (item.value / totalValue) * 360)
            result.append(SliceData(start: currentAngle, end: currentAngle + sweep, gradient: item.gradient))
            currentAngle += sweep
        }
        return result
    }
    
    var totalValue: Double {
        items.map { $0.value }.reduce(0, +)
    }
    
    var body: some View {
        ZStack {
            ForEach(slices) { slice in
                PieSlice(startAngle: slice.start, endAngle: slice.end)
                    .stroke(slice.gradient, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .butt))
            }
            
            VStack(spacing: 0) {
                Text("Total Spent")
                    .font(AppTokens.Typography.label)
                    .foregroundColor(AppTokens.Colors.secondary)
                Text(formatCurrency(totalValue))
                    .font(AppTokens.Typography.headline)
                    .foregroundColor(AppTokens.Colors.primary)
            }
        }
    }
}

struct PieSlice: Shape {
    let startAngle: Angle
    let endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.width / 2,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false)
        return path
    }
}

struct CardView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .background(AppTokens.Colors.surface)
            .cornerRadius(AppTokens.Shapes.large)
            .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
    }
}

struct BudgetItemRow: View {
    let item: BudgetItem
    
    var body: some View {
        HStack(alignment: .center) {
            HStack(spacing: AppTokens.Spacing.md) {
                Circle()
                    .fill(item.gradient)
                    .frame(width: 20, height: 20)
                
                Text(item.name)
                    .font(AppTokens.Typography.body)
                    .foregroundColor(AppTokens.Colors.onSurface)
            }
            
            Spacer()
            
            Text(formatCurrency(item.value))
                .font(AppTokens.Typography.title)
                .foregroundColor(AppTokens.Colors.onSurface)
        }
        .padding(.vertical, AppTokens.Spacing.md)
        .padding(.horizontal, AppTokens.Spacing.md)
    }
}

struct BottomBarItem: View {
    let text: String
    let active: Bool
    
    var body: some View {
        VStack(spacing: AppTokens.Spacing.xs) {
            let color = active ? AppTokens.Colors.primary : AppTokens.Colors.tertiary
            
            Circle()
                .fill(color.opacity(0.2))
                .frame(width: 24, height: 24)
            
            Text(text)
                .font(AppTokens.Typography.label)
                .foregroundColor(color)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - Helpers

func formatCurrency(_ value: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale(identifier: "en_US")
    formatter.maximumFractionDigits = 2
    return formatter.string(from: NSNumber(value: value)) ?? "$0.00"
}

// MARK: - Color Hex Extension
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