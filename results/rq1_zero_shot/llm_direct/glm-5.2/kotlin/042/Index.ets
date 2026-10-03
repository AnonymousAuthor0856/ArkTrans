// Build configuration. Do not modify this section.
// {
//   "apiType": "stageMode",
//   "buildOption": {},
//   "targets": [
//     { "name": "default" }
//   ]
// }

import { Length, ResourceStr } from '@ohos.arkui.UI';

const NAME = "056*PriceCompare*en";
const UI_TYPE = "ECommerce";
const STYLE_THEME = "Cold Gradient";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

class AppTokens {
  static readonly Colors = {
    primary: "#0EA5E9",
    secondary: "#38BDF8",
    tertiary: "#7DD3FC",
    background: "#F0F9FF",
    surface: "#FFFFFF",
    surfaceVariant: "#E0F2FE",
    outline: "#BAE6FD",
    success: "#22C55E",
    warning: "#FACC15",
    error: "#EF4444",
    onPrimary: "#FFFFFF",
    onSecondary: "#1E1E1E",
    onTertiary: "#0F172A",
    onBackground: "#0F172A",
    onSurface: "#0F172A",
  };
  static readonly TypographyTokens = {
    display: { fontSize: 26, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  };
  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 16,
  };
  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28,
  };
  static readonly ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 },
  };
}

class Product {
  id: number;
  name: string;
  price: string;
  store: string;

  constructor(id: number, name: string, price: string, store: string) {
    this.id = id;
    this.name = name;
    this.price = price;
    this.store = store;
  }
}

@Entry
@Component
struct RootScreen {
  private products: Product[] = [
    new Product(1, "Wireless Earbuds", "$59.99", "ShopA"),
    new Product(2, "Smart Watch", "$129.99", "ShopB"),
    new Product(3, "Laptop Stand", "$39.99", "ShopC"),
    new Product(4, "Mechanical Keyboard", "$89.99", "ShopA"),
    new Product(5, "Noise Cancel Headset", "$149.99", "ShopB"),
    new Product(6, "Ergo Mouse", "$45.99", "ShopC"),
  ];

  build() {
    Column() {
      // Header
      Text("Cold Gradient Price Compare")
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.onBackground)
        .margin({ bottom: AppTokens.Spacing.lg });

      // Grid Section
      Grid() {
        ForEach(this.products, (p: Product) => {
          GridItem() {
            Column() {
              Column() {
                // Image Placeholder
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

                Button("Compare")
                  .width("100%")
                  .height(36)
                  .backgroundColor(AppTokens.Colors.primary)
                  .fontColor(AppTokens.Colors.onPrimary)
                  .borderRadius(AppTokens.Shapes.medium)
                  .margin({ top: AppTokens.Spacing.sm });
              }
              .width("100%")
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.large)
              .shadow({
                radius: AppTokens.ElevationMapping.level1.radius,
                color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1.opacity})`,
                offsetX: 0,
                offsetY: AppTokens.ElevationMapping.level1.dy
              });
            }
          }
        });
      }
      .columnsTemplate("1fr 1fr")
      .columnsGap(AppTokens.Spacing.md)
      .rowsGap(AppTokens.Spacing.md)
      .padding({ bottom: AppTokens.Spacing.xxl })
      .margin({ bottom: AppTokens.Spacing.lg });

      // Log Section Title
      Text("Price Update Log")
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .fontColor(AppTokens.Colors.primary)
        .margin({ bottom: AppTokens.Spacing.lg });

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
            .width("100%")
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.small);
          }
        });
      }
      .padding({ bottom: 48 })
      .layoutWeight(1);
    }
    .width("100%")
    .height("100%")
    .padding(AppTokens.Spacing.lg)
    .linearGradient({
      angle: 180,
      colors: [
        [AppTokens.Colors.secondary, 0.0],
        [AppTokens.Colors.background, 0.5],
        [AppTokens.Colors.primary, 1.0]
      ]
    });
  }
}