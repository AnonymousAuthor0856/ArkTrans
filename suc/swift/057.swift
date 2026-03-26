import SwiftUI

// MARK: - AppTokens
// This struct defines a consistent set of design tokens for colors, typography, shapes, and spacing,
// mirroring the AppTokens object in the Kotlin version for atomic correspondence.
struct AppTokens {
    struct Colors {
        static let primary = Color(red: 37/255, green: 99/255, blue: 235/255) // #2563EB
        static let secondary = Color(red: 56/255, green: 189/255, blue: 248/255) // #38BDF8
        static let tertiary = Color(red: 96/255, green: 165/255, blue: 250/255) // #60A5FA
        // 加深背景蓝色
        static let background = Color(red: 230/255, green: 240/255, blue: 255/255) // #E6F0FF - 更深的蓝色背景
        static let surface = Color(red: 255/255, green: 255/255, blue: 255/255) // #FFFFFF
        static let surfaceVariant = Color(red: 226/255, green: 232/255, blue: 240/255) // #E2E8F0
        static let outline = Color(red: 203/255, green: 213/255, blue: 225/255) // #CBD5E1
        static let success = Color(red: 34/255, green: 197/255, blue: 94/255) // #22C55E
        static let warning = Color(red: 245/255, green: 158/255, blue: 11/255) // #F59E0B
        static let error = Color(red: 239/255, green: 68/255, blue: 68/255) // #EF4444
        static let onPrimary = Color(red: 255/255, green: 255/255, blue: 255/255) // #FFFFFF
        static let onSecondary = Color(red: 15/255, green: 23/255, blue: 42/255) // #0F172A
        static let onTertiary = Color(red: 255/255, green: 255/255, blue: 255/255) // #FFFFFF
        static let onBackground = Color(red: 15/255, green: 23/255, blue: 42/255) // #0F172A
        static let onSurface = Color(red: 30/255, green: 41/255, blue: 59/255) // #1E293B
    }

    struct TypographyTokens {
        // Using .system font with specified size and weight to match TextStyle in Compose.
        static let display = Font.system(size: 28, weight: .bold)
        static let headline = Font.system(size: 20, weight: .semibold)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        // Corner radii are represented as CGFloat values.
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
    }

    struct Spacing {
        // Spacing values are represented as CGFloat values.
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 36
    }
}

// MARK: - RootScreen
// This view translates the RootScreen Composable from Kotlin to SwiftUI.
// It uses GeometryReader to accurately calculate dynamic sizes like button width.
struct RootScreen: View {
    var body: some View {
        GeometryReader { geometry in // Used for dynamic width calculations to match `fillMaxWidth`
            VStack(spacing: 0) { // Main vertical stack to arrange top bar and content
                // Top Bar (equivalent to Compose's CenterAlignedTopAppBar)
                HStack {
                    // Navigation Icon (Left)
                    Button(action: {}) {
                        ZStack {
                            Circle()
                                .fill(AppTokens.Colors.primary)
                                .frame(width: 24, height: 24) // Fixed size for the circular background
                            Text("<")
                                .foregroundColor(AppTokens.Colors.onPrimary)
                                .font(AppTokens.TypographyTokens.label)
                        }
                    }
                    .padding(.leading, AppTokens.Spacing.lg) // Padding to match the Android version

                    Spacer() // Pushes title to center and icons to edges

                    // Title
                    Text("Sleep Cycle")
                        .font(AppTokens.TypographyTokens.display)
                        .foregroundColor(AppTokens.Colors.onBackground)

                    Spacer() // Pushes title to center and icons to edges

                    // Actions Icon (Right)
                    Button(action: {}) {
                        ZStack {
                            Circle()
                                .fill(AppTokens.Colors.secondary)
                                .frame(width: 24, height: 24) // Fixed size for the circular background
                            Text("?")
                                .foregroundColor(AppTokens.Colors.onSecondary)
                                .font(AppTokens.TypographyTokens.label)
                        }
                    }
                    .padding(.trailing, AppTokens.Spacing.lg) // Padding to match the Android version
                }
                .frame(height: 56) // Standard height for Material3 TopAppBar
                .background(AppTokens.Colors.surface) // 顶部栏使用纯白色背景
                // End Top Bar

                // Main Content Area (equivalent to Scaffold content Column)
                VStack(spacing: AppTokens.Spacing.xl) { // Vertical arrangement with spacedBy
                    Spacer() // Pushes content to center vertically

                    // Central Emoji Box
                    ZStack {
                        Circle()
                            .fill(AppTokens.Colors.surface)
                            .frame(width: 160, height: 160) // Fixed size
                            .overlay(
                                Circle()
                                    .stroke(AppTokens.Colors.outline, lineWidth: 2) // Border
                            )
                        Text("😴")
                            .font(.system(size: 48)) // Fixed font size for emoji
                    }

                    // Welcome Back Text
                    Text("Welcome Back")
                        .font(AppTokens.TypographyTokens.headline)
                        .foregroundColor(AppTokens.Colors.onSurface)

                    // Description Text
                    Text("Track your sleep patterns and improve rest quality.")
                        .font(AppTokens.TypographyTokens.body)
                        .foregroundColor(AppTokens.Colors.onSurface)
                        .multilineTextAlignment(.center) // Center-align multi-line text

                    // Sign In Button
                    Button(action: {}) {
                        Text("Sign In")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .frame(maxWidth: .infinity) // Text fills the button's width
                            .frame(height: 52) // Fixed height for the button content
                            .background(AppTokens.Colors.primary) // Button background color
                            .cornerRadius(AppTokens.Shapes.large) // Rounded corners
                    }
                    // Calculate button width to atomically match Kotlin's `fillMaxWidth(0.8f)`
                    // The Kotlin Column has `padding(AppTokens.Spacing.lg)`.
                    // The button then takes 80% of the width *inside* that padding.
                    .frame(width: (geometry.size.width - 2 * AppTokens.Spacing.lg) * 0.8)

                    Spacer() // Pushes content to center vertically
                }
                .padding(.horizontal, AppTokens.Spacing.lg) // Column's horizontal padding
                .frame(maxWidth: .infinity, maxHeight: .infinity) // Fill remaining space in the VStack
                .background(
                    // 加深渐变背景
                    LinearGradient(
                        gradient: Gradient(colors: [
                            AppTokens.Colors.background, // 使用更深的背景色
                            AppTokens.Colors.background // 单色背景，更深的蓝色
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            .background(AppTokens.Colors.background) // 整体背景使用更深的蓝色
            .edgesIgnoringSafeArea(.all) // Ensures the content extends to the very edges of the screen
        }
    }
}

// MARK: - App Entry Point
// This is the main entry point for the SwiftUI application.
// It sets up the RootScreen and applies global modifiers for full-screen display and status bar visibility.
@main
struct SleepCycleApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                // Hide the status bar to achieve a full-screen experience, compatible with iOS 16.0.
                .statusBarHidden(true)
        }
    }
}