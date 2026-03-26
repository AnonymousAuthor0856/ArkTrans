import SwiftUI
import UIKit

// MARK: - AppTokens
// 定义应用程序的颜色、字体、形状和间距。
// 这种结构使得修改 UI 的外观和感觉变得容易。
struct AppTokens {
    struct Colors {
        // 主要品牌颜色，用于主要的交互元素。
        static let primary = Color(red: 59/255, green: 130/255, blue: 246/255) // #3B82F6
        // 次要品牌颜色，用于补充元素。
        static let secondary = Color(red: 6/255, green: 182/255, blue: 212/255) // #06B6D4
        // 第三品牌颜色，用于额外的强调。
        static let tertiary = Color(red: 14/255, green: 165/255, blue: 233/255) // #0EA5E9
        // 主屏幕内容的背景颜色。
        static let background = Color(red: 240/255, green: 249/255, blue: 255/255) // #F0F9FF
        // 卡片、表单和其他凸起元素的表面颜色。
        static let surface = Color(red: 255/255, green: 255/255, blue: 255/255) // #FFFFFF
        // 表面颜色的变体，通常用于应用栏或不同的部分。
        static let surfaceVariant = Color(red: 224/255, green: 242/255, blue: 254/255) // #E0F2FE
        // 边框或分隔线的轮廓颜色。
        static let outline = Color(red: 203/255, green: 213/255, blue: 225/255) // #CBD5E1
        // 显示在主要颜色上的内容的颜色。
        static let onPrimary = Color(red: 255/255, green: 255/255, blue: 255/255) // #FFFFFF
        // 显示在背景颜色上的内容的颜色。
        static let onBackground = Color(red: 15/255, green: 23/255, blue: 42/255) // #0F172A
        // 显示在表面颜色上的内容的颜色。
        static let onSurface = Color(red: 30/255, green: 41/255, blue: 59/255) // #1E293B
    }

    struct TypographyTokens {
        // 大号显示文本样式。
        static let display = Font.system(size: 26, weight: .bold)
        // 中号标题文本样式。
        static let headline = Font.system(size: 18, weight: .semibold)
        // 中号标题文本样式。
        static let title = Font.system(size: 14, weight: .medium)
        // 中号正文文本样式。
        static let body = Font.system(size: 12, weight: .regular)
    }

    struct Shapes {
        // 圆角矩形的小圆角半径。
        static let smallCornerRadius: CGFloat = 8
        // 中等圆角半径。
        static let mediumCornerRadius: CGFloat = 12
        // 大圆角半径。
        static let largeCornerRadius: CGFloat = 18
    }

    struct Spacing {
        // 小间距单位。
        static let sm: CGFloat = 8
        // 中等间距单位。
        static let md: CGFloat = 12
        // 大间距单位。
        static let lg: CGFloat = 18
        // 特大间距单位。
        static let xl: CGFloat = 26
    }
}

// MARK: - HostingController
// 一个自定义的 UIHostingController，用于控制 SwiftUI 视图的状态栏可见性。
class HostingController<Content: View>: UIHostingController<Content> {
    // 重写此属性以隐藏状态栏。
    override var prefersStatusBarHidden: Bool {
        return true
    }

    // 重写此属性以推迟所有边缘的系统手势，提供真正的全屏体验。
    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        return .all
    }
}

// MARK: - FullScreenView
// 一个 UIViewControllerRepresentable 包装器，用于将 SwiftUI 视图嵌入到可以管理
// 系统 UI 元素（如状态栏）的 UIViewController 中。
struct FullScreenView<Content: View>: UIViewControllerRepresentable {
    var content: Content

    // 创建并配置 HostingController。
    func makeUIViewController(context: Context) -> HostingController<Content> {
        return HostingController(rootView: content)
    }

    // 更新 HostingController。
    func updateUIViewController(_ uiViewController: HostingController<Content>, context: Context) {
        // 在此特定情况下不需要更新逻辑。
    }
}

// MARK: - ModeButton
// 一个可重用的按钮组件，用于选择不同的模式（例如，Cool/Heat）。
struct ModeButton: View {
    let label: String // 按钮的文本标签。
    let iconName: String // SF Symbol 图标的名称。
    let currentMode: String // 当前选定的模式。
    let onSelect: (String) -> Void // 按钮被点击时的回调。

    var body: some View {
        let isSelected = label == currentMode
        Button(action: {
            onSelect(label)
        }) {
            VStack(alignment: .center) {
                Image(systemName: iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32) // 图标大小与 Kotlin 的 32.dp 匹配
                Text(label)
                    .font(AppTokens.TypographyTokens.body)
            }
            .frame(width: 100, height: 100) // 按钮大小与 Kotlin 的 100.dp 匹配
            .background(isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
            .foregroundColor(isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
            .clipShape(Circle()) // 形状与 Kotlin 的 CircleShape 匹配
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5) // 模拟 ElevatedButton 的凸起效果
        }
    }
}

// MARK: - RootScreen
// ThermoCurve 应用程序的主 UI 屏幕。
struct RootScreen: View {
    // 状态变量，用于管理目标温度和当前模式。
    @State private var targetTemp: Int = 22
    @State private var mode: String = "Cool"

    var body: some View {
        GeometryReader { geometry in // 使用 GeometryReader 进行动态宽度计算（例如，用于分隔线）
            VStack(spacing: 0) { // 主 VStack，垂直堆叠顶部栏和内容
                // 自定义顶部栏（相当于 Jetpack Compose 的 CenterAlignedTopAppBar）
                HStack(spacing: 0) {
                    Image(systemName: "thermometer.medium") // 对应 Icons.Filled.Thermostat
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(AppTokens.Colors.primary)
                        .padding(.leading, AppTokens.Spacing.md) // 与 Kotlin 的 12.dp 匹配的内边距

                    Spacer() // 将标题推到中心

                    Text("ThermoCurve")
                        .font(AppTokens.TypographyTokens.display)
                        .foregroundColor(AppTokens.Colors.onSurface) // 标题颜色来自 MaterialTheme.colorScheme.onSurface

                    Spacer() // 将操作按钮推到右侧

                    Button(action: {
                        targetTemp += 1 // 太阳图标按钮的操作
                    }) {
                        Image(systemName: "sun.max.fill") // 对应 Icons.Filled.WbSunny
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundColor(AppTokens.Colors.secondary)
                    }
                    .padding(.trailing, AppTokens.Spacing.md) // 与 Kotlin 的 12.dp 匹配的内边距
                }
                .frame(height: 56) // 标准 AppBar 高度
                .background(AppTokens.Colors.surfaceVariant) // 顶部栏的容器颜色

                // 主要内容区域
                VStack(spacing: AppTokens.Spacing.xl) { // 垂直排列，使用特大间距
                    Text("Target Temperature")
                        .font(AppTokens.TypographyTokens.headline)
                        .foregroundColor(AppTokens.Colors.onSurface)

                    Text("\(targetTemp)°C")
                        .font(.system(size: 48, weight: .bold)) // 温度显示自定义字体大小
                        .foregroundColor(AppTokens.Colors.primary)

                    HStack(spacing: AppTokens.Spacing.md) { // 温度控制按钮的水平排列
                        Button(action: {
                            if targetTemp > 10 { targetTemp -= 1 } // 降低温度，有最小限制
                        }) {
                            Text("–")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(AppTokens.Colors.onPrimary)
                                .frame(width: 60, height: 60) // 按钮固定大小以匹配视觉效果
                                .background(AppTokens.Colors.primary)
                                .cornerRadius(AppTokens.Shapes.smallCornerRadius) // 按钮默认圆角半径
                        }

                        Button(action: {
                            if targetTemp < 35 { targetTemp += 1 } // 升高温度，有最大限制
                        }) {
                            Text("+")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(AppTokens.Colors.onPrimary)
                                .frame(width: 60, height: 60) // 按钮固定大小以匹配视觉效果
                                .background(AppTokens.Colors.primary)
                                .cornerRadius(AppTokens.Shapes.smallCornerRadius) // 按钮默认圆角半径
                        }
                    }

                    Divider() // 水平分隔线
                        .frame(width: geometry.size.width * 0.8, height: 1) // 80% 宽度，1.dp 厚度
                        .overlay(AppTokens.Colors.outline.opacity(0.5)) // 分隔线的颜色和透明度

                    Text("Mode")
                        .font(AppTokens.TypographyTokens.headline)
                        .foregroundColor(AppTokens.Colors.onSurface)

                    HStack(spacing: AppTokens.Spacing.lg) { // 模式选择按钮的水平排列
                        ModeButton(label: "Cool", iconName: "wind", currentMode: mode) { selectedMode in
                            mode = selectedMode // 选择“Cool”时更新模式
                        }
                        ModeButton(label: "Heat", iconName: "sun.max.fill", currentMode: mode) { selectedMode in
                            mode = selectedMode // 选择“Heat”时更新模式
                        }
                    }

                    Text("Current Mode: \(mode)")
                        .font(AppTokens.TypographyTokens.body)
                        .foregroundColor(AppTokens.Colors.onSurface)
                }
                .padding(AppTokens.Spacing.lg) // 整个内容块的内边距，与 Kotlin 的 lg 内边距匹配
                .frame(maxWidth: .infinity, maxHeight: .infinity) // 内容填充可用空间
                .background(
                    LinearGradient( // 垂直渐变背景
                        gradient: Gradient(colors: [
                            AppTokens.Colors.secondary.opacity(0.15), // 次要颜色，15% 透明度
                            AppTokens.Colors.primary.opacity(0.2)    // 主要颜色，20% 透明度
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .background(AppTokens.Colors.background) // Scaffold 的 containerColor，在渐变下方应用
            }
            .ignoresSafeArea() // 确保整个视图延伸到屏幕边缘，忽略安全区域
        }
    }
}

// MARK: - ThermoCurveApp
// SwiftUI 应用程序的入口点。
@main
struct ThermoCurveApp: App {
    var body: some Scene {
        WindowGroup {
            // RootScreen 被 FullScreenView 包装，以实现全屏显示并隐藏状态栏，
            // 符合要求。
            FullScreenView(content: RootScreen())
        }
    }
}

// MARK: - Preview Provider
// 在 Xcode 的画布中提供 RootScreen 的预览。
struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}
