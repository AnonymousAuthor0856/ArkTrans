const NAME: string = '057*ShoppingCart*en'
const UI_TYPE: string = 'ECommerce'
const STYLE_THEME: string = 'Dark Neon'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

interface TextToken {
  fontSize: number
  fontWeight: FontWeight
}

interface ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number
}

class AppTokens {
  static readonly Colors = {
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
    onSurfaceHalf: '#80FFFFFF'
  }

  static readonly TypographyTokens: Record<string, TextToken> = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  }

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14
  }

  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28
  }

  static readonly ElevationMapping: Record<string, ShadowSpec> = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.15 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 },
    level3: { elevation: 10, radius: 12, dy: 6, opacity: 0.2 }
  }
}

class CartItem {
  id: number
  name: string
  price: number

  constructor(id: number, name: string, price: number) {
    this.id = id
    this.name = name
    this.price = price
  }
}

@Entry
@Component
struct RootScreen {
  @State promo: string = ''
  @State promoFocused: boolean = false

  private items: CartItem[] = [
    new CartItem(1, 'Neon Keyboard', 89.99),
    new CartItem(2, 'Wireless Mouse', 49.99),
    new CartItem(3, 'Gaming Headset', 109.99)
  ]

  private totalPrice(): number {
    return this.items.reduce((sum: number, item: CartItem) => sum + item.price, 0)
  }

  private formatPrice(price: number): string {
    return '$' + price.toFixed(2)
  }

  @Builder
  private AppText(
    value: string,
    token: TextToken,
    color: ResourceColor
  ) {
    Text(value)
      .fontSize(token.fontSize)
      .fontWeight(token.fontWeight)
      .fontColor(color)
  }

  @Builder
  private CartItemCard(item: CartItem) {
    Column() {
      Row() {
        Column({ space: AppTokens.Spacing.sm }) {
          this.AppText(item.name, AppTokens.TypographyTokens.title, AppTokens.Colors.onSurface)
          this.AppText(this.formatPrice(item.price), AppTokens.TypographyTokens.body, AppTokens.Colors.secondary)
        }
        .alignItems(HorizontalAlign.Start)

        Button() {
          this.AppText('Remove', AppTokens.TypographyTokens.label, AppTokens.Colors.onPrimary)
        }
        .type(ButtonType.Normal)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .padding({
          left: AppTokens.Spacing.md,
          right: AppTokens.Spacing.md,
          top: AppTokens.Spacing.sm,
          bottom: AppTokens.Spacing.sm
        })
        .onClick((): void => {
        })
      }
      .width('100%')
      .padding(AppTokens.Spacing.md)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: 'rgba(0, 0, 0, 0.15)',
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
  }

  @Builder
  private PromoField() {
    TextInput({
      placeholder: 'Promo Code',
      text: this.promo
    })
      .width('100%')
      .height(52)
      .fontSize(AppTokens.TypographyTokens.body.fontSize)
      .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
      .fontColor(AppTokens.Colors.onSurface)
      .placeholderColor(AppTokens.Colors.onSurfaceHalf)
      .placeholderFont({
        size: AppTokens.TypographyTokens.body.fontSize,
        weight: AppTokens.TypographyTokens.body.fontWeight
      })
      .caretColor(AppTokens.Colors.primary)
      .backgroundColor(this.promoFocused ? AppTokens.Colors.surface : AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.medium)
      .border({
        width: 1,
        color: this.promoFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline
      })
      .padding({
        left: AppTokens.Spacing.md,
        right: AppTokens.Spacing.md
      })
      .onChange((value: string): void => {
        this.promo = value
      })
      .onFocus((): void => {
        this.promoFocused = true
      })
      .onBlur((): void => {
        this.promoFocused = false
      })
  }

  @Builder
  private SummaryCard() {
    Column() {
      Column({ space: AppTokens.Spacing.sm }) {
        Row() {
          this.AppText('Items:', AppTokens.TypographyTokens.body, AppTokens.Colors.onSurface)
          this.AppText(this.items.length.toString(), AppTokens.TypographyTokens.body, AppTokens.Colors.primary)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Row() {
          this.AppText('Total:', AppTokens.TypographyTokens.title, AppTokens.Colors.onSurface)
          this.AppText(this.formatPrice(this.totalPrice()), AppTokens.TypographyTokens.title, AppTokens.Colors.primary)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: 'rgba(0, 0, 0, 0.15)',
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
  }

  @Builder
  private CheckoutButton() {
    Button() {
      this.AppText('Checkout', AppTokens.TypographyTokens.title, AppTokens.Colors.onSecondary)
    }
    .width('100%')
    .height(56)
    .type(ButtonType.Normal)
    .backgroundColor(AppTokens.Colors.secondary)
    .borderRadius(AppTokens.Shapes.large)
    .onClick((): void => {
    })
  }

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      this.AppText('Your Cart', AppTokens.TypographyTokens.display, AppTokens.Colors.primary)

      ForEach(this.items, (item: CartItem) => {
        this.CartItemCard(item)
      }, (item: CartItem): string => item.id.toString())

      Blank()
        .height(AppTokens.Spacing.md)

      this.PromoField()

      Blank()
        .height(AppTokens.Spacing.md)

      this.SummaryCard()

      this.CheckoutButton()
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppTokens.Colors.background)
    .linearGradient({
      angle: 180,
      colors: [
        [AppTokens.Colors.background, 0.0],
        [AppTokens.Colors.surfaceVariant, 1.0]
      ]
    })
  }
}