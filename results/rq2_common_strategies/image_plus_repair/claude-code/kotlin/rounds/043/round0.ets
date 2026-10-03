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
    let sum: number = 0
    for (let i = 0; i < this.items.length; i++) {
      sum += this.items[i].price
    }
    return sum
  }

  build() {
    Column() {
      Text('Your Cart')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00E5FF')
        .width('100%')
        .margin({ bottom: 10 })

      ForEach(this.items, (item: CartItem) => {
        Row() {
          Column() {
            Text(item.name)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
            Text('$' + item.price.toFixed(2))
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
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
            .height(44)
            .padding({ left: 24, right: 24 })
            .onClick(() => {})
        }
        .width('100%')
        .padding(10)
        .backgroundColor('#121212')
        .borderRadius(14)
        .alignItems(VerticalAlign.Center)
        .margin({ bottom: 10 })
      }, (item: CartItem) => item.id.toString())

      TextInput({ placeholder: 'Promo Code', text: this.promoCode })
        .width('100%')
        .height(56)
        .backgroundColor('#1E1E1E')
        .placeholderColor('#FFFFFF80')
        .fontColor('#FFFFFF')
        .borderRadius(10)
        .padding({ left: 14, right: 14 })
        .margin({ top: 10, bottom: 10 })
        .onChange((value: string) => {
          this.promoCode = value
        })

      Column() {
        Row() {
          Text('Items:')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor('#FFFFFF')
          Text(this.items.length.toString())
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor('#00E5FF')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ bottom: 6 })

        Row() {
          Text('Total:')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
          Text('$' + this.total.toFixed(2))
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#00E5FF')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .padding(14)
      .backgroundColor('#1E1E1E')
      .borderRadius(14)
      .margin({ bottom: 14 })

      Button('Checkout')
        .width('100%')
        .height(56)
        .backgroundColor('#00BFA5')
        .fontColor('#0A0A0A')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .borderRadius(14)
        .onClick(() => {})
    }
    .width('100%')
    .height('100%')
    .padding(14)
    .backgroundColor('#0A0A0A')
    .justifyContent(FlexAlign.Start)
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
