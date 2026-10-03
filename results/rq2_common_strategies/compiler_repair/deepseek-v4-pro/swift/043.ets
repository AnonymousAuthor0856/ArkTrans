@Entry
@Component
struct RootScreen {
  @State promo: string = ""
  private items: CartItem[] = [
    { id: 1, name: "Neon Keyboard", price: 89.99 },
    { id: 2, name: "Wireless Mouse", price: 49.99 },
    { id: 3, name: "Gaming Headset", price: 109.99 }
  ]

  build() {
    Column() {
      List({ space: 10 }) {
        // Title
        ListItem() {
          Text('Your Cart')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .foregroundColor('#FF00E5FF')
            .width('100%')
        }

        // Cart items
        ForEach(this.items, (item: CartItem) => {
          ListItem() {
            Row({ space: 0 }) {
              Column({ space: 4 }) {
                Text(item.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#FFFFFFFF')
                Text('$' + item.price.toFixed(2))
                  .fontSize(14)
                  .fontWeight(FontWeight.Regular)
                  .foregroundColor('#FF00BFA5')
              }
              .alignItems(HorizontalAlign.Start)

              Blank().layoutWeight(1)

              Button() {
                Text('Remove')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#FF0A0A0A')
                  .padding({ left: 10, right: 10, top: 6, bottom: 6 })
              }
              .backgroundColor('#FF00E5FF')
              .borderRadius(10)
              .onClick(() => {})
            }
            .width('100%')
            .padding({ left: 10, right: 10, top: 10, bottom: 10 })
            .backgroundColor('#FF121212')
            .borderRadius(14)
            .shadow({
              radius: 4,
              color: 'rgba(10,10,10,0.15)',
              offsetX: 0,
              offsetY: 2
            })
          }
        })

        // Promo code input
        ListItem() {
          TextInput({ placeholder: 'Promo Code', text: this.promo })
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .foregroundColor('#FFFFFFFF')
            .placeholderColor('rgba(255,255,255,0.5)')
            .padding({ left: 10, right: 10, top: 10, bottom: 10 })
            .backgroundColor('#FF1E1E1E')
            .borderRadius(10)
            .border({ width: 1, color: '#FF2C2C2C' })
            .onChange((value: string) => {
              this.promo = value
            })
        }

        // Summary card
        ListItem() {
          Column({ space: 6 }) {
            Row({ space: 0 }) {
              Text('Items:')
                .fontSize(14)
                .fontWeight(FontWeight.Regular)
                .foregroundColor('#FFFFFFFF')
              Blank().layoutWeight(1)
              Text(this.items.length.toString())
                .fontSize(14)
                .fontWeight(FontWeight.Regular)
                .foregroundColor('#FF00E5FF')
            }
            .width('100%')

            Row({ space: 0 }) {
              Text('Total:')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#FFFFFFFF')
              Blank().layoutWeight(1)
              Text('$' + this.items.reduce((sum, item) => sum + item.price, 0).toFixed(2))
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#FF00E5FF')
            }
            .width('100%')
          }
          .width('100%')
          .padding({ left: 14, right: 14, top: 14, bottom: 14 })
          .backgroundColor('#FF1E1E1E')
          .borderRadius(14)
          .shadow({
            radius: 4,
            color: 'rgba(10,10,10,0.15)',
            offsetX: 0,
            offsetY: 2
          })
        }

        // Checkout button
        ListItem() {
          Button() {
            Text('Checkout')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#FF0A0A0A')
          }
          .width('100%')
          .height(56)
          .backgroundColor('#FF00BFA5')
          .borderRadius(14)
          .onClick(() => {})
        }
      }
      .width('100%')
      .height('100%')
      .padding({ left: 14, right: 14, top: 14, bottom: 14 })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      colors: [['#FF0A0A0A', 0], ['#FF1E1E1E', 1]],
      direction: GradientDirection.Bottom
    })
  }
}

interface CartItem {
  id: number
  name: string
  price: number
}