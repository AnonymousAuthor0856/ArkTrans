interface Marker {
  x: number;
  y: number;
  label: string;
}

@Entry
@Component
struct InvoiceScanner {
  @State markers: Marker[] = [
    { x: 120, y: 200, label: 'A1' },
    { x: 300, y: 400, label: 'B2' },
    { x: 520, y: 600, label: 'C3' }
  ]
  @State scanning: boolean = false

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Invoice Scanner')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F0F9FF')

      // Main Content Area with Gradient Background
      Column({ space: 16 }) {
        // Canvas Card
        Column() {
          Stack() {
            // Base white card background
            Column()
              .width('100%')
              .height('100%')
              .backgroundColor('#FFFFFF')
              .borderRadius(20)

            // Inner content area
            Column() {
              // Simulated Canvas Content
              Stack() {
                // Large light blue circle (simulating the scanned area)
                Circle()
                  .width(280)
                  .height(280)
                  .fill('#E0F2FE')

                // Markers
                ForEach(this.markers, (marker: Marker) => {
                  Circle()
                    .width(12)
                    .height(12)
                    .fill('#06B6D4')
                    .position({ x: marker.x, y: marker.y })
                })
              }
              .width('100%')
              .height('100%')
              .padding(12)
            }
            .width('100%')
            .height('100%')
            .margin(16)
            .borderRadius(8)
            .backgroundColor('#FFFFFF')
          }
          .width('100%')
          .height(400)
          .shadow({ radius: 8, color: '#2E000000', offsetY: 4 })
          .borderRadius(20)
        }

        // Controls Row
        Row() {
          Text('Scanning Active')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0F172A')

          Blank()

          Toggle({ type: ToggleType.Switch, isOn: this.scanning })
            .onChange((isOn: boolean) => {
              this.scanning = isOn
            })
            .selectedColor('#3B82F6')
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        // Action Button
        Button('Add Marker')
          .width('100%')
          .height(48)
          .backgroundColor('#06B6D4')
          .fontColor('#FFFFFF')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .borderRadius(12)
          .onClick(() => {
            if (this.scanning) {
              const newX = Math.random() * 400 + 80
              const newY = Math.random() * 500 + 150
              this.markers.push({
                x: newX,
                y: newY,
                label: `N${this.markers.length + 1}`
              })
            }
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .linearGradient({
        angle: 180,
        colors: [['#3B82F6', 0.3], ['#F0F9FF', 0.5], ['#06B6D4', 0.3]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}