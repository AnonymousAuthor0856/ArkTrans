@Entry
@Component
struct ThermoCurveApp {
  build() {
    Stack() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}

// AppTokens - Design tokens
class AppTokens {
  static readonly Colors = {
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
  }

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 18,
    xl: 26
  }

  static readonly Shapes = {
    smallCornerRadius: 8,
    mediumCornerRadius: 12,
    largeCornerRadius: 18
  }
}

// ModeButton Component
@Component
struct ModeButton {
  @Prop label: string
  @Prop iconName: string
  @Prop currentMode: string
  onSelect: (mode: string) => void = () => {}

  private isSelected(): boolean {
    return this.label === this.currentMode
  }

  build() {
    Column({ space: 4 }) {
      Image(this.iconName === 'wind' ? $r('sys.media.ohos_ic_public_air') : $r('sys.media.ohos_ic_public_sunny'))
        .width(32)
        .height(32)
        .fillColor(this.isSelected() ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Regular)
        .fontColor(this.isSelected() ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
    }
    .width(100)
    .height(100)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.isSelected() ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
    .borderRadius(50)
    .shadow({
      radius: 5,
      color: 'rgba(0, 0, 0, 0.1)',
      offsetX: 0,
      offsetY: 5
    })
    .onClick(() => {
      this.onSelect(this.label)
    })
  }
}

// RootScreen Component
@Component
struct RootScreen {
  @State targetTemp: number = 22
  @State mode: string = 'Cool'

  build() {
    Column({ space: 0 }) {
      // Top App Bar
      Row({ space: 0 }) {
        Image($r('sys.media.ohos_ic_public_thermometer'))
          .width(24)
          .height(24)
          .fillColor(AppTokens.Colors.primary)
          .margin({ left: AppTokens.Spacing.md })

        Blank()

        Text('ThermoCurve')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Image($r('sys.media.ohos_ic_public_sunny'))
          .width(24)
          .height(24)
          .fillColor(AppTokens.Colors.secondary)
          .margin({ right: AppTokens.Spacing.md })
          .onClick(() => {
            this.targetTemp += 1
          })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .alignItems(VerticalAlign.Center)

      // Main Content
      Column({ space: AppTokens.Spacing.xl }) {
        Text('Target Temperature')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)

        Row({ space: AppTokens.Spacing.md }) {
          Button() {
            if (this.targetTemp > 10) {
              this.targetTemp -= 1
            }
          }
          .width(60)
          .height(60)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.smallCornerRadius)
          .type(ButtonType.Normal)
          .borderRadius(AppTokens.Shapes.smallCornerRadius)

          Button() {
            if (this.targetTemp < 35) {
              this.targetTemp += 1
            }
          }
          .width(60)
          .height(60)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.smallCornerRadius)
          .type(ButtonType.Normal)
          .borderRadius(AppTokens.Shapes.smallCornerRadius)
        }
        .justifyContent(FlexAlign.Center)

        // Minus button label
        Row({ space: AppTokens.Spacing.md }) {
          Text('–')
            .fontSize(20)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppTokens.Colors.onPrimary)
            .width(60)
            .height(60)
            .textAlign(TextAlign.Center)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.smallCornerRadius)
            .onClick(() => {
              if (this.targetTemp > 10) {
                this.targetTemp -= 1
              }
            })

          Text('+')
            .fontSize(20)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppTokens.Colors.onPrimary)
            .width(60)
            .height(60)
            .textAlign(TextAlign.Center)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.smallCornerRadius)
            .onClick(() => {
              if (this.targetTemp < 35) {
                this.targetTemp += 1
              }
            })
        }
        .justifyContent(FlexAlign.Center)

        // Divider
        Divider()
          .width('80%')
          .height(1)
          .color('rgba(203, 213, 225, 0.5)')

        Text('Mode')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)

        Row({ space: AppTokens.Spacing.lg }) {
          ModeButton({
            label: 'Cool',
            iconName: 'wind',
            currentMode: this.mode,
            onSelect: (selectedMode: string) => {
              this.mode = selectedMode
            }
          })

          ModeButton({
            label: 'Heat',
            iconName: 'sun',
            currentMode: this.mode,
            onSelect: (selectedMode: string) => {
              this.mode = selectedMode
            }
          })
        }
        .justifyContent(FlexAlign.Center)

        Text(`Current Mode: ${this.mode}`)
          .fontSize(12)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Center)
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
  }
}