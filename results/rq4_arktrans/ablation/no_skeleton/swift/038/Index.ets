@Entry
@Component
struct InvoiceScanner {
  @State scanning: boolean = false
  @State markers: Marker[] = [
    { x: 120, y: 200, label: "A1" },
    { x: 300, y: 400, label: "B2" },
    { x: 520, y: 600, label: "C3" }
  ]

  build() {
    Column() {
      // Top Bar
      Text('Invoice Scanner')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor('#F0F9FF')

      // Main Content Area
      Column({ space: 16 }) {
        // Surface containing the Canvas
        Stack() {
          // Background for shadow effect (simulated with a slightly larger box behind if needed, 
          // but here we apply shadow to the container directly)
          Column() {
            // Canvas simulation using Stack and Circles
            Stack() {
              // Inner circle (surfaceVariant)
              Circle()
                .fill('#E0F2FE')
                .width('80%') // Approximating minDimension / 2.5 ratio visually
                .height('80%')

              // Markers
              ForEach(this.markers, (marker: Marker) => {
                Circle()
                  .fill('#06B6D4')
                  .width(24) // radius 12 * 2
                  .height(24)
                  .position({ x: marker.x, y: marker.y })
              })
            }
            .width('100%')
            .height('100%')
            .padding(12)
          }
          .width('100%')
          .height(400)
          .backgroundColor('#FFFFFF')
          .borderRadius(20)
          .shadow({ radius: 8, color: '#2E000000', offsetY: 4 }) // opacity 0.18 approx #2E
        }

        // Scanning Active Row
        Row() {
          Text('Scanning Active')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0F172A')
          
          Blank()

          // Custom Toggle Implementation
          Row() {
            if (this.scanning) {
              Circle()
                .fill('#3B82F6')
                .width(26)
                .height(26)
                .margin({ right: 22 }) // 50 - 26 - 2 padding
            } else {
              Circle()
                .fill('#BAE6FD')
                .width(26)
                .height(26)
                .margin({ left: 2 })
            }
          }
          .width(50)
          .height(30)
          .backgroundColor(this.scanning ? '#3B82F6' : '#E0F2FE')
          .borderRadius(15)
          .onClick(() => {
            this.scanning = !this.scanning
          })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        // Add Marker Button
        Button('Add Marker')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#06B6D4')
          .borderRadius(12)
          .width('100%')
          .height(48)
          .onClick(() => {
            if (this.scanning) {
              const newMarker: Marker = {
                x: Math.random() * 500 + 40,
                y: Math.random() * 500 + 100,
                label: `N${this.markers.length + 1}`
              }
              this.markers.push(newMarker)
            }
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .linearGradient({
        angle: 90,
        colors: [['#3B82F6', 0.3], ['#F0F9FF', 0.5], ['#06B6D4', 0.3]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}

interface Marker {
  x: number;
  y: number;
  label: string;
}