@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    { x: 120, y: 200, label: "A1" },
    { x: 300, y: 400, label: "B2" },
    { x: 520, y: 600, label: "C3" }
  ]
  @State scanning: boolean = false

  build() {
    Column({ space: 0 }) {
      // Top Bar
      Text('Invoice Scanner')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .foregroundColor('#FF0F172A')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor('#FFF0F9FF')

      // Main content
      Column({ space: 16 }) {
        // Surface with canvas (simulated with Stack)
        Stack() {
          // Large inner circle (surfaceVariant)
          Button() { }
            .width(200)
            .height(200)
            .borderRadius(100)
            .backgroundColor('#FFE0F2FE')
            .alignSelf(ItemAlign.Center)

          // Markers
          ForEach(this.markers, (marker: Marker) => {
            Button() {
              Text(marker.label)
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#FFFFFFFF')
            }
            .width(24)
            .height(24)
            .borderRadius(12)
            .backgroundColor('#FF06B6D4')
            .position({ x: marker.x, y: marker.y })
          })
        }
        .width('100%')
        .height(400)
        .backgroundColor('rgba(255,255,255,0.9)')
        .borderRadius(20)
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.18)', offsetX: 0, offsetY: 4 })

        // Scanning Active row
        Row({ space: 0 }) {
          Text('Scanning Active')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#FF0F172A')
          Blank().layoutWeight(1)
          Button() {
            Text(this.scanning ? 'ON' : 'OFF')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#FFFFFFFF')
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          }
          .backgroundColor(this.scanning ? '#FF3B82F6' : '#FFE0F2FE')
          .borderRadius(12)
          .onClick(() => {
            this.scanning = !this.scanning
          })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        // Add Marker button
        Button() {
          Text('Add Marker')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#FFFFFFFF')
        }
        .width('100%')
        .height(48)
        .backgroundColor('#FF06B6D4')
        .borderRadius(12)
        .onClick(() => {
          if (this.scanning) {
            const newX: number = Math.floor(Math.random() * 500) + 80
            const newY: number = Math.floor(Math.random() * 500) + 150
            this.markers.push({ x: newX, y: newY, label: 'N' + (this.markers.length + 1).toString() })
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .linearGradient({
        colors: [['rgba(59,130,246,0.3)', 0], ['#FFF0F9FF', 0.5], ['rgba(6,182,212,0.3)', 1]],
        direction: GradientDirection.Bottom
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF0F9FF')
  }
}

interface Marker {
  x: number
  y: number
  label: string
}