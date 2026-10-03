@Entry
@Component
struct Index {
  @State quantities: number[] = [1, 1, 1, 1]
  @State subtotal: number = 0.0

  build() {
    Stack({ alignContent: Alignment.Top }) {
      List({ space: 8 }) {
        ListItem() {
          Column() {
            Row({ space: 8 }) {
              Stack({ alignContent: Alignment.Center }) {
                Text('Item Color')
                  .width(60)
                  .height(60)
                  .backgroundColor('#E0E0E0')
                  .borderRadius(8)
              }

              Column({ space: 2 }) {
                Text('item.name')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000000')

                Text('$${"%.2f".format(item.price)}')
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#000000')

                Row({ space: 4 }) {
                  Stack({ alignContent: Alignment.Center }) {
                    Text('+')
                      .width(28)
                      .height(28)
                      .backgroundColor('#F5F5F5')
                      .borderRadius(4)
                  }
                  Stack({ alignContent: Alignment.Center }) {
                    Text('-')
                      .width(28)
                      .height(28)
                      .backgroundColor('#F5F5F5')
                      .borderRadius(4)
                  }
                  Stack({ alignContent: Alignment.Center }) {
                    Text('Remove')
                      .width(28)
                      .height(28)
                      .backgroundColor('#F5F5F5')
                      .borderRadius(4)
                  }
                }.alignItems(VerticalAlign.Center)
              }.alignItems(HorizontalAlign.Start).layoutWeight(1)

              Column({ space: 4 }) {
                Button() {
                  Text('+')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                }
                .width(28)
                .height(28)
                .backgroundColor('#F5F5F5')
                .borderRadius(4)
                .onClick(() => {
                  // if (quantities[item.id - 1] < 10) quantities[item.id - 1]++
                })

                Text('quantities[item.id - 1].toString()')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000000')

                Button() {
                  Text('-')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                }
                .width(28)
                .height(28)
                .backgroundColor('#F5F5F5')
                .borderRadius(4)
                .onClick(() => {
                  // if (quantities[item.id - 1] > 1) quantities[item.id - 1]--
                })
              }.alignItems(HorizontalAlign.Center)

              Button() {
                Text('Remove')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
              }
              .height(36)
              .width(85)
              .backgroundColor('#B00020')
              .borderRadius(8)
              .onClick(() => {
                // {}
              })
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')
            .padding(8)
          }
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000' })
        }

        ListItem() {
          Row({ space: 4 }) {
            Button() {
              Text('Apply Coupon')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#000000')
            }
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .borderWidth(1)
            .borderColor('#E0E0E0')
            .onClick(() => {
              // {}
            })

            Button() {
              Text('Gift Wrap')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#000000')
            }
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .borderWidth(1)
            .borderColor('#E0E0E0')
            .onClick(() => {
              // {}
            })

            Button() {
              Text('Save for Later')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#000000')
            }
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .borderWidth(1)
            .borderColor('#E0E0E0')
            .onClick(() => {
              // {}
            })
          }
          .alignItems(VerticalAlign.Center)
          .width('100%')
        }
      }
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .width('100%')
      .layoutWeight(1)

      Column() {
        Row({ space: 4 }) {
          Stack({ alignContent: Alignment.Center }) {
            Text('Icon')
              .width(20)
              .height(20)
              .backgroundColor('#000000')
              .borderRadius(4)
          }
          Text('Shopping Cart')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .padding(16)
      }

      Column() {
        Column({ space: 6 }) {
          Row({ space: 0 }) {
            Text('Subtotal')
              .fontSize(16)
              .fontColor('#000000')
            Blank().layoutWeight(1)
            Text('$${"%.2f".format(cartItems.mapIndexed { index, item -> item.price * quantities[index] }.sum())}')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
          }
          .alignItems(VerticalAlign.Center)
          .width('100%')

          Row({ space: 0 }) {
            Text('Shipping')
              .fontSize(16)
              .fontColor('#000000')
            Blank().layoutWeight(1)
            Text('$${"%.2f".format(shipping)}')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
          }
          .alignItems(VerticalAlign.Center)
          .width('100%')

          Row({ space: 0 }) {
            Text('Tax')
              .fontSize(16)
              .fontColor('#000000')
            Blank().layoutWeight(1)
            Text('$${"%.2f".format(tax)}')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
          }
          .alignItems(VerticalAlign.Center)
          .width('100%')

          Row({ space: 0 }) {
            Text('Total')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
            Blank().layoutWeight(1)
            Text('$${"%.2f".format(cartItems.mapIndexed { index, item -> item.price * quantities[index] }.sum() + shipping + tax)}')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
          }
          .alignItems(VerticalAlign.Center)
          .width('100%')

          Button() {
            Text('Proceed to Checkout')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
          }
          .height(44)
          .width('100%')
          .backgroundColor('#000000')
          .borderRadius(12)
          .onClick(() => {
            // {}
          })
        }
        .width('100%')
        .padding(8)
      }
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 4, color: '#1A000000' })
    }
    .width('100%')
    .height('100%')
  }
}