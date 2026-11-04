class Marker {
  x: number
  y: number
  label: string

  constructor(x: number, y: number, label: string) {
    this.x = x
    this.y = y
    this.label = label
  }
}

@Entry
@Component
struct Index {
  @State markers: Marker[] = [
    new Marker(120, 200, 'Store A'),
    new Marker(360, 400, 'Store B')
  ]

  private newMarker(): Marker {
    const index = this.markers.length + 1
    const x = 100 + ((index * 73) % 400)
    const y = 150 + ((index * 91) % 300)
    return new Marker(x, y, 'New')
  }

  @Builder
  ProductCard() {
    Column() {
      Rect()
        .width('100%')
        .height(160)
        .fill('#E5E5E5')

      Text('Monochrome Bag')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#111111')
        .width('100%')
        .margin({ top: 12 })

      Text('A minimalist and timeless design piece.')
        .fontSize(14)
        .fontColor('#777777')
        .width('100%')
        .margin({ top: 12 })

      Text('$79.00')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#111111')
        .width('100%')
        .margin({ top: 12 })

      Button('Add to Cart')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .width('100%')
        .height(48)
        .backgroundColor('#111111')
        .borderRadius(10)
        .margin({ top: 12 })
    }
    .width('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor('#F9F9F9')
    .borderRadius(14)
    .shadow({ radius: 8, color: '#1F000000', offsetY: 4 })
  }

  @Builder
  MapArea() {
    Stack() {
      Rect()
        .width('100%')
        .height('100%')
        .radius(14)
        .fill('#E5E5E5')

      ForEach(this.markers, (marker: Marker) => {
        Stack() {
          Circle()
            .width(28)
            .height(28)
            .fill('#111111')
          Text(marker.label.substring(0, 1))
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
        }
        .width(34)
        .height(34)
        .translate({ x: marker.x / 2 - 150, y: marker.y / 2 - 120 })
      }, (marker: Marker, index: number) => `${marker.label}${index}`)
    }
    .width('100%')
    .height(240)
    .padding(16)
    .backgroundColor('#F9F9F9')
    .borderRadius(14)
  }

  build() {
    Stack() {
      Column() {
        Text('Product Detail')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111111')
          .width('100%')

        Column() {
          this.ProductCard()
        }
        .margin({ top: 16 })

        Column() {
          this.MapArea()
        }
        .margin({ top: 16 })

        Row() {
          Button('Add Marker')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .height(44)
            .layoutWeight(1)
            .backgroundColor('#333333')
            .borderRadius(10)
            .onClick(() => {
              this.markers = [...this.markers, this.newMarker()]
            })

          Blank()
            .width(12)

          Button('Clear')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#111111')
            .height(44)
            .layoutWeight(1)
            .backgroundColor('#777777')
            .borderRadius(10)
            .onClick(() => {
              this.markers = []
            })
        }
        .width('100%')
        .margin({ top: 16 })
      }
      .width('100%')
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
