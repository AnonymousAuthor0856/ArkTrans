@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    { x: 120, y: 200, label: "Store A" },
    { x: 360, y: 400, label: "Store B" }
  ]

  build() {
    Stack() {
      Column({ space: 16 }) {
        // Title
        Text('Product Detail')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#FF111111')

        // Product Card
        Column({ space: 12 }) {
          // Image placeholder
          Button() { }
            .width('100%')
            .height(160)
            .backgroundColor('#FFE5E5E5')

          Text('Monochrome Bag')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#FF111111')

          Text('A minimalist and timeless design piece.')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .foregroundColor('#FF777777')

          Text('$79.00')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#FF111111')

          Button() {
            Text('Add to Cart')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#FFFFFFFF')
          }
          .width('100%')
          .height(48)
          .backgroundColor('#FF111111')
          .borderRadius(10)
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFF9F9F9')
        .borderRadius(14)
        .shadow({
          radius: 8,
          color: 'rgba(0,0,0,0.12)',
          offsetX: 0,
          offsetY: 4
        })

        // Map Area (simulated canvas with markers)
        Stack() {
          // Background
          Button() { }
            .width('100%')
            .height(240)
            .backgroundColor('#FFE5E5E5')
            .borderRadius(14)

          // Markers as small circles
          ForEach(this.markers, (marker: Marker) => {
            Button() {
              Text(marker.label)
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#FFFFFFFF')
            }
            .width(28)
            .height(28)
            .borderRadius(14)
            .backgroundColor('#FF111111')
            .position({ x: marker.x, y: marker.y })
          })
        }
        .width('100%')
        .height(240)
        .padding(16)
        .backgroundColor('#FFF9F9F9')
        .borderRadius(14)

        // Bottom Action Buttons
        Row({ space: 12 }) {
          Button() {
            Text('Add Marker')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#FFFFFFFF')
          }
          .layoutWeight(1)
          .height(44)
          .backgroundColor('#FF333333')
          .borderRadius(10)
          .onClick(() => {
            // Add random marker
            const newX: number = Math.floor(Math.random() * 400) + 50
            const newY: number = Math.floor(Math.random() * 200) + 50
            this.markers.push({ x: newX, y: newY, label: "New" })
          })

          Button() {
            Text('Clear')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#FF111111')
          }
          .layoutWeight(1)
          .height(44)
          .backgroundColor('#FF777777')
          .borderRadius(10)
          .onClick(() => {
            this.markers = []
          })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFFFF')
  }
}

interface Marker {
  x: number
  y: number
  label: string
}