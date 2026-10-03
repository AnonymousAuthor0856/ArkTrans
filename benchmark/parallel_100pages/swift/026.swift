import SwiftUI

extension Color {
                init(hex: UInt) {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0x00FF00) >> 8) / 255.0
        let blue = Double(hex & 0x0000FF) / 255.0
        let alpha = Double((hex & 0xFF000000) >> 24) / 255.0

                        self.init(red: red, green: green, blue: blue, opacity: (hex & 0xFF000000) == 0 ? 1.0 : alpha)
    }
}

struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFF38BDF8)
        static let secondary = Color(hex: 0xFFA78BFA)
        static let tertiary = Color(hex: 0xFF7DD3FC)
        static let background = Color(hex: 0xFFF1F5F9)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFE2E8F0)
        static let outline = Color(hex: 0xFFCBD5E1)
        static let success = Color(hex: 0xFF22C55E)
        static let warning = Color(hex: 0xFFF59E0B)
        static let error = Color(hex: 0xFFEF4444)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFF1E1E1E)
        static let onTertiary = Color(hex: 0xFF1E1E1E)
        static let onBackground = Color(hex: 0xFF1E1E1E)
        static let onSurface = Color(hex: 0xFF1E1E1E)
    }

    struct TypographyTokens {
        static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) 
        static let label = Font.system(size: 12, weight: .medium)
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

struct RootScreen: View {
        @State private var scrollOffset: CGSize = .zero

    var body: some View {
                VStack(spacing: 0) {
                        Text("Glass Doc Reader")
                .font(AppTokens.TypographyTokens.display)
                .foregroundColor(AppTokens.Colors.onSurface)
                .padding(.top, 20)
                .padding(.vertical, AppTokens.Spacing.lg) 
                .frame(maxWidth: .infinity) 
                .background(AppTokens.Colors.background) 

                        ZStack(alignment: .center) { 
                                LinearGradient(
                    gradient: Gradient(colors: [
                        AppTokens.Colors.surfaceVariant.opacity(0.8),
                        AppTokens.Colors.background,
                        AppTokens.Colors.surfaceVariant.opacity(0.8)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity) 
                
                                VStack(alignment: .leading, spacing: AppTokens.Spacing.md) { 
                    Text("Document Reader")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.primary)

                    ForEach(0..<8) { index in
                        Text("This is a sample line of text content number \(index + 1).")
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(AppTokens.Colors.onSurface)
                    }
                    Spacer()
                }
                .padding(AppTokens.Spacing.lg) 
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 400) 
                .background(AppTokens.Colors.surface.opacity(0.7)) 
                .cornerRadius(AppTokens.Shapes.large) 
                .shadow(
                    color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity),
                    radius: AppTokens.ElevationMapping.level2.radius,
                    x: 0, 
                    y: AppTokens.ElevationMapping.level2.dy
                )
                .offset(y: scrollOffset.height / 5) 
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            scrollOffset.height += value.translation.height
                        }
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) 
        }
        .background(AppTokens.Colors.background.ignoresSafeArea()) 
    }
}

@main
struct SingleFileUIApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                                .ignoresSafeArea(.all)
                                                .statusBarHidden(true)
        }
    }
}

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}
