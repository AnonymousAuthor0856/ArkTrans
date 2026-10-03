@Entry
@Component
struct Index {
  @State quantity: number = 1
  @State selectedColorIndex: number = 0

  private colors: string[] = ['#EFB495', '#A3B18A', '#588157']

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#FFF5F5F7')

      // Scrollable Content Area
      Column() {
        .width('100%')
        .layoutWeight(1)
        .padding({ bottom: 120 }) // Reserve space for bottom sheet
        .scrollable(ScrollDirection.Vertical)

        // Hero Image Section
        Stack({ alignContent: Alignment.Center }) {
          Image($r('app.media.startIcon'))
            .width(200)
            .height(200)
            .borderRadius(100)
            .shadow({ radius: 20, color: '#1A000000' })
            .backgroundColor(Color.White)

          Row() {
            Button() {
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .fillColor(Color.Black)
            }
            .width(42)
            .height(42)
            .borderRadius(21)
            .backgroundColor(Color.White)

            Blank()

            Button() {
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .fillColor(Color.Red)
            }
            .width(42)
            .height(42)
            .borderRadius(21)
            .backgroundColor(Color.White)
          }
          .width('100%')
          .padding(24)
          .position({ x: 0, y: 0 })
        }
        .width('100%')
        .height(400)
        .backgroundColor('#FFE8E8E8')
        .clip(true)
        .borderRadius({ bottomLeft: 40, bottomRight: 40 })

        // Product Details
        Column() {
          .width('100%')
          .padding(24)

          Row() {
            Text('Modern Lounge')
              .fontSize(26)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')

            Blank()

            Row() {
              Image($r('app.media.startIcon'))
                .width(20)
                .height(20)
                .fillColor('#FFC107')
              Text('4.8')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .margin({ left: 4 })
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)

          Text('Armchair')
            .fontSize(20)
            .fontWeight(FontWeight.Normal)
            .fontColor(Color.Gray)
            .margin({ top: -4 })

          Blank().height(24)

          Text('Description')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)

          Blank().height(8)

          Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
            .fontSize(14)
            .fontColor(Color.Gray)
            .lineHeight(22)

          Blank().height(24)

          Row() {
            Column() {
              Text('Color')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)

              Blank().height(8)

              Row() {
                ForEach(this.colors, (color: string, index: number) => {
                  Stack()
                    .width(30)
                    .height(30)
                    .borderRadius(15)
                    .backgroundColor(color)
                    .border({
                      width: this.selectedColorIndex === index ? 2 : 0,
                      color: this.selectedColorIndex === index ? Color.Black : Color.Transparent,
                      radius: 15
                    })
                    .onClick(() => {
                      this.selectedColorIndex = index
                    })
                }, (item: string) => item)
              }
              .columnGap(12)
            }

            Blank()

            Column() {
              .alignItems(HorizontalAlign.End)
              Text('Quantity')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)

              Blank().height(8)

              Row() {
                .alignItems(VerticalAlign.Center)
                .backgroundColor(Color.White)
                .borderRadius(12)
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })

                Text('-')
                  .fontSize(20)
                  .padding({ left: 8, right: 8 })
                  .onClick(() => {
                    if (this.quantity > 1) this.quantity--
                  })

                Text(`${this.quantity}`)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .padding({ left: 8, right: 8 })

                Image($r('app.media.startIcon'))
                  .width(20)
                  .height(20)
                  .onClick(() => {
                    this.quantity++
                  })
              }
            }
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
        }
      }

      // Fixed Bottom Sheet
      Column() {
        .width('100%')
        .backgroundColor(Color.White)
        .shadow({ radius: 16, color: '#1A000000' })
        .borderRadius({ topLeft: 24, topRight: 24 })
        .position({ x: 0, y: '100%' })
        .translate({ y: -100 }) // Approximate height offset

        Row() {
          .width('100%')
          .padding(24)
          .alignItems(VerticalAlign.Center)

          Column() {
            Text('Total Price')
              .fontSize(14)
              .fontColor(Color.Gray)
            Text(`$${245 * this.quantity}`)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
          }

          Blank()

          Button() {
            Row() {
              Image($r('app.media.startIcon'))
                .width(20)
                .height(20)
              Blank().width(8)
              Text('Add to Cart')
            }
            .alignItems(VerticalAlign.Center)
          }
          .width(160)
          .height(50)
          .backgroundColor('#FF333333')
          .borderRadius(16)
        }
      }
    }
    .width('100%')
    .height('100%')
  }
}