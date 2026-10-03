class CartItem {
  id: number;
  name: string;
  price: number;

  constructor(id: number, name: string, price: number) {
    this.id = id;
    this.name = name;
    this.price = price;
  }
}

@Entry
@Component
struct RootScreen {
  @State promo: string = '';
  private items: CartItem[] = [
    new CartItem(1, 'Neon Keyboard', 89.99),
    new CartItem(2, 'Wireless Mouse', 49.99),
    new CartItem(3, 'Gaming Headset', 109.99)
  ];

  private getTotal(): string {
    let sum: number = 0;
    for (let i = 0; i < this.items.length; i++) {
      sum += this.items[i].price;
    }
    return sum.toFixed(2);
  }

  build() {
    Column({ space: 10 }) {
      Text('Your Cart')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00E5FF')

      ForEach(this.items, (item: CartItem) => {
        Column() {
          Row() {
            Column() {
              Text(item.name)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
              Text('$' + item.price.toFixed(2))
                .fontSize(14)
                .fontColor('#00BFA5')
            }
            .alignItems(HorizontalAlign.Start)

            Button('Remove')
              .backgroundColor('#00E5FF')
              .fontColor('#0A0A0A')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .borderRadius(10)
              .onClick(() => {})
          }
          .width('100%')
          .padding(10)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .backgroundColor('#121212')
        .borderRadius(14)
        .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.15)', offsetX: 0, offsetY: 2 })
      }, (item: CartItem) => item.id.toString())

      Blank().height(10)

      TextInput({ placeholder: 'Promo Code', text: this.promo })
        .onChange((value: string) => {
          this.promo = value;
        })
        .width('100%')
        .height(48)
        .backgroundColor('#1E1E1E')
        .placeholderColor('rgba(255, 255, 255, 0.5)')
        .fontColor('#FFFFFF')
        .borderRadius(10)

      Blank().height(10)

      Column({ space: 6 }) {
        Row() {
          Text('Items:')
            .fontSize(14)
            .fontColor('#FFFFFF')
          Text(this.items.length.toString())
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
          Text('$' + this.getTotal())
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
      .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.15)', offsetX: 0, offsetY: 2 })

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
    .linearGradient({
      angle: 180,
      colors: [['#0A0A0A', 0.0], ['#1E1E1E', 1.0]]
    })
  }
}
