//
//  ContentView.swift
//  1
//
//  Created by hang on 2025/10/12.
//

import SwiftUI

// MARK: - Design Tokens - Exact values from Kotlin
struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFF0EA5E9)
        static let secondary = Color(hex: 0xFF22C55E)
        static let tertiary = Color(hex: 0xFFF59E0B)
        static let background = Color(hex: 0xFFF7FAFC)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFEFF3F7)
        static let outline = Color(hex: 0xFFD4D9E1)
        static let success = Color(hex: 0xFF16A34A)
        static let warning = Color(hex: 0xFFF59E0B)
        static let error = Color(hex: 0xFFEF4444)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFF0F172A)
        static let onTertiary = Color(hex: 0xFF111827)
        static let onBackground = Color(hex: 0xFF0B1220)
        static let onSurface = Color(hex: 0xFF0B1220)
    }
    
    struct TypographyTokens {
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
        static let small = RoundedRectangle(cornerRadius: 6)
        static let medium = RoundedRectangle(cornerRadius: 8)
        static let large = RoundedRectangle(cornerRadius: 12)
    }
}

extension Color {
    init(hex: UInt) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}

// MARK: - Data Models
struct MetricCardUi: Identifiable {
    let id: Int
    let title: String
    let value: String
    let delta: String
    let color: Color
}

struct ChartCardUi: Identifiable {
    let id: Int
    let title: String
    let color: Color
}

// MARK: - Main Content View
struct ContentView: View {
    @State private var selectedRange = "7 Days"
    @State private var selectedFlags: Set<String> = []
    @State private var darkMode = false
    @State private var notificationCount = 2
    
    private let ranges = ["Today", "7 Days", "30 Days", "90 Days"]
    private let ranges2 = ["YTD", "Custom"]
    private let flags = ["Prev Period", "Goal"]
    
    private let kpis: [MetricCardUi] = [
        MetricCardUi(id: 1, title: "Revenue", value: "$24,560", delta: "+8.2%", color: AppTokens.Colors.secondary),
        MetricCardUi(id: 2, title: "Orders", value: "1,284", delta: "+3.1%", color: AppTokens.Colors.primary),
        MetricCardUi(id: 3, title: "Refunds", value: "42", delta: "-1.4%", color: AppTokens.Colors.error),
        MetricCardUi(id: 4, title: "Active Users", value: "8,921", delta: "+5.6%", color: AppTokens.Colors.tertiary)
    ]
    
    private let charts: [ChartCardUi] = [
        ChartCardUi(id: 1, title: "Sales Trend", color: Color(hex: 0xFFE0F2FE)),
        ChartCardUi(id: 2, title: "Conversion Funnel", color: Color(hex: 0xFFEFF6FF))
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header - Exact replica of CenterAlignedTopAppBar
                HStack {
                    Spacer()
                    HStack(spacing: AppTokens.Spacing.sm) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(AppTokens.Colors.primary)
                            .frame(width: 20, height: 20)
                        
                        Text("Analytics")
                            .font(AppTokens.TypographyTokens.display)
                            .foregroundColor(AppTokens.Colors.onSurface)
                    }
                    Spacer()
                }
                .padding(.top, 48)
                .padding(.bottom, 12)
                .background(AppTokens.Colors.background)
                Divider()
                // Content
                ScrollView {
                    VStack(alignment: .leading, spacing: AppTokens.Spacing.md) {
                        // Date Range Selector
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: AppTokens.Spacing.sm) {
                                ForEach(ranges, id: \.self) { range in
                                    Button(action: { selectedRange = range }) {
                                        Text(range)
                                            .font(selectedRange == range ? AppTokens.TypographyTokens.title : AppTokens.TypographyTokens.body)
                                            .foregroundColor(selectedRange == range ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 8)
                                    }
                                    .background(
                                        AppTokens.Shapes.medium
                                            .fill(selectedRange == range ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                                    )
                                    .overlay(
                                        AppTokens.Shapes.medium
                                            .stroke(AppTokens.Colors.outline, lineWidth: 1)
                                    )
                                }
                            }
                            .padding(.vertical, 4)
                            HStack(spacing: AppTokens.Spacing.sm) {
                                ForEach(ranges2, id: \.self) { range in
                                    Button(action: { selectedRange = range }) {
                                        Text(range)
                                            .font(selectedRange == range ? AppTokens.TypographyTokens.title : AppTokens.TypographyTokens.body)
                                            .foregroundColor(selectedRange == range ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 10)
                                    }
                                    .background(
                                        AppTokens.Shapes.medium
                                            .fill(selectedRange == range ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                                    )
                                    .overlay(
                                        AppTokens.Shapes.medium
                                            .stroke(AppTokens.Colors.outline, lineWidth: 1)
                                    )
                                }
                                Spacer()
                            }
                            .padding(.vertical, 8)
                        }
                        
                        
                        // Comparison Options
                        HStack(spacing: AppTokens.Spacing.sm) {
                            Text("Compare")
                                .font(AppTokens.TypographyTokens.label)
                                .foregroundColor(AppTokens.Colors.onSurface)
                            
                            ForEach(flags, id: \.self) { flag in
                                Button(action: {
                                    if selectedFlags.contains(flag) {
                                        selectedFlags.remove(flag)
                                    } else {
                                        selectedFlags.insert(flag)
                                    }
                                }) {
                                    Text(flag)
                                        .font(AppTokens.TypographyTokens.label)
                                        .foregroundColor(selectedFlags.contains(flag) ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
                                        .lineLimit(1)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 10)
                                }
                                .background(
                                    AppTokens.Shapes.small
                                        .fill(selectedFlags.contains(flag) ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
                                )
                                .overlay(
                                    AppTokens.Shapes.small
                                        .stroke(AppTokens.Colors.outline, lineWidth: 1)
                                )
                            }
                            
                            // Dark Mode Toggle
                            HStack(spacing: AppTokens.Spacing.xs) {
                                Text("Dark")
                                    .font(AppTokens.TypographyTokens.label)
                                    .foregroundColor(AppTokens.Colors.onSurface)
                                Toggle(isOn: $darkMode){
                                    
                                }
                                .labelsHidden()
                                .toggleStyle(SwitchToggleStyle(tint: AppTokens.Colors.primary))
                                .scaleEffect(0.8)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.vertical, 6)
                        // Metrics Grid
                        LazyVGrid(
                            columns: [
                                GridItem(.flexible(), spacing: AppTokens.Spacing.lg),
                                GridItem(.flexible(), spacing: AppTokens.Spacing.lg)
                            ],
                            spacing: AppTokens.Spacing.lg
                        ) {
                            // First row: Revenue and Orders
                            MetricCardView(metric: kpis[0])
                            MetricCardView(metric: kpis[1])
                            
                            // Second row: Refunds and Active Users
                            MetricCardView(metric: kpis[2])
                            MetricCardView(metric: kpis[3])
                            
                            // Charts row
                            ChartCardView(chart: charts[0])
                            ChartCardView(chart: charts[1])
                        }
                        
                        Spacer().frame(height: 80)
                    }
                    .padding(.horizontal, AppTokens.Spacing.lg)
                    .padding(.vertical, AppTokens.Spacing.md)
                }
                .background(AppTokens.Colors.background)
            }
            
            // Bottom Notification Bar
            .overlay(alignment: .bottom) {
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(AppTokens.Colors.outline.opacity(0.3))
                        .frame(height: 1)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: AppTokens.Spacing.xs) {
                            Text("Notifications")
                                .font(AppTokens.TypographyTokens.label)
                                .foregroundColor(AppTokens.Colors.onSurface)
                            
                            Text("\(notificationCount) pending")
                                .font(AppTokens.TypographyTokens.headline)
                                .foregroundColor(AppTokens.Colors.onSurface)
                        }
                        
                        Spacer()
                        
                        Button(action: { notificationCount = 0 }) {
                            Text("Mark All Read")
                                .font(AppTokens.TypographyTokens.title)
                                .foregroundColor(AppTokens.Colors.onSecondary)
                                .frame(width: 140, height: 44)
                        }
                        .background(
                            AppTokens.Shapes.large
                                .fill(AppTokens.Colors.secondary)
                        )
                    }
                    .padding(.horizontal, AppTokens.Spacing.lg)
                    .padding(.vertical, AppTokens.Spacing.md)
                    .background(AppTokens.Colors.surface)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: -2)
                }
            }
            .navigationBarHidden(true) // 隐藏导航栏
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .statusBar(hidden: true) // 隐藏状态栏
        .ignoresSafeArea() // 忽略安全区域
    }
}

// MARK: - Metric Card View
struct MetricCardView: View {
    let metric: MetricCardUi
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
            HStack {
                Text(metric.title)
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.onSurface)
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(metric.color)
                    .frame(width: 16, height: 16)
            }
            
            Text(metric.value)
                .font(AppTokens.TypographyTokens.headline)
                .foregroundColor(AppTokens.Colors.onSurface)
            
            HStack(spacing: AppTokens.Spacing.xs) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(metric.delta.hasPrefix("+") ? AppTokens.Colors.success : AppTokens.Colors.error)
                    .frame(width: 6, height: 6)
                
                Text(metric.delta)
                    .font(AppTokens.TypographyTokens.label)
                    .foregroundColor(metric.delta.hasPrefix("+") ? AppTokens.Colors.success : AppTokens.Colors.error)
            }
            Spacer()
        }
        .padding(AppTokens.Spacing.lg)
        .frame(height: 120)
        .frame(maxWidth: .infinity, alignment: .top)
        .background(
            AppTokens.Shapes.large
                .fill(AppTokens.Colors.surface)
                .shadow(color: .black.opacity(0.14), radius: 4, x: 0, y: 2)
        )
        .overlay(
            AppTokens.Shapes.large
                .stroke(AppTokens.Colors.outline, lineWidth: 1)
        )
        
    }
}

// MARK: - Chart Card View
struct ChartCardView: View {
    let chart: ChartCardUi
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppTokens.Spacing.md) {
            Text(chart.title)
                .font(AppTokens.TypographyTokens.title)
                .foregroundColor(AppTokens.Colors.onSurface)
            
            ZStack {
                AppTokens.Shapes.medium
                    .fill(chart.color)
                
                // Bar chart representation
                HStack(spacing: AppTokens.Spacing.sm) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(AppTokens.Colors.primary)
                        .frame(width: 6, height: 40)
                    
                    RoundedRectangle(cornerRadius: 2)
                        .fill(AppTokens.Colors.secondary)
                        .frame(width: 6, height: 30)
                    
                    RoundedRectangle(cornerRadius: 2)
                        .fill(AppTokens.Colors.tertiary)
                        .frame(width: 6, height: 48)
                    
                    RoundedRectangle(cornerRadius: 2)
                        .fill(AppTokens.Colors.outline)
                        .frame(width: 6, height: 22)
                    
                    RoundedRectangle(cornerRadius: 2)
                        .fill(AppTokens.Colors.primary)
                        .frame(width: 6, height: 32)
                    
                    RoundedRectangle(cornerRadius: 2)
                        .fill(AppTokens.Colors.secondary)
                        .frame(width: 6, height: 42)
                }
            }
            .aspectRatio(1.6, contentMode: .fit)
            .frame(maxWidth: .infinity)
            
            // Chart legend
            HStack(spacing: AppTokens.Spacing.sm) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(AppTokens.Colors.primary)
                    .frame(width: 8, height: 8)
                
                Text("Series A")
                    .font(AppTokens.TypographyTokens.label)
                    .foregroundColor(AppTokens.Colors.onSurface)
                
                RoundedRectangle(cornerRadius: 2)
                    .fill(AppTokens.Colors.secondary)
                    .frame(width: 8, height: 8)
                
                Text("Series B")
                    .font(AppTokens.TypographyTokens.label)
                    .foregroundColor(AppTokens.Colors.onSurface)
            }
        }
        .padding(AppTokens.Spacing.lg)
        .frame(height: 180)
        .frame(maxWidth: .infinity)
        .background(
            AppTokens.Shapes.large
                .fill(AppTokens.Colors.surface)
                .shadow(color: .black.opacity(0.14), radius: 4, x: 0, y: 2)
        )
        .overlay(
            AppTokens.Shapes.large
                .stroke(AppTokens.Colors.outline, lineWidth: 1)
        )
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone SE (3rd generation)")
    }
}

@main
struct DashboardApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView() // Replace with your main view
        }
    }
}
