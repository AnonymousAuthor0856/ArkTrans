import SwiftUI

// MARK: - AppTokens
// 复制 Kotlin 的 AppTokens 结构，确保颜色、字体、形状和间距的原子级对应。
struct AppTokens {
    // MARK: Colors
    struct Colors {
        // 使用扩展方便从 Hex 值创建 Color
        static let primary = Color(hex: 0xFF2563EB)
        static let secondary = Color(hex: 0xFF38BDF8)
        static let tertiary = Color(hex: 0xFF3B82F6)
        static let background = Color(hex: 0xFFF8FAFC)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFE2E8F0)
        static let outline = Color(hex: 0xFFCBD5E1)
        static let success = Color(hex: 0xFF22C55E)
        static let warning = Color(hex: 0xFFF59E0B)
        static let error = Color(hex: 0xFFEF4444)
        static let onPrimary = Color(hex: 0xFFFFFFFF)
        static let onSecondary = Color(hex: 0xFF0F172A)
        static let onTertiary = Color(hex: 0xFFFFFFFF)
        static let onBackground = Color(hex: 0xFF0F172A)
        static let onSurface = Color(hex: 0xFF1E293B)
    }

    // MARK: TypographyTokens
    // 将 Compose 的 TextStyle 映射到 SwiftUI 的 Font
    struct TypographyTokens {
        static let display = Font.system(size: 28, weight: .bold)
        static let headline = Font.system(size: 20, weight: .semibold)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    // MARK: Shapes
    // 将 Compose 的 RoundedCornerShape 映射到 CGFloat
    struct Shapes {
        static let small = CGFloat(8) // 8.dp
        static let medium = CGFloat(12) // 12.dp
        static let large = CGFloat(16) // 16.dp
    }

    // MARK: Spacing
    // 将 Compose 的 Dp 映射到 CGFloat
    struct Spacing {
        static let xs = CGFloat(4) // 4.dp
        static let sm = CGFloat(8) // 8.dp
        static let md = CGFloat(12) // 12.dp
        static let lg = CGFloat(16) // 16.dp
        static let xl = CGFloat(24) // 24.dp
        static let xxl = CGFloat(36) // 36.dp
    }

    // MARK: ElevationMapping
    // 复制 ShadowSpec，用于模拟 Compose 的 tonalElevation
    struct ShadowSpec {
        let elevation: CGFloat // 阴影在 Z 轴上的偏移（通常影响强度和扩散）
        let radius: CGFloat    // 阴影的模糊半径
        let dy: CGFloat        // 阴影在 Y 轴上的偏移
        let opacity: Double    // 阴影的不透明度
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 4, radius: 8, dy: 4, opacity: 0.14)
        static let level3 = ShadowSpec(elevation: 8, radius: 12, dy: 6, opacity: 0.16)
    }
}

// MARK: - Color Extension for Hex Initialization
// 方便从 Kotlin 0xFF... 格式的 Hex 值创建 SwiftUI Color
extension Color {
    init(hex: UInt) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: Double((hex >> 24) & 0xFF) / 255.0 // Alpha 通道
        )
    }
}

// MARK: - RootScreen View (ContentView)
// 对应 Kotlin 的 RootScreen Composable 函数
struct RootScreen: View {
    // 定义常量以匹配 Material Design 组件的默认尺寸，确保布局一致性
    private let topBarHeight: CGFloat = 64 // 对应 Compose CenterAlignedTopAppBar 的默认高度
    private let bottomBarHeight: CGFloat = 80 // 对应 Compose BottomAppBar 的默认高度
    private let fabSize: CGFloat = 56 // 对应 Compose FloatingActionButton 的默认尺寸

    var body: some View {
        // 使用 ZStack 来模拟 Scaffold 的分层布局：内容层、顶部栏、底部栏、浮动按钮
        ZStack(alignment: .bottomTrailing) { // 浮动按钮默认在右下角
            // 1. 主要内容层：填充整个屏幕，但为顶部和底部栏预留空间
            VStack(spacing: AppTokens.Spacing.lg) { // Column 的 verticalArrangement = spacedBy(AppTokens.Spacing.lg)
                // 顶部占位符，避免内容被自定义顶部栏遮挡
                Spacer().frame(height: topBarHeight)

                Text("Sign In to Continue")
                    .font(AppTokens.TypographyTokens.headline)
                    .foregroundColor(AppTokens.Colors.onSurface)

                // Workout Preview Box
                ZStack { // 对应 Box
                    Text("Workout Preview")
                        .font(AppTokens.TypographyTokens.body)
                        .foregroundColor(AppTokens.Colors.onSurface)
                }
                .frame(maxWidth: .infinity) // fillMaxWidth()
                .frame(height: 200) // height(200.dp)
                .background(AppTokens.Colors.surface) // background(AppTokens.Colors.surface)
                .cornerRadius(AppTokens.Shapes.large) // shape = AppTokens.Shapes.large
                .overlay( // border(1.dp, AppTokens.Colors.outline, AppTokens.Shapes.large)
                    RoundedRectangle(cornerRadius: AppTokens.Shapes.large)
                        .stroke(AppTokens.Colors.outline, lineWidth: 1) // 1.dp 边框
                )

                // Authenticate Button
                Button(action: {}) {
                    Text("Authenticate")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onPrimary) // contentColor
                        .frame(maxWidth: .infinity) // 模拟 fillMaxWidth
                        .frame(height: 52) // height(52.dp)
                        .background(AppTokens.Colors.primary) // containerColor
                        .cornerRadius(AppTokens.Shapes.large) // shape
                }
                .frame(width: UIScreen.main.bounds.width * 0.8) // fillMaxWidth(0.8f)
                // 注意：在 SwiftUI 中，Button 的 frame 和 background 顺序很重要，
                // 先设置 Text 的 frame 和背景，再设置 Button 的 frame 和背景，可以更好地控制内部内容。
                // 这里将背景和圆角直接应用于 Button 内部的 Text，然后 Button 自身再设置宽度。
                // 另一种常见做法是 Button 内部是 `Label` 或 `HStack`，然后对其应用 `frame` 和 `background`。
                // 为了原子级对应，我们让 Text 填充 Button 内部，然后 Button 限制外部宽度。

                Spacer() // 将内容推向顶部，保持垂直居中或顶部对齐
            }
            .padding(.horizontal, AppTokens.Spacing.lg) // Column 的 padding(AppTokens.Spacing.lg)
            .frame(maxWidth: .infinity, maxHeight: .infinity) // fillMaxSize()
            .background( // background(Brush.verticalGradient(...))
                LinearGradient(
                    gradient: Gradient(colors: [
                        AppTokens.Colors.secondary.opacity(0.1), // secondary.copy(alpha = 0.1f)
                        AppTokens.Colors.primary.opacity(0.15) // primary.copy(alpha = 0.15f)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .background(AppTokens.Colors.background) // Scaffold 的 containerColor
            // 为底部栏预留空间，防止内容被底部栏遮挡
            .padding(.bottom, bottomBarHeight)
            .ignoresSafeArea(.all) // 让内容填充整个屏幕，忽略安全区

            // 2. 自定义顶部栏层
            VStack { // 对应 CenterAlignedTopAppBar
                Text("Workout Plan")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.onBackground)
            }
            .frame(maxWidth: .infinity)
            .frame(height: topBarHeight)
            .background(AppTokens.Colors.surface)
            .frame(maxHeight: .infinity, alignment: .top) // 将顶部栏对齐到 ZStack 的顶部
            .ignoresSafeArea(.container, edges: .top) // 顶部栏延伸至屏幕顶部边缘

            // 3. 自定义底部栏层
            VStack { // 对应 BottomAppBar
                HStack(spacing: 0) { // spacing: 0，因为 Spacer 管理间距
                    Text("Home")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.primary) // Home 是选中状态，使用 primary 颜色
                        .frame(maxWidth: .infinity) // 均匀分布
                    Spacer() // Arrangement.SpaceBetween
                    Text("Plan")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)
                    Spacer() // Arrangement.SpaceBetween
                    Text("Profile")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)
                }
                .padding(.horizontal, AppTokens.Spacing.lg) // padding(horizontal = AppTokens.Spacing.lg)
                .frame(maxWidth: .infinity)
                .frame(height: bottomBarHeight) // 设置底部栏高度
                .background(AppTokens.Colors.surface) // containerColor
                // 模拟 tonalElevation，使用 shadow 修饰符
                .shadow(color: AppTokens.Colors.onBackground.opacity(AppTokens.ElevationMapping.level2.opacity),
                        radius: AppTokens.ElevationMapping.level2.radius,
                        y: AppTokens.ElevationMapping.level2.dy)
            }
            .frame(maxHeight: .infinity, alignment: .bottom) // 将底部栏对齐到 ZStack 的底部
            .ignoresSafeArea(.container, edges: .bottom) // 底部栏延伸至屏幕底部边缘

            // 4. 浮动操作按钮 (FAB) 层
            Button(action: {}) { // 对应 FloatingActionButton
                Text("+")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.onPrimary) // contentColor
                    .frame(width: fabSize, height: fabSize) // 尺寸
                    .background(AppTokens.Colors.primary) // containerColor
                    .clipShape(Circle()) // shape = CircleShape
            }
            // 定位 FAB：距离右侧 AppTokens.Spacing.lg，距离底部 (bottomBarHeight + AppTokens.Spacing.lg)
            // 这样 FAB 会在底部栏上方，并与屏幕边缘保持 AppTokens.Spacing.lg 的间距
            .padding(.trailing, AppTokens.Spacing.lg)
            .padding(.bottom, bottomBarHeight + AppTokens.Spacing.lg)
        }
        .background(AppTokens.Colors.background) // 整个 ZStack 的背景色
        .statusBarHidden(true) // 隐藏状态栏，实现全屏沉浸式效果
    }
}

// MARK: - App Entry Point
// 对应 Kotlin 的 MainActivity 和 AppTheme
@main
struct WorkoutPlanApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                // 再次确认隐藏状态栏，确保在整个应用生命周期内生效
                .statusBarHidden(true)
        }
    }
}

// 预览提供一个 Xcode Canvas 预览
struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}