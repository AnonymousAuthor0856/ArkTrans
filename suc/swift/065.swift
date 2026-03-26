import SwiftUI

// MARK: - AppTokens
// 翻译 Kotlin 的 AppTokens 对象到 Swift 结构体和扩展。
struct AppTokens {
    struct Colors {
        static let primary = Color(red: 17/255.0, green: 17/255.0, blue: 17/255.0)
        static let secondary = Color(red: 42/255.0, green: 42/255.0, blue: 42/255.0)
        static let tertiary = Color(red: 71/255.0, green: 71/255.0, blue: 71/255.0)
        static let background = Color(red: 246/255.0, green: 246/255.0, blue: 246/255.0)
        static let surface = Color(red: 255/255.0, green: 255/255.0, blue: 255/255.0)
        static let surfaceVariant = Color(red: 237/255.0, green: 237/255.0, blue: 237/255.0)
        static let outline = Color(red: 209/255.0, green: 209/255.0, blue: 209/255.0)
        static let success = Color(red: 46/255.0, green: 125/255.0, blue: 50/255.0)
        static let warning = Color(red: 185/255.0, green: 137/255.0, blue: 0/255.0)
        static let error = Color(red: 179/255.0, green: 38/255.0, blue: 30/255.0)
        static let onPrimary = Color(red: 255/255.0, green: 255/255.0, blue: 255/255.0)
        static let onSecondary = Color(red: 255/255.0, green: 255/255.0, blue: 255/255.0)
        static let onTertiary = Color(red: 255/255.0, green: 255/255.0, blue: 255/255.0)
        static let onBackground = Color(red: 10/255.0, green: 10/255.0, blue: 10/255.0)
        static let onSurface = Color(red: 10/255.0, green: 10/255.0, blue: 10/255.0)
    }

    struct TypographyTokens {
        // SwiftUI 的 lineHeight 和 letterSpacing 默认与系统字体匹配良好，
        // 对于自定义字体可以进一步微调，但对于系统字体，通常直接设置 size 和 weight 即可。
        static let display = Font.system(size: 28, weight: .semibold)
        static let headline = Font.system(size: 20, weight: .medium)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
        static let label = Font.system(size: 12, weight: .medium)
    }

    struct Shapes {
        static let small = RoundedCornerShape(cornerRadius: 8)
        static let medium = RoundedCornerShape(cornerRadius: 12)
        static let large = RoundedCornerShape(cornerRadius: 16)
    }

    struct Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 32
        static let xxxl: CGFloat = 48
    }

    struct ShadowSpec {
        let elevation: CGFloat // Compose 中的 elevation，SwiftUI 中通常用 radius 和 offset 模拟
        let radius: CGFloat // 阴影模糊半径
        let dy: CGFloat     // 阴影 Y 轴偏移
        let opacity: Double // 阴影不透明度
    }

    struct ElevationMapping {
        // 将 Compose 的 elevation 映射到 SwiftUI 的 shadow 参数
        static let level1 = ShadowSpec(elevation: 1, radius: 4, dy: 2, opacity: 0.10)
        static let level2 = ShadowSpec(elevation: 3, radius: 8, dy: 4, opacity: 0.14)
        static let level3 = ShadowSpec(elevation: 6, radius: 12, dy: 6, opacity: 0.16)
        static let level4 = ShadowSpec(elevation: 10, radius: 16, dy: 8, opacity: 0.18)
        static let level5 = ShadowSpec(elevation: 14, radius: 20, dy: 10, opacity: 0.20)
    }
}

// 自定义 Shape，用于模拟 Compose 的 RoundedCornerShape
struct RoundedCornerShape: Shape {
    var cornerRadius: CGFloat

    func path(in rect: CGRect) -> Path {
        Path(roundedRect: rect, cornerRadius: cornerRadius)
    }
}

// MARK: - AppTheme
// SwiftUI 没有直接的 MaterialTheme 等价物。
// 我们将使用 Environment 值来模拟颜色主题，以便在整个视图层级中访问。
struct AppColorScheme {
    let primary: Color
    let onPrimary: Color
    let secondary: Color
    let onSecondary: Color
    let tertiary: Color
    let onTertiary: Color
    let background: Color
    let onBackground: Color
    let surface: Color
    let onSurface: Color
    let surfaceVariant: Color
    let outline: Color
    let error: Color

    static let light = AppColorScheme(
        primary: AppTokens.Colors.primary,
        onPrimary: AppTokens.Colors.onPrimary,
        secondary: AppTokens.Colors.secondary,
        onSecondary: AppTokens.Colors.onSecondary,
        tertiary: AppTokens.Colors.tertiary,
        onTertiary: AppTokens.Colors.onTertiary,
        background: AppTokens.Colors.background,
        onBackground: AppTokens.Colors.onBackground,
        surface: AppTokens.Colors.surface,
        onSurface: AppTokens.Colors.onSurface,
        surfaceVariant: AppTokens.Colors.surfaceVariant,
        outline: AppTokens.Colors.outline,
        error: AppTokens.Colors.error
    )
}

// 定义一个 EnvironmentKey 来存储 AppColorScheme
private struct AppColorSchemeKey: EnvironmentKey {
    static let defaultValue: AppColorScheme = .light
}

extension EnvironmentValues {
    var appColorScheme: AppColorScheme {
        get { self[AppColorSchemeKey.self] }
        set { self[AppColorSchemeKey.self] = newValue }
    }
}

// 视图扩展，用于方便地应用主题
extension View {
    func appTheme() -> some View {
        self.environment(\.appColorScheme, .light)
    }
}

// MARK: - Data Models
// 翻译 Kotlin 的 AssetMarker 数据类
struct AssetMarker: Identifiable {
    let id: Int
    let name: String
    let type: String
    let x: CGFloat
    let y: CGFloat
}

// MARK: - RootScreen
struct RootScreen: View {
    @Environment(\.appColorScheme) var colorScheme

    @State private var categories: [String] = ["Warehouse", "Device", "Office"]
    @State private var enabledCats: [String] = ["Warehouse", "Device", "Office"]
    @State private var markers: [AssetMarker] = [
        AssetMarker(id: 1, name: "Main Warehouse", type: "Warehouse", x: 0.18, y: 0.34),
        AssetMarker(id: 2, name: "CNC-07", type: "Device", x: 0.52, y: 0.46),
        AssetMarker(id: 3, name: "HQ Office", type: "Office", x: 0.75, y: 0.62),
        AssetMarker(id: 4, name: "Spare Parts", type: "Warehouse", x: 0.33, y: 0.78)
    ]
    @State private var assetName: String = ""
    @State private var assetCode: String = ""
    @State private var assetType: String = "Device"
    @State private var selectedId: Int? = nil

    var body: some View {
        // Scaffold 等价物：一个 VStack 包含顶部栏、内容区和底部栏
        VStack(spacing: 0) {
            // 顶部栏 (CenterAlignedTopAppBar)
            ZStack {
                // 背景颜色延伸到安全区域顶部，模拟 Scaffold contentWindowInsets(0) 和 TopAppBar 的背景
                colorScheme.surface.ignoresSafeArea(.container, edges: .top)
                Text("Asset Inventory")
                    .font(AppTokens.TypographyTokens.display)
                    .foregroundColor(colorScheme.onSurface)
                    .padding(.vertical, 200) // 垂直内边距，帮助居中显示
            }
            .frame(height: 86) // 固定的顶部栏高度
            .background(colorScheme.surface) // 确保背景色填充

            // 主要内容区域
            // ScrollView 模拟 Compose 的 Column + Modifier.fillMaxSize() + padding
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppTokens.Spacing.lg) {
                    // Filter Chips (LazyRow)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: AppTokens.Spacing.sm) {
                            ForEach(categories, id: \.self) { c in
                                let isOn = enabledCats.contains(c)
                                Button(action: {
                                    if isOn {
                                        enabledCats.removeAll(where: { $0 == c })
                                    } else {
                                        enabledCats.append(c)
                                    }
                                }) {
                                    Text(c)
                                        .font(isOn ? AppTokens.TypographyTokens.title : AppTokens.TypographyTokens.body)
                                        .foregroundColor(isOn ? colorScheme.onPrimary : colorScheme.onSurface)
                                        .padding(.horizontal, AppTokens.Spacing.md)
                                        .padding(.vertical, AppTokens.Spacing.sm)
                                        .background(
                                            AppTokens.Shapes.small
                                                .fill(isOn ? colorScheme.primary : colorScheme.surface)
                                        )
                                        .overlay(
                                            AppTokens.Shapes.small
                                                .stroke(colorScheme.outline, lineWidth: 1)
                                        )
                                }
                                .buttonStyle(PlainButtonStyle()) // 移除 SwiftUI 默认按钮样式
                            }
                        }
                    }
                    .padding(.horizontal, AppTokens.Spacing.lg)
                    .padding(.top, AppTokens.Spacing.md) // 整个内容列的顶部内边距

                    // 资产详情和地图 (Row)
                    HStack(alignment: .top, spacing: AppTokens.Spacing.lg) {
                        // 左侧资产输入和选中卡片 (Column)
                        VStack(spacing: AppTokens.Spacing.md) {
                            TextField("Asset Name", text: $assetName)
                                .textFieldStyle(AppTextFieldStyle(colorScheme: colorScheme))
                            TextField("Asset Code", text: $assetCode)
                                .textFieldStyle(AppTextFieldStyle(colorScheme: colorScheme))
                            TextField("Asset Type", text: $assetType)
                                .textFieldStyle(AppTextFieldStyle(colorScheme: colorScheme))

                            // Selected Asset Card (Card)
                            VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
                                Text("Selected")
                                    .font(AppTokens.TypographyTokens.label)
                                    .foregroundColor(colorScheme.onSurface)
                                Text(selectedId.flatMap { id in markers.first(where: { $0.id == id })?.name } ?? "None")
                                    .font(AppTokens.TypographyTokens.headline)
                                    .foregroundColor(colorScheme.onSurface)
                            }
                            .padding(AppTokens.Spacing.lg)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                AppTokens.Shapes.large
                                    .fill(colorScheme.surface)
                                    .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity), radius: AppTokens.ElevationMapping.level1.radius, x: 0, y: AppTokens.ElevationMapping.level1.dy)
                                    .overlay(AppTokens.Shapes.large.stroke(colorScheme.outline, lineWidth: 1))
                            )
                        }
                        .frame(maxWidth: .infinity) // 模拟 Modifier.weight(1f)

                        // 地图区域 (BoxWithConstraints)
                        GeometryReader { geometry in
                            ZStack(alignment: .topLeading) {
                                MapGridOverlay() // 网格叠加层
                                ForEach(markers.filter { enabledCats.contains($0.type) }) { m in
                                    MapMarker(
                                        type: m.type,
                                        selected: selectedId == m.id,
                                        onClick: { selectedId = (selectedId == m.id) ? nil : m.id },
                                        colorScheme: colorScheme
                                    )
                                    // 根据 GeometryReader 的尺寸和 marker 的相对坐标进行偏移
                                    .offset(x: geometry.size.width * m.x, y: geometry.size.height * m.y)
                                }
                            }
                        }
                        .frame(minHeight: 360) // 模拟 heightIn(min = 360.dp)
                        .aspectRatio(0.9, contentMode: .fit) // 模拟 aspectRatio(0.9f)
                        .background(
                            AppTokens.Shapes.large
                                .fill(AppTokens.Colors.surface)
                                .overlay(AppTokens.Shapes.large.stroke(AppTokens.Colors.outline, lineWidth: 1))
                        )
                        .frame(maxWidth: .infinity) // 模拟 Modifier.weight(1f)
                    }
                    .padding(.horizontal, AppTokens.Spacing.lg)
                }
            }
            .background(colorScheme.background) // 主内容区的背景色
            .padding(.bottom, AppTokens.Spacing.md) // 整个内容列的底部内边距

            // 底部栏 (BottomBar - Surface)
            VStack(spacing: 0) {
                // 模拟 Compose 的 tonalElevation 阴影，从底部向上投射
                Rectangle()
                    .fill(colorScheme.surface) // 阴影的背景色，实际高度为0，只为承载阴影
                    .frame(height: 0)
                    .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity), radius: AppTokens.ElevationMapping.level2.radius, x: 0, y: -AppTokens.ElevationMapping.level2.dy) // 负 dy 使阴影向上

                HStack(spacing: AppTokens.Spacing.md) {
                    // Reset 按钮
                    Button(action: {
                        assetName = ""
                        assetCode = ""
                        assetType = "Device"
                        selectedId = nil
                    }) {
                        Text("Reset")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(colorScheme.onSurface)
                            .frame(maxWidth: .infinity) // 模拟 weight(1f)
                            .frame(height: 48) // 模拟 height(48.dp)
                            .background(
                                AppTokens.Shapes.medium
                                    .fill(colorScheme.surfaceVariant)
                            )
                    }
                    .buttonStyle(PlainButtonStyle())

                    // Save Asset 按钮
                    Button(action: {
                        // 保存资产逻辑
                    }) {
                        Text("Save Asset")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(colorScheme.onPrimary)
                            .frame(maxWidth: .infinity) // 模拟 weight(1f)
                            .frame(height: 48) // 模拟 height(48.dp)
                            .background(
                                AppTokens.Shapes.medium
                                    .fill(colorScheme.primary)
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, AppTokens.Spacing.lg)
                .padding(.vertical, AppTokens.Spacing.md)
                .background(colorScheme.surface) // 底部栏背景色
            }
        }
        .background(colorScheme.background.ignoresSafeArea()) // 确保整个屏幕背景色填充，包括安全区域
        .ignoresSafeArea(.keyboard, edges: .bottom) // 键盘弹出时，不挤压内容
    }
}

// MARK: - Custom TextFieldStyle
// 自定义 TextField 样式以匹配 Material3 TextField 的外观
struct AppTextFieldStyle: TextFieldStyle {
    var colorScheme: AppColorScheme

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, AppTokens.Spacing.md)
            .padding(.vertical, AppTokens.Spacing.sm)
            .background(
                RoundedRectangle(cornerRadius: AppTokens.Shapes.small.cornerRadius)
                    .fill(colorScheme.surfaceVariant)
            )
            .overlay(
                RoundedRectangle(cornerRadius: AppTokens.Shapes.small.cornerRadius)
                    .stroke(colorScheme.outline, lineWidth: 1)
            )
            .font(AppTokens.TypographyTokens.body)
            .foregroundColor(colorScheme.onSurface)
    }
}

// MARK: - MapMarker
// 翻译 Kotlin 的 MapMarker Composable
struct MapMarker: View {
    let type: String
    let selected: Bool
    let onClick: () -> Void
    var colorScheme: AppColorScheme

    var body: some View {
        // ZStack 用于叠加圆形标记和文本卡片
        ZStack(alignment: .topLeading) {
            let markerColor = { () -> Color in
                switch type {
                case "Warehouse": return AppTokens.Colors.tertiary
                case "Device": return AppTokens.Colors.secondary
                default: return AppTokens.Colors.primary
                }
            }()

            Circle()
                .fill(markerColor)
                .frame(width: selected ? 28 : 22, height: selected ? 28 : 22) // 模拟 size(if (selected) 28.dp else 22.dp)
                .overlay(
                    Circle()
                        .stroke(selected ? AppTokens.Colors.primary : AppTokens.Colors.surface, lineWidth: 2) // 模拟 border(2.dp, ...)
                )

            // 文本卡片
            Button(action: onClick) {
                Text(type)
                    .font(AppTokens.TypographyTokens.label)
                    .foregroundColor(colorScheme.onSurface)
                    .padding(.horizontal, AppTokens.Spacing.sm)
                    .padding(.vertical, AppTokens.Spacing.xs)
                    .background(
                        AppTokens.Shapes.small
                            .fill(colorScheme.surface)
                            .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity), radius: AppTokens.ElevationMapping.level1.radius, x: 0, y: AppTokens.ElevationMapping.level1.dy)
                            .overlay(AppTokens.Shapes.small.stroke(colorScheme.outline, lineWidth: 1))
                    )
            }
            .buttonStyle(PlainButtonStyle())
            .offset(x: 18, y: -4) // 模拟 offset(x = 18.dp, y = (-4).dp)
        }
    }
}

// MARK: - MapGridOverlay
// 翻译 Kotlin 的 MapGridOverlay Composable
struct MapGridOverlay: View {
    @Environment(\.appColorScheme) var colorScheme

    var body: some View {
        ZStack {
            // 垂直线
            VStack(spacing: 0) {
                ForEach(0..<6) { _ in
                    Rectangle()
                        .fill(AppTokens.Colors.surfaceVariant)
                        .frame(height: 1)
                    Spacer() // 模拟 SpaceEvenly
                }
                Rectangle() // 绘制最后一条线
                    .fill(AppTokens.Colors.surfaceVariant)
                    .frame(height: 1)
            }
            .padding(AppTokens.Spacing.lg)

            // 水平线
            HStack(spacing: 0) {
                ForEach(0..<6) { _ in
                    Rectangle()
                        .fill(AppTokens.Colors.surfaceVariant)
                        .frame(width: 1)
                    Spacer() // 模拟 SpaceEvenly
                }
                Rectangle() // 绘制最后一条线
                    .fill(AppTokens.Colors.surfaceVariant)
                    .frame(width: 1)
            }
            .padding(AppTokens.Spacing.lg)
        }
    }
}

// MARK: - App Entry Point
// Swift UI 的应用程序入口点，包含 @main
@main
struct SingleFileUIApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                .appTheme() // 应用自定义主题
                .statusBarHidden(true) // 隐藏状态栏，满足全屏显示要求
        }
    }
}
