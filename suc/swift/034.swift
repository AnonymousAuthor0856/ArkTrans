
import SwiftUI

// MARK: - AppTokens
// 严格对应 Kotlin 中的 AppTokens 定义，使用 CGFloat 替代 Dp，使用 Swift 的 Color 和 Font
struct AppTokens {
    struct Colors {
        static let primary = Color(hex: 0x00FF66)
        static let secondary = Color(hex: 0xCCCCCC)
        static let tertiary = Color(hex: 0x999999)
        static let background = Color(hex: 0x000000)
        static let surface = Color(hex: 0x0A0A0A)
        static let surfaceVariant = Color(hex: 0x111111)
        static let outline = Color(hex: 0x1F1F1F)
        static let success = Color(hex: 0x16A34A)
        static let warning = Color(hex: 0xF59E0B)
        static let error = Color(hex: 0xFF4444)
        static let onPrimary = Color(hex: 0x000000)
        static let onSecondary = Color(hex: 0xFFFFFFFF)
        static let onTertiary = Color(hex: 0xFFFFFFFF)
        static let onBackground = Color(hex: 0xE0E0E0)
        static let onSurface = Color(hex: 0xE0E0E0)
    }

    struct TypographyTokens {
        static let display = Font.system(size: 28, weight: .bold)
        static let headline = Font.system(size: 20, weight: .medium)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 13, weight: .regular) // Normal -> regular
        static let label = Font.system(size: 11, weight: .medium)
    }

    struct Shapes {
        static let small: CGFloat = 6
        static let medium: CGFloat = 10
        static let large: CGFloat = 14
    }

    struct Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 32
    }

    struct ShadowSpec {
        // Kotlin elevation is 0.dp, radius 4.dp, dy 2.dp, opacity 0.12f
        // SwiftUI shadow takes radius (blur), x/y offset, and opacity.
        // Mapping Compose radius to SwiftUI blur radius, Compose dy to SwiftUI y offset.
        let radius: CGFloat // Blur radius
        let y: CGFloat      // Y offset
        let opacity: Double
    }

    struct ElevationMapping {
        static let level1 = ShadowSpec(radius: 0, y: 0, opacity: 0)
        // Kotlin: elevation = 2.dp, radius = 4.dp, dy = 2.dp, opacity = 0.12f
        static let level2 = ShadowSpec(radius: 4, y: 2, opacity: 0.12)
    }
}

// MARK: - Color Extension for Hex Initialization
// 方便地从十六进制值创建 Color
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

// MARK: - Data Model
// 对应 Kotlin 的 MapMarker data class
struct MapMarker: Identifiable {
    let id = UUID() // SwiftUI ForEach 需要 Identifiable
    let name: String
    let distance: String
}

// MARK: - RootScreen View
struct RootScreen: View {
    @State private var query: String = ""
    @FocusState private var isSearchFieldFocused: Bool // 用于 OutlinedTextField 的焦点状态

    // 对应 Kotlin 中的 markers 列表
    let markers = [
        MapMarker(name: "Central Plaza", distance: "1.2 km"),
        MapMarker(name: "Museum District", distance: "3.4 km"),
        MapMarker(name: "Tech Park", distance: "5.6 km"),
        MapMarker(name: "Old Town Gate", distance: "7.8 km")
    ]

    var body: some View {
        ZStack { // 使用 ZStack 作为根容器，以便设置背景色并忽略安全区
            AppTokens.Colors.background
                .ignoresSafeArea() // 确保背景色覆盖整个屏幕，包括安全区

            VStack(spacing: 0) { // 主 VStack 布局，spacing: 0 避免 VStack 自身添加间距
                // Top Bar (对应 Kotlin 的 CenterAlignedTopAppBar)
                Text("Explore Map")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(AppTokens.Colors.primary)
                    .frame(maxWidth: .infinity) // 填充宽度
                    .padding(.vertical, AppTokens.Spacing.lg) // 垂直内边距，模拟 TopAppBar 默认高度
                    .background(AppTokens.Colors.background)

                // 主内容区域
                VStack(spacing: AppTokens.Spacing.lg) { // 对应 Kotlin Column 的 verticalArrangement.spacedBy(AppTokens.Spacing.lg)
                    // Search Field (对应 Kotlin 的 OutlinedTextField)
                    TextField("Search destination", text: $query)
                        .focused($isSearchFieldFocused) // 绑定焦点状态
                        .font(AppTokens.TypographyTokens.body) // 文本和占位符字体
                        .foregroundColor(AppTokens.Colors.onSurface) // 文本颜色
                        .accentColor(AppTokens.Colors.primary) // 光标颜色
                        .padding(AppTokens.Spacing.md) // 内部文本内边距
                        .background(AppTokens.Colors.surfaceVariant) // 对应 Kotlin OutlinedTextField 的背景色
                        .cornerRadius(AppTokens.Shapes.medium) // 圆角
                        .overlay( // 边框
                            RoundedRectangle(cornerRadius: AppTokens.Shapes.medium)
                                .stroke(isSearchFieldFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline, lineWidth: 1)
                        )
                        .frame(maxWidth: .infinity) // 填充宽度

                    // Markers List (对应 Kotlin 的 Column 包含 Card 列表)
                    VStack(spacing: AppTokens.Spacing.md) { // 对应 Kotlin Column 的 verticalArrangement.spacedBy(AppTokens.Spacing.md)
                        ForEach(markers) { marker in
                            CardView(marker: marker)
                        }
                    }
                    .frame(maxWidth: .infinity) // 填充宽度

                    Spacer() // 将底部的按钮推到底部

                    // Refresh Map Button (对应 Kotlin 的 Button)
                    Button(action: {
                        // 处理刷新地图操作
                        print("Refresh Map Tapped")
                    }) {
                        Text("Refresh Map")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.onPrimary)
                            .frame(maxWidth: .infinity) // 填充宽度
                            .frame(height: 48) // 固定高度
                            .background(AppTokens.Colors.primary)
                            .cornerRadius(AppTokens.Shapes.large) // 圆角
                    }
                }
                .padding(AppTokens.Spacing.lg) // 对应 Kotlin Column 的 .padding(AppTokens.Spacing.lg)
            }
        }
        .statusBarHidden(true) // 隐藏顶部状态栏，满足全屏要求
    }
}

// MARK: - CardView
// 对应 Kotlin 中的 Card 及其内容
struct CardView: View {
    let marker: MapMarker

    var body: some View {
        HStack(alignment: .center, spacing: 0) { // 对应 Kotlin Row 的 horizontalArrangement.SpaceBetween 和 verticalAlignment.CenterVertically
            VStack(alignment: .leading, spacing: 0) { // 对应 Kotlin Column
                Text(marker.name)
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.onSurface)
                Text(marker.distance)
                    .font(AppTokens.TypographyTokens.body)
                    .foregroundColor(AppTokens.Colors.secondary)
            }
            Spacer() // 将按钮推到右侧
            Button(action: {
                // 处理 View 按钮操作
                print("View \(marker.name) Tapped")
            }) {
                Text("View")
                    .font(AppTokens.TypographyTokens.label)
                    .foregroundColor(AppTokens.Colors.onPrimary)
                    // 按钮内部填充，模拟 Compose Button 的默认填充
                    .padding(.horizontal, AppTokens.Spacing.md)
                    .padding(.vertical, AppTokens.Spacing.xs)
                    .background(AppTokens.Colors.primary)
                    .cornerRadius(AppTokens.Shapes.small)
            }
        }
        .padding(AppTokens.Spacing.md) // 对应 Kotlin Card 内部的 .padding(AppTokens.Spacing.md)
        .background(AppTokens.Colors.surface) // 对应 Kotlin Card 的 containerColor
        .cornerRadius(AppTokens.Shapes.medium) // 圆角
        .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity), // 阴影颜色和透明度
                radius: AppTokens.ElevationMapping.level2.radius, // 阴影模糊半径
                y: AppTokens.ElevationMapping.level2.y) // 阴影 Y 轴偏移
        .frame(maxWidth: .infinity) // 填充宽度
    }
}

// MARK: - App Entry Point
// 对应 Kotlin 的 MainActivity 和 setContent
@main
struct SingleFileUIApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}
