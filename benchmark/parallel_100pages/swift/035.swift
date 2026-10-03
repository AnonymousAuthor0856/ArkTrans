
import SwiftUI
import Foundation 

struct AppTokens {
    struct Colors {
        static let primary = Color(red: 37/255, green: 99/255, blue: 235/255) 
        static let secondary = Color(red: 96/255, green: 165/255, blue: 250/255) 
        static let tertiary = Color(red: 147/255, green: 197/255, blue: 253/255) 
        static let background = Color(red: 248/255, green: 250/255, blue: 252/255) 
        static let surface = Color(red: 255/255, green: 255/255, blue: 255/255) 
        static let surfaceVariant = Color(red: 226/255, green: 232/255, blue: 240/255) 
        static let outline = Color(red: 203/255, green: 213/255, blue: 225/255) 
        static let success = Color(red: 34/255, green: 197/255, blue: 94/255) 
        static let warning = Color(red: 245/255, green: 158/255, blue: 11/255) 
        static let error = Color(red: 239/255, green: 68/255, blue: 68/255) 
        static let onPrimary = Color(red: 255/255, green: 255/255, blue: 255/255) 
        static let onSecondary = Color(red: 30/255, green: 58/255, blue: 138/255) 
        static let onTertiary = Color(red: 30/255, green: 64/255, blue: 175/255) 
        static let onBackground = Color(red: 15/255, green: 23/255, blue: 42/255) 
        static let onSurface = Color(red: 15/255, green: 23/255, blue: 42/255) 
    }

    struct TypographyTokens {
                static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) 
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let small: CGFloat = 4.0
        static let medium: CGFloat = 8.0
        static let large: CGFloat = 16.0
    }

    struct Spacing {
        static let sm: CGFloat = 6.0
        static let md: CGFloat = 10.0
        static let lg: CGFloat = 14.0
        static let xl: CGFloat = 20.0
        static let xxl: CGFloat = 28.0
    }

        struct ShadowSpec {
        let elevation: CGFloat 
        let radius: CGFloat    
        let dy: CGFloat        
        let opacity: Double    
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 2.0, radius: 4.0, dy: 2.0, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 6.0, radius: 8.0, dy: 4.0, opacity: 0.18)
    }
}

struct CustomLinearProgressViewStyle: ProgressViewStyle {
    var tint: Color       
    var trackColor: Color 

    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 4)
                    .fill(trackColor)
                    .frame(height: 8)

                                RoundedRectangle(cornerRadius: 4)
                    .fill(tint)
                    .frame(width: geometry.size.width * CGFloat(configuration.fractionCompleted ?? 0), height: 8)
            }
        }
        .frame(height: 8) 
    }
}

struct RootScreen: View {
    @State private var progress: Double = 0.5 

    var body: some View {
                VStack(spacing: 0) {
                        ZStack {
                AppTokens.Colors.background
                    .frame(height: 56) 
                Text("Stock K-Line")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.onSurface)
            }
                        .ignoresSafeArea(.container, edges: .top)

                        VStack(spacing: AppTokens.Spacing.lg) {
                                ZStack { 
                    RoundedRectangle(cornerRadius: AppTokens.Shapes.large)
                        .fill(AppTokens.Colors.surface)
                                                .shadow(
                            color: AppTokens.Colors.onBackground.opacity(AppTokens.ElevationMapping.level2.opacity),
                            radius: AppTokens.ElevationMapping.level2.radius,
                            x: 0, 
                            y: AppTokens.ElevationMapping.level2.dy
                        )
                    
                                        Canvas { context, size in
                        let width = size.width
                        let height = size.height
                        let step = width / 50.0 
                        var prevY = height / 2.0 

                        var path = Path()
                                                path.move(to: CGPoint(x: 0, y: prevY))

                                                for i in 0...50 {
                            let x = CGFloat(i) * step
                                                        let y = height / 2.0 + sin(Double(i) * Double.pi / 8.0 + progress * Double.pi) * (height / 3.0)
                            path.addLine(to: CGPoint(x: x, y: y))
                            prevY = y 
                        }
                        
                                                context.stroke(path, with: .color(AppTokens.Colors.primary), lineWidth: 4)

                    }
                    .padding(AppTokens.Spacing.lg) 
                }
                .frame(maxWidth: .infinity) 
                .frame(height: 260) 
                .cornerRadius(AppTokens.Shapes.large) 

                Text("Market Trend")
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.primary)

                                                Slider(value: $progress, in: 0...1) {
                                    }
                .tint(AppTokens.Colors.primary) 
                                                                .frame(maxWidth: .infinity) 
                .frame(height: 44) 

                                ProgressView(value: progress)
                    .progressViewStyle(CustomLinearProgressViewStyle(tint: AppTokens.Colors.primary, trackColor: AppTokens.Colors.surfaceVariant))
                    .frame(maxWidth: .infinity) 
                    .frame(height: 8) 
            }
            .padding(AppTokens.Spacing.lg) 
            .frame(maxWidth: .infinity, maxHeight: .infinity) 
                        .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        AppTokens.Colors.secondary.opacity(0.15),
                        AppTokens.Colors.background,
                        AppTokens.Colors.primary.opacity(0.15)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
                .background(AppTokens.Colors.background)
                .ignoresSafeArea(.all, edges: .all)
                .statusBarHidden(true)
    }
}

@main
struct StockKLineApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                .statusBarHidden()
        }
    }
}

extension Double {
    func toFloat() -> CGFloat {
        return CGFloat(self)
    }
}
