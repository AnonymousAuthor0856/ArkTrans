import SwiftUI

// MARK: - AppTokens
// 翻译 AppTokens 对象到 Swift 结构体，包含静态属性
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
        // Kotlin的dp/sp通常直接对应SwiftUI的pt
        static let display = Font.system(size: 28, weight: .bold)
        static let headline = Font.system(size: 18, weight: .semibold)
        static let body = Font.system(size: 14, weight: .regular)
    }

    struct Shapes {
        let radius: CGFloat
        var style: RoundedCornerStyle = .continuous // 默认使用连续圆角，视觉上更平滑

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
        // Kotlin的ShadowSpec(elevation, radius, dy, opacity)
        // elevation在Compose中常与blur radius相关，这里Kotlin明确给出了radius。
        // SwiftUI的shadow(color:radius:x:y:)中，radius是模糊半径。
        // 我们将Kotlin的`radius`映射到SwiftUI的`blurRadius`，`dy`映射到`yOffset`。
        let blurRadius: CGFloat
        let yOffset: CGFloat
        let opacity: Double
    }
    struct ElevationMapping {
        // Kotlin: ShadowSpec(2.dp, 4.dp, 2.dp, 0.1f)
        // 对应 SwiftUI: blurRadius: 4, yOffset: 2, opacity: 0.1
        static let level1 = ShadowSpec(blurRadius: 4, yOffset: 2, opacity: 0.1)
    }
}

// MARK: - 辅助扩展
// 扩展 Color 以支持十六进制颜色初始化
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

// 扩展 View 以支持使用 AppTokens.Shapes 定义的圆角
extension View {
    func cornerRadius(_ shape: AppTokens.Shapes) -> some View {
        self.cornerRadius(shape.radius)
    }
}

// MARK: - RootScreen
struct RootScreen: View {
    let tabs = ["All", "Enrolled", "Completed"]
    @State private var selectedTabIndex: Int = 0
    
    var body: some View {
        // ZStack 用于设置整个屏幕的背景色，并忽略安全区域
        ZStack {
            AppTokens.Colors.background.ignoresSafeArea(.all)

            VStack(spacing: AppTokens.Spacing.md) {
                Text("Course Catalog")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.primary)
                    .frame(maxWidth: .infinity, alignment: .leading) // 文本左对齐

                // 自定义 TabRow 的等效实现
                CustomTabRow(tabs: tabs, selectedTabIndex: $selectedTabIndex)
                    .background(AppTokens.Colors.surface) // TabRow 的背景色
                    .cornerRadius(AppTokens.Shapes.small) // TabRow 容器的圆角

                // HorizontalPager 的等效实现
                // 使用 TabView 配合 .page 样式实现水平分页
                TabView(selection: $selectedTabIndex) {
                    ForEach(tabs.indices, id: \.self) { index in
                        // Group 用于在 ForEach 内部条件性渲染视图
                        Group {
                            switch index {
                            case 0:
                                CourseList(title: "All Courses", count: 6)
                            case 1:
                                CourseList(title: "Enrolled", count: 3)
                            case 2:
                                CourseList(title: "Completed", count: 4)
                            default:
                                EmptyView() // 默认情况，防止意外索引
                            }
                        }
                        .tag(index) // 必须设置 tag 以便 TabView 的 selection 绑定工作
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never)) // 隐藏默认的分页指示器
                .animation(.easeInOut, value: selectedTabIndex) // 动画页面切换
            }
            .padding(.horizontal, AppTokens.Spacing.lg)
            .padding(.vertical, AppTokens.Spacing.md)
            .ignoresSafeArea(.keyboard, edges: .bottom) // 键盘弹出时自动调整布局
        }
    }
}

// MARK: - CustomTabRow
struct CustomTabRow: View {
    let tabs: [String]
    @Binding var selectedTabIndex: Int
    @Namespace private var tabNamespace // 用于匹配几何效果，实现下划线动画

    var body: some View {
        HStack(spacing: 0) { // 标签之间无间距，与 Compose TabRow 保持一致
            ForEach(tabs.indices, id: \.self) { index in
                Button(action: {
                    selectedTabIndex = index
                }) {
                    VStack(spacing: 0) { // 文本和下划线之间无间距
                        Text(tabs[index])
                            .font(selectedTabIndex == index ? AppTokens.TypographyTokens.headline : AppTokens.TypographyTokens.body)
                            .foregroundColor(selectedTabIndex == index ? AppTokens.Colors.primary : AppTokens.Colors.secondary)
                            .padding(.vertical, AppTokens.Spacing.md) // 标签文本的垂直内边距
                            .frame(maxWidth: .infinity) // 每个标签占据等宽空间
                        
                        // 下划线指示器
                        if selectedTabIndex == index {
                            Rectangle()
                                .fill(AppTokens.Colors.primary)
                                .frame(height: 2)
                                .matchedGeometryEffect(id: "tabUnderline", in: tabNamespace) // 动画效果
                        } else {
                            // 占位符，保持未选中标签的布局一致性
                            Rectangle()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle()) // 移除按钮的默认样式（如蓝色高亮）
            }
        }
        .animation(.easeInOut(duration: 0.2), value: selectedTabIndex) // 动画下划线移动
    }
}


// MARK: - CourseList
struct CourseList: View {
    let title: String
    let count: Int

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) { // 允许内容超出屏幕时滚动
            VStack(alignment: .leading, spacing: AppTokens.Spacing.md) {
                Text(title)
                    .font(AppTokens.TypographyTokens.headline)
                    .foregroundColor(AppTokens.Colors.secondary)

                ForEach(0..<count, id: \.self) { index in
                    CourseCard(courseNumber: index + 1)
                }
            }
            .frame(maxWidth: .infinity) // 确保 VStack 在 ScrollView 中占据全部宽度
        }
    }
}

// MARK: - CourseCard
struct CourseCard: View {
    let courseNumber: Int

    var body: some View {
        // Card 等效实现：VStack 结合背景、圆角和阴影修饰符
        VStack {
            HStack(alignment: .center) { // 垂直居中对齐
                VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
                    Text("Course \(courseNumber)")
                        .font(AppTokens.TypographyTokens.headline)
                        .foregroundColor(AppTokens.Colors.primary)
                    // Kotlin 的 (5 + it) 对应 Swift 的 (5 + courseNumber - 1)，因为 courseNumber 是 1-indexed
                    Text("Duration: \(5 + courseNumber - 1) hrs")
                        .font(AppTokens.TypographyTokens.body)
                        .foregroundColor(AppTokens.Colors.secondary)
                }
                Spacer() // 占据剩余空间，实现左右两端对齐

                // Box (按钮样式) 等效实现：Text 结合背景和胶囊形状裁剪
                Text("View")
                    .font(AppTokens.TypographyTokens.body)
                    .foregroundColor(AppTokens.Colors.onPrimary)
                    .padding(.horizontal, 12) // 水平内边距 12.dp
                    .frame(height: 24) // 高度 24.dp
                    .background(AppTokens.Colors.primary)
                    .clipShape(Capsule()) // 圆形或胶囊形裁剪，模拟 CircleShape
            }
            .padding(AppTokens.Spacing.md) // 内部内容与卡片边缘的内边距
        }
        .background(AppTokens.Colors.surface) // 卡片的背景色
        .cornerRadius(AppTokens.Shapes.medium) // 卡片的圆角
        .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity), // 标准阴影颜色（黑色带透明度）
                radius: AppTokens.ElevationMapping.level1.blurRadius, // 模糊半径
                x: 0, // X 轴偏移，Kotlin 的 ShadowSpec 未指定，默认为 0
                y: AppTokens.ElevationMapping.level1.yOffset) // Y 轴偏移
        .frame(maxWidth: .infinity) // 占据全部可用宽度
    }
}


// MARK: - App 入口点
// 这是 SwiftUI 应用程序的入口结构体
@main
struct CourseCatalogApp: App {
    // UIViewControllerRepresentable 用于控制状态栏的可见性。
    // 这是在 SwiftUI 中隐藏状态栏最可靠的方法，尤其是在 iOS 16+。
    private struct StatusBarHidingViewController: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let controller = UIViewController()
            // 将控制器视图的背景设置为透明，确保它不会遮挡内容
            controller.view.backgroundColor = .clear
            return controller
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            // 对于这个简单的控制器，无需更新
        }

        // 此方法由系统调用以确定状态栏的可见性
        func prefersStatusBarHidden() -> Bool {
            return true
        }
    }

    var body: some Scene {
        WindowGroup {
            RootScreen()
                .statusBarHidden(true)
                // 使内容填充整个屏幕，包括通常为状态栏和 Home 指示器保留的区域
                .ignoresSafeArea(.all)
                // 覆盖一个零大小的、隐藏状态栏的 UIViewController，以确保状态栏被隐藏。
                // frame(width: 0, height: 0) 使其不可见，但仍是视图层次结构的一部分，
                // 从而使其 prefersStatusBarHidden 方法生效。
                .overlay(StatusBarHidingViewController().frame(width: 0, height: 0))
        }
    }
}

// MARK: - 预览
struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}