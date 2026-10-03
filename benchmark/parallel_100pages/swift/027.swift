import SwiftUI


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

struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFFA0C4FF)
        static let secondary = Color(hex: 0xFFB7E4C7)
        static let tertiary = Color(hex: 0xFFFFDDC1)
        static let background = Color(hex: 0xFFF8F7FF)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFF0F0F5)
        static let outline = Color(hex: 0xFFD9D9E3)
        static let success = Color(hex: 0xFFB4E4C7)
        static let warning = Color(hex: 0xFFFFDDC1)
        static let error = Color(hex: 0xFFFFB4AB)
        static let onPrimary = Color(hex: 0xFF001D3D)
        static let onSecondary = Color(hex: 0xFF003720)
        static let onTertiary = Color(hex: 0xFF3E2800)
        static let onBackground = Color(hex: 0xFF1B1B1F)
        static let onSurface = Color(hex: 0xFF1B1B1F)
    }

    struct TypographyTokens {
                                static let display = Font.system(size: 45, weight: .bold)
        static let headline = Font.system(size: 24, weight: .semibold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let small = RoundedRectangle(cornerRadius: 4.0)
        static let medium = RoundedRectangle(cornerRadius: 8.0)
        static let large = RoundedRectangle(cornerRadius: 12.0)
        static let circle = Circle()
    }

    struct Spacing {
                static let xs: CGFloat = 4.0
        static let sm: CGFloat = 8.0
        static let md: CGFloat = 12.0
        static let lg: CGFloat = 16.0
        static let xl: CGFloat = 24.0
    }

        struct ShadowSpec {
        let elevation: CGFloat 
        let radius: CGFloat    
        let dy: CGFloat        
        let opacity: Double    
    }

    struct ElevationMapping {
                                        static let level1 = ShadowSpec(elevation: 1.0, radius: 2.0, dy: 1.0, opacity: 0.08)
        static let level2 = ShadowSpec(elevation: 3.0, radius: 4.0, dy: 2.0, opacity: 0.10)
        static let level3 = ShadowSpec(elevation: 6.0, radius: 8.0, dy: 4.0, opacity: 0.12)
    }
}

struct AppThemeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
                                        }
}

extension View {
        func appTheme() -> some View {
        self.modifier(AppThemeModifier())
    }
}


struct AnnotationToolButton: View {
    let icon: String
    let toolName: String
    let selectedTool: String
    let onClick: () -> Void

    var isSelected: Bool { toolName == selectedTool }

    var body: some View {
        Button(action: onClick) {
            Text(icon)
                .font(Font.system(size: 17, weight: .bold)) 
                .foregroundColor(isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
        }
        .frame(width: 40, height: 40) 
        .background(isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
        .clipShape(AppTokens.Shapes.circle) 
        .buttonStyle(PlainButtonStyle()) 
        .contentShape(AppTokens.Shapes.circle) 
    }
}


struct RootScreen: View {
    @State private var selectedPage: Int = 1
    @State private var selectedTool: String = "pen"

    var body: some View {
                        VStack(spacing: 0) {
                        HStack(spacing: AppTokens.Spacing.sm) {
                                Button(action: {}) {
                    AppTokens.Shapes.circle
                        .fill(AppTokens.Colors.surfaceVariant)
                        .frame(width: 24, height: 24) 
                }
                .buttonStyle(PlainButtonStyle()) 

                Spacer() 

                Text("Document.pdf")
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.onBackground)

                Spacer() 

                                Button(action: {}) {
                    Text("Share")
                        .font(AppTokens.TypographyTokens.label)
                        .foregroundColor(AppTokens.Colors.onPrimary)
                        .padding(.vertical, AppTokens.Spacing.xs) 
                        .padding(.horizontal, AppTokens.Spacing.sm)
                }
                .background(AppTokens.Colors.primary)
                .clipShape(AppTokens.Shapes.small) 
                .buttonStyle(PlainButtonStyle()) 
            }
            .padding(AppTokens.Spacing.md) 
            .background(AppTokens.Colors.surface) 
            .frame(height: 56) 

                        HStack(spacing: AppTokens.Spacing.md) { 
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: AppTokens.Spacing.sm) { 
                    ForEach(1...12, id: \.self) { page in
                        Button(action: { selectedPage = page }) {
                            AppTokens.Shapes.medium 
                                .fill(selectedPage == page ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                                .overlay(
                                    Text(page.description)
                                        .font(AppTokens.TypographyTokens.label)
                                        .foregroundColor(selectedPage == page ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                                )
                                .aspectRatio(0.7, contentMode: .fit) 
                                .overlay(
                                                                        selectedPage == page ?
                                    AppTokens.Shapes.medium.stroke(AppTokens.Colors.primary, lineWidth: 2)
                                    : nil
                                )
                        }
                        .buttonStyle(PlainButtonStyle()) 
                    }
                }
                .frame(width: 150) 
                .padding(AppTokens.Spacing.sm) 
                .frame(maxHeight: .infinity) 

                                ZStack(alignment: .center) { 
                                        AppTokens.Shapes.large 
                        .fill(AppTokens.Colors.surface)
                        .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity),
                                radius: AppTokens.ElevationMapping.level1.radius, 
                                x: 0,
                                y: AppTokens.ElevationMapping.level1.dy) 
                        .overlay(
                            Text("Page \(selectedPage)")
                                .font(AppTokens.TypographyTokens.headline)
                                .foregroundColor(AppTokens.Colors.onSurface)
                        )
                        .frame(maxWidth: .infinity, maxHeight: .infinity) 

                                        VStack(spacing: AppTokens.Spacing.sm) { 
                        AnnotationToolButton(icon: "P", toolName: "pen", selectedTool: selectedTool, onClick: { selectedTool = "pen" })
                        AnnotationToolButton(icon: "H", toolName: "highlighter", selectedTool: selectedTool, onClick: { selectedTool = "highlighter" })
                        AnnotationToolButton(icon: "T", toolName: "text", selectedTool: selectedTool, onClick: { selectedTool = "text" })
                        AnnotationToolButton(icon: "S", toolName: "shape", selectedTool: selectedTool, onClick: { selectedTool = "shape" })
                    }
                    .padding(AppTokens.Spacing.sm) 
                    .background(AppTokens.Colors.surface.opacity(0.8)) 
                    .clipShape(AppTokens.Shapes.large) 
                    .overlay(
                        AppTokens.Shapes.large 
                            .stroke(AppTokens.Colors.outline, lineWidth: 1) 
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading) 
                    .padding(AppTokens.Spacing.md) 
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity) 
            }
            .padding(.horizontal, AppTokens.Spacing.md) 
            .frame(maxWidth: .infinity, maxHeight: .infinity) 
        }
        .background(AppTokens.Colors.background.ignoresSafeArea()) 
        .statusBarHidden(true) 
    }
}


@main
struct SingleFileUIApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                .appTheme() 
        }
    }
}