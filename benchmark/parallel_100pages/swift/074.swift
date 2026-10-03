import SwiftUI

struct AppTokens {

    struct Colors {
                static let primary = Color(hex: 0xFFD95F02)
        static let secondary = Color(hex: 0xFF1B9AAA)
        static let tertiary = Color(hex: 0xFFFEC601)
        static let background = Color(hex: 0xFFF9F4EB)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFF0E3D1)
        static let outline = Color(hex: 0xFFE1CDB2)
        static let success = Color(hex: 0xFF56C271)
        static let warning = Color(hex: 0xFFF4A259)
        static let error = Color(hex: 0xFFD7263D)
        static let onPrimary = Color(hex: 0xFF1B1B1B)
        static let onSecondary = Color(hex: 0xFF041012)
        static let onTertiary = Color(hex: 0xFF1E1200)
        static let onBackground = Color(hex: 0xFF2C2A29)
        static let onSurface = Color(hex: 0xFF2E2924)
    }

    struct TypographyTokens {
                                        static let display = Font.system(size: 28, weight: .semibold)
        static let headline = Font.system(size: 20, weight: .semibold)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 13, weight: .regular)
        static let label = Font.system(size: 11, weight: .medium)
    }

    struct Shapes {
                static let small = CGFloat(12)
        static let medium = CGFloat(16)
        static let large = CGFloat(20)
    }

    struct Spacing {
                static let xs = CGFloat(4)
        static let sm = CGFloat(8)
        static let md = CGFloat(12)
        static let lg = CGFloat(16)
        static let xl = CGFloat(20)
        static let xxl = CGFloat(28)
        static let xxxl = CGFloat(40)
    }

        struct ShadowSpec {
        let elevation: CGFloat 
        let radius: CGFloat    
        let dy: CGFloat        
        let opacity: Double    
    }

    struct ElevationMapping {
                static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 4, radius: 8, dy: 4, opacity: 0.16)
        static let level3 = ShadowSpec(elevation: 8, radius: 12, dy: 6, opacity: 0.2)
        static let level4 = ShadowSpec(elevation: 12, radius: 16, dy: 8, opacity: 0.24)
        static let level5 = ShadowSpec(elevation: 16, radius: 20, dy: 10, opacity: 0.28)
    }
}

extension Color {
    init(hex: UInt) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: Double((hex >> 24) & 0xFF) == 0 ? 1.0 : Double((hex >> 24) & 0xFF) / 255.0 
        )
    }
}

struct Zone: Identifiable {
    let id = UUID() 
    let name: String
    let humidity: Float
    let temp: String
}

struct StatusRow: View {
    let label: String
    let value: Float
    let accent: Color

    var body: some View {
        VStack(alignment: .leading, spacing: AppTokens.Spacing.xs) {
            HStack {
                Text(label)
                    .font(AppTokens.TypographyTokens.body)
                    .foregroundColor(AppTokens.Colors.onSurface)
                Spacer()
                Text("\(Int(value * 100))%")
                    .font(AppTokens.TypographyTokens.label)
                    .foregroundColor(accent)
            }
                        ProgressView(value: value)
                .tint(accent) 
                .background(AppTokens.Colors.surface) 
                .frame(height: 4) 
                .cornerRadius(2) 
        }
    }
}

struct ZoneRow: View {
    let zone: Zone

    var body: some View {
        VStack(alignment: .leading, spacing: AppTokens.Spacing.xs) {
            HStack {
                Text(zone.name)
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.onSurface)
                Spacer()
                Text(zone.temp)
                    .font(AppTokens.TypographyTokens.label)
                    .foregroundColor(AppTokens.Colors.primary)
            }
                        ProgressView(value: zone.humidity)
                .tint(AppTokens.Colors.secondary)
                .background(AppTokens.Colors.surface) 
                .frame(height: 4) 
                .cornerRadius(2) 
        }
        .padding(AppTokens.Spacing.sm)
        .background(AppTokens.Colors.surfaceVariant.opacity(0.5)) 
        .cornerRadius(AppTokens.Shapes.small) 
    }
}

struct RootScreen: View {
        @State private var activeMode: String = "Orbit"
    @State private var solarLevel: Float = 0.6
    @State private var ambientGlow: Float = 0.35

    let modes = ["Orbit", "Eclipse", "Manual"]
    let zones = [
        Zone(name: "Atrium", humidity: 0.45, temp: "72°F"),
        Zone(name: "Lab East", humidity: 0.62, temp: "68°F"),
        Zone(name: "Hab Deck", humidity: 0.30, temp: "70°F")
    ]

    var body: some View {
                ZStack {
            AppTokens.Colors.background.ignoresSafeArea(.all) 

                        VStack(spacing: 0) {
                                                HStack {
                    Button {
                                            } label: {
                        Text("Dock")
                            .font(AppTokens.TypographyTokens.label)
                            .foregroundColor(AppTokens.Colors.onSurface)
                    }
                    Spacer() 
                    Text("Smart Orbit Panel")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)
                    Spacer() 
                    Button {
                                            } label: {
                        Text("Alerts")
                            .font(AppTokens.TypographyTokens.label)
                            .foregroundColor(AppTokens.Colors.secondary)
                    }
                }
                .padding(.horizontal, AppTokens.Spacing.lg) 
                .frame(height: 56) 
                .background(AppTokens.Colors.surface) 
                
                                                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: AppTokens.Spacing.md) {
                                                HStack(spacing: AppTokens.Spacing.sm) {
                            ForEach(modes, id: \.self) { mode in
                                Button {
                                    activeMode = mode
                                } label: {
                                    Text(mode)
                                        .font(AppTokens.TypographyTokens.label)
                                        .foregroundColor(AppTokens.Colors.onSurface)
                                        .padding(.horizontal, AppTokens.Spacing.md) 
                                        .padding(.vertical, AppTokens.Spacing.sm)   
                                        .background(
                                            RoundedRectangle(cornerRadius: AppTokens.Shapes.small) 
                                                .fill(activeMode == mode ? AppTokens.Colors.primary.opacity(0.15) : AppTokens.Colors.surface) 
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: AppTokens.Shapes.small)
                                                        .stroke(AppTokens.Colors.outline, lineWidth: 1) 
                                                )
                                        )
                                }
                                .buttonStyle(PlainButtonStyle()) 
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading) 

                                                                        VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
                            Text("Solar wash")
                                .font(AppTokens.TypographyTokens.headline)
                                .foregroundColor(AppTokens.Colors.onSurface)
                            Text("Adjust orbital window glow")
                                .font(AppTokens.TypographyTokens.body)
                                .foregroundColor(AppTokens.Colors.onSurface.opacity(0.7))
                            
                                                        Slider(value: $solarLevel, in: 0...1)
                                .tint(AppTokens.Colors.primary) 
                            
                                                        HStack {
                                Text("0%")
                                    .font(AppTokens.TypographyTokens.label)
                                    .foregroundColor(AppTokens.Colors.onSurface)
                                Spacer()
                                Text("\(Int(solarLevel * 100))%")
                                    .font(AppTokens.TypographyTokens.title)
                                    .foregroundColor(AppTokens.Colors.primary)
                            }
                            .frame(maxWidth: .infinity) 

                                                        Text("Ambient glow")
                                .font(AppTokens.TypographyTokens.headline)
                                .foregroundColor(AppTokens.Colors.onSurface)
                            
                                                        Slider(value: $ambientGlow, in: 0...1)
                                .tint(AppTokens.Colors.secondary) 
                            
                                                        ProgressView(value: ambientGlow)
                                .tint(AppTokens.Colors.secondary)
                                .background(AppTokens.Colors.surfaceVariant) 
                                .frame(height: 4) 
                                .cornerRadius(2) 
                        }
                        .padding(AppTokens.Spacing.lg) 
                        .background(AppTokens.Colors.surface) 
                        .cornerRadius(AppTokens.Shapes.large) 
                                                .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity),
                                radius: AppTokens.ElevationMapping.level1.radius,
                                x: 0, y: AppTokens.ElevationMapping.level1.dy)

                                                                        VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
                            Text("Orbit health")
                                .font(AppTokens.TypographyTokens.headline)
                                .foregroundColor(AppTokens.Colors.onSurface)
                            StatusRow(label: "Atmos mix", value: 0.74, accent: AppTokens.Colors.secondary)
                            StatusRow(label: "Hull temp", value: 0.42, accent: AppTokens.Colors.primary)
                            StatusRow(label: "Shield sync", value: 0.88, accent: AppTokens.Colors.tertiary)
                        }
                        .padding(AppTokens.Spacing.lg) 
                        .background(AppTokens.Colors.surfaceVariant) 
                        .cornerRadius(AppTokens.Shapes.large) 
                                                .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity),
                                radius: AppTokens.ElevationMapping.level1.radius,
                                x: 0, y: AppTokens.ElevationMapping.level1.dy)

                                                                        VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
                            Text("Deck zones")
                                .font(AppTokens.TypographyTokens.headline)
                                .foregroundColor(AppTokens.Colors.onSurface)
                            ForEach(zones) { zone in
                                ZoneRow(zone: zone)
                            }
                        }
                        .padding(AppTokens.Spacing.lg) 
                        .background(AppTokens.Colors.surface) 
                        .cornerRadius(AppTokens.Shapes.large) 
                                                .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity),
                                radius: AppTokens.ElevationMapping.level1.radius,
                                x: 0, y: AppTokens.ElevationMapping.level1.dy)
                    }
                                        .padding(.horizontal, AppTokens.Spacing.lg)
                    .padding(.vertical, AppTokens.Spacing.sm)
                }

                                                HStack {
                    VStack(alignment: .leading, spacing: AppTokens.Spacing.xs) {
                        Text("Grid draw")
                            .font(AppTokens.TypographyTokens.label)
                            .foregroundColor(AppTokens.Colors.onSurface)
                        Text("18.4 kWh")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.primary)
                    }
                    Spacer()
                    Button {
                                            } label: {
                        Text("Engage eco hold")
                            .font(AppTokens.TypographyTokens.label)
                            .padding(.horizontal, AppTokens.Spacing.md) 
                            .padding(.vertical, AppTokens.Spacing.sm)   
                            .background(AppTokens.Colors.primary) 
                            .foregroundColor(AppTokens.Colors.onPrimary) 
                            .cornerRadius(AppTokens.Shapes.medium) 
                    }
                    .buttonStyle(PlainButtonStyle()) 
                }
                .padding(.horizontal, AppTokens.Spacing.lg) 
                .padding(.vertical, AppTokens.Spacing.sm)   
                .background(AppTokens.Colors.surface) 
                                .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity),
                        radius: AppTokens.ElevationMapping.level2.radius,
                        x: 0, y: AppTokens.ElevationMapping.level2.dy)
            }
        }
                .ignoresSafeArea(.all, edges: .vertical)
    }
}

@main
struct SmartOrbitPanelApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                                .statusBarHidden(true)
        }
    }
}