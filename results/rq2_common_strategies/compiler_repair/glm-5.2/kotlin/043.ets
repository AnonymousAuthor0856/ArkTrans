// Index.ets
const NAME: string = "057*ShoppingCart*en";
const UI_TYPE: string = "ECommerce";
const STYLE_THEME: string = "Dark Neon";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

class AppColors {
  primary: ResourceColor = 0xFF00E5FF;
  secondary: ResourceColor = 0xFF00BFA5;
  tertiary: ResourceColor = 0xFF69F0AE;
  background: ResourceColor = 0xFF0A0A0A;
  surface: ResourceColor = 0xFF121212;
  surfaceVariant: ResourceColor = 0xFF1E1E1E;
  outline: ResourceColor = 0xFF2C2C2C;
  success: ResourceColor = 0xFF00C853;
  warning: ResourceColor = 0xFFFFD600;
  error: ResourceColor = 0xFFD50000;
  onPrimary: ResourceColor = 0xFF0A0A0A;
  onSecondary: ResourceColor = 0xFF0A0A0A;
  onBackground: ResourceColor = 0xFFFFFFFF;
  onSurface: ResourceColor = 0xFFFFFFFF;
}

class AppTypography {
  display: TextStyle = new TextStyle({ fontSize: 28, fontWeight: FontWeight.Bold });
  title: TextStyle = new TextStyle({ fontSize: 18, fontWeight: FontWeight.Medium });
  body: TextStyle = new TextStyle({ fontSize: 14, fontWeight: FontWeight.Normal });
  label: TextStyle = new TextStyle({ fontSize: 12, fontWeight: FontWeight.Medium });
}

class AppShapes {
  small: number = 6;
  medium: number = 10;
  large: number = 14;
}

class AppSpacing {
  sm: Length = 6;
  md: Length = 10;
  lg: Length = 14;
  xl: Length = 20;
  xxl: Length = 28;
}

class AppTokens {
  static Colors: AppColors = new AppColors();
  static TypographyTokens: AppTypography = new AppTypography();
  static Shapes: AppShapes = new AppShapes();
  static Spacing: AppSpacing = new AppSpacing();
}

class CartItem {
  id: number;
  name: string;
  price: number;

  constructor(id: number, name: string, price: number) {
    this.id = id;
    this.name = name;
    this.price = price;
  }
}

@Entry
@Component
struct RootScreen {
  @State promo: string = "";
  private items: CartItem[] = [
    new CartItem(1, "Neon Keyboard", 89.99),
    new CartItem(2, "Wireless Mouse", 49.99),
    new CartItem(3, "Gaming Headset", 109.99)
  ];

  private getTotal(): number {
    let sum: number = 0;
    for (let item of this.items) {
      sum += item.price;
    }
    return sum;
  }

  build() {
    Column() {
      Column() {
        Text("Your Cart")
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.primary)
          .margin({ bottom: AppTokens.Spacing.md })

        ForEach(this.items, (item: CartItem) => {
          Row() {
            Column() {
              Text(item.name)
                .fontSize(AppTokens.TypographyTokens.title.fontSize)
                .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)
              Text(`$${item.price.toFixed(2)}`)
                .fontSize(AppTokens.TypographyTokens.body.fontSize)
                .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
                .fontColor(AppTokens.Colors.secondary)
                .margin({ top: AppTokens.Spacing.sm })
            }
            .alignItems(HorizontalAlign.Start)

            Button("Remove")
              .fontSize(AppTokens.TypographyTokens.label.fontSize)
              .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
              .fontColor(AppTokens.Colors.onPrimary)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.medium)
              .height(36)
          }
          .width('100%')
          .padding(AppTokens.Spacing.md)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .margin({ bottom: AppTokens.Spacing.md })
        })

        TextInput({ text: this.promo, placeholder: "Promo Code" })
          .width('100%')
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)
          .fontColor(AppTokens.Colors.onSurface)
          .placeholderColor(Color.Gray)
          .onChange((value: string) => {
            this.promo = value;
          })
          .margin({ bottom: AppTokens.Spacing.md })

        Column() {
          Row() {
            Text("Items:")
              .fontSize(AppTokens.TypographyTokens.body.fontSize)
              .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
            Text(`${this.items.length}`)
              .fontSize(AppTokens.TypographyTokens.body.fontSize)
              .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
              .fontColor(AppTokens.Colors.primary)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({ bottom: AppTokens.Spacing.sm })

          Row() {
            Text("Total:")
              .fontSize(AppTokens.TypographyTokens.title.fontSize)
              .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
            Text(`$${this.getTotal().toFixed(2)}`)
              .fontSize(AppTokens.TypographyTokens.title.fontSize)
              .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
              .fontColor(AppTokens.Colors.primary)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.large)
        .margin({ bottom: AppTokens.Spacing.md })

        Button("Checkout")
          .width('100%')
          .height(56)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSecondary)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.large)
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [[AppTokens.Colors.background, 0.0], [AppTokens.Colors.surfaceVariant, 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}