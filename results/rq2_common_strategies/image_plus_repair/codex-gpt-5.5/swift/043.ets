interface CartItem {
  id: number
  name: string
  price: number
}

@Entry
@Component
struct ShoppingCartPage {
  @State private items: CartItem[] = [
    { id: 1, name: 'Neon Keyboard', price: 89.99 },
    { id: 2, name: 'Wireless Mouse', price: 49.99 },
    { id: 3, name: 'Gaming Headset', price: 109.99 }
  ]
  @State private promo: string = ''

  private readonly primary: string = '#00E5FF'
  private readonly secondary: string = '#00BFA5'
  private readonly backgroundColorValue: string = '#0A0A0A'
  private readonly surface: string = '#121212'
  private readonly surfaceVariant: string = '#1E1E1E'
  private readonly outlineColorValue: string = '#2C2C2C'

  private total(): number {
    return this.items.reduce((sum: number, item: CartItem) => sum + item.price, 0)
  }

  private money(value: number): string {
    return '$' + value.toFixed(2)
  }

  private removeItem(id: number): void {
    this.items = this.items.filter((item: CartItem) => item.id !== id)
  }

  @Builder
  private cartItem(item: CartItem) {
    Row() {
      Column() {
        Text(item.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .lineHeight(24)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.money(item.price))
          .fontSize(14)
          .fontColor(this.secondary)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Remove', { type: ButtonType.Normal })
        .fontSize(12)
        .fontColor(this.backgroundColorValue)
        .backgroundColor(this.primary)
        .borderRadius(10)
        .height(38)
        .padding({ left: 14, right: 14 })
        .onClick(() => this.removeItem(item.id))
    }
    .width('100%')
    .height(104)
    .padding({ left: 20, right: 20 })
    .backgroundColor(this.surface)
    .borderRadius(14)
    .shadow({
      radius: 4,
      color: '#26000000',
      offsetX: 0,
      offsetY: 2
    })
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [[this.backgroundColorValue, 0.0], [this.surfaceVariant, 1.0]]
        })

      Scroll() {
        Column({ space: 10 }) {
          Text('Your Cart')
            .width('100%')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.primary)
            .margin({ bottom: 10 })

          ForEach(this.items, (item: CartItem) => {
            this.cartItem(item)
          }, (item: CartItem) => item.id.toString())

          Blank()
            .height(20)

          TextInput({ placeholder: 'Promo Code', text: this.promo })
            .width('100%')
            .height(58)
            .fontSize(14)
            .fontColor('#FFFFFF')
            .placeholderColor('#80FFFFFF')
            .padding({ left: 20, right: 20 })
            .backgroundColor(this.surfaceVariant)
            .border({
              width: 1,
              color: this.outlineColorValue,
              radius: 10
            })
            .borderRadius(10)
            .onChange((value: string) => {
              this.promo = value
            })

          Blank()
            .height(20)

          Column({ space: 6 }) {
            Row() {
              Text('Items:')
                .fontSize(14)
                .fontColor('#FFFFFF')

              Blank()
                .layoutWeight(1)

              Text(this.items.length.toString())
                .fontSize(14)
                .fontColor(this.primary)
            }
            .width('100%')

            Row() {
              Text('Total:')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')

              Blank()
                .layoutWeight(1)

              Text(this.money(this.total()))
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.primary)
            }
            .width('100%')
          }
          .width('100%')
          .height(96)
          .padding(14)
          .backgroundColor(this.surfaceVariant)
          .borderRadius(14)
          .shadow({
            radius: 4,
            color: '#26000000',
            offsetX: 0,
            offsetY: 2
          })

          Button('Checkout', { type: ButtonType.Normal })
            .width('100%')
            .height(56)
            .fontSize(18)
            .fontColor(this.backgroundColorValue)
            .backgroundColor(this.secondary)
            .borderRadius(14)
            .margin({ top: 10 })
        }
        .width('100%')
        .padding({ left: 28, right: 28, top: 28, bottom: 28 })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
  }
}
