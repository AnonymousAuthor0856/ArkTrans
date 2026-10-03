import SwiftUI
import UIKit 


struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFF0EA5E9)
        static let secondary = Color(hex: 0xFF6366F1)
        static let tertiary = Color(hex: 0xFF06B6D4)
        static let background = Color(hex: 0xFFF1F5F9)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFE2E8F0)
        static let outline = Color(hex: 0xFFD1D5DB)
        static let success = Color(hex: 0xFF10B981)
        static let warning = Color(hex: 0xFFF59E0B)
        static let error = Color(hex: 0xFFEF4444)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFFFFFFFF)
        static let onTertiary = Color(hex: 0xFF0F172A)
        static let onBackground = Color(hex: 0xFF1E293B)
        static let onSurface = Color(hex: 0xFF1E293B)
    }

    struct TypographyTokens {
                static let display = Font.system(size: 26, weight: .bold)
        static let headline = Font.system(size: 18, weight: .semibold)
        static let title = Font.system(size: 14, weight: .medium)
        static let body = Font.system(size: 12, weight: .regular)
        static let label = Font.system(size: 11, weight: .medium)
    }

    struct Shapes {
                static let small: CGFloat = 6.0
        static let medium: CGFloat = 10.0
        static let large: CGFloat = 14.0
    }

    struct Spacing {
                static let xs: CGFloat = 2.0
        static let sm: CGFloat = 6.0
        static let md: CGFloat = 10.0
        static let lg: CGFloat = 14.0
        static let xl: CGFloat = 20.0
        static let xxl: CGFloat = 28.0
    }

                struct ShadowSpec {
        let radius: CGFloat
        let x: CGFloat
        let y: CGFloat
        let opacity: Double 
    }

    struct ElevationMapping {
                        static let level1 = ShadowSpec(radius: 2, x: 0, y: 1, opacity: 0.1)
        static let level2 = ShadowSpec(radius: 4, x: 0, y: 2, opacity: 0.14)
        static let level3 = ShadowSpec(radius: 6, x: 0, y: 3, opacity: 0.16)
    }
}


extension Color {
            init(hex: UInt) {
        let r = Double((hex >> 16) & 0xFF) / 255.0
        let g = Double((hex >> 8) & 0xFF) / 255.0
        let b = Double(hex & 0xFF) / 255.0
        let a = Double((hex >> 24) & 0xFF) / 255.0 
        
                self.init(red: r, green: g, blue: b, opacity: a == 0 ? 1.0 : a)
    }
}


struct Homework: Identifiable {
    let id: Int
    let title: String
    let status: String
}

struct ChartData: Identifiable {
    let id: Int
    let label: String
    let progress: Float 
}


struct RootScreen: View {
        let works: [Homework] = [
        Homework(id: 1, title: "Linear Algebra HW1", status: "Submitted"),
        Homework(id: 2, title: "Data Structures HW2", status: "Pending"),
        Homework(id: 3, title: "Algorithm HW3", status: "Graded"),
        Homework(id: 4, title: "Probability HW4", status: "Pending")
    ]
    
        @State private var charts: [ChartData] = [
        ChartData(id: 1, label: "Week 1", progress: 0.7),
        ChartData(id: 2, label: "Week 2", progress: 0.9),
        ChartData(id: 3, label: "Week 3", progress: 0.5),
        ChartData(id: 4, label: "Week 4", progress: 0.8)
    ]

    var body: some View {
                                ZStack {
                        AppTokens.Colors.background.ignoresSafeArea()

            VStack(spacing: 0) { 
                                HStack {
                    Text("Homework Submit")
                        .font(AppTokens.TypographyTokens.display)
                        .foregroundColor(AppTokens.Colors.onBackground)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, AppTokens.Spacing.lg) 
                .background(AppTokens.Colors.surface) 
                                
                                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: AppTokens.Spacing.lg) { 
                        Text("Assignments")
                            .font(AppTokens.TypographyTokens.headline)
                            .foregroundColor(AppTokens.Colors.onBackground)

                                                LazyVGrid(
                            columns: [
                                GridItem(.flexible(), spacing: AppTokens.Spacing.md), 
                                GridItem(.flexible())
                            ],
                            spacing: AppTokens.Spacing.md 
                        ) {
                            ForEach(works) { w in
                                AssignmentCard(homework: w)
                            }
                        }
                        .padding(.bottom, AppTokens.Spacing.lg) 

                        Text("Progress Chart")
                            .font(AppTokens.TypographyTokens.headline)
                            .foregroundColor(AppTokens.Colors.onBackground)

                                                VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) { 
                            ForEach(charts) { c in
                                ChartProgressBar(chartData: c)
                            }
                        }

                                                Button(action: {
                                                        print("Submit New HW Tapped")
                        }) {
                            Text("Submit New HW")
                                .font(AppTokens.TypographyTokens.title)
                                .foregroundColor(AppTokens.Colors.onSecondary)
                                .frame(maxWidth: .infinity) 
                                .frame(height: 40) 
                                .background(AppTokens.Colors.secondary)
                                .cornerRadius(AppTokens.Shapes.large) 
                        }
                                                                                                                                                .frame(maxWidth: (UIScreen.main.bounds.width - 2 * AppTokens.Spacing.lg) * 0.6)
                        .frame(height: 40) 
                        .padding(.top, AppTokens.Spacing.lg) 
                        .frame(maxWidth: .infinity, alignment: .center) 
                    }
                    .padding(AppTokens.Spacing.lg) 
                }
                .background(
                    LinearGradient( 
                        gradient: Gradient(colors: [
                            AppTokens.Colors.primary.opacity(0.15),
                            AppTokens.Colors.secondary.opacity(0.1)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
        }
        .ignoresSafeArea(.all) 
    }
}


struct AssignmentCard: View {
    let homework: Homework

    var body: some View {
        VStack(alignment: .center, spacing: AppTokens.Spacing.sm) { 
                        Rectangle()
                .fill(AppTokens.Colors.tertiary)
                .frame(width: 40, height: 40) 
                .cornerRadius(AppTokens.Shapes.small) 
            
            Spacer() 
            
            Text(homework.title)
                .font(AppTokens.TypographyTokens.title)
                .foregroundColor(AppTokens.Colors.onSurface)
            Text(homework.status)
                .font(AppTokens.TypographyTokens.label)
                .foregroundColor(AppTokens.Colors.onSurface)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) 
        .padding(AppTokens.Spacing.md) 
        .background(AppTokens.Colors.surface) 
        .cornerRadius(AppTokens.Shapes.medium) 
        .overlay(
                        RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                .stroke(AppTokens.Colors.outline, lineWidth: 1)
        )
        .aspectRatio(1.0, contentMode: .fit) 
    }
}


struct ChartProgressBar: View {
    let chartData: ChartData

    var body: some View {
        VStack(alignment: .leading, spacing: 0) { 
            GeometryReader { geometry in
                HStack(spacing: 0) { 
                                        Rectangle()
                        .fill(AppTokens.Colors.primary)
                        .frame(width: geometry.size.width * CGFloat(chartData.progress))
                        .cornerRadius(AppTokens.Shapes.small)
                    Spacer() 
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity) 
                .background(AppTokens.Colors.surfaceVariant) 
                .cornerRadius(AppTokens.Shapes.small) 
            }
            .frame(height: 24) 
            .frame(maxWidth: .infinity) 

                        Text("\(chartData.label): \(Int(chartData.progress * 100))%")
                .font(AppTokens.TypographyTokens.body)
                .foregroundColor(AppTokens.Colors.onSurface)
        }
    }
}


class CustomHostingController<Content>: UIHostingController<Content> where Content : View {
    override var prefersStatusBarHidden: Bool {
        return true 
    }
    
        override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear 
    }
}

@main
struct SingleFileUIApp: App {
    var body: some Scene {
        WindowGroup {
                        RootScreen()
                .preferredColorScheme(.light) 
                                                                                                                                                .onAppear {
                                                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        if let rootVC = windowScene.windows.first?.rootViewController as? UIHostingController<RootScreen> {
                                                                                                                                                                                                                                rootVC.setNeedsStatusBarAppearanceUpdate()
                        } else {
                                                        windowScene.windows.first?.rootViewController?.setNeedsStatusBarAppearanceUpdate()
                        }
                    }
                }
                .statusBarHidden(true) 
        }
    }
}


struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
            .previewDisplayName("Homework Submit UI")
    }
}