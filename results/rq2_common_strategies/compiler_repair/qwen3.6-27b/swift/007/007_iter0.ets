import { BusinessError } from '@kit.BasicServicesKit';

// Token Definitions
const ShoppingCartTokens = {
  Colors: {
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
  },
  Typography: {
    display: { size: 22, weight: FontWeight.Semibold },
    headline: { size: 18, weight: FontWeight.Semibold },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Normal },
    label: { size: 10, weight: FontWeight.Medium }
  },
  Shapes: {
    small: 6,
    medium: 8,
    large: 12
  },
  Spacing: {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  },
  Elevation: {
    level2: { radius: 4, y: 1, opacity: 0.14 },
    level3: { radius: 6, y: 1.5, opacity: 0.16 }
  }
};

interface CartItem {
  id: number;
  name: string;
  price: number;
  color: string;
}

@Entry
@Component
struct ShoppingCartAppView {
  @State cartItems: CartItem[] = [
    { id: 1, name: "Wireless Headphones", price: 129.99, color: ShoppingCartTokens.Colors.secondary },
    { id: 2, name: "Smartphone Case", price: 24.99, color: ShoppingCartTokens.Colors.primary },
    { id: 3, name: "USB-C Cable", price: 19.99, color: ShoppingCartTokens.Colors.tertiary },
    { id: 4, name: "Portable Charger", price: 49.99, color: ShoppingCartTokens.Colors.secondary }
  ];

  @State quantities: number[] = [1, 1, 1, 1];

  private readonly shipping: number = 5.99;
  private readonly tax: number = 18.50;
  private readonly bottomBarHeight: number = 220;

  get subtotal(): number {
    return this.cartItems.reduce((acc, item, index) => acc + (item.price * this.quantities[index]), 0);
  }

  get total(): number {
    return this.subtotal + this.shipping + this.tax;
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top Bar
        Row() {
          Rectangle()
            .fill(ShoppingCartTokens.Colors.primary)
            .width(20)
            .height(20)
            .borderRadius(ShoppingCartTokens.Shapes.small)
          
          Text("Shopping Cart")
            .font({ size: ShoppingCartTokens.Typography.display.size, weight: ShoppingCartTokens.Typography.display.weight })
            .fontColor(ShoppingCartTokens.Colors.onSurface)
        }
        .width('100%')
        .padding({ top: ShoppingCartTokens.Spacing.xxl, bottom: ShoppingCartTokens.Spacing.md })
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Start)
        .margin({ left: ShoppingCartTokens.Spacing.lg, right: ShoppingCartTokens.Spacing.lg })

        // Scrollable Content
        Scroll() {
          Column() {
            ForEach(this.cartItems, (item: CartItem, index: number) => {
              this.CartItemCard(item, index)
            }, (item: CartItem) => item.id.toString())

            // Chips Row
            Row() {
              ['Apply Coupon', 'Gift Wrap', 'Save for Later'].forEach((label: string) => {
                Button(label) {
                  // Action
                }
                .font({ size: ShoppingCartTokens.Typography.label.size, weight: ShoppingCartTokens.Typography.label.weight })
                .backgroundColor(ShoppingCartTokens.Colors.surface)
                .borderWidth(1)
                .borderColor(ShoppingCartTokens.Colors.outline)
                .borderRadius(ShoppingCartTokens.Shapes.small)
                .margin({ right: ShoppingCartTokens.Spacing.sm })
                .height(32) // Approximate height based on padding
              })
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)
            .margin({ top: ShoppingCartTokens.Spacing.lg })
          }
          .padding({ top: ShoppingCartTokens.Spacing.md, bottom: this.bottomBarHeight + ShoppingCartTokens.Spacing.lg })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(ShoppingCartTokens.Colors.background)

      // Bottom Summary
      this.BottomSummary()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ShoppingCartTokens.Colors.background)
  }

  @Builder
  CartItemCard(item: CartItem, index: number) {
    Row() {
      // Image Placeholder
      Rectangle()
        .fill(item.color)
        .width(60)
        .height(60)
        .borderRadius(ShoppingCartTokens.Shapes.medium)

      Column() {
        Text(item.name)
          .font({ size: ShoppingCartTokens.Typography.title.size, weight: ShoppingCartTokens.Typography.title.weight })
          .fontColor(ShoppingCartTokens.Colors.onSurface)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width(120)
          .textAlign(TextAlign.Start)
        
        Text(`$${item.price.toFixed(2)}`)
          .font({ size: ShoppingCartTokens.Typography.headline.size, weight: ShoppingCartTokens.Typography.headline.weight })
          .fontColor(ShoppingCartTokens.Colors.onSurface)
          .margin({ top: ShoppingCartTokens.Spacing.xs })

        Row() {
          this.FeatureBox()
          this.FeatureBox()
          this.FeatureBox()
        }
        .margin({ top: ShoppingCartTokens.Spacing.sm })
        .justifyContent(FlexAlign.Start)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // Quantity Controls
      Column() {
        this.QuantityButton("+", () => {
          if (this.quantities[index] < 10) {
            this.quantities[index]++;
          }
        })
        
        Text(`${this.quantities[index]}`)
          .font({ size: ShoppingCartTokens.Typography.title.size, weight: ShoppingCartTokens.Typography.title.weight })
          .fontColor(ShoppingCartTokens.Colors.onSurface)
          .margin({ top: ShoppingCartTokens.Spacing.sm, bottom: ShoppingCartTokens.Spacing.sm })
        
        this.QuantityButton("-", () => {
          if (this.quantities[index] > 1) {
            this.quantities[index]--;
          }
        })
      }

      // Remove Button
      Button("Remove") {
        // Action
      }
      .font({ size: ShoppingCartTokens.Typography.label.size, weight: ShoppingCartTokens.Typography.label.weight })
      .fontColor(ShoppingCartTokens.Colors.onPrimary)
      .backgroundColor(ShoppingCartTokens.Colors.error)
      .borderRadius(ShoppingCartTokens.Shapes.medium)
      .width(85)
      .height(36)
    }
    .width('100%')
    .padding(ShoppingCartTokens.Spacing.lg)
    .backgroundColor(ShoppingCartTokens.Colors.surface)
    .borderRadius(ShoppingCartTokens.Shapes.large)
    .border({ width: 1, color: ShoppingCartTokens.Colors.outline })
    .shadow({ radius: ShoppingCartTokens.Elevation.level2.radius, color: `rgba(0,0,0,${ShoppingCartTokens.Elevation.level2.opacity})`, offsetY: ShoppingCartTokens.Elevation.level2.y })
    .margin({ bottom: ShoppingCartTokens.Spacing.lg })
  }

  @Builder
  FeatureBox() {
    Rectangle()
      .fill(ShoppingCartTokens.Colors.surfaceVariant)
      .width(28)
      .height(28)
      .borderRadius(ShoppingCartTokens.Shapes.small)
      .margin({ right: ShoppingCartTokens.Spacing.sm })
  }

  @Builder
  QuantityButton(symbol: string, action: () => void) {
    Button(symbol) {
      action();
    }
    .font({ size: ShoppingCartTokens.Typography.title.size, weight: ShoppingCartTokens.Typography.title.weight })
    .fontColor(ShoppingCartTokens.Colors.onSurface)
    .backgroundColor(ShoppingCartTokens.Colors.surfaceVariant)
    .borderRadius(ShoppingCartTokens.Shapes.small)
    .width(28)
    .height(28)
  }

  @Builder
  BottomSummary() {
    Column() {
      this.SummaryRow("Subtotal", this.subtotal)
      this.SummaryRow("Shipping", this.shipping)
      this.SummaryRow("Tax", this.tax)
      this.SummaryRow("Total", this.total, true)
      
      Button("Proceed to Checkout") {
        // Action
      }
      .font({ size: ShoppingCartTokens.Typography.title.size, weight: ShoppingCartTokens.Typography.title.weight })
      .fontColor(ShoppingCartTokens.Colors.onPrimary)
      .backgroundColor(ShoppingCartTokens.Colors.primary)
      .borderRadius(ShoppingCartTokens.Shapes.large)
      .height(44)
      .margin({ top: ShoppingCartTokens.Spacing.md })
    }
    .width('100%')
    .padding(ShoppingCartTokens.Spacing.lg)
    .backgroundColor(ShoppingCartTokens.Colors.surface)
    .borderRadius(ShoppingCartTokens.Shapes.large)
    .shadow({ radius: ShoppingCartTokens.Elevation.level3.radius, color: `rgba(0,0,0,${ShoppingCartTokens.Elevation.level3.opacity})`, offsetY: ShoppingCartTokens.Elevation.level3.y })
    .margin({ left: ShoppingCartTokens.Spacing.lg, right: ShoppingCartTokens.Spacing.lg, bottom: ShoppingCartTokens.Spacing.md })
  }

  @Builder
  SummaryRow(title: string, value: number, emphasize: boolean = false) {
    Row() {
      Text(title)
        .font({ 
          size: emphasize ? ShoppingCartTokens.Typography.headline.size : ShoppingCartTokens.Typography.body.size, 
          weight: emphasize ? ShoppingCartTokens.Typography.headline.weight : ShoppingCartTokens.Typography.body.weight 
        })
        .fontColor(ShoppingCartTokens.Colors.onSurface)
      
      Blank()
      
      Text(`$${value.toFixed(2)}`)
        .font({ 
          size: emphasize ? ShoppingCartTokens.Typography.headline.size : ShoppingCartTokens.Typography.title.size, 
          weight: emphasize ? ShoppingCartTokens.Typography.headline.weight : ShoppingCartTokens.Typography.title.weight 
        })
        .fontColor(ShoppingCartTokens.Colors.onSurface)
    }
    .width('100%')
    .margin({ bottom: ShoppingCartTokens.Spacing.md })
  }
}