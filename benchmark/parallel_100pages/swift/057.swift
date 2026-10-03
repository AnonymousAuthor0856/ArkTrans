import SwiftUI

struct AppTokens {
    struct Colors {
        static let primary = Color(red: 37/255, green: 99/255, blue: 235/255) 
        static let secondary = Color(red: 56/255, green: 189/255, blue: 248/255) 
        static let tertiary = Color(red: 96/255, green: 165/255, blue: 250/255) 
                static let background = Color(red: 230/255, green: 240/255, blue: 255/255) 
        static let surface = Color(red: 255/255, green: 255/255, blue: 255/255) 
        static let surfaceVariant = Color(red: 226/255, green: 232/255, blue: 240/255) 
        static let outline = Color(red: 203/255, green: 213/255, blue: 225/255) 
        static let success = Color(red: 34/255, green: 197/255, blue: 94/255) 
        static let warning = Color(red: 245/255, green: 158/255, blue: 11/255) 
        static let error = Color(red: 239/255, green: 68/255, blue: 68/255) 
        static let onPrimary = Color(red: 255/255, green: 255/255, blue: 255/255) 
        static let onSecondary = Color(red: 15/255, green: 23/255, blue: 42/255) 
        static let onTertiary = Color(red: 255/255, green: 255/255, blue: 255/255) 
        static let onBackground = Color(red: 15/255, green: 23/255, blue: 42/255) 
        static let onSurface = Color(red: 30/255, green: 41/255, blue: 59/255) 
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
    var body: some View {
        GeometryReader { geometry in 
            VStack(spacing: 0) { 
                                HStack {
                                        Button(action: {}) {
                        ZStack {
                            Circle()
                                .fill(AppTokens.Colors.primary)
                                .frame(width: 24, height: 24) 
                            Text("<")
                                .foregroundColor(AppTokens.Colors.onPrimary)
                                .font(AppTokens.TypographyTokens.label)
                        }
                    }
                    .padding(.leading, AppTokens.Spacing.lg) 

                    Spacer() 

                                        Text("Sleep Cycle")
                        .font(AppTokens.TypographyTokens.display)
                        .foregroundColor(AppTokens.Colors.onBackground)

                    Spacer() 

                                        Button(action: {}) {
                        ZStack {
                            Circle()
                                .fill(AppTokens.Colors.secondary)
                                .frame(width: 24, height: 24) 
                            Text("?")
                                .foregroundColor(AppTokens.Colors.onSecondary)
                                .font(AppTokens.TypographyTokens.label)
                        }
                    }
                    .padding(.trailing, AppTokens.Spacing.lg) 
                }
                .frame(height: 56) 
                .background(AppTokens.Colors.surface) 
                
                                VStack(spacing: AppTokens.Spacing.xl) { 
                    Spacer() 

                                        ZStack {
                        Circle()
                            .fill(AppTokens.Colors.surface)
                            .frame(width: 160, height: 160) 
                            .overlay(
                                Circle()
                                    .stroke(AppTokens.Colors.outline, lineWidth: 2) 
                            )
                        Text("😴")
                            .font(.system(size: 48)) 
                    }

                                        Text("Welcome Back")
                        .font(AppTokens.TypographyTokens.headline)
                        .foregroundColor(AppTokens.Colors.onSurface)

                                        Text("Track your sleep patterns and improve rest quality.")
                        .font(AppTokens.TypographyTokens.body)
                        .foregroundColor(AppTokens.Colors.onSurface)
                        .multilineTextAlignment(.center) 

                                        Button(action: {}) {
                        Text("Sign In")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .frame(maxWidth: .infinity) 
                            .frame(height: 52) 
                            .background(AppTokens.Colors.primary) 
                            .cornerRadius(AppTokens.Shapes.large) 
                    }
                                                                                .frame(width: (geometry.size.width - 2 * AppTokens.Spacing.lg) * 0.8)

                    Spacer() 
                }
                .padding(.horizontal, AppTokens.Spacing.lg) 
                .frame(maxWidth: .infinity, maxHeight: .infinity) 
                .background(
                                        LinearGradient(
                        gradient: Gradient(colors: [
                            AppTokens.Colors.background, 
                            AppTokens.Colors.background 
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            .background(AppTokens.Colors.background) 
            .edgesIgnoringSafeArea(.all) 
        }
    }
}

@main
struct SleepCycleApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                                .statusBarHidden(true)
        }
    }
}