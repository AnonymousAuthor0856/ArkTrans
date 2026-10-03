import SwiftUI


struct AppTokens {
        struct Colors {
        static let primary = Color(hex: 0xFF0F172A)
        static let secondary = Color(hex: 0xFF475569)
        static let tertiary = Color(hex: 0xFF94A3B8)
        static let background = Color(hex: 0xFFF8FAFC)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFF1F5F9)
        static let outline = Color(hex: 0xFFE2E8F0)
        static let success = Color(hex: 0xFF22C55E)
        static let warning = Color(hex: 0xFFF59E0B)
        static let error = Color(hex: 0xFFEF4444)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFFFFFFFF)
        static let onTertiary = Color(hex: 0xFF0F172A)
        static let onBackground = Color(hex: 0xFF0F172A)
        static let onSurface = Color(hex: 0xFF0F172A)
    }

        struct TypographyTokens {
                struct Style {
            let font: Font
            let fontSize: CGFloat 
            let lineHeight: CGFloat
            let letterSpacing: CGFloat

                                    var lineSpacingValue: CGFloat {
                return max(0, lineHeight - fontSize)
            }
        }

        static let display = Style(font: .system(size: 32, weight: .bold), fontSize: 32, lineHeight: 40, letterSpacing: 0)
        static let headline = Style(font: .system(size: 24, weight: .semibold), fontSize: 24, lineHeight: 32, letterSpacing: 0)
        static let title = Style(font: .system(size: 18, weight: .medium), fontSize: 18, lineHeight: 24, letterSpacing: 0.15)
        static let body = Style(font: .system(size: 16, weight: .regular), fontSize: 16, lineHeight: 22, letterSpacing: 0.5)
        static let label = Style(font: .system(size: 14, weight: .medium), fontSize: 14, lineHeight: 18, letterSpacing: 0.5)
    }

        struct Shapes {
        static let smallCornerRadius: CGFloat = 8
        static let mediumCornerRadius: CGFloat = 12
        static let largeCornerRadius: CGFloat = 16
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
        static let level1 = ShadowSpec(elevation: 1, radius: 3, dy: 1, opacity: 0.10)
        static let level2 = ShadowSpec(elevation: 3, radius: 6, dy: 2, opacity: 0.10)
        static let level3 = ShadowSpec(elevation: 6, radius: 10, dy: 4, opacity: 0.10)
    }
}


extension Color {
    init(hex: UInt) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
                        opacity: Double((hex >> 24) & 0xFF) == 0 ? 1.0 : Double((hex >> 24) & 0xFF) / 255.0
        )
    }
}

extension Text {
    func appStyle(_ style: AppTokens.TypographyTokens.Style) -> Text {
        self.font(style.font)

    }
}


struct ProductivityItem: Identifiable {
    let id: Int
    let title: String
    let status: String
    let progress: Float
    let statusColor: Color
}

struct ChartData: Identifiable {
    let id = UUID() 
    let label: String
    let value: Float
}


struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .appStyle(AppTokens.TypographyTokens.label)
                .foregroundColor(isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                .padding(.horizontal, AppTokens.Spacing.md)
                .padding(.vertical, AppTokens.Spacing.sm)
                .background(
                    isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface
                )
                .cornerRadius(AppTokens.Shapes.smallCornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: AppTokens.Shapes.smallCornerRadius)
                        .stroke(AppTokens.Colors.outline, lineWidth: 1)
                )
        }
    }
}

struct CustomLinearProgressIndicator: View {
    let progress: Float
    let color: Color
    let trackColor: Color
    let height: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: height / 2) 
                    .fill(trackColor)
                    .frame(height: height)

                RoundedRectangle(cornerRadius: height / 2) 
                    .fill(color)
                    .frame(width: geometry.size.width * CGFloat(progress), height: height)
            }
        }
        .frame(height: height)
    }
}


struct RootScreen: View {
    @State private var selectedFilter: String = "Weekly"

    let filters = ["Daily", "Weekly", "Monthly"]
    let productivityItems: [ProductivityItem] = [
        ProductivityItem(id: 1, title: "Form Batch #A-102", status: "Completed", progress: 1.0, statusColor: AppTokens.Colors.success),
        ProductivityItem(id: 2, title: "Invoice Set #B-231", status: "In Progress", progress: 0.75, statusColor: AppTokens.Colors.warning),
        ProductivityItem(id: 3, title: "Document Scan #C-456", status: "Pending", progress: 0.1, statusColor: AppTokens.Colors.secondary),
        ProductivityItem(id: 4, title: "Form Batch #A-103", status: "Completed", progress: 1.0, statusColor: AppTokens.Colors.success),
        ProductivityItem(id: 5, title: "Data Entry #D-789", status: "Failed", progress: 0.4, statusColor: AppTokens.Colors.error)
    ]

    let chartData: [ChartData] = [
        ChartData(label: "Mon", value: 0.6), ChartData(label: "Tue", value: 0.8), ChartData(label: "Wed", value: 0.5),
        ChartData(label: "Thu", value: 1.0), ChartData(label: "Fri", value: 0.7), ChartData(label: "Sat", value: 0.4),
        ChartData(label: "Sun", value: 0.2)
    ]

    let topBarHeight: CGFloat = 56 
    let bottomBarButtonHeight: CGFloat = 56 
    let bottomBarPadding: CGFloat = AppTokens.Spacing.md 
    var bottomBarTotalHeight: CGFloat {
        return bottomBarButtonHeight + bottomBarPadding * 2 
    }

    var body: some View {
        VStack(spacing: 0) { 
                        HStack {
                Button(action: {}) {
                    Circle()
                        .fill(AppTokens.Colors.outline)
                        .frame(width: 24, height: 24)
                }
                .padding(.leading, AppTokens.Spacing.md) 

                Spacer()

                Text("Productivity Check")
                    .appStyle(AppTokens.TypographyTokens.headline)
                    .foregroundColor(AppTokens.Colors.onSurface)

                Spacer()

                Button(action: {}) {
                    Circle()
                        .fill(AppTokens.Colors.outline)
                        .frame(width: 24, height: 24)
                }
                .padding(.trailing, AppTokens.Spacing.md) 
            }
            .frame(height: topBarHeight)
            .background(AppTokens.Colors.surface)
            .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level3.opacity),
                    radius: AppTokens.ElevationMapping.level3.radius,
                    x: 0,
                    y: AppTokens.ElevationMapping.level3.dy)
            .zIndex(1) 

                        ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: AppTokens.Spacing.lg) { 
                                        HStack(alignment: .center) {
                        ForEach(filters, id: \.self) { filter in
                            FilterChip(title: filter, isSelected: selectedFilter == filter) {
                                selectedFilter = filter
                            }
                            if filter != filters.last {
                                Spacer().frame(width: AppTokens.Spacing.sm) 
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, AppTokens.Spacing.md) 
                    
                                        VStack(alignment: .leading, spacing: 0) {
                        Text("Weekly Throughput")
                            .appStyle(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.onSurface)
                            .padding(.bottom, AppTokens.Spacing.md) 

                                                VStack(spacing: AppTokens.Spacing.sm) {
                            GeometryReader { geometry in
                                HStack(alignment: .bottom, spacing: 0) { 
                                    ForEach(chartData) { data in
                                        VStack {
                                            Spacer() 
                                            RoundedRectangle(cornerRadius: AppTokens.Shapes.smallCornerRadius)
                                                .fill(AppTokens.Colors.primary)
                                                .frame(width: geometry.size.width / CGFloat(chartData.count) * 0.6, 
                                                       height: geometry.size.height * CGFloat(data.value)) 
                                        }
                                        .frame(maxWidth: .infinity) 
                                    }
                                }
                            }
                            .frame(height: 150) 

                                                        HStack(spacing: 0) {
                                ForEach(chartData) { data in
                                    Text(data.label)
                                        .appStyle(AppTokens.TypographyTokens.label)
                                        .foregroundColor(AppTokens.Colors.secondary)
                                        .multilineTextAlignment(.center)
                                        .frame(maxWidth: .infinity) 
                                }
                            }
                        }
                    }
                    .padding(AppTokens.Spacing.md)
                    .background(AppTokens.Colors.surface)
                    .cornerRadius(AppTokens.Shapes.largeCornerRadius)
                    .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity),
                            radius: AppTokens.ElevationMapping.level1.radius,
                            x: 0,
                            y: AppTokens.ElevationMapping.level1.dy)
                    .padding(.horizontal, AppTokens.Spacing.md) 

                                        ForEach(productivityItems) { item in
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(alignment: .center) { 
                                Text(item.title)
                                    .appStyle(AppTokens.TypographyTokens.title)
                                    .foregroundColor(AppTokens.Colors.onSurface)

                                Spacer() 

                                HStack(spacing: AppTokens.Spacing.sm) {
                                    Circle()
                                        .fill(item.statusColor)
                                        .frame(width: 10, height: 10)

                                    Text(item.status)
                                        .appStyle(AppTokens.TypographyTokens.label)
                                        .foregroundColor(item.statusColor)
                                }
                            }
                            .padding(.bottom, AppTokens.Spacing.md) 

                            HStack(alignment: .center, spacing: AppTokens.Spacing.sm) {
                                CustomLinearProgressIndicator(
                                    progress: item.progress,
                                    color: item.statusColor,
                                    trackColor: AppTokens.Colors.surfaceVariant,
                                    height: 8
                                )
                                .frame(maxWidth: .infinity) 

                                Text("\(Int(item.progress * 100))%")
                                    .appStyle(AppTokens.TypographyTokens.label)
                                    .foregroundColor(AppTokens.Colors.secondary)
                                    .multilineTextAlignment(.trailing)
                                    .frame(width: 40) 
                            }
                        }
                        .padding(AppTokens.Spacing.md)
                        .background(AppTokens.Colors.surface)
                        .cornerRadius(AppTokens.Shapes.mediumCornerRadius)
                        .overlay(
                            RoundedRectangle(cornerRadius: AppTokens.Shapes.mediumCornerRadius)
                                .stroke(AppTokens.Colors.outline, lineWidth: 1)
                        )
                        .padding(.horizontal, AppTokens.Spacing.md) 
                    }
                }
                .padding(.vertical, AppTokens.Spacing.md) 
                                .padding(.bottom, bottomBarTotalHeight)
            }
            .background(AppTokens.Colors.background) 

                        VStack {
                Button(action: {}) {
                    Text("Submit New Form")
                        .appStyle(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onPrimary)
                        .frame(maxWidth: .infinity)
                        .frame(height: bottomBarButtonHeight) 
                        .background(AppTokens.Colors.primary)
                        .cornerRadius(AppTokens.Shapes.mediumCornerRadius)
                }
                .padding(AppTokens.Spacing.md) 
            }
            .background(AppTokens.Colors.surface)
            .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level3.opacity),
                    radius: AppTokens.ElevationMapping.level3.radius,
                    x: 0,
                    y: AppTokens.ElevationMapping.level3.dy)
            .zIndex(1) 
        }
                .ignoresSafeArea(.all, edges: .all) 
        .statusBarHidden(true) 
    }
}


@main
struct ProductivityApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}
