@Entry
@Component
struct Index {
  @State scanning: boolean = false
  @State markers: Marker[] = [
    { x: 120, y: 200, label: 'A1' },
    { x: 300, y: 400, label: 'B2' },
    { x: 520, y: 600, label: 'C3' }
  ]

  private addMarker(): void {
    if (!this.scanning) return
    const newMarker: Marker = {
      x: 80 + Math.random() * 500,
      y: 150 + Math.random() * 500,
      label: 'N' + (this.markers.length + 1)
    }
    this.markers.push(newMarker)
  }

  build() {
    Column() {
      Text('Invoice Scanner')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')
        .margin({ top: 24, bottom: 16 })

      Stack({ alignContent: Alignment.Center }) {
        Canvas(this.canvasSettings)
          .width('100%')
          .height('100%')
          .padding(12)
          .onReady(() => {
            this.drawCanvas()
          })
      }
      .width('100%')
      .height(400)
      .backgroundColor('rgba(255, 255, 255, 0.9)')
      .borderRadius(20)
      .shadow({
        radius: 8,
        color: 'rgba(0, 0, 0, 0.18)',
        offsetY: 4
      })

      Row() {
        Text('Scanning Active')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0F172A')
        Toggle({ type: ToggleType.Switch, isOn: this.scanning })
          .onChange((isOn: boolean) => {
            this.scanning = isOn
          })
          .selectedColor('#3B82F6')
          .switchPointColor('#FFFFFF')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Button('Add Marker', { type: ButtonType.Normal })
        .width('100%')
        .height(48)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#06B6D4')
        .borderRadius(12)
        .onClick(() => {
          this.addMarker()
        })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#F0F9FF')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['rgba(6, 182, 212, 0.3)', 0.0],
        ['#F0F9FF', 0.5],
        ['rgba(59, 130, 246, 0.3)', 1.0]
      ]
    })
  }

  private canvasSettings: CanvasRenderingContext2D = new CanvasRenderingContext2D()

  private drawCanvas(): void {
    const ctx = this.canvasSettings
    const w = 360
    const h = 376
    const centerX = w / 2
    const centerY = h / 2
    const radius = Math.min(w, h) / 2.5

    ctx.beginPath()
    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2)
    ctx.fillStyle = '#E0F2FE'
    ctx.fill()

    for (let i = 0; i < this.markers.length; i++) {
      const m = this.markers[i]
      ctx.beginPath()
      ctx.arc(m.x, m.y, 12, 0, Math.PI * 2)
      ctx.fillStyle = '#06B6D4'
      ctx.fill()
    }
  }
}

interface Marker {
  x: number
  y: number
  label: string
}
