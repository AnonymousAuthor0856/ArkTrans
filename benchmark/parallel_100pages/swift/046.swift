import SwiftUI


extension Color {
    init(hex: UInt) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: Double((hex >> 24) & 0xFF) / 255.0 
        )
    }
}

struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFF7B61FF)
        static let secondary = Color(hex: 0xFF26C6DA)
        static let tertiary = Color(hex: 0xFFFF8A80)
        static let background = Color(hex: 0xFFF5F7FF)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFF0F2F8)
        static let outline = Color(hex: 0xFFE0E3EB)
        static let success = Color(hex: 0xFF22C55E)
        static let warning = Color(hex: 0xFFF59E0B)
        static let error = Color(hex: 0xFFEF4444)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFF0B1220)
        static let onTertiary = Color(hex: 0xFF0B1220)
        static let onBackground = Color(hex: 0xFF0B1220)
        static let onSurface = Color(hex: 0xFF0B1220)
    }

    struct TypographyTokens {
                static func display() -> Font { .system(size: 28, weight: .bold) }
        static func headline() -> Font { .system(size: 20, weight: .semibold) }
        static func title() -> Font { .system(size: 16, weight: .medium) }
        static func body() -> Font { .system(size: 14, weight: .regular) }
        static func label() -> Font { .system(size: 12, weight: .medium) }
    }

    struct Shapes {
                static let smallCornerRadius: CGFloat = 8
        static let mediumCornerRadius: CGFloat = 14
        static let largeCornerRadius: CGFloat = 20
    }

    struct Spacing {
                static let xs: CGFloat = 4
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
        static let level2 = ShadowSpec(elevation: 6, radius: 10, dy: 6, opacity: 0.16)
        static let level3 = ShadowSpec(elevation: 10, radius: 14, dy: 8, opacity: 0.18)
    }
}


struct AppColorScheme {
    let primary = AppTokens.Colors.primary
    let onPrimary = AppTokens.Colors.onPrimary
    let secondary = AppTokens.Colors.secondary
    let onSecondary = AppTokens.Colors.onSecondary
    let tertiary = AppTokens.Colors.tertiary
    let onTertiary = AppTokens.Colors.onTertiary
    let background = AppTokens.Colors.background
    let onBackground = AppTokens.Colors.onBackground
    let surface = AppTokens.Colors.surface
    let onSurface = AppTokens.Colors.onSurface
    let surfaceVariant = AppTokens.Colors.surfaceVariant
    let outline = AppTokens.Colors.outline
    let error = AppTokens.Colors.error
}


struct Coupon: Identifiable {
    let id: Int
    let title: String
    let value: String
    let colorA: Color
    let colorB: Color
}

struct MapPin: Identifiable {
    let id = UUID() 
    let x: CGFloat
    let y: CGFloat
    let label: String
    let tint: Color
}


struct RootScreen: View {
        private var appColorScheme: AppColorScheme { AppColorScheme() }

        let coupons: [Coupon] = [
        Coupon(id: 1, title: "Grocery Pack", value: "-$5", colorA: AppTokens.Colors.primary, colorB: AppTokens.Colors.secondary),
        Coupon(id: 2, title: "Cafe Bundle", value: "-15%", colorA: AppTokens.Colors.secondary, colorB: AppTokens.Colors.tertiary),
        Coupon(id: 3, title: "Electro Deal", value: "-$20", colorA: AppTokens.Colors.tertiary, colorB: AppTokens.Colors.primary),
        Coupon(id: 4, title: "Fashion Duo", value: "-10%", colorA: AppTokens.Colors.secondary, colorB: AppTokens.Colors.primary)
    ]

        @State private var pins: [MapPin] = [
        MapPin(x: 140, y: 220, label: "A", tint: AppTokens.Colors.primary),
        MapPin(x: 320, y: 400, label: "B", tint: AppTokens.Colors.secondary),
        MapPin(x: 520, y: 300, label: "C", tint: AppTokens.Colors.tertiary)
    ]

    var body: some View {
                ZStack {
                        LinearGradient(
                gradient: Gradient(colors: [
                    AppTokens.Colors.secondary.opacity(0.25),
                    AppTokens.Colors.background,
                    AppTokens.Colors.primary.opacity(0.25)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all) 

                        VStack(spacing: AppTokens.Spacing.lg) { 
                                HStack {
                                        Button(action: {}) {
                        Circle()
                            .fill(appColorScheme.onSurface)
                            .frame(width: 20, height: 20) 
                    }
                    .padding(.leading, AppTokens.Spacing.lg) 

                    Spacer() 

                                        Text("Coupon Pack")
                        .font(AppTokens.TypographyTokens.display()) 
                        .foregroundColor(appColorScheme.onSurface) 

                    Spacer() 

                                        Button(action: {}) {
                        Circle()
                            .fill(appColorScheme.primary)
                            .frame(width: 20, height: 20) 
                    }
                    .padding(.trailing, AppTokens.Spacing.lg) 
                }
                .padding(.top, AppTokens.Spacing.lg) 

                                VStack(alignment: .leading, spacing: AppTokens.Spacing.lg) {
                                        Text("Nearby Packs")
                        .font(AppTokens.TypographyTokens.headline()) 
                        .foregroundColor(appColorScheme.onSurface) 

                                        ZStack(alignment: .topTrailing) { 
                        RoundedRectangle(cornerRadius: AppTokens.Shapes.largeCornerRadius) 
                            .fill(appColorScheme.surface) 
                            .aspectRatio(16 / 9, contentMode: .fit) 
                            .overlay(
                                                                Canvas { context, size in
                                                                        context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(AppTokens.Colors.surfaceVariant))

                                                                        for pin in pins {
                                                                                                                                                                context.fill(Path(ellipseIn: CGRect(x: pin.x - 14, y: pin.y - 14, width: 28, height: 28)), with: .color(pin.tint))
                                    }
                                }
                                .padding(AppTokens.Spacing.md) 
                            )
                                                        .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity), radius: AppTokens.ElevationMapping.level2.radius, x: 0, y: AppTokens.ElevationMapping.level2.dy)

                                                HStack(spacing: AppTokens.Spacing.sm) { 
                            Circle()
                                .fill(AppTokens.Colors.primary)
                                .frame(width: 10, height: 10) 
                            Text("A")
                                .font(AppTokens.TypographyTokens.label()) 
                                .foregroundColor(appColorScheme.onSurface)

                            Circle()
                                .fill(AppTokens.Colors.secondary)
                                .frame(width: 10, height: 10)
                            Text("B")
                                .font(AppTokens.TypographyTokens.label())
                                .foregroundColor(appColorScheme.onSurface)

                            Circle()
                                .fill(AppTokens.Colors.tertiary)
                                .frame(width: 10, height: 10)
                            Text("C")
                                .font(AppTokens.TypographyTokens.label())
                                .foregroundColor(appColorScheme.onSurface)
                        }
                        .padding(.horizontal, AppTokens.Spacing.md) 
                        .padding(.vertical, AppTokens.Spacing.xs) 
                        .background(
                            RoundedRectangle(cornerRadius: AppTokens.Shapes.smallCornerRadius) 
                                .fill(appColorScheme.surface.opacity(0.9)) 
                        )
                        .padding(AppTokens.Spacing.md) 
                    }

                                        Text("Your Coupon Packs")
                        .font(AppTokens.TypographyTokens.headline())
                        .foregroundColor(appColorScheme.onSurface)

                                        ScrollView(.horizontal, showsIndicators: false) { 
                        LazyHStack(spacing: AppTokens.Spacing.lg) { 
                            ForEach(coupons) { coupon in 
                                                                ZStack {
                                                                        RoundedRectangle(cornerRadius: AppTokens.Shapes.largeCornerRadius) 
                                        .fill(appColorScheme.surface) 
                                        .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity), radius: AppTokens.ElevationMapping.level2.radius, x: 0, y: AppTokens.ElevationMapping.level2.dy) 

                                                                        VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) { 
                                        HStack(spacing: AppTokens.Spacing.sm) { 
                                            Circle()
                                                .fill(appColorScheme.primary) 
                                                .frame(width: 14, height: 14) 
                                            Text(coupon.title)
                                                .font(AppTokens.TypographyTokens.title()) 
                                                .foregroundColor(appColorScheme.onSurface)
                                        }
                                        Text(coupon.value)
                                            .font(AppTokens.TypographyTokens.display()) 
                                            .foregroundColor(appColorScheme.onSurface)
                                                                                Button(action: {}) {
                                            Text("Redeem")
                                                .font(AppTokens.TypographyTokens.label()) 
                                                .frame(maxWidth: .infinity) 
                                                .frame(height: 40) 
                                                .background(appColorScheme.primary) 
                                                .foregroundColor(appColorScheme.onPrimary) 
                                                .cornerRadius(AppTokens.Shapes.mediumCornerRadius) 
                                        }
                                    }
                                    .padding(AppTokens.Spacing.lg) 
                                    .background(
                                                                                LinearGradient(
                                            gradient: Gradient(colors: [coupon.colorA.opacity(0.18), coupon.colorB.opacity(0.18)]), 
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .cornerRadius(AppTokens.Shapes.largeCornerRadius) 
                                }
                                .frame(width: 200, height: 140) 
                            }
                        }
                        .padding(.horizontal, AppTokens.Spacing.xs) 
                    }

                                        Spacer(minLength: AppTokens.Spacing.sm) 

                                        HStack(spacing: AppTokens.Spacing.md) { 
                                                Button(action: {}) {
                            Text("My Coupons")
                                .font(AppTokens.TypographyTokens.title()) 
                                .frame(maxWidth: .infinity) 
                                .frame(height: 52) 
                                .background(appColorScheme.secondary) 
                                .foregroundColor(appColorScheme.onSecondary) 
                                .cornerRadius(AppTokens.Shapes.largeCornerRadius) 
                        }
                                                Button(action: {}) {
                            Text("Explore More")
                                .font(AppTokens.TypographyTokens.title()) 
                                .frame(maxWidth: .infinity) 
                                .frame(height: 52) 
                                .background(appColorScheme.primary) 
                                .foregroundColor(appColorScheme.onPrimary) 
                                .cornerRadius(AppTokens.Shapes.largeCornerRadius) 
                        }
                    }
                }
                .padding(.horizontal, AppTokens.Spacing.lg) 
            }
        }
        .edgesIgnoringSafeArea(.all) 
        .statusBarHidden(true) 
    }
}


@main
struct CouponPackApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}


struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
                        .background(AppTokens.Colors.background)
            .edgesIgnoringSafeArea(.all) 
    }
}