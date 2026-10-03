import { window } from '@kit.ArkUI';

// MARK: - AppTokens
// 定义应用程序的颜色、字体、形状和间距。
// 这种结构使得修改 UI 的外观和感觉变得容易。
class AppTokens {
    static Colors = {
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
        onSurface: '#1E293B'
    };

    static TypographyTokens = {
        // 大号显示文本样式。
        display: { size: 26, weight: FontWeight.Bold },
        // 中号标题文本样式。
        headline: { size: 18, weight: FontWeight.SemiBold },
        // 中号标题文本样式。
        title: { size: 14, weight: FontWeight.Medium },
        // 中号正文文本样式。
        body: { size: 12, weight: FontWeight.Normal }
    };

    static Shapes = {
        // 圆角矩形的小圆角半径。
        smallCornerRadius: 8,
        // 中等圆角半径。
        mediumCornerRadius: 12,
        // 大圆角半径。
        largeCornerRadius: 18
    };

    static Spacing = {
        // 小间距单位。
        sm: 8,
        // 中等间距单位。
        md: 12,
        // 大间距单位。
        lg: 18,
        // 特大间距单位。
        xl: 26
    };
}

@Entry
@Component
struct RootScreen {
    // 状态变量，用于管理目标温度和当前模式。
    @State targetTemp: number = 22;
    @State mode: string = 'Cool';

    build() {
        Column() {
            // 自定义顶部栏（相当于 Jetpack Compose 的 CenterAlignedTopAppBar）
            Row() {
                Image($r('app.media.thermometer_medium')) // 对应 Icons.Filled.Thermostat
                    .width(24)
                    .height(24)
                    .objectFit(ImageFit.Contain)
                    .fillColor(AppTokens.Colors.primary)
                    .margin({ left: AppTokens.Spacing.md })

                Blank() // 将标题推到中心

                Text('ThermoCurve')
                    .font-size(AppTokens.TypographyTokens.display.size)
                    .fontWeight(AppTokens.TypographyTokens.display.weight)
                    .fontColor(AppTokens.Colors.onSurface)

                Blank() // 将操作按钮推到右侧

                Button('', { type: ButtonType.Circle }) {
                    Image($r('app.media.sun_max_fill')) // 对应 Icons.Filled.WbSunny
                        .width(24)
                        .height(24)
                        .objectFit(ImageFit.Contain)
                        .fillColor(AppTokens.Colors.secondary)
                }
                .backgroundColor(Color.Transparent)
                .onClick(() => {
                    this.targetTemp += 1; // 太阳图标按钮的操作
                })
                .margin({ right: AppTokens.Spacing.md })
            }
            .width('100%')
            .height(56) // 标准 AppBar 高度
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .backgroundColor(AppTokens.Colors.surfaceVariant)

            // 主要内容区域
            Column() {
                Text('Target Temperature')
                    .font-size(AppTokens.TypographyTokens.headline.size)
                    .fontWeight(AppTokens.TypographyTokens.headline.weight)
                    .fontColor(AppTokens.Colors.onSurface)
                    .margin({ top: AppTokens.Spacing.xl })

                Text(`${this.targetTemp}°C`)
                    .fontSize(48) // 温度显示自定义字体大小
                    .fontWeight(FontWeight.Bold)
                    .fontColor(AppTokens.Colors.primary)
                    .margin({ top: AppTokens.Spacing.sm })

                Row() {
                    Button('–', { type: ButtonType.Capsule })
                        .width(60)
                        .height(60)
                        .fontSize(20)
                        .fontColor(AppTokens.Colors.onPrimary)
                        .backgroundColor(AppTokens.Colors.primary)
                        .borderRadius(AppTokens.Shapes.smallCornerRadius)
                        .onClick(() => {
                            if (this.targetTemp > 10) {
                                this.targetTemp -= 1; // 降低温度，有最小限制
                            }
                        })

                    Button('+', { type: ButtonType.Capsule })
                        .width(60)
                        .height(60)
                        .fontSize(20)
                        .fontColor(AppTokens.Colors.onPrimary)
                        .backgroundColor(AppTokens.Colors.primary)
                        .borderRadius(AppTokens.Shapes.smallCornerRadius)
                        .margin({ left: AppTokens.Spacing.md })
                        .onClick(() => {
                            if (this.targetTemp < 35) {
                                this.targetTemp += 1; // 升高温度，有最大限制
                            }
                        })
                }
                .justifyContent(FlexAlign.Center)
                .margin({ top: AppTokens.Spacing.lg })

                Divider()
                    .color(AppTokens.Colors.outline)
                    .opacity(0.5)
                    .width('80%')
                    .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })

                Text('Mode')
                    .font-size(AppTokens.TypographyTokens.headline.size)
                    .fontWeight(AppTokens.TypographyTokens.headline.weight)
                    .fontColor(AppTokens.Colors.onSurface)

                Row() {
                    ModeButton({ label: 'Cool', iconName: $r('app.media.wind'), currentMode: this.mode, onSelect: (selectedMode: string) => {
                        this.mode = selectedMode; // 选择“Cool”时更新模式
                    }})

                    ModeButton({ label: 'Heat', iconName: $r('app.media.sun_max_fill'), currentMode: this.mode, onSelect: (selectedMode: string) => {
                        this.mode = selectedMode; // 选择“Heat”时更新模式
                    }})
                        .margin({ left: AppTokens.Spacing.lg })
                }
                .justifyContent(FlexAlign.Center)
                .margin({ top: AppTokens.Spacing.lg })

                Text(`Current Mode: ${this.mode}`)
                    .font-size(AppTokens.TypographyTokens.body.size)
                    .fontWeight(AppTokens.TypographyTokens.body.weight)
                    .fontColor(AppTokens.Colors.onSurface)
                    .margin({ top: AppTokens.Spacing.lg })
            }
            .width('100%')
            .padding(AppTokens.Spacing.lg)
            .linearGradient({
                angle: 90,
                colors: [
                    [AppTokens.Colors.secondary, 0.15],
                    [AppTokens.Colors.primary, 0.2]
                ]
            })
            .backgroundColor(AppTokens.Colors.background)
        }
        .width('100%')
        .height('100%')
    }
}

@Component
struct ModeButton {
    label: string;
    iconName: Resource;
    currentMode: string;
    onSelect: (string) => void;

    build() {
        let isSelected = this.label === this.currentMode;
        Button() {
            Column() {
                Image(this.iconName)
                    .width(32)
                    .height(32)
                    .objectFit(ImageFit.Contain)
                    .fillColor(isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)

                Text(this.label)
                    .font-size(AppTokens.TypographyTokens.body.size)
                    .fontWeight(AppTokens.TypographyTokens.body.weight)
                    .fontColor(isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                    .margin({ top: AppTokens.Spacing.sm })
            }
        }
        .width(100)
        .height(100)
        .borderRadius(50)
        .backgroundColor(isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
        .shadow({ radius: 5, color: Color.Black.opacity(0.1), offsetY: 5 })
        .onClick(() => {
            this.onSelect(this.label);
        })
    }
}

// 注意：ArkTS 没有直接等同于 SwiftUI 的 @main 入口点。
// 应用程序的入口通常在 main.ts 文件中定义，并使用 UIAbility 来启动第一个页面。
// 为了隐藏状态栏，可以在 UIAbility 的 onCreate 方法中设置窗口属性。
/*
import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

export default class EntryAbility extends UIAbility {
    async onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): Promise<void> {
        super.onCreate(want, launchParam);
        // 获取窗口实例
        let windowClass: window.Window = await window.getMainWindowSync();
        // 隐藏状态栏
        windowClass.setWindowSystemBarEnable([], (err) => {
            if (err) {
                console.error(`Failed to set system bar enable. Code is ${err.code}, message ${err.message}`);
                return;
            }
            console.info('Successfully set the system bar enable.');
        });
        // 加载根组件
        this.context.loadContent('pages/Index', (err, data) => {
            if (err) {
                console.error(`Failed to load content. Code is ${err.code}, message ${err.message}`);
                return;
            }
            console.info('Successfully loaded content.');
        });
    }
    // ... 其他生命周期方法
}
*/