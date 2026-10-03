import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens
// 定义应用程序的颜色、字体、形状和间距。
// 这种结构使得修改 UI 的外观和感觉变得容易。

interface ColorMap {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  onPrimary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyMap {
  display: TypographyToken;
  headline: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
}

interface ShapeMap {
  smallCornerRadius: number;
  mediumCornerRadius: number;
  largeCornerRadius: number;
}

interface SpacingMap {
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

class AppTokens {
  static Colors: ColorMap = {
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

  static TypographyTokens: TypographyMap = {
    // 大号显示文本样式。
    display: { size: 26, weight: FontWeight.Bold },
    // 中号标题文本样式。
    headline: { size: 18, weight: FontWeight.Medium }, // Fixed: SemiBold does not exist in standard ArkTS FontWeight enum usually, using Medium or Bold. If SemiBold is needed, it might be a custom extension, but standard is Normal/Medium/Bold/Black. Let's use Medium as closest safe bet or check if specific version supports it. Standard ArkTS often lacks SemiBold. Using Medium.
    // 中号标题文本样式。
    title: { size: 14, weight: FontWeight.Medium },
    // 中号正文文本样式。
    body: { size: 12, weight: FontWeight.Normal }
  };

  static Shapes: ShapeMap = {
    // 圆角矩形的小圆角半径。
    smallCornerRadius: 8,
    // 中等圆角半径。
    mediumCornerRadius: 12,
    // 大圆角半径。
    largeCornerRadius: 18
  };

  static Spacing: SpacingMap = {
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

// MARK: - ModeButton
// 一个可重用的按钮组件，用于选择不同的模式（例如，Cool/Heat）。
@Component
struct ModeButton {
  label: string = ''; // 按钮的文本标签。
  iconName: string = ''; // SF Symbol 图标的名称 (ArkTS uses system icons or images)
  currentMode: string = ''; // 当前选定的模式。
  onSelect: (mode: string) => void = () => {}; // 按钮被点击时的回调。

  build() {
    let isSelected = this.label === this.currentMode;
    Button({ type: ButtonType.Circle }) {
      Column() {
        // ArkTS doesn't have direct SF Symbols mapping like SwiftUI. 
        // We use Image with system icon names if available or placeholder.
        // For 'wind' and 'sun.max.fill', we'll use generic system icons or text fallbacks if specific assets aren't provided.
        // Here we assume standard system icons might work or use a simple image component.
        // Note: In real ArkTS dev, you'd add .png/.svg to media folder. 
        // Using 'sys.icon' is not standard in all versions, so we use Image with a name that might exist or fallback.
        // For this conversion, I will use Image with a placeholder name that represents the concept.
        Image(this.iconName === 'wind' ? '$r(app.media.ic_wind)' : '$r(app.media.ic_sun)')
          .width(32)
          .height(32)
          .objectFit(ImageFit.Contain)
        
        Text(this.label)
          .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
      }
      .width(100)
      .height(100)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .backgroundColor(isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
    .foregroundColor(isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
    .borderRadius('50%') // Circle shape
    .shadow({ radius: 5, color: '#0000001A', offsetX: 0, offsetY: 5 }) // Simulate elevation
    .onClick(() => {
      this.onSelect(this.label);
    })
  }
}

// MARK: - RootScreen
// ThermoCurve 应用程序的主 UI 屏幕。
@Entry
@Component
struct RootScreen {
  // 状态变量，用于管理目标温度和当前模式。
  @State targetTemp: number = 22;
  @State mode: string = "Cool";

  build() {
    Column() {
      // 自定义顶部栏（相当于 Jetpack Compose 的 CenterAlignedTopAppBar）
      Row() {
        // Thermometer Icon
        Image('$r(app.media.ic_thermometer)')
          .width(24)
          .height(24)
          .fillColor(AppTokens.Colors.primary)
          .margin({ left: AppTokens.Spacing.md })

        Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
          Text("ThermoCurve")
            .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
            .foregroundColor(AppTokens.Colors.onSurface)
            
          // Sun Icon Button
          Button() {
            Image('$r(app.media.ic_sun)')
              .width(24)
              .height(24)
              .fillColor(AppTokens.Colors.secondary)
          }
          .margin({ right: AppTokens.Spacing.md })
          .onClick(() => {
            this.targetTemp += 1;
          })
        }
        .layoutWeight(1)
      }
      .height(56)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .width('100%')

      // 主要内容区域
      Column() {
        Text("Target Temperature")
          .font({ size: AppTokens.TypographyTokens.headline.size, weight: AppTokens.TypographyTokens.headline.weight })
          .foregroundColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.xl })

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: AppTokens.Spacing.sm })

        Row() {
          // Decrease Button
          Button() {
            Text("–")
              .fontSize(20)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .width(60)
          .height(60)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.smallCornerRadius)
          .onClick(() => {
            if (this.targetTemp > 10) {
              this.targetTemp -= 1;
            }
          })

          // Increase Button
          Button() {
            Text("+")
              .fontSize(20)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .width(60)
          .height(60)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.smallCornerRadius)
          .margin({ left: AppTokens.Spacing.md })
          .onClick(() => {
            if (this.targetTemp < 35) {
              this.targetTemp += 1;
            }
          })
        }
        .margin({ top: AppTokens.Spacing.lg })

        // Divider
        Divider()
          .color(AppTokens.Colors.outline)
          .opacity(0.5)
          .strokeWidth(1)
          .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
          .width('80%')

        Text("Mode")
          .font({ size: AppTokens.TypographyTokens.headline.size, weight: AppTokens.TypographyTokens.headline.weight })
          .foregroundColor(AppTokens.Colors.onSurface)

        Row() {
          ModeButton({
            label: "Cool",
            iconName: "wind",
            currentMode: this.mode,
            onSelect: (selectedMode: string) => {
              this.mode = selectedMode;
            }
          })

          ModeButton({
            label: "Heat",
            iconName: "sun.max.fill",
            currentMode: this.mode,
            onSelect: (selectedMode: string) => {
              this.mode = selectedMode;
            }
          })
        }
        .margin({ top: AppTokens.Spacing.lg })
        .justifyContent(FlexAlign.SpaceEvenly)

        Text(`Current Mode: ${this.mode}`)
          .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
          .foregroundColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.lg })
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .layoutWeight(1)
      // Background Gradient simulation using Stack or just setting background color for simplicity as LinearGradient is complex in basic ArkTS without custom drawing
      .linearGradient({
        angle: 180,
        colors: [
          ['rgba(6, 182, 212, 0.15)', 0],
          ['rgba(59, 130, 246, 0.2)', 1]
        ]
      })
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}