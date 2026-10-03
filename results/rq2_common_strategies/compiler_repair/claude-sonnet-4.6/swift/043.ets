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
const spacingXl: number = 20;

const shapeMedium: number = 10;
const shapeLarge: number = 14;

interface CartItem {
  id: number;
  name: string;
  price: number;
}

class CartItemClass implements CartItem {
  id: number = 0;
  name: string = '';
  price: number = 0;

  constructor(id: number, name: string, price: number) {
    this.id = id;
    this.name = name;
    this.price = price;
  }
}

const cartItems: CartItem[] = [
  new CartItemClass(1, 'Neon Keyboard', 89.99),
  new CartItemClass(2, 'Wireless Mouse', 49.99),
  new CartItemClass(3, 'Gaming Headset', 109.99),
];

@Component
struct CartItemCard {
  item: CartItem = new CartItemClass(0, '', 0);

  build() {
    Row() {
      Column() {
        Text(this.item.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(onSurfaceColor)
          .margin({ bottom: 4 })

        Text('$' + this.item.price.toFixed(2))
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
        .padding({
          left: spacingMd,
          right: spacingMd,
          top: spacingSm,
          bottom: spacingSm
        })
        .height('auto')
    }
    .alignItems(VerticalAlign.Center)
    .padding(spacingMd)
    .width('100%')
    .backgroundColor(surfaceColor)
    .borderRadius(shapeLarge)
    .shadow({
      radius: 4,
      color: '#260A0A0A',
      offsetX: 0,
      offsetY: 2,
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State promo: string = '';
  private items: CartItem[] = cartItems;

  getTotal(): number {
    let sum: number = 0;
    for (let i = 0; i < this.items.length; i++) {
      sum += this.items[i].price;
    }
    return sum;
  }

  build() {
    Stack() {
      // Background gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            [0xFF0A0A0A, 0.0],
            [0xFF1E1E1E, 1.0],
          ],
        })

      // Content
      Scroll() {
        Column({ space: spacingMd }) {
          // Title
          Text('Your Cart')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(primaryColor)
            .width('100%')
            .textAlign(TextAlign.Start)

          // Cart Items
          ForEach(this.items, (item: CartItem) => {
            CartItemCard({ item: item })
          }, (item: CartItem) => item.id.toString())

          // Spacer
          Column().height(spacingMd)

          // Promo Code Input
          Row() {
            TextInput({ placeholder: 'Promo Code', text: this.promo })
              .fontSize(14)
              .fontColor(onSurfaceColor)
              .placeholderColor('#80FFFFFF')
              .placeholderFont({ size: 14, weight: FontWeight.Normal })
              .backgroundColor(surfaceVariantColor)
              .borderRadius(shapeMedium)
              .border({ width: 1, color: outlineColor, radius: shapeMedium })
              .padding(spacingMd)
              .width('100%')
              .onChange((value: string) => {
                this.promo = value;
              })
          }
          .width('100%')

          // Spacer
          Column().height(spacingMd)

          // Summary Card
          Column({ space: spacingSm }) {
            Row() {
              Text('Items:')
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor(onSurfaceColor)

              Blank()

              Text(this.items.length.toString())
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor(primaryColor)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)

            Row() {
              Text('Total:')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(onSurfaceColor)

              Blank()

              Text('$' + this.getTotal().toFixed(2))
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(primaryColor)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
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

          // Checkout Button
          Button('Checkout')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(onSecondaryColor)
            .width('100%')
            .height(56)
            .backgroundColor(secondaryColor)
            .borderRadius(shapeLarge)
            .onClick(() => {})

          // Bottom padding
          Column().height(spacingXl)
        }
        .padding(spacingLg)
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}