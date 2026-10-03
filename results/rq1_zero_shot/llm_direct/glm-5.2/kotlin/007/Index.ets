// 010_ShoppingCart_en.ets
// E-commerce Cart - Minimal Monochrome

class AppTokens {
  static readonly Colors = {
    primary: '#000000',
    secondary: '#FF6F00',
    tertiary: '#4CAF50',
    background: '#FFFFFF',
    surface: '#FFFFFF',
    surfaceVariant: '#F5F5F5',
    outline: '#E0E0E0',
    success: '#4CAF50',
    warning: '#FF9800',
    error: '#F44336',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#000000',
    onSurface: '#000000'
  };
  static readonly TypographyTokens = {
    display: { fontSize: 22, fontWeight: FontWeight.Medium, lineHeight: 28 },
    headline: { fontSize: 18, fontWeight: FontWeight.Medium, lineHeight: 24 },
    title: { fontSize: 14, fontWeight: FontWeight.Medium, lineHeight: 18 },
    body: { fontSize: 12, fontWeight: FontWeight.Normal, lineHeight: 16 },
    label: { fontSize: 10, fontWeight: FontWeight.Medium, lineHeight: 14 }
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
  static readonly ElevationMapping = {
    level1: { elevation: 1, radius: 2, dy: 0.5, opacity: 0.12 },
    level2: { elevation: 2, radius: 4, dy: 1, opacity: 0.14 },
    level3: { elevation: 3, radius: 6, dy: 1.5, opacity: 0.16 },
    level4: { elevation: 4, radius: 8, dy: 2, opacity: 0.18 },
    level5: { elevation: 5, radius: 10, dy: 2.5, opacity: 0.20 }
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
struct RootScreen {
  @State quantities: number[] = [1, 1, 1, 1];
  private cartItems: CartItem[] = [
    { id: 1, name: "Wireless Headphones", price: 129.99, color: AppTokens.Colors.secondary },
    { id: 2, name: "Smartphone Case", price: 24.99, color: AppTokens.Colors.primary },
    { id: 3, name: "USB-C Cable", price: 19.99, color: AppTokens.Colors.tertiary },
    { id: 4, name: "Portable Charger", price: 49.99, color: AppTokens.Colors.secondary }
  ];
  private shipping: number = 5.99;
  private tax: number = 18.50;

  private formatPrice(value: number): string {
    return `$${value.toFixed(2)}`;
  }

  private getSubtotal(): number {
    let sum = 0;
    this.cartItems.forEach((item, index) => {
      sum += item.price * this.quantities[index];
    });
    return sum;
  }

  private getTotal(): number {
    return this.getSubtotal() + this.shipping + this.tax;
  }

  private increment(index: number) {
    if (this.quantities[index] < 10) {
      this.quantities[index] += 1;
    }
  }

  private decrement(index: number) {
    if (this.quantities[index] > 1) {
      this.quantities[index] -= 1;
    }
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row() {
          Box()
            .width(20)
            .height(20)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)
            .margin({ right: AppTokens.Spacing.sm });

          Text("Shopping Cart")
            .fontSize(AppTokens.TypographyTokens.display.fontSize)
            .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
            .fontColor(AppTokens.Colors.onSurface);
        }
        .height(56)
        .justifyContent(FlexAlign.Center)
        .width('100%');
      }
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface);

      // Content List
      Scroll() {
        Column() {
          ForEach(this.cartItems, (item: CartItem, index: number) => {
            Row() {
              Box()
                .width(60)
                .height(60)
                .backgroundColor(item.color)
                .borderRadius(AppTokens.Shapes.medium);

              Column() {
                Text(item.name)
                  .fontSize(AppTokens.TypographyTokens.title.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .margin({ bottom: AppTokens.Spacing.xs });

                Text(this.formatPrice(item.price))
                  .fontSize(AppTokens.TypographyTokens.headline.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .margin({ bottom: AppTokens.Spacing.sm });

                Row() {
                  Box().width(28).height(28).backgroundColor(AppTokens.Colors.surfaceVariant).borderRadius(AppTokens.Shapes.small).margin({ right: AppTokens.Spacing.sm });
                  Box().width(28).height(28).backgroundColor(AppTokens.Colors.surfaceVariant).borderRadius(AppTokens.Shapes.small).margin({ right: AppTokens.Spacing.sm });
                  Box().width(28).height(28).backgroundColor(AppTokens.Colors.surfaceVariant).borderRadius(AppTokens.Shapes.small);
                }
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
              .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg });

              Column() {
                Button("+") {
                  this.increment(index);
                }
                .width(28)
                .height(28)
                .fontSize(AppTokens.TypographyTokens.title.fontSize)
                .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.small)
                .padding(0);

                Text(this.quantities[index].toString())
                  .fontSize(AppTokens.TypographyTokens.title.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .margin({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm });

                Button("-") {
                  this.decrement(index);
                }
                .width(28)
                .height(28)
                .fontSize(AppTokens.TypographyTokens.title.fontSize)
                .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.small)
                .padding(0);
              }
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
              .margin({ right: AppTokens.Spacing.lg });

              Button("Remove") {
                // Handle remove
              }
              .height(36)
              .width(85)
              .fontSize(AppTokens.TypographyTokens.label.fontSize)
              .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
              .fontColor(AppTokens.Colors.onPrimary)
              .backgroundColor(AppTokens.Colors.error)
              .borderRadius(AppTokens.Shapes.medium);
            }
            .width('100%')
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .margin({ bottom: AppTokens.Spacing.lg });
          });

          // Chips Row
          Row() {
            Button("Apply Coupon") {
              // Handle click
            }
            .height(28)
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.small)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .margin({ right: AppTokens.Spacing.sm });

            Button("Gift Wrap") {
              // Handle click
            }
            .height(28)
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.small)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .margin({ right: AppTokens.Spacing.sm });

            Button("Save for Later") {
              // Handle click
            }
            .height(28)
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.small)
            .border({ width: 1, color: AppTokens.Colors.outline });
          }
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.xxxl });
        }
        .padding({ horizontal: AppTokens.Spacing.lg, vertical: AppTokens.Spacing.md });
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background);

      // Bottom Bar
      Column() {
        Row() {
          Text("Subtotal")
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.onSurface);
          Text(this.formatPrice(this.getSubtotal()))
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface);
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ bottom: AppTokens.Spacing.md });

        Row() {
          Text("Shipping")
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.onSurface);
          Text(this.formatPrice(this.shipping))
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface);
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ bottom: AppTokens.Spacing.md });

        Row() {
          Text("Tax")
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.onSurface);
          Text(this.formatPrice(this.tax))
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface);
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ bottom: AppTokens.Spacing.md });

        Row() {
          Text("Total")
            .fontSize(AppTokens.TypographyTokens.headline.fontSize)
            .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
            .fontColor(AppTokens.Colors.onSurface);
          Text(this.formatPrice(this.getTotal()))
            .fontSize(AppTokens.TypographyTokens.headline.fontSize)
            .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
            .fontColor(AppTokens.Colors.onSurface);
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ bottom: AppTokens.Spacing.lg });

        Button("Proceed to Checkout") {
          // Handle checkout
        }
        .width('100%')
        .height(44)
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.large);
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: AppTokens.ElevationMapping.level3.radius,
        color: `rgba(0,0,0,${AppTokens.ElevationMapping.level3.opacity})`,
        offsetY: AppTokens.ElevationMapping.level3.dy
      });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}