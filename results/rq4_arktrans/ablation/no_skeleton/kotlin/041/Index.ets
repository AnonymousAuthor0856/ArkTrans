@Entry
@Component
struct ProductDetail {
  @State markers: Marker[] = [
    { x: 120, y: 200, label: 'Store A' },
    { x: 360, y: 400, label: 'Store B' }
  ]

  build() {
    Column({ space: 16 }) {
      Text('Product Detail')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111111')

      // Card
      Column() {
        Image($r('app.media.startIcon'))
          .width('100%')
          .height(160)
          .objectFit(ImageFit.Cover)
          .backgroundColor('#E5E5E5')

        Text('Monochrome Bag')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111111')
          .margin({ top: 12 })

        Text('A minimalist and timeless design piece.')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#777777')
          .margin({ top: 4 })

        Text('$79.00')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111111')
          .margin({ top: 12 })

        Button('Add to Cart')
          .width('100%')
          .height(48)
          .backgroundColor('#111111')
          .fontColor('#FFFFFF')
          .borderRadius(10)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ top: 16 })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F9F9F9')
      .borderRadius(14)
      .shadow({ radius: 8, color: '#1F000000', offsetY: 4 })

      // Map Area
      Stack() {
        Rect().fill(Color.Gray).opacity(0.1)
        
        ForEach(this.markers, (marker: Marker) => {
          Circle({ width: 28, height: 28 })
            .fill('#111111')
            .position({ x: marker.x, y: marker.y })
        })
      }
      .width('100%')
      .height(240)
      .backgroundColor('#F9F9F9')
      .borderRadius(14)
      .padding(16)

      // Action Buttons
      Row({ space: 12 }) {
        Button('Add Marker')
          .layoutWeight(1)
          .height(44)
          .backgroundColor('#333333')
          .fontColor('#FFFFFF')
          .borderRadius(10)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            this.markers.push({
              x: Math.random() * 300 + 50,
              y: Math.random() * 200 + 50,
              label: 'New'
            })
          })

        Button('Clear')
          .layoutWeight(1)
          .height(44)
          .backgroundColor('#777777')
          .fontColor('#111111')
          .borderRadius(10)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            this.markers = []
          })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
  }
}

interface Marker {
  x: number;
  y: number;
  label: string;
}