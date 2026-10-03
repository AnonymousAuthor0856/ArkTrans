import SwiftUI
import CoreGraphics

struct AppTokens {
    struct Colors {
                static let primary = Color(hex: 0xFF8B5CF6)
        static let secondary = Color(hex: 0xFFD946EF)
        static let tertiary = Color(hex: 0xFF3B82F6)
        static let background = Color(hex: 0xFFF9F5FF)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFF1E9FE)
        static let outline = Color(hex: 0xFFE3D7FE)
        static let success = Color(hex: 0xFF22C55E)
        static let warning = Color(hex: 0xFFFACC15)
        static let error = Color(hex: 0xFFEF4444)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFFFFFFFF)
        static let onTertiary = Color(hex: 0xFFFFFFFF)
        static let onBackground = Color(hex: 0xFF1E1E1E)
        static let onSurface = Color(hex: 0xFF1E1E1E)
    }

    struct TypographyTokens {
                static let display = Font.system(size: 48, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) 
        static let label = Font.system(size: 42, weight: .medium)
    }

    struct Shapes {
                static let small = RoundedRectangle(cornerRadius: 8)
        static let medium = RoundedRectangle(cornerRadius: 14)
        static let large = RoundedRectangle(cornerRadius: 22)
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
        let dy: CGFloat        
        let opacity: Double    
    }

    struct ElevationMapping {
                                static let level1 = ShadowSpec(elevation: 4, dy: 2, opacity: 0.14)
        static let level2 = ShadowSpec(elevation: 8, dy: 6, opacity: 0.18)
    }
}

extension Color {
            init(hex: UInt) {
        self.init(
            red: Double((hex & 0xFF0000) >> 16) / 255.0,
            green: Double((hex & 0x00FF00) >> 8) / 255.0,
            blue: Double(hex & 0x0000FF) / 255.0
        )
    }
}

struct RootScreen: View {
        @State private var fontSize: CGFloat = 23.0
    @State private var syncProgress: CGFloat = 0.3

    var body: some View {
                        NavigationView {
                        VStack(spacing: AppTokens.Spacing.xl) {
                                Text("Sample Subtitle Line")
                    .font(.system(size: fontSize)) 
                    .foregroundColor(AppTokens.Colors.onSurface)
                    .frame(maxWidth: .infinity, maxHeight: .infinity) 
                    .background(AppTokens.Colors.surface)
                    .clipShape(AppTokens.Shapes.large) 
                    .shadow(
                        color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity),
                        radius: AppTokens.ElevationMapping.level2.elevation, 
                        x: 0,
                        y: AppTokens.ElevationMapping.level2.dy 
                    )
                    .frame(height: 200) 
                    .frame(maxWidth: .infinity) 

                Text("Font Size: \(Int(fontSize))sp")
                    .font(AppTokens.TypographyTokens.body)
                    .foregroundColor(AppTokens.Colors.onSurface)

                                Slider(value: $fontSize, in: 16...48) {
                                    }
                .tint(AppTokens.Colors.primary) 
                .frame(maxWidth: .infinity)
                                                                
                Text("Sync Progress")
                    .font(AppTokens.TypographyTokens.body)
                    .foregroundColor(AppTokens.Colors.onSurface)

                                ProgressView(value: syncProgress)
                    .progressViewStyle(LinearProgressViewStyle()) 
                    .tint(AppTokens.Colors.primary) 
                    .background(AppTokens.Colors.surfaceVariant) 
                    .frame(height: 6) 
                    .frame(maxWidth: .infinity) 

                                HStack(spacing: AppTokens.Spacing.md) {
                                        Button(action: {
                        syncProgress = min(syncProgress + 0.1,1.0) 
                    }) {
                        Text("Sync +")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .frame(maxWidth: .infinity, maxHeight: .infinity) 
                    }
                    .frame(height: 48) 
                    .background(AppTokens.Colors.primary) 
                    .clipShape(AppTokens.Shapes.medium) 

                                        Button(action: {
                        syncProgress = min(syncProgress - 0.1,0.0) 
                    }) {
                        Text("Sync -")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.onSecondary)
                            .frame(maxWidth: .infinity, maxHeight: .infinity) 
                    }
                    .frame(height: 48) 
                    .background(AppTokens.Colors.secondary) 
                    .clipShape(AppTokens.Shapes.medium) 
                }
                .frame(maxWidth: .infinity) 
            }
            .padding(AppTokens.Spacing.lg) 
            .frame(maxWidth: .infinity, maxHeight: .infinity) 
            .background(
                                LinearGradient(
                    colors: [
                        AppTokens.Colors.surfaceVariant,
                        AppTokens.Colors.background,
                        AppTokens.Colors.surface
                    ],
                    startPoint: .top, 
                    endPoint: .bottom 
                )
            )
                        .navigationTitle("Subtitle Editor") 
            .navigationBarTitleDisplayMode(.inline) 
            .toolbarBackground(AppTokens.Colors.background, for: .navigationBar) 
            .toolbarBackground(.visible, for: .navigationBar) 
            .padding(.bottom, 50)
        }
        .navigationViewStyle(.stack) 
        .ignoresSafeArea(.all) 
        .statusBarHidden(true) 

    }
}

@main
struct SubtitleEditorApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen() 
        }
    }
}
