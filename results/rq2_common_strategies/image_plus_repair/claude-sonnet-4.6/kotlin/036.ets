import { curves } from '@kit.ArkUI'

// Color tokens
const COLOR_PRIMARY = '#FFFFA8A8'
const COLOR_SECONDARY = '#FFFFE1A8'
const COLOR_TERTIARY = '#FFA8FFE1'
const COLOR_BACKGROUND = '#FFFFFCF5'
const COLOR_SURFACE = '#FFFFFFFF'
const COLOR_SURFACE_VARIANT = '#FFF7F7F7'
const COLOR_OUTLINE = '#FFE2E2E2'
const COLOR_ON_SURFACE = '#FF1E1E1E'
const COLOR_ON_PRIMARY = '#FF1E1E1E'
const COLOR_SUCCESS = '#FF22C55E'

interface ChipItem {
  label: string
  selected: boolean
}

@Entry
@Component
struct RootScreen {
  @State selectedChip: string = 'BTC'
  @State progress: number = 0.6
  @State isAutoUpdate: boolean = true

  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA']

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Crypto Market')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(COLOR_BACKGROUND)

      // Main content with gradient background
      Column({ space: 16 }) {
        // Filter Chips Row
        Row({ space: 12 }) {
          ForEach(this.chips, (chip: string) => {
            Text(chip)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLOR_ON_PRIMARY)
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .backgroundColor(this.selectedChip === chip ? COLOR_PRIMARY : COLOR_SURFACE_VARIANT)
              .borderRadius(20)
              .onClick(() => {
                this.selectedChip = chip
              })
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        // Chart Card
        Column() {
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawChart()
            })
        }
        .width('100%')
        .height(260)
        .backgroundColor(COLOR_SURFACE)
        .borderRadius(20)
        .shadow({ radius: 8, color: '#1E000000', offsetX: 0, offsetY: 4 })
        .padding(16)

        // Price Variation Label
        Text('Price Variation')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_PRIMARY)

        // Progress Bar
        Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(COLOR_PRIMARY)
          .backgroundColor(COLOR_SURFACE_VARIANT)
          .style({ strokeWidth: 8, enableScanEffect: false })

        // Auto Update Row
        Row() {
          Text('Auto Update')
            .fontSize(14)
            .fontColor(COLOR_ON_SURFACE)

          Toggle({ type: ToggleType.Switch, isOn: this.isAutoUpdate })
            .selectedColor(COLOR_PRIMARY)
            .switchPointColor(COLOR_SECONDARY)
            .onChange((isOn: boolean) => {
              this.isAutoUpdate = isOn
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#4DFFE1A8', 0.0],
          [COLOR_BACKGROUND, 0.5],
          ['#4DA8FFE1', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }

  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  )

  private drawChart() {
    const ctx = this.canvasContext
    const w = ctx.width
    const h = ctx.height
    const step = w / 30

    ctx.clearRect(0, 0, w, h)
    ctx.strokeStyle = COLOR_PRIMARY
    ctx.lineWidth = 5
    ctx.lineJoin = 'round'
    ctx.lineCap = 'round'

    ctx.beginPath()
    let prevY = h / 2
    for (let i = 0; i <= 30; i++) {
      const x = i * step
      const y = h / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (h / 3)
      if (i === 0) {
        ctx.moveTo(x, y)
      } else {
        ctx.lineTo(x, y)
      }
      prevY = y
    }
    ctx.stroke()
  }
}