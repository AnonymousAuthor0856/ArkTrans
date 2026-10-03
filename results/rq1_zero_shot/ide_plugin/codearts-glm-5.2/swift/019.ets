class AppTokens {
  static readonly Colors = {
    primary: '#FF8B5CF6',
    secondary: '#FFD946EF',
    tertiary: '#FF3B82F6',
    background: '#FFF9F5FF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFF1E9FE',
    outline: '#FFE3D7FE',
    success: '#FF22C55E',
    warning: '#FFFACC15',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF1E1E1E',
    onSurface: '#FF1E1E1E'
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }

  static readonly Shapes = {
    small: 8,
    medium: 14,
    large: 22
  }
}

@Entry
@Component
struct SubtitleEditor {
  @State fontSize: number = 23.0
  @State syncProgress: number = 0.3

  build() {
    Column() {
      Stack() {
        Text('Subtitle Editor')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)
      .alignContent(Alignment.Center)

      Column() {
        Stack() {
          Text('Sample Subtitle Line')
            .fontSize(this.fontSize)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(200)
        .borderRadius(22)
        .backgroundColor(AppTokens.Colors.surface)
        .alignContent(Alignment.Center)
        .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 6 })

        Text(`Font Size: ${Math.floor(this.fontSize)}sp`)
          .fontSize(14)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: 24 })

        Slider({
          value: this.fontSize,
          min: 16,
          max: 48,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .blockColor(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .selectedColor(AppTokens.Colors.primary)
          .onChange((value: number, mode: SliderChangeMode) => {
            this.fontSize = value
          })

        Text('Sync Progress')
          .fontSize(14)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: 24 })

        Progress({ value: this.syncProgress, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)

        Row() {
          Button('Sync +') {
          }
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .layoutWeight(1)
          .height(48)
          .borderRadius(14)
          .backgroundColor(AppTokens.Colors.primary)
          .onClick(() => {
            this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0)
          })

          Button('Sync -') {
          }
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
          .layoutWeight(1)
          .height(48)
          .borderRadius(14)
          .backgroundColor(AppTokens.Colors.secondary)
          .margin({ left: 12 })
          .onClick(() => {
            this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0)
          })
        }
        .width('100%')
        .margin({ top: 24 })
      }
      .padding(16)
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}