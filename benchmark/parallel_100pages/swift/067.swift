import SwiftUI

struct AppTokens {
        struct Colors {
        static let primary = Color(red: 0xFF / 255.0, green: 0x70 / 255.0, blue: 0x43 / 255.0)
        static let secondary = Color(red: 0xFF / 255.0, green: 0xB7 / 255.0, blue: 0x4D / 255.0)
        static let tertiary = Color(red: 0xFF / 255.0, green: 0xD5 / 255.0, blue: 0x4F / 255.0)
        static let background = Color(red: 0xFF / 255.0, green: 0xF8 / 255.0, blue: 0xE1 / 255.0)
        static let surface = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let surfaceVariant = Color(red: 0xFF / 255.0, green: 0xEC / 255.0, blue: 0xB3 / 255.0)
        static let outline = Color(red: 0xE0 / 255.0, green: 0xC0 / 255.0, blue: 0x97 / 255.0)
        static let success = Color(red: 0x43 / 255.0, green: 0xA0 / 255.0, blue: 0x47 / 255.0)
        static let warning = Color(red: 0xFB / 255.0, green: 0xC0 / 255.0, blue: 0x2D / 255.0)
        static let error = Color(red: 0xE5 / 255.0, green: 0x39 / 255.0, blue: 0x35 / 255.0)
        static let onPrimary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onSecondary = Color(red: 0x3E / 255.0, green: 0x27 / 255.0, blue: 0x23 / 255.0)
        static let onTertiary = Color(red: 0x3E / 255.0, green: 0x27 / 255.0, blue: 0x23 / 255.0)
        static let onBackground = Color(red: 0x3E / 255.0, green: 0x27 / 255.0, blue: 0x23 / 255.0)
        static let onSurface = Color(red: 0x3E / 255.0, green: 0x27 / 255.0, blue: 0x23 / 255.0)
    }

        struct TypographyTokens {
        static let display = Font.system(size: 28, weight: .bold)
        static let headline = Font.system(size: 20, weight: .semibold)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

        struct Shapes {
        static let small = RoundedRectangle(cornerRadius: 8)
        static let medium = RoundedRectangle(cornerRadius: 12)
        static let large = RoundedRectangle(cornerRadius: 16)
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
        static let level1 = ShadowSpec(elevation: 1, radius: 4, dy: 2, opacity: 0.1)
        static let level2 = ShadowSpec(elevation: 3, radius: 8, dy: 4, opacity: 0.14)
        static let level3 = ShadowSpec(elevation: 6, radius: 12, dy: 6, opacity: 0.16)
    }
}


struct AppColorScheme {
    let primary: Color
    let onPrimary: Color
    let secondary: Color
    let onSecondary: Color
    let background: Color
    let onBackground: Color
    let surface: Color
    let onSurface: Color
    let surfaceVariant: Color
    let outline: Color
    let error: Color
}

private struct AppColorSchemeKey: EnvironmentKey {
    static let defaultValue = AppColorScheme(
        primary: AppTokens.Colors.primary,
        onPrimary: AppTokens.Colors.onPrimary,
        secondary: AppTokens.Colors.secondary,
        onSecondary: AppTokens.Colors.onSecondary,
        background: AppTokens.Colors.background,
        onBackground: AppTokens.Colors.onBackground,
        surface: AppTokens.Colors.surface,
        onSurface: AppTokens.Colors.onSurface,
        surfaceVariant: AppTokens.Colors.surfaceVariant,
        outline: AppTokens.Colors.outline,
        error: AppTokens.Colors.error
    )
}

extension EnvironmentValues {
    var appColorScheme: AppColorScheme {
        get { self[AppColorSchemeKey.self] }
        set { self[AppColorSchemeKey.self] = newValue }
    }
}

struct AppTypography {
    let displayLarge: Font
    let headlineMedium: Font
    let titleMedium: Font
    let bodyMedium: Font
    let labelMedium: Font
}

private struct AppTypographyKey: EnvironmentKey {
    static let defaultValue = AppTypography(
        displayLarge: AppTokens.TypographyTokens.display,
        headlineMedium: AppTokens.TypographyTokens.headline,
        titleMedium: AppTokens.TypographyTokens.title,
        bodyMedium: AppTokens.TypographyTokens.body,
        labelMedium: AppTokens.TypographyTokens.label
    )
}

extension EnvironmentValues {
    var appTypography: AppTypography {
        get { self[AppTypographyKey.self] }
        set { self[AppTypographyKey.self] = newValue }
    }
}

struct AppThemeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .environment(\.appColorScheme, AppColorSchemeKey.defaultValue)
            .environment(\.appTypography, AppTypographyKey.defaultValue)
                            }
}

extension View {
        func appTheme() -> some View {
        self.modifier(AppThemeModifier())
    }
}

struct Client: Identifiable {
    let id: Int
    let name: String
    let region: String
    let level: String
    let x: CGFloat 
    let y: CGFloat 
}


struct MapMarker: View {
    let label: String
    let level: String
    let selected: Bool
    let onClick: () -> Void
    let xOffset: CGFloat 
    let yOffset: CGFloat 

    @Environment(\.appColorScheme) private var colorScheme
    @Environment(\.appTypography) private var typography

    var body: some View {
                        ZStack(alignment: .topLeading) {
            let markerColor = {
                switch level {
                case "A": return AppTokens.Colors.primary
                case "B": return AppTokens.Colors.secondary
                default: return AppTokens.Colors.tertiary
                }
            }()
            
                        Circle()
                .fill(markerColor)
                .frame(width: selected ? 28 : 22, height: selected ? 28 : 22)
                .overlay(
                    Circle()
                        .stroke(selected ? AppTokens.Colors.onPrimary : AppTokens.Colors.surface, lineWidth: 2)
                )
                .offset(x: xOffset, y: yOffset) 

                        Button(action: onClick) {
                Text(label)
                    .font(typography.labelMedium)
                    .foregroundColor(colorScheme.onSurface)
                    .padding(.horizontal, AppTokens.Spacing.sm)
                    .padding(.vertical, AppTokens.Spacing.xs)
                    .background(colorScheme.surfaceVariant)
                    .clipShape(AppTokens.Shapes.small)
                    .overlay(
                        AppTokens.Shapes.small
                            .stroke(colorScheme.outline, lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity),
                            radius: AppTokens.ElevationMapping.level1.radius, 
                            x: 0,
                            y: AppTokens.ElevationMapping.level1.dy) 
            }
            .buttonStyle(PlainButtonStyle()) 
                        .offset(x: xOffset + 20, y: yOffset - 4) 
        }
    }
}

struct MapGridOverlayCorrected: View {
    @Environment(\.appColorScheme) private var colorScheme

    var body: some View {
        GeometryReader { geometry in
                        let availableWidth = geometry.size.width - 2 * AppTokens.Spacing.lg
            let availableHeight = geometry.size.height - 2 * AppTokens.Spacing.lg

            ZStack {
                                ForEach(0..<6) { i in
                    Rectangle()
                        .fill(colorScheme.surfaceVariant)
                        .frame(height: 1)
                                                                                                .offset(y: AppTokens.Spacing.lg + (availableHeight / 7.0) * CGFloat(i + 1))
                }

                                ForEach(0..<6) { i in
                    Rectangle()
                        .fill(colorScheme.surfaceVariant)
                        .frame(width: 1)
                                                                                                .offset(x: AppTokens.Spacing.lg + (availableWidth / 7.0) * CGFloat(i + 1))
                }
            }
        }
    }
}

struct RootScreen: View {
    @State private var selectedId: Int? = nil 
    @Environment(\.appColorScheme) private var colorScheme
    @Environment(\.appTypography) private var typography

        let clients = [
        Client(id: 1, name: "Sunrise Tech", region: "Shanghai", level: "A", x: 0.2, y: 0.3),
        Client(id: 2, name: "Delta Logistics", region: "Beijing", level: "B", x: 0.5, y: 0.45),
        Client(id: 3, name: "Oceanic Foods", region: "Guangzhou", level: "A", x: 0.72, y: 0.6),
        Client(id: 4, name: "Horizon Ltd.", region: "Chengdu", level: "C", x: 0.33, y: 0.75)
    ]

    var body: some View {
                VStack(spacing: 0) {
                        ZStack {
                Text("Client Detail")
                    .font(typography.displayLarge)
                    .foregroundColor(colorScheme.onSurface)
                    .padding(.vertical, AppTokens.Spacing.md) 
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56) 
            .background(colorScheme.background) 
            
                        ScrollView {
                VStack(spacing: AppTokens.Spacing.md) { 
                                        Text("Regional Client Map")
                        .font(typography.headlineMedium)
                        .foregroundColor(AppTokens.Colors.onPrimary)
                        .frame(maxWidth: .infinity, minHeight: 200) 
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [AppTokens.Colors.secondary, AppTokens.Colors.primary]),
                                startPoint: .leading, 
                                endPoint: .trailing
                            )
                        )
                        .clipShape(AppTokens.Shapes.large) 
                        .padding(.horizontal, AppTokens.Spacing.lg) 
                        .padding(.top, AppTokens.Spacing.md) 

                                        GeometryReader { geometry in
                        ZStack(alignment: .topLeading) { 
                            AppTokens.Shapes.large 
                                .fill(colorScheme.surface)
                                .overlay(
                                    AppTokens.Shapes.large 
                                        .stroke(colorScheme.outline, lineWidth: 1)
                                )
                            
                            MapGridOverlayCorrected() 

                                                        ForEach(clients) { client in
                                MapMarker(
                                    label: client.name,
                                    level: client.level,
                                    selected: selectedId == client.id,
                                    onClick: {
                                        selectedId = (selectedId == client.id) ? nil : client.id
                                    },
                                                                        xOffset: geometry.size.width * client.x,
                                    yOffset: geometry.size.height * client.y
                                )
                            }
                        }
                                                .frame(maxWidth: .infinity)
                        .aspectRatio(0.9, contentMode: .fit) 
                        .frame(minHeight: 360) 
                    }
                                        .frame(maxWidth: .infinity)
                    .aspectRatio(0.9, contentMode: .fit)
                    .frame(minHeight: 360)
                    .padding(.horizontal, AppTokens.Spacing.lg) 

                                        VStack(spacing: AppTokens.Spacing.md) { 
                        ForEach(clients) { client in
                                                        ZStack {
                                AppTokens.Shapes.medium 
                                    .fill(colorScheme.surface)
                                    .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity),
                                            radius: AppTokens.ElevationMapping.level1.radius,
                                            x: 0,
                                            y: AppTokens.ElevationMapping.level1.dy)
                                    .overlay(
                                        AppTokens.Shapes.medium 
                                            .stroke(colorScheme.outline, lineWidth: 1)
                                    )
                                
                                HStack { 
                                    VStack(alignment: .leading, spacing: AppTokens.Spacing.xs) { 
                                        Text(client.name)
                                            .font(typography.titleMedium)
                                            .foregroundColor(colorScheme.onSurface)
                                        Text(client.region)
                                            .font(typography.bodyMedium)
                                            .foregroundColor(colorScheme.onSurface)
                                    }
                                    Spacer() 
                                    Text("Level \(client.level)")
                                        .font(typography.labelMedium)
                                        .foregroundColor(colorScheme.primary)
                                }
                                .padding(AppTokens.Spacing.lg) 
                            }
                            .frame(maxWidth: .infinity) 
                        }
                    }
                    .padding(.horizontal, AppTokens.Spacing.lg) 
                    .padding(.bottom, AppTokens.Spacing.xxl) 
                }
            }
            .background(colorScheme.background) 
        }
        .ignoresSafeArea(.all) 
        .statusBarHidden(true) 
        .background(colorScheme.background) 
    }
}

@main
struct ClientDetailApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                .appTheme() 
        }
    }
}