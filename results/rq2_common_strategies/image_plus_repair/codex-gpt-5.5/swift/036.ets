@Entry
@Component
struct CryptoMarketPage {
  @State selectedChip: string = 'BTC'
  @State progress: number = 0.6
  @State isAutoUpdate: boolean = true

  private readonly primary: string = '#FFA8A8'
  private readonly secondary: string = '#FFE1A8'
  private readonly tertiary: string = '#A8FFE1'
  private readonly pageBackground: string = '#FFFCF5'
  private readonly ink: string = '#1E1E1E'
  private chartContext: CanvasRenderingContext2D =
    new CanvasRenderingContext2D(new RenderingContextSettings(true))

  build() {
    Column() {
      Column() {
        Text('Crypto Market')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.ink)
      }
      .width('100%')
      .height(143)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(this.pageBackground)

      Column({ space: 16 }) {
        Row({ space: 12 }) {
          ForEach(['BTC', 'ETH', 'SOL', 'ADA'], (symbol: string) => {
            Text(symbol)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.ink)
              .padding({ left: 12, right: 12, top: 8, bottom: 8 })
              .backgroundColor(this.selectedChip === symbol ? this.primary : '#F7F7F7')
              .borderRadius(6)
              .onClick(() => {
                this.selectedChip = symbol
              })
          }, (symbol: string) => symbol)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Stack() {
          Canvas(this.chartContext)
            .onReady(() => {
              const width = this.chartContext.width
              const height = this.chartContext.height
              const step = width / 30
              this.chartContext.beginPath()
              this.chartContext.moveTo(-step, height / 2)
              for (let i = 0; i <= 30; i++) {
                const x = i * step
                const y = height / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (height / 3)
                this.chartContext.lineTo(x, y)
              }
              this.chartContext.strokeStyle = this.primary
              this.chartContext.lineWidth = 5
              this.chartContext.stroke()
          })
          .width('100%')
          .height('100%')
          .padding(16)
        }
        .width('100%')
        .height(260)
        .backgroundColor('#FFFFFF')
        .borderRadius(20)
        .shadow({ radius: 8, color: '#2E000000', offsetY: 4 })

        Text('Price Variation')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.primary)

        Stack({ alignContent: Alignment.Start }) {
          Row().width('100%').height(8).backgroundColor('#F7F7F7').borderRadius(4)
          Row().width(`${this.progress * 100}%`).height(8).backgroundColor(this.primary).borderRadius(4)
        }
        .width('100%')
        .height(8)

        Row() {
          Text('Auto Update')
            .fontSize(14)
            .fontColor(this.ink)
          Blank()
          Stack({ alignContent: Alignment.Center }) {
            Row()
              .width(51)
              .height(31)
              .backgroundColor(this.isAutoUpdate ? this.primary : '#F7F7F7')
              .borderRadius(16)
            Row() {
              Blank()
              Circle()
                .width(27)
                .height(27)
                .fill(this.isAutoUpdate ? this.secondary : '#E2E2E2')
                .shadow({ radius: 2, color: '#1A000000', offsetY: 1 })
            }
            .width(47)
            .height(27)
            .justifyContent(this.isAutoUpdate ? FlexAlign.End : FlexAlign.Start)
          }
          .width(51)
          .height(31)
          .onClick(() => {
            this.isAutoUpdate = !this.isAutoUpdate
          })
        }
        .width('100%')
        .height(31)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .linearGradient({
        angle: 180,
        colors: [
          ['#4DFFE1A8', 0],
          [this.pageBackground, 0.5],
          ['#4DA8FFE1', 1]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.pageBackground)
  }
}
