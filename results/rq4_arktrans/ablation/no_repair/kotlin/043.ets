@Entry
@Component
struct Index {
  @State promo: string = ""
  @State items: CartItem[] = [
    { name: 'Neon Keyboard', price: 89.99 },
    { name: 'Wireless Mouse', price: 49.99 },
    { name: 'Gaming Headset', price: 109.99 }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 10 }) {
        Text('Your Cart')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00E5FF')

        ForEach(this.items, (item: CartItem) => {
          Column() {
            Row({ space: 0 }) {
              Column({ space: 0 }) {
                Text(item.name)
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FFFFFF')
                Text(`$${item.price.toFixed(2)}`)
                  .fontSize(16)
                  .fontColor('#00BFA5')
              }
              Blank()
              Button('Remove')
                .backgroundColor('#00E5FF')
                .borderRadius(12)
                .height(40)
                .width(100)
                .fontColor('#0A0A0A')
                .onClick(() => {
                  // Remove logic
                })
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')
            .padding(10)
          }
          .backgroundColor('#1C1C1E')
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000' })
          .margin({ bottom: 10 })
        }, (item: CartItem) => item.name)

        TextInput({ placeholder: 'Promo Code' })
          .placeholderColor('#8E8E93')
          .backgroundColor('#2C2C2E')
          .borderRadius(12)
          .height(50)
          .padding({ left: 16 })
          .onChange((value: string) => {
            this.promo = value
          })

        Column() {
          Column({ space: 6 }) {
            Row({ space: 0 }) {
              Text('Items:')
                .fontSize(16)
                .fontColor('#FFFFFF')
              Blank()
              Text(`${this.items.length}`)
                .fontSize(16)
                .fontColor('#00E5FF')
            }
            .width('100%')

            Row({ space: 0 }) {
              Text('Total:')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
              Blank()
              Text(`$${this.getTotal().toFixed(2)}`)
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#00E5FF')
            }
            .width('100%')
          }
          .padding(14)
        }
        .backgroundColor('#1C1C1E')
        .borderRadius(12)
        .shadow({ radius: 4, color: '#1A000000' })

        Button('Checkout')
          .backgroundColor('#00BFA5')
          .borderRadius(16)
          .height(56)
          .fontColor('#0A0A0A')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            // Checkout logic
          })
      }
      .width('100%')
      .height('100%')
      .padding(14)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#0A0A0A', 0], ['#1C1C1E', 1]]
      })
    }
    .width('100%')
    .height('100%')
  }

  getTotal(): number {
    return this.items.reduce((sum, item) => sum + item.price, 0)
  }
}

interface CartItem {
  name: string
  price: number
}