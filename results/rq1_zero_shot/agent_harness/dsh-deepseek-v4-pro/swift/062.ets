// MARK: - AppTokens
const AppTokens = {
  Colors: {
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
  },
  Typography: {
    display: { size: 26, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Semibold },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Regular }
  },
  Shapes: {
    smallCornerRadius: 8,
    mediumCornerRadius: 12,
    largeCornerRadius: 18
  },
  Spacing: {
    sm: 8,
    md: 12,
    lg: 18,
    xl: 26
  }
};

// MARK: - ModeButton
@Component
struct ModeButton {
  @Prop label: string = '';
  @Prop iconName: string = '';
  @Prop currentMode: string = '';
  onSelect: (label: string) => void = () => {};

  build() {
    Button() {
      Column() {
        Text(this.iconName)
          .fontSize(32)
          .fontColor(this.label === this.currentMode ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
        Text(this.label)
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(this.label === this.currentMode ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      }
      .width(100)
      .height(100)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(this.label === this.currentMode ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
      .borderRadius(50)
      .shadow({ radius: 5, color: '#1A000000', offsetX: 0, offsetY: 5 })
    }
    .onClick(() => {
      this.onSelect(this.label);
    })
  }
}

// MARK: - RootScreen
@Component
struct RootScreen {
  @State targetTemp: number = 22;
  @State mode: string = 'Cool';

  build() {
    Column({ space: 0 }) {
      Row({ space: 0 }) {
        Text('🌡')
          .fontSize(24)
          .fontColor(AppTokens.Colors.primary)
          .padding({ left: AppTokens.Spacing.md })

        Blank()

        Text('ThermoCurve')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Button() {
          Text('☀')
            .fontSize(24)
            .fontColor(AppTokens.Colors.secondary)
        }
        .onClick(() => {
          this.targetTemp += 1;
        })
        .padding({ right: AppTokens.Spacing.md })
      }
      .height(56)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.surfaceVariant)

      Column({ space: AppTokens.Spacing.xl }) {
        Text('Target Temperature')
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Text(this.targetTemp.toString() + '°C')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)

        Row({ space: AppTokens.Spacing.md }) {
          Button() {
            Text('–')
              .fontSize(20)
              .fontWeight(FontWeight.Regular)
              .fontColor(AppTokens.Colors.onPrimary)
              .width(60)
              .height(60)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.smallCornerRadius)
          }
          .onClick(() => {
            if (this.targetTemp > 10) {
              this.targetTemp -= 1;
            }
          })

          Button() {
            Text('+')
              .fontSize(20)
              .fontWeight(FontWeight.Regular)
              .fontColor(AppTokens.Colors.onPrimary)
              .width(60)
              .height(60)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.smallCornerRadius)
          }
          .onClick(() => {
            if (this.targetTemp < 35) {
              this.targetTemp += 1;
            }
          })
        }

        Row()
          .width('80%')
          .height(1)
          .backgroundColor(AppTokens.Colors.outline)
          .opacity(0.5)

        Text('Mode')
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Row({ space: AppTokens.Spacing.lg }) {
          ModeButton({
            label: 'Cool',
            iconName: '💨',
            currentMode: this.mode,
            onSelect: (selectedMode: string) => {
              this.mode = selectedMode;
            }
          })
          ModeButton({
            label: 'Heat',
            iconName: '☀',
            currentMode: this.mode,
            onSelect: (selectedMode: string) => {
              this.mode = selectedMode;
            }
          })
        }

        Text('Current Mode: ' + this.mode)
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
      .linearGradient({
        angle: 180,
        colors: [['#2606B6D4', 0.0], ['#333B82F6', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.ALL])
  }
}

// MARK: - ThermoCurveApp
@Entry
@Component
struct ThermoCurveApp {
  build() {
    RootScreen()
  }
}
