import { BusinessError } from '@kit.BasicServicesKit';

// Token definitions matching the SwiftUI source
enum ShoppingCartTokens {
  enum Colors {
    static readonly primary: string = '#000000';
    static readonly secondary: string = '#FF6F00';
    static readonly tertiary: string = '#4CAF50';
    static readonly background: string = '#FFFFFF';
    static readonly surface: string = '#FFFFFF';
    static readonly surfaceVariant: string = '#F5F5F5';
    static readonly outline: string = '#E0E0E0';
    static readonly error: string = '#F44336';
    static readonly onPrimary: string = '#FFFFFF';
    static readonly onBackground: string = '#000000';
    static readonly onSurface: string = '#000000';
  }

  enum Typography {
    static readonly display = { fontSize: 22, fontWeight: FontWeight.Semibold };
    static readonly headline = { fontSize: 18, fontWeight: FontWeight.Semibold };
    static readonly title = { fontSize: 14, fontWeight: FontWeight.Medium };
    static readonly body = { fontSize: 12, fontWeight: FontWeight.Normal };
    static readonly label = { fontSize: 10, fontWeight: FontWeight.Medium };
  }

  enum Shapes {
    static readonly small: number = 6;
    static readonly medium: number = 8;
    static readonly large: number = 12;
  }

  enum Spacing {
    static readonly xs: number = 2;
    static readonly sm: number = 4;
    static readonly md: number = 6;
    static readonly lg: number = 8;
    static readonly xl: number = 12;
    static readonly xxl: number = 16;
    static readonly xxxl: number = 24;
  }

  interface ShadowSpec {
    radius: number;
    y: number;
    opacity: number;
  }

  enum Elevation {
    static readonly level1: ShadowSpec = { radius: 2, y: 0.5, opacity: 0.12 };
    static readonly level2: ShadowSpec = { radius: 4, y: 1, opacity: 0.14 };
    static readonly level3: ShadowSpec = { radius: 6, y: 1.5, opacity: 0.16 };
    static readonly level4: ShadowSpec = { radius: 8, y: 2, opacity: 0.18 };
    static readonly level5: ShadowSpec = { radius: 10, y: 2.5, opacity: 0.2 };
  }
}

interface CartItem {
  id: number;
  name: string;
  price: number;
  color: string;
}

@Entry
@Component
struct ShoppingCartAppView {
  private cartItems: CartItem[] = [
    { id: 1, name: "Wireless Headphones", price: 129.99, color: ShoppingCartTokens.Colors.secondary },
    { id: 2, name: "Smartphone Case", price: 24.99, color: ShoppingCartTokens.Colors.primary },
    { id: 3, name: "USB-C Cable", price: 19.99, color: ShoppingCartTokens.Colors.tertiary },
    { id: 4, name: "Portable Charger", price: 49.99, color: ShoppingCartTokens.Colors.secondary }
  ];

  @State quantities: number[] = [1, 1, 1, 1];

  private shipping: number = 5.99;
  private tax: number = 18.50;
  private bottomBarHeight: number = 220;

  get subtotal(): number {
    return this.cartItems.reduce((sum, item, index) => sum + (item.price * this.quantities[index]), 0);
  }

  get total(): number {
    return this.subtotal + this.shipping + this.tax;
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Bottom }) {
        // Background
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor(ShoppingCartTokens.Colors.background);

        Column() {
          // Top Bar
          Row() {
            Rectangle()
              .fill(ShoppingCartTokens.Colors.primary)
              .width(20)
              .height(20)
              .borderRadius(ShoppingCartTokens.Shapes.small);
            
            Text("Shopping Cart")
              .font-size(ShoppingCartTokens.Typography.display.fontSize)
              .fontWeight(ShoppingCartTokens.Typography.display.fontWeight)
              .fontColor(ShoppingCartTokens.Colors.onSurface)
              .margin({ left: ShoppingCartTokens.Spacing.sm });
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)
          .padding({ top: 30, bottom: 20, left: ShoppingCartTokens.Spacing.lg, right: ShoppingCartTokens.Spacing.lg });

          // Scrollable Content
          Scroll() {
            Column() {
              ForEach(this.cartItems.map((item, index) => ({ ...item, index })), (item: any) => {
                this.cartItemCard(item, item.index);
              });
              
              // Chips Row
              Row() {
                ["Apply Coupon", "Gift Wrap", "Save for Later"].forEach(label => {
                  Button(label) {
                    // Action
                  }
                  .font-size(ShoppingCartTokens.Typography.label.fontSize)
                  .fontWeight(ShoppingCartTokens.Typography.label.fontWeight)
                  .fontColor(ShoppingCartTokens.Colors.onSurface)
                  .backgroundColor(ShoppingCartTokens.Colors.surface)
                  .borderWidth(1)
                  .borderColor(ShoppingCartTokens.Colors.outline)
                  .borderRadius(ShoppingCartTokens.Shapes.small)
                  .padding({ left: ShoppingCartTokens.Spacing.xl, right: ShoppingCartTokens.Spacing.xl, top: ShoppingCartTokens.Spacing.sm, bottom: ShoppingCartTokens.Spacing.sm })
                  .margin({ right: ShoppingCartTokens.Spacing.sm });
                });
              }
              .width('100%')
              .justifyContent(FlexAlign.Start)
              .margin({ top: ShoppingCartTokens.Spacing.md });
            }
            .padding({ top: ShoppingCartTokens.Spacing.md, bottom: this.bottomBarHeight + ShoppingCartTokens.Spacing.lg });
          }
          .layoutWeight(1)
          .scrollBar(BarState.Off)
          .align(Alignment.Top);
        }
        .width('100%')
        .height('100%');

        // Bottom Summary
        this.bottomSummary();
      }
      .width('100%')
      .height('100%');
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ShoppingCartTokens.Colors.background);
  }

  @Builder
  cartItemCard(item: CartItem, index: number) {
    Row() {
      // Image Placeholder
      Rectangle()
        .fill(item.color)
        .width(60)
        .height(60)
        .borderRadius(ShoppingCartTokens.Shapes.medium);

      // Item Details
      Column() {
        Text(item.name)
          .font-size(ShoppingCartTokens.Typography.title.fontSize)
          .fontWeight(ShoppingCartTokens.Typography.title.fontWeight)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width(120)
          .textAlign(TextAlign.Start);

        Text(`$${item.price.toFixed(2)}`)
          .font-size(ShoppingCartTokens.Typography.headline.fontSize)
          .fontWeight(ShoppingCartTokens.Typography.headline.fontWeight)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
          .margin({ top: ShoppingCartTokens.Spacing.xs });

        // Feature Boxes
        Row() {
          ForEach([1, 2, 3], () => {
            Rectangle()
              .fill(ShoppingCartTokens.Colors.surfaceVariant)
              .width(28)
              .height(28)
              .borderRadius(ShoppingCartTokens.Shapes.small)
              .margin({ right: ShoppingCartTokens.Spacing.sm });
          });
        }
        .margin({ top: ShoppingCartTokens.Spacing.xs });
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start);

      // Quantity Controls
      Column() {
        Button('+') {
          if (this.quantities[index] < 10) {
            this.quantities[index]++;
          }
        }
        .font-size(ShoppingCartTokens.Typography.title.fontSize)
        .fontWeight(ShoppingCartTokens.Typography.title.fontWeight)
        .fontColor(ShoppingCartTokens.Colors.onSurface)
        .backgroundColor(ShoppingCartTokens.Colors.surfaceVariant)
        .borderRadius(ShoppingCartTokens.Shapes.small)
        .width(28)
        .height(28);

        Text(`${this.quantities[index]}`)
          .font-size(ShoppingCartTokens.Typography.title.fontSize)
          .fontWeight(ShoppingCartTokens.Typography.title.fontWeight)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
          .margin({ top: ShoppingCartTokens.Spacing.sm, bottom: ShoppingCartTokens.Spacing.sm });

        Button('-') {
          if (this.quantities[index] > 1) {
            this.quantities[index]--;
          }
        }
        .font-size(ShoppingCartTokens.Typography.title.fontSize)
        .fontWeight(ShoppingCartTokens.Typography.title.fontWeight)
        .fontColor(ShoppingCartTokens.Colors.onSurface)
        .backgroundColor(ShoppingCartTokens.Colors.surfaceVariant)
        .borderRadius(ShoppingCartTokens.Shapes.small)
        .width(28)
        .height(28);
      }
      .margin({ left: ShoppingCartTokens.Spacing.lg, right: ShoppingCartTokens.Spacing.lg });

      // Remove Button
      Button('Remove') {
        // Action
      }
      .font-size(ShoppingCartTokens.Typography.label.fontSize)
      .fontWeight(ShoppingCartTokens.Typography.label.fontWeight)
      .fontColor(ShoppingCartTokens.Colors.onPrimary)
      .backgroundColor(ShoppingCartTokens.Colors.error)
      .borderRadius(ShoppingCartTokens.Shapes.medium)
      .width(85)
      .height(36);
    }
    .width('100%')
    .padding(ShoppingCartTokens.Spacing.lg)
    .backgroundColor(ShoppingCartTokens.Colors.surface)
    .borderRadius(ShoppingCartTokens.Shapes.large)
    .shadow({
      radius: ShoppingCartTokens.Elevation.level2.radius,
      color: `rgba(0, 0, 0, ${ShoppingCartTokens.Elevation.level2.opacity})`,
      offsetX: 0,
      offsetY: ShoppingCartTokens.Elevation.level2.y
    })
    .border({ width: 1, color: ShoppingCartTokens.Colors.outline, radius: ShoppingCartTokens.Shapes.large })
    .margin({ bottom: ShoppingCartTokens.Spacing.lg });
  }

  @Builder
  bottomSummary() {
    Column() {
      this.summaryRow("Subtotal", this.subtotal, false);
      this.summaryRow("Shipping", this.shipping, false);
      this.summaryRow("Tax", this.tax, false);
      this.summaryRow("Total", this.total, true);

      Button('Proceed to Checkout') {
        // Action
      }
      .font-size(ShoppingCartTokens.Typography.title.fontSize)
      .fontWeight(ShoppingCartTokens.Typography.title.fontWeight)
      .fontColor(ShoppingCartTokens.Colors.onPrimary)
      .backgroundColor(ShoppingCartTokens.Colors.primary)
      .borderRadius(ShoppingCartTokens.Shapes.large)
      .width('100%')
      .height(44)
      .margin({ top: ShoppingCartTokens.Spacing.md });
    }
    .width('100%')
    .padding(ShoppingCartTokens.Spacing.lg)
    .backgroundColor(ShoppingCartTokens.Colors.surface)
    .borderRadius(ShoppingCartTokens.Shapes.large)
    .shadow({
      radius: ShoppingCartTokens.Elevation.level3.radius,
      color: `rgba(0, 0, 0, ${ShoppingCartTokens.Elevation.level3.opacity})`,
      offsetX: 0,
      offsetY: ShoppingCartTokens.Elevation.level3.y
    })
    .margin({ left: ShoppingCartTokens.Spacing.lg, right: ShoppingCartTokens.Spacing.lg, bottom: ShoppingCartTokens.Spacing.md });
  }

  @Builder
  summaryRow(title: string, value: number, emphasize: boolean) {
    Row() {
      Text(title)
        .font-size(emphasize ? ShoppingCartTokens.Typography.headline.fontSize : ShoppingCartTokens.Typography.body.fontSize)
        .fontWeight(emphasize ? ShoppingCartTokens.Typography.headline.fontWeight : ShoppingCartTokens.Typography.body.fontWeight)
        .fontColor(ShoppingCartTokens.Colors.onSurface);
      
      Blank().layoutWeight(1);
      
      Text(`$${value.toFixed(2)}`)
        .font-size(emphasize ? ShoppingCartTokens.Typography.headline.fontSize : ShoppingCartTokens.Typography.title.fontSize)
        .fontWeight(emphasize ? ShoppingCartTokens.Typography.headline.fontWeight : ShoppingCartTokens.Typography.title.fontWeight)
        .fontColor(ShoppingCartTokens.Colors.onSurface);
    }
    .width('100%')
    .margin({ bottom: ShoppingCartTokens.Spacing.md });
  }
}