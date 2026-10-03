// Design Tokens
class ShoppingCartTokens {
  static Colors = class {
    static primary: string = '#000000';
    static secondary: string = '#FF6F00';
    static tertiary: string = '#4CAF50';
    static background: string = '#FFFFFF';
    static surface: string = '#FFFFFF';
    static surfaceVariant: string = '#F5F5F5';
    static outline: string = '#E0E0E0';
    static error: string = '#F44336';
    static onPrimary: string = '#FFFFFF';
    static onBackground: string = '#000000';
    static onSurface: string = '#000000';
  };

  static Spacing = class {
    static xs: number = 2;
    static sm: number = 4;
    static md: number = 6;
    static lg: number = 8;
    static xl: number = 12;
    static xxl: number = 16;
    static xxxl: number = 24;
  };

  static Shapes = class {
    static small: number = 6;
    static medium: number = 8;
    static large: number = 12;
  };
}

interface CartItem {
  id: number;
  name: string;
  price: number;
  color: string;
}

@Entry
@Component
struct ShoppingCartPage {
  private cartItems: CartItem[] = [
    { id: 1, name: 'Wireless Headphones', price: 129.99, color: ShoppingCartTokens.Colors.secondary },
    { id: 2, name: 'Smartphone Case', price: 24.99, color: ShoppingCartTokens.Colors.primary },
    { id: 3, name: 'USB-C Cable', price: 19.99, color: ShoppingCartTokens.Colors.tertiary },
    { id: 4, name: 'Portable Charger', price: 49.99, color: ShoppingCartTokens.Colors.secondary }
  ];

  @State quantities: number[] = [1, 1, 1, 1];
  private shipping: number = 5.99;
  private tax: number = 18.50;
  private bottomBarHeight: number = 220;

  private get subtotal(): number {
    let sum: number = 0;
    for (let i = 0; i < this.cartItems.length; i++) {
      sum += this.cartItems[i].price * this.quantities[i];
    }
    return sum;
  }

  private get total(): number {
    return this.subtotal + this.shipping + this.tax;
  }

  @Builder
  featureBox() {
    Row() {
    }
    .width(28)
    .height(28)
    .backgroundColor(ShoppingCartTokens.Colors.surfaceVariant)
    .borderRadius(ShoppingCartTokens.Shapes.small)
  }

  @Builder
  quantityButton(symbol: string, index: number, isIncrement: boolean) {
    Button({ type: ButtonType.Normal }) {
      Text(symbol)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(ShoppingCartTokens.Colors.onSurface)
    }
    .width(28)
    .height(28)
    .backgroundColor(ShoppingCartTokens.Colors.surfaceVariant)
    .borderRadius(ShoppingCartTokens.Shapes.small)
    .onClick(() => {
      if (isIncrement) {
        if (this.quantities[index] < 10) {
          this.quantities[index] += 1;
        }
      } else {
        if (this.quantities[index] > 1) {
          this.quantities[index] -= 1;
        }
      }
    })
  }

  @Builder
  cartItemCard(item: CartItem, index: number) {
    Row() {
      Row() {
      }
      .width(60)
      .height(60)
      .backgroundColor(item.color)
      .borderRadius(ShoppingCartTokens.Shapes.medium)
      .margin({ right: ShoppingCartTokens.Spacing.lg })

      Column() {
        Text(item.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width(120)
          .margin({ bottom: ShoppingCartTokens.Spacing.xs })

        Text('$' + item.price.toFixed(2))
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
          .margin({ bottom: ShoppingCartTokens.Spacing.xs })

        Row({ space: ShoppingCartTokens.Spacing.sm }) {
          this.featureBox()
          this.featureBox()
          this.featureBox()
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column({ space: ShoppingCartTokens.Spacing.sm }) {
        this.quantityButton('+', index, true)
        Text(this.quantities[index].toString())
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
        this.quantityButton('-', index, false)
      }
      .margin({ right: ShoppingCartTokens.Spacing.lg })

      Button({ type: ButtonType.Normal }) {
        Text('Remove')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(ShoppingCartTokens.Colors.onPrimary)
      }
      .width(85)
      .height(36)
      .backgroundColor(ShoppingCartTokens.Colors.error)
      .borderRadius(ShoppingCartTokens.Shapes.medium)
    }
    .padding(ShoppingCartTokens.Spacing.lg)
    .width('100%')
    .minHeight(100)
    .backgroundColor(ShoppingCartTokens.Colors.surface)
    .borderRadius(ShoppingCartTokens.Shapes.large)
    .border({ width: 1, color: ShoppingCartTokens.Colors.outline })
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.14)',
      offsetY: 1
    })
  }

  @Builder
  chipsRow() {
    Row({ space: ShoppingCartTokens.Spacing.sm }) {
      ForEach(['Apply Coupon', 'Gift Wrap', 'Save for Later'], (label: string) => {
        Button({ type: ButtonType.Normal }) {
          Text(label)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(ShoppingCartTokens.Colors.onSurface)
        }
        .padding({ left: ShoppingCartTokens.Spacing.xl, right: ShoppingCartTokens.Spacing.xl, top: ShoppingCartTokens.Spacing.sm, bottom: ShoppingCartTokens.Spacing.sm })
        .backgroundColor(ShoppingCartTokens.Colors.surface)
        .borderRadius(ShoppingCartTokens.Shapes.small)
        .border({ width: 1, color: ShoppingCartTokens.Colors.outline })
      }, (label: string) => label)
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
  }

  @Builder
  summaryRow(title: string, value: number, emphasize: boolean) {
    Row() {
      Text(title)
        .fontSize(emphasize ? 18 : 12)
        .fontWeight(emphasize ? FontWeight.SemiBold : FontWeight.Regular)
        .fontColor(ShoppingCartTokens.Colors.onSurface)
      Blank()
      Text('$' + value.toFixed(2))
        .fontSize(emphasize ? 18 : 14)
        .fontWeight(emphasize ? FontWeight.SemiBold : FontWeight.Medium)
        .fontColor(ShoppingCartTokens.Colors.onSurface)
    }
    .width('100%')
  }

  @Builder
  topBar() {
    Row({ space: ShoppingCartTokens.Spacing.sm }) {
      Row() {
      }
      .width(20)
      .height(20)
      .backgroundColor(ShoppingCartTokens.Colors.primary)
      .borderRadius(ShoppingCartTokens.Shapes.small)

      Text('Shopping Cart')
        .fontSize(22)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(ShoppingCartTokens.Colors.onSurface)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding({ top: ShoppingCartTokens.Spacing.xxl, bottom: ShoppingCartTokens.Spacing.md })
  }

  @Builder
  bottomSummary() {
    Column({ space: ShoppingCartTokens.Spacing.md }) {
      this.summaryRow('Subtotal', this.subtotal, false)
      this.summaryRow('Shipping', this.shipping, false)
      this.summaryRow('Tax', this.tax, false)
      this.summaryRow('Total', this.total, true)

      Button({ type: ButtonType.Normal }) {
        Text('Proceed to Checkout')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(ShoppingCartTokens.Colors.onPrimary)
      }
      .width('100%')
      .height(44)
      .backgroundColor(ShoppingCartTokens.Colors.primary)
      .borderRadius(ShoppingCartTokens.Shapes.large)
    }
    .padding(ShoppingCartTokens.Spacing.lg)
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(ShoppingCartTokens.Colors.surface)
    .borderRadius(ShoppingCartTokens.Shapes.large)
    .shadow({
      radius: 6,
      color: 'rgba(0, 0, 0, 0.16)',
      offsetY: 1.5
    })
  }

  build() {
    Stack() {
      Column() {
      }
      .width('100%')
      .height('100%')
      .backgroundColor(ShoppingCartTokens.Colors.background)

      Column({ space: 0 }) {
        this.topBar()
          .margin({ top: 30, bottom: 20 })

        Scroll() {
          Column({ space: ShoppingCartTokens.Spacing.lg }) {
            ForEach(this.cartItems, (item: CartItem, index: number) => {
              this.cartItemCard(item, index)
            }, (item: CartItem) => item.id.toString())

            this.chipsRow()
          }
          .padding({ left: ShoppingCartTokens.Spacing.lg, right: ShoppingCartTokens.Spacing.lg })
          .padding({ top: ShoppingCartTokens.Spacing.md })
          .padding({ bottom: this.bottomBarHeight + ShoppingCartTokens.Spacing.lg })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      Column() {
        this.bottomSummary()
          .margin({ left: ShoppingCartTokens.Spacing.lg, right: ShoppingCartTokens.Spacing.lg, bottom: ShoppingCartTokens.Spacing.md })
      }
      .width('100%')
      .align(Alignment.Bottom)
    }
    .width('100%')
    .height('100%')
  }
}
