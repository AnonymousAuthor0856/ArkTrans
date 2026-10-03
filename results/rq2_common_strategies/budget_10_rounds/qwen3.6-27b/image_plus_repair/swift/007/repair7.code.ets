import { BusinessError } from '@kit.BasicServicesKit';

// Token definitions matching the SwiftUI source
interface ShadowSpec {
  radius: number;
  y: number;
  opacity: number;
}

interface ColorTokens {
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

interface TypographyStyle {
  fontSize: number;
  fontWeight: FontWeight;
}

interface TypographyTokens {
  display: TypographyStyle;
  headline: TypographyStyle;
  title: TypographyStyle;
  body: TypographyStyle;
  label: TypographyStyle;
}

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

interface SpacingTokens {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface ElevationLevel {
  radius: number;
  y: number;
  opacity: number;
}

interface ElevationTokens {
  level1: ElevationLevel;
  level2: ElevationLevel;
  level3: ElevationLevel;
  level4: ElevationLevel;
  level5: ElevationLevel;
}

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
  } as ColorTokens,

  Typography: {
    display: { fontSize: 22, fontWeight: FontWeight.Bold },
    headline: { fontSize: 18, fontWeight: FontWeight.Bold },
    title: { fontSize: 14, fontWeight: FontWeight.Medium },
    body: { fontSize: 12, fontWeight: FontWeight.Normal },
    label: { fontSize: 10, fontWeight: FontWeight.Medium }
  } as TypographyTokens,

  Shapes: {
    small: 6,
    medium: 8,
    large: 12
  } as ShapeTokens,

  Spacing: {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  } as SpacingTokens,

  Elevation: {
    level1: { radius: 2, y: 0.5, opacity: 0.12 },
    level2: { radius: 4, y: 1, opacity: 0.14 },
    level3: { radius: 6, y: 1.5, opacity: 0.16 },
    level4: { radius: 8, y: 2, opacity: 0.18 },
    level5: { radius: 10, y: 2.5, opacity: 0.2 }
  } as ElevationTokens
};

interface CartItem {
  id: number;
  name: string;
  price: number;
  color: string;
}

interface CartItemWithIndex extends CartItem {
  index: number;
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
            Rect()
              .fill(ShoppingCartTokens.Colors.primary)
              .width(20)
              .height(20)
              .borderRadius(ShoppingCartTokens.Shapes.small);
            
            Text("Shopping Cart")
              .fontSize(ShoppingCartTokens.Typography.display.fontSize)
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
              ForEach(this.getCartItemsWithIndex(), (item: CartItemWithIndex) => {
                this.cartItemCard(item, item.index);
              });
              
              // Chips Row
              Row() {
                ForEach(["Apply Coupon", "Gift Wrap", "Save for Later"], (label: string) => {
                  Button(label)
                    .fontSize(ShoppingCartTokens.Typography.label.fontSize)
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

  private getCartItemsWithIndex(): CartItemWithIndex[] {
    return this.cartItems.map((item, index) => {
      const newItem: CartItemWithIndex = {
        id: item.id,
        name: item.name,
        price: item.price,
        color: item.color,
        index: index
      };
      return newItem;
    });
  }

  @Builder
  cartItemCard(item: CartItem, index: number) {
    Row() {
      // Image Placeholder
      Rect()
        .fill(item.color)
        .width(60)
        .height(60)
        .borderRadius(ShoppingCartTokens.Shapes.medium);

      // Item Details
      Column() {
        Text(item.name)
          .fontSize(ShoppingCartTokens.Typography.title.fontSize)
          .fontWeight(ShoppingCartTokens.Typography.title.fontWeight)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width(120)
          .textAlign(TextAlign.Start);

        Text(`$${item.price.toFixed(2)}`)
          .fontSize(ShoppingCartTokens.Typography.headline.fontSize)
          .fontWeight(ShoppingCartTokens.Typography.headline.fontWeight)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
          .margin({ top: ShoppingCartTokens.Spacing.xs });

        // Feature Boxes
        Row() {
          ForEach([1, 2, 3], () => {
            Rect()
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
        Button('+')
          .onClick(() => {
            if (this.quantities[index] < 10) {
              this.quantities[index]++;
            }
          })
          .fontSize(ShoppingCartTokens.Typography.title.fontSize)
          .fontWeight(ShoppingCartTokens.Typography.title.fontWeight)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
          .backgroundColor(ShoppingCartTokens.Colors.surfaceVariant)
          .borderRadius(ShoppingCartTokens.Shapes.small)
          .width(28)
          .height(28);

        Text(`${this.quantities[index]}`)
          .fontSize(ShoppingCartTokens.Typography.title.fontSize)
          .fontWeight(ShoppingCartTokens.Typography.title.fontWeight)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
          .margin({ top: ShoppingCartTokens.Spacing.sm, bottom: ShoppingCartTokens.Spacing.sm });

        Button('-')
          .onClick(() => {
            if (this.quantities[index] > 1) {
              this.quantities[index]--;
            }
          })
          .fontSize(ShoppingCartTokens.Typography.title.fontSize)
          .fontWeight(ShoppingCartTokens.Typography.title.fontWeight)
          .fontColor(ShoppingCartTokens.Colors.onSurface)
          .backgroundColor(ShoppingCartTokens.Colors.surfaceVariant)
          .borderRadius(ShoppingCartTokens.Shapes.small)
          .width(28)
          .height(28);
      }
      .margin({ left: ShoppingCartTokens.Spacing.lg, right: ShoppingCartTokens.Spacing.lg });

      // Remove Button
      Button('Remove')
        .fontSize(ShoppingCartTokens.Typography.label.fontSize)
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

      Button('Proceed to Checkout')
        .fontSize(ShoppingCartTokens.Typography.title.fontSize)
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
        .fontSize(emphasize ? ShoppingCartTokens.Typography.headline.fontSize : ShoppingCartTokens.Typography.body.fontSize)
        .fontWeight(emphasize ? ShoppingCartTokens.Typography.headline.fontWeight : ShoppingCartTokens.Typography.body.fontWeight)
        .fontColor(ShoppingCartTokens.Colors.onSurface);
      
      Blank().layoutWeight(1);
      
      Text(`$${value.toFixed(2)}`)
        .fontSize(emphasize ? ShoppingCartTokens.Typography.headline.fontSize : ShoppingCartTokens.Typography.title.fontSize)
        .fontWeight(emphasize ? ShoppingCartTokens.Typography.headline.fontWeight : ShoppingCartTokens.Typography.title.fontWeight)
        .fontColor(ShoppingCartTokens.Colors.onSurface);
    }
    .width('100%')
    .margin({ bottom: ShoppingCartTokens.Spacing.md });
  }
}