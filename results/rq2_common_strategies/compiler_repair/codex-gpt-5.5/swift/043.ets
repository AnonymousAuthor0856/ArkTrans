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

@Entry
@Component
struct Index {
  @State promo: string = ''

  private items: CartItem[] = [
    new CartItem(1, 'Neon Keyboard', 89.99),
    new CartItem(2, 'Wireless Mouse', 49.99),
    new CartItem(3, 'Gaming Headset', 109.99)
  ]

  private total(): number {
    let total = 0
    this.items.forEach((item: CartItem) => {
      total += item.price
    })
    return total
  }

  private money(value: number): string {
    return `$${value.toFixed(2)}`
  }

  @Builder
  CartItemCard(item: CartItem) {
    Row() {
      Column() {
        Text(item.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .width('100%')
        Text(this.money(item.price))
          .fontSize(14)
          .fontColor('#00BFA5')
          .width('100%')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button('Remove')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0A0A0A')
        .height(32)
        .padding({ left: 10, right: 10 })
        .backgroundColor('#00E5FF')
        .borderRadius(10)
    }
    .width('100%')
    .padding(10)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#121212')
    .borderRadius(14)
    .shadow({ radius: 4, color: '#260A0A0A', offsetY: 2 })
  }

  @Builder
  SummaryCard() {
    Column() {
      Row() {
        Text('Items:')
          .fontSize(14)
          .fontColor('#FFFFFF')
        Blank()
        Text(this.items.length.toString())
          .fontSize(14)
          .fontColor('#00E5FF')
      }
      .width('100%')

      Row() {
        Text('Total:')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
        Blank()
        Text(this.money(this.total()))
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#00E5FF')
      }
      .width('100%')
      .margin({ top: 6 })
    }
    .width('100%')
    .padding(14)
    .backgroundColor('#1E1E1E')
    .borderRadius(14)
    .shadow({ radius: 4, color: '#260A0A0A', offsetY: 2 })
  }

  build() {
    Stack() {
      Scroll() {
        Column() {
          Text('Your Cart')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#00E5FF')
            .width('100%')

          ForEach(this.items, (item: CartItem) => {
            Column() {
              this.CartItemCard(item)
            }
            .margin({ top: 10 })
          }, (item: CartItem) => item.id.toString())

          TextInput({ placeholder: 'Promo Code', text: this.promo })
            .fontSize(14)
            .fontColor('#FFFFFF')
            .placeholderColor('#80FFFFFF')
            .width('100%')
            .height(46)
            .padding(10)
            .backgroundColor('#1E1E1E')
            .border({ width: 1, color: '#2C2C2C', radius: 10 })
            .margin({ top: 20 })
            .onChange((value: string) => {
              this.promo = value
            })

          Column() {
            this.SummaryCard()
          }
          .margin({ top: 20 })

          Button('Checkout')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0A0A0A')
            .width('100%')
            .height(56)
            .backgroundColor('#00BFA5')
            .borderRadius(14)
            .margin({ top: 10 })
        }
        .width('100%')
        .padding(14)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [['#0A0A0A', 0.0], ['#1E1E1E', 1.0]]
    })
  }
}
