import { drawing } from '@kit.ArkGraphics'

interface ChartRect {
  width: number;
  height: number;
}

@Entry
@Component
struct RootScreen {
  @State selectedChip: string = 'BTC'
  @State progress: number = 0.6
  @State isAutoUpdate: boolean = true

  private ctx: drawing.DrawingContext = new drawing.DrawingContext()

  build() {
    Column() {
      // Top Bar
      Text('Crypto Market')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 40, bottom: 24 })

      // Chips Row
      Row({ space: 12 }) {
        this.renderChip('BTC')
        this.renderChip('ETH')
        this.renderChip('SOL')
        this.renderChip('ADA')
      }
      .justifyContent(FlexAlign.Start)
      .width('100%')
      .padding({ left: 16, right: 16 })

      // Chart Surface
      Column() {
        Canvas(this.ctx)
          .width('100%')
          .height(260)
          .onReady(() => {
            const canvasRenderingContext2D = this.ctx.getDrawingContext() as drawing.CanvasRenderingContext2D
            this.drawChart(canvasRenderingContext2D, { width: 375, height: 260 })
          })
      }
      .width('100%')
      .height(260)
      .backgroundColor('#FFF')
      .borderRadius(20)
      .shadow({ radius: 8, color: '#2D000000', offsetY: 4 })
      .margin({ top: 16, left: 16, right: 16 })

      // Price Variation Label
      Text('Price Variation')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFA8A8')
        .margin({ top: 16 })

      // Progress Bar
      Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(8)
        .color('#FFA8A8')
        .trackColor('#F7F7F7')
        .margin({ top: 16, left: 16, right: 16 })

      // Auto Update Row
      Row() {
        Text('Auto Update')
          .fontSize(14)
          .fontColor('#1E1E1E')
        
        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.isAutoUpdate })
          .onChange((isOn: boolean) => {
            this.isAutoUpdate = isOn
          })
          .selectedColor('#FFE1A8')
          .width(50)
          .height(30)
      }
      .width('100%')
      .padding({ left: 16, right: 16 })
      .margin({ top: 16 })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#A8FFE1', 0], ['#FFFCF5', 0.5], ['#FFE1A8', 1]]
    })
  }

  @Builder
  private renderChip(label: string) {
    Button() {
      Text(label)
        .fontSize(14)
        .fontColor('#1E1E1E')
    }
    .type(ButtonType.Normal)
    .backgroundColor(this.selectedChip === label ? '#FFA8A8' : '#F7F7F7')
    .borderRadius(8)
    .width(80)
    .height(40)
    .onClick(() => {
      this.selectedChip = label
    })
  }

  private drawChart(ctx: drawing.CanvasRenderingContext2D, rect: ChartRect): void {
    const w = rect.width
    const h = rect.height
    const step = w / 30
    let prevY = h / 2
    
    ctx.beginPath()
    ctx.moveTo(0, prevY)

    for (let i = 0; i <= 30; i++) {
      const x = i * step
      const y = h / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (h / 3)
      ctx.lineTo(x, y)
      prevY = y
    }

    ctx.lineWidth = 5
    ctx.strokeStyle = '#FFA8A8'
    ctx.stroke()
  }
}