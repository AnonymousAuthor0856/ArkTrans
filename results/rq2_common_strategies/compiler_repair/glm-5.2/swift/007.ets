// ShoppingCartApp.ets
interface CartItem {
  id: number;
  name: string;
  price: number;
  color: ResourceColor;
}

interface ShadowSpec {
  radius: number;
  y: number;
  opacity: number;
}

interface ColorsType {
  primary: ResourceColor;
  secondary: ResourceColor;
  tertiary: ResourceColor;
  background: ResourceColor;
  surface: ResourceColor;
  surfaceVariant: ResourceColor;
  outline: ResourceColor;
  error: ResourceColor;
  onPrimary: ResourceColor;
  onBackground: ResourceColor;
  onSurface: ResourceColor;
}

interface TypographyItem {
  fontSize: number | string | Resource;
  fontWeight: FontWeight | number;
}

interface TypographyType {
  display: TypographyItem;
  headline: TypographyItem;
  title: TypographyItem;
  body: TypographyItem;
  label: TypographyItem;
}

interface ShapesType {
  small: number;
  medium: number;
  large: number;
}

interface SpacingType {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface ElevationType {
  level1: ShadowSpec;
  level2: ShadowSpec;
  level3: ShadowSpec;
  level4: ShadowSpec;
  level5: ShadowSpec;
}

class ShoppingCartTokens {
  static Colors: ColorsType = {
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
    onSurface: '#000000',
  };

  static Typography: TypographyType = {
    display: { fontSize: 22, fontWeight: FontWeight.Bold },
    headline: { fontSize: 18, fontWeight: FontWeight.Bold },
    title: { fontSize: 14, fontWeight: FontWeight.Medium },
    body: { fontSize: 12, fontWeight: FontWeight.Normal },
    label: { fontSize: 10, fontWeight: FontWeight.Medium },
  };

  static Shapes: ShapesType = {
    small: 6,
    medium: 8,
    large: 12,
  };

  static Spacing: SpacingType = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24,
  };

  static Elevation: ElevationType = {
    level1: { radius: 2, y: 0.5, opacity: 0.12 } as ShadowSpec,
    level2: { radius: 4, y: 1, opacity: 0.14 } as ShadowSpec,
    level3: { radius: 6, y: 1.5, opacity: 0.16 } as ShadowSpec,
    level4: { radius: 8, y: 2, opacity: 0.18 } as ShadowSpec,
    level5: { radius: 10, y: 2.5, opacity: 0.2 } as ShadowSpec,
  };
}

@Entry
@Component
struct ShoppingCartAppView {
  private cartItems: CartItem[] = [
    { id: 1, name: 'Wireless Headphones', price: 129.99, color: ShoppingCartTokens.Colors.secondary },
    { id: 2, name: 'Smartphone Case', price: 24.99, color: ShoppingCartTokens.Colors.primary },
    { id: 3, name: 'USB-C Cable', price: 19.99, color: ShoppingCartTokens.Colors.tertiary },
    { id: 4, name: 'Portable Charger', price: 49.99, color: ShoppingCartTokens.Colors.secondary },
  ];

  @State quantities: number[] = [1, 1, 1, 1];

  private shipping: number = 5.99;
  private tax: number = 18.50;
  private bottomBarHeight: number = 220;

  private get subtotal(): number {
    let sum = 0;
    this.cartItems.forEach((item, index) => {
      sum += item.price * this.quantities[index];
    });
    return sum;
  }

  private get total(): number {
    return this.subtotal + this.shipping + this.tax;
  }

  private formatPrice(value: number): string {
    return `$${value.toFixed(2)}`;
  }

  @Builder
  TopBar() {
    Row({ space: ShoppingCartTokens.Spacing.sm }) {
      Text('')
        .width(20)
        .height(20)
        .borderRadius(ShoppingCartTokens.Shapes.small)
        .backgroundColor(ShoppingCartTokens.Colors.primary)
      
      Text('Shopping Cart')
        .fontColor(ShoppingCartTokens.Colors.onSurface)
        .fontSize(ShoppingCartTokens.Typography.display.fontSize)
        .fontWeight(ShoppingCartTokens.Typography.display.fontWeight)
    }
    .width('100%')
    .padding({ top: 30, bottom: 20 })
  }

  @Builder
  FeatureBox() {
    Column()
      .width(28)
      .height(28)
      .borderRadius(ShoppingCartTokens.Shapes.small)
      .backgroundColor(ShoppingCartTokens.Colors.surfaceVariant)
  }

  @Builder
  QuantityButton(symbol: string, onClick: () => void) {
    Button(symbol, { type: ButtonType.Normal })
      .onClick(onClick)
      .fontSize(ShoppingCartTokens.Typography.title.fontSize)
      .fontWeight(ShoppingCartTokens.Typography.title.fontWeight)
      .fontColor(ShoppingCartTokens.Colors.onSurface)
      .width(28)
      .height(28)
      .borderRadius(ShoppingCartTokens.Shapes.small)
      .backgroundColor(ShoppingCartTokens.Colors.surfaceVariant)
      .padding(0)
  }

  @Builder
  CartItemCard(item: CartItem, index: number) {
    Row({ space: ShoppingCartTokens.Spacing.lg }) {
      // Item Color Icon
      Column()
        .width(60)
        .height(60)
        .borderRadius(ShoppingCartTokens.Shapes.medium)
        .backgroundColor(item.color)

      // Item Details
      Column({ space: ShoppingCartTokens.Spacing.xs }) {
        Text(item.name)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
          .fontSize(ShoppingCartTokens.Typography.title.fontSize)
          .fontWeight(ShoppingCartTokens.Typography.title.fontWeight)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .constraintSize({ maxWidth: 120 })
          .alignSelf(ItemAlign.Start)

        Text(this.formatPrice(item.price))
          .fontColor(ShoppingCartTokens.Colors.onSurface)
          .fontSize(ShoppingCartTokens.Typography.headline.fontSize)
          .fontWeight(ShoppingCartTokens.Typography.headline.fontWeight)
          .alignSelf(ItemAlign.Start)

        Row({ space: ShoppingCartTokens.Spacing.sm }) {
          this.FeatureBox()
          this.FeatureBox()
          this.FeatureBox()
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // Quantity Controls
      Column({ space: ShoppingCartTokens.Spacing.sm }) {
        this.QuantityButton('+', () => {
          if (index < this.quantities.length && this.quantities[index] < 10) {
            this.quantities[index] += 1;
          }
        })
        
        Text(this.quantities[index] ? this.quantities[index].toString() : '1')
          .fontColor(ShoppingCartTokens.Colors.onSurface)
          .fontSize(ShoppingCartTokens.Typography.title.fontSize)
          .fontWeight(ShoppingCartTokens.Typography.title.fontWeight)
        
        this.QuantityButton('-', () => {
          if (index < this.quantities.length && this.quantities[index] > 1) {
            this.quantities[index] -= 1;
          }
        })
      }

      // Remove Button
      Button('Remove', { type: ButtonType.Normal })
        .onClick(() => {})
        .fontSize(ShoppingCartTokens.Typography.label.fontSize)
        .fontWeight(ShoppingCartTokens.Typography.label.fontWeight)
        .fontColor(ShoppingCartTokens.Colors.onPrimary)
        .width(85)
        .height(36)
        .borderRadius(ShoppingCartTokens.Shapes.medium)
        .backgroundColor(ShoppingCartTokens.Colors.error)
        .padding(0)
    }
    .padding(ShoppingCartTokens.Spacing.lg)
    .width('100%')
    .borderRadius(ShoppingCartTokens.Shapes.large)
    .backgroundColor(ShoppingCartTokens.Colors.surface)
    .border({ width: 1, color: ShoppingCartTokens.Colors.outline })
    .shadow({
      radius: ShoppingCartTokens.Elevation.level2.radius,
      color: `rgba(0,0,0,${ShoppingCartTokens.Elevation.level2.opacity})`,
      offsetY: ShoppingCartTokens.Elevation.level2.y
    })
  }

  @Builder
  ChipsRow() {
    Row({ space: ShoppingCartTokens.Spacing.sm }) {
      ForEach(['Apply Coupon', 'Gift Wrap', 'Save for Later'], (label: string) => {
        Button(label, { type: ButtonType.Normal })
          .onClick(() => {})
          .fontSize(ShoppingCartTokens.Typography.label.fontSize)
          .fontWeight(ShoppingCartTokens.Typography.label.fontWeight)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
          .padding({ left: ShoppingCartTokens.Spacing.xl, right: ShoppingCartTokens.Spacing.xl, top: ShoppingCartTokens.Spacing.sm, bottom: ShoppingCartTokens.Spacing.sm })
          .borderRadius(ShoppingCartTokens.Shapes.small)
          .backgroundColor(ShoppingCartTokens.Colors.surface)
          .border({ width: 1, color: ShoppingCartTokens.Colors.outline })
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
  }

  @Builder
  SummaryRow(title: string, value: number, emphasize: boolean = false) {
    Row() {
      Text(title)
        .fontColor(ShoppingCartTokens.Colors.onSurface)
        .fontSize(emphasize ? ShoppingCartTokens.Typography.headline.fontSize : ShoppingCartTokens.Typography.body.fontSize)
        .fontWeight(emphasize ? ShoppingCartTokens.Typography.headline.fontWeight : ShoppingCartTokens.Typography.body.fontWeight)
      
      Blank() // Spacer equivalent
      
      Text(this.formatPrice(value))
        .fontColor(ShoppingCartTokens.Colors.onSurface)
        .fontSize(emphasize ? ShoppingCartTokens.Typography.headline.fontSize : ShoppingCartTokens.Typography.title.fontSize)
        .fontWeight(emphasize ? ShoppingCartTokens.Typography.headline.fontWeight : ShoppingCartTokens.Typography.title.fontWeight)
    }
    .width('100%')
  }

  @Builder
  BottomSummary() {
    Column({ space: ShoppingCartTokens.Spacing.md }) {
      this.SummaryRow('Subtotal', this.subtotal)
      this.SummaryRow('Shipping', this.shipping)
      this.SummaryRow('Tax', this.tax)
      this.SummaryRow('Total', this.total, true)
      
      Button('Proceed to Checkout', { type: ButtonType.Normal })
        .onClick(() => {})
        .fontSize(ShoppingCartTokens.Typography.title.fontSize)
        .fontWeight(ShoppingCartTokens.Typography.title.fontWeight)
        .fontColor(ShoppingCartTokens.Colors.onPrimary)
        .width('100%')
        .height(44)
        .borderRadius(ShoppingCartTokens.Shapes.large)
        .backgroundColor(ShoppingCartTokens.Colors.primary)
    }
    .padding(ShoppingCartTokens.Spacing.lg)
    .width('100%')
    .borderRadius(ShoppingCartTokens.Shapes.large)
    .backgroundColor(ShoppingCartTokens.Colors.surface)
    .shadow({
      radius: ShoppingCartTokens.Elevation.level3.radius,
      color: `rgba(0,0,0,${ShoppingCartTokens.Elevation.level3.opacity})`,
      offsetY: ShoppingCartTokens.Elevation.level3.y
    })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background Layer
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(ShoppingCartTokens.Colors.background)

      // Main Content Layer
      Column() {
        this.TopBar()
        
        Scroll() {
          Column({ space: ShoppingCartTokens.Spacing.lg }) {
            ForEach(this.cartItems, (item: CartItem, index: number) => {
              this.CartItemCard(item, index)
            })
            this.ChipsRow()
          }
          .width('100%')
          .padding({
            left: ShoppingCartTokens.Spacing.lg,
            right: ShoppingCartTokens.Spacing.lg,
            top: ShoppingCartTokens.Spacing.md,
            bottom: this.bottomBarHeight + ShoppingCartTokens.Spacing.lg
          })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .align(Alignment.Top)
      }
      .width('100%')
      .height('100%')

      // Bottom Summary Layer
      Column() {
        this.BottomSummary()
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
  }
}