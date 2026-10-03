import SwiftUI
import CoreGraphics 
import UIKit      

struct AppTokens {
    struct Colors {
        static let primary = Color(red: 0xFF / 255.0, green: 0xA5 / 255.0, blue: 0x00 / 255.0) 
        static let secondary = Color(red: 0xFF / 255.0, green: 0xC1 / 255.0, blue: 0x07 / 255.0) 
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

    struct Shapes {
        static let small: CGFloat = 6.0
        static let medium: CGFloat = 12.0
        static let large: CGFloat = 20.0
    }

    struct Spacing {
        static let sm: CGFloat = 8.0
        static let md: CGFloat = 12.0
        static let lg: CGFloat = 16.0
        static let xl: CGFloat = 24.0
        static let xxl: CGFloat = 32.0
    }

                struct ShadowSpec {
        let radius: CGFloat 
        let dy: CGFloat     
        let opacity: Double 
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(radius: 4, dy: 2, opacity: 0.12)
        static let level2 = ShadowSpec(radius: 8, dy: 4, opacity: 0.18)
    }
}


struct CustomLinearProgressIndicator: View {
    let progress: Double
    let color: Color
    let trackColor: Color
    let height: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                trackColor 
                    .frame(width: geometry.size.width, height: height)
                    .cornerRadius(height / 2)

                color 
                    .frame(width: geometry.size.width * CGFloat(progress), height: height)
                    .cornerRadius(height / 2)
            }
        }
        .frame(height: height)
    }
}

struct CustomSlider: UIViewRepresentable {
    @Binding var value: Float
    let activeTrackColor: Color
    let inactiveTrackColor: Color
    let thumbColor: Color

    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = value
        slider.addTarget(context.coordinator, action: #selector(Coordinator.valueChanged(_:)), for: .valueChanged)

                slider.minimumTrackTintColor = UIColor(activeTrackColor)
        slider.maximumTrackTintColor = UIColor(inactiveTrackColor)

                slider.thumbTintColor = UIColor(thumbColor)

        return slider
    }

    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = value
        uiView.minimumTrackTintColor = UIColor(activeTrackColor)
        uiView.maximumTrackTintColor = UIColor(inactiveTrackColor)
        uiView.thumbTintColor = UIColor(thumbColor)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: CustomSlider

        init(_ parent: CustomSlider) {
            self.parent = parent
        }

        @objc func valueChanged(_ sender: UISlider) {
            parent.value = sender.value
        }
    }
}

extension Double {
        func toCGFloat() -> CGFloat {
        return CGFloat(self)
    }
}


struct SurfaceWithCanvas: View {
    @Binding var paymentProgress: Float

    var body: some View {
        ZStack {
                        RoundedRectangle(cornerRadius: AppTokens.Shapes.large)
                .fill(AppTokens.Colors.surface.opacity(0.9))
                .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity),
                        radius: AppTokens.ElevationMapping.level2.radius,
                        x: 0,
                        y: AppTokens.ElevationMapping.level2.dy)
                .frame(height: 240) 

                        Canvas { context, size in
                let w = size.width
                let h = size.height
                let step = w / 20 

                var path = Path()
                
                                let initialY = h / 2 + sin(0 * Double.pi / 5 + Double(paymentProgress) * Double.pi).toCGFloat() * (h / 3)
                path.move(to: CGPoint(x: 0, y: initialY))

                                for i in 1...20 {
                    let x = CGFloat(i) * step
                    let y = h / 2 + sin(Double(i) * Double.pi / 5 + Double(paymentProgress) * Double.pi).toCGFloat() * (h / 3)
                    path.addLine(to: CGPoint(x: x, y: y))
                }
                context.stroke(path, with: .color(AppTokens.Colors.primary), lineWidth: 5)
            }
            .padding(AppTokens.Spacing.lg) 
            .frame(height: 240) 
        }
        .frame(maxWidth: .infinity) 
    }
}

struct RootScreen: View {
    @State private var paymentProgress: Float = 0.3 

    var body: some View {
                VStack(spacing: 0) { 
                        Text("Installment Plan")
                .font(AppTokens.TypographyTokens.display)
                .foregroundColor(AppTokens.Colors.onSurface)
                .frame(maxWidth: .infinity)
                .frame(height: 64) 
                .background(AppTokens.Colors.background) 

                        VStack(spacing: AppTokens.Spacing.lg) { 
                SurfaceWithCanvas(paymentProgress: $paymentProgress)

                Text("Payment Progress")
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.primary)

                CustomLinearProgressIndicator(
                    progress: Double(paymentProgress),
                    color: AppTokens.Colors.primary,
                    trackColor: AppTokens.Colors.surfaceVariant,
                    height: 8
                )
                .frame(maxWidth: .infinity) 

                CustomSlider(
                    value: $paymentProgress,
                    activeTrackColor: AppTokens.Colors.primary,
                    inactiveTrackColor: AppTokens.Colors.surfaceVariant,
                    thumbColor: AppTokens.Colors.secondary
                )
                .frame(maxWidth: .infinity) 

                Button(action: {
                    paymentProgress = 0.0 
                }) {
                    Text("Reset Progress")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onTertiary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity) 
                }
                .frame(height: 48) 
                .background(AppTokens.Colors.tertiary) 
                .cornerRadius(AppTokens.Shapes.medium) 
                .buttonStyle(PlainButtonStyle()) 
            }
            .padding(AppTokens.Spacing.lg) 
            .frame(maxWidth: .infinity, maxHeight: .infinity) 
            .background(
                LinearGradient( 
                    gradient: Gradient(colors: [
                        AppTokens.Colors.secondary.opacity(0.25),
                        AppTokens.Colors.background,
                        AppTokens.Colors.primary.opacity(0.25)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .background(AppTokens.Colors.background) 
        .ignoresSafeArea() 
        .statusBarHidden(true) 
    }
}

@main
struct InstallmentPlanApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}