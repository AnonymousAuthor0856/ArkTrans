import SwiftUI

// MARK: - AppTokens
// 集中管理所有设计令牌，方便原子级修改和保持双平台一致性。
struct AppTokens {
    struct Colors {
        // 使用 hex 初始化 Color，确保颜色精确对应
        static let primary = Color(hex: 0xFF007BFF)
        static let secondary = Color(hex: 0xFF6C757D)
        static let tertiary = Color(hex: 0xFF17A2B8)
        static let background = Color(hex: 0xFFF8F9FA)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFE9ECEF)
        static let outline = Color(hex: 0xFFDEE2E6)
        static let success = Color(hex: 0xFF28A745)
        static let warning = Color(hex: 0xFFFFC107)
        static let error = Color(hex: 0xFFDC3545)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFFFFFFFF)
        static let onTertiary = Color(hex: 0xFFFFFFFF)
        static let onBackground = Color(hex: 0xFF212529)
        static let onSurface = Color(hex: 0xFF212529)
    }

    struct TypographyTokens {
        // 字体大小和字重与 Compose 对应
        static let display = Font.system(size: 36, weight: .bold)
        static let headline = Font.system(size: 28, weight: .semibold)
        static let title = Font.system(size: 22, weight: .medium)
        static let body = Font.system(size: 16, weight: .regular) // Compose 的 FontWeight.Normal 对应 Swift 的 .regular
        static let label = Font.system(size: 14, weight: .medium)
    }

    struct Shapes {
        // 圆角半径
        static let small: CGFloat = 4
        static let medium: CGFloat = 8
        static let large: CGFloat = 12
    }

    struct Spacing {
        // 间距值，直接从 Dp 转换为 CGFloat
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
    }

    // 阴影规范，用于精确匹配 Compose 的 elevation
    struct ShadowSpec {
        let elevation: CGFloat // 对应 Compose 的 elevation，用于计算阴影强度
        let radius: CGFloat    // 阴影模糊半径
        let dy: CGFloat        // Y 轴偏移
        let opacity: Double    // 阴影不透明度
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 1, radius: 3, dy: 1, opacity: 0.1)
        static let level2 = ShadowSpec(elevation: 3, radius: 6, dy: 2, opacity: 0.1)
        static let level3 = ShadowSpec(elevation: 6, radius: 10, dy: 4, opacity: 0.1)
    }
}

// 扩展 Color，支持从十六进制值初始化
extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

// MARK: - App Theme Environment Values
// 使用 EnvironmentKey 模拟 Compose 的 MaterialTheme.typography 访问方式
struct AppTypographyKey: EnvironmentKey {
    static let defaultValue: AppTypography = AppTypography()
}

struct AppTypography {
    let displayMedium = AppTokens.TypographyTokens.display
    let headlineSmall = AppTokens.TypographyTokens.headline
    let titleMedium = AppTokens.TypographyTokens.title
    let bodyMedium = AppTokens.TypographyTokens.body
    let labelMedium = AppTokens.TypographyTokens.label
}

extension EnvironmentValues {
    var appTypography: AppTypography {
        get { self[AppTypographyKey.self] }
        set { self[AppTypographyKey.self] = newValue }
    }
}

// 安全区域 Environment Key
struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    }
}

extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        get { self[SafeAreaInsetsKey.self] }
        set { self[SafeAreaInsetsKey.self] = newValue }
    }
}

// MARK: - Data Models
// 对应 Kotlin 的 ClipboardItem 数据类
struct ClipboardItem: Identifiable {
    let id: Int
    let content: String
    let type: String
    let timestamp: String
    let progress: Float
}

// MARK: - RootScreen
// 对应 Kotlin 的 RootScreen Composable
struct RootScreen: View {
    @State private var sliderValue: Float = 24.0

    // 模拟 Compose 中的 remember { listOf(...) }
    let clipboardItems: [ClipboardItem] = [
        ClipboardItem(id: 1, content: "https://www.example.com/modern-design", type: "Link", timestamp: "5 min ago", progress: 0.2),
        ClipboardItem(id: 2, content: "Final project review notes have been updated.", type: "Text", timestamp: "23 min ago", progress: 0.5),
        ClipboardItem(id: 3, content: "#007BFF", type: "Color", timestamp: "1 hour ago", progress: 0.8),
        ClipboardItem(id: 4, content: "Meeting at 3 PM with the design team.", type: "Text", timestamp: "3 hours ago", progress: 0.9),
        ClipboardItem(id: 5, content: "Shared file: 'Q3_Report.pdf'", type: "File", timestamp: "Yesterday", progress: 1.0)
    ]

    var body: some View {
        GeometryReader { geometry in
            // 整体使用 VStack 布局，模拟 Scaffold
            VStack(spacing: 0) {
                // 自定义顶部栏，模拟 CenterAlignedTopAppBar
                HStack {
                    Spacer() // 用于居中标题
                    Text("Clipboard History")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onBackground)
                    Spacer() // 用于居中标题

                    Button(action: {
                        // 处理 Clear 按钮点击事件
                        print("Clear button tapped")
                    }) {
                        Text("Clear")
                            .font(AppTokens.TypographyTokens.label)
                            .foregroundColor(AppTokens.Colors.onSurface)
                            .padding(.vertical, AppTokens.Spacing.sm)
                            .padding(.horizontal, AppTokens.Spacing.md)
                            .background(AppTokens.Colors.surfaceVariant)
                            .cornerRadius(AppTokens.Shapes.medium)
                    }
                    .padding(.trailing, AppTokens.Spacing.md) // 按钮右侧间距
                }
                .padding(.top, geometry.safeAreaInsets.top) // 顶部内边距，避开状态栏
                .frame(height: 56 + geometry.safeAreaInsets.top) // 顶部栏高度 (标准 AppBar 高度 + 状态栏高度)
                .background(AppTokens.Colors.surface)
                // 顶部栏阴影，模拟 elevation
                .shadow(color: .black.opacity(0.05), radius: 0.5, x: 0, y: 0.5)

                // 内容区域，模拟 LazyColumn
                ScrollView {
                    LazyVStack(spacing: AppTokens.Spacing.md) { // 垂直间距
                        ForEach(clipboardItems) { item in
                            ClipboardCard(item: item)
                        }
                    }
                    .padding(.horizontal, AppTokens.Spacing.lg) // 水平内边距
                    .padding(.vertical, AppTokens.Spacing.md)   // 垂直内边距
                }
                .background(AppTokens.Colors.background) // 滚动区域背景色

                // 设置面板
                SettingsPane(sliderValue: $sliderValue)
                    .background(AppTokens.Colors.surface)
                    // 设置面板阴影，模拟 elevation
                    .shadow(color: .black.opacity(AppTokens.ElevationMapping.level2.opacity),
                            radius: AppTokens.ElevationMapping.level2.radius,
                            x: 0,
                            y: -AppTokens.ElevationMapping.level2.dy) // 阴影向上
            }
        }
        // 忽略安全区域，使内容延伸到屏幕边缘，包括状态栏下方
        .ignoresSafeArea(.all, edges: .top)
        .background(AppTokens.Colors.background) // 整个屏幕的背景色
        .statusBarHidden(true) // 隐藏状态栏
    }
}

// MARK: - ClipboardCard
// 对应 Kotlin 的 ClipboardCard Composable
struct ClipboardCard: View {
    let item: ClipboardItem
    // 通过 Environment 访问自定义的排版样式
    @Environment(\.appTypography) var typography

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: AppTokens.Spacing.sm) {
                // 模拟 Box + clip + background
                RoundedRectangle(cornerRadius: AppTokens.Shapes.small)
                    .fill(AppTokens.Colors.primary)
                    .frame(width: 24, height: 24)

                Text(item.type)
                    .font(typography.labelMedium)
                    .foregroundColor(AppTokens.Colors.primary)
                    .fontWeight(.bold)

                Spacer() // 模拟 Modifier.weight(1f)

                Text(item.timestamp)
                    .font(typography.labelMedium)
                    .foregroundColor(AppTokens.Colors.secondary)
            }
            .padding(.bottom, AppTokens.Spacing.sm) // 模拟 Spacer height

            Text(item.content)
                .font(typography.bodyMedium)
                .foregroundColor(AppTokens.Colors.onSurface)
                .lineLimit(2) // 模拟 maxLines
                .truncationMode(.tail) // 模拟 TextOverflow.Ellipsis
                .padding(.bottom, AppTokens.Spacing.md) // 模拟 Spacer height

            // 线性进度指示器，使用自定义样式以匹配 Compose 的 trackColor
            ProgressView(value: item.progress)
                .progressViewStyle(CustomLinearProgressViewStyle(tint: AppTokens.Colors.tertiary, track: AppTokens.Colors.surfaceVariant))
                .frame(height: 4) // 设置高度
        }
        .padding(AppTokens.Spacing.md) // 内边距
        .background(AppTokens.Colors.surface) // 背景色
        .cornerRadius(AppTokens.Shapes.large) // 圆角
        .overlay(
            // 边框，模拟 BorderStroke
            RoundedRectangle(cornerRadius: AppTokens.Shapes.large)
                .stroke(AppTokens.Colors.surfaceVariant, lineWidth: 1)
        )
        // 阴影，模拟 elevation
        .shadow(color: .black.opacity(AppTokens.ElevationMapping.level1.opacity),
                radius: AppTokens.ElevationMapping.level1.radius,
                x: 0,
                y: AppTokens.ElevationMapping.level1.dy)
    }
}

// 自定义 ProgressViewStyle，以匹配 Compose 的 LinearProgressIndicator 的 trackColor
struct CustomLinearProgressViewStyle: ProgressViewStyle {
    var tint: Color // 进度条颜色
    var track: Color // 轨道颜色

    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // 轨道背景
                RoundedRectangle(cornerRadius: AppTokens.Shapes.small)
                    .fill(track)
                    .frame(height: 4)
                    .frame(width: geometry.size.width) // 轨道宽度填充可用空间

                // 进度条
                RoundedRectangle(cornerRadius: AppTokens.Shapes.small)
                    .fill(tint)
                    .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * geometry.size.width, height: 4)
            }
        }
        .frame(height: 4) // 确保整个 ProgressView 的高度
    }
}

// MARK: - SettingsPane
// 对应 Kotlin 的 SettingsPane Composable
struct SettingsPane: View {
    @Binding var sliderValue: Float // 绑定滑块值
    @Environment(\.appTypography) var typography

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("History Limit (Hours)")
                    .font(typography.labelMedium)
                    .foregroundColor(AppTokens.Colors.onSurface)
                Spacer()
                Text(String(format: "%.0f", sliderValue)) // 显示整数值
                    .font(typography.bodyMedium)
                    .fontWeight(.semibold)
                    .foregroundColor(AppTokens.Colors.onSurface)
            }
            .padding(.bottom, AppTokens.Spacing.sm) // 垂直间距

            Slider(value: $sliderValue, in: 1...72, step: 1) 
                .tint(AppTokens.Colors.primary) // iOS 15+
                .accentColor(AppTokens.Colors.primary) // 兼容 iOS 14
        }
        .padding(AppTokens.Spacing.lg) // 内边距
        .frame(maxWidth: .infinity) // 宽度填充
        // 面板的背景和阴影在 RootScreen 中应用
    }
}

// MARK: - App Entry Point
// 对应 Kotlin 的 MainActivity，使用 @main 标记为应用入口
@main
struct ClipboardHistoryApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                // 将自定义的排版样式注入环境，供子视图使用
                .environment(\.appTypography, AppTypography())
        }
    }
}

// MARK: - Preview
// Xcode 预览，对应 Compose 的 @Preview
struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
            .environment(\.appTypography, AppTypography())
    }
}