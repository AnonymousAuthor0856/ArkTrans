
import SwiftUI

struct AppTokens {
        struct Colors {
                                                                                                                                
        static let primary = Color(red: 255/255, green: 140/255, blue: 0/255)
        static let secondary = Color(red: 255/255, green: 193/255, blue: 7/255)
        static let tertiary = Color(red: 255/255, green: 224/255, blue: 130/255)
        static let background = Color(red: 255/255, green: 248/255, blue: 225/255)
        static let surface = Color(red: 255/255, green: 255/255, blue: 255/255)
        static let surfaceVariant = Color(red: 255/255, green: 236/255, blue: 179/255)
        static let outline = Color(red: 215/255, green: 204/255, blue: 200/255)
        static let success = Color(red: 76/255, green: 175/255, blue: 80/255)
        static let warning = Color(red: 255/255, green: 179/255, blue: 0/255)
        static let error = Color(red: 229/255, green: 57/255, blue: 53/255)
        static let onPrimary = Color(red: 62/255, green: 39/255, blue: 35/255)
        static let onSecondary = Color(red: 62/255, green: 39/255, blue: 35/255)
        static let onBackground = Color(red: 62/255, green: 39/255, blue: 35/255)
        static let onSurface = Color(red: 62/255, green: 39/255, blue: 35/255)
    }

        struct TypographyTokens {
                static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) 
        static let label = Font.system(size: 12, weight: .medium)
    }

        struct Shapes {
                static let small = RoundedRectangle(cornerRadius: 6)
        static let medium = RoundedRectangle(cornerRadius: 10)
        static let large = RoundedRectangle(cornerRadius: 16)
    }

        struct Spacing {
                static let sm: CGFloat = 6
        static let md: CGFloat = 10
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
    }

        struct ShadowSpec {
        let elevation: CGFloat 
        let radius: CGFloat    
        let dy: CGFloat        
        let opacity: Double    
    }

        struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.1)
        static let level2 = ShadowSpec(elevation: 6, radius: 8, dy: 4, opacity: 0.15)
        static let level3 = ShadowSpec(elevation: 10, radius: 12, dy: 6, opacity: 0.18)
    }
}

struct Pin: Identifiable {
    let id = UUID() 
    var x: CGFloat
    var y: CGFloat
    var label: String
}

struct RootScreen: View {
        @State private var pins: [Pin] = [
        Pin(x: 150, y: 250, label: "Group A"),
        Pin(x: 350, y: 420, label: "Group B"),
        Pin(x: 520, y: 310, label: "Group C")
    ]

    var body: some View {
                        ZStack {
            AppTokens.Colors.background 
                .ignoresSafeArea(.all, edges: .all) 

            VStack(spacing: AppTokens.Spacing.lg) { 
                Text("Retro Group Buy")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.onBackground)
                    .frame(maxWidth: .infinity, alignment: .leading) 

                                VStack(alignment: .leading, spacing: AppTokens.Spacing.md) { 
                    Text("Live Deals Map")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)

                                        ZStack {
                                                AppTokens.Colors.surfaceVariant
                            .clipShape(AppTokens.Shapes.medium) 

                        Canvas { context, size in
                                                        for pin in pins {
                                let center = CGPoint(x: pin.x, y: pin.y)
                                                                let path = Path(ellipseIn: CGRect(x: center.x - 14, y: center.y - 14, width: 28, height: 28))
                                context.fill(path, with: .color(AppTokens.Colors.primary))
                            }
                        }
                        .padding(8) 
                    }
                    .frame(maxWidth: .infinity) 
                    .frame(height: 220) 
                                                            .background(AppTokens.Colors.surfaceVariant)
                    .clipShape(AppTokens.Shapes.medium)
                }
                .padding(AppTokens.Spacing.lg) 
                .background(AppTokens.Colors.surface) 
                .clipShape(AppTokens.Shapes.large) 
                .shadow(color: AppTokens.Colors.onSurface.opacity(AppTokens.ElevationMapping.level2.opacity),
                        radius: AppTokens.ElevationMapping.level2.elevation, 
                        x: 0, 
                        y: AppTokens.ElevationMapping.level2.dy) 

                Spacer().frame(height: AppTokens.Spacing.sm) 

                                HStack(spacing: AppTokens.Spacing.md) { 
                    Button(action: {
                                                                        let randomX = CGFloat.random(in: 100..<550)
                        let randomY = CGFloat.random(in: 150..<450)
                        pins.append(Pin(x: randomX, y: randomY, label: "New"))
                    }) {
                        Text("Add Group")
                            .font(AppTokens.TypographyTokens.label)
                            .foregroundColor(AppTokens.Colors.onSecondary)
                            .frame(maxWidth: .infinity) 
                            .frame(height: 48) 
                            .background(AppTokens.Colors.secondary) 
                            .clipShape(AppTokens.Shapes.medium) 
                    }
                    .buttonStyle(PlainButtonStyle()) 

                    Button(action: {
                        pins.removeAll()
                    }) {
                        Text("Clear")
                            .font(AppTokens.TypographyTokens.label)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .frame(maxWidth: .infinity) 
                            .frame(height: 48) 
                            .background(AppTokens.Colors.primary) 
                            .clipShape(AppTokens.Shapes.medium) 
                    }
                    .buttonStyle(PlainButtonStyle()) 
                }

                                VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) { 
                    Text("Active Groups")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.primary)

                                        ForEach(pins) { pin in
                        HStack { 
                            Text(pin.label)
                                .font(AppTokens.TypographyTokens.body)
                                .foregroundColor(AppTokens.Colors.onSurface)
                            Spacer() 
                            Circle() 
                                .fill(AppTokens.Colors.primary)
                                .frame(width: 14, height: 14) 
                        }
                    }
                }
                .padding(AppTokens.Spacing.lg) 
                .background(AppTokens.Colors.surface) 
                .clipShape(AppTokens.Shapes.large) 
                .shadow(color: AppTokens.Colors.onSurface.opacity(AppTokens.ElevationMapping.level1.opacity),
                        radius: AppTokens.ElevationMapping.level1.elevation, 
                        x: 0,
                        y: AppTokens.ElevationMapping.level1.dy) 

                Spacer() 
            }
            .padding(AppTokens.Spacing.lg) 
        }
                                                        .statusBarHidden(true)
    }
}

@main
struct GroupBuyApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}