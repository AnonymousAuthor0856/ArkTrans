import SwiftUI


extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double(hex & 0xff) / 255,
            opacity: alpha
        )
    }
}

extension Comparable {
    func `coerce`(in range: ClosedRange<Self>) -> Self {
        max(range.lowerBound, min(self, range.upperBound))
    }
}

struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFF0EA5E9)
        static let secondary = Color(hex: 0xFF6366F1)
        static let tertiary = Color(hex: 0xFF06B6D4)
        static let background = Color(hex: 0xFFF1F5F9)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFE2E8F0)
        static let outline = Color(hex: 0xFFD1D5DB)
        static let success = Color(hex: 0xFF22C55E)
        static let warning = Color(hex: 0xFFF59E0B)
        static let error = Color(hex: 0xFFEF4444)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFFFFFFFF)
        static let onTertiary = Color(hex: 0xFF0F172A)
        static let onBackground = Color(hex: 0xFF1E293B)
        static let onSurface = Color(hex: 0xFF1E293B)
    }

    struct TypographyTokens {
                static let display = Font.system(size: 28, weight: .bold)
        static let headline = Font.system(size: 20, weight: .semibold)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) 
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
    }

    struct Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 36
    }
    
                }


struct RootScreen: View {
    @State private var selectedTab: Int = 0
    let tabs = ["Meals", "Chat", "Stats"]

    var body: some View {
                                VStack(spacing: 0) {
            LinearGradient(
                gradient: Gradient(colors: [
                    AppTokens.Colors.primary.opacity(0.1),
                    AppTokens.Colors.secondary.opacity(0.1)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea(.all, edges: .all) 
            .overlay(
                VStack(spacing: 0) { 
                                        HStack {
                        Text("Diet Log")
                            .font(AppTokens.TypographyTokens.display)
                            .foregroundColor(AppTokens.Colors.onBackground)
                    }
                    .frame(maxWidth: .infinity) 
                    .padding(AppTokens.Spacing.lg)

                                        VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            ForEach(tabs.indices, id: \.self) { index in
                                Button(action: {
                                    selectedTab = index
                                }) {
                                    Text(tabs[index])
                                        .font(AppTokens.TypographyTokens.body)
                                        .foregroundColor(selectedTab == index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
                                        .padding(.vertical, AppTokens.Spacing.md)
                                        .frame(maxWidth: .infinity) 
                                }
                            }
                        }
                                                Rectangle()
                            .fill(AppTokens.Colors.primary)
                            .frame(width: UIScreen.main.bounds.width / CGFloat(tabs.count), height: 2)
                                                        .offset(x: (UIScreen.main.bounds.width / CGFloat(tabs.count)) * CGFloat(selectedTab) - (UIScreen.main.bounds.width / 2) + (UIScreen.main.bounds.width / CGFloat(tabs.count) / 2))
                            .animation(.easeInOut(duration: 0.2), value: selectedTab) 
                    }
                    .background(AppTokens.Colors.surface) 
                    .frame(maxWidth: .infinity)

                                        TabView(selection: $selectedTab) {
                        MealsPage()
                            .tag(0)
                        ChatPage()
                            .tag(1)
                        StatsPage()
                            .tag(2)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never)) 
                    .animation(.easeInOut(duration: 0.2), value: selectedTab) 
                }
            )
        }
        .background(AppTokens.Colors.background) 
        .statusBarHidden(true) 
    }
}


struct MealsPage: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AppTokens.Spacing.md) {
            Text("Today's Meals")
                .font(AppTokens.TypographyTokens.headline)
                .foregroundColor(AppTokens.Colors.onSurface)

            ForEach(0..<3, id: \.self) { it in
                ZStack { 
                    Text("Meal \(it + 1)")
                        .font(AppTokens.TypographyTokens.body)
                        .foregroundColor(AppTokens.Colors.onSurface)
                }
                .frame(maxWidth: .infinity) 
                .frame(height: 80) 
                .background(AppTokens.Colors.surface)
                .cornerRadius(AppTokens.Shapes.medium)
                .overlay( 
                    RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                        .stroke(AppTokens.Colors.outline, lineWidth: 1)
                )
            }
            Spacer() 
        }
        .padding(AppTokens.Spacing.lg)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) 
        .background(Color.clear) 
    }
}


struct ChatPage: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
            Text("Diet Chat")
                .font(AppTokens.TypographyTokens.headline)
                .foregroundColor(AppTokens.Colors.onSurface)

            ForEach(0..<5, id: \.self) { it in
                HStack { 
                    if it % 2 == 0 { 
                        Text("Message \(it + 1)")
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(AppTokens.Colors.onSurface)
                            .padding(AppTokens.Spacing.md)
                            .background(AppTokens.Colors.surfaceVariant)
                            .cornerRadius(AppTokens.Shapes.medium)
                        Spacer() 
                    } else { 
                        Spacer() 
                        Text("Message \(it + 1)")
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .padding(AppTokens.Spacing.md)
                            .background(AppTokens.Colors.primary)
                            .cornerRadius(AppTokens.Shapes.medium)
                    }
                }
                .frame(maxWidth: .infinity) 
            }
            Spacer() 
        }
        .padding(AppTokens.Spacing.lg)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.clear)
    }
}


struct StatsPage: View {
    var body: some View {
        VStack(spacing: AppTokens.Spacing.md) {
            Text("Weekly Calories")
                .font(AppTokens.TypographyTokens.headline)
                .foregroundColor(AppTokens.Colors.onSurface)

            ForEach(0..<7, id: \.self) { it in
                HStack {
                                        Rectangle()
                        .fill(AppTokens.Colors.primary)
                                                .frame(width: (UIScreen.main.bounds.width - AppTokens.Spacing.lg * 2) * CGFloat((0.3 + Double(it) * 0.1).coerce(in: 0...1)))
                        .cornerRadius(AppTokens.Shapes.small) 
                    Spacer() 
                }
                .frame(maxWidth: .infinity) 
                .frame(height: 24) 
                .background(AppTokens.Colors.surfaceVariant)
                .cornerRadius(AppTokens.Shapes.small) 
            }

            Spacer() 
                .frame(height: AppTokens.Spacing.lg) 

            Button(action: {}) {
                Text("Share Report")
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.onSecondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity) 
            }
                        .frame(width: UIScreen.main.bounds.width * 0.6, height: 48)
            .background(AppTokens.Colors.secondary)
            .cornerRadius(AppTokens.Shapes.large)
                    }
        .padding(AppTokens.Spacing.lg)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top) 
        .background(Color.clear)
    }
}


@main
struct DietLogApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}


struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}