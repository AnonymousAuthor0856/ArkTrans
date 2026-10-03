
import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double(hex & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFF38BDF8)
        static let secondary = Color(hex: 0xFF6366F1)
        static let tertiary = Color(hex: 0xFFA5B4FC)
        static let background = Color(hex: 0xFFF1F5F9)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFE2E8F0)
        static let outline = Color(hex: 0xFFD1D5DB)
        static let success = Color(hex: 0xFF22C55E)
        static let warning = Color(hex: 0xFFF59E0B)
        static let error = Color(hex: 0xFFEF4444)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFF1E1E1E)
        static let onTertiary = Color(hex: 0xFF1E1E1E)
        static let onBackground = Color(hex: 0xFF1E1E1E)
        static let onSurface = Color(hex: 0xFF1E1E1E)
    }

    struct TypographyTokens {
                static let display = Font.system(size: 26, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
                static let small = RoundedCorner(radius: 6)
        static let medium = RoundedCorner(radius: 10)
        static let large = RoundedCorner(radius: 16)

        struct RoundedCorner {
            let radius: CGFloat
        }
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

struct Task: Identifiable {
    let id = UUID() 
    let name: String
    let progress: Float
}

struct CustomSwitchToggleStyle: ToggleStyle {
    var checkedThumbColor: Color

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label 
            Spacer()
                        let trackWidth: CGFloat = 51 
            let trackHeight: CGFloat = 31 
            let thumbSize: CGFloat = 27 
            let thumbPadding: CGFloat = 2 

            ZStack(alignment: configuration.isOn ? .trailing : .leading) {
                Capsule()
                    .fill(configuration.isOn ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                    .frame(width: trackWidth, height: trackHeight)
                Circle()
                    .fill(configuration.isOn ? checkedThumbColor : AppTokens.Colors.surface)
                    .shadow(radius: 1, x: 0, y: 1) 
                    .frame(width: thumbSize, height: thumbSize)
                    .padding(thumbPadding)
            }
            .onTapGesture {
                configuration.isOn.toggle() 
            }
        }
    }
}

struct CustomLinearProgressViewStyle: ProgressViewStyle {
    var trackColor: Color    
    var progressColor: Color 
    var height: CGFloat      

    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: height / 2) 
                    .fill(trackColor)
                    .frame(height: height)

                RoundedRectangle(cornerRadius: height / 2) 
                    .fill(progressColor)
                    .frame(width: geometry.size.width * CGFloat(configuration.fractionCompleted ?? 0), height: height)
            }
        }
        .frame(height: height) 
    }
}


struct RootScreen: View {
    @State private var tasks: [Task] = [
        Task(name: "Design Phase", progress: 0.8),
        Task(name: "Development", progress: 0.5),
        Task(name: "Testing", progress: 0.3),
        Task(name: "Documentation", progress: 0.6),
        Task(name: "Deployment", progress: 0.2)
    ]
    @State private var notificationsEnabled: Bool = true

    var body: some View {
        VStack(spacing: 0) { 
                        Text("Project Timeline")
                .font(AppTokens.TypographyTokens.display)
                .foregroundColor(AppTokens.Colors.onSurface)
                .frame(maxWidth: .infinity) 
                .padding(.vertical, AppTokens.Spacing.lg) 
                .background(AppTokens.Colors.background) 
                                                .padding(.top, AppTokens.Spacing.sm)

                        VStack(spacing: AppTokens.Spacing.lg) { 
                                HStack {
                    Text("Notifications")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)

                    Spacer() 

                    Toggle(isOn: $notificationsEnabled) {
                        EmptyView() 
                    }
                    .toggleStyle(CustomSwitchToggleStyle(checkedThumbColor: AppTokens.Colors.primary))
                }

                                ScrollView { 
                    VStack(spacing: AppTokens.Spacing.md) { 
                        ForEach(tasks) { task in
                            VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) { 
                                Text(task.name)
                                    .font(AppTokens.TypographyTokens.title)
                                    .foregroundColor(AppTokens.Colors.primary)

                                ProgressView(value: task.progress)
                                    .progressViewStyle(CustomLinearProgressViewStyle(
                                        trackColor: AppTokens.Colors.surfaceVariant,
                                        progressColor: AppTokens.Colors.secondary,
                                        height: 8 
                                    ))
                                    .frame(maxWidth: .infinity) 
                            }
                            .padding(AppTokens.Spacing.md) 
                            .frame(maxWidth: .infinity, alignment: .leading) 
                            .background(AppTokens.Colors.surface.opacity(0.7)) 
                            .cornerRadius(AppTokens.Shapes.large.radius) 
                            .shadow(
                                color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity), 
                                radius: AppTokens.ElevationMapping.level1.radius, 
                                x: 0, 
                                y: AppTokens.ElevationMapping.level1.dy 
                            )
                        }
                    }
                }

                                Button(action: {
                                        print("Add Task button tapped!")
                }) {
                    Text("Add Task")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onPrimary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity) 
                }
                .frame(height: 52) 
                .background(AppTokens.Colors.primary) 
                .cornerRadius(AppTokens.Shapes.large.radius) 
            }
            .padding(AppTokens.Spacing.lg) 
            .background(
                LinearGradient( 
                    gradient: Gradient(colors: [
                        AppTokens.Colors.surface.opacity(0.8),
                        AppTokens.Colors.background,
                        AppTokens.Colors.surface.opacity(0.8)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .ignoresSafeArea(.all, edges: .bottom) 
        }
        .background(AppTokens.Colors.background) 
        .statusBarHidden(true) 
        .ignoresSafeArea(.all, edges: .top) 
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

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}