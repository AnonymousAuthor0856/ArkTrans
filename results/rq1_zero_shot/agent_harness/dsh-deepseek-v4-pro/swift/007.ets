// Shopping Cart UI (SwiftUI -> ArkTS).

interface CartColors {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  error: string;
  onPrimary: string;
  onBackground: string;
  onSurface: string;
}

interface FontSpec {
  size: number;
  weight: FontWeight;
}

interface CartTypography {
  display: FontSpec;
  headline: FontSpec;
  title: FontSpec;
  body: FontSpec;
  label: FontSpec;
}

interface CartSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface CartShapes {
  small: number;
  medium: number;
  large: number;
}

interface ShadowSpec {
  radius: number;
  y: number;
  opacity: number;
}

interface CartElevation {
  level1: ShadowSpec;
  level2: ShadowSpec;
  level3: ShadowSpec;
  level4: ShadowSpec;
  level5: ShadowSpec;
}

class ShoppingCartTokens {
  static readonly Colors: CartColors = {
    primary: '#000000',
    secondary: '#FF6F00',
    tertiary: '#4CAF50',
    background: '#FFFFFF',
    surface: '#FFFFFF',
    surfaceVariant: '#F5F5F5',
    outline: '#E0E0E0',
    error: '#F44336',
    onPrimary: '#FFFFFF',
    onBackground: '#000000',
    onSurface: '#000000'
  };

  static readonly Typography: CartTypography = {
    display: { size: 22, weight: FontWeight.Semibold },
    headline: { size: 18, weight: FontWeight.Semibold },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Regular },
    label: { size: 10, weight: FontWeight.Medium }
  };

  static readonly Shapes: CartShapes = {
    small: 6, medium: 8, large: 12
  };

  static readonly Spacing: CartSpacing = {
    xs: 2, sm: 4, md: 6, lg: 8, xl: 12, xxl: 16, xxxl: 24
  };

  static readonly Elevation: CartElevation = {
    level1: { radius: 2, y: 0.5, opacity: 0.12 },
    level2: { radius: 4, y: 1, opacity: 0.14 },
    level3: { radius: 6, y: 1.5, opacity: 0.16 },
    level4: { radius: 8, y: 2, opacity: 0.18 },
    level5: { radius: 10, y: 2.5, opacity: 0.2 }
  };
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
struct ShoppingCartAppView {
  cartItems: CartItem[] = [
    new CartItem(1, 'Wireless Headphones', 129.99, ShoppingCartTokens.Colors.secondary),
    new CartItem(2, 'Smartphone Case', 24.99, ShoppingCartTokens.Colors.primary),
    new CartItem(3, 'USB-C Cable', 19.99, ShoppingCartTokens.Colors.tertiary),
    new CartItem(4, 'Portable Charger', 49.99, ShoppingCartTokens.Colors.secondary)
  ];

  @State quantities: number[] = [1, 1, 1, 1];

  shipping: number = 5.99;
  tax: number = 18.50;
  bottomBarHeight: number = 220;

  private subtotal(): number {
    let sum: number = 0;
    this.cartItems.forEach((item: CartItem, i: number) => {
      sum += item.price * this.quantities[i];
    });
    return sum;
  }

  private total(): number {
    return this.subtotal() + this.shipping + this.tax;
  }

  @Builder
  topBar() {
    Row({ space: ShoppingCartTokens.Spacing.sm }) {
      Row()
        .width(20)
        .height(20)
        .backgroundColor(ShoppingCartTokens.Colors.primary)
        .borderRadius(ShoppingCartTokens.Shapes.small)
      Text('Shopping Cart')
        .fontSize(ShoppingCartTokens.Typography.display.size)
        .fontWeight(ShoppingCartTokens.Typography.display.weight)
        .fontColor(ShoppingCartTokens.Colors.onSurface)
    }
    .width('100%')
    .padding({ top: 30 + ShoppingCartTokens.Spacing.xxl, bottom: 20 + ShoppingCartTokens.Spacing.md })
  }

  @Builder
  chipsRow() {
    const chips: string[] = ['Apply Coupon', 'Gift Wrap', 'Save for Later'];
    Row({ space: ShoppingCartTokens.Spacing.sm }) {
      ForEach(chips, (label: string) => {
        Button(label)
          .fontSize(ShoppingCartTokens.Typography.label.size)
          .fontWeight(ShoppingCartTokens.Typography.label.weight)
          .padding({ left: ShoppingCartTokens.Spacing.xl, right: ShoppingCartTokens.Spacing.xl, top: ShoppingCartTokens.Spacing.sm, bottom: ShoppingCartTokens.Spacing.sm })
          .backgroundColor(ShoppingCartTokens.Colors.surface)
          .borderRadius(ShoppingCartTokens.Shapes.small)
          .border({ width: 1, color: ShoppingCartTokens.Colors.outline })
          .fontColor(ShoppingCartTokens.Colors.onSurface)
          .onClick(() => {})
      }, (label: string) => label)
    }
    .width('100%')
  }

  @Builder
  bottomSummary() {
    Column({ space: ShoppingCartTokens.Spacing.md }) {
      Row() {
        Text('Subtotal')
          .fontSize(ShoppingCartTokens.Typography.body.size)
          .fontWeight(ShoppingCartTokens.Typography.body.weight)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
        Blank()
        Text('$' + this.subtotal().toFixed(2))
          .fontSize(ShoppingCartTokens.Typography.title.size)
          .fontWeight(ShoppingCartTokens.Typography.title.weight)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
      }

      Row() {
        Text('Shipping')
          .fontSize(ShoppingCartTokens.Typography.body.size)
          .fontWeight(ShoppingCartTokens.Typography.body.weight)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
        Blank()
        Text('$' + this.shipping.toFixed(2))
          .fontSize(ShoppingCartTokens.Typography.title.size)
          .fontWeight(ShoppingCartTokens.Typography.title.weight)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
      }

      Row() {
        Text('Tax')
          .fontSize(ShoppingCartTokens.Typography.body.size)
          .fontWeight(ShoppingCartTokens.Typography.body.weight)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
        Blank()
        Text('$' + this.tax.toFixed(2))
          .fontSize(ShoppingCartTokens.Typography.title.size)
          .fontWeight(ShoppingCartTokens.Typography.title.weight)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
      }

      Row() {
        Text('Total')
          .fontSize(ShoppingCartTokens.Typography.headline.size)
          .fontWeight(ShoppingCartTokens.Typography.headline.weight)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
        Blank()
        Text('$' + this.total().toFixed(2))
          .fontSize(ShoppingCartTokens.Typography.headline.size)
          .fontWeight(ShoppingCartTokens.Typography.headline.weight)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
      }

      Button('Proceed to Checkout')
        .fontSize(ShoppingCartTokens.Typography.title.size)
        .fontWeight(ShoppingCartTokens.Typography.title.weight)
        .width('100%')
        .height(44)
        .backgroundColor(ShoppingCartTokens.Colors.primary)
        .fontColor(ShoppingCartTokens.Colors.onPrimary)
        .borderRadius(ShoppingCartTokens.Shapes.large)
        .onClick(() => {})
    }
    .padding(ShoppingCartTokens.Spacing.lg)
    .width('100%')
    .backgroundColor(ShoppingCartTokens.Colors.surface)
    .borderRadius(ShoppingCartTokens.Shapes.large)
    .shadow({ radius: ShoppingCartTokens.Elevation.level3.radius, color: 'rgba(0,0,0,' + ShoppingCartTokens.Elevation.level3.opacity + ')', offsetX: 0, offsetY: ShoppingCartTokens.Elevation.level3.y })
    .margin({ left: ShoppingCartTokens.Spacing.lg, right: ShoppingCartTokens.Spacing.lg, bottom: ShoppingCartTokens.Spacing.md })
  }

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(ShoppingCartTokens.Colors.background)

      Column({ space: 0 }) {
        this.topBar()

        Scroll() {
          Column({ space: ShoppingCartTokens.Spacing.lg }) {
            ForEach(this.cartItems, (item: CartItem, index: number) => {
              Row({ space: ShoppingCartTokens.Spacing.lg }) {
                Row()
                  .width(60)
                  .height(60)
                  .backgroundColor(item.color)
                  .borderRadius(ShoppingCartTokens.Shapes.medium)

                Column({ space: ShoppingCartTokens.Spacing.xs }) {
                  Text(item.name)
                    .fontSize(ShoppingCartTokens.Typography.title.size)
                    .fontWeight(ShoppingCartTokens.Typography.title.weight)
                    .fontColor(ShoppingCartTokens.Colors.onSurface)
                    .width(120)
                    .textAlign(TextAlign.Start)
                    .maxLines(2)

                  Text('$' + item.price.toFixed(2))
                    .fontSize(ShoppingCartTokens.Typography.headline.size)
                    .fontWeight(ShoppingCartTokens.Typography.headline.weight)
                    .fontColor(ShoppingCartTokens.Colors.onSurface)

                  Row({ space: ShoppingCartTokens.Spacing.sm }) {
                    Row().width(28).height(28).backgroundColor(ShoppingCartTokens.Colors.surfaceVariant).borderRadius(ShoppingCartTokens.Shapes.small)
                    Row().width(28).height(28).backgroundColor(ShoppingCartTokens.Colors.surfaceVariant).borderRadius(ShoppingCartTokens.Shapes.small)
                    Row().width(28).height(28).backgroundColor(ShoppingCartTokens.Colors.surfaceVariant).borderRadius(ShoppingCartTokens.Shapes.small)
                  }
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Column({ space: ShoppingCartTokens.Spacing.sm }) {
                  Button('+')
                    .fontSize(ShoppingCartTokens.Typography.title.size)
                    .fontWeight(ShoppingCartTokens.Typography.title.weight)
                    .width(28)
                    .height(28)
                    .backgroundColor(ShoppingCartTokens.Colors.surfaceVariant)
                    .fontColor(ShoppingCartTokens.Colors.onSurface)
                    .borderRadius(ShoppingCartTokens.Shapes.small)
                    .onClick(() => {
                      if (index < this.quantities.length && this.quantities[index] < 10) {
                        this.quantities[index] += 1;
                      }
                    })

                  Text(this.quantities[index].toString())
                    .fontSize(ShoppingCartTokens.Typography.title.size)
                    .fontWeight(ShoppingCartTokens.Typography.title.weight)
                    .fontColor(ShoppingCartTokens.Colors.onSurface)

                  Button('-')
                    .fontSize(ShoppingCartTokens.Typography.title.size)
                    .fontWeight(ShoppingCartTokens.Typography.title.weight)
                    .width(28)
                    .height(28)
                    .backgroundColor(ShoppingCartTokens.Colors.surfaceVariant)
                    .fontColor(ShoppingCartTokens.Colors.onSurface)
                    .borderRadius(ShoppingCartTokens.Shapes.small)
                    .onClick(() => {
                      if (index < this.quantities.length && this.quantities[index] > 1) {
                        this.quantities[index] -= 1;
                      }
                    })
                }

                Button('Remove')
                  .fontSize(ShoppingCartTokens.Typography.label.size)
                  .fontWeight(ShoppingCartTokens.Typography.label.weight)
                  .width(85)
                  .height(36)
                  .backgroundColor(ShoppingCartTokens.Colors.error)
                  .fontColor(ShoppingCartTokens.Colors.onPrimary)
                  .borderRadius(ShoppingCartTokens.Shapes.medium)
                  .onClick(() => {})
              }
              .padding(ShoppingCartTokens.Spacing.lg)
              .width('100%')
              .constraintSize({ minHeight: 100 })
              .backgroundColor(ShoppingCartTokens.Colors.surface)
              .borderRadius(ShoppingCartTokens.Shapes.large)
              .border({ width: 1, color: ShoppingCartTokens.Colors.outline })
              .shadow({ radius: ShoppingCartTokens.Elevation.level2.radius, color: 'rgba(0,0,0,' + ShoppingCartTokens.Elevation.level2.opacity + ')', offsetX: 0, offsetY: ShoppingCartTokens.Elevation.level2.y })
            }, (item: CartItem) => item.id.toString())

            this.chipsRow()
          }
          .padding({ left: ShoppingCartTokens.Spacing.lg, right: ShoppingCartTokens.Spacing.lg, top: ShoppingCartTokens.Spacing.md, bottom: this.bottomBarHeight + ShoppingCartTokens.Spacing.lg })
        }
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
        this.bottomSummary()
      }
      .width('100%')
      .height('100%')
    }
  }
}
