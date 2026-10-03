import { router } from '@kit.ArkUI';

interface CartItem {
  id: number;
  name: string;
  price: number;
}

@Entry
@Component
struct RootScreen {
  @State promoCode: string = '';

  private items: CartItem[] = [
    { id: 1, name: 'Neon Keyboard', price: 89.99 },
    { id: 2, name: 'Wireless Mouse', price: 49.99 },
    { id: 3, name: 'Gaming Headset', price: 109.99 }
  ];

  private getTotal(): number {
    return this.items.reduce((sum, item) => sum + item.price, 0);
  }

  private formatPrice(price: number): string {
    return price.toFixed(2);
  }

  build() {
    Column() {
      // Header
      Text('Your Cart')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00E5FF')
        .margin({ bottom: 10 })

      // Cart Items
      ForEach(this.items, (item: CartItem) => {
        Column() {
          Row() {
            Column() {
              Text(item.name)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
                .margin({ bottom: 4 })
              Text('$' + this.formatPrice(item.price))
                .fontSize(14)
                .fontColor('#00BFA5')
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
              .padding({ left: 12, right: 12 })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .padding(10)
        }
        .width('100%')
        .backgroundColor('#121212')
        .borderRadius(14)
        .margin({ bottom: 10 })
        .shadow({
          radius: 4,
          color: '#26000000',
          offsetX: 0,
          offsetY: 2
        })
      })

      // Spacer
      Blank().height(10)

      // Promo Code Input
      TextInput({ placeholder: 'Promo Code', text: this.promoCode })
        .placeholderColor('#80FFFFFF')
        .placeholderFont({ size: 14 })
        .fontColor('#FFFFFF')
        .fontSize(14)
        .backgroundColor('#1E1E1E')
        .borderRadius(10)
        .width('100%')
        .height(50)
        .padding({ left: 12, right: 12 })
        .onChange((value: string) => {
          this.promoCode = value;
        })

      // Spacer
      Blank().height(10)

      // Order Summary Card
      Column() {
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
        .margin({ bottom: 6 })

        Row() {
          Text('Total:')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
          Text('$' + this.formatPrice(this.getTotal()))
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#00E5FF')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .backgroundColor('#1E1E1E')
      .borderRadius(14)
      .padding(14)
      .margin({ bottom: 10 })
      .shadow({
        radius: 4,
        color: '#26000000',
        offsetX: 0,
        offsetY: 2
      })

      // Checkout Button
      Button('Checkout')
        .width('100%')
        .height(56)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0A0A0A')
        .backgroundColor('#00BFA5')
        .borderRadius(14)
        .margin({ top: 4 })
    }
    .width('100%')
    .height('100%')
    .padding(14)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#0A0A0A', 0.0], ['#1E1E1E', 1.0]]
    })
    .alignItems(HorizontalAlign.Start)
  }
}