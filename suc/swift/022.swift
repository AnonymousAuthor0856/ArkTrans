
import SwiftUI

// MARK: - 颜色扩展：支持十六进制初始化
// 方便地使用与 Android 相同的十六进制颜色定义
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

// MARK: - 应用设计令牌 (AppTokens)
// 统一管理颜色、字体、形状、间距和阴影，便于修改和维护
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
        // Kotlin 的 FontWeight.Normal 对应 SwiftUI 的 .regular
        static let display = Font.system(size: 26, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        // RoundedCornerShape 对应 SwiftUI 的 cornerRadius
        static let small = RoundedCorner(radius: 6)
        static let medium = RoundedCorner(radius: 10)
        static let large = RoundedCorner(radius: 16)

        struct RoundedCorner {
            let radius: CGFloat
        }
    }

    struct Spacing {
        // dp 单位直接转换为 CGFloat，保持原子级对应
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
    }

    struct ShadowSpec {
        // Compose 的 ShadowSpec 映射到 SwiftUI 的 .shadow 修饰符
        // elevation 在 Compose 中更多是概念上的层级，实际阴影参数是 radius, dy, opacity
        let elevation: CGFloat // Compose 中的 elevation，此处作为参考
        let radius: CGFloat    // 阴影的模糊半径
        let dy: CGFloat        // 阴影的 Y 轴偏移
        let opacity: Double    // 阴影的不透明度
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 4, radius: 8, dy: 4, opacity: 0.16)
    }
}

// MARK: - 数据模型
// Task 数据类，需遵循 Identifiable 协议以便在 ForEach 中使用
struct Task: Identifiable {
    let id = UUID() // 唯一标识符
    let name: String
    let progress: Float
}

// MARK: - 自定义样式
// 1. 自定义 ToggleStyle 以匹配 Android 的 Switch 视觉效果
struct CustomSwitchToggleStyle: ToggleStyle {
    var checkedThumbColor: Color

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label // 隐藏默认标签
            Spacer()
            // 模拟 Android Switch 的外观和尺寸
            let trackWidth: CGFloat = 51 // 轨道宽度
            let trackHeight: CGFloat = 31 // 轨道高度
            let thumbSize: CGFloat = 27 // 滑块尺寸
            let thumbPadding: CGFloat = 2 // 滑块内边距

            ZStack(alignment: configuration.isOn ? .trailing : .leading) {
                Capsule()
                    .fill(configuration.isOn ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                    .frame(width: trackWidth, height: trackHeight)
                Circle()
                    .fill(configuration.isOn ? checkedThumbColor : AppTokens.Colors.surface)
                    .shadow(radius: 1, x: 0, y: 1) // 简单的滑块阴影
                    .frame(width: thumbSize, height: thumbSize)
                    .padding(thumbPadding)
            }
            .onTapGesture {
                configuration.isOn.toggle() // 点击切换状态
            }
        }
    }
}

// 2. 自定义 ProgressViewStyle 以匹配 Android 的 LinearProgressIndicator 视觉效果
struct CustomLinearProgressViewStyle: ProgressViewStyle {
    var trackColor: Color    // 轨道颜色
    var progressColor: Color // 进度条颜色
    var height: CGFloat      // 进度条高度

    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: height / 2) // 轨道，圆角为高度的一半
                    .fill(trackColor)
                    .frame(height: height)

                RoundedRectangle(cornerRadius: height / 2) // 进度条
                    .fill(progressColor)
                    .frame(width: geometry.size.width * CGFloat(configuration.fractionCompleted ?? 0), height: height)
            }
        }
        .frame(height: height) // 确保 ProgressView 自身的高度
    }
}


// MARK: - 根视图 (RootScreen)
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
        VStack(spacing: 0) { // 主垂直堆栈，子视图之间无额外间距
            // 顶部导航栏 (CenterAlignedTopAppBar 模拟)
            Text("Project Timeline")
                .font(AppTokens.TypographyTokens.display)
                .foregroundColor(AppTokens.Colors.onSurface)
                .frame(maxWidth: .infinity) // 宽度填充
                .padding(.vertical, AppTokens.Spacing.lg) // 文本垂直内边距
                .background(AppTokens.Colors.background) // 顶部栏背景色
                // 根据 UI 效果图，顶部标题与屏幕顶部有一小段距离，即使状态栏隐藏
                // 这里通过额外添加顶部内边距来模拟
                .padding(.top, AppTokens.Spacing.sm)

            // 主要内容区域，带有渐变背景
            VStack(spacing: AppTokens.Spacing.lg) { // 通知行、任务列表、按钮之间的间距
                // 通知开关行
                HStack {
                    Text("Notifications")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)

                    Spacer() // 将开关推到右侧

                    Toggle(isOn: $notificationsEnabled) {
                        EmptyView() // 隐藏 SwiftUI 默认的 Toggle 标签
                    }
                    .toggleStyle(CustomSwitchToggleStyle(checkedThumbColor: AppTokens.Colors.primary))
                }

                // 任务列表 (LazyColumn 模拟)
                ScrollView { // 使用 ScrollView 模拟 LazyColumn，适用于少量固定数据
                    VStack(spacing: AppTokens.Spacing.md) { // 任务项之间的间距
                        ForEach(tasks) { task in
                            VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) { // 任务项内部文本与进度条间距
                                Text(task.name)
                                    .font(AppTokens.TypographyTokens.title)
                                    .foregroundColor(AppTokens.Colors.primary)

                                ProgressView(value: task.progress)
                                    .progressViewStyle(CustomLinearProgressViewStyle(
                                        trackColor: AppTokens.Colors.surfaceVariant,
                                        progressColor: AppTokens.Colors.secondary,
                                        height: 8 // 进度条高度 8.dp
                                    ))
                                    .frame(maxWidth: .infinity) // 进度条宽度填充
                            }
                            .padding(AppTokens.Spacing.md) // 任务项内部内容与边框的内边距
                            .frame(maxWidth: .infinity, alignment: .leading) // 任务项宽度填充，内容左对齐
                            .background(AppTokens.Colors.surface.opacity(0.7)) // 背景色及透明度
                            .cornerRadius(AppTokens.Shapes.large.radius) // 圆角
                            .shadow(
                                color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity), // 阴影颜色及不透明度
                                radius: AppTokens.ElevationMapping.level1.radius, // 阴影模糊半径
                                x: 0, // X 轴无偏移
                                y: AppTokens.ElevationMapping.level1.dy // Y 轴偏移
                            )
                        }
                    }
                }

                // 添加任务按钮
                Button(action: {
                    // TODO: 处理添加任务逻辑
                    print("Add Task button tapped!")
                }) {
                    Text("Add Task")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onPrimary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // 文本填充按钮区域
                }
                .frame(height: 52) // 按钮固定高度 52.dp
                .background(AppTokens.Colors.primary) // 按钮背景色
                .cornerRadius(AppTokens.Shapes.large.radius) // 按钮圆角
            }
            .padding(AppTokens.Spacing.lg) // 整个内容区域（通知、列表、按钮）的内边距
            .background(
                LinearGradient( // 垂直渐变背景
                    gradient: Gradient(colors: [
                        AppTokens.Colors.surface.opacity(0.8),
                        AppTokens.Colors.background,
                        AppTokens.Colors.surface.opacity(0.8)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .ignoresSafeArea(.all, edges: .bottom) // 渐变背景延伸至底部边缘，忽略底部安全区
        }
        .background(AppTokens.Colors.background) // 整个视图的背景色，作为未被渐变覆盖区域的填充
        .statusBarHidden(true) // 隐藏顶部状态栏
        .ignoresSafeArea(.all, edges: .top) // 整个 VStack 忽略顶部安全区，使其内容从屏幕最顶部开始
    }
}

// MARK: - App 入口点
// @main 宏定义了应用的入口
@main
struct SingleFileUIApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}

// MARK: - 预览提供者
// 用于 Xcode Canvas 预览
struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}