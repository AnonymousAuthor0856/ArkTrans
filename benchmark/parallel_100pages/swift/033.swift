import SwiftUI

struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFF06B6D4)
        static let secondary = Color(hex: 0xFF3B82F6)
        static let tertiary = Color(hex: 0xFF8B5CF6)
        static let background = Color(hex: 0xFFF0F9FF)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFE0F2FE)
        static let outline = Color(hex: 0xFFBAE6FD)
        static let success = Color(hex: 0xFF22C55E)
        static let warning = Color(hex: 0xFFFACC15)
        static let error = Color(hex: 0xFFEF4444)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFFFFFFFF)
        static let onTertiary = Color(hex: 0xFFFFFFFF)
        static let onBackground = Color(hex: 0xFF0F172A)
        static let onSurface = Color(hex: 0xFF0F172A)
    }

    struct TypographyTokens {
                static let display: Font = .system(size: 28, weight: .bold)
                static let title: Font = .system(size: 18, weight: .medium)
                static let body: Font = .system(size: 14, weight: .regular)
                static let label: Font = .system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let small: CGFloat = 6
        static let medium: CGFloat = 12
        static let large: CGFloat = 20
    }

    struct Spacing {
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 32
    }

        struct ShadowSpec {
        let elevation: CGFloat 
        let radius: CGFloat    
        let dy: CGFloat        
        let opacity: Double    
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 6, radius: 8, dy: 4, opacity: 0.18)
    }
}

extension Color {
    init(hex: UInt) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: Double((hex >> 24) & 0xFF) / 255.0 == 0.0 ? 1.0 : Double((hex >> 24) & 0xFF) / 255.0 
        )
    }
}

struct LinearProgressViewStyle: ProgressViewStyle {
    var tint: Color
    var track: Color

    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in 
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4) 
                    .fill(track)
                    .frame(height: 8)

                RoundedRectangle(cornerRadius: 4) 
                    .fill(tint)
                    .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * geometry.size.width, height: 8)
            }
        }
        .frame(height: 8) 
    }
}

struct RootScreen: View {
        @State private var spending: Float = 500.0
    let goal: Float = 1000.0

    var body: some View {
                VStack(spacing: 0) { 
                        ZStack {
                AppTokens.Colors.background 
                    .ignoresSafeArea(.all, edges: .top) 

                Text("Bill Calendar") 
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.onSurface)
            }
            .frame(height: 56) 
            .background(AppTokens.Colors.background) 

                        ScrollView {
                VStack(spacing: AppTokens.Spacing.lg) { 
                                        RoundedRectangle(cornerRadius: AppTokens.Shapes.large) 
                        .fill(AppTokens.Colors.surface.opacity(0.9)) 
                        .shadow(
                            color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity),
                            radius: AppTokens.ElevationMapping.level2.radius, 
                            x: 0, 
                            y: AppTokens.ElevationMapping.level2.dy 
                        ) 
                        .frame(maxWidth: .infinity) 
                        .frame(height: 160) 
                        .overlay( 
                            VStack(alignment: .leading, spacing: 0) { 
                                Text("Current Spending")
                                    .font(AppTokens.TypographyTokens.title)
                                    .foregroundColor(AppTokens.Colors.primary)
                                
                                Spacer() 

                                Text("$\(Int(spending)) / $\(Int(goal))")
                                    .font(AppTokens.TypographyTokens.display)
                                    .foregroundColor(AppTokens.Colors.onSurface)
                                
                                Spacer() 

                                                                ProgressView(value: Double(spending), total: Double(goal))
                                    .progressViewStyle(LinearProgressViewStyle(tint: AppTokens.Colors.primary, track: AppTokens.Colors.surfaceVariant))
                                    .frame(maxWidth: .infinity) 
                                    .frame(height: 8) 
                            }
                            .padding(AppTokens.Spacing.lg) 
                        )

                    Text("Adjust Spending")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)

                                        Slider(value: $spending, in: 0...2000) {
                                            }
                                                                                .tint(AppTokens.Colors.primary) 
                                        .background(AppTokens.Colors.surfaceVariant.opacity(0.5)) 
                    .cornerRadius(4) 
                    .frame(maxWidth: .infinity) 

                                        Button(action: {
                        spending = 0.0
                    }) {
                        Text("Reset")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.onTertiary) 
                            .frame(maxWidth: .infinity, maxHeight: .infinity) 
                    }
                    .frame(maxWidth: .infinity) 
                    .frame(height: 48) 
                    .background(AppTokens.Colors.tertiary) 
                    .cornerRadius(AppTokens.Shapes.medium) 
                }
                .padding(AppTokens.Spacing.lg) 
            }
            .background(
                LinearGradient( 
                    gradient: Gradient(colors: [
                        AppTokens.Colors.secondary.opacity(0.3), 
                        AppTokens.Colors.background,
                        AppTokens.Colors.primary.opacity(0.2) 
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .background(AppTokens.Colors.background) 
        .ignoresSafeArea(.all, edges: .bottom) 
    }
}

@main
struct BillCalendarApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                .statusBarHidden(true) 
                                        }
    }
}