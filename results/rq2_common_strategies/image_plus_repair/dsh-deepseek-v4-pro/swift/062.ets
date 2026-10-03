// MARK: - AppTokens
// 定义应用程序的颜色、字体、形状和间距。
// 这种结构使得修改 UI 的外观和感觉变得容易。

// 颜色令牌（SwiftUI 的 Color 在此映射为 ArkUI 的十六进制颜色字符串）。
interface ColorTokens {
    primary: string
    secondary: string
    tertiary: string
    background: string
    surface: string
    surfaceVariant: string
    outline: string
    onPrimary: string
    onBackground: string
    onSurface: string
}

const Colors: ColorTokens = {
    // 主要品牌颜色，用于主要的交互元素。
    primary: '#3B82F6',
    // 次要品牌颜色，用于补充元素。
    secondary: '#06B6D4',
    // 第三品牌颜色，用于额外的强调。
    tertiary: '#0EA5E9',
    // 主屏幕内容的背景颜色。
    background: '#F0F9FF',
    // 卡片、表单和其他凸起元素的表面颜色。
    surface: '#FFFFFF',
    // 表面颜色的变体，通常用于应用栏或不同的部分。
    surfaceVariant: '#E0F2FE',
    // 边框或分隔线的轮廓颜色。
    outline: '#CBD5E1',
    // 显示在主要颜色上的内容的颜色。
    onPrimary: '#FFFFFF',
    // 显示在背景颜色上的内容的颜色。
    onBackground: '#0F172A',
    // 显示在表面颜色上的内容的颜色。
    onSurface: '#1E293B',
}

// 字体令牌（SwiftUI 的 Font.system(size:weight:) 拆分为 size 与 weight）。
interface FontToken {
    size: number
    weight: number
}

interface TypographyTokensType {
    display: FontToken
    headline: FontToken
    title: FontToken
    body: FontToken
}

const TypographyTokens: TypographyTokensType = {
    // 大号显示文本样式。
    display: { size: 26, weight: 700 }, // .bold
    // 中号标题文本样式。
    headline: { size: 18, weight: 600 }, // .semibold
    // 中号标题文本样式。
    title: { size: 14, weight: 500 }, // .medium
    // 中号正文文本样式。
    body: { size: 12, weight: 400 }, // .regular
}

interface ShapesTokensType {
    smallCornerRadius: number
    mediumCornerRadius: number
    largeCornerRadius: number
}

const Shapes: ShapesTokensType = {
    // 圆角矩形的小圆角半径。
    smallCornerRadius: 8,
    // 中等圆角半径。
    mediumCornerRadius: 12,
    // 大圆角半径。
    largeCornerRadius: 18,
}

interface SpacingTokensType {
    sm: number
    md: number
    lg: number
    xl: number
}

const Spacing: SpacingTokensType = {
    // 小间距单位。
    sm: 8,
    // 中等间距单位。
    md: 12,
    // 大间距单位。
    lg: 18,
    // 特大间距单位。
    xl: 26,
}

// 聚合令牌容器，保持 Swift 中的 AppTokens.Colors / AppTokens.TypographyTokens 等嵌套结构。
interface AppTokensType {
    Colors: ColorTokens
    TypographyTokens: TypographyTokensType
    Shapes: ShapesTokensType
    Spacing: SpacingTokensType
}

const AppTokens: AppTokensType = {
    Colors: Colors,
    TypographyTokens: TypographyTokens,
    Shapes: Shapes,
    Spacing: Spacing,
}

// MARK: - HostingController
// 原 Swift 代码使用自定义 UIHostingController 来隐藏状态栏并推迟系统手势，
// 实现真正的全屏体验。这一能力在 HarmonyOS 中由窗口/系统栏管理完成，
// 因此此处不再提供等价的 UIKit 类。

// MARK: - FullScreenView
// 原 Swift 代码使用 UIViewControllerRepresentable 将 SwiftUI 视图嵌入到
// 可管理系统 UI 元素（如状态栏）的 UIViewController 中。HarmonyOS 没有
// UIKit 的 UIViewController，因此该包装器被省略；RootScreen 直接作为页面渲染。

// MARK: - ModeButton
// 一个可重用的按钮组件，用于选择不同的模式（例如，Cool/Heat）。

// 将 SF Symbol 名称映射为可在 Text 中渲染的图形符号（HarmonyOS 无 SF Symbols）。
function sfSymbol(name: string): string {
    switch (name) {
        case 'thermometer.medium':
            return '🌡'
        case 'sun.max.fill':
            return '☀'
        case 'wind':
            return '💨'
        default:
            return '●'
    }
}

@Component
struct ModeButton {
    label: string = '' // 按钮的文本标签。
    iconName: string = '' // SF Symbol 图标的名称。
    currentMode: string = '' // 当前选定的模式。
    onSelect: (selected: string) => void = () => {} // 按钮被点击时的回调。

    build() {
        Column() {
            Button() {
                Column() {
                    Text(sfSymbol(this.iconName))
                        .fontSize(32)
                        .fontColor(this.label === this.currentMode ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                    Text(this.label)
                        .fontSize(AppTokens.TypographyTokens.body.size)
                        .fontWeight(AppTokens.TypographyTokens.body.weight)
                        .fontColor(this.label === this.currentMode ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                }
                .width(100)
                .height(100) // 按钮大小与 Kotlin 的 100.dp 匹配
                .justifyContent(FlexAlign.Center)
                .backgroundColor(this.label === this.currentMode ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                .borderRadius(50) // 形状与 Kotlin 的 CircleShape 匹配
                .shadow({ radius: 5, color: 'rgba(0, 0, 0, 0.1)', offsetX: 0, offsetY: 5 }) // 模拟 ElevatedButton 的凸起效果
            }
            .type(ButtonType.Normal)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
                this.onSelect(this.label)
            })
        }
    }
}

// MARK: - RootScreen
// ThermoCurve 应用程序的主 UI 屏幕。
@Component
struct RootScreen {
    // 状态变量，用于管理目标温度和当前模式。
    @State targetTemp: number = 22
    @State mode: string = 'Cool'

    build() {
        Column() { // 主 Column，垂直堆叠顶部栏和内容
            // 自定义顶部栏（相当于 Jetpack Compose 的 CenterAlignedTopAppBar）
            Row() {
                Text(sfSymbol('thermometer.medium')) // 对应 Icons.Filled.Thermostat
                    .fontSize(24)
                    .fontColor(AppTokens.Colors.primary)
                    .margin({ left: AppTokens.Spacing.md }) // 与 Kotlin 的 12.dp 匹配的内边距

                Blank() // 将标题推到中心

                Text('ThermoCurve')
                    .fontSize(AppTokens.TypographyTokens.display.size)
                    .fontWeight(AppTokens.TypographyTokens.display.weight)
                    .fontColor(AppTokens.Colors.onSurface) // 标题颜色来自 MaterialTheme.colorScheme.onSurface

                Blank() // 将操作按钮推到右侧

                Button() {
                    Text(sfSymbol('sun.max.fill')) // 对应 Icons.Filled.WbSunny
                        .fontSize(24)
                        .fontColor(AppTokens.Colors.secondary)
                }
                .backgroundColor(Color.Transparent)
                .onClick(() => {
                    this.targetTemp += 1 // 太阳图标按钮的操作
                })
                .margin({ right: AppTokens.Spacing.md }) // 与 Kotlin 的 12.dp 匹配的内边距
            }
            .width('100%')
            .height(56) // 标准 AppBar 高度
            .backgroundColor(AppTokens.Colors.surfaceVariant) // 顶部栏的容器颜色

            // 主要内容区域
            Column({ space: AppTokens.Spacing.xl }) { // 垂直排列，使用特大间距
                Text('Target Temperature')
                    .fontSize(AppTokens.TypographyTokens.headline.size)
                    .fontWeight(AppTokens.TypographyTokens.headline.weight)
                    .fontColor(AppTokens.Colors.onSurface)

                Text(`${this.targetTemp}°C`)
                    .fontSize(48)
                    .fontWeight(700) // 温度显示自定义字体大小
                    .fontColor(AppTokens.Colors.primary)

                Row({ space: AppTokens.Spacing.md }) { // 温度控制按钮的水平排列
                    Button() {
                        Text('–')
                            .fontSize(20)
                            .fontWeight(400)
                            .fontColor(AppTokens.Colors.onPrimary)
                    }
                    .width(60)
                    .height(60) // 按钮固定大小以匹配视觉效果
                    .backgroundColor(AppTokens.Colors.primary)
                    .borderRadius(AppTokens.Shapes.smallCornerRadius) // 按钮默认圆角半径
                    .onClick(() => {
                        if (this.targetTemp > 10) {
                            this.targetTemp -= 1 // 降低温度，有最小限制
                        }
                    })

                    Button() {
                        Text('+')
                            .fontSize(20)
                            .fontWeight(400)
                            .fontColor(AppTokens.Colors.onPrimary)
                    }
                    .width(60)
                    .height(60) // 按钮固定大小以匹配视觉效果
                    .backgroundColor(AppTokens.Colors.primary)
                    .borderRadius(AppTokens.Shapes.smallCornerRadius) // 按钮默认圆角半径
                    .onClick(() => {
                        if (this.targetTemp < 35) {
                            this.targetTemp += 1 // 升高温度，有最大限制
                        }
                    })
                }

                Divider() // 水平分隔线
                    .width('80%') // 80% 宽度
                    .strokeWidth(1) // 1.dp 厚度
                    .color('rgba(203, 213, 225, 0.5)') // 分隔线的颜色和透明度（outline，50% 透明度）

                Text('Mode')
                    .fontSize(AppTokens.TypographyTokens.headline.size)
                    .fontWeight(AppTokens.TypographyTokens.headline.weight)
                    .fontColor(AppTokens.Colors.onSurface)

                Row({ space: AppTokens.Spacing.lg }) { // 模式选择按钮的水平排列
                    ModeButton({
                        label: 'Cool',
                        iconName: 'wind',
                        currentMode: this.mode,
                        onSelect: (selectedMode: string) => {
                            this.mode = selectedMode // 选择“Cool”时更新模式
                        }
                    })
                    ModeButton({
                        label: 'Heat',
                        iconName: 'sun.max.fill',
                        currentMode: this.mode,
                        onSelect: (selectedMode: string) => {
                            this.mode = selectedMode // 选择“Heat”时更新模式
                        }
                    })
                }

                Text(`Current Mode: ${this.mode}`)
                    .fontSize(AppTokens.TypographyTokens.body.size)
                    .fontWeight(AppTokens.TypographyTokens.body.weight)
                    .fontColor(AppTokens.Colors.onSurface)
            }
            .width('100%')
            .height('100%') // 内容填充可用空间
            .padding(AppTokens.Spacing.lg) // 整个内容块的内边距，与 Kotlin 的 lg 内边距匹配
            .linearGradient({ // 垂直渐变背景
                direction: GradientDirection.Bottom,
                colors: [
                    ['rgba(6, 182, 212, 0.15)', 0.0], // 次要颜色，15% 透明度
                    ['rgba(59, 130, 246, 0.2)', 1.0] // 主要颜色，20% 透明度
                ]
            })
        }
        .width('100%')
        .height('100%') // 确保整个视图延伸到屏幕边缘，忽略安全区域
        .backgroundColor(AppTokens.Colors.background) // Scaffold 的 containerColor，在渐变下方应用
    }
}

// MARK: - ThermoCurveApp
// 应用程序的入口点（对应 SwiftUI 的 @main App）。
@Entry
@Component
struct ThermoCurveApp {
    build() {
        Column() {
            // RootScreen 原本被 FullScreenView 包装，以实现全屏显示并隐藏状态栏。
            // 在 HarmonyOS 中由窗口/系统栏管理完成，因此直接渲染 RootScreen。
            RootScreen()
        }
        .width('100%')
        .height('100%')
    }
}

// MARK: - Preview Provider
// 原 Swift 代码在 Xcode 的画布中提供 RootScreen 的预览；
// HarmonyOS 使用 Previewer 注解而非 PreviewProvider，因此此处省略。
