import SwiftUI
import UIKit // Required for UIHostingController and prefersStatusBarHidden

// MARK: - AppTokens
// 严格遵守要求4：按钮尺寸、间距与留白需与安卓版本原子级对应，保持控件样式、比例及排版一致。
// 所有 Dp 值直接转换为 CGFloat。
// 所有 Color 值从十六进制直接转换为 RGB。
// 所有 Font 尺寸和权重直接翻译。
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
        static let body = Font.system(size: 14, weight: .regular) // FontWeight.Normal 映射到 .regular
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
        // Kotlin: ShadowSpec(2.dp, 4.dp, 2.dp, 0.12f) -> radius: 4, y: 2, opacity: 0.12
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.12)
        // Kotlin: ShadowSpec(4.dp, 8.dp, 4.dp, 0.16f) -> radius: 8, y: 4, opacity: 0.16
        static let level2 = ShadowSpec(elevation: 4, radius: 8, dy: 4, opacity: 0.16)
    }
}

// MARK: - Data Models
struct KanbanColumn: Identifiable {
    let id = UUID() // SwiftUI ForEach 需要 Identifiable
    let title: String
    let tasks: [String]
}

// MARK: - RootScreen
struct RootScreen: View {
    let columns = [
        KanbanColumn(title: "To Do", tasks: ["Write report", "Design mockup"]),
        KanbanColumn(title: "In Progress", tasks: ["Implement feature X", "Fix layout bug"]),
        KanbanColumn(title: "Done", tasks: ["Team sync", "Client feedback"])
    ]

    @State private var notificationsEnabled: Bool = true

    var body: some View {
        // 要求2: App 必须设置为全屏显示，并确保顶部状态栏隐藏。
        // 全屏背景色，忽略所有安全区域。
        ZStack {
            AppTokens.Colors.background.ignoresSafeArea(.all)

            VStack(spacing: 0) { // 主内容 VStack，内部元素自行处理间距
                // 自定义顶部栏，等同于 CenterAlignedTopAppBar
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Text("Kanban Board")
                            .font(AppTokens.TypographyTokens.display)
                            .foregroundColor(AppTokens.Colors.onSurface)
                        Spacer()
                    }
                    .padding(.horizontal, AppTokens.Spacing.lg) // 水平内边距
                    .padding(.top, AppTokens.Spacing.lg) // 顶部内边距
                    .padding(.bottom, AppTokens.Spacing.md) // 底部内边距
                }
                .frame(maxWidth: .infinity)
                .background(AppTokens.Colors.background) // 顶部栏背景色

                // 主要内容区域
                VStack(alignment: .leading, spacing: AppTokens.Spacing.lg) {
                    // 通知行
                    HStack {
                        Text("Notifications")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.onSurface)
                        Spacer()
                        Toggle(isOn: $notificationsEnabled) {
                            // 空标签，因为文本已单独提供
                        }
                        .toggleStyle(SwitchToggleStyle(tint: AppTokens.Colors.primary)) // 匹配 checkedThumbColor
                        .labelsHidden() // 隐藏默认的 Toggle 标签
                    }
                    .frame(maxWidth: .infinity)

                    // Kanban 列的 LazyRow 等效
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: AppTokens.Spacing.md) {
                            ForEach(columns) { col in
                                CardView(column: col)
                                    .frame(width: 220) // 固定宽度，与 Kotlin 相同
                                    .frame(maxHeight: .infinity) // 填充高度，与 Kotlin 相同
                            }
                        }
                        .padding(.vertical, AppTokens.Spacing.xs) // 滚动视图内容的小垂直内边距
                    }

                    // 任务完成
                    Text("Task Completion")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)

                    // LinearProgressIndicator 等效
                    ProgressView(value: 0.65)
                        .progressViewStyle(LinearProgressViewStyle(tint: AppTokens.Colors.primary, trackColor: AppTokens.Colors.surfaceVariant))
                        .frame(maxWidth: .infinity)
                        .frame(height: 8) // 固定高度，与 Kotlin 相同
                }
                .padding(AppTokens.Spacing.lg) // 主要内容 VStack 的内边距
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 填充剩余空间
            }
        }
    }
}

// MARK: - Custom ProgressViewStyle to match LinearProgressIndicator
struct LinearProgressViewStyle: ProgressViewStyle {
    var tint: Color
    var trackColor: Color

    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4) // 高度 8.dp 的一半
                    .fill(trackColor)
                    .frame(height: 8)

                RoundedRectangle(cornerRadius: 4)
                    .fill(tint)
                    .frame(width: geometry.size.width * CGFloat(configuration.fractionCompleted ?? 0), height: 8)
            }
        }
    }
}

// MARK: - CardView (Kanban Column Card)
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
            Spacer() // 将内容推到卡片顶部，模拟 fillMaxHeight 行为
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

// MARK: - AssistChipView
struct AssistChipView: View {
    let task: String

    var body: some View {
        Button(action: {
            // Kotlin 版本中 onClick 为空，此处也留空
        }) {
            Text(task)
                .font(AppTokens.TypographyTokens.body)
                .foregroundColor(AppTokens.Colors.onSurface)
                .padding(.horizontal, AppTokens.Spacing.lg) // 调整内边距以匹配 AssistChip 视觉效果
                .padding(.vertical, AppTokens.Spacing.sm) // 调整垂直内边距
                .background(AppTokens.Colors.surfaceVariant)
                .cornerRadius(AppTokens.Shapes.medium.cornerRadius)
        }
        .buttonStyle(PlainButtonStyle()) // 移除默认按钮样式
    }
}

// MARK: - UIHostingController for Status Bar Hiding (要求2)
// 必须在 Info.plist 中设置 "View controller-based status bar appearance" 为 YES。
class HostingController<Content>: UIHostingController<Content> where Content : View {
    override var prefersStatusBarHidden: Bool {
        return true // 隐藏顶部状态栏
    }
    
    // 确保在 iOS 16.0 及以上版本兼容
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
}

// MARK: - App Entry Point (要求5)
@main
struct KanbanBoardApp: App {
    var body: some Scene {
        WindowGroup {
            // 将 RootScreen 包装在自定义的 HostingController 中以隐藏状态栏。
            HostingControllerWrapper()
        }
    }
}

// Helper struct to wrap UIHostingController in a SwiftUI View
struct HostingControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> HostingController<RootScreen> {
        return HostingController(rootView: RootScreen())
    }

    func updateUIViewController(_ uiViewController: HostingController<RootScreen>, context: Context) {
        // SwiftUI 视图更新时，无需在此处执行任何操作
    }
}