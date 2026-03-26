import SwiftUI

// MARK: - AppTokens
// 集中管理应用程序的颜色、字体、形状、间距和阴影定义
struct AppTokens {
    // 颜色定义，从 Kotlin 的 ARGB (0xFF...) 转换为 SwiftUI 的 Color
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

    // 字体样式定义，从 Kotlin 的 TextStyle 转换为 SwiftUI 的 Font
    struct TypographyTokens {
        static let display = Font.system(size: 26, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) // FontWeight.Normal 对应 SwiftUI 的 .regular
        static let label = Font.system(size: 12, weight: .medium)
    }

    // 圆角形状定义，从 Kotlin 的 Dp 转换为 SwiftUI 的 CGFloat
    struct Shapes {
        static let small = CGFloat(6)
        static let medium = CGFloat(10)
        static let large = CGFloat(14)
    }

    // 间距定义，从 Kotlin 的 Dp 转换为 SwiftUI 的 CGFloat
    struct Spacing {
        static let sm = CGFloat(8)
        static let md = CGFloat(12)
        static let lg = CGFloat(16)
        static let xl = CGFloat(24)

        // 自定义顶部应用栏高度，包括状态栏区域，以确保全屏显示时内容不被状态栏遮挡
        // 假设状态栏高度约为 44pt (iPhone X/XS/XR/11/12/13/14系列) + 应用栏内容高度 56pt
        static let totalAppBarHeight: CGFloat = 100
    }

    // 阴影规格定义，从 Kotlin 的 ShadowSpec 转换为 SwiftUI 的 shadow 参数
    struct ShadowSpec {
        let elevation: CGFloat // 在 SwiftUI 中通常映射为 y 偏移或与 radius 结合
        let radius: CGFloat    // 在 SwiftUI 中映射为模糊半径
        let dy: CGFloat        // 在 SwiftUI 中映射为 y 偏移
        let opacity: Float

        var swiftShadowColor: Color {
            Color.black.opacity(Double(opacity))
        }
    }

    struct ElevationMapping {
        // Kotlin: ShadowSpec(2.dp, 4.dp, 2.dp, 0.12f)
        // SwiftUI: shadow(color: ..., radius: blurRadius, x: xOffset, y: yOffset)
        // 这里的 radius (4.dp) 映射到 SwiftUI 的 blur radius，dy (2.dp) 映射到 SwiftUI 的 y 偏移
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 4, radius: 8, dy: 4, opacity: 0.16)
    }
}

// MARK: - Data Model
// 文件项数据模型，遵循 Identifiable 协议以便在 ForEach 中使用
struct FileItem: Identifiable {
    let id = UUID() // 唯一标识符
    let name: String
    let type: String
    let size: String
}

// MARK: - Components
// 模拟 Kotlin Compose 中的 Box 控件，用于显示文件类型
struct BoxView: View {
    let text: String

    var body: some View {
        Text(text)
            .font(AppTokens.TypographyTokens.body)
            .foregroundColor(AppTokens.Colors.onSurface)
            .frame(maxWidth: .infinity) // 填充宽度，固定高度
            .background(AppTokens.Colors.surfaceVariant)
            .cornerRadius(AppTokens.Shapes.medium)
    }
}

// 模拟 Kotlin Compose 中的 Card 控件，用于显示单个文件信息
struct FileCard: View {
    let file: FileItem

    var body: some View {
        VStack(alignment: .leading) { // 垂直布局，内容左对齐
            BoxView(text: file.type)

            Spacer() // 模拟 Arrangement.SpaceBetween，将上方 Box 和下方文本推开

            VStack(alignment: .leading, spacing: 2) { // 文件名和大小的垂直布局，小间距
                Text(file.name)
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.onSurface)
                Text(file.size)
                    .font(AppTokens.TypographyTokens.label)
                    .foregroundColor(AppTokens.Colors.tertiary)
            }
        }
        .padding(AppTokens.Spacing.md) // 卡片内部填充
        .frame(height: 120) // 卡片固定高度
        .background(AppTokens.Colors.surface) // 卡片背景色
        .cornerRadius(AppTokens.Shapes.large) // 卡片圆角
        .shadow(color: AppTokens.ElevationMapping.level1.swiftShadowColor,
                radius: AppTokens.ElevationMapping.level1.radius, // 阴影模糊半径
                x: 0,
                y: AppTokens.ElevationMapping.level1.dy) // 阴影 Y 轴偏移
    }
}

// MARK: - Root Screen
// 应用程序的主屏幕视图
struct RootScreen: View {
    // 示例文件数据
    let files = [
        FileItem(name: "Report.pdf", type: "PDF", size: "2.1 MB"),
        FileItem(name: "Budget.xlsx", type: "Spreadsheet", size: "1.2 MB"),
        FileItem(name: "Design.psd", type: "Image", size: "4.7 MB"),
        FileItem(name: "Presentation.pptx", type: "Slides", size: "5.4 MB"),
        FileItem(name: "MeetingNotes.txt", type: "Text", size: "64 KB")
    ]

    var body: some View {
        VStack(spacing: 0) { // 根垂直布局，无默认间距
            // 自定义顶部应用栏，模拟 CenterAlignedTopAppBar
            ZStack {
                AppTokens.Colors.background // 顶部栏背景色
                Text("File Manager")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.onSurface)
            }
            .frame(height: AppTokens.Spacing.totalAppBarHeight) // 固定顶部栏高度，覆盖状态栏区域

            // 主要内容区域
            VStack(alignment: .leading, spacing: AppTokens.Spacing.lg) { // 垂直布局，内容左对齐，大间距
                Text("Recent Files")
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.primary)

                // 垂直网格布局，两列，水平和垂直间距均为中等
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: AppTokens.Spacing.md), count: 2),
                          spacing: AppTokens.Spacing.md) {
                    ForEach(files) { file in
                        FileCard(file: file)
                    }
                }
            }
            .padding(AppTokens.Spacing.lg) // 整个内容区域的内边距
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 填充剩余空间，内容顶部左对齐
            .background(AppTokens.Colors.background) // 内容区域背景色
        }
        .ignoresSafeArea(.all) // 使整个视图忽略安全区域，实现全屏显示
        .background(AppTokens.Colors.background) // 整个屏幕的背景色
    }
}

// MARK: - App Entry Point
// 应用程序的入口点
@main
struct SingleFileUIApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
            .statusBar(hidden: true)}
    }
}

// MARK: - Preview
// SwiftUI 预览提供器
struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}
