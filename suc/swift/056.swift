import SwiftUI

// MARK: - AppTokens (Atomic Design System)

// Extension to initialize Color from a hex string (e.g., 0xFFRRGGBB)
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

// Helper extension for CGFloat to mimic Kotlin's coerceAtMost
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
        // SwiftUI's Font.system uses points (pt) by default, which is a good equivalent for dp/sp in Compose for UI scaling.
        static let display = Font.system(size: 28, weight: .bold)
        static let headline = Font.system(size: 20, weight: .semibold)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) // Normal maps to regular
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
    
    // ElevationMapping is not directly translatable to SwiftUI's built-in shadow modifiers
    // without custom ViewModifier or explicit parameters. The Kotlin code doesn't explicitly
    // apply these shadows to the UI elements, so we will omit direct translation for now.
    // If shadows were explicitly used, we would use .shadow(color:radius:x:y:)
}

// MARK: - RootScreen

struct RootScreen: View {
    @State private var selectedTab: Int = 0
    let tabs = ["Meals", "Chat", "Stats"]

    var body: some View {
        // VStack acts as the main container, similar to Scaffold's content area.
        // We use ignoresSafeArea() for the background gradient to cover the entire screen,
        // including the area under the status bar.
        VStack(spacing: 0) {
            LinearGradient(
                gradient: Gradient(colors: [
                    AppTokens.Colors.primary.opacity(0.1),
                    AppTokens.Colors.secondary.opacity(0.1)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea(.all, edges: .all) // Ensures the gradient fills the entire screen
            .overlay(
                VStack(spacing: 0) { // This VStack holds all the UI content
                    // Title Box equivalent
                    HStack {
                        Text("Diet Log")
                            .font(AppTokens.TypographyTokens.display)
                            .foregroundColor(AppTokens.Colors.onBackground)
                    }
                    .frame(maxWidth: .infinity) // Equivalent to fillMaxWidth()
                    .padding(AppTokens.Spacing.lg)

                    // Custom TabRow equivalent
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
                                        .frame(maxWidth: .infinity) // Each tab takes equal width
                                }
                            }
                        }
                        // Tab indicator line
                        Rectangle()
                            .fill(AppTokens.Colors.primary)
                            .frame(width: UIScreen.main.bounds.width / CGFloat(tabs.count), height: 2)
                            // Calculate offset to position the indicator under the selected tab
                            .offset(x: (UIScreen.main.bounds.width / CGFloat(tabs.count)) * CGFloat(selectedTab) - (UIScreen.main.bounds.width / 2) + (UIScreen.main.bounds.width / CGFloat(tabs.count) / 2))
                            .animation(.easeInOut(duration: 0.2), value: selectedTab) // Animate indicator movement
                    }
                    .background(AppTokens.Colors.surface) // TabRow background color
                    .frame(maxWidth: .infinity)

                    // HorizontalPager equivalent using TabView with .page style
                    TabView(selection: $selectedTab) {
                        MealsPage()
                            .tag(0)
                        ChatPage()
                            .tag(1)
                        StatsPage()
                            .tag(2)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never)) // Hide default page indicator dots
                    .animation(.easeInOut(duration: 0.2), value: selectedTab) // Animate page transitions
                }
            )
        }
        .background(AppTokens.Colors.background) // Fallback background color for the entire view
        .statusBarHidden(true) // Requirement: Hide the top status bar
    }
}

// MARK: - MealsPage

struct MealsPage: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AppTokens.Spacing.md) {
            Text("Today's Meals")
                .font(AppTokens.TypographyTokens.headline)
                .foregroundColor(AppTokens.Colors.onSurface)

            ForEach(0..<3, id: \.self) { it in
                ZStack { // Equivalent to Box with contentAlignment: .Center
                    Text("Meal \(it + 1)")
                        .font(AppTokens.TypographyTokens.body)
                        .foregroundColor(AppTokens.Colors.onSurface)
                }
                .frame(maxWidth: .infinity) // Equivalent to fillMaxWidth()
                .frame(height: 80) // Fixed height
                .background(AppTokens.Colors.surface)
                .cornerRadius(AppTokens.Shapes.medium)
                .overlay( // Equivalent to border()
                    RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                        .stroke(AppTokens.Colors.outline, lineWidth: 1)
                )
            }
            Spacer() // Pushes content to the top
        }
        .padding(AppTokens.Spacing.lg)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // Align content to top-leading
        .background(Color.clear) // Ensure background is transparent to show RootScreen's gradient
    }
}

// MARK: - ChatPage

struct ChatPage: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
            Text("Diet Chat")
                .font(AppTokens.TypographyTokens.headline)
                .foregroundColor(AppTokens.Colors.onSurface)

            ForEach(0..<5, id: \.self) { it in
                HStack { // Equivalent to Row
                    if it % 2 == 0 { // Arrangement.Start
                        Text("Message \(it + 1)")
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(AppTokens.Colors.onSurface)
                            .padding(AppTokens.Spacing.md)
                            .background(AppTokens.Colors.surfaceVariant)
                            .cornerRadius(AppTokens.Shapes.medium)
                        Spacer() // Pushes content to the start
                    } else { // Arrangement.End
                        Spacer() // Pushes content to the end
                        Text("Message \(it + 1)")
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .padding(AppTokens.Spacing.md)
                            .background(AppTokens.Colors.primary)
                            .cornerRadius(AppTokens.Shapes.medium)
                    }
                }
                .frame(maxWidth: .infinity) // Ensure HStack takes full width
            }
            Spacer() // Pushes content to the top
        }
        .padding(AppTokens.Spacing.lg)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.clear)
    }
}

// MARK: - StatsPage

struct StatsPage: View {
    var body: some View {
        VStack(spacing: AppTokens.Spacing.md) {
            Text("Weekly Calories")
                .font(AppTokens.TypographyTokens.headline)
                .foregroundColor(AppTokens.Colors.onSurface)

            ForEach(0..<7, id: \.self) { it in
                HStack {
                    // Progress bar segment
                    Rectangle()
                        .fill(AppTokens.Colors.primary)
                        // Calculate width based on screen width, padding, and the dynamic factor
                        .frame(width: (UIScreen.main.bounds.width - AppTokens.Spacing.lg * 2) * CGFloat((0.3 + Double(it) * 0.1).coerce(in: 0...1)))
                        .cornerRadius(AppTokens.Shapes.small) // Apply corner radius to the filled part
                    Spacer() // Fills the rest of the width
                }
                .frame(maxWidth: .infinity) // Equivalent to fillMaxWidth()
                .frame(height: 24) // Fixed height
                .background(AppTokens.Colors.surfaceVariant)
                .cornerRadius(AppTokens.Shapes.small) // Apply corner radius to the background container
            }

            Spacer() // Pushes content to the top and the button to the bottom
                .frame(height: AppTokens.Spacing.lg) // Spacer height from Kotlin code

            Button(action: {}) {
                Text("Share Report")
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.onSecondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // Make text fill button for centering
            }
            // Equivalent to fillMaxWidth(0.6f) and height(48.dp)
            .frame(width: UIScreen.main.bounds.width * 0.6, height: 48)
            .background(AppTokens.Colors.secondary)
            .cornerRadius(AppTokens.Shapes.large)
            // No explicit bottom padding in Kotlin, Spacer handles vertical distribution
        }
        .padding(AppTokens.Spacing.lg)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top) // Align content to top-center
        .background(Color.clear)
    }
}

// MARK: - App Entry Point

@main
struct DietLogApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}

// MARK: - Preview

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}