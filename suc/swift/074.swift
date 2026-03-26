import SwiftUI

// MARK: - AppTokens
// 翻译自 Kotlin 的 AppTokens 对象，用于定义颜色、字体、间距、形状和阴影。
// 这种结构使得修改 UI 比例和控件大小变得非常方便。
struct AppTokens {

    struct Colors {
        // 使用 UInt 构造器，方便直接从 Kotlin 的 0xFF... 格式转换
        static let primary = Color(hex: 0xFFD95F02)
        static let secondary = Color(hex: 0xFF1B9AAA)
        static let tertiary = Color(hex: 0xFFFEC601)
        static let background = Color(hex: 0xFFF9F4EB)
        static let surface = Color(hex: 0xFFFFFFFF)
        static let surfaceVariant = Color(hex: 0xFFF0E3D1)
        static let outline = Color(hex: 0xFFE1CDB2)
        static let success = Color(hex: 0xFF56C271)
        static let warning = Color(hex: 0xFFF4A259)
        static let error = Color(hex: 0xFFD7263D)
        static let onPrimary = Color(hex: 0xFF1B1B1B)
        static let onSecondary = Color(hex: 0xFF041012)
        static let onTertiary = Color(hex: 0xFF1E1200)
        static let onBackground = Color(hex: 0xFF2C2A29)
        static let onSurface = Color(hex: 0xFF2E2924)
    }

    struct TypographyTokens {
        // SwiftUI 的 Font.system 提供了 size 和 weight。
        // lineHeight (行高) 和 letterSpacing (字间距/kerning) 在 SwiftUI 中需要通过 Text 修饰符单独处理。
        // 由于 Kotlin 代码中的 letterSpacing 均为 0，我们主要关注 size 和 weight。
        // lineHeight 在 SwiftUI 中通常通过默认行为或 lineSpacing() 修饰符处理，但对于单行文本，它通常由字体大小决定。
        static let display = Font.system(size: 28, weight: .semibold)
        static let headline = Font.system(size: 20, weight: .semibold)
        static let title = Font.system(size: 16, weight: .medium)
        static let body = Font.system(size: 13, weight: .regular)
        static let label = Font.system(size: 11, weight: .medium)
    }

    struct Shapes {
        // 圆角半径直接映射为 CGFloat
        static let small = CGFloat(12)
        static let medium = CGFloat(16)
        static let large = CGFloat(20)
    }

    struct Spacing {
        // 间距直接映射为 CGFloat
        static let xs = CGFloat(4)
        static let sm = CGFloat(8)
        static let md = CGFloat(12)
        static let lg = CGFloat(16)
        static let xl = CGFloat(20)
        static let xxl = CGFloat(28)
        static let xxxl = CGFloat(40)
    }

    // 阴影规格结构体
    struct ShadowSpec {
        let elevation: CGFloat // 在 SwiftUI 中通常映射为 shadow 的 radius 或 y 偏移的强度
        let radius: CGFloat    // 阴影的模糊半径
        let dy: CGFloat        // 阴影的 Y 轴偏移
        let opacity: Double    // 阴影的透明度
    }

    struct ElevationMapping {
        // 阴影映射，根据 Kotlin 定义进行转换
        static let level1 = ShadowSpec(elevation: 2, radius: 4, dy: 2, opacity: 0.12)
        static let level2 = ShadowSpec(elevation: 4, radius: 8, dy: 4, opacity: 0.16)
        static let level3 = ShadowSpec(elevation: 8, radius: 12, dy: 6, opacity: 0.2)
        static let level4 = ShadowSpec(elevation: 12, radius: 16, dy: 8, opacity: 0.24)
        static let level5 = ShadowSpec(elevation: 16, radius: 20, dy: 10, opacity: 0.28)
    }
}

// MARK: - Color Hex Extension
// 方便从十六进制整数创建 SwiftUI 颜色
extension Color {
    init(hex: UInt) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: Double((hex >> 24) & 0xFF) == 0 ? 1.0 : Double((hex >> 24) & 0xFF) / 255.0 // 如果没有alpha值，默认为1.0
        )
    }
}

// MARK: - Data Models
// 翻译自 Kotlin 的 Zone 数据类
struct Zone: Identifiable {
    let id = UUID() // SwiftUI ForEach 需要 Identifiable 协议
    let name: String
    let humidity: Float
    let temp: String
}

// MARK: - Reusable Components
// 翻译自 Kotlin 的 StatusRow Composable
struct StatusRow: View {
    let label: String
    let value: Float
    let accent: Color

    var body: some View {
        VStack(alignment: .leading, spacing: AppTokens.Spacing.xs) {
            HStack {
                Text(label)
                    .font(AppTokens.TypographyTokens.body)
                    .foregroundColor(AppTokens.Colors.onSurface)
                Spacer()
                Text("\(Int(value * 100))%")
                    .font(AppTokens.TypographyTokens.label)
                    .foregroundColor(accent)
            }
            // 线性进度条，近似 Compose 的 LinearProgressIndicator
            ProgressView(value: value)
                .tint(accent) // 进度条颜色
                .background(AppTokens.Colors.surface) // 轨道颜色
                .frame(height: 4) // 近似 Compose 进度条高度
                .cornerRadius(2) // 进度条圆角
        }
    }
}

// 翻译自 Kotlin 的 ZoneRow Composable
struct ZoneRow: View {
    let zone: Zone

    var body: some View {
        VStack(alignment: .leading, spacing: AppTokens.Spacing.xs) {
            HStack {
                Text(zone.name)
                    .font(AppTokens.TypographyTokens.title)
                    .foregroundColor(AppTokens.Colors.onSurface)
                Spacer()
                Text(zone.temp)
                    .font(AppTokens.TypographyTokens.label)
                    .foregroundColor(AppTokens.Colors.primary)
            }
            // 线性进度条，近似 Compose 的 LinearProgressIndicator
            ProgressView(value: zone.humidity)
                .tint(AppTokens.Colors.secondary)
                .background(AppTokens.Colors.surface) // 轨道颜色
                .frame(height: 4) // 近似 Compose 进度条高度
                .cornerRadius(2) // 进度条圆角
        }
        .padding(AppTokens.Spacing.sm)
        .background(AppTokens.Colors.surfaceVariant.opacity(0.5)) // 背景色和透明度
        .cornerRadius(AppTokens.Shapes.small) // 圆角
    }
}

// MARK: - Main Screen
// 翻译自 Kotlin 的 RootScreen Composable
struct RootScreen: View {
    // 使用 @State 存储可变状态，对应 Kotlin 的 remember { mutableStateOf(...) }
    @State private var activeMode: String = "Orbit"
    @State private var solarLevel: Float = 0.6
    @State private var ambientGlow: Float = 0.35

    let modes = ["Orbit", "Eclipse", "Manual"]
    let zones = [
        Zone(name: "Atrium", humidity: 0.45, temp: "72°F"),
        Zone(name: "Lab East", humidity: 0.62, temp: "68°F"),
        Zone(name: "Hab Deck", humidity: 0.30, temp: "70°F")
    ]

    var body: some View {
        // ZStack 用于将背景色铺满整个屏幕，并允许内容忽略安全区域
        ZStack {
            AppTokens.Colors.background.ignoresSafeArea(.all) // 设置整个屏幕的背景色

            // 主 VStack 结构，对应 Kotlin 的 Scaffold，包含顶部栏、可滚动内容和底部栏
            VStack(spacing: 0) {
                // MARK: 顶部栏 (Top Bar)
                // 对应 Kotlin 的 CenterAlignedTopAppBar
                HStack {
                    Button {
                        // "Dock" 按钮点击事件
                    } label: {
                        Text("Dock")
                            .font(AppTokens.TypographyTokens.label)
                            .foregroundColor(AppTokens.Colors.onSurface)
                    }
                    Spacer() // 居中标题
                    Text("Smart Orbit Panel")
                        .font(AppTokens.TypographyTokens.title)
                        .foregroundColor(AppTokens.Colors.onSurface)
                    Spacer() // 居中标题
                    Button {
                        // "Alerts" 按钮点击事件
                    } label: {
                        Text("Alerts")
                            .font(AppTokens.TypographyTokens.label)
                            .foregroundColor(AppTokens.Colors.secondary)
                    }
                }
                .padding(.horizontal, AppTokens.Spacing.lg) // 水平内边距
                .frame(height: 56) // 近似 Material3 TopAppBar 的标准高度
                .background(AppTokens.Colors.surface) // 背景色
                // Kotlin 代码中 TopAppBar 没有明确的阴影，因此这里不添加

                // MARK: 可滚动内容区域 (Scrollable Content)
                // 对应 Kotlin 的 Column.verticalScroll
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: AppTokens.Spacing.md) {
                        // 模式选择芯片 (Filter Chips)
                        HStack(spacing: AppTokens.Spacing.sm) {
                            ForEach(modes, id: \.self) { mode in
                                Button {
                                    activeMode = mode
                                } label: {
                                    Text(mode)
                                        .font(AppTokens.TypographyTokens.label)
                                        .foregroundColor(AppTokens.Colors.onSurface)
                                        .padding(.horizontal, AppTokens.Spacing.md) // 芯片内部文本的水平内边距
                                        .padding(.vertical, AppTokens.Spacing.sm)   // 芯片内部文本的垂直内边距
                                        .background(
                                            RoundedRectangle(cornerRadius: AppTokens.Shapes.small) // 芯片形状
                                                .fill(activeMode == mode ? AppTokens.Colors.primary.opacity(0.15) : AppTokens.Colors.surface) // 选中/未选中背景色
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: AppTokens.Shapes.small)
                                                        .stroke(AppTokens.Colors.outline, lineWidth: 1) // 未选中芯片的边框
                                                )
                                        )
                                }
                                .buttonStyle(PlainButtonStyle()) // 移除 SwiftUI 默认按钮样式，以匹配 Compose 样式
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading) // 确保芯片靠左对齐

                        // Solar Wash 卡片
                        // 对应 Kotlin 的 Card
                        VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
                            Text("Solar wash")
                                .font(AppTokens.TypographyTokens.headline)
                                .foregroundColor(AppTokens.Colors.onSurface)
                            Text("Adjust orbital window glow")
                                .font(AppTokens.TypographyTokens.body)
                                .foregroundColor(AppTokens.Colors.onSurface.opacity(0.7))
                            
                            // Slider (滑块)
                            Slider(value: $solarLevel, in: 0...1)
                                .tint(AppTokens.Colors.primary) // 滑块拇指和激活轨道的颜色
                            
                            // Slider 下方的 0% 和 X% 文本
                            HStack {
                                Text("0%")
                                    .font(AppTokens.TypographyTokens.label)
                                    .foregroundColor(AppTokens.Colors.onSurface)
                                Spacer()
                                Text("\(Int(solarLevel * 100))%")
                                    .font(AppTokens.TypographyTokens.title)
                                    .foregroundColor(AppTokens.Colors.primary)
                            }
                            .frame(maxWidth: .infinity) // 填充可用宽度

                            // Ambient Glow
                            Text("Ambient glow")
                                .font(AppTokens.TypographyTokens.headline)
                                .foregroundColor(AppTokens.Colors.onSurface)
                            
                            // Slider (滑块)
                            Slider(value: $ambientGlow, in: 0...1)
                                .tint(AppTokens.Colors.secondary) // 滑块拇指和激活轨道的颜色
                            
                            // 线性进度条
                            ProgressView(value: ambientGlow)
                                .tint(AppTokens.Colors.secondary)
                                .background(AppTokens.Colors.surfaceVariant) // 轨道颜色
                                .frame(height: 4) // 近似 Compose 进度条高度
                                .cornerRadius(2) // 进度条圆角
                        }
                        .padding(AppTokens.Spacing.lg) // 卡片内部内边距
                        .background(AppTokens.Colors.surface) // 卡片背景色
                        .cornerRadius(AppTokens.Shapes.large) // 卡片圆角
                        // 卡片阴影，对应 AppTokens.ElevationMapping.level1
                        .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity),
                                radius: AppTokens.ElevationMapping.level1.radius,
                                x: 0, y: AppTokens.ElevationMapping.level1.dy)

                        // Orbit Health 卡片
                        // 对应 Kotlin 的 Card
                        VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
                            Text("Orbit health")
                                .font(AppTokens.TypographyTokens.headline)
                                .foregroundColor(AppTokens.Colors.onSurface)
                            StatusRow(label: "Atmos mix", value: 0.74, accent: AppTokens.Colors.secondary)
                            StatusRow(label: "Hull temp", value: 0.42, accent: AppTokens.Colors.primary)
                            StatusRow(label: "Shield sync", value: 0.88, accent: AppTokens.Colors.tertiary)
                        }
                        .padding(AppTokens.Spacing.lg) // 卡片内部内边距
                        .background(AppTokens.Colors.surfaceVariant) // 卡片背景色
                        .cornerRadius(AppTokens.Shapes.large) // 卡片圆角
                        // 卡片阴影，对应 AppTokens.ElevationMapping.level1
                        .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity),
                                radius: AppTokens.ElevationMapping.level1.radius,
                                x: 0, y: AppTokens.ElevationMapping.level1.dy)

                        // Deck Zones 卡片
                        // 对应 Kotlin 的 Card
                        VStack(alignment: .leading, spacing: AppTokens.Spacing.sm) {
                            Text("Deck zones")
                                .font(AppTokens.TypographyTokens.headline)
                                .foregroundColor(AppTokens.Colors.onSurface)
                            ForEach(zones) { zone in
                                ZoneRow(zone: zone)
                            }
                        }
                        .padding(AppTokens.Spacing.lg) // 卡片内部内边距
                        .background(AppTokens.Colors.surface) // 卡片背景色
                        .cornerRadius(AppTokens.Shapes.large) // 卡片圆角
                        // 卡片阴影，对应 AppTokens.ElevationMapping.level1
                        .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level1.opacity),
                                radius: AppTokens.ElevationMapping.level1.radius,
                                x: 0, y: AppTokens.ElevationMapping.level1.dy)
                    }
                    // 整个可滚动内容的水平和垂直内边距，对应 Scaffold 的 contentPadding
                    .padding(.horizontal, AppTokens.Spacing.lg)
                    .padding(.vertical, AppTokens.Spacing.sm)
                }

                // MARK: 底部栏 (Bottom Bar)
                // 对应 Kotlin 的 Scaffold bottomBar
                HStack {
                    VStack(alignment: .leading, spacing: AppTokens.Spacing.xs) {
                        Text("Grid draw")
                            .font(AppTokens.TypographyTokens.label)
                            .foregroundColor(AppTokens.Colors.onSurface)
                        Text("18.4 kWh")
                            .font(AppTokens.TypographyTokens.title)
                            .foregroundColor(AppTokens.Colors.primary)
                    }
                    Spacer()
                    Button {
                        // "Engage eco hold" 按钮点击事件
                    } label: {
                        Text("Engage eco hold")
                            .font(AppTokens.TypographyTokens.label)
                            .padding(.horizontal, AppTokens.Spacing.md) // 按钮内部文本的水平内边距
                            .padding(.vertical, AppTokens.Spacing.sm)   // 按钮内部文本的垂直内边距
                            .background(AppTokens.Colors.primary) // 按钮背景色
                            .foregroundColor(AppTokens.Colors.onPrimary) // 按钮文本颜色
                            .cornerRadius(AppTokens.Shapes.medium) // 按钮圆角
                    }
                    .buttonStyle(PlainButtonStyle()) // 移除 SwiftUI 默认按钮样式
                }
                .padding(.horizontal, AppTokens.Spacing.lg) // 水平内边距
                .padding(.vertical, AppTokens.Spacing.sm)   // 垂直内边距
                .background(AppTokens.Colors.surface) // 背景色
                // 底部栏阴影，对应 AppTokens.ElevationMapping.level2
                .shadow(color: Color.black.opacity(AppTokens.ElevationMapping.level2.opacity),
                        radius: AppTokens.ElevationMapping.level2.radius,
                        x: 0, y: AppTokens.ElevationMapping.level2.dy)
            }
        }
        // 使整个 VStack 内容忽略安全区域，实现全屏效果
        .ignoresSafeArea(.all, edges: .vertical)
    }
}

// MARK: - App Entry Point
// SwiftUI 应用的入口点，对应 Kotlin 的 MainActivity
@main
struct SmartOrbitPanelApp: App {
    var body: some Scene {
        WindowGroup {
            RootScreen()
                // 隐藏顶部状态栏，兼容 iOS 16.0
                .statusBarHidden(true)
        }
    }
}