import SwiftUI
import UIKit 

struct AppTokens {
    struct Colors {
        static let primary = Color(red: 0x25 / 255.0, green: 0x63 / 255.0, blue: 0xEB / 255.0)
        static let secondary = Color(red: 0x60 / 255.0, green: 0xA5 / 255.0, blue: 0xFA / 255.0)
        static let tertiary = Color(red: 0x3B / 255.0, green: 0x82 / 255.0, blue: 0xF6 / 255.0)
        static let background = Color(red: 0xF3 / 255.0, green: 0xF4 / 255.0, blue: 0xF6 / 255.0)
        static let surface = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let surfaceVariant = Color(red: 0xE5 / 255.0, green: 0xE7 / 255.0, blue: 0xEB / 255.0)
        static let outline = Color(red: 0xD1 / 255.0, green: 0xD5 / 255.0, blue: 0xDB / 255.0)
        static let success = Color(red: 0x16 / 255.0, green: 0xA3 / 255.0, blue: 0x4A / 255.0)
        static let warning = Color(red: 0xF5 / 255.0, green: 0x9E / 255.0, blue: 0x0B / 255.0)
        static let error = Color(red: 0xDC / 255.0, green: 0x26 / 255.0, blue: 0x26 / 255.0)
        static let onPrimary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onSecondary = Color(red: 0x1E / 255.0, green: 0x1E / 255.0, blue: 0x1E / 255.0)
        static let onTertiary = Color(red: 0xFF / 255.0, green: 0xFF / 255.0, blue: 0xFF / 255.0)
        static let onBackground = Color(red: 0x1E / 255.0, green: 0x1E / 255.0, blue: 0x1E / 255.0)
        static let onSurface = Color(red: 0x1E / 255.0, green: 0x1E / 255.0, blue: 0x1E / 255.0)
    }

    struct TypographyTokens {
        static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) 
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        let cornerRadius: CGFloat
        static let small = Shapes(cornerRadius: 6)
        static let medium = Shapes(cornerRadius: 10)
        static let large = Shapes(cornerRadius: 14)
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
                static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.12)
                static let level2 = ShadowSpec(elevation: 4, radius: 8, dy: 4, opacity: 0.16)
    }
}

struct KanbanColumn: Identifiable {
    let id = UUID() 
    let title: String
    let tasks: [String]
}

struct RootScreen: View {
    let columns = [
        KanbanColumn(title: "To Do", tasks: ["Write report", "Design mockup"]),
        KanbanColumn(title: "In Progress", tasks: ["Implement feature X", "Fix layout bug"]),
        KanbanColumn(title: "Done", tasks: ["Team sync", "Client feedback"])
    ]

    @State private var notificationsEnabled: Bool = true

    var body: some View {
                        ZStack {
            AppTokens.Colors.background.ignoresSafeArea(.all)

            VStack(spacing: 0) { 
                                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Text("Kanban Board")
                            .font(AppTokens.TypographyTokens.display)
                            .foregroundColor(AppTokens.Colors.onSurface)
                        Spacer()
                    }
                    .padding(.horizontal, AppTokens.Spacing.lg) 
                    .padding(.top, AppTokens.Spacing.lg) 
                    .padding(.bottom, AppTokens.Spacing.md) 
                }
                .frame(maxWidth: .infinity)
                .background(AppTokens.Colors.background) 

                                VStack(alignment: .leading, spacing: AppTokens.Spacing.lg) {
                                        HStack {
                        Text("Notifications")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.onSurface)
                        Spacer()
                        Toggle(isOn: $notificationsEnabled) {
                                                    }
                        .toggleStyle(SwitchToggleStyle(tint: AppTokens.Colors.primary)) 
                        .labelsHidden() 
                    }
                    .frame(maxWidth: .infinity)

                                        ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: AppTokens.Spacing.md) {
                            ForEach(columns) { col in
                                CardView(column: col)
                                    .frame(width: 220) 
                                    .frame(maxHeight: .infinity) 
                            }
                        }
                        .padding(.vertical, AppTokens.Spacing.xs) 
                    }

                                        Text("Task Completion")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)

                                        ProgressView(value: 0.65)
                        .progressViewStyle(LinearProgressViewStyle(tint: AppTokens.Colors.primary, trackColor: AppTokens.Colors.surfaceVariant))
                        .frame(maxWidth: .infinity)
                        .frame(height: 8) 
                }
                .padding(AppTokens.Spacing.lg) 
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) 
            }
        }
    }
}

struct LinearProgressViewStyle: ProgressViewStyle {
    var tint: Color
    var trackColor: Color

    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4) 
                    .fill(trackColor)
                    .frame(height: 8)

                RoundedRectangle(cornerRadius: 4)
                    .fill(tint)
                    .frame(width: geometry.size.width * CGFloat(configuration.fractionCompleted ?? 0), height: 8)
            }
        }
    }
}

struct CardView: View {
    let column: KanbanColumn

    var body: some View {
        VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
            Text(column.title)
                .font(AppTokens.TypographyTokens.title)
                .foregroundColor(AppTokens.Colors.primary)

            ForEach(column.tasks, id: \.self) { task in
                AssistChipView(task: task)
            }
            Spacer() 
        }
        .padding(AppTokens.Spacing.md)
        .background(AppTokens.Colors.surface)
        .cornerRadius(AppTokens.Shapes.large.cornerRadius)
        .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity),
                radius: AppTokens.ElevationMapping.level2.radius,
                x: 0,
                y: AppTokens.ElevationMapping.level2.dy)
    }
}

struct AssistChipView: View {
    let task: String

    var body: some View {
        Button(action: {
                    }) {
            Text(task)
                .font(AppTokens.TypographyTokens.body)
                .foregroundColor(AppTokens.Colors.onSurface)
                .padding(.horizontal, AppTokens.Spacing.lg) 
                .padding(.vertical, AppTokens.Spacing.sm) 
                .background(AppTokens.Colors.surfaceVariant)
                .cornerRadius(AppTokens.Shapes.medium.cornerRadius)
        }
        .buttonStyle(PlainButtonStyle()) 
    }
}

class HostingController<Content>: UIHostingController<Content> where Content : View {
    override var prefersStatusBarHidden: Bool {
        return true 
    }
    
        override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
}

@main
struct KanbanBoardApp: App {
    var body: some Scene {
        WindowGroup {
                        HostingControllerWrapper()
        }
    }
}

struct HostingControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> HostingController<RootScreen> {
        return HostingController(rootView: RootScreen())
    }

    func updateUIViewController(_ uiViewController: HostingController<RootScreen>, context: Context) {
            }
}