
import SwiftUI
import CoreGraphics 


typealias Dp = CGFloat

struct AppTokens {
    struct Colors {
                static func color(hex: UInt) -> Color {
            let red = Double((hex >> 16) & 0xFF) / 255.0
            let green = Double((hex >> 8) & 0xFF) / 255.0
            let blue = Double(hex & 0xFF) / 255.0
            return Color(red: red, green: green, blue: blue)
        }

        static let primary = color(hex: 0xFFFFA8A8)
        static let secondary = color(hex: 0xFFFFE1A8)
        static let tertiary = color(hex: 0xFFA8FFE1)
        static let background = color(hex: 0xFFFFFCF5)
        static let surface = color(hex: 0xFFFFFFFF)
        static let surfaceVariant = color(hex: 0xFFF7F7F7)
        static let outline = color(hex: 0xFFE2E2E2)
        static let success = color(hex: 0xFF22C55E)
        static let warning = color(hex: 0xFFF59E0B)
        static let error = color(hex: 0xFFEF4444)
        static let onPrimary = color(hex: 0xFF1E1E1E)
        static let onSecondary = color(hex: 0xFF1E1E1E)
        static let onTertiary = color(hex: 0xFF1E1E1E)
        static let onBackground = color(hex: 0xFF1E1E1E)
        static let onSurface = color(hex: 0xFF1E1E1E)
    }

    struct TypographyTokens {
        static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let small: Dp = 6
        static let medium: Dp = 12
        static let large: Dp = 20
    }

    struct Spacing {
        static let sm: Dp = 8
        static let md: Dp = 12
        static let lg: Dp = 16
        static let xl: Dp = 24
        static let xxl: Dp = 32
    }

    struct ShadowSpec {
        let elevation: Dp 
        let radius: Dp
        let dy: Dp
        let opacity: Double 
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 6, radius: 8, dy: 4, opacity: 0.18)
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
                    .frame(width: geometry.size.width * CGFloat(configuration.fractionCompleted ?? 0), height: 8)
            }
        }
    }
}

struct CustomSwitchToggleStyle: ToggleStyle {
    var checkedThumbColor: Color
    var uncheckedThumbColor: Color

    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Capsule()
                                .fill(configuration.isOn ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                .frame(width: 51, height: 31) 
                .overlay(
                    Circle()
                                                .fill(configuration.isOn ? checkedThumbColor : uncheckedThumbColor)
                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1) 
                        .padding(2) 
                        .offset(x: configuration.isOn ? (51 - 31) / 2 : -(51 - 31) / 2) 
                )
                .animation(.easeInOut(duration: 0.2), value: configuration.isOn) 
        }
        .buttonStyle(PlainButtonStyle()) 
    }
}

struct FilterChipView: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(AppTokens.TypographyTokens.label)
                .foregroundColor(AppTokens.Colors.onPrimary)
                .padding(.horizontal, AppTokens.Spacing.md) 
                .padding(.vertical, AppTokens.Spacing.sm)   
                .background(
                    RoundedRectangle(cornerRadius: AppTokens.Shapes.small) 
                                                .fill(isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                )
        }
        .buttonStyle(PlainButtonStyle()) 
    }
}


struct RootScreen: View {
    @State private var selectedChip: String = "BTC"
    @State private var progress: Double = 0.6 
    @State private var isAutoUpdate: Bool = true

    var body: some View {
        ZStack { 
                        AppTokens.Colors.background
                .ignoresSafeArea() 

            VStack(spacing: 0) { 
                                Text("Crypto Market")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.onSurface)
                    .padding(.vertical, AppTokens.Spacing.lg) 
                    .frame(maxWidth: .infinity) 
                    .background(AppTokens.Colors.background) 
                    .ignoresSafeArea(.container, edges: .top) 

                                VStack(spacing: AppTokens.Spacing.lg) { 
                                        HStack(spacing: AppTokens.Spacing.md) { 
                        ForEach(["BTC", "ETH", "SOL", "ADA"], id: \.self) { chipText in
                            FilterChipView(
                                text: chipText,
                                isSelected: selectedChip == chipText,
                                action: { selectedChip = chipText }
                            )
                        }
                    }

                                        ZStack { 
                        RoundedRectangle(cornerRadius: AppTokens.Shapes.large)
                            .fill(AppTokens.Colors.surface) 
                            .shadow(
                                color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity),
                                radius: AppTokens.ElevationMapping.level2.radius,
                                x: 0, 
                                y: AppTokens.ElevationMapping.level2.dy
                            )

                                                Canvas { context, size in
                            let w = size.width
                            let h = size.height
                            let step = w / 30
                            let initialPrevY = h / 2 

                            var path = Path()
                                                        path.move(to: CGPoint(x: -step, y: initialPrevY))

                            for i in 0...30 { 
                                let x = Dp(i) * step
                                let y = h / 2 + sin(Double(i) * .pi / 6 + progress * .pi) * (h / 3)
                                path.addLine(to: CGPoint(x: x, y: y)) 
                            }
                            context.stroke(path, with: .color(AppTokens.Colors.primary), lineWidth: 5)
                        }
                        .padding(AppTokens.Spacing.lg) 
                    }
                    .frame(maxWidth: .infinity, minHeight: 260, maxHeight: 260) 

                                        Text("Price Variation")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.primary)

                                        ProgressView(value: progress)
                        .progressViewStyle(LinearProgressViewStyle(tint: AppTokens.Colors.primary, track: AppTokens.Colors.surfaceVariant))
                        .frame(maxWidth: .infinity)
                        .frame(height: 8) 

                                        HStack {
                        Text("Auto Update")
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(AppTokens.Colors.onSurface)

                        Spacer() 

                        Toggle(isOn: $isAutoUpdate) {
                            EmptyView() 
                        }
                        .toggleStyle(CustomSwitchToggleStyle(
                            checkedThumbColor: AppTokens.Colors.secondary,
                            uncheckedThumbColor: AppTokens.Colors.outline
                        ))
                    }
                }
                .padding(AppTokens.Spacing.lg) 
                .background(
                    LinearGradient( 
                        gradient: Gradient(colors: [
                            AppTokens.Colors.secondary.opacity(0.3),
                            AppTokens.Colors.background,
                            AppTokens.Colors.tertiary.opacity(0.3)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity) 
            }
        }
        .statusBarHidden(true) 
    }
}


@main
struct CryptoMarketApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}
