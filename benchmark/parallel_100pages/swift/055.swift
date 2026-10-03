import SwiftUI

struct AppTokens {
        struct Colors {
                static let primary = Color(hex: 0xFF2563EB)
        static let secondary = Color(hex: 0xFF38BDF8)
        static let tertiary = Color(hex: 0xFF3B82F6)
        static let background = Color(hex: 0xFFF8FAFC)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFE2E8F0)
        static let outline = Color(hex: 0xFFCBD5E1)
        static let success = Color(hex: 0xFF22C55E)
        static let warning = Color(hex: 0xFFF59E0B)
        static let error = Color(hex: 0xFFEF4444)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFF0F172A)
        static let onTertiary = Color(hex: 0xFFFFFFFF)
        static let onBackground = Color(hex: 0xFF0F172A)
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
        static let small = CGFloat(8) 
        static let medium = CGFloat(12) 
        static let large = CGFloat(16) 
    }

            struct Spacing {
        static let xs = CGFloat(4) 
        static let sm = CGFloat(8) 
        static let md = CGFloat(12) 
        static let lg = CGFloat(16) 
        static let xl = CGFloat(24) 
        static let xxl = CGFloat(36) 
    }

            struct ShadowSpec {
        let elevation: CGFloat 
        let radius: CGFloat    
        let dy: CGFloat        
        let opacity: Double    
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 4, radius: 8, dy: 4, opacity: 0.14)
        static let level3 = ShadowSpec(elevation: 8, radius: 12, dy: 6, opacity: 0.16)
    }
}

extension Color {
    init(hex: UInt) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: Double((hex >> 24) & 0xFF) / 255.0 
        )
    }
}

struct RootScreen: View {
        private let topBarHeight: CGFloat = 64 
    private let bottomBarHeight: CGFloat = 80 
    private let fabSize: CGFloat = 56 

    var body: some View {
                ZStack(alignment: .bottomTrailing) { 
                        VStack(spacing: AppTokens.Spacing.lg) { 
                                Spacer().frame(height: topBarHeight)

                Text("Sign In to Continue")
                    .font(AppTokens.TypographyTokens.headline)
                    .foregroundColor(AppTokens.Colors.onSurface)

                                ZStack { 
                    Text("Workout Preview")
                        .font(AppTokens.TypographyTokens.body)
                        .foregroundColor(AppTokens.Colors.onSurface)
                }
                .frame(maxWidth: .infinity) 
                .frame(height: 200) 
                .background(AppTokens.Colors.surface) 
                .cornerRadius(AppTokens.Shapes.large) 
                .overlay( 
                    RoundedRectangle(cornerRadius: AppTokens.Shapes.large)
                        .stroke(AppTokens.Colors.outline, lineWidth: 1) 
                )

                                Button(action: {}) {
                    Text("Authenticate")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onPrimary) 
                        .frame(maxWidth: .infinity) 
                        .frame(height: 52) 
                        .background(AppTokens.Colors.primary) 
                        .cornerRadius(AppTokens.Shapes.large) 
                }
                .frame(width: UIScreen.main.bounds.width * 0.8) 
                                                                                
                Spacer() 
            }
            .padding(.horizontal, AppTokens.Spacing.lg) 
            .frame(maxWidth: .infinity, maxHeight: .infinity) 
            .background( 
                LinearGradient(
                    gradient: Gradient(colors: [
                        AppTokens.Colors.secondary.opacity(0.1), 
                        AppTokens.Colors.primary.opacity(0.15) 
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .background(AppTokens.Colors.background) 
                        .padding(.bottom, bottomBarHeight)
            .ignoresSafeArea(.all) 

                        VStack { 
                Text("Workout Plan")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.onBackground)
            }
            .frame(maxWidth: .infinity)
            .frame(height: topBarHeight)
            .background(AppTokens.Colors.surface)
            .frame(maxHeight: .infinity, alignment: .top) 
            .ignoresSafeArea(.container, edges: .top) 

                        VStack { 
                HStack(spacing: 0) { 
                    Text("Home")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.primary) 
                        .frame(maxWidth: .infinity) 
                    Spacer() 
                    Text("Plan")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)
                    Spacer() 
                    Text("Profile")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)
                }
                .padding(.horizontal, AppTokens.Spacing.lg) 
                .frame(maxWidth: .infinity)
                .frame(height: bottomBarHeight) 
                .background(AppTokens.Colors.surface) 
                                .shadow(color: AppTokens.Colors.onBackground.opacity(AppTokens.ElevationMapping.level2.opacity),
                        radius: AppTokens.ElevationMapping.level2.radius,
                        y: AppTokens.ElevationMapping.level2.dy)
            }
            .frame(maxHeight: .infinity, alignment: .bottom) 
            .ignoresSafeArea(.container, edges: .bottom) 

                        Button(action: {}) { 
                Text("+")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.onPrimary) 
                    .frame(width: fabSize, height: fabSize) 
                    .background(AppTokens.Colors.primary) 
                    .clipShape(Circle()) 
            }
                                    .padding(.trailing, AppTokens.Spacing.lg)
            .padding(.bottom, bottomBarHeight + AppTokens.Spacing.lg)
        }
        .background(AppTokens.Colors.background) 
        .statusBarHidden(true) 
    }
}

@main
struct WorkoutPlanApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                                .statusBarHidden(true)
        }
    }
}

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}