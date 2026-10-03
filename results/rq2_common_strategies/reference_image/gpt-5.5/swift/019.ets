class AppTokens {
  static readonly primary: ResourceColor = '#8B5CF6'
  static readonly secondary: ResourceColor = '#D946EF'
  static readonly tertiary: ResourceColor = '#3B82F6'
  static readonly background: ResourceColor = '#F9F5FF'
  static readonly surface: ResourceColor = '#FFFFFF'
  static readonly surfaceVariant: ResourceColor = '#F1E9FE'
  static readonly outline: ResourceColor = '#E3D7FE'
  static readonly success: ResourceColor = '#22C55E'
  static readonly warning: ResourceColor = '#FACC15'
  static readonly error: ResourceColor = '#EF4444'
  static readonly onPrimary: ResourceColor = '#FFFFFF'
  static readonly onSecondary: ResourceColor = '#FFFFFF'
  static readonly onTertiary: ResourceColor = '#FFFFFF'
  static readonly onBackground: ResourceColor = '#1E1E1E'
  static readonly onSurface: ResourceColor = '#1E1E1E'

  static readonly displaySize: number = 48
  static readonly titleSize: number = 18
  static readonly bodySize: number = 14
  static readonly labelSize: number = 42

  static readonly smallRadius: number = 8
  static readonly mediumRadius: number = 14
  static readonly largeRadius: number = 22

  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32

  static readonly level1Elevation: number = 4
  static readonly level1Dy: number = 2
  static readonly level1ShadowColor: ResourceColor = '#24000000'

  static readonly level2Elevation: number = 8
  static readonly level2Dy: number = 6
  static readonly level2ShadowColor: ResourceColor = '#2E000000'

  static readonly pageGradientColors: Array<[ResourceColor, number]> = [
    ['#F1E9FE', 0.0],
    ['#F9F5FF', 0.5],
    ['#FFFFFF', 1.0]
  ]
}

@Entry
@Component
struct SubtitleEditorApp {
  @State private fontSize: number = 23
  @State private syncProgress: number = 0.3

  build() {
    Column() {
      Row() {
        Text('Subtitle Editor')
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .width('100%')
      .height(44)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.background)

      Divider()
        .width('100%')
        .height(1)
        .strokeWidth(1)
        .color('#22000000')

      Column({ space: AppTokens.xl }) {
        Stack({ alignContent: Alignment.Center }) {
          Text('Sample Subtitle Line')
            .fontSize(this.fontSize)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppTokens.onSurface)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(200)
        .backgroundColor(AppTokens.surface)
        .borderRadius(AppTokens.largeRadius)
        .shadow({
          radius: AppTokens.level2Elevation,
          color: AppTokens.level2ShadowColor,
          offsetX: 0,
          offsetY: AppTokens.level2Dy
        })

        Text('Font Size: ' + Math.round(this.fontSize).toString() + 'sp')
          .fontSize(AppTokens.bodySize)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppTokens.onSurface)

        Slider({
          value: this.fontSize,
          min: 16,
          max: 48,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .selectedColor(AppTokens.primary)
          .trackColor('#DED9E8')
          .blockColor(AppTokens.surface)
          .showTips(false)
          .onChange((value: number) => {
            this.fontSize = value
          })

        Text('Sync Progress')
          .fontSize(AppTokens.bodySize)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppTokens.onSurface)

        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(6)
            .backgroundColor('#DED9E8')
            .borderRadius(3)

          Row()
            .width((this.syncProgress * 100).toString() + '%')
            .height(6)
            .backgroundColor(AppTokens.primary)
            .borderRadius(3)
        }
        .width('100%')
        .height(6)

        Row({ space: AppTokens.md }) {
          Button({ type: ButtonType.Normal }) {
            Text('Sync +')
              .fontSize(AppTokens.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.onPrimary)
          }
          .layoutWeight(1)
          .height(48)
          .backgroundColor(AppTokens.primary)
          .borderRadius(AppTokens.mediumRadius)
          .onClick(() => {
            this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0)
          })

          Button({ type: ButtonType.Normal }) {
            Text('Sync -')
              .fontSize(AppTokens.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.onSecondary)
          }
          .layoutWeight(1)
          .height(48)
          .backgroundColor(AppTokens.secondary)
          .borderRadius(AppTokens.mediumRadius)
          .onClick(() => {
            this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0)
          })
        }
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: AppTokens.lg,
        right: AppTokens.lg,
        top: AppTokens.lg,
        bottom: 50
      })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: AppTokens.pageGradientColors
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)
  }
}