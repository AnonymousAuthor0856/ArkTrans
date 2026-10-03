@Entry
@Component
struct ShoppingCartPage {
  @State promoCode: string = ''

  private items: CartItem[] = [
    new CartItem(1, 'Neon Keyboard', 89.99),
    new CartItem(2, 'Wireless Mouse', 49.99),
    new CartItem(3, 'Gaming Headset', 109.99)
  ]

  private get total(): number {
    return this.items.reduce((sum, item) => sum + item.price, 0)
  }

  build() {
    Column() {
      Text('Your Cart')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00E5FF')
        .width('100%')

      ForEach(this.items, (item: CartItem) => {
        Row() {
          Column() {
            Text(item.name)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
            Text(`$${item.price.toFixed(2)}`)
              .fontSize(14)
              .fontColor('#00BFA5')
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Button('Remove')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0A0A0A')
            .backgroundColor('#00E5FF')
            .borderRadius(10)
            .height(36)
            .padding({ left: 14, right: 14 })
        }
        .width('100%')
        .padding(10)
        .backgroundColor('#121212')
        .borderRadius(14)
        .alignItems(VerticalAlign.Center)
        .shadow({
          radius: 4,
          color: 'rgba(0, 0, 0, 0.15)',
          offsetY: 2
        })
      }, (item: CartItem) => item.id.toString())

      Blank(10)

      TextInput({ placeholder: 'Promo Code', text: this.promoCode })
        .width('100%')
        .height(48)
        .backgroundColor('#1E1E1E')
        .borderRadius(10)
        .placeholderColor('rgba(255, 255, 255, 0.5)')
        .fontColor('#FFFFFF')
        .onChange((value: string) => {
          this.promoCode = value
        })

      Blank(10)

      Column() {
        Row() {
          Text('Items:')
            .fontSize(14)
            .fontColor('#FFFFFF')
          Text(`${this.items.length}`)
            .fontSize(14)
            .fontColor('#00E5FF')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Row() {
          Text('Total:')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
          Text(`$${this.total.toFixed(2)}`)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#00E5FF')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: 6 })
      }
      .width('100%')
      .padding(14)
      .backgroundColor('#1E1E1E')
      .borderRadius(14)
      .shadow({
        radius: 4,
        color: 'rgba(0, 0, 0, 0.15)',
        offsetY: 2
      })

      Button('Checkout')
        .width('100%')
        .height(56)
        .backgroundColor('#00BFA5')
        .fontColor('#0A0A0A')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .borderRadius(14)
        .margin({ top: 14 })
    }
    .width('100%')
    .height('100%')
    .padding(14)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#0A0A0A', 0.0], ['#1E1E1E', 1.0]]
    })
  }
}

class CartItem {
  id: number
  name: string
  price: number

  constructor(id: number, name: string, price: number) {
    this.id = id
    this.name = name
    this.price = price
  }
}
