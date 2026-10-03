// AppTokens.ets
// 定义应用程序的颜色、字体、形状和间距。
export class AppTokens {
  static Colors: Record<string, string> = {
    primary: '#3B82F6',
    secondary: '#06B6D4',
    tertiary: '#0EA5E9',
    background: '#F0F9FF',
    surface: '#FFFFFF',
    surfaceVariant: '#E0F2FE',
    outline: '#CBD5E1',
    onPrimary: '#FFFFFF',
    onBackground: '#0F172A',
    onSurface: '#1E293B'
  };

  static TypographyTokens: Record<string, Record<string, number | string>> = {
    display: { size: 26, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Medium },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Normal }
  };

  static Shapes: Record<string, number> = {
    smallCornerRadius: 8,
    mediumCornerRadius: 12,
    largeCornerRadius: 18
  };

  static Spacing: Record<string, number> = {
    sm: 8,
    md: 12,
    lg: 18,
    xl: 26
  };
}

// ModeButton.ets
// 一个可重用的按钮组件，用于选择不同的模式（例如，Cool/Heat）。
@Component
export struct ModeButton {
  private label: string = '';
  private iconName: ResourceStr = '';
  private currentMode: string = '';
  private onSelect: (mode: string) => void = () => {};

  build() {
    Button({ type: ButtonType.Circle, action: () => this.onSelect(this.label) }) {
      Column({ space: 4 }) {
        Image(this.iconName)
          .width(32)
          .height(32)
          .fillColor(this.label === this.currentMode ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
        Text(this.label)
          .fontSize(AppTokens.TypographyTokens.body.size as number)
          .fontWeight(AppTokens.TypographyTokens.body.weight as number)
          .fontColor(this.label === this.currentMode ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      }
      .width(100)
      .height(100)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width(100)
    .height(100)
    .backgroundColor(this.label === this.currentMode ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
    .shadow({ radius: 5, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: 5 });
  }
}

// RootScreen.ets
// ThermoCurve 应用程序的主 UI 屏幕。
@Entry
@Component
struct RootScreen {
  @State private targetTemp: number = 22;
  @State private mode: string = 'Cool';

  build() {
    Column() {
      // 自定义顶部栏
      Row() {
        Image($r('sys.media.ohos_ic_public_thermometer'))
          .width(24)
          .height(24)
          .fillColor(AppTokens.Colors.primary)
          .margin({ left: AppTokens.Spacing.md })

        Blank() // 将标题推到中心

        Text('ThermoCurve')
          .fontSize(AppTokens.TypographyTokens.display.size as number)
          .fontWeight(AppTokens.TypographyTokens.display.weight as number)
          .fontColor(AppTokens.Colors.onSurface)

        Blank() // 将操作按钮推到右侧

        Button({ type: ButtonType.Normal, action: () => this.targetTemp++ }) {
          Image($r('sys.media.ohos_ic_public_sun'))
            .width(24)
            .height(24)
            .fillColor(AppTokens.Colors.secondary)
        }
        .backgroundColor(Color.Transparent)
        .margin({ right: AppTokens.Spacing.md })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surfaceVariant)

      // 主要内容区域
      Column({ space: AppTokens.Spacing.xl }) {
        Text('Target Temperature')
          .fontSize(AppTokens.TypographyTokens.headline.size as number)
          .fontWeight(AppTokens.TypographyTokens.headline.weight as number)
          .fontColor(AppTokens.Colors.onSurface)

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)

        Row({ space: AppTokens.Spacing.md }) {
          Button({ type: ButtonType.Normal, action: () => {
            if (this.targetTemp > 10) this.targetTemp--;
          } }) {
            Text('–')
              .fontSize(20)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .width(60)
          .height(60)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.smallCornerRadius)

          Button({ type: ButtonType.Normal, action: () => {
            if (this.targetTemp < 35) this.targetTemp++;
          } }) {
            Text('+')
              .fontSize(20)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .width(60)
          .height(60)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.smallCornerRadius)
        }

        // 水平分隔线
        Divider()
          .color(AppTokens.Colors.outline)
          .strokeWidth(1)
          .width('80%')
          .opacity(0.5)

        Text('Mode')
          .fontSize(AppTokens.TypographyTokens.headline.size as number)
          .fontWeight(AppTokens.TypographyTokens.headline.weight as number)
          .fontColor(AppTokens.Colors.onSurface)

        Row({ space: AppTokens.Spacing.lg }) {
          ModeButton({
            label: 'Cool',
            iconName: $r('sys.media.ohos_ic_public_wind'),
            currentMode: this.mode,
            onSelect: (selectedMode: string) => this.mode = selectedMode
          })
          ModeButton({
            label: 'Heat',
            iconName: $r('sys.media.ohos_ic_public_sun'),
            currentMode: this.mode,
            onSelect: (selectedMode: string) => this.mode = selectedMode
          })
        }

        Text(`Current Mode: ${this.mode}`)
          .fontSize(AppTokens.TypographyTokens.body.size as number)
          .fontWeight(AppTokens.TypographyTokens.body.weight as number)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.secondary, 0.15],
          [AppTokens.Colors.primary, 0.2]
        ]
      })
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.System], [SafeAreaEdge.All]) // 确保整个视图延伸到屏幕边缘，忽略安全区域
  }
}