@Entry
@Component
struct Index {
  @State promo: string = ""
  @State items: CartItem[] = [
    { name: "Item 1", price: 10.50 },
    { name: "Item 2", price: 20.00 }
  ]
  @State total: number = 30.50

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 10 }) {
        Text('Your Cart')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00E5FF')

        ForEach(this.items, (it: CartItem) => {
          Column() {
            Row({ space: 0 }) {
              Column({ space: 0 }) {
                Text(it.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FFFFFF')
                Text(`$${it.price.toFixed(2)}`)
                  .fontSize(14)
                  .fontColor('#00BFA5')
              }
              Button() {
                Text('Remove')
                  .fontSize(12)
                  .fontColor('#0A0A0A')
              }
              .backgroundColor('#00E5FF')
              .borderRadius(8)
              .height(32)
              .width(80)
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')
            .padding(10)
          }
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000' })
          .margin({ bottom: 10 })
        })

        Blank().height(16)

        TextInput({ placeholder: 'Promo Code' })
          .width('100%')
          .height(44)
          .backgroundColor('#2A2A2A')
          .borderRadius(8)
          .padding({ left: 12 })
          .fontColor('#FFFFFF')
          .onChange((value: string) => {
            this.promo = value
          })

        Blank().height(16)

        Column() {
          Column({ space: 6 }) {
            Row({ space: 0 }) {
              Text('Items:')
                .fontSize(14)
                .fontColor('#FFFFFF')
              Blank()
              Text(`${this.items.length}`)
                .fontSize(14)
                .fontColor('#00E5FF')
            }
            .width('100%')

            Row({ space: 0 }) {
              Text('Total:')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFF')
              Blank()
              Text(`$${this.total.toFixed(2)}`)
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#00E5FF')
            }
            .width('100%')
          }
          .padding(14)
        }
        .backgroundColor('#2A2A2A')
        .borderRadius(12)
        .shadow({ radius: 4, color: '#1A000000' })

        Button() {
          Text('Checkout')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0A0A0A')
        }
        .width('100%')
        .height(56)
        .backgroundColor('#00BFA5')
        .borderRadius(12)
      }
      .width('100%')
      .height('100%')
      .padding(14)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#0A0A0A', 0], ['#1A1A1A', 1]]
      })
    }
    .width('100%')
    .height('100%')
  }
}

interface CartItem {
  name: string
  price: number
}