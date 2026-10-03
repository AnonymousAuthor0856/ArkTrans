// MARK: - AppTokens
// Application color, font, shape, and spacing definitions.
class AppTokens {
  static Colors = class {
    static primary: string = '#3B82F6'
    static secondary: string = '#06B6D4'
    static tertiary: string = '#0EA5E9'
    static background: string = '#F0F9FF'
    static surface: string = '#FFFFFF'
    static surfaceVariant: string = '#E0F2FE'
    static outline: string = '#CBD5E1'
    static onPrimary: string = '#FFFFFF'
    static onBackground: string = '#0F172A'
    static onSurface: string = '#1E293B'
  }

  static TypographyTokens = class {
    static display: { size: number, weight: FontWeight } = { size: 26, weight: FontWeight.Bold }
    static headline: { size: number, weight: FontWeight } = { size: 18, weight: FontWeight.Medium }
    static title: { size: number, weight: FontWeight } = { size: 14, weight: FontWeight.Medium }
    static body: { size: number, weight: FontWeight } = { size: 12, weight: FontWeight.Normal }
  }

  static Shapes = class {
    static smallCornerRadius: number = 8
    static mediumCornerRadius: number = 12
    static largeCornerRadius: number = 18
  }

  static Spacing = class {
    static sm: number = 8
    static md: number = 12
    static lg: number = 18
    static xl: number = 26
  }
}

// MARK: - ModeButton
// Reusable button component for selecting different modes (e.g., Cool/Heat).
@Component
struct ModeButton {
  label: string = ''
  iconName: ResourceStr = $r('sys.media.ohos_ic_public_add')
  currentMode: string = ''
  onSelect: (mode: string) => void = () => {}

  build() {
    Column() {
      Image(this.iconName)
        .width(32)
        .height(32)
        .objectFit(ImageFit.Contain)
        .fillColor(this.label === this.currentMode ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      Text(this.label)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(this.label === this.currentMode ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
    }
    .width(100)
    .height(100)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.label === this.currentMode ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
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

// MARK: - RootScreen
// Main UI screen of the ThermoCurve application.
@Entry
@Component
struct RootScreen {
  @State targetTemp: number = 22
  @State mode: string = 'Cool'

  build() {
    Column() {
      // Top bar
      Row() {
        Image($r('sys.media.ohos_ic_public_add'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .fillColor(AppTokens.Colors.primary)
          .margin({ left: AppTokens.Spacing.md })

        Blank()

        Text('ThermoCurve')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Image($r('sys.media.ohos_ic_public_arrow_right'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .fillColor(AppTokens.Colors.secondary)
          .margin({ right: AppTokens.Spacing.md })
          .onClick(() => {
            this.targetTemp += 1
          })
      }
      .height(56)
      .width('100%')
      .backgroundColor(AppTokens.Colors.surfaceVariant)

      // Main content area
      Column() {
        Text('Target Temperature')
          .fontSize(AppTokens.TypographyTokens.headline.size)
          .fontWeight(AppTokens.TypographyTokens.headline.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: AppTokens.Spacing.md })

        Row() {
          Text('–')
            .fontSize(20)
            .fontWeight(FontWeight.Normal)
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
            .fontWeight(FontWeight.Normal)
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
        .margin({ top: AppTokens.Spacing.md })

        Divider()
          .strokeWidth(1)
          .color('rgba(203, 213, 225, 0.5)')
          .width('80%')
          .margin({ top: AppTokens.Spacing.xl })

        Text('Mode')
          .fontSize(AppTokens.TypographyTokens.headline.size)
          .fontWeight(AppTokens.TypographyTokens.headline.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.xl })

        Row() {
          ModeButton({
            label: 'Cool',
            iconName: $r('sys.media.ohos_ic_public_circle'),
            currentMode: this.mode,
            onSelect: (selectedMode: string) => {
              this.mode = selectedMode
            }
          })

          ModeButton({
            label: 'Heat',
            iconName: $r('sys.media.ohos_ic_public_arrow_right'),
            currentMode: this.mode,
            onSelect: (selectedMode: string) => {
              this.mode = selectedMode
            }
          })
        }
        .margin({ top: AppTokens.Spacing.md })

        Text(`Current Mode: ${this.mode}`)
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.lg })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(AppTokens.Colors.background)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokens.Colors.secondary + '26', 0.0],
          [AppTokens.Colors.primary + '33', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
  }
}
