// MARK: - AppTokens
// Application color, font, shape, and spacing definitions.

class AppColors {
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

interface TypographyStyle {
  size: number
  weight: FontWeight
}

class AppTypographyTokens {
  static display: TypographyStyle = { size: 26, weight: FontWeight.Bold }
  static headline: TypographyStyle = { size: 18, weight: FontWeight.Medium }
  static title: TypographyStyle = { size: 14, weight: FontWeight.Medium }
  static body: TypographyStyle = { size: 12, weight: FontWeight.Normal }
}

class AppShapes {
  static smallCornerRadius: number = 8
  static mediumCornerRadius: number = 12
  static largeCornerRadius: number = 18
}

class AppSpacing {
  static sm: number = 8
  static md: number = 12
  static lg: number = 18
  static xl: number = 26
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
        .fillColor(this.label === this.currentMode ? AppColors.onPrimary : AppColors.onSurface)
      Text(this.label)
        .fontSize(AppTypographyTokens.body.size)
        .fontWeight(AppTypographyTokens.body.weight)
        .fontColor(this.label === this.currentMode ? AppColors.onPrimary : AppColors.onSurface)
    }
    .width(100)
    .height(100)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.label === this.currentMode ? AppColors.primary : AppColors.surfaceVariant)
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
          .fillColor(AppColors.primary)
          .margin({ left: AppSpacing.md })

        Blank()

        Text('ThermoCurve')
          .fontSize(AppTypographyTokens.display.size)
          .fontWeight(AppTypographyTokens.display.weight)
          .fontColor(AppColors.onSurface)

        Blank()

        Image($r('sys.media.ohos_ic_public_arrow_right'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .fillColor(AppColors.secondary)
          .margin({ right: AppSpacing.md })
          .onClick(() => {
            this.targetTemp += 1
          })
      }
      .height(56)
      .width('100%')
      .backgroundColor(AppColors.surfaceVariant)

      // Main content area
      Column() {
        Text('Target Temperature')
          .fontSize(AppTypographyTokens.headline.size)
          .fontWeight(AppTypographyTokens.headline.weight)
          .fontColor(AppColors.onSurface)

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .margin({ top: AppSpacing.md })

        Row() {
          Text('–')
            .fontSize(20)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onPrimary)
            .width(60)
            .height(60)
            .textAlign(TextAlign.Center)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.smallCornerRadius)
            .onClick(() => {
              if (this.targetTemp > 10) {
                this.targetTemp -= 1
              }
            })

          Text('+')
            .fontSize(20)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onPrimary)
            .width(60)
            .height(60)
            .textAlign(TextAlign.Center)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.smallCornerRadius)
            .onClick(() => {
              if (this.targetTemp < 35) {
                this.targetTemp += 1
              }
            })
        }
        .margin({ top: AppSpacing.md })

        Divider()
          .strokeWidth(1)
          .color('rgba(203, 213, 225, 0.5)')
          .width('80%')
          .margin({ top: AppSpacing.xl })

        Text('Mode')
          .fontSize(AppTypographyTokens.headline.size)
          .fontWeight(AppTypographyTokens.headline.weight)
          .fontColor(AppColors.onSurface)
          .margin({ top: AppSpacing.xl })

        Row() {
          ModeButton({
            label: 'Cool',
            iconName: $r('sys.media.ohos_ic_public_arrow_down'),
            currentMode: this.mode,
            onSelect: (selectedMode: string) => {
              this.mode = selectedMode
            }
          })

          ModeButton({
            label: 'Heat',
            iconName: $r('sys.media.ohos_ic_public_arrow_up'),
            currentMode: this.mode,
            onSelect: (selectedMode: string) => {
              this.mode = selectedMode
            }
          })
        }
        .margin({ top: AppSpacing.md })

        Text(`Current Mode: ${this.mode}`)
          .fontSize(AppTypographyTokens.body.size)
          .fontWeight(AppTypographyTokens.body.weight)
          .fontColor(AppColors.onSurface)
          .margin({ top: AppSpacing.lg })
      }
      .width('100%')
      .height('100%')
      .padding(AppSpacing.lg)
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(AppColors.background)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppColors.secondary + '26', 0.0],
          [AppColors.primary + '33', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
  }
}
