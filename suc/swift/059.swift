import SwiftUI

// MARK: - AppTokens
// 翻译自 Kotlin 的 AppTokens 对象，用于定义颜色、字体、形状、间距和阴影。
struct AppTokens {
    struct Colors {
        // 将 Kotlin 的 Color(0xFF...) 转换为 SwiftUI 的 Color(red:green:blue:)
        static let primary = Color(red: 17/255, green: 24/255, blue: 39/255) // 0xFF111827
        static let secondary = Color(red: 55/255, green: 65/255, blue: 81/255) // 0xFF374151
        static let tertiary = Color(red: 107/255, green: 114/255, blue: 128/255) // 0xFF6B7280
        static let background = Color(red: 249/255, green: 250/255, blue: 251/255) // 0xFFF9FAFB
        static let surface = Color(red: 255/255, green: 255/255, blue: 255/255) // 0xFFFFFFFF
        static let surfaceVariant = Color(red: 229/255, green: 231/255, blue: 235/255) // 0xFFE5E7EB
        static let outline = Color(red: 209/255, green: 213/255, blue: 219/255) // 0xFFD1D5DB
        static let success = Color(red: 22/255, green: 163/255, blue: 74/255) // 0xFF16A34A
        static let warning = Color(red: 245/255, green: 158/255, blue: 11/255) // 0xFFF59E0B
        static let error = Color(red: 239/255, green: 68/255, blue: 68/255) // 0xFFEF4444
        static let onPrimary = Color(red: 255/255, green: 255/255, blue: 255/255) // 0xFFFFFFFF
        static let onSecondary = Color(red: 255/255, green: 255/255, blue: 255/255) // 0xFFFFFFFF
        static let onTertiary = Color(red: 17/255, green: 24/255, blue: 39/255) // 0xFF111827
        static let onBackground = Color(red: 17/255, green: 24/255, blue: 39/255) // 0xFF111827
        static let onSurface = Color(red: 31/255, green: 41/255, blue: 55/255) // 0xFF1F2937
    }

    struct TypographyTokens {
        // Compose 的 sp 单位直接映射为 SwiftUI 的 CGFloat 字体大小
        static let displayLarge = Font.system(size: 28, weight: .bold)
        static let headlineMedium = Font.system(size: 20, weight: .semibold)
        static let titleMedium = Font.system(size: 16, weight: .medium)
        static let bodyMedium = Font.system(size: 14, weight: .regular)
        static let labelMedium = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        // Compose 的 dp 单位直接映射为 SwiftUI 的 CGFloat 圆角半径
        static let small = 8.0
        static let medium = 12.0
        static let large = 16.0
    }

    struct Spacing {
        // Compose 的 dp 单位直接映射为 SwiftUI 的 CGFloat 间距
        static let xs = 4.0
        static let sm = 8.0
        static let md = 12.0
        static let lg = 16.0
        static let xl = 24.0
        static let xxl = 36.0
    }

    struct ShadowSpec {
        let elevation: CGFloat // 阴影扩散程度，在 SwiftUI 中通常与 radius 结合
        let radius: CGFloat    // 阴影模糊半径
        let dy: CGFloat        // 阴影 Y 轴偏移
        let opacity: Double    // 阴影不透明度
    }

    struct ElevationMapping {
        // 阴影参数的映射
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 4, radius: 8, dy: 4, opacity: 0.14)
        static let level3 = ShadowSpec(elevation: 8, radius: 12, dy: 6, opacity: 0.16)
    }
}

// MARK: - Data Model
// 翻译自 Kotlin 的 data class Medicine
struct Medicine: Identifiable {
    let id: Int
    let name: String
    let time: String
}

// MARK: - MedicineItem View
// 翻译自 Kotlin 的 @Composable fun MedicineItem
struct MedicineItem: View {
    let medicine: Medicine

    var body: some View {
        HStack(alignment: .center) { // horizontalArrangement = Arrangement.SpaceBetween, verticalAlignment = Alignment.CenterVertically
            VStack(alignment: .leading, spacing: AppTokens.Spacing.xs) { // verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)
                Text(medicine.name)
                    .font(AppTokens.TypographyTokens.titleMedium)
                    .foregroundColor(AppTokens.Colors.onSurface)
                Text(medicine.time)
                    .font(AppTokens.TypographyTokens.bodyMedium)
                    .foregroundColor(AppTokens.Colors.onSurface)
            }
            Spacer() // 实现 Arrangement.SpaceBetween
            Circle()
                .fill(AppTokens.Colors.primary)
                .frame(width: 16, height: 16) // size(16.dp)
        }
        .padding(AppTokens.Spacing.md) // padding(AppTokens.Spacing.md)
        .background(AppTokens.Colors.surface) // background(AppTokens.Colors.surface)
        .cornerRadius(AppTokens.Shapes.medium) // shape = AppTokens.Shapes.medium
        .overlay( // border(1.dp, AppTokens.Colors.outline, AppTokens.Shapes.medium)
            RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                .stroke(AppTokens.Colors.outline, lineWidth: 1)
        )
        .frame(maxWidth: .infinity) // fillMaxWidth()
    }
}

// MARK: - MedicineList View
// 翻译自 Kotlin 的 @Composable fun MedicineList
struct MedicineList: View {
    let items = [
        Medicine(id: 1, name: "Vitamin C", time: "08:00 AM"),
        Medicine(id: 2, name: "Aspirin", time: "12:30 PM"),
        Medicine(id: 3, name: "Insulin", time: "06:00 PM"),
        Medicine(id: 4, name: "Melatonin", time: "10:00 PM")
    ]

    var body: some View {
        // 使用 ScrollView + VStack 来精确控制间距和布局，类似于 LazyColumn with spacedBy
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: AppTokens.Spacing.md) { // verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
                ForEach(items) { m in
                    MedicineItem(medicine: m)
                }
            }
            .padding(.bottom, AppTokens.Spacing.xxl) // contentPadding = PaddingValues(bottom = AppTokens.Spacing.xxl)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // fillMaxSize()
    }
}

// MARK: - RootScreen View
// 翻译自 Kotlin 的 @Composable fun RootScreen
struct RootScreen: View {
    var body: some View {
        // ZStack 用于将 FAB 和 BottomAppBar 叠加在主内容之上
        ZStack(alignment: .bottomTrailing) { // 用于定位 FloatingActionButton
            VStack(spacing: 0) { // 主内容区域，模拟 Scaffold 的内容部分
                // 顶部区域，包含标题和列表，带有渐变背景
                VStack(spacing: AppTokens.Spacing.md) { // 对应 Kotlin 的 Column
                    Text("Medicine Reminder")
                        .font(AppTokens.TypographyTokens.displayLarge)
                        .foregroundColor(AppTokens.Colors.onBackground)

                    MedicineList()

                    Spacer() // Pushes the button to the bottom of this VStack

                    Button(action: {}) {
                        Text("Mark All Taken")
                            .font(AppTokens.TypographyTokens.titleMedium)
                            .foregroundColor(AppTokens.Colors.onSecondary)
                            .frame(height: 48) // height(48.dp)
                            .frame(maxWidth: .infinity) // 填充父视图的可用宽度
                            .background(AppTokens.Colors.secondary) // containerColor
                            .cornerRadius(AppTokens.Shapes.large) // shape
                    }
                    // fillMaxWidth(0.8f) 的实现：在父视图已应用水平 padding 的情况下，
                    // 按钮占据父视图内容区域的 80%，即左右各留 10% 的 padding。
                    // 父视图的水平 padding 是 AppTokens.Spacing.lg。
                    // 所以父视图内容区域宽度 = 屏幕宽度 - 2 * AppTokens.Spacing.lg。
                    // 按钮左右各需要 (父视图内容区域宽度 * 0.2) / 2 的 padding。
                    .padding(.horizontal, (UIScreen.main.bounds.width - 2 * AppTokens.Spacing.lg) * 0.1)
                    .padding(.bottom, AppTokens.Spacing.md) // 对应 Spacer(modifier = Modifier.height(AppTokens.Spacing.md))
                }
                .padding(.top, AppTokens.Spacing.lg) // 对应 Column 的 .padding(AppTokens.Spacing.lg)
                .padding(.horizontal, AppTokens.Spacing.lg) // 对应 Column 的 .padding(AppTokens.Spacing.lg)
                .background(
                    LinearGradient( // Brush.verticalGradient
                        gradient: Gradient(colors: [AppTokens.Colors.surfaceVariant, AppTokens.Colors.surface]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity) // fillMaxSize()
                .ignoresSafeArea(.keyboard, edges: .bottom) // 防止键盘推出内容
                // 为 BottomAppBar 预留底部空间，避免内容被遮挡
                .padding(.bottom, 56) // BottomAppBar 默认高度为 56dp
            }
            .background(AppTokens.Colors.background) // Scaffold 的 containerColor
            .ignoresSafeArea(.all, edges: .top) // 内容延伸到状态栏区域

            // BottomAppBar
            VStack { // 使用 VStack 配合 Spacer 将 BottomAppBar 推到底部
                Spacer()
                HStack(alignment: .center) { // horizontalArrangement = Arrangement.SpaceBetween, verticalAlignment = Alignment.CenterVertically
                    Text("Today")
                        .font(AppTokens.TypographyTokens.titleMedium)
                        .foregroundColor(AppTokens.Colors.primary) // primary color for selected item
                    Spacer()
                    Text("History")
                        .font(AppTokens.TypographyTokens.titleMedium)
                        .foregroundColor(AppTokens.Colors.onSurface)
                    Spacer()
                    Text("Profile")
                        .font(AppTokens.TypographyTokens.titleMedium)
                        .foregroundColor(AppTokens.Colors.onSurface)
                }
                .padding(.horizontal, AppTokens.Spacing.lg) // padding(horizontal = AppTokens.Spacing.lg)
                .frame(maxWidth: .infinity) // fillMaxWidth()
                .frame(height: 56) // BottomAppBar 默认高度
                .background(AppTokens.Colors.surface) // containerColor
                .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity),
                        radius: AppTokens.ElevationMapping.level2.radius,
                        x: 0,
                        y: AppTokens.ElevationMapping.level2.dy) // tonalElevation 转换为 shadow
            }
            .ignoresSafeArea(.all, edges: .bottom) // BottomAppBar 延伸到屏幕底部边缘

            // FloatingActionButton
            Button(action: {}) {
                Text("+")
                    .font(AppTokens.TypographyTokens.displayLarge)
                    .foregroundColor(AppTokens.Colors.onPrimary)
                    .frame(width: 56, height: 56) // 默认 FAB 大小
                    .background(AppTokens.Colors.primary) // containerColor
                    .clipShape(Circle()) // shape = CircleShape
            }
            .padding(AppTokens.Spacing.lg) // 定位 FAB，提供默认的间距
        }
        .statusBarHidden(true) // 隐藏状态栏，满足全屏显示要求
    }
}

// MARK: - App Entry Point
// 应用程序的入口点，SwiftUI 应用程序必须包含 @main
@main
struct MedicineReminderApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}
