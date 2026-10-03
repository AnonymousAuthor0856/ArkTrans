class AppTokens {
  static readonly Colors = {
    primary: '#FFFFA8A8',
    secondary: '#FFFFE1A8',
    tertiary: '#FFA8FFE1',
    background: '#FFFFFCF5',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFF7F7F7',
    outline: '#FFE2E2E2',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FF1E1E1E',
    onSecondary: '#FF1E1E1E',
    onTertiary: '#FF1E1E1E',
    onBackground: '#FF1E1E1E',
    onSurface: '#FF1E1E1E'
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
struct CryptoMarket {
  @State selectedChip: string = 'BTC'
  @State progress: number = 0.6
  @State isAutoUpdate: boolean = true

  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA']

  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  private drawCanvas() {
    const ctx = this.canvasContext
    const w: number = 300
    const h: number = 230
    const step = w / 30

    ctx.clearRect(0, 0, w, h)

    ctx.beginPath()
    ctx.moveTo(-step, h / 2)

    for (let i = 0; i <= 30; i++) {
      const x = i * step
      const y = h / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (h / 3)
      ctx.lineTo(x, y)
    }

    ctx.strokeStyle = '#FFFFA8A8'
    ctx.lineWidth = 5
    ctx.stroke()
  }

  build() {
    Column() {
      Text('Crypto Market')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .padding({ top: 16, bottom: 16 })
        .textAlign(TextAlign.Center)
        .backgroundColor(AppTokens.Colors.background)

      Column() {
        Row() {
          ForEach(this.chips, (chip: string) => {
            Text(chip)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onPrimary)
              .padding({ left: 12, right: 12, top: 8, bottom: 8 })
              .borderRadius(6)
              .backgroundColor(this.selectedChip === chip ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
              .onClick(() => {
                this.selectedChip = chip
              })
              .margin({ left: chip === 'BTC' ? 0 : 12 })
          })
        }
        .width('100%')

        Stack() {
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .padding(16)
            .onReady(() => {
              this.drawCanvas()
            })
        }
        .width('100%')
        .height(260)
        .borderRadius(20)
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })
        .margin({ top: 16 })

        Text('Price Variation')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: 16 })

        Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)

        Row() {
          Text('Auto Update')
            .fontSize(14)
            .fontColor(AppTokens.Colors.onSurface)
          Blank()
          Toggle({ type: ToggleType.Switch, isOn: this.isAutoUpdate })
            .selectedColor(AppTokens.Colors.primary)
            .onChange((value: boolean) => {
              this.isAutoUpdate = value
            })
        }
        .width('100%')
        .margin({ top: 16 })
      }
      .padding(16)
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}