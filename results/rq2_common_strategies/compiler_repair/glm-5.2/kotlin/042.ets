// 056*PriceCompare*en
// UI_TYPE: ECommerce
// STYLE_THEME: Cold Gradient
// LANG: en
// BASELINE_SIZE: 720x1280

interface Product {
  id: number;
  name: string;
  price: string;
  store: string;
}

class AppTokens {
  static Colors = {
    primary: '#FF0EA5E9',
    secondary: '#FF38BDF8',
    tertiary: '#FF7DD3FC',
    background: '#FFF0F9FF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE0F2FE',
    outline: '#FFBAE6FD',
    success: '#FF22C55E',
    warning: '#FFFACC15',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF1E1E1E',
    onTertiary: '#FF0F172A',
    onBackground: '#FF0F172A',
    onSurface: '#FF0F172A'
  };
  static TypographyTokens = {
    display: { fontSize: 26, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };
  static Shapes = {
    small: 6,
    medium: 10,
    large: 16
  };
  static Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28
  };
}

@Entry
@Component
struct RootScreen {
  private products: Product[] = [
    { id: 1, name: 'Wireless Earbuds', price: '$59.99', store: 'ShopA' },
    { id: 2, name: 'Smart Watch', price: '$129.99', store: 'ShopB' },
    { id: 3, name: 'Laptop Stand', price: '$39.99', store: 'ShopC' },
    { id: 4, name: 'Mechanical Keyboard', price: '$89.99', store: 'ShopA' },
    { id: 5, name: 'Noise Cancel Headset', price: '$149.99', store: 'ShopB' },
    { id: 6, name: 'Ergo Mouse', price: '$45.99', store: 'ShopC' }
  ];

  build() {
    Column() {
      Text('Cold Gradient Price Compare')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.onBackground)
        .margin({ bottom: AppTokens.Spacing.lg });

      // Grid Section
      Grid() {
        ForEach(this.products, (p: Product) => {
          GridItem() {
            Column() {
              Column()
                .width(100)
                .height(100)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.medium);

              Text(p.name)
                .fontSize(AppTokens.TypographyTokens.title.fontSize)
                .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ top: AppTokens.Spacing.sm });

              Text(p.price)
                .fontSize(AppTokens.TypographyTokens.body.fontSize)
                .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
                .fontColor(AppTokens.Colors.primary)
                .margin({ top: AppTokens.Spacing.sm });

              Text(p.store)
                .fontSize(AppTokens.TypographyTokens.label.fontSize)
                .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                .fontColor(AppTokens.Colors.tertiary)
                .margin({ top: AppTokens.Spacing.sm });

              Button('Compare')
                .width('100%')
                .backgroundColor(AppTokens.Colors.primary)
                .fontColor(AppTokens.Colors.onPrimary)
                .borderRadius(AppTokens.Shapes.medium)
                .margin({ top: AppTokens.Spacing.md });
            }
            .width('100%')
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 });
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(AppTokens.Spacing.md)
      .rowsGap(AppTokens.Spacing.md)
      .padding({ bottom: AppTokens.Spacing.xxl });

      Text('Price Update Log')
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .fontColor(AppTokens.Colors.primary)
        .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.sm });

      // List Section
      List({ space: AppTokens.Spacing.sm }) {
        ForEach(this.products, (p: Product) => {
          ListItem() {
            Row() {
              Text(`${p.name} (${p.store})`)
                .fontSize(AppTokens.TypographyTokens.body.fontSize)
                .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .layoutWeight(1);

              Text(p.price)
                .fontSize(AppTokens.TypographyTokens.label.fontSize)
                .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                .fontColor(AppTokens.Colors.secondary);
            }
            .width('100%')
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.small);
          }
        })
      }
      .padding({ bottom: 48 })
      .layoutWeight(1);
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .linearGradient({
      angle: 180,
      colors: [
        [AppTokens.Colors.secondary, 0.25],
        [AppTokens.Colors.background, 0.5],
        [AppTokens.Colors.primary, 0.25]
      ]
    });
  }
}