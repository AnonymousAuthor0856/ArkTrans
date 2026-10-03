import SwiftUI

struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFF111111)
        static let secondary = Color(hex: 0xFF444444)
        static let background = Color(hex: 0xFFF5F5F5)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let outline = Color(hex: 0xFFCCCCCC)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSurface = Color(hex: 0xFF111111)
    }

    struct TypographyTokens {
                static let display = Font.system(size: 28, weight: .bold)
        static let headline = Font.system(size: 18, weight: .semibold)
        static let body = Font.system(size: 14, weight: .regular)
    }

    struct Shapes {
        let radius: CGFloat
        var style: RoundedCornerStyle = .continuous 

        static let small = Shapes(radius: 6)
        static let medium = Shapes(radius: 10)
        static let large = Shapes(radius: 14)
    }

    struct Spacing {
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
    }

    struct ShadowSpec {
                                        let blurRadius: CGFloat
        let yOffset: CGFloat
        let opacity: Double
    }
    struct ElevationMapping {
                        static let level1 = ShadowSpec(blurRadius: 4, yOffset: 2, opacity: 0.1)
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

extension View {
    func cornerRadius(_ shape: AppTokens.Shapes) -> some View {
        self.cornerRadius(shape.radius)
    }
}

struct RootScreen: View {
    let tabs = ["All", "Enrolled", "Completed"]
    @State private var selectedTabIndex: Int = 0
    
    var body: some View {
                ZStack {
            AppTokens.Colors.background.ignoresSafeArea(.all)

            VStack(spacing: AppTokens.Spacing.md) {
                Text("Course Catalog")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.primary)
                    .frame(maxWidth: .infinity, alignment: .leading) 

                                CustomTabRow(tabs: tabs, selectedTabIndex: $selectedTabIndex)
                    .background(AppTokens.Colors.surface) 
                    .cornerRadius(AppTokens.Shapes.small) 

                                                TabView(selection: $selectedTabIndex) {
                    ForEach(tabs.indices, id: \.self) { index in
                                                Group {
                            switch index {
                            case 0:
                                CourseList(title: "All Courses", count: 6)
                            case 1:
                                CourseList(title: "Enrolled", count: 3)
                            case 2:
                                CourseList(title: "Completed", count: 4)
                            default:
                                EmptyView() 
                            }
                        }
                        .tag(index) 
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never)) 
                .animation(.easeInOut, value: selectedTabIndex) 
            }
            .padding(.horizontal, AppTokens.Spacing.lg)
            .padding(.vertical, AppTokens.Spacing.md)
            .ignoresSafeArea(.keyboard, edges: .bottom) 
        }
    }
}

struct CustomTabRow: View {
    let tabs: [String]
    @Binding var selectedTabIndex: Int
    @Namespace private var tabNamespace 

    var body: some View {
        HStack(spacing: 0) { 
            ForEach(tabs.indices, id: \.self) { index in
                Button(action: {
                    selectedTabIndex = index
                }) {
                    VStack(spacing: 0) { 
                        Text(tabs[index])
                            .font(selectedTabIndex == index ? AppTokens.TypographyTokens.headline : AppTokens.TypographyTokens.body)
                            .foregroundColor(selectedTabIndex == index ? AppTokens.Colors.primary : AppTokens.Colors.secondary)
                            .padding(.vertical, AppTokens.Spacing.md) 
                            .frame(maxWidth: .infinity) 
                        
                                                if selectedTabIndex == index {
                            Rectangle()
                                .fill(AppTokens.Colors.primary)
                                .frame(height: 2)
                                .matchedGeometryEffect(id: "tabUnderline", in: tabNamespace) 
                        } else {
                                                        Rectangle()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle()) 
            }
        }
        .animation(.easeInOut(duration: 0.2), value: selectedTabIndex) 
    }
}


struct CourseList: View {
    let title: String
    let count: Int

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) { 
            VStack(alignment: .leading, spacing: AppTokens.Spacing.md) {
                Text(title)
                    .font(AppTokens.TypographyTokens.headline)
                    .foregroundColor(AppTokens.Colors.secondary)

                ForEach(0..<count, id: \.self) { index in
                    CourseCard(courseNumber: index + 1)
                }
            }
            .frame(maxWidth: .infinity) 
        }
    }
}

struct CourseCard: View {
    let courseNumber: Int

    var body: some View {
                VStack {
            HStack(alignment: .center) { 
                VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
                    Text("Course \(courseNumber)")
                        .font(AppTokens.TypographyTokens.headline)
                        .foregroundColor(AppTokens.Colors.primary)
                                        Text("Duration: \(5 + courseNumber - 1) hrs")
                        .font(AppTokens.TypographyTokens.body)
                        .foregroundColor(AppTokens.Colors.secondary)
                }
                Spacer() 

                                Text("View")
                    .font(AppTokens.TypographyTokens.body)
                    .foregroundColor(AppTokens.Colors.onPrimary)
                    .padding(.horizontal, 12) 
                    .frame(height: 24) 
                    .background(AppTokens.Colors.primary)
                    .clipShape(Capsule()) 
            }
            .padding(AppTokens.Spacing.md) 
        }
        .background(AppTokens.Colors.surface) 
        .cornerRadius(AppTokens.Shapes.medium) 
        .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity), 
                radius: AppTokens.ElevationMapping.level1.blurRadius, 
                x: 0, 
                y: AppTokens.ElevationMapping.level1.yOffset) 
        .frame(maxWidth: .infinity) 
    }
}


@main
struct CourseCatalogApp: App {
            private struct StatusBarHidingViewController: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let controller = UIViewController()
                        controller.view.backgroundColor = .clear
            return controller
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
                    }

                func prefersStatusBarHidden() -> Bool {
            return true
        }
    }

    var body: some Scene {
        WindowGroup {
            RootScreen()
                .statusBarHidden(true)
                                .ignoresSafeArea(.all)
                                                                .overlay(StatusBarHidingViewController().frame(width: 0, height: 0))
        }
    }
}

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}