import SwiftUI

// MARK: - AppTokens
// 定义应用程序的颜色、排版、形状、间距和阴影规范
struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0xFF8E6BF2)
        static let secondary = Color(hex: 0xFFD3C1FF)
        static let tertiary = Color(hex: 0xFFB39DDB)
        static let background = Color(hex: 0xFFF5F3FF)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFECE6F8)
        static let outline = Color(hex: 0xFFD1C4E9)
        static let success = Color(hex: 0xFF4CAF50)
        static let warning = Color(hex: 0xFFFFB300)
        static let error = Color(hex: 0xFFE53935)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFF2E1A47)
        static let onBackground = Color(hex: 0xFF2E1A47)
        static let onSurface = Color(hex: 0xFF2E1A47)
    }

    struct TypographyTokens {
        static let display = Font.system(size: 28, weight: .bold)
        static let title = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular) // FontWeight.Normal 对应 .regular
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let small = 8.0
        static let medium = 14.0
        static let large = 20.0
    }

    struct Spacing {
        static let sm = 6.0
        static let md = 10.0
        static let lg = 16.0
        static let xl = 24.0
    }

    struct ShadowSpec {
        let elevation: CGFloat // 对应 Compose 的 elevation，在 SwiftUI 中通常映射为 shadow radius
        let radius: CGFloat    // 对应 Compose 的 radius，在 SwiftUI 中通常映射为 shadow radius
        let dy: CGFloat        // 对应 Compose 的 dy，在 SwiftUI 中映射为 shadow y 偏移
        let opacity: Double    // 对应 Compose 的 opacity
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 4.0, radius: 8.0, dy: 2.0, opacity: 0.18)
        static let level2 = ShadowSpec(elevation: 8.0, radius: 12.0, dy: 4.0, opacity: 0.22)
        static let level3 = ShadowSpec(elevation: 12.0, radius: 20.0, dy: 8.0, opacity: 0.26)
    }
}

// MARK: - Color Extension
// 方便使用十六进制颜色值初始化 Color
extension Color {
    init(hex: UInt) {
        self.init(
            red: Double((hex & 0xFF0000) >> 16) / 255.0,
            green: Double((hex & 0x00FF00) >> 8) / 255.0,
            blue: Double(hex & 0x0000FF) / 255.0
        )
    }
}

// MARK: - CustomCardStyle ViewModifier
// 用于模拟 Compose Card 的样式，包括圆角、背景色和阴影
struct CustomCardStyle: ViewModifier {
    var cornerRadius: CGFloat
    var backgroundColor: Color
    var shadowSpec: AppTokens.ShadowSpec
    // Compose 的 spotColor 和 ambientColor 在 SwiftUI 的单个 shadow modifier 中难以完全复制。
    // 这里使用 ambientColor 作为主阴影颜色，并结合 opacity。
    var spotColor: Color // 仅为兼容性保留，实际效果由 ambientColor 和 shadowSpec 控制
    var ambientColor: Color

    func body(content: Content) -> some View {
        content
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            // SwiftUI 的 shadow 无法直接区分 spotColor 和 ambientColor。
            // 我们使用 ambientColor 作为阴影颜色，并应用 shadowSpec 中的半径、偏移和不透明度。
            .shadow(color: ambientColor.opacity(shadowSpec.opacity), radius: shadowSpec.radius, x: 0, y: shadowSpec.dy)
    }
}

// MARK: - RootScreen
// 应用程序的主要 UI 视图
struct RootScreen: View {
    @State private var orderId: String = ""
    @State private var issue: String = ""
    @State private var submitted: Bool = false

    // 用于 TextField 和 TextEditor 的焦点状态，以便精确控制样式
    @FocusState private var orderIdIsFocused: Bool
    @FocusState private var issueIsFocused: Bool

    var body: some View {
        ZStack { // 相当于 Compose 的 Scaffold，用于设置整个屏幕的背景色
            AppTokens.Colors.background.ignoresSafeArea() // 设置背景色并忽略安全区域

            VStack(spacing: AppTokens.Spacing.lg) { // 对应 Compose 的 Column，垂直间距为 lg
                Text("After-Sale Service")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.onBackground)
                    .frame(maxWidth: .infinity, alignment: .leading) // 文本左对齐

                // Card 区域
                VStack(alignment: .leading, spacing: AppTokens.Spacing.md) { // Card 内部的 Column
                    Text("Order ID")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)

                    // Order ID 输入框
                    ZStack(alignment: .topLeading) { // 用于实现带自定义颜色的 placeholder
                        if orderId.isEmpty && !orderIdIsFocused { // 当输入为空且未聚焦时显示 placeholder
                            Text("Enter order number")
                                .font(AppTokens.TypographyTokens.body)
                                .foregroundColor(AppTokens.Colors.onSurface.opacity(0.5))
                                .padding(.horizontal, AppTokens.Spacing.md)
                                .padding(.vertical, (56 - AppTokens.TypographyTokens.body.pointSize) / 2) // 垂直居中 placeholder
                        }
                        TextField("", text: $orderId) // TextField 本身不带 placeholder
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(AppTokens.Colors.onSurface)
                            .padding(.horizontal, AppTokens.Spacing.md)
                            .frame(height: 56) // 对应 Compose TextField 的默认高度 (如 56.dp)
                            .background(
                                RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                                    .fill(AppTokens.Colors.surfaceVariant) // unfocusedContainerColor 和 focusedContainerColor 相同
                                    .overlay(
                                        RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                                            .stroke(orderIdIsFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline, lineWidth: 1)
                                    )
                            )
                            .focused($orderIdIsFocused)
                    }

                    Text("Issue Description")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)

                    // Issue Description 输入框 (TextEditor 对应多行 TextField)
                    ZStack(alignment: .topLeading) { // 用于实现带自定义颜色的 placeholder
                        if issue.isEmpty && !issueIsFocused { // 当输入为空且未聚焦时显示 placeholder
                            Text("Describe your issue")
                                .font(AppTokens.TypographyTokens.body)
                                .foregroundColor(AppTokens.Colors.onSurface.opacity(0.5))
                                .padding(.horizontal, AppTokens.Spacing.md)
                                .padding(.vertical, AppTokens.Spacing.sm + 4) // 调整 TextEditor 内部默认 padding
                        }
                        TextEditor(text: $issue)
                            .font(AppTokens.TypographyTokens.body)
                            .foregroundColor(AppTokens.Colors.onSurface)
                            .padding(.horizontal, AppTokens.Spacing.md)
                            .padding(.vertical, AppTokens.Spacing.sm + 4) // 匹配 placeholder 垂直 padding
                            .frame(height: 120) // 对应 Kotlin 代码中的 height(120.dp)
                            .background(
                                RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                                    .fill(AppTokens.Colors.surfaceVariant) // unfocusedContainerColor 和 focusedContainerColor 相同
                                    .overlay(
                                        RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                                            .stroke(issueIsFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline, lineWidth: 1)
                                    )
                            )
                            .focused($issueIsFocused)
                    }
                }
                .frame(maxWidth: .infinity) // 对应 Compose 的 fillMaxWidth()
                .modifier(CustomCardStyle(
                    cornerRadius: AppTokens.Shapes.large,
                    backgroundColor: AppTokens.Colors.surface,
                    shadowSpec: AppTokens.ElevationMapping.level2,
                    spotColor: AppTokens.Colors.secondary,
                    ambientColor: AppTokens.Colors.outline
                ))

                // 提交按钮
                Button(action: {
                    submitted = true
                }) {
                    Text("Submit Request")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onPrimary)
                        .frame(maxWidth: .infinity) // 对应 Compose 的 fillMaxWidth()
                        .frame(height: 56) // 对应 Compose 的 height(56.dp)
                        .background(AppTokens.Colors.primary)
                        .cornerRadius(AppTokens.Shapes.large)
                }

                // 提交成功消息
                if submitted {
                    Text("Request submitted successfully!")
                        .font(AppTokens.TypographyTokens.body)
                        .foregroundColor(AppTokens.Colors.success)
                        .frame(maxWidth: .infinity) // 对应 Compose 的 fillMaxWidth()
                        .padding(AppTokens.Spacing.lg)
                        .background(AppTokens.Colors.success.opacity(0.15))
                        .cornerRadius(AppTokens.Shapes.medium)
                        .multilineTextAlignment(.center) // 对应 Alignment.Center
                }

                Spacer() // 将内容推到顶部，模拟 Compose Column 的 fillMaxSize 行为
            }
            .padding(AppTokens.Spacing.lg) // 对应 Compose Column 上的 padding(AppTokens.Spacing.lg)
        }
        .ignoresSafeArea(.all, edges: .all) // 设置为全屏显示
        .statusBarHidden(true) // 隐藏顶部状态栏 (iOS 16.0 兼容)
    }
}

// 辅助扩展，用于获取 Font 的点大小，以便进行精确布局
extension Font {
    // 这是一个简化的方法，仅针对 AppTokens.TypographyTokens.body 的特定定义
    // 如果需要更通用的解决方案，可能需要更复杂的 Font 描述符解析
    var pointSize: CGFloat {
        // AppTokens.TypographyTokens.body 被定义为 Font.system(size: 14, ...)
        if self == AppTokens.TypographyTokens.body {
            return 14.0
        }
        // 可以根据需要添加其他字体大小的判断
        return 14.0 // 默认值或回退值
    }
}


// MARK: - App Entry Point
// SwiftUI 应用程序的入口点
@main
struct AfterSaleServiceApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}