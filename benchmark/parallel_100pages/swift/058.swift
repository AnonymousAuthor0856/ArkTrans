import SwiftUI

struct AppTokens {
    struct Colors {
        static let primary = Color(hex: "111827")
        static let secondary = Color(hex: "374151")
        static let tertiary = Color(hex: "6B7280")
        static let background = Color(hex: "F9FAFB")
        static let surface = Color(hex: "FFFFFF")
        static let surfaceVariant = Color(hex: "E5E7EB")
        static let outline = Color(hex: "D1D5DB")
        static let success = Color(hex: "16A34A")
        static let warning = Color(hex: "F59E0B")
        static let error = Color(hex: "EF4444")
        static let onPrimary = Color(hex: "FFFFFF")
        static let onSecondary = Color(hex: "FFFFFF")
        static let onTertiary = Color(hex: "111827")
        static let onBackground = Color(hex: "111827")
        static let onSurface = Color(hex: "1F2937")
    }

    struct TypographyTokens {
                static let display = Font.system(size: 28, weight: .bold)
        static let headline = Font.system(size: 20, weight: .semibold)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
                static let small = 8.0
        static let medium = 12.0
        static let large = 16.0
    }

    struct Spacing {
                static let xs = 4.0
        static let sm = 8.0
        static let md = 12.0
        static let lg = 16.0
        static let xl = 24.0
        static let xxl = 36.0
    }
    
        }

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
                guard scanner.scanHexInt64(&rgbValue) else {
            self.init(red: 0, green: 0, blue: 0) 
            return
        }

        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}

struct RootScreen: View {
        @State private var selectedTabIndex: Int = 0
    let tabs = ["Overview", "Ranking", "Stats"]

    var body: some View {
                GeometryReader { geometry in
            VStack(spacing: 0) { 
                                Text("Step Challenge")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.onBackground)
                    .padding(AppTokens.Spacing.lg) 
                    .frame(maxWidth: .infinity, alignment: .center) 

                                CustomTabRow(tabs: tabs, selectedTabIndex: $selectedTabIndex)
                    .frame(maxWidth: .infinity) 
                
                                TabView(selection: $selectedTabIndex) {
                    OverviewPage()
                        .tag(0) 
                        .frame(maxWidth: .infinity, maxHeight: .infinity) 
                    RankingPage()
                        .tag(1)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    StatsPage()
                        .tag(2)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .tabViewStyle(.page(indexDisplayMode: .never)) 
                .animation(.easeInOut, value: selectedTabIndex) 
                .background(AppTokens.Colors.surface) 
            }
                        .background(
                LinearGradient(
                    gradient: Gradient(colors: [AppTokens.Colors.surfaceVariant, AppTokens.Colors.surface]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
                        .ignoresSafeArea(.all, edges: .all)
        }
    }
}

struct CustomTabRow: View {
    let tabs: [String]
    @Binding var selectedTabIndex: Int 

    var body: some View {
        VStack(spacing: 0) { 
            HStack(spacing: 0) { 
                ForEach(tabs.indices, id: \.self) { index in
                    Button(action: {
                        selectedTabIndex = index 
                    }) {
                        Text(tabs[index])
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(selectedTabIndex == index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
                            .padding(.vertical, AppTokens.Spacing.md) 
                            .frame(maxWidth: .infinity) 
                    }
                }
            }
            
                        GeometryReader { geometry in 
                Rectangle()
                    .fill(AppTokens.Colors.primary) 
                    .frame(width: geometry.size.width / CGFloat(tabs.count), height: 2) 
                                        .offset(x: (geometry.size.width / CGFloat(tabs.count)) * CGFloat(selectedTabIndex))
                    .animation(.easeInOut(duration: 0.2), value: selectedTabIndex) 
            }
            .frame(height: 2) 
        }
        .background(AppTokens.Colors.surface) 
    }
}

struct OverviewPage: View {
    var body: some View {
        VStack(spacing: AppTokens.Spacing.md) { 
            Text("Today's Steps: 8452")
                .font(AppTokens.TypographyTokens.headline)
                .foregroundColor(AppTokens.Colors.onSurface)
            
            Spacer() 
                .frame(height: AppTokens.Spacing.lg)
            
            Button(action: {
                            }) {
                Text("Sync Device")
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.onPrimary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity) 
            }
                        .frame(width: UIScreen.main.bounds.width * 0.6, height: 48)
            .background(AppTokens.Colors.primary) 
            .cornerRadius(AppTokens.Shapes.large) 
            
            Spacer() 
        }
        .padding(AppTokens.Spacing.lg) 
        .frame(maxWidth: .infinity, maxHeight: .infinity) 
    }
}

struct RankingPage: View {
    var body: some View {
        VStack(spacing: AppTokens.Spacing.sm) { 
            ForEach(0..<5) { it in 
                HStack { 
                    Text("User \(it + 1)")
                        .foregroundColor(AppTokens.Colors.onSurface)
                        .font(AppTokens.TypographyTokens.body) 
                    
                    Spacer() 
                    
                    Text("\(9000 - it * 500) steps")
                        .foregroundColor(AppTokens.Colors.onSurface)
                        .font(AppTokens.TypographyTokens.body) 
                }
                .padding(AppTokens.Spacing.md) 
                .background(AppTokens.Colors.surfaceVariant) 
                .cornerRadius(AppTokens.Shapes.medium) 
                .frame(maxWidth: .infinity) 
            }
        }
        .padding(AppTokens.Spacing.lg) 
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top) 
    }
}

struct StatsPage: View {
    var body: some View {
        VStack(spacing: AppTokens.Spacing.sm) { 
            Text("Weekly Progress")
                .font(AppTokens.TypographyTokens.headline)
                .foregroundColor(AppTokens.Colors.onSurface)
            
            ForEach(0..<7) { it in 
                GeometryReader { geometry in 
                    HStack(spacing: 0) { 
                        Rectangle()
                            .fill(AppTokens.Colors.primary) 
                                                        .frame(width: geometry.size.width * (0.3 + CGFloat(it) * 0.1).clamped(to: 0...1))
                            .cornerRadius(AppTokens.Shapes.small) 
                        
                        Spacer(minLength: 0) 
                    }
                    .frame(height: 20) 
                    .background(AppTokens.Colors.surfaceVariant) 
                    .cornerRadius(AppTokens.Shapes.small) 
                }
                .frame(height: 20) 
                .frame(maxWidth: .infinity) 
            }
            Spacer() 
        }
        .padding(AppTokens.Spacing.lg) 
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top) 
    }
}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

@main
struct StepChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                                .statusBarHidden(true)
        }
    }
}
