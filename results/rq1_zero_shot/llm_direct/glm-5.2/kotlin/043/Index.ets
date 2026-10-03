// Build configuration: compileSdkVersion 12, compatibleSdkVersion 10, target runtime: HarmonyOS NEXT
// Dependencies: ArkUI (ArkTS declarative UI)

const NAME = "057*ShoppingCart*en";
const UI_TYPE = "ECommerce";
const STYLE_THEME = "Dark Neon";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

class AppTokens {
  static Colors = {
    primary: '#00E5FF',
    secondary: '#00BFA5',
    tertiary: '#69F0AE',
    background: '#0A0A0A',
    surface: '#121212',
    surfaceVariant: '#1E1E1E',
    outline: '#2C2C2C',
    success: '#00C853',
    warning: '#FFD600',
    error: '#D50000',
    onPrimary: '#0A0A0A',
    onSecondary: '#0A0A0A',
    onBackground: '#FFFFFF',
    onSurface: '#FFFFFF'
  };
  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };
  static Shapes = {
    small: 6,
    medium: 10,
    large: 14
  };
  static Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28
  };
  static ElevationMapping = {
    level1: 2,
    level2: 6,
    level3: 10
  };
}

interface CartItem {
  id: number;
  name: string;
  price: number;
}

@Entry
@Component
struct RootScreen {
  private items: CartItem[] = [
    { id: 1, name: "Neon Keyboard", price: 89.99 },
    { id: 2, name: "Wireless Mouse", price: 49.99 },
    { id: 3, name: "Gaming Headset", price: 109.99 }
  ];
  @State promo: string = '';

  private get total(): number {
    return this.items.reduce((sum, item) => sum + item.price, 0);
  }

  build() {
    Column() {
      Column() {
        Text('Your Cart')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.primary)
          .margin({ bottom: AppTokens.Spacing.md })

        ForEach(this.items, (item: CartItem) => {
          Column() {
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

              Button('Remove') {
                Text('Remove')
                  .fontSize(AppTokens.TypographyTokens.label.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                  .fontColor(AppTokens.Colors.onPrimary)
              }
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.medium)
              .height(36)
              .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .padding(AppTokens.Spacing.md)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({ radius: AppTokens.ElevationMapping.level1, color: 'rgba(0,0,0,0.15)', offsetY: 2 })
          .margin({ bottom: AppTokens.Spacing.md })
        }, (item: CartItem) => item.id.toString())

        TextInput({ text: this.promo, placeholder: 'Promo Code' })
          .width('100%')
          .height(50)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)
          .fontColor(AppTokens.Colors.onSurface)
          .placeholderColor('rgba(255,255,255,0.5)')
          .onChange((value: string) => {
            this.promo = value;
          })
          .margin({ bottom: AppTokens.Spacing.md })

        Column() {
          Row() {
            Text('Items:')
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

          Row() {
            Text('Total:')
              .fontSize(AppTokens.TypographyTokens.title.fontSize)
              .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
            Text(`$${this.total.toFixed(2)}`)
              .fontSize(AppTokens.TypographyTokens.title.fontSize)
              .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
              .fontColor(AppTokens.Colors.primary)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({ top: AppTokens.Spacing.sm })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({ radius: AppTokens.ElevationMapping.level1, color: 'rgba(0,0,0,0.15)', offsetY: 2 })
        .margin({ bottom: AppTokens.Spacing.md })

        Button('Checkout') {
          Text('Checkout')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSecondary)
        }
        .width('100%')
        .height(56)
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