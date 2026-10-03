@Entry
@Component
struct Index {
  @State markers: Array<Marker> = [new Marker(120, 200, "Store A"), new Marker(360, 400, "Store B")]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        Text('Product Detail')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111111')

        Column() {
          Column({ space: 12 }) {
            Stack({ alignContent: Alignment.Center }) {
              // Placeholder for image
            }
              .width('100%')
              .height(160)
              .backgroundColor('#E5E5E5')

            Text('Monochrome Bag')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111111')

            Text('A minimalist and timeless design piece.')
              .fontSize(16)
              .fontColor('#777777')

            Text('$79.00')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111111')

            Button() {
              Text('Add to Cart')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
            }
              .width('100%')
              .height(48)
              .backgroundColor('#111111')
              .borderRadius(12)
          }
            .width('100%')
            .padding(16)
        }
          .width('100%')
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })

        Stack({ alignContent: Alignment.Center }) {
          Canvas()
            .width('100%')
            .height('100%')
        }
          .width('100%')
          .height(240)
          .backgroundColor('#F9F9F9')
          .borderRadius(16)

        Row({ space: 16 }) {
          Button() {
            Text('Add Marker')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
          }
            .layoutWeight(1)
            .height(44)
            .backgroundColor('#6200EE')
            .borderRadius(8)

          Button() {
            Text('Clear')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
          }
            .layoutWeight(1)
            .height(44)
            .backgroundColor('#03DAC6')
            .borderRadius(8)
        }
          .alignItems(VerticalAlign.Center)
          .width('100%')
      }
        .width('100%')
        .height('100%')
        .padding(16)
    }
      .width('100%')
      .height('100%')
  }
}

class Marker {
  x: number;
  y: number;
  label: string;

  constructor(x: number, y: number, label: string) {
    this.x = x;
    this.y = y;
    this.label = label;
  }
}