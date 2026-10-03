interface Marker {
  x: number
  y: number
  label: string
}

@Entry
@Component
struct InvoiceScannerPage {
  @State markers: Marker[] = [
    { x: 120, y: 200, label: 'A1' },
    { x: 300, y: 400, label: 'B2' },
    { x: 520, y: 600, label: 'C3' }
  ]
  @State scanning: boolean = false
  @State canvasWidth: number = 0
  @State canvasHeight: number = 0
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  @State canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  aboutToUpdate(): void {
    if (this.canvasWidth > 0 && this.canvasHeight > 0) {
      this.doDraw()
    }
  }

  doDraw(): void {
    const ctx = this.canvasCtx
    const w = this.canvasWidth
    const h = this.canvasHeight
    ctx.clearRect(0, 0, w, h)
    const centerX = w / 2
    const centerY = h / 2
    const radius = Math.min(w, h) / 2.5
    ctx.beginPath()
    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2)
    ctx.fillStyle = '#E0F2FE'
    ctx.fill()
    for (const m of this.markers) {
      ctx.beginPath()
      ctx.arc(m.x, m.y, 12, 0, Math.PI * 2)
      ctx.fillStyle = '#06B6D4'
      ctx.fill()
    }
  }

  build() {
    Column() {
      Text('Invoice Scanner')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor('#F0F9FF')

      Column({ space: 16 }) {
        // Scanner card with markers
        Stack({ alignContent: Alignment.Center }) {
          Canvas(this.canvasCtx)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.doDraw()
            })
            .onAreaChange((oldVal: Area, newVal: Area) => {
              this.canvasWidth = newVal.width as number
              this.canvasHeight = newVal.height as number
            })
        }
        .width('100%')
        .height(400)
        .backgroundColor('rgba(255,255,255,0.9)')
        .borderRadius(20)
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.18)', offsetY: 4 })
        .padding(12)

        // Scanning row
        Row() {
          Text('Scanning Active')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0F172A')
          Toggle({ type: ToggleType.Switch, isOn: this.scanning })
            .onChange((value: boolean) => {
              this.scanning = value
            })
            .selectedColor('#3B82F6')
            .switchPointColor('#FFFFFF')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // Add Marker button
        Button('Add Marker')
          .width('100%')
          .height(48)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#06B6D4')
          .borderRadius(12)
          .onClick(() => {
            if (this.scanning) {
              const newMarker: Marker = {
                x: 80 + Math.random() * 500,
                y: 150 + Math.random() * 500,
                label: 'N' + (this.markers.length + 1)
              }
              this.markers.push(newMarker)
            }
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [['rgba(59,130,246,0.3)', 0], ['#F0F9FF', 0.5], ['rgba(6,182,212,0.3)', 1]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}
