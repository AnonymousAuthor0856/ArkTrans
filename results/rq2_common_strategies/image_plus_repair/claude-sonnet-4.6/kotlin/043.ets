import { promptAction } from '@kit.ArkUI';

interface CartItem {
  id: number;
  name: string;
  price: number;
}

@Entry
@Component
struct RootScreen {
  @State promoCode: string = '';
  @State items: CartItem[] = [
    { id: 1, name: 'Neon Keyboard', price: 89.99 },
    { id: 2, name: 'Wireless Mouse', price: 49.99 },
    { id: 3, name: 'Gaming Headset', price: 109.99 }
  ];

  get total(): number {
    return this.items.reduce((sum, item) => sum + item.price, 0);
  }

  build() {
    Scroll() {
      Column({ space: 10 }) {
        Text('Your Cart')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00E5FF')
          .width('100%')
          .margin({ bottom: 4 })

        ForEach(this.items, (item: CartItem) => {
          Column() {
            Row() {
              Column({ space: 4 }) {
                Text(item.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FFFFFF')
                Text('$' + item.price.toFixed(2))
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
                .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                .onClick(() => {})
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .padding(10)
          }
          .width('100%')
          .backgroundColor('#121212')
          .borderRadius(14)
          .shadow({ radius: 4, color: '#26000000', offsetX: 0, offsetY: 2 })
        }, (item: CartItem) => item.id.toString())

        Column() {
          TextInput({ placeholder: 'Promo Code', text: this.promoCode })
            .placeholderColor('#80FFFFFF')
            .placeholderFont({ size: 14 })
            .fontColor('#FFFFFF')
            .fontSize(14)
            .backgroundColor('#1E1E1E')
            .borderRadius(10)
            .borderWidth({ bottom: 2 })
            .borderColor('#2C2C2C')
            .width('100%')
            .height(56)
            .padding({ left: 16, right: 16 })
            .onChange((value: string) => {
              this.promoCode = value;
            })
        }
        .width('100%')

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
            Text('$' + this.total.toFixed(2))
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
        .shadow({ radius: 4, color: '#26000000', offsetX: 0, offsetY: 2 })

        Button('Checkout')
          .width('100%')
          .height(56)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0A0A0A')
          .backgroundColor('#00BFA5')
          .borderRadius(14)
          .onClick(() => {})
      }
      .width('100%')
      .padding(14)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#0A0A0A', 0.0], ['#1E1E1E', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0A0A0A')
    .scrollBar(BarState.Off)
  }
}