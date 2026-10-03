import SwiftUI

struct AppTokens {
        struct Colors {
        static let primary = Color(red: 0x11 / 255.0, green: 0x11 / 255.0, blue: 0x11 / 255.0)
        static let secondary = Color(red: 0x33 / 255.0, green: 0x33 / 255.0, blue: 0x33 / 255.0)
        static let tertiary = Color(red: 0x55 / 255.0, green: 0x55 / 255.0, blue: 0x55 / 255.0)
        static let background = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let surface = Color(red: 0xF9 / 255.0, green: 0xF9 / 255.0, blue: 0xF9 / 255.0)
        static let surfaceVariant = Color(red: 0xEA / 255.0, green: 0xEA / 255.0, blue: 0xEA / 255.0)
        static let outline = Color(red: 0xD0 / 255.0, green: 0xD0 / 255.0, blue: 0xD0 / 255.0)
        static let success = Color(red: 0x16 / 255.0, green: 0xA3 / 255.0, blue: 0x4A / 255.0)
        static let warning = Color(red: 0xF5 / 255.0, green: 0x9E / 255.0, blue: 0x0B / 255.0)
        static let error = Color(red: 0xDC / 255.0, green: 0x26 / 255.0, blue: 0x26 / 255.0)
        static let onPrimary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onSecondary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onTertiary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onBackground = Color(red: 0x11 / 255.0, green: 0x11 / 255.0, blue: 0x11 / 255.0)
        static let onSurface = Color(red: 0x11 / 255.0, green: 0x11 / 255.0, blue: 0x11 / 255.0)
    }

        struct TypographyTokens {
        static let display = Font.system(size: 26, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) 
        static let label = Font.system(size: 12, weight: .medium)
    }

        struct Shapes {
        static let small = CGFloat(6)
        static let medium = CGFloat(10)
        static let large = CGFloat(14)
    }

        struct Spacing {
        static let sm = CGFloat(8)
        static let md = CGFloat(12)
        static let lg = CGFloat(16)
        static let xl = CGFloat(24)

                        static let totalAppBarHeight: CGFloat = 100
    }

        struct ShadowSpec {
        let elevation: CGFloat 
        let radius: CGFloat    
        let dy: CGFloat        
        let opacity: Float

        var swiftShadowColor: Color {
            Color.black.opacity(Double(opacity))
        }
    }

    struct ElevationMapping {
                                static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 4, radius: 8, dy: 4, opacity: 0.16)
    }
}

struct FileItem: Identifiable {
    let id = UUID() 
    let name: String
    let type: String
    let size: String
}

struct BoxView: View {
    let text: String

    var body: some View {
        Text(text)
            .font(AppTokens.TypographyTokens.body)
            .foregroundColor(AppTokens.Colors.onSurface)
            .frame(maxWidth: .infinity) 
            .background(AppTokens.Colors.surfaceVariant)
            .cornerRadius(AppTokens.Shapes.medium)
    }
}

struct FileCard: View {
    let file: FileItem

    var body: some View {
        VStack(alignment: .leading) { 
            BoxView(text: file.type)

            Spacer() 

            VStack(alignment: .leading, spacing: 2) { 
                Text(file.name)
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.onSurface)
                Text(file.size)
                    .font(AppTokens.TypographyTokens.label)
                    .foregroundColor(AppTokens.Colors.tertiary)
            }
        }
        .padding(AppTokens.Spacing.md) 
        .frame(height: 120) 
        .background(AppTokens.Colors.surface) 
        .cornerRadius(AppTokens.Shapes.large) 
        .shadow(color: AppTokens.ElevationMapping.level1.swiftShadowColor,
                radius: AppTokens.ElevationMapping.level1.radius, 
                x: 0,
                y: AppTokens.ElevationMapping.level1.dy) 
    }
}

struct RootScreen: View {
        let files = [
        FileItem(name: "Report.pdf", type: "PDF", size: "2.1 MB"),
        FileItem(name: "Budget.xlsx", type: "Spreadsheet", size: "1.2 MB"),
        FileItem(name: "Design.psd", type: "Image", size: "4.7 MB"),
        FileItem(name: "Presentation.pptx", type: "Slides", size: "5.4 MB"),
        FileItem(name: "MeetingNotes.txt", type: "Text", size: "64 KB")
    ]

    var body: some View {
        VStack(spacing: 0) { 
                        ZStack {
                AppTokens.Colors.background 
                Text("File Manager")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.onSurface)
            }
            .frame(height: AppTokens.Spacing.totalAppBarHeight) 

                        VStack(alignment: .leading, spacing: AppTokens.Spacing.lg) { 
                Text("Recent Files")
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.primary)

                                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: AppTokens.Spacing.md), count: 2),
                          spacing: AppTokens.Spacing.md) {
                    ForEach(files) { file in
                        FileCard(file: file)
                    }
                }
            }
            .padding(AppTokens.Spacing.lg) 
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) 
            .background(AppTokens.Colors.background) 
        }
        .ignoresSafeArea(.all) 
        .background(AppTokens.Colors.background) 
    }
}

@main
struct SingleFileUIApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
            .statusBar(hidden: true)}
    }
}

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}
