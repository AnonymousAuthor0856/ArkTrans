// Index.ets
interface CartItem {
  id: number;
  name: string;
  price: number;
  color: ResourceColor;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokens {
  static Colors = {
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

  static TypographyTokens = {
    display: { fontSize: 22, fontWeight: FontWeight.Medium, lineHeight: 28 },
    headline: { fontSize: 18, fontWeight: FontWeight.Medium, lineHeight: 24 },
    title: { fontSize: 14, fontWeight: FontWeight.Medium, lineHeight: 18 },
    body: { fontSize: 12, fontWeight: FontWeight.Normal, lineHeight: 16 },
    label: { fontSize: 10, fontWeight: FontWeight.Medium, lineHeight: 14 }
  };

  static Shapes = {
    small: 6,
    medium: 8,
    large: 12
  };

  static Spacing = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  };

  static ElevationMapping: Record<string, ShadowSpec> = {
    level1: { elevation: 1, radius: 2, dy: 0.5, opacity: 0.12 },
    level2: { elevation: 2, radius: 4, dy: 1, opacity: 0.14 },
    level3: { elevation: 3, radius: 6, dy: 1.5, opacity: 0.16 },
    level4: { elevation: 4, radius: 8, dy: 2, opacity: 0.18 },
    level5: { elevation: 5, radius: 10, dy: 2.5, opacity: 0.20 }
  };
}

@Entry
@Component
struct RootScreen {
  @State quantities: number[] = [1, 1, 1, 1];
  private cartItems: CartItem[] = [
    { id: 1, name: 'Wireless Headphones', price: 129.99, color: AppTokens.Colors.secondary },
    { id: 2, name: 'Smartphone Case', price: 24.99, color: AppTokens.Colors.primary },
    { id: 3, name: 'USB-C Cable', price: 19.99, color: AppTokens.Colors.tertiary },
    { id: 4, name: 'Portable Charger', price: 49.99, color: AppTokens.Colors.secondary }
  ];
  private shipping: number = 5.99;
  private tax: number = 18.50;

  private getSubtotal(): number {
    let sum = 0;
    for (let i = 0; i < this.cartItems.length; i++) {
      sum += this.cartItems[i].price * this.quantities[i];
    }
    return sum;
  }

  private getTotal(): number {
    return this.getSubtotal() + this.shipping + this.tax;
  }

  private formatPrice(value: number): string {
    return `$${value.toFixed(2)}`;
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row() {
          Column()
            .width(20)
            .height(20)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)
            .margin({ right: AppTokens.Spacing.sm });

          Text('Shopping Cart')
            .fontSize(AppTokens.TypographyTokens.display.fontSize)
            .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
            .fontColor(AppTokens.Colors.onSurface);
        }
        .width('100%')
        .height(56)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center);
      }
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface);

      // Content List
      Scroll() {
        Column() {
          ForEach(this.cartItems, (item: CartItem) => {
            Row() {
              Column()
                .width(60)
                .height(60)
                .backgroundColor(item.color)
                .borderRadius(AppTokens.Shapes.medium);

              Column() {
                Text(item.name)
                  .fontSize(AppTokens.TypographyTokens.title.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                  .fontColor(AppTokens.Colors.onSurface);

                Text(this.formatPrice(item.price))
                  .fontSize(AppTokens.TypographyTokens.headline.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .margin({ top: AppTokens.Spacing.xs });

                Row() {
                  Column()
                    .width(28)
                    .height(28)
                    .backgroundColor(AppTokens.Colors.surfaceVariant)
                    .borderRadius(AppTokens.Shapes.small);

                  Column()
                    .width(28)
                    .height(28)
                    .backgroundColor(AppTokens.Colors.surfaceVariant)
                    .borderRadius(AppTokens.Shapes.small)
                    .margin({ left: AppTokens.Spacing.sm });

                  Column()
                    .width(28)
                    .height(28)
                    .backgroundColor(AppTokens.Colors.surfaceVariant)
                    .borderRadius(AppTokens.Shapes.small)
                    .margin({ left: AppTokens.Spacing.sm });
                }
                .margin({ top: AppTokens.Spacing.sm });
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)
              .margin({ left: AppTokens.Spacing.lg });

              Column() {
                Button('+')
                  .fontSize(AppTokens.TypographyTokens.title.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .width(28)
                  .height(28)
                  .padding(0)
                  .backgroundColor(AppTokens.Colors.surfaceVariant)
                  .borderRadius(AppTokens.Shapes.small)
                  .onClick(() => {
                    if (this.quantities[item.id - 1] < 10) {
                      this.quantities[item.id - 1]++;
                    }
                  });

                Text(this.quantities[item.id - 1].toString())
                  .fontSize(AppTokens.TypographyTokens.title.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .margin({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm });

                Button('-')
                  .fontSize(AppTokens.TypographyTokens.title.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .width(28)
                  .height(28)
                  .padding(0)
                  .backgroundColor(AppTokens.Colors.surfaceVariant)
                  .borderRadius(AppTokens.Shapes.small)
                  .onClick(() => {
                    if (this.quantities[item.id - 1] > 1) {
                      this.quantities[item.id - 1]--;
                    }
                  });
              }
              .alignItems(HorizontalAlign.Center)
              .margin({ left: AppTokens.Spacing.lg });

              Button('Remove')
                .fontSize(AppTokens.TypographyTokens.label.fontSize)
                .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                .fontColor(AppTokens.Colors.onPrimary)
                .height(36)
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
                .backgroundColor(AppTokens.Colors.error)
                .borderRadius(AppTokens.Shapes.medium)
                .margin({ left: AppTokens.Spacing.lg });
            }
            .width('100%')
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .shadow({
              radius: AppTokens.ElevationMapping.level2.radius,
              color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
              offsetX: 0,
              offsetY: AppTokens.ElevationMapping.level2.dy
            })
            .margin({ bottom: AppTokens.Spacing.lg });
          });

          // Chips Row
          Row() {
            Button('Apply Coupon')
              .fontSize(AppTokens.TypographyTokens.label.fontSize)
              .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .height(32)
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.small)
              .border({ width: 1, color: AppTokens.Colors.outline });

            Button('Gift Wrap')
              .fontSize(AppTokens.TypographyTokens.label.fontSize)
              .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .height(32)
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.small)
              .border({ width: 1, color: AppTokens.Colors.outline })
              .margin({ left: AppTokens.Spacing.sm });

            Button('Save for Later')
              .fontSize(AppTokens.TypographyTokens.label.fontSize)
              .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .height(32)
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.small)
              .border({ width: 1, color: AppTokens.Colors.outline })
              .margin({ left: AppTokens.Spacing.sm });
          }
          .margin({ bottom: AppTokens.Spacing.xxxl });
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md });
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off);

      // Bottom Bar
      Column() {
        Row() {
          Text('Subtotal')
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.onSurface);
          Text(this.formatPrice(this.getSubtotal()))
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface);
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween);

        Row() {
          Text('Shipping')
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
        .margin({ top: AppTokens.Spacing.md });

        Row() {
          Text('Tax')
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
        .margin({ top: AppTokens.Spacing.md });

        Row() {
          Text('Total')
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
        .margin({ top: AppTokens.Spacing.md });

        Button('Proceed to Checkout')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('100%')
          .height(44)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
          .margin({ top: AppTokens.Spacing.lg });
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: AppTokens.ElevationMapping.level3.radius,
        color: `rgba(0,0,0,${AppTokens.ElevationMapping.level3.opacity})`,
        offsetX: 0,
        offsetY: AppTokens.ElevationMapping.level3.dy
      });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}