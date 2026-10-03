@Entry
@Component
struct Index {
  @State markers: Array<Marker> = [
    { x: 120, y: 200, label: "Store A" },
    { x: 360, y: 400, label: "Store B" }
  ]
  @State ProductDetail: string = ""
  @State MonochromeBag: string = ""
  @State Description: string = ""
  @State Price: number = 79
  @State AddToCart: string = ""
  @State itY: string = ""
  @State AddMarker: string = ""
  @State Clear: string = ""

  build() {
    Stack() {
      // === Scaffold ===
      Stack({ alignContent: Alignment.Top }) {
        // === Column ===
        Column({ space: 16 }) {
          // === Text ===
          Text('Product Detail')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#111111')

          // === Card ===
          Column() {
            // === Column ===
            Column({ space: 12 }) {
              // === Box (Image Placeholder) ===
              Stack({ alignContent: Alignment.Center }) {
                Image($r('app.media.startIcon'))
                  .width('100%')
                  .height('100%')
                  .objectFit(ImageFit.Cover)
              }
              .width('100%')
              .height(160)
              .backgroundColor('#E5E5E5')

              // === Text ===
              Text('Monochrome Bag')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#111111')

              // === Text ===
              Text('A minimalist and timeless design piece.')
                .fontSize(14)
                .fontColor('#777777')

              // === Text ===
              Text('$79.00')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#111111')

              // === Button ===
              Button() {
                // === Text ===
                Text('Add to Cart')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FFFFFF')
              }
              .width('100%')
              .height(48)
              .backgroundColor('#6750A4')
              .borderRadius(8)
              .onClick(() => {
                // onClick logic
              })
            }
            .width('100%')
            .padding(16)
          }
          .width('100%')
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })

          // === Box (Canvas Area) ===
          Stack({ alignContent: Alignment.Center }) {
            // === Canvas ===
            // In ArkTS, we use a custom component or Shape for canvas-like drawing.
            // Here we represent the area with a colored box as per skeleton structure.
            Column() {
              // Simulating canvas content if needed, otherwise empty container
            }
            .width('100%')
            .height('100%')
            .backgroundColor('#F9F9F9')
          }
          .width('100%')
          .height(240)
          .borderRadius(12)

          // === Row ===
          Row({ space: 0 }) {
            // === Button ===
            Button() {
              // === Text ===
              Text('Add Marker')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
            }
            .layoutWeight(1)
            .height(44)
            .backgroundColor('#6200EE')
            .borderRadius(8)
            .onClick(() => {
              // onClick logic
            })

            // === Spacer ===
            Blank().width(16)

            // === Button ===
            Button() {
              // === Text ===
              Text('Clear')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
            }
            .layoutWeight(1)
            .height(44)
            .backgroundColor('#03DAC6')
            .borderRadius(8)
            .onClick(() => {
              this.markers = []
            })
          }
          .alignItems(VerticalAlign.Center)
          .width('100%')
        }
        .width('100%')
        .height('100%')
        .padding(16)
      }
    }
    .width('100%')
    .height('100%')
  }
}

interface Marker {
  x: number;
  y: number;
  label: string;
}