import SwiftUI

struct AppTokens {
    struct Colors {
        static let primary = Color(red: 1.0, green: 0.44, blue: 0.26)
        static let secondary = Color(red: 1.0, green: 0.72, blue: 0.3)
        static let tertiary = Color(red: 1.0, green: 0.82, blue: 0.5)
        static let background = Color(red: 1.0, green: 0.95, blue: 0.88)
        static let surface = Color(red: 1.0, green: 1.0, blue: 1.0)
        static let surfaceVariant = Color(red: 1.0, green: 0.88, blue: 0.7)
        static let outline = Color(red: 0.84, green: 0.8, blue: 0.78)
        static let success = Color(red: 0.4, green: 0.73, blue: 0.42)
        static let warning = Color(red: 1.0, green: 0.79, blue: 0.16)
        static let error = Color(red: 0.83, green: 0.18, blue: 0.18)
        static let onPrimary = Color(red: 1.0, green: 1.0, blue: 1.0)
        static let onSecondary = Color(red: 0.24, green: 0.15, blue: 0.14)
        static let onBackground = Color(red: 0.24, green: 0.15, blue: 0.14)
        static let onSurface = Color(red: 0.24, green: 0.15, blue: 0.14)
    }

    struct TypographyTokens {
        static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let small: CGFloat = 6.0
        static let medium: CGFloat = 10.0
        static let large: CGFloat = 16.0
    }

    struct Spacing {
        static let sm: CGFloat = 6.0
        static let md: CGFloat = 10.0
        static let lg: CGFloat = 16.0
        static let xl: CGFloat = 24.0
    }
}

struct CustomSlider: View {
    @Binding var value: Float
    let activeColor: Color
    let inactiveColor: Color
    let thumbColor: Color
    let trackHeight: CGFloat = 10
    let thumbDiameter: CGFloat = 20

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(inactiveColor)
                    .frame(height: trackHeight)

                Capsule()
                    .fill(activeColor)
                    .frame(width: geometry.size.width * CGFloat(value), height: trackHeight)

                Circle()
                    .fill(thumbColor)
                    .frame(width: thumbDiameter, height: thumbDiameter)
                    .offset(x: geometry.size.width * CGFloat(value) - thumbDiameter / 2)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                let dragLocation = gesture.location.x
                                let newValue = Float(min(max(0, dragLocation / geometry.size.width), 1))
                                self.value = newValue
                            }
                    )
            }
        }
        .frame(height: thumbDiameter)
    }
}

struct RootScreen: View {
    @State private var progress: Float = 0.42 

    var body: some View {
        ZStack {
                        AppTokens.Colors.background.ignoresSafeArea(.all)

                        VStack(spacing: AppTokens.Spacing.lg) {
                                Text("Order Tracking")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.onBackground)
                    .frame(maxWidth: .infinity, alignment: .leading)

                                VStack(spacing: AppTokens.Spacing.md) {
                    Text("Order #25491")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("Estimated Delivery: 2 days")
                        .font(AppTokens.TypographyTokens.body)
                        .foregroundColor(AppTokens.Colors.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                                        GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(AppTokens.Colors.surfaceVariant)
                                .frame(height: 10)

                            Capsule()
                                .fill(AppTokens.Colors.primary)
                                .frame(width: geometry.size.width * CGFloat(progress), height: 10)
                        }
                    }
                    .frame(height: 10)

                                        HStack {
                        Text("Processing")
                            .font(AppTokens.TypographyTokens.label)
                            .foregroundColor(AppTokens.Colors.secondary)

                        Spacer() 

                        Text("\(Int(progress * 100))%")
                            .font(AppTokens.TypographyTokens.label)
                            .foregroundColor(AppTokens.Colors.primary)
                    }
                }
                .padding(AppTokens.Spacing.lg)
                .background(AppTokens.Colors.surface)
                .cornerRadius(AppTokens.Shapes.large)
                .shadow(
                    color: Color.black.opacity(0.15),
                    radius: 8,
                    x: 0,
                    y: 4 
                )

                                VStack(spacing: AppTokens.Spacing.md) {
                    Text("Adjust Progress")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)
                        .frame(maxWidth: .infinity, alignment: .center)

                    CustomSlider(
                        value: $progress,
                        activeColor: AppTokens.Colors.primary,
                        inactiveColor: AppTokens.Colors.surfaceVariant,
                        thumbColor: AppTokens.Colors.primary
                    )

                    Button(action: {
                        progress = 1.0 
                    }) {
                        Text("Mark as Delivered")
                            .font(AppTokens.TypographyTokens.label)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .padding(.vertical, AppTokens.Spacing.md)
                            .frame(maxWidth: .infinity)
                            .background(AppTokens.Colors.primary)
                            .cornerRadius(AppTokens.Shapes.medium)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(AppTokens.Spacing.lg)
                .background(AppTokens.Colors.surface)
                .cornerRadius(AppTokens.Shapes.large)
            }
                                    .padding(AppTokens.Spacing.lg)
        }
        .ignoresSafeArea(.all)
        .statusBarHidden(true) 
    }
}

@main
struct OrderTrackingApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}