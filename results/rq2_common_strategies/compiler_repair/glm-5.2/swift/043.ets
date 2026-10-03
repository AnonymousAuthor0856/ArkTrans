// AppTokens.ets

export class Colors {
  primary: string = '#FF00E5FF';
  secondary: string = '#FF00BFA5';
  tertiary: string = '#FF69F0AE';
  background: string = '#FF0A0A0A';
  surface: string = '#FF121212';
  surfaceVariant: string = '#FF1E1E1E';
  outline: string = '#FF2C2C2C';
  success: string = '#FF00C853';
  warning: string = '#FFFFD600';
  error: string = '#FFD50000';
  onPrimary: string = '#FF0A0A0A';
  onSecondary: string = '#FF0A0A0A';
  onBackground: string = '#FFFFFFFF';
  onSurface: string = '#FFFFFFFF';
}

export interface FontConfig {
  size: number;
  weight: FontWeight;
}

export class TypographyTokens {
  display: FontConfig = { size: 28, weight: FontWeight.Bold };
  title: FontConfig = { size: 18, weight: FontWeight.Medium };
  body: FontConfig = { size: 14, weight: FontWeight.Regular };
  label: FontConfig = { size: 12, weight: FontWeight.Medium };
}

export class Shapes {
  small: number = 6;
  medium: number = 10;
  large: number = 14;
}

export class Spacing {
  sm: number = 6;
  md: number = 10;
  lg: number = 14;
  xl: number = 20;
  xxl: number = 28;
}

export class ShadowSpec {
  radius: number;
  x: number;
  y: number;
  opacity: number;

  constructor(radius: number, x: number, y: number, opacity: number) {
    this.radius = radius;
    this.x = x;
    this.y = y;
    this.opacity = opacity;
  }
}

export class ElevationMapping {
  level1: ShadowSpec = new ShadowSpec(4, 0, 2, 0.15);
  level2: ShadowSpec = new ShadowSpec(8, 0, 4, 0.18);
  level3: ShadowSpec = new ShadowSpec(12, 0, 6, 0.2);
}

export class AppTokens {
  static Colors: Colors = new Colors();
  static TypographyTokens: TypographyTokens = new TypographyTokens();
  static Shapes: Shapes = new Shapes();
  static Spacing: Spacing = new Spacing();
  static ElevationMapping: ElevationMapping = new ElevationMapping();
}

// CartItem Model
export class CartItem {
  id: number;
  name: string;
  price: number;

  constructor(id: number, name: string, price: number) {
    this.id = id;
    this.name = name;
    this.price = price;
  }
}

// RootScreen.ets
@Entry
@Component
struct RootScreen {
  private items: Array<CartItem> = [
    new CartItem(1, "Neon Keyboard", 89.99),
    new CartItem(2, "Wireless Mouse", 49.99),
    new CartItem(3, "Gaming Headset", 109.99)
  ];

  @State private promo: string = "";

  private get total(): number {
    return this.items.reduce((sum: number, item: CartItem) => sum + item.price, 0.0);
  }

  build() {
    Stack() {
      // Background Gradient
      Column() {
        // In ArkUI, a linear gradient is typically applied to a container
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 180,
        colors: [[AppTokens.Colors.background, 0.0], [AppTokens.Colors.surfaceVariant, 1.0]]
      })

      // Scrollable Content
      Scroll() {
        Column({ space: AppTokens.Spacing.md }) {
          Text("Your Cart")
            .fontSize(AppTokens.TypographyTokens.display.size)
            .fontWeight(AppTokens.TypographyTokens.display.weight)
            .fontColor(AppTokens.Colors.primary)
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ bottom: AppTokens.Spacing.md })

          // Cart Items List
          ForEach(this.items, (item: CartItem) => {
            this.cartItemCard(item)
          })

          Blank().height(AppTokens.Spacing.md)

          // Promo Code Input
          TextInput({ text: this.promo, placeholder: "Promo Code" })
            .onChange((value: string) => {
              this.promo = value;
            })
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontColor(AppTokens.Colors.onSurface)
            .placeholderColor(AppTokens.Colors.onSurface)
            .placeholderFont({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .padding(AppTokens.Spacing.md)
            .height(50)

          Blank().height(AppTokens.Spacing.md)

          // Summary Card
          Column({ space: AppTokens.Spacing.sm }) {
            Row() {
              Text("Items:")
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontColor(AppTokens.Colors.onSurface)
              Blank()
              Text(`${this.items.length}`)
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontColor(AppTokens.Colors.primary)
            }
            .width('100%')

            Row() {
              Text("Total:")
                .fontSize(AppTokens.TypographyTokens.title.size)
                .fontWeight(AppTokens.TypographyTokens.title.weight)
                .fontColor(AppTokens.Colors.onSurface)
              Blank()
              Text(`$${this.total.toFixed(2)}`)
                .fontSize(AppTokens.TypographyTokens.title.size)
                .fontWeight(AppTokens.TypographyTokens.title.weight)
                .fontColor(AppTokens.Colors.primary)
            }
            .width('100%')
          }
          .padding(AppTokens.Spacing.lg)
          .width('100%')
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.ElevationMapping.level1.radius,
            color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1.opacity})`,
            offsetX: AppTokens.ElevationMapping.level1.x,
            offsetY: AppTokens.ElevationMapping.level1.y
          })

          // Checkout Button
          Button() {
            Text("Checkout")
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(AppTokens.TypographyTokens.title.weight)
              .fontColor(AppTokens.Colors.onSecondary)
          }
          .width('100%')
          .height(56)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.large)
          .margin({ top: AppTokens.Spacing.lg })
        }
        .padding(AppTokens.Spacing.lg)
      }
      .scrollBar(BarState.Off)
      .align(Alignment.Top)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  cartItemCard(item: CartItem) {
    Row() {
      Column({ space: 4 }) {
        Text(item.name)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
        Text(`$${item.price.toFixed(2)}`)
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontColor(AppTokens.Colors.secondary)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Text("Remove")
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.onPrimary)
      }
      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Shapes.medium)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1.opacity})`,
      offsetX: AppTokens.ElevationMapping.level1.x,
      offsetY: AppTokens.ElevationMapping.level1.y
    })
  }
}