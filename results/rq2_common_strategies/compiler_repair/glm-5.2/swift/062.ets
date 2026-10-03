// MARK: - AppTokens
// 定义应用程序的颜色、字体、形状和间距。
class AppTokens {
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

  static Typography: Record<string, Record<string, number | FontWeight>> = {
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

// MARK: - ModeButton
// 一个可重用的按钮组件，用于选择不同的模式（例如，Cool/Heat）。
@Component
struct ModeButton {
  @Prop label: string = '';
  @Prop iconName: Resource = $r('app.media.startIcon');
  @Prop currentMode: string = '';
  onSelect: (mode: string) => void = () => {};

  build() {
    Button({ type: ButtonType.Circle }) {
      Column({ space: AppTokens.Spacing.sm }) {
        Image(this.iconName)
          .width(32)
          .height(32)
          .fillColor(this.label === this.currentMode ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
        
        Text(this.label)
          .fontSize(AppTokens.Typography.body.size as number)
          .fontWeight(AppTokens.Typography.body.weight as FontWeight)
          .fontColor(this.label === this.currentMode ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      }
      .width(100)
      .height(100)
      .justifyContent(FlexAlign.Center)
    }
    .width(100)
    .height(100)
    .backgroundColor(this.label === this.currentMode ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
    .shadow({ radius: 5, color: '#1A000000', offsetX: 0, offsetY: 5 })
    .onClick(() => this.onSelect(this.label))
  }
}

// MARK: - RootScreen
// ThermoCurve 应用程序的主 UI 屏幕。
@Entry
@Component
struct RootScreen {
  @State targetTemp: number = 22;
  @State mode: string = 'Cool';

  build() {
    Column() {
      // 自定义顶部栏
      Row() {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor(AppTokens.Colors.primary)
          .margin({ left: AppTokens.Spacing.md })

        Blank() // 将标题推到中心

        Text('ThermoCurve')
          .fontSize(AppTokens.Typography.display.size as number)
          .fontWeight(AppTokens.Typography.display.weight as FontWeight)
          .fontColor(AppTokens.Colors.onSurface)

        Blank() // 将操作按钮推到右侧

        Button({ type: ButtonType.Normal }) {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor(AppTokens.Colors.secondary)
        }
        .backgroundColor(Color.Transparent)
        .onClick(() => this.targetTemp += 1)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surfaceVariant)

      // 主要内容区域
      Column({ space: AppTokens.Spacing.xl }) {
        Text('Target Temperature')
          .fontSize(AppTokens.Typography.headline.size as number)
          .fontWeight(AppTokens.Typography.headline.weight as FontWeight)
          .fontColor(AppTokens.Colors.onSurface)

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)

        // 温度控制按钮
        Row({ space: AppTokens.Spacing.md }) {
          Button({ type: ButtonType.Normal }) {
            Text('-')
              .fontSize(20)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .width(60)
          .height(60)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.smallCornerRadius)
          .onClick(() => {
            if (this.targetTemp > 10) this.targetTemp -= 1;
          })

          Button({ type: ButtonType.Normal }) {
            Text('+')
              .fontSize(20)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .width(60)
          .height(60)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.smallCornerRadius)
          .onClick(() => {
            if (this.targetTemp < 35) this.targetTemp += 1;
          })
        }

        // 分隔线
        Divider()
          .color(AppTokens.Colors.outline)
          .strokeWidth(1)
          .width('80%')
          .opacity(0.5)

        Text('Mode')
          .fontSize(AppTokens.Typography.headline.size as number)
          .fontWeight(AppTokens.Typography.headline.weight as FontWeight)
          .fontColor(AppTokens.Colors.onSurface)

        // 模式选择按钮
        Row({ space: AppTokens.Spacing.lg }) {
          ModeButton({
            label: 'Cool',
            iconName: $r('app.media.startIcon'),
            currentMode: this.mode,
            onSelect: (selectedMode: string) => this.mode = selectedMode
          })
          ModeButton({
            label: 'Heat',
            iconName: $r('app.media.startIcon'),
            currentMode: this.mode,
            onSelect: (selectedMode: string) => this.mode = selectedMode
          })
        }

        Text(`Current Mode: ${this.mode}`)
          .fontSize(AppTokens.Typography.body.size as number)
          .fontWeight(AppTokens.Typography.body.weight as FontWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .layoutWeight(1) // 填充可用空间
      .padding(AppTokens.Spacing.lg)
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
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM, SafeAreaEdge.START, SafeAreaEdge.END]) // 确保整个视图延伸到屏幕边缘
  }
}