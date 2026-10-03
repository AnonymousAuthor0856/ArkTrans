import SwiftUI

struct AppTokens {
    struct Colors {
        static let primary = Color(red: 0xFF / 255.0, green: 0xA5 / 255.0, blue: 0x00 / 255.0)
        static let secondary = Color(red: 0xFF / 255.0, green: 0xC3 / 255.0, blue: 0x00 / 255.0)
        static let tertiary = Color(red: 0xFF / 255.0, green: 0xE0 / 255.0, blue: 0x66 / 255.0)
        static let background = Color(red: 0xFF / 255.0, green: 0xFB / 255.0, blue: 0xF2 / 255.0)
        static let surface = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let surfaceVariant = Color(red: 0xFF / 255.0, green: 0xEE / 255.0, blue: 0xD6 / 255.0)
        static let outline = Color(red: 0xF1 / 255.0, green: 0xC2 / 255.0, blue: 0x7D / 255.0)
        static let success = Color(red: 0x22 / 255.0, green: 0xC5 / 255.0, blue: 0x5E / 255.0)
        static let warning = Color(red: 0xF5 / 255.0, green: 0x9E / 255.0, blue: 0x0B / 255.0)
        static let error = Color(red: 0xEF / 255.0, green: 0x44 / 255.0, blue: 0x44 / 255.0)
        static let onPrimary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onSecondary = Color(red: 0x1E / 255.0, green: 0x1E / 255.0, blue: 0x1E / 255.0)
        static let onTertiary = Color(red: 0x1E / 255.0, green: 0x1E / 255.0, blue: 0x1E / 255.0)
        static let onBackground = Color(red: 0x1E / 255.0, green: 0x1E / 255.0, blue: 0x1E / 255.0)
        static let onSurface = Color(red: 0x1E / 255.0, green: 0x1E / 255.0, blue: 0x1E / 255.0)
    }

    struct TypographyTokens {
                static let display = Font.system(size: 28, weight: .bold)
                static let title = Font.system(size: 18, weight: .medium)
                static let body = Font.system(size: 14, weight: .regular)
                static let label = Font.system(size: 12, weight: .medium)
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
        static let level2 = ShadowSpec(elevation: 6, radius: 8, dy: 4, opacity: 0.16)
    }
}

struct CustomLinearProgressViewStyle: ProgressViewStyle {
    var progressColor: Color
    var trackColor: Color
    var height: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in 
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(trackColor)
                    .frame(height: height)

                Capsule()
                    .fill(progressColor)
                                        .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * geometry.size.width, height: height)
            }
        }
        .frame(height: height) 
    }
}

struct RootScreen: View {
                @State private var markerPosition: CGPoint = CGPoint(x: 200, y: 400)
    @State private var progress: Float = 0.4

    var body: some View {
                ZStack {
                        LinearGradient(
                gradient: Gradient(colors: [
                    AppTokens.Colors.secondary.opacity(0.2),
                    AppTokens.Colors.background,
                    AppTokens.Colors.primary.opacity(0.2)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea() 

                        VStack(spacing: 0) {
                                ZStack {
                    AppTokens.Colors.background
                        .frame(height: 56) 
                        .ignoresSafeArea(.container, edges: .top) 

                    Text("Transfer Wizard")
                        .font(AppTokens.TypographyTokens.display) 
                        .foregroundColor(AppTokens.Colors.onSurface)
                }
                .frame(maxWidth: .infinity) 

                                GeometryReader { geometry in
                                        ZStack(alignment: .center) {
                                                Canvas { context, size in
                            let center = CGPoint(x: size.width / 2, y: size.height / 2)
                            
                                                        context.fill(Path(ellipseIn: CGRect(x: center.x - 260, y: center.y - 260, width: 520, height: 520)), with: .color(AppTokens.Colors.surfaceVariant))
                            
                                                        context.fill(Path(ellipseIn: CGRect(x: markerPosition.x - 20, y: markerPosition.y - 20, width: 40, height: 40)), with: .color(AppTokens.Colors.primary))
                            
                        }
                                                .padding(AppTokens.Spacing.xl)
                        .frame(maxWidth: .infinity, maxHeight: .infinity) 

                                                                        VStack(spacing: AppTokens.Spacing.lg) {
                            Text("Transfer Progress")
                                .font(AppTokens.TypographyTokens.title) 
                                .foregroundColor(AppTokens.Colors.onSurface)

                                                        ProgressView(value: progress)
                                .progressViewStyle(CustomLinearProgressViewStyle(
                                    progressColor: AppTokens.Colors.primary,
                                    trackColor: AppTokens.Colors.surfaceVariant,
                                    height: 8 
                                ))
                                                                .frame(width: geometry.size.width * 0.8)

                                                        HStack(spacing: AppTokens.Spacing.md) {
                                                                Button(action: {
                                    progress = min(progress + 0.1, 1.0) 
                                }) {
                                    Text("+")
                                        .font(.system(size: 24, weight: .bold)) 
                                        .frame(width: 64, height: 64) 
                                        .background(AppTokens.Colors.primary) 
                                        .foregroundColor(AppTokens.Colors.onPrimary) 
                                        .clipShape(Circle()) 
                                }
                                .buttonStyle(PlainButtonStyle()) 

                                                                Button(action: {
                                    progress = max(progress - 0.1, 0.0) 
                                }) {
                                    Text("-")
                                        .font(.system(size: 24, weight: .bold)) 
                                        .frame(width: 64, height: 64) 
                                        .background(AppTokens.Colors.secondary) 
                                        .foregroundColor(AppTokens.Colors.onSecondary) 
                                        .clipShape(Circle()) 
                                }
                                .buttonStyle(PlainButtonStyle()) 
                            }
                        }
                                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                                                .padding(.bottom, AppTokens.Spacing.xxl)
                    }
                }
            }
        }
        .background(AppTokens.Colors.background) 
        .edgesIgnoringSafeArea(.all) 
        .statusBarHidden(true) 
    }
}

@main
struct TransferWizardApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}