import SwiftUI

struct AppTokens {
    struct Colors {
                static let primary = Color(red: 37/255, green: 99/255, blue: 235/255)
        static let secondary = Color(red: 56/255, green: 189/255, blue: 248/255)
        static let tertiary = Color(red: 96/255, green: 165/255, blue: 250/255)
        static let background = Color(red: 248/255, green: 250/255, blue: 252/255)
        static let surface = Color(red: 255/255, green: 255/255, blue: 255/255)
        static let surfaceVariant = Color(red: 226/255, green: 232/255, blue: 240/255)
        static let outline = Color(red: 203/255, green: 213/255, blue: 225/255)
        static let onPrimary = Color(red: 255/255, green: 255/255, blue: 255/255)
        static let onSecondary = Color(red: 15/255, green: 23/255, blue: 42/255)
        static let onTertiary = Color(red: 255/255, green: 255/255, blue: 255/255)
        static let onBackground = Color(red: 15/255, green: 23/255, blue: 42/255)
        static let onSurface = Color(red: 30/255, green: 41/255, blue: 59/255)
    }

    struct TypographyTokens {
                static let display = Font.system(size: 24, weight: .bold)
        static let headline = Font.system(size: 18, weight: .semibold)
        static let title = Font.system(size: 14, weight: .medium)
        static let body = Font.system(size: 12, weight: .regular) 
    }

    struct Shapes {
                static let small = 6.0
        static let medium = 10.0
        static let large = 14.0
    }

    struct Spacing {
                static let sm = 6.0
        static let md = 10.0
        static let lg = 14.0
        static let xl = 20.0
                static let buttonContentHorizontal = 16.0
        static let buttonContentVertical = 8.0
    }
}

struct CustomUnitButton: ButtonStyle {
    var isActive: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTokens.TypographyTokens.title) 
            .padding(.horizontal, AppTokens.Spacing.buttonContentHorizontal) 
            .padding(.vertical, AppTokens.Spacing.buttonContentVertical) 
            .background(
                isActive ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant
            )
            .foregroundColor(
                isActive ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface
            )
            .cornerRadius(AppTokens.Shapes.small) 
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) 
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed) 
    }
}

struct MarkerBox: View {
    let unit: String
    let value: String
    let active: Bool

    var body: some View {
        VStack(alignment: .leading) { 
            Text(unit)
                .font(AppTokens.TypographyTokens.headline)
                .foregroundColor(AppTokens.Colors.onSurface)
            Text(value)
                .font(AppTokens.TypographyTokens.body)
                .foregroundColor(AppTokens.Colors.onSurface)
        }
        .padding(AppTokens.Spacing.md) 
        .frame(maxWidth: .infinity, alignment: .leading) 
        .frame(height: 80) 
        .background(
            active ? AppTokens.Colors.secondary.opacity(0.3) : AppTokens.Colors.surface
        )
        .cornerRadius(AppTokens.Shapes.medium) 
        .overlay(
                        RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                .stroke(AppTokens.Colors.outline, lineWidth: 1)
        )
    }
}

struct MapArea: View {
    let selected: String

    var body: some View {
        VStack(spacing: AppTokens.Spacing.md) { 
            Text("Unit Map Visualization")
                .font(AppTokens.TypographyTokens.headline)
                .foregroundColor(AppTokens.Colors.onSurface)
            Text("Active Unit: \(selected)")
                .font(AppTokens.TypographyTokens.body)
                .foregroundColor(AppTokens.Colors.onSurface)
        }
        .frame(maxWidth: .infinity, maxHeight: 240) 
        .background(AppTokens.Colors.surfaceVariant) 
        .cornerRadius(AppTokens.Shapes.large) 
        .overlay(
                        RoundedRectangle(cornerRadius: AppTokens.Shapes.large)
                .stroke(AppTokens.Colors.outline, lineWidth: 1)
        )
        .padding(AppTokens.Spacing.lg) 
            }
}

struct RootScreen: View {
    let markers = ["Length", "Weight", "Temperature", "Speed"]
    @State private var active: String 

    init() {
        _active = State(initialValue: markers.first ?? "")
    }

    var body: some View {
        VStack(spacing: AppTokens.Spacing.lg) { 
            Text("Unit Converter")
                .font(AppTokens.TypographyTokens.display)
                .foregroundColor(AppTokens.Colors.onBackground)
            
            MapArea(selected: active)
            
            ForEach(markers, id: \.self) { marker in
                MarkerBox(unit: marker, value: "Tap to convert", active: self.active == marker)
            }
            
                                                                                    Spacer().frame(height: AppTokens.Spacing.md)
            
            HStack(spacing: AppTokens.Spacing.md) { 
                ForEach(markers, id: \.self) { marker in
                    Button(action: {
                        self.active = marker
                    }) {
                        Text(marker)
                    }
                                        .buttonStyle(CustomUnitButton(isActive: self.active == marker))
                }
            }
        }
        .padding(AppTokens.Spacing.lg) 
        .frame(maxWidth: .infinity, maxHeight: .infinity) 
        .background(
                        LinearGradient(
                gradient: Gradient(colors: [
                    AppTokens.Colors.secondary.opacity(0.15),
                    AppTokens.Colors.primary.opacity(0.15)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .ignoresSafeArea(.all, edges: .all) 
        .statusBarHidden(true) 
    }
}

@main
struct UnitConverterApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}
