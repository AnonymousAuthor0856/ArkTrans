
import SwiftUI

struct AppTokens {
    struct Colors {
                static let primary = Color(hex: 0xFF111111)
        static let secondary = Color(hex: 0xFF333333)
        static let tertiary = Color(hex: 0xFF777777)
        static let background = Color(hex: 0xFFFFFFFF)
        static let surface = Color(hex: 0xFFF9F9F9)
        static let surfaceVariant = Color(hex: 0xFFE5E5E5)
        static let outline = Color(hex: 0xFFCCCCCC)
        static let success = Color(hex: 0xFF16A34A)
        static let warning = Color(hex: 0xFFF59E0B)
        static let error = Color(hex: 0xFFDC2626)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFFFFFFFF)
        static let onTertiary = Color(hex: 0xFF111111)
        static let onBackground = Color(hex: 0xFF111111)
        static let onSurface = Color(hex: 0xFF111111)
    }

    struct TypographyTokens {
                static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) 
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
                static let smallCornerRadius: CGFloat = 6
        static let mediumCornerRadius: CGFloat = 10
        static let largeCornerRadius: CGFloat = 14
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
                                static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.1)
        static let level2 = ShadowSpec(elevation: 4, radius: 8, dy: 4, opacity: 0.12)
        static let level3 = ShadowSpec(elevation: 8, radius: 12, dy: 6, opacity: 0.15)
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

struct Marker: Identifiable {
    let id = UUID() 
    var x: CGFloat
    var y: CGFloat
    let label: String
}

struct RootScreen: View {
        @State private var markers: [Marker] = [
        Marker(x: 120, y: 200, label: "Store A"),
        Marker(x: 360, y: 400, label: "Store B")
    ]

    var body: some View {
                ZStack {
            AppTokens.Colors.background
                .ignoresSafeArea() 

                        VStack(alignment: .leading, spacing: AppTokens.Spacing.lg) {
                Text("Product Detail")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.primary)

                                                VStack(alignment: .leading, spacing: AppTokens.Spacing.md) {
                                        Rectangle()
                        .fill(AppTokens.Colors.surfaceVariant)
                        .frame(maxWidth: .infinity) 
                        .frame(height: 160) 

                    Text("Monochrome Bag")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)

                    Text("A minimalist and timeless design piece.")
                        .font(AppTokens.TypographyTokens.body)
                        .foregroundColor(AppTokens.Colors.tertiary)

                    Text("$79.00")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.primary)

                                        Button(action: {
                                                print("Add to Cart tapped!")
                    }) {
                        Text("Add to Cart")
                            .font(AppTokens.TypographyTokens.title)
                            .frame(maxWidth: .infinity) 
                            .frame(height: 48) 
                            .background(AppTokens.Colors.primary)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .cornerRadius(AppTokens.Shapes.mediumCornerRadius) 
                    }
                }
                .padding(AppTokens.Spacing.lg) 
                .background(AppTokens.Colors.surface) 
                .cornerRadius(AppTokens.Shapes.largeCornerRadius) 
                                .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity),
                        radius: AppTokens.ElevationMapping.level2.radius,
                        x: 0, 
                        y: AppTokens.ElevationMapping.level2.dy)

                                ZStack {
                                        RoundedRectangle(cornerRadius: AppTokens.Shapes.largeCornerRadius)
                        .fill(AppTokens.Colors.surface)

                                        Canvas { context, size in
                                                context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(AppTokens.Colors.surfaceVariant))

                                                for marker in markers {
                            let center = CGPoint(x: marker.x, y: marker.y)
                            let path = Path { p in
                                p.addArc(center: center, radius: 14, startAngle: .zero, endAngle: .degrees(360), clockwise: true)
                            }
                            context.fill(path, with: .color(AppTokens.Colors.primary))
                        }
                    }
                    .padding(AppTokens.Spacing.lg) 
                }
                .frame(maxWidth: .infinity) 
                .frame(height: 240) 

                                HStack(spacing: AppTokens.Spacing.md) { 
                                        Button(action: {
                                                markers.append(
                            Marker(
                                x: CGFloat.random(in: 100...500),
                                y: CGFloat.random(in: 150...450),
                                label: "New"
                            )
                        )
                    }) {
                        Text("Add Marker")
                            .font(AppTokens.TypographyTokens.label)
                            .frame(maxWidth: .infinity) 
                            .frame(height: 44) 
                            .background(AppTokens.Colors.secondary) 
                            .foregroundColor(AppTokens.Colors.onSecondary) 
                            .cornerRadius(AppTokens.Shapes.mediumCornerRadius) 
                    }

                                        Button(action: {
                        markers.removeAll() 
                    }) {
                        Text("Clear")
                            .font(AppTokens.TypographyTokens.label)
                            .frame(maxWidth: .infinity) 
                            .frame(height: 44) 
                            .background(AppTokens.Colors.tertiary) 
                            .foregroundColor(AppTokens.Colors.onTertiary) 
                            .cornerRadius(AppTokens.Shapes.mediumCornerRadius) 
                    }
                }
            }
            .padding(AppTokens.Spacing.lg) 
        }
    }
}

@main
struct ProductDetailApp: App {
        init() {
                                            }

    var body: some Scene {
        WindowGroup {
            RootScreen()
                .prefersStatusBarHidden(true) 
        }
    }
}

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
            .previewDisplayName("Product Detail Screen") 
    }
}
