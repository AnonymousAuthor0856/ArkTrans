import SwiftUI

struct AppTokens {
    struct Colors {
                static let primary = Color(hex: 0xFF007BFF)
        static let secondary = Color(hex: 0xFF6C757D)
        static let tertiary = Color(hex: 0xFF17A2B8)
        static let background = Color(hex: 0xFFF8F9FA)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFE9ECEF)
        static let outline = Color(hex: 0xFFDEE2E6)
        static let success = Color(hex: 0xFF28A745)
        static let warning = Color(hex: 0xFFFFC107)
        static let error = Color(hex: 0xFFDC3545)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFFFFFFFF)
        static let onTertiary = Color(hex: 0xFFFFFFFF)
        static let onBackground = Color(hex: 0xFF212529)
        static let onSurface = Color(hex: 0xFF212529)
    }

    struct TypographyTokens {
                static let display = Font.system(size: 36, weight: .bold)
        static let headline = Font.system(size: 28, weight: .semibold)
        static let title = Font.system(size: 22, weight: .medium)
        static let body = Font.system(size: 16, weight: .regular) 
        static let label = Font.system(size: 14, weight: .medium)
    }

    struct Shapes {
                static let small: CGFloat = 4
        static let medium: CGFloat = 8
        static let large: CGFloat = 12
    }

    struct Spacing {
                static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
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
        static let level1 = ShadowSpec(elevation: 1, radius: 3, dy: 1, opacity: 0.1)
        static let level2 = ShadowSpec(elevation: 3, radius: 6, dy: 2, opacity: 0.1)
        static let level3 = ShadowSpec(elevation: 6, radius: 10, dy: 4, opacity: 0.1)
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct AppTypographyKey: EnvironmentKey {
    static let defaultValue: AppTypography = AppTypography()
}

struct AppTypography {
    let displayMedium = AppTokens.TypographyTokens.display
    let headlineSmall = AppTokens.TypographyTokens.headline
    let titleMedium = AppTokens.TypographyTokens.title
    let bodyMedium = AppTokens.TypographyTokens.body
    let labelMedium = AppTokens.TypographyTokens.label
}

extension EnvironmentValues {
    var appTypography: AppTypography {
        get { self[AppTypographyKey.self] }
        set { self[AppTypographyKey.self] = newValue }
    }
}

struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    }
}

extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        get { self[SafeAreaInsetsKey.self] }
        set { self[SafeAreaInsetsKey.self] = newValue }
    }
}

struct ClipboardItem: Identifiable {
    let id: Int
    let content: String
    let type: String
    let timestamp: String
    let progress: Float
}

struct RootScreen: View {
    @State private var sliderValue: Float = 24.0

        let clipboardItems: [ClipboardItem] = [
        ClipboardItem(id: 1, content: "https://www.example.com/modern-design", type: "Link", timestamp: "5 min ago", progress: 0.2),
        ClipboardItem(id: 2, content: "Final project review notes have been updated.", type: "Text", timestamp: "23 min ago", progress: 0.5),
        ClipboardItem(id: 3, content: "#007BFF", type: "Color", timestamp: "1 hour ago", progress: 0.8),
        ClipboardItem(id: 4, content: "Meeting at 3 PM with the design team.", type: "Text", timestamp: "3 hours ago", progress: 0.9),
        ClipboardItem(id: 5, content: "Shared file: 'Q3_Report.pdf'", type: "File", timestamp: "Yesterday", progress: 1.0)
    ]

    var body: some View {
        GeometryReader { geometry in
                        VStack(spacing: 0) {
                                HStack {
                    Spacer() 
                    Text("Clipboard History")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onBackground)
                    Spacer() 

                    Button(action: {
                                                print("Clear button tapped")
                    }) {
                        Text("Clear")
                            .font(AppTokens.TypographyTokens.label)
                            .foregroundColor(AppTokens.Colors.onSurface)
                            .padding(.vertical, AppTokens.Spacing.sm)
                            .padding(.horizontal, AppTokens.Spacing.md)
                            .background(AppTokens.Colors.surfaceVariant)
                            .cornerRadius(AppTokens.Shapes.medium)
                    }
                    .padding(.trailing, AppTokens.Spacing.md) 
                }
                .padding(.top, geometry.safeAreaInsets.top) 
                .frame(height: 56 + geometry.safeAreaInsets.top) 
                .background(AppTokens.Colors.surface)
                                .shadow(color: .black.opacity(0.05), radius: 0.5, x: 0, y: 0.5)

                                ScrollView {
                    LazyVStack(spacing: AppTokens.Spacing.md) { 
                        ForEach(clipboardItems) { item in
                            ClipboardCard(item: item)
                        }
                    }
                    .padding(.horizontal, AppTokens.Spacing.lg) 
                    .padding(.vertical, AppTokens.Spacing.md)   
                }
                .background(AppTokens.Colors.background) 

                                SettingsPane(sliderValue: $sliderValue)
                    .background(AppTokens.Colors.surface)
                                        .shadow(color: .black.opacity(AppTokens.ElevationMapping.level2.opacity),
                            radius: AppTokens.ElevationMapping.level2.radius,
                            x: 0,
                            y: -AppTokens.ElevationMapping.level2.dy) 
            }
        }
                .ignoresSafeArea(.all, edges: .top)
        .background(AppTokens.Colors.background) 
        .statusBarHidden(true) 
    }
}

struct ClipboardCard: View {
    let item: ClipboardItem
        @Environment(\.appTypography) var typography

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: AppTokens.Spacing.sm) {
                                RoundedRectangle(cornerRadius: AppTokens.Shapes.small)
                    .fill(AppTokens.Colors.primary)
                    .frame(width: 24, height: 24)

                Text(item.type)
                    .font(typography.labelMedium)
                    .foregroundColor(AppTokens.Colors.primary)
                    .fontWeight(.bold)

                Spacer() 

                Text(item.timestamp)
                    .font(typography.labelMedium)
                    .foregroundColor(AppTokens.Colors.secondary)
            }
            .padding(.bottom, AppTokens.Spacing.sm) 

            Text(item.content)
                .font(typography.bodyMedium)
                .foregroundColor(AppTokens.Colors.onSurface)
                .lineLimit(2) 
                .truncationMode(.tail) 
                .padding(.bottom, AppTokens.Spacing.md) 

                        ProgressView(value: item.progress)
                .progressViewStyle(CustomLinearProgressViewStyle(tint: AppTokens.Colors.tertiary, track: AppTokens.Colors.surfaceVariant))
                .frame(height: 4) 
        }
        .padding(AppTokens.Spacing.md) 
        .background(AppTokens.Colors.surface) 
        .cornerRadius(AppTokens.Shapes.large) 
        .overlay(
                        RoundedRectangle(cornerRadius: AppTokens.Shapes.large)
                .stroke(AppTokens.Colors.surfaceVariant, lineWidth: 1)
        )
                .shadow(color: .black.opacity(AppTokens.ElevationMapping.level1.opacity),
                radius: AppTokens.ElevationMapping.level1.radius,
                x: 0,
                y: AppTokens.ElevationMapping.level1.dy)
    }
}

struct CustomLinearProgressViewStyle: ProgressViewStyle {
    var tint: Color 
    var track: Color 

    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: AppTokens.Shapes.small)
                    .fill(track)
                    .frame(height: 4)
                    .frame(width: geometry.size.width) 

                                RoundedRectangle(cornerRadius: AppTokens.Shapes.small)
                    .fill(tint)
                    .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * geometry.size.width, height: 4)
            }
        }
        .frame(height: 4) 
    }
}

struct SettingsPane: View {
    @Binding var sliderValue: Float 
    @Environment(\.appTypography) var typography

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("History Limit (Hours)")
                    .font(typography.labelMedium)
                    .foregroundColor(AppTokens.Colors.onSurface)
                Spacer()
                Text(String(format: "%.0f", sliderValue)) 
                    .font(typography.bodyMedium)
                    .fontWeight(.semibold)
                    .foregroundColor(AppTokens.Colors.onSurface)
            }
            .padding(.bottom, AppTokens.Spacing.sm) 

            Slider(value: $sliderValue, in: 1...72, step: 1) 
                .tint(AppTokens.Colors.primary) 
                .accentColor(AppTokens.Colors.primary) 
        }
        .padding(AppTokens.Spacing.lg) 
        .frame(maxWidth: .infinity) 
            }
}

@main
struct ClipboardHistoryApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                                .environment(\.appTypography, AppTypography())
        }
    }
}

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
            .environment(\.appTypography, AppTypography())
    }
}