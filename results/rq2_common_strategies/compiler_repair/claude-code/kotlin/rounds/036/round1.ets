class AppColors {
  primary: string = '#FFA8A8'
  secondary: string = '#FFE1A8'
  tertiary: string = '#A8FFE1'
  background: string = '#FFFCF5'
  surface: string = '#FFFFFF'
  surfaceVariant: string = '#F7F7F7'
  outline: string = '#E2E2E2'
  onSurface: string = '#1E1E1E'
  onPrimary: string = '#1E1E1E'
}

@Entry
@Component
struct CryptoMarketScreen {
  @State selectedChip: string = 'BTC'
  @State progress: number = 0.6
  @State isAutoUpdate: boolean = true
  private colors: AppColors = new AppColors()
  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA']

  build() {
    Column() {
      Text('Crypto Market')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.colors.onSurface)
        .margin({ top: 24, bottom: 16 })

      Row() {
        ForEach(this.chips, (chip: string) => {
          Text(chip)
            .fontSize(14)
            .fontColor(this.colors.onPrimary)
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .backgroundColor(this.selectedChip === chip ? this.colors.primary : this.colors.surfaceVariant)
            .borderRadius(6)
            .onClick(() => {
              this.selectedChip = chip
            })
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)

      Stack() {
        Canvas(this.chartSettings)
          .width('100%')
          .height(260)
          .backgroundColor(this.colors.surface)
          .borderRadius(20)
          .shadow({ radius: 8, color: 'rgba(0,0,0,0.10)', offsetY: 4 })
          .onReady(() => {
            this.drawChart()
          })
      }
      .width('100%')
      .height(260)
      .margin({ top: 16 })

      Text('Price Variation')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.colors.primary)
        .margin({ top: 16 })

      Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(8)
        .color(this.colors.primary)
        .backgroundColor(this.colors.surfaceVariant)
        .borderRadius(4)
        .margin({ top: 12 })

      Row() {
        Text('Auto Update')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(this.colors.onSurface)

        Toggle({ type: ToggleType.Switch, isOn: this.isAutoUpdate })
          .selectedColor(this.colors.secondary)
          .switchPointColor('#FFFFFF')
          .onChange((isOn: boolean) => {
            this.isAutoUpdate = isOn
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 16 })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor(this.colors.background)
  }

  private chartSettings: CanvasRenderingContext2D = new CanvasRenderingContext2D()

  private drawChart(): void {
    const ctx = this.chartSettings
    const canvasWidth = 360
    const canvasHeight = 228
    const padding = 16
    const w = canvasWidth - padding * 2
    const h = canvasHeight - padding * 2
    const step = w / 30

    ctx.clearRect(0, 0, canvasWidth, canvasHeight)

    ctx.strokeStyle = this.colors.primary
    ctx.lineWidth = 5
    ctx.lineCap = 'round'
    ctx.lineJoin = 'round'

    ctx.beginPath()
    for (let i = 0; i <= 30; i++) {
      const x = padding + i * step
      const y = padding + h / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (h / 3)
      if (i === 0) {
        ctx.moveTo(x, y)
      } else {
        ctx.lineTo(x, y)
      }
    }
    ctx.stroke()
  }
}
