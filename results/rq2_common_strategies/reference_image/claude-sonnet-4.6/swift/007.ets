// ShoppingCartPage.ets

class CartTokens {
  static readonly colorPrimary: string = '#000000';
  static readonly colorSecondary: string = '#FF6F00';
  static readonly colorTertiary: string = '#4CAF50';
  static readonly colorBackground: string = '#FFFFFF';
  static readonly colorSurface: string = '#FFFFFF';
  static readonly colorSurfaceVariant: string = '#F5F5F5';
  static readonly colorOutline: string = '#E0E0E0';
  static readonly colorError: string = '#F44336';
  static readonly colorOnPrimary: string = '#FFFFFF';
  static readonly colorOnSurface: string = '#000000';

  static readonly radiusSmall: number = 6;
  static readonly radiusMedium: number = 8;
  static readonly radiusLarge: number = 12;

  static readonly spaceXs: number = 2;
  static readonly spaceSm: number = 4;
  static readonly spaceMd: number = 6;
  static readonly spaceLg: number = 8;
  static readonly spaceXl: number = 12;
  static readonly spaceXxl: number = 16;
  static readonly spaceXxxl: number = 24;

  static readonly shadowL2Radius: number = 4;
  static readonly shadowL2Color: string = '#24000000';
  static readonly shadowL2OffsetY: number = 1;
  static readonly shadowL3Radius: number = 6;
  static readonly shadowL3Color: string = '#29000000';
  static readonly shadowL3OffsetY: number = 1.5;
}

class CartItem {
  id: number;
  name: string;
  price: number;
  color: string;

  constructor(id: number, name: string, price: number, color: string) {
    this.id = id;
    this.name = name;
    this.price = price;
    this.color = color;
  }
}

@Entry
@Component
struct ShoppingCartPage {
  private cartItems: CartItem[] = [
    new CartItem(1, 'Wireless Headphones', 129.99, CartTokens.colorSecondary),
    new CartItem(2, 'Smartphone Case', 24.99, CartTokens.colorPrimary),
    new CartItem(3, 'USB-C Cable', 19.99, CartTokens.colorTertiary),
    new CartItem(4, 'Portable Charger', 49.99, CartTokens.colorSecondary)
  ];
  private chips: string[] = ['Apply Coupon', 'Gift Wrap', 'Save for Later'];
  private shipping: number = 5.99;
  private tax: number = 18.50;
  private bottomBarHeight: number = 220;

  @State quantities: number[] = [1, 1, 1, 1];

  private quantityAt(index: number): number {
    if (index >= 0 && index < this.quantities.length) {
      return this.quantities[index];
    }
    return 1;
  }

  private changeQuantity(index: number, delta: number): void {
    if (index < 0 || index >= this.quantities.length) {
      return;
    }
    const next: number = this.quantities[index] + delta;
    if (next < 1 || next > 10) {
      return;
    }
    const updated: number[] = [];
    for (let i = 0; i < this.quantities.length; i++) {
      updated.push(i === index ? next : this.quantities[i]);
    }
    this.quantities = updated;
  }

  private subtotal(): number {
    let sum: number = 0;
    for (let i = 0; i < this.cartItems.length; i++) {
      sum = sum + this.cartItems[i].price * this.quantityAt(i);
    }
    return sum;
  }

  private total(): number {
    return this.subtotal() + this.shipping + this.tax;
  }

  private money(value: number): string {
    return '$' + value.toFixed(2);
  }

  @Builder
  featureBox() {
    Column()
      .width(28)
      .height(28)
      .borderRadius(CartTokens.radiusSmall)
      .backgroundColor(CartTokens.colorSurfaceVariant)
  }

  @Builder
  topBar() {
    Row({ space: CartTokens.spaceSm }) {
      Column()
        .width(20)
        .height(20)
        .borderRadius(CartTokens.radiusSmall)
        .backgroundColor(CartTokens.colorPrimary)
      Text('Shopping Cart')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(CartTokens.colorOnSurface)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding({ top: 46, bottom: CartTokens.spaceMd })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.topBar()

        List({ space: CartTokens.spaceLg }) {
          ForEach(this.cartItems, (item: CartItem, index: number) => {
            ListItem() {
              Row({ space: CartTokens.spaceLg }) {
                Column()
                  .width(60)
                  .height(60)
                  .borderRadius(CartTokens.radiusMedium)
                  .backgroundColor(item.color)

                Column({ space: CartTokens.spaceXs }) {
                  Text(item.name)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(CartTokens.colorOnSurface)
                    .maxLines(2)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .width(120)
                    .textAlign(TextAlign.Start)

                  Text(this.money(item.price))
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(CartTokens.colorOnSurface)

                  Row({ space: CartTokens.spaceSm }) {
                    this.featureBox()
                    this.featureBox()
                    this.featureBox()
                  }
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Column({ space: CartTokens.spaceSm }) {
                  Button('+', { type: ButtonType.Normal, stateEffect: true })
                    .width(28)
                    .height(28)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(CartTokens.colorOnSurface)
                    .backgroundColor(CartTokens.colorSurfaceVariant)
                    .borderRadius(CartTokens.radiusSmall)
                    .onClick(() => {
                      this.changeQuantity(index, 1);
                    })

                  Text(this.quantityAt(index).toString())
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(CartTokens.colorOnSurface)

                  Button('-', { type: ButtonType.Normal, stateEffect: true })
                    .width(28)
                    .height(28)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(CartTokens.colorOnSurface)
                    .backgroundColor(CartTokens.colorSurfaceVariant)
                    .borderRadius(CartTokens.radiusSmall)
                    .onClick(() => {
                      this.changeQuantity(index, -1);
                    })
                }
                .justifyContent(FlexAlign.Center)

                Button('Remove', { type: ButtonType.Normal, stateEffect: true })
                  .width(85)
                  .height(36)
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(CartTokens.colorOnPrimary)
                  .backgroundColor(CartTokens.colorError)
                  .borderRadius(CartTokens.radiusMedium)
                  .onClick(() => {
                  })
              }
              .width('100%')
              .padding(CartTokens.spaceLg)
              .constraintSize({ minHeight: 100 })
              .alignItems(VerticalAlign.Center)
              .backgroundColor(CartTokens.colorSurface)
              .borderRadius(CartTokens.radiusLarge)
              .border({ width: 1, color: CartTokens.colorOutline })
              .shadow({
                radius: CartTokens.shadowL2Radius,
                color: CartTokens.shadowL2Color,
                offsetX: 0,
                offsetY: CartTokens.shadowL2OffsetY
              })
            }
          }, (item: CartItem) => item.id.toString())

          ListItem() {
            Row({ space: CartTokens.spaceSm }) {
              ForEach(this.chips, (label: string) => {
                Button(label, { type: ButtonType.Normal, stateEffect: true })
                  .height(30)
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(CartTokens.colorOnSurface)
                  .backgroundColor(CartTokens.colorSurface)
                  .borderRadius(CartTokens.radiusSmall)
                  .border({ width: 1, color: CartTokens.colorOutline })
                  .padding({ left: CartTokens.spaceXl, right: CartTokens.spaceXl })
                  .onClick(() => {
                  })
              }, (label: string) => label)
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)
          }

          ListItem() {
            Column()
              .width('100%')
              .height(this.bottomBarHeight)
          }
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .padding({ left: CartTokens.spaceLg, right: CartTokens.spaceLg, top: CartTokens.spaceMd })
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)

      Column() {
        Column({ space: CartTokens.spaceMd }) {
          Row() {
            Text('Subtotal')
              .fontSize(12)
              .fontWeight(FontWeight.Normal)
              .fontColor(CartTokens.colorOnSurface)
            Blank()
            Text(this.money(this.subtotal()))
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(CartTokens.colorOnSurface)
          }
          .width('100%')

          Row() {
            Text('Shipping')
              .fontSize(12)
              .fontWeight(FontWeight.Normal)
              .fontColor(CartTokens.colorOnSurface)
            Blank()
            Text(this.money(this.shipping))
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(CartTokens.colorOnSurface)
          }
          .width('100%')

          Row() {
            Text('Tax')
              .fontSize(12)
              .fontWeight(FontWeight.Normal)
              .fontColor(CartTokens.colorOnSurface)
            Blank()
            Text(this.money(this.tax))
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(CartTokens.colorOnSurface)
          }
          .width('100%')

          Row() {
            Text('Total')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(CartTokens.colorOnSurface)
            Blank()
            Text(this.money(this.total()))
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(CartTokens.colorOnSurface)
          }
          .width('100%')

          Button('Proceed to Checkout', { type: ButtonType.Normal, stateEffect: true })
            .width('100%')
            .height(44)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(CartTokens.colorOnPrimary)
            .backgroundColor(CartTokens.colorPrimary)
            .borderRadius(CartTokens.radiusLarge)
            .margin({ top: CartTokens.spaceXs })
            .onClick(() => {
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding(CartTokens.spaceLg)
        .backgroundColor(CartTokens.colorSurface)
        .borderRadius(CartTokens.radiusLarge)
        .shadow({
          radius: CartTokens.shadowL3Radius,
          color: CartTokens.shadowL3Color,
          offsetX: 0,
          offsetY: CartTokens.shadowL3OffsetY
        })
      }
      .width('100%')
      .padding({
        left: CartTokens.spaceLg,
        right: CartTokens.spaceLg,
        bottom: CartTokens.spaceMd
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(CartTokens.colorBackground)
  }
}