class AppTokens {
  static readonly Colors = {
    primary: '#FF38BDF8',
    secondary: '#FFA78BFA',
    tertiary: '#FF7DD3FC',
    background: '#FFF1F5F9',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE2E8F0',
    outline: '#FFCBD5E1',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF1E1E1E',
    onTertiary: '#FF1E1E1E',
    onBackground: '#FF1E1E1E',
    onSurface: '#FF1E1E1E',
    surface70: '#B3FFFFFF',
    surfaceVariant80: '#CCE2E8F0'
  }

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }

  static readonly Shapes = {
    small: 6,
    medium: 12,
    large: 20
  }
}

@Entry
@Component
struct GlassDocReader {
  @State scrollOffset: number = 0

  build() {
    Column() {
      Text('Glass Doc Reader')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .padding({ top: 36, bottom: 16 })
        .textAlign(TextAlign.Center)
        .backgroundColor(AppTokens.Colors.background)

      Stack() {
        Column() {
          Text('Document Reader')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.primary)

          ForEach([1, 2, 3, 4, 5, 6, 7, 8], (index: number) => {
            Text(`This is a sample line of text content number ${index}.`)
              .fontSize(14)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ top: 12 })
          })
        }
        .width('90%')
        .height(400)
        .padding(16)
        .borderRadius(20)
        .backgroundColor(AppTokens.Colors.surface70)
        .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })
        .offset({ y: this.scrollOffset / 5 })
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              this.scrollOffset += event.offsetY
            })
        )
      }
      .width('100%')
      .layoutWeight(1)
      .alignContent(Alignment.Center)
      .backgroundColor(AppTokens.Colors.surfaceVariant80)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}