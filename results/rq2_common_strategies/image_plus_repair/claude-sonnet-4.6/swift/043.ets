// Design Tokens
const primaryColor: string = '#00E5FF';
const secondaryColor: string = '#00BFA5';
const backgroundColor: string = '#0A0A0A';
const surfaceColor: string = '#121212';
const surfaceVariantColor: string = '#1E1E1E';
const outlineColor: string = '#2C2C2C';
const onPrimaryColor: string = '#0A0A0A';
const onSecondaryColor: string = '#0A0A0A';
const onSurfaceColor: string = '#FFFFFF';

const spacingSm: number = 6;
const spacingMd: number = 10;
const spacingLg: number = 14;

const shapeMedium: number = 10;
const shapeLarge: number = 14;

class CartItem {
  id: number = 0;
  name: string = '';
  price: number = 0;
}

@Entry
@Component
struct RootScreen {
  private items: CartItem[] = [
    { id: 1, name: 'Neon Keyboard', price: 89.99 },
    { id: 2, name: 'Wireless Mouse', price: 49.99 },
    { id: 3, name: 'Gaming Headset', price: 109.99 },
  ];

  @State private promo: string = '';

  private getTotal(): number {
    return this.items.reduce((sum: number, item: CartItem) => sum + item.price, 0);
  }

  @Builder
  CartItemCard(item: CartItem) {
    Row() {
      Column() {
        Text(item.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(onSurfaceColor)
          .margin({ bottom: 4 })

        Text('$' + item.price.toFixed(2))
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(secondaryColor)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Remove')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(onPrimaryColor)
        .backgroundColor(primaryColor)
        .borderRadius(shapeMedium)
        .padding({ left: spacingMd, right: spacingMd, top: spacingSm, bottom: spacingSm })
        .height('auto')
    }
    .width('100%')
    .padding(spacingMd)
    .backgroundColor(surfaceColor)
    .borderRadius(shapeLarge)
    .shadow({
      radius: 4,
      color: '#260A0A0A',
      offsetX: 0,
      offsetY: 2,
    })
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [[0x0A0A0A, 0.0], [0x1E1E1E, 1.0]],
        })

      Scroll() {
        Column() {
          Text('Your Cart')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(primaryColor)
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ bottom: spacingMd })

          ForEach(this.items, (item: CartItem) => {
            this.CartItemCard(item)
            Blank().height(spacingMd)
          })

          Blank().height(spacingMd)

          Stack({ alignContent: Alignment.Start }) {
            if (this.promo === '') {
              Text('Promo Code')
                .fontSize(14)
                .fontColor('#80FFFFFF')
                .padding(spacingMd)
                .width('100%')
            }
            TextInput({ text: this.promo })
              .fontSize(14)
              .fontColor(onSurfaceColor)
              .backgroundColor(surfaceVariantColor)
              .borderRadius(shapeMedium)
              .border({ width: 1, color: outlineColor, radius: shapeMedium })
              .padding(spacingMd)
              .width('100%')
              .caretColor(primaryColor)
              .onChange((value: string) => {
                this.promo = value;
              })
          }
          .width('100%')
          .margin({ bottom: spacingMd })

          Blank().height(spacingMd)

          Column() {
            Row() {
              Text('Items:')
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor(onSurfaceColor)

              Blank()
                .layoutWeight(1)

              Text('' + this.items.length)
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor(primaryColor)
            }
            .width('100%')
            .margin({ bottom: spacingSm })

            Row() {
              Text('Total:')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(onSurfaceColor)

              Blank()
                .layoutWeight(1)

              Text('$' + this.getTotal().toFixed(2))
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(primaryColor)
            }
            .width('100%')
          }
          .padding(spacingLg)
          .width('100%')
          .backgroundColor(surfaceVariantColor)
          .borderRadius(shapeLarge)
          .shadow({
            radius: 4,
            color: '#260A0A0A',
            offsetX: 0,
            offsetY: 2,
          })
          .margin({ bottom: spacingMd })

          Button('Checkout')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(onSecondaryColor)
            .width('100%')
            .height(56)
            .backgroundColor(secondaryColor)
            .borderRadius(shapeLarge)
            .margin({ top: spacingSm })
        }
        .padding(spacingLg)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(backgroundColor)
  }
}