interface ShadowSpec {
  radius: number;
  y: number;
  opacity: number;
}

interface TypographySpec {
  size: number;
  weight: FontWeight;
}

interface CartItem {
  id: number;
  name: string;
  price: number;
  color: ResourceColor;
}

class ShoppingCartTokens {
  static readonly Colors = {
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

  static readonly Typography: Record<string, TypographySpec> = {
    display: { size: 22, weight: FontWeight.SemiBold },
    headline: { size: 18, weight: FontWeight.SemiBold },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Regular },
    label: { size: 10, weight: FontWeight.Medium }
  };

  static readonly Shapes = {
    small: 6,
    medium: 8,
    large: 12
  };

  static readonly Spacing = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  };

  static readonly Elevation: Record<string, ShadowSpec> = {
    level1: { radius: 2, y: 0.5, opacity: 0.12 },
    level2: { radius: 4, y: 1, opacity: 0.14 },
    level3: { radius: 6, y: 1.5, opacity: 0.16 },
    level4: { radius: 8, y: 2, opacity: 0.18 },
    level5: { radius: 10, y: 2.5, opacity: 0.20 }
  };
}

@Entry
@Component
struct ShoppingCartAppView {
  private readonly cartItems: CartItem[] = [
    { id: 1, name: 'Wireless Headphones', price: 129.99, color: ShoppingCartTokens.Colors.secondary },
    { id: 2, name: 'Smartphone Case', price: 24.99, color: ShoppingCartTokens.Colors.primary },
    { id: 3, name: 'USB-C Cable', price: 19.99, color: ShoppingCartTokens.Colors.tertiary },
    { id: 4, name: 'Portable Charger', price: 49.99, color: ShoppingCartTokens.Colors.secondary }
  ];

  @State private quantities: number[] = [1, 1, 1, 1];

  private readonly shipping: number = 5.99;
  private readonly tax: number = 18.50;
  private readonly bottomBarHeight: number = 220;

  private get subtotal(): number {
    return this.cartItems.reduce((sum: number, item: CartItem, index: number) => {
      return sum + item.price * (this.quantities[index] ?? 1);
    }, 0);
  }

  private get total(): number {
    return this.subtotal + this.shipping + this.tax;
  }

  private money(value: number): string {
    return `$${value.toFixed(2)}`;
  }

  private shadowColor(opacity: number): string {
    return `rgba(0, 0, 0, ${opacity})`;
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.topBar()
          .padding({ top: 30, bottom: 20 })

        Scroll() {
          Column({ space: ShoppingCartTokens.Spacing.lg }) {
            ForEach(
              this.cartItems,
              (item: CartItem, index: number) => {
                this.cartItemCard(item, index)
              },
              (item: CartItem) => item.id.toString()
            )

            this.chipsRow()
          }
          .width('100%')
          .padding({
            left: ShoppingCartTokens.Spacing.lg,
            right: ShoppingCartTokens.Spacing.lg,
            top: ShoppingCartTokens.Spacing.md,
            bottom: this.bottomBarHeight + ShoppingCartTokens.Spacing.lg
          })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(ShoppingCartTokens.Colors.background)

      Column() {
        this.bottomSummary()
      }
      .width('100%')
      .padding({
        left: ShoppingCartTokens.Spacing.lg,
        right: ShoppingCartTokens.Spacing.lg,
        bottom: ShoppingCartTokens.Spacing.md
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ShoppingCartTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  @Builder
  private topBar() {
    Row({ space: ShoppingCartTokens.Spacing.sm }) {
      Blank()
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
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .padding({
      top: ShoppingCartTokens.Spacing.xxl,
      bottom: ShoppingCartTokens.Spacing.md
    })
  }

  @Builder
  private cartItemCard(item: CartItem, index: number) {
    Row({ space: ShoppingCartTokens.Spacing.lg }) {
      Blank()
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
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.money(item.price))
          .fontSize(ShoppingCartTokens.Typography.headline.size)
          .fontWeight(ShoppingCartTokens.Typography.headline.weight)
          .fontColor(ShoppingCartTokens.Colors.onSurface)

        Row({ space: ShoppingCartTokens.Spacing.sm }) {
          this.featureBox()
          this.featureBox()
          this.featureBox()
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Column({ space: ShoppingCartTokens.Spacing.sm }) {
        this.quantityButton('+', () => {
          if (index >= 0 && index < this.quantities.length && this.quantities[index] < 10) {
            const next: number[] = [...this.quantities];
            next[index] = next[index] + 1;
            this.quantities = next;
          }
        })

        Text(`${this.quantities[index] ?? 1}`)
          .fontSize(ShoppingCartTokens.Typography.title.size)
          .fontWeight(ShoppingCartTokens.Typography.title.weight)
          .fontColor(ShoppingCartTokens.Colors.onSurface)

        this.quantityButton('-', () => {
          if (index >= 0 && index < this.quantities.length && this.quantities[index] > 1) {
            const next: number[] = [...this.quantities];
            next[index] = next[index] - 1;
            this.quantities = next;
          }
        })
      }
      .alignItems(HorizontalAlign.Center)

      Button({ type: ButtonType.Normal }) {
        Text('Remove')
          .fontSize(ShoppingCartTokens.Typography.label.size)
          .fontWeight(ShoppingCartTokens.Typography.label.weight)
          .fontColor(ShoppingCartTokens.Colors.onPrimary)
      }
      .width(85)
      .height(36)
      .backgroundColor(ShoppingCartTokens.Colors.error)
      .borderRadius(ShoppingCartTokens.Shapes.medium)
    }
    .width('100%')
    .height(100)
    .padding(ShoppingCartTokens.Spacing.lg)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(ShoppingCartTokens.Colors.surface)
    .borderRadius(ShoppingCartTokens.Shapes.large)
    .border({
      width: 1,
      color: ShoppingCartTokens.Colors.outline
    })
    .shadow({
      radius: ShoppingCartTokens.Elevation.level2.radius,
      color: this.shadowColor(ShoppingCartTokens.Elevation.level2.opacity),
      offsetX: 0,
      offsetY: ShoppingCartTokens.Elevation.level2.y
    })
  }

  @Builder
  private featureBox() {
    Blank()
      .width(28)
      .height(28)
      .backgroundColor(ShoppingCartTokens.Colors.surfaceVariant)
      .borderRadius(ShoppingCartTokens.Shapes.small)
  }

  @Builder
  private quantityButton(symbol: string, action: () => void) {
    Button({ type: ButtonType.Normal }) {
      Text(symbol)
        .fontSize(ShoppingCartTokens.Typography.title.size)
        .fontWeight(ShoppingCartTokens.Typography.title.weight)
        .fontColor(ShoppingCartTokens.Colors.onSurface)
    }
    .width(28)
    .height(28)
    .backgroundColor(ShoppingCartTokens.Colors.surfaceVariant)
    .borderRadius(ShoppingCartTokens.Shapes.small)
    .onClick(action)
  }

  @Builder
  private chipsRow() {
    Row({ space: ShoppingCartTokens.Spacing.sm }) {
      ForEach(
        ['Apply Coupon', 'Gift Wrap', 'Save for Later'],
        (label: string) => {
          Button({ type: ButtonType.Normal }) {
            Text(label)
              .fontSize(ShoppingCartTokens.Typography.label.size)
              .fontWeight(ShoppingCartTokens.Typography.label.weight)
              .fontColor(ShoppingCartTokens.Colors.onSurface)
              .padding({
                left: ShoppingCartTokens.Spacing.xl,
                right: ShoppingCartTokens.Spacing.xl,
                top: ShoppingCartTokens.Spacing.sm,
                bottom: ShoppingCartTokens.Spacing.sm
              })
          }
          .backgroundColor(ShoppingCartTokens.Colors.surface)
          .borderRadius(ShoppingCartTokens.Shapes.small)
          .border({
            width: 1,
            color: ShoppingCartTokens.Colors.outline
          })
        },
        (label: string) => label
      )
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
  }

  @Builder
  private bottomSummary() {
    Column({ space: ShoppingCartTokens.Spacing.md }) {
      this.summaryRow('Subtotal', this.subtotal)
      this.summaryRow('Shipping', this.shipping)
      this.summaryRow('Tax', this.tax)
      this.summaryRow('Total', this.total, true)

      Button({ type: ButtonType.Normal }) {
        Text('Proceed to Checkout')
          .fontSize(ShoppingCartTokens.Typography.title.size)
          .fontWeight(ShoppingCartTokens.Typography.title.weight)
          .fontColor(ShoppingCartTokens.Colors.onPrimary)
      }
      .width('100%')
      .height(44)
      .backgroundColor(ShoppingCartTokens.Colors.primary)
      .borderRadius(ShoppingCartTokens.Shapes.large)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(ShoppingCartTokens.Spacing.lg)
    .backgroundColor(ShoppingCartTokens.Colors.surface)
    .borderRadius(ShoppingCartTokens.Shapes.large)
    .shadow({
      radius: ShoppingCartTokens.Elevation.level3.radius,
      color: this.shadowColor(ShoppingCartTokens.Elevation.level3.opacity),
      offsetX: 0,
      offsetY: ShoppingCartTokens.Elevation.level3.y
    })
  }

  @Builder
  private summaryRow(title: string, value: number, emphasize: boolean = false) {
    Row() {
      Text(title)
        .fontSize(emphasize ? ShoppingCartTokens.Typography.headline.size : ShoppingCartTokens.Typography.body.size)
        .fontWeight(emphasize ? ShoppingCartTokens.Typography.headline.weight : ShoppingCartTokens.Typography.body.weight)
        .fontColor(ShoppingCartTokens.Colors.onSurface)

      Blank()
        .layoutWeight(1)

      Text(this.money(value))
        .fontSize(emphasize ? ShoppingCartTokens.Typography.headline.size : ShoppingCartTokens.Typography.title.size)
        .fontWeight(emphasize ? ShoppingCartTokens.Typography.headline.weight : ShoppingCartTokens.Typography.title.weight)
        .fontColor(ShoppingCartTokens.Colors.onSurface)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}