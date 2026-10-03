// EntryIndex.ets
import { Length, Resource, ForEach, If, Else } from '@kit.ArkUI';

// --- Design Tokens ---
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
    onSurface: '#000000',
  };

  static readonly Typography = {
    display: { size: 22, weight: FontWeight.SemiBold },
    headline: { size: 18, weight: FontWeight.SemiBold },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Regular },
    label: { size: 10, weight: FontWeight.Medium },
  };

  static readonly Shapes = {
    small: 6,
    medium: 8,
    large: 12,
  };

  static readonly Spacing = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24,
  };

  static readonly Elevation = {
    level1: { radius: 2, y: 0.5, opacity: 0.12 },
    level2: { radius: 4, y: 1, opacity: 0.14 },
    level3: { radius: 6, y: 1.5, opacity: 0.16 },
    level4: { radius: 8, y: 2, opacity: 0.18 },
    level5: { radius: 10, y: 2.5, opacity: 0.2 },
  };
}

// --- Models ---
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

// --- View Model ---
class ShoppingCartViewModel {
  cartItems: CartItem[] = [
    new CartItem(1, "Wireless Headphones", 129.99, ShoppingCartTokens.Colors.secondary),
    new CartItem(2, "Smartphone Case", 24.99, ShoppingCartTokens.Colors.primary),
    new CartItem(3, "USB-C Cable", 19.99, ShoppingCartTokens.Colors.tertiary),
    new CartItem(4, "Portable Charger", 49.99, ShoppingCartTokens.Colors.secondary)
  ];

  quantities: number[] = [1, 1, 1, 1];

  shipping: number = 5.99;
  tax: number = 18.50;
  bottomBarHeight: number = 220;

  get subtotal(): number {
    let sum = 0;
    for (let i = 0; i < this.cartItems.length; i++) {
      sum += this.cartItems[i].price * this.quantities[i];
    }
    return sum;
  }

  get total(): number {
    return this.subtotal + this.shipping + this.tax;
  }

  incrementQuantity(index: number) {
    if (index >= 0 && index < this.quantities.length && this.quantities[index] < 10) {
      this.quantities[index] += 1;
    }
  }

  decrementQuantity(index: number) {
    if (index >= 0 && index < this.quantities.length && this.quantities[index] > 1) {
      this.quantities[index] -= 1;
    }
  }
}

// --- UI Components ---
@Component
struct FeatureBox {
  build() {
    Row()
      .width(28)
      .height(28)
      .backgroundColor(ShoppingCartTokens.Colors.surfaceVariant)
      .borderRadius(ShoppingCartTokens.Shapes.small);
  }
}

@Component
struct QuantityButton {
  @Prop symbol: string;
  onTap: () => void = () => {};

  build() {
    Button(this.symbol)
      .fontSize(ShoppingCartTokens.Typography.title.size)
      .fontWeight(ShoppingCartTokens.Typography.title.weight)
      .fontColor(ShoppingCartTokens.Colors.onSurface)
      .width(28)
      .height(28)
      .backgroundColor(ShoppingCartTokens.Colors.surfaceVariant)
      .borderRadius(ShoppingCartTokens.Shapes.small)
      .onClick(() => this.onTap());
  }
}

@Component
struct SummaryRow {
  @Prop title: string;
  @Prop value: number;
  @Prop emphasize: boolean = false;

  build() {
    Row() {
      Text(this.title)
        .fontSize(this.emphasize ? ShoppingCartTokens.Typography.headline.size : ShoppingCartTokens.Typography.body.size)
        .fontWeight(this.emphasize ? ShoppingCartTokens.Typography.headline.weight : ShoppingCartTokens.Typography.body.weight)
        .fontColor(ShoppingCartTokens.Colors.onSurface);

      Blank();

      Text(`$${this.value.toFixed(2)}`)
        .fontSize(this.emphasize ? ShoppingCartTokens.Typography.headline.size : ShoppingCartTokens.Typography.title.size)
        .fontWeight(this.emphasize ? ShoppingCartTokens.Typography.headline.weight : ShoppingCartTokens.Typography.title.weight)
        .fontColor(ShoppingCartTokens.Colors.onSurface);
    }
    .width('100%');
  }
}

@Component
struct ChipsRow {
  private chips: string[] = ["Apply Coupon", "Gift Wrap", "Save for Later"];

  build() {
    Row() {
      ForEach(this.chips, (label: string) => {
        Button(label)
          .fontSize(ShoppingCartTokens.Typography.label.size)
          .fontWeight(ShoppingCartTokens.Typography.label.weight)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
          .padding({ horizontal: ShoppingCartTokens.Spacing.xl, vertical: ShoppingCartTokens.Spacing.sm })
          .backgroundColor(ShoppingCartTokens.Colors.surface)
          .border({ width: 1, color: ShoppingCartTokens.Colors.outline })
          .borderRadius(ShoppingCartTokens.Shapes.small);
      }, (label: string) => label);
    }
    .width('100%');
  }
}

@Component
struct CartItemCard {
  @Prop item: CartItem;
  @Prop index: number;
  @Prop quantity: number;
  onIncrement: (index: number) => void = () => {};
  onDecrement: (index: number) => void = () => {};

  build() {
    Row() {
      // Item Color Icon
      Row()
        .width(60)
        .height(60)
        .backgroundColor(this.item.color)
        .borderRadius(ShoppingCartTokens.Shapes.medium);

      // Item Details
      Column() {
        Text(this.item.name)
          .fontSize(ShoppingCartTokens.Typography.title.size)
          .fontWeight(ShoppingCartTokens.Typography.title.weight)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width(120)
          .textAlign(TextAlign.Start);

        Text(`$${this.item.price.toFixed(2)}`)
          .fontSize(ShoppingCartTokens.Typography.headline.size)
          .fontWeight(ShoppingCartTokens.Typography.headline.weight)
          .fontColor(ShoppingCartTokens.Colors.onSurface);

        Row() {
          FeatureBox();
          FeatureBox();
          FeatureBox();
        }
        .margin({ top: ShoppingCartTokens.Spacing.sm });
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: ShoppingCartTokens.Spacing.lg });

      // Quantity Controls
      Column() {
        QuantityButton({ symbol: "+", onTap: () => this.onIncrement(this.index) });
        Text(`${this.quantity}`)
          .fontSize(ShoppingCartTokens.Typography.title.size)
          .fontWeight(ShoppingCartTokens.Typography.title.weight)
          .fontColor(ShoppingCartTokens.Colors.onSurface);
        QuantityButton({ symbol: "-", onTap: () => this.onDecrement(this.index) });
      }
      .margin({ left: ShoppingCartTokens.Spacing.lg });

      // Remove Button
      Button("Remove")
        .fontSize(ShoppingCartTokens.Typography.label.size)
        .fontWeight(ShoppingCartTokens.Typography.label.weight)
        .fontColor(ShoppingCartTokens.Colors.onPrimary)
        .width(85)
        .height(36)
        .backgroundColor(ShoppingCartTokens.Colors.error)
        .borderRadius(ShoppingCartTokens.Shapes.medium);
    }
    .padding(ShoppingCartTokens.Spacing.lg)
    .width('100%')
    .backgroundColor(ShoppingCartTokens.Colors.surface)
    .borderRadius(ShoppingCartTokens.Shapes.large)
    .border({ width: 1, color: ShoppingCartTokens.Colors.outline })
    .shadow({
      radius: ShoppingCartTokens.Elevation.level2.radius,
      color: `rgba(0,0,0,${ShoppingCartTokens.Elevation.level2.opacity})`,
      offsetY: ShoppingCartTokens.Elevation.level2.y
    });
  }
}

@Component
struct BottomSummary {
  @Prop subtotal: number;
  @Prop shipping: number;
  @Prop tax: number;
  @Prop total: number;

  build() {
    Column() {
      SummaryRow({ title: "Subtotal", value: this.subtotal });
      SummaryRow({ title: "Shipping", value: this.shipping });
      SummaryRow({ title: "Tax", value: this.tax });
      SummaryRow({ title: "Total", value: this.total, emphasize: true });

      Button("Proceed to Checkout")
        .fontSize(ShoppingCartTokens.Typography.title.size)
        .fontWeight(ShoppingCartTokens.Typography.title.weight)
        .fontColor(ShoppingCartTokens.Colors.onPrimary)
        .width('100%')
        .height(44)
        .backgroundColor(ShoppingCartTokens.Colors.primary)
        .borderRadius(ShoppingCartTokens.Shapes.large);
    }
    .padding(ShoppingCartTokens.Spacing.lg)
    .width('100%')
    .backgroundColor(ShoppingCartTokens.Colors.surface)
    .borderRadius(ShoppingCartTokens.Shapes.large)
    .shadow({
      radius: ShoppingCartTokens.Elevation.level3.radius,
      color: `rgba(0,0,0,${ShoppingCartTokens.Elevation.level3.opacity})`,
      offsetY: ShoppingCartTokens.Elevation.level3.y
    });
  }
}

// --- Main View ---
@Entry
@Component
struct ShoppingCartAppView {
  private viewModel: ShoppingCartViewModel = new ShoppingCartViewModel();
  @State quantities: number[] = this.viewModel.quantities;

  get subtotal(): number {
    let sum = 0;
    for (let i = 0; i < this.viewModel.cartItems.length; i++) {
      sum += this.viewModel.cartItems[i].price * this.quantities[i];
    }
    return sum;
  }

  get total(): number {
    return this.subtotal + this.viewModel.shipping + this.viewModel.tax;
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top Bar
        Row() {
          Row()
            .width(20)
            .height(20)
            .backgroundColor(ShoppingCartTokens.Colors.primary)
            .borderRadius(ShoppingCartTokens.Shapes.small);

          Text("Shopping Cart")
            .fontSize(ShoppingCartTokens.Typography.display.size)
            .fontWeight(ShoppingCartTokens.Typography.display.weight)
            .fontColor(ShoppingCartTokens.Colors.onSurface)
            .margin({ left: ShoppingCartTokens.Spacing.sm });
        }
        .width('100%')
        .padding({ top: 30, bottom: 20 });

        // Scrollable Content
        Scroll() {
          Column() {
            ForEach(this.viewModel.cartItems, (item: CartItem, index: number) => {
              CartItemCard({
                item: item,
                index: index,
                quantity: this.quantities[index],
                onIncrement: (i: number) => {
                  if (this.quantities[i] < 10) {
                    this.quantities[i] += 1;
                  }
                },
                onDecrement: (i: number) => {
                  if (this.quantities[i] > 1) {
                    this.quantities[i] -= 1;
                  }
                }
              });
            }, (item: CartItem) => `${item.id}`);

            ChipsRow();
          }
          .padding({ 
            left: ShoppingCartTokens.Spacing.lg, 
            right: ShoppingCartTokens.Spacing.lg, 
            top: ShoppingCartTokens.Spacing.md,
            bottom: this.viewModel.bottomBarHeight + ShoppingCartTokens.Spacing.lg
          });
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off);
      }
      .width('100%')
      .height('100%')
      .backgroundColor(ShoppingCartTokens.Colors.background);

      // Bottom Summary
      BottomSummary({
        subtotal: this.subtotal,
        shipping: this.viewModel.shipping,
        tax: this.viewModel.tax,
        total: this.total
      })
      .padding({ 
        left: ShoppingCartTokens.Spacing.lg, 
        right: ShoppingCartTokens.Spacing.lg, 
        bottom: ShoppingCartTokens.Spacing.md 
      });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ShoppingCartTokens.Colors.background);
  }
}