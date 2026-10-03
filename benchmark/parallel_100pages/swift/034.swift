
import SwiftUI

struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0x00FF66)
        static let secondary = Color(hex: 0xCCCCCC)
        static let tertiary = Color(hex: 0x999999)
        static let background = Color(hex: 0x000000)
        static let surface = Color(hex: 0x0A0A0A)
        static let surfaceVariant = Color(hex: 0x111111)
        static let outline = Color(hex: 0x1F1F1F)
        static let success = Color(hex: 0x16A34A)
        static let warning = Color(hex: 0xF59E0B)
        static let error = Color(hex: 0xFF4444)
        static let onPrimary = Color(hex: 0x000000)
        static let onSecondary = Color(hex: 0xFFFFFFFF)
        static let onTertiary = Color(hex: 0xFFFFFFFF)
        static let onBackground = Color(hex: 0xE0E0E0)
        static let onSurface = Color(hex: 0xE0E0E0)
    }

    struct TypographyTokens {
        static let display = Font.system(size: 28, weight: .bold)
        static let headline = Font.system(size: 20, weight: .medium)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 13, weight: .regular) 
        static let label = Font.system(size: 11, weight: .medium)
    }

    struct Shapes {
        static let small: CGFloat = 6
        static let medium: CGFloat = 10
        static let large: CGFloat = 14
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
                                let radius: CGFloat 
        let y: CGFloat      
        let opacity: Double
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(radius: 0, y: 0, opacity: 0)
                static let level2 = ShadowSpec(radius: 4, y: 2, opacity: 0.12)
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }
}

struct MapMarker: Identifiable {
    let id = UUID() 
    let name: String
    let distance: String
}

struct RootScreen: View {
    @State private var query: String = ""
    @FocusState private var isSearchFieldFocused: Bool 

        let markers = [
        MapMarker(name: "Central Plaza", distance: "1.2 km"),
        MapMarker(name: "Museum District", distance: "3.4 km"),
        MapMarker(name: "Tech Park", distance: "5.6 km"),
        MapMarker(name: "Old Town Gate", distance: "7.8 km")
    ]

    var body: some View {
        ZStack { 
            AppTokens.Colors.background
                .ignoresSafeArea() 

            VStack(spacing: 0) { 
                                Text("Explore Map")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.primary)
                    .frame(maxWidth: .infinity) 
                    .padding(.vertical, AppTokens.Spacing.lg) 
                    .background(AppTokens.Colors.background)

                                VStack(spacing: AppTokens.Spacing.lg) { 
                                        TextField("Search destination", text: $query)
                        .focused($isSearchFieldFocused) 
                        .font(AppTokens.TypographyTokens.body) 
                        .foregroundColor(AppTokens.Colors.onSurface) 
                        .accentColor(AppTokens.Colors.primary) 
                        .padding(AppTokens.Spacing.md) 
                        .background(AppTokens.Colors.surfaceVariant) 
                        .cornerRadius(AppTokens.Shapes.medium) 
                        .overlay( 
                            RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                                .stroke(isSearchFieldFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline, lineWidth: 1)
                        )
                        .frame(maxWidth: .infinity) 

                                        VStack(spacing: AppTokens.Spacing.md) { 
                        ForEach(markers) { marker in
                            CardView(marker: marker)
                        }
                    }
                    .frame(maxWidth: .infinity) 

                    Spacer() 

                                        Button(action: {
                                                print("Refresh Map Tapped")
                    }) {
                        Text("Refresh Map")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .frame(maxWidth: .infinity) 
                            .frame(height: 48) 
                            .background(AppTokens.Colors.primary)
                            .cornerRadius(AppTokens.Shapes.large) 
                    }
                }
                .padding(AppTokens.Spacing.lg) 
            }
        }
        .statusBarHidden(true) 
    }
}

struct CardView: View {
    let marker: MapMarker

    var body: some View {
        HStack(alignment: .center, spacing: 0) { 
            VStack(alignment: .leading, spacing: 0) { 
                Text(marker.name)
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.onSurface)
                Text(marker.distance)
                    .font(AppTokens.TypographyTokens.body)
                    .foregroundColor(AppTokens.Colors.secondary)
            }
            Spacer() 
            Button(action: {
                                print("View \(marker.name) Tapped")
            }) {
                Text("View")
                    .font(AppTokens.TypographyTokens.label)
                    .foregroundColor(AppTokens.Colors.onPrimary)
                                        .padding(.horizontal, AppTokens.Spacing.md)
                    .padding(.vertical, AppTokens.Spacing.xs)
                    .background(AppTokens.Colors.primary)
                    .cornerRadius(AppTokens.Shapes.small)
            }
        }
        .padding(AppTokens.Spacing.md) 
        .background(AppTokens.Colors.surface) 
        .cornerRadius(AppTokens.Shapes.medium) 
        .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity), 
                radius: AppTokens.ElevationMapping.level2.radius, 
                y: AppTokens.ElevationMapping.level2.y) 
        .frame(maxWidth: .infinity) 
    }
}

@main
struct SingleFileUIApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}
