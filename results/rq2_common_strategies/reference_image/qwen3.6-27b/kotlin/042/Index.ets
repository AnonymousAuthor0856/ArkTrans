// entry/src/main/ets/pages/Index.ets

import { router } from '@kit.ArkUI';

// --- Data Models & Tokens ---

interface Product {
  id: number;
  name: string;
  price: string;
  store: string;
}

const AppTokens = {
  Colors: {
    primary: '#0EA5E9',
    secondary: '#38BDF8',
    tertiary: '#7DD3FC',
    background: '#F0F9FF',
    surface: '#FFFFFF',
    surfaceVariant: '#E0F2FE',
    outline: '#BAE6FD',
    success: '#22C55E',
    warning: '#FACC15',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#0F172A',
    onBackground: '#0F172A',
    onSurface: '#0F172A'
  },
  Typography: {
    display: { fontSize: 26, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  },
  Shapes: {
    small: 6,
    medium: 10,
    large: 16
  },
  Spacing: {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28
  }
};

@Entry
@Component
struct RootScreen {
  @State products: Product[] = [
    { id: 1, name: "Wireless Earbuds", price: "$59.99", store: "ShopA" },
    { id: 2, name: "Smart Watch", price: "$129.99", store: "ShopB" },
    { id: 3, name: "Laptop Stand", price: "$39.99", store: "ShopC" },
    { id: 4, name: "Mechanical Keyboard", price: "$89.99", store: "ShopA" },
    { id: 5, name: "Noise Cancel Headset", price: "$149.99", store: "ShopB" },
    { id: 6, name: "Ergo Mouse", price: "$45.99", store: "ShopC" }
  ];

  build() {
    Column() {
      // Header
      Text("Cold Gradient Price Compare")
        .fontStyle(AppTokens.Typography.display)
        .fontColor(AppTokens.Colors.onBackground)
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: AppTokens.Spacing.lg })

      // Product Grid
      GridContainer({ products: this.products })
        .layoutWeight(1)
        .margin({ bottom: AppTokens.Spacing.lg })

      // Price Update Log
      Text("Price Update Log")
        .fontStyle(AppTokens.Typography.title)
        .fontColor(AppTokens.Colors.primary)
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: AppTokens.Spacing.sm })

      List({ space: AppTokens.Spacing.sm }) {
        ForEach(this.products, (product: Product) => {
          ListItem() {
            Row() {
              Text(`${product.name} (${product.store})`)
                .fontStyle(AppTokens.Typography.body)
                .fontColor(AppTokens.Colors.onSurface)
                .layoutWeight(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
              
              Text(product.price)
                .fontStyle(AppTokens.Typography.label)
                .fontColor(AppTokens.Colors.secondary)
            }
            .width('100%')
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.small)
          }
        })
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ bottom: 48 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Transparent)
    .linearGradient({
      angle: 180,
      colors: [
        [AppTokens.Colors.secondary, 0.25],
        [AppTokens.Colors.background, 0.5],
        [AppTokens.Colors.primary, 0.25]
      ]
    })
    .padding(AppTokens.Spacing.lg)
  }
}

@Component
struct GridContainer {
  @Prop products: Product[];

  build() {
    Grid() {
      ForEach(this.products, (product: Product) => {
        GridItem() {
          ProductCard({ product: product })
        }
      })
    }
    .columnsTemplate('1fr 1fr')
    .rowsGap(AppTokens.Spacing.md)
    .columnsGap(AppTokens.Spacing.md)
    .width('100%')
    .layoutWeight(1)
  }
}

@Component
struct ProductCard {
  @Prop product: Product;

  build() {
    Column() {
      // Placeholder Image Box
      Row()
        .width(100)
        .height(100)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)
        .margin({ bottom: AppTokens.Spacing.sm })

      Text(this.product.name)
        .fontStyle(AppTokens.Typography.title)
        .fontColor(AppTokens.Colors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ bottom: AppTokens.Spacing.sm / 2 })

      Text(this.product.price)
        .fontStyle(AppTokens.Typography.body)
        .fontColor(AppTokens.Colors.primary)
        .margin({ bottom: AppTokens.Spacing.sm / 2 })

      Text(this.product.store)
        .fontStyle(AppTokens.Typography.label)
        .fontColor(AppTokens.Colors.tertiary)
        .margin({ bottom: AppTokens.Spacing.sm })

      Button("Compare")
        .type(ButtonType.Capsule)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontStyle(AppTokens.Typography.label)
        .width('100%')
        .height(40)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: 8,
      color: 'rgba(0, 0, 0, 0.1)',
      offsetX: 0,
      offsetY: 4
    })
  }
}