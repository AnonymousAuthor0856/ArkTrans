@Entry
@Component
struct Index {
  @State quantity: number = 1
  @State isFavorite: boolean = false

  build() {
    Stack({ alignContent: Alignment.Center }) {
      // Background Box
      Stack().width('100%').height('100%').backgroundColor('#F5F5F7')

      Column({ space: 0 }) {
        // === Image Section ===
        Stack({ alignContent: Alignment.Center }) {
          // Main Product Icon (Home)
          Stack({ alignContent: Alignment.Center }) {
            Image($r('app.media.startIcon'))
              .width(100).height(100).objectFit(ImageFit.Contain)
              .fillColor('#EFB495')
          }
          .width(200).height(200).backgroundColor(Color.White)
          .borderRadius(100)
          .shadow({ radius: 20, color: '#33000000', offsetY: 10 })

          // Top Navigation Row
          Row({ space: 0 }) {
            // Back Button
            Button() {
              Image($r('app.media.startIcon'))
                .width(24).height(24).objectFit(ImageFit.Contain)
                .fillColor(Color.Black)
            }
            .width(42).height(42).backgroundColor(Color.White)
            .borderRadius(21)
            .onClick(() => { /* back action */ })

            Blank()

            // Favorite Button
            Button() {
              Image($r('app.media.startIcon'))
                .width(24).height(24).objectFit(ImageFit.Contain)
                .fillColor(this.isFavorite ? Color.Red : Color.Black)
            }
            .width(42).height(42).backgroundColor(Color.White)
            .borderRadius(21)
            .onClick(() => { this.isFavorite = !this.isFavorite })
          }
          .width('100%').padding({ left: 24, right: 24, top: 24 })
          .position({ x: 0, y: 0 })
        }
        .width('100%').height(400)
        .backgroundColor('#E8E8E8')
        .borderRadius({ bottomLeft: 40, bottomRight: 40 })

        // === Content Section ===
        Column({ space: 0 }) {
          // Title and Rating
          Row({ space: 0 }) {
            Text('Modern Lounge')
              .fontSize(26).fontWeight(FontWeight.Bold).fontColor('#333333')
            
            Blank()

            Row({ space: 4 }) {
              Image($r('app.media.startIcon'))
                .width(20).height(20).objectFit(ImageFit.Contain)
                .fillColor('#FFC107')
              
              Text('4.8')
                .fontSize(16).fontWeight(FontWeight.Bold).fontColor('#333333')
            }
          }
          .width('100%').alignItems(VerticalAlign.Center)

          Text('Armchair')
            .fontSize(20).fontWeight(FontWeight.Normal).fontColor('#999999')
            .margin({ top: -4 })

          Blank().height(24)

          Text('Description')
            .fontSize(18).fontWeight(FontWeight.Medium).fontColor('#000000')

          Blank().height(8)

          Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
            .fontSize(14).fontColor('#999999').lineHeight(22)

          Blank().height(24)

          // Options Row
          Row({ space: 0 }) {
            // Color Selection
            Column({ space: 0 }) {
              Text('Color')
                .fontSize(18).fontWeight(FontWeight.Medium).fontColor('#333333')
              
              Blank().height(8)

              Row({ space: 12 }) {
                // Mocking a single selected color option based on screenshot
                Stack().width(30).height(30).borderRadius(15)
                  .backgroundColor('#EFB495')
                  .border({ width: 2, color: Color.Black })
              }
            }

            Blank()

            // Quantity Selection
            Column({ space: 0 }) {
              Text('Quantity')
                .fontSize(18).fontWeight(FontWeight.Medium).fontColor('#333333')
              
              Blank().height(8)

              Row({ space: 0 }) {
                Text('-')
                  .fontSize(20).fontColor('#333333')
                  .width(30).textAlign(TextAlign.Center)
                  .onClick(() => { if (this.quantity > 1) this.quantity-- })

                Text(`${this.quantity}`)
                  .fontSize(18).fontWeight(FontWeight.Bold).fontColor('#333333')
                  .width(30).textAlign(TextAlign.Center)

                Image($r('app.media.startIcon'))
                  .width(20).height(20).objectFit(ImageFit.Contain)
                  .fillColor('#333333')
                  .onClick(() => { this.quantity++ })
              }
              .alignItems(VerticalAlign.Center)
              .justifyContent(FlexAlign.Center)
              .backgroundColor(Color.White)
              .borderRadius(12)
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            }
            .alignItems(HorizontalAlign.End)
          }
          .width('100%').alignItems(VerticalAlign.Center)
        }
        .width('100%').padding(24)
      }
      .width('100%').height('100%')
      .padding({ bottom: 80 })

      // === Bottom Sheet / Cart Bar ===
      Column() {
        Row({ space: 0 }) {
          Column({ space: 0 }) {
            Text('Total Price')
              .fontSize(14).fontColor('#999999')
            
            Text(`$${245 * this.quantity}`)
              .fontSize(24).fontWeight(FontWeight.Bold).fontColor('#000000')
          }

          Blank()

          Button() {
            Row({ space: 8 }) {
              Image($r('app.media.startIcon'))
                .width(20).height(20).objectFit(ImageFit.Contain)
                .fillColor(Color.White)
              
              Text('Add to Cart')
                .fontSize(16).fontWeight(FontWeight.Medium).fontColor(Color.White)
            }
          }
          .width(160).height(50).backgroundColor('#333333')
          .borderRadius(16)
        }
        .width('100%').padding(24).alignItems(VerticalAlign.Center)
      }
      .width('100%').backgroundColor(Color.White)
      .borderRadius({ topLeft: 24, topRight: 24 })
      .shadow({ radius: 16, color: '#1A000000' })
      .position({ x: 0, y: '100%' })
      .translate({ y: -80 }) // Adjust position to sit at bottom
    }
    .width('100%').height('100%')
  }
}