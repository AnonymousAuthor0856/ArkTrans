@Entry
@Component
struct CryptoMarketPage {
  @State selectedChip: string = 'BTC'
  @State progress: number = 0.6
  @State isAutoUpdate: boolean = true
  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA']
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawChart(): void {
    const w: number = this.context.width
    const h: number = this.context.height
    const step: number = w / 30
    this.context.strokeStyle = '#FFA8A8'
    this.context.lineWidth = 5
    this.context.beginPath()
    for (let i = 0; i <= 30; i++) {
      const x: number = i * step
      const y: number = h / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (h / 3)
      if (i === 0) {
        this.context.moveTo(x, y)
      } else {
        this.context.lineTo(x, y)
      }
    }
    this.context.stroke()
  }

  @Builder
  Chip(label: string) {
    Text(label)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor('#1E1E1E')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(this.selectedChip === label ? '#FFA8A8' : '#F7F7F7')
      .borderRadius(16)
      .onClick(() => {
        this.selectedChip = label
      })
  }

  build() {
    Column() {
      Text('Crypto Market')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })

      Column({ space: 16 }) {
        Row({ space: 12 }) {
          ForEach(this.chips, (item: string) => {
            this.Chip(item)
          }, (item: string) => item)
        }

        Stack() {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawChart()
            })
        }
        .width('100%')
        .height(260)
        .backgroundColor('#FFFFFF')
        .borderRadius(20)
        .padding(16)

        Text('Price Variation')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFA8A8')

        Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color('#FFA8A8')
          .backgroundColor('#F7F7F7')

        Row() {
          Text('Auto Update')
            .fontSize(14)
            .fontColor('#1E1E1E')
          Toggle({ type: ToggleType.Switch, isOn: this.isAutoUpdate })
            .onChange((isOn: boolean) => {
              this.isAutoUpdate = isOn
            })
            .selectedColor('#FFE1A8')
            .switchPointColor('#E2E2E2')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [['#4DFFE1A8', 0.0], ['#FFFCF5', 0.5], ['#4DA8FFE1', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFCF5')
  }
}
