// AppTokens: Unified UI design system
class AppTokens {
  static Colors: Record<string, string> = {
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
  }

  static TypographyTokens: Record<string, TypographyStyle> = {
    display: { size: 26, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static Shapes: Record<string, number> = {
    small: 6.0,
    medium: 10.0,
    large: 16.0
  }

  static Spacing: Record<string, number> = {
    sm: 6.0,
    md: 10.0,
    lg: 14.0,
    xl: 20.0,
    xxl: 28.0
  }

  static ElevationMapping: Record<string, ShadowSpec> = {
    level1: { elevation: 2.0, radius: 4.0, dy: 2.0, opacity: 0.12 },
    level2: { elevation: 6.0, radius: 8.0, dy: 4.0, opacity: 0.18 }
  }
}

interface TypographyStyle {
  size: number;
  weight: FontWeight;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

// Data Model
interface Product {
  id: number;
  name: string;
  price: string;
  store: string;
}

@Entry
@Component
struct RootScreen {
  private products: Product[] = [
    { id: 1, name: "Wireless Earbuds", price: "$59.99", store: "ShopA" },
    { id: 2, name: "Smart Watch", price: "$129.99", store: "ShopB" },
    { id: 3, name: "Laptop Stand", price: "$39.99", store: "ShopC" },
    { id: 4, name: "Mechanical Keyboard", price: "$89.99", store: "ShopA" },
    { id: 5, name: "Noise Cancel Headset", price: "$149.99", store: "ShopB" },
    { id: 6, name: "Ergo Mouse", price: "$45.99", store: "ShopC" }
  ];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background Gradient
      Column()
        .linearGradient({
          angle: 180,
          colors: [
            [AppTokens.Colors.secondary, 0.0],
            [AppTokens.Colors.background, 0.5],
            [AppTokens.Colors.primary, 1.0]
          ]
        })
        .width('100%')
        .height('100%')
        .position({ x: 0, y: 0 })

      // Scrollable Content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          Text("Cold Gradient Price Compare")
            .fontSize(AppTokens.TypographyTokens.display.size)
            .fontWeight(AppTokens.TypographyTokens.display.weight)
            .fontColor(AppTokens.Colors.onBackground)
            .width('100%')

          // Grid Layout
          Grid() {
            ForEach(this.products, (p: Product) => {
              GridItem() {
                ProductCard({ product: p })
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppTokens.Spacing.md)
          .rowsGap(AppTokens.Spacing.md)
          .padding({ bottom: AppTokens.Spacing.xxl })
          .width('100%')

          Text("Price Update Log")
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.primary)
            .width('100%')

          // List Layout
          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(this.products, (p: Product) => {
              PriceUpdateLogItem({ product: p })
            })
          }
          .width('100%')
          .padding({ bottom: 48 })
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// ProductCard Component
@Component
struct ProductCard {
  private product: Product = { id: 0, name: "", price: "", store: "" };

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // Placeholder Box
      Column()
        .width(100)
        .height(100)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.product.name)
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(this.product.price)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.primary)

      Text(this.product.store)
        .fontSize(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .fontColor(AppTokens.Colors.tertiary)

      // Button
      Button("Compare")
        .fontSize(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .width('100%')
        .height(36)
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
    .alignItems(HorizontalAlign.Center)
  }
}

// PriceUpdateLogItem Component
@Component
struct PriceUpdateLogItem {
  private product: Product = { id: 0, name: "", price: "", store: "" };

  build() {
    Row() {
      Text(`${this.product.name} (${this.product.store})`)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .layoutWeight(1)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(this.product.price)
        .fontSize(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .fontColor(AppTokens.Colors.secondary)
        .margin({ left: AppTokens.Spacing.sm })
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.small)
    .width('100%')
  }
}