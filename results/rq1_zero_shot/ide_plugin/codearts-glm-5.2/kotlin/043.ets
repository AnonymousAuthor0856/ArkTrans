const NAME = '057*ShoppingCart*en'
const UI_TYPE = 'ECommerce'
const STYLE_THEME = 'Dark Neon'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

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
    onSurface: '#FFFFFF',
  }

  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  }

  static Shapes = {
    small: 6,
    medium: 10,
    large: 14,
  }

  static Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28,
  }

  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.15 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 },
    level3: { elevation: 10, radius: 12, dy: 6, opacity: 0.2 },
  }
}

interface CartItem {
  id: number
  name: string
  price: number
}

@Entry
@Component
struct RootScreen {
  @State promo: string = ''
  private items: CartItem[] = [
    { id: 1, name: 'Neon Keyboard', price: 89.99 },
    { id: 2, name: 'Wireless Mouse', price: 49.99 },
    { id: 3, name: 'Gaming Headset', price: 109.99 },
  ]

  private getTotal(): number {
    let total = 0
    for (const item of this.items) {
      total += item.price
    }
    return total
  }

  build() {
    Column() {
      Text('Your Cart')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.primary)

      List() {
        ForEach(this.items, (item: CartItem) => {
          ListItem() {
            CartItemCard({ item: item })
          }
        }, (item: CartItem) => item.id.toString())
      }
      .width('100%')
      .height(200)
      .margin({ top: AppTokens.Spacing.md })

      TextInput({ text: this.promo, placeholder: 'Promo Code' })
        .width('100%')
        .height(48)
        .borderRadius(AppTokens.Shapes.medium)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .fontColor(AppTokens.Colors.onSurface)
        .fontSize(AppTokens.TypographyTokens.body.fontSize)
        .placeholderColor('#80FFFFFF')
        .margin({ top: AppTokens.Spacing.md })
        .onChange((value: string) => {
          this.promo = value
        })

      Column() {
        Row() {
          Text('Items:')
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Text(`${this.items.length}`)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.primary)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Row() {
          Text('Total:')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Text(`$${this.getTotal().toFixed(2)}`)
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.primary)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: AppTokens.Spacing.sm })
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.large)
      .shadow({ radius: AppTokens.ElevationMapping.level1.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`, offsetY: AppTokens.ElevationMapping.level1.dy })
      .margin({ top: AppTokens.Spacing.md })

      Button('Checkout')
        .type(ButtonType.Normal)
        .width('100%')
        .height(56)
        .borderRadius(AppTokens.Shapes.large)
        .backgroundColor(AppTokens.Colors.secondary)
        .fontColor(AppTokens.Colors.onSecondary)
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .margin({ top: AppTokens.Spacing.md })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .linearGradient({
      angle: 180,
      colors: [[AppTokens.Colors.background, 0.0], [AppTokens.Colors.surfaceVariant, 1.0]]
    })
  }
}

@Component
struct CartItemCard {
  private item: CartItem = { id: 0, name: '', price: 0 }

  build() {
    Row() {
      Column() {
        Text(this.item.name)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)

        Text(`$${this.item.price.toFixed(2)}`)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.secondary)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button('Remove')
        .type(ButtonType.Normal)
        .borderRadius(AppTokens.Shapes.medium)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(AppTokens.TypographyTokens.label.fontSize)
        .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .alignItems(VerticalAlign.Center)
    .shadow({ radius: AppTokens.ElevationMapping.level1.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`, offsetY: AppTokens.ElevationMapping.level1.dy })
  }
}