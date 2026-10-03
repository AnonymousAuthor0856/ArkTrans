import SwiftUI


struct AppTokens {
    struct Colors {
        static let primary = Color(red: 30/255, green: 41/255, blue: 59/255)
        static let secondary = Color(red: 14/255, green: 165/255, blue: 233/255)
        static let tertiary = Color(red: 250/255, green: 204/255, blue: 21/255)
        static let background = Color(red: 30/255, green: 41/255, blue: 59/255)
        static let surface = Color(red: 30/255, green: 41/255, blue: 59/255)
        static let surfaceVariant = Color(red: 51/255, green: 65/255, blue: 85/255)
        static let outline = Color(red: 71/255, green: 85/255, blue: 105/255)
        static let success = Color(red: 34/255, green: 197/255, blue: 94/255)
        static let warning = Color(red: 245/255, green: 158/255, blue: 11/255)
        static let error = Color(red: 239/255, green: 68/255, blue: 68/255)
        static let onPrimary = Color(red: 255/255, green: 255/255, blue: 255/255)
        static let onSecondary = Color(red: 255/255, green: 255/255, blue: 255/255)
        static let onTertiary = Color(red: 11/255, green: 18/255, blue: 32/255)
        static let onBackground = Color(red: 226/255, green: 232/255, blue: 240/255)
        static let onSurface = Color(red: 226/255, green: 232/255, blue: 240/255)
    }

    struct TypographyTokens {
                        static let display = Font.system(size: 26, weight: .bold)
        static let headline = Font.system(size: 20, weight: .semibold)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
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
        static let xxl: CGFloat = 36
    }
    
                            struct ShadowSpec {
        let radius: CGFloat 
        let y: CGFloat      
        let opacity: Double 
        
        static let level1 = ShadowSpec(radius: 2, y: 1, opacity: 0.1)
        static let level2 = ShadowSpec(radius: 4, y: 2, opacity: 0.14)
        static let level3 = ShadowSpec(radius: 6, y: 3, opacity: 0.16)
    }
}


struct CodeMarker: Identifiable {
    let id: Int
    let name: String
    let desc: String
}


struct CustomTopAppBar: View {
    var title: String
    
    var body: some View {
                HStack {
            Spacer()
            Text(title)
                .font(AppTokens.TypographyTokens.display)
                .foregroundColor(AppTokens.Colors.onBackground)
            Spacer()
        }
        .padding(.vertical, AppTokens.Spacing.md) 
        .background(AppTokens.Colors.background) 
    }
}

struct CodeMarkerCard: View {
    let marker: CodeMarker
    
    var body: some View {
        HStack(spacing: AppTokens.Spacing.md) { 
            ZStack { 
                RoundedRectangle(cornerRadius: AppTokens.Shapes.small)
                    .fill(AppTokens.Colors.secondary)
                    .frame(width: 32, height: 32) 
                Text(String(marker.id))
                    .foregroundColor(AppTokens.Colors.onSecondary)
                    .font(AppTokens.TypographyTokens.label)
            }
            VStack(alignment: .leading) { 
                Text(marker.name)
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.onSurface)
                Text(marker.desc)
                    .font(AppTokens.TypographyTokens.body)
                    .foregroundColor(AppTokens.Colors.onSurface)
            }
        }
        .padding(AppTokens.Spacing.md) 
        .frame(maxWidth: .infinity, alignment: .leading) 
        .background(AppTokens.Colors.surfaceVariant) 
        .cornerRadius(AppTokens.Shapes.medium) 
                .shadow(color: Color.black.opacity(AppTokens.ShadowSpec.level1.opacity),
                radius: AppTokens.ShadowSpec.level1.radius,
                x: 0,
                y: AppTokens.ShadowSpec.level1.y)
    }
}


struct RootScreen: View {
    let markers = [
        CodeMarker(id: 1, name: "Main.kt", desc: "Entry point for Compose app"),
        CodeMarker(id: 2, name: "Utils.kt", desc: "Helper functions"),
        CodeMarker(id: 3, name: "Theme.kt", desc: "Color & Typography setup"),
        CodeMarker(id: 4, name: "Data.kt", desc: "Repository and model classes")
    ]
    
    var body: some View {
                        GeometryReader { geometry in
            VStack(spacing: 0) { 
                CustomTopAppBar(title: "CodeIDE Terminal")
                
                ScrollView(.vertical, showsIndicators: false) { 
                    VStack(alignment: .leading, spacing: AppTokens.Spacing.lg) { 
                        Text("Project Files")
                            .font(AppTokens.TypographyTokens.headline)
                            .foregroundColor(AppTokens.Colors.onBackground)
                        
                        LazyVStack(spacing: AppTokens.Spacing.sm) { 
                            ForEach(markers) { marker in
                                CodeMarkerCard(marker: marker)
                            }
                        }
                        .padding(.bottom, AppTokens.Spacing.xl) 
                        
                        Text("Live Terminal")
                            .font(AppTokens.TypographyTokens.headline)
                            .foregroundColor(AppTokens.Colors.onBackground)
                        
                        ZStack(alignment: .topLeading) { 
                            RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                                .fill(AppTokens.Colors.surfaceVariant)
                                .frame(maxWidth: .infinity) 
                                .frame(height: 240) 
                                .overlay(
                                                                        RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                                        .stroke(AppTokens.Colors.outline, lineWidth: 1)
                                )
                            Text("> println(\"Hello, Kotlin!\")")
                                .font(AppTokens.TypographyTokens.body)
                                .foregroundColor(AppTokens.Colors.onSurface)
                                .padding(AppTokens.Spacing.md) 
                        }
                        
                        Button(action: {}) {
                            Text("Run Code")
                                .font(AppTokens.TypographyTokens.title)
                                .foregroundColor(AppTokens.Colors.onSecondary)
                                .frame(maxWidth: .infinity) 
                        }
                                                .frame(width: geometry.size.width * 0.6, height: 48) 
                        .background(AppTokens.Colors.secondary) 
                        .cornerRadius(AppTokens.Shapes.large) 
                                                .shadow(color: Color.black.opacity(AppTokens.ShadowSpec.level1.opacity),
                                radius: AppTokens.ShadowSpec.level1.radius,
                                x: 0,
                                y: AppTokens.ShadowSpec.level1.y)
                        .frame(maxWidth: .infinity) 
                    }
                    .padding(AppTokens.Spacing.lg) 
                    .frame(maxWidth: .infinity) 
                }
                                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            AppTokens.Colors.primary.opacity(0.8),
                            AppTokens.Colors.surface.opacity(0.9)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            .background(AppTokens.Colors.background) 
                        .ignoresSafeArea(.all, edges: .all)
        }
    }
}


@main
struct SingleFileUIApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                                                .statusBarHidden(true)
        }
    }
}


struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}