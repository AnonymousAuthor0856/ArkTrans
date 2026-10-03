interface ShadowSpec {
  radius: number
  x: number
  y: number
  opacity: number
}

class AppTokens {
  static Colors = class {
    static readonly primary: string = '#00E5FF'
    static readonly secondary: string = '#00BFA5'
    static readonly tertiary: string = '#69F0AE'
    static readonly background: string = '#0A0A0A'
    static readonly surface: string = '#121212'
    static readonly surfaceVariant: string = '#1E1E1E'
    static readonly outline: string = '#2C2C2C'
    static readonly success: string = '#00C853'
    static readonly warning: string = '#FFD600'
    static readonly error: string = '#D50000'
    static readonly onPrimary: string = '#0A0A0A'
    static readonly onSecondary: string = '#0A0A0A'
    static readonly onBackground: string = '#FFFFFF'
    static readonly onSurface: string = '#FFFFFF'
  }

  static TypographyTokens = class {
    static readonly displaySize: number = 28
    static readonly displayWeight: FontWeight = FontWeight.Bold

    static readonly titleSize: number = 18
    static readonly titleWeight: FontWeight = FontWeight.Medium

    static readonly bodySize: number = 14
    static readonly bodyWeight: FontWeight = FontWeight.Regular

    static readonly labelSize: number = 12
    static readonly labelWeight: FontWeight = FontWeight.Medium
  }

  static Shapes = class {
    static readonly small: number = 6
    static readonly medium: number = 10
    static readonly large: number = 14
  }

  static Spacing = class {
    static readonly sm: number = 6
    static readonly md: number = 10
    static readonly lg: number = 14
    static readonly xl: number = 20
    static readonly xxl: number = 28
  }

  static ElevationMapping = class {
    static readonly level1: ShadowSpec = { radius: 4, x: 0, y: 2, opacity: 0.15 }
    static readonly level2: ShadowSpec = { radius: 8, x: 0, y: 4, opacity: 0.18 }
    static readonly level3: ShadowSpec = { radius: 12, x: 0, y: 6, opacity: 0.2 }
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
  private items: CartItem[] = [
    new CartItem(1, 'Neon Keyboard', 89.99),
    new CartItem(2, 'Wireless Mouse', 49.99),
    new CartItem(3, 'Gaming Headset', 109.99)
  ]

  @State promo: string = ''

  get total(): number {
    return this.items.reduce((sum: number, item: CartItem) => sum + item.price, 0)
  }

  @Builder
  cartItemCard(item: CartItem) {
    Row() {
      Column({ space: 4 }) {
        Text(item.name)
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
          .fontColor(AppTokens.Colors.onSurface)

        Text(`$${item.price.toFixed(2)}`)
          .fontSize(AppTokens.TypographyTokens.bodySize)
          .fontWeight(AppTokens.TypographyTokens.bodyWeight)
          .fontColor(AppTokens.Colors.secondary)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button('Remove')
        .fontSize(AppTokens.TypographyTokens.labelSize)
        .fontWeight(AppTokens.TypographyTokens.labelWeight)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .padding({
          left: AppTokens.Spacing.md,
          right: AppTokens.Spacing.md,
          top: AppTokens.Spacing.sm,
          bottom: AppTokens.Spacing.sm
        })
    }
    .alignItems(VerticalAlign.Center)
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      offsetX: AppTokens.ElevationMapping.level1.x,
      offsetY: AppTokens.ElevationMapping.level1.y,
      color: 'rgba(10, 10, 10, 0.15)'
    })
  }

  build() {
    Stack() {
      Scroll() {
        Column({ space: AppTokens.Spacing.md }) {
          Text('Your Cart')
            .fontSize(AppTokens.TypographyTokens.displaySize)
            .fontWeight(AppTokens.TypographyTokens.displayWeight)
            .fontColor(AppTokens.Colors.primary)
            .width('100%')
            .textAlign(TextAlign.Start)

          ForEach(this.items, (item: CartItem) => {
            this.cartItemCard(item)
          }, (item: CartItem) => item.id.toString())

          Blank()
            .height(AppTokens.Spacing.md)

          Row() {
            TextInput({
              placeholder: 'Promo Code',
              text: this.promo
            })
              .fontSize(AppTokens.TypographyTokens.bodySize)
              .fontWeight(AppTokens.TypographyTokens.bodyWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .placeholderColor('rgba(255, 255, 255, 0.5)')
              .placeholderFont({
                size: AppTokens.TypographyTokens.bodySize,
                weight: AppTokens.TypographyTokens.bodyWeight
              })
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .border({
                width: 1,
                color: AppTokens.Colors.outline
              })
              .padding(AppTokens.Spacing.md)
              .width('100%')
              .onChange((value: string) => {
                this.promo = value
              })
          }
          .width('100%')

          Blank()
            .height(AppTokens.Spacing.md)

          Column({ space: AppTokens.Spacing.sm }) {
            Row() {
              Text('Items:')
                .fontSize(AppTokens.TypographyTokens.bodySize)
                .fontWeight(AppTokens.TypographyTokens.bodyWeight)
                .fontColor(AppTokens.Colors.onSurface)

              Blank()

              Text(`${this.items.length}`)
                .fontSize(AppTokens.TypographyTokens.bodySize)
                .fontWeight(AppTokens.TypographyTokens.bodyWeight)
                .fontColor(AppTokens.Colors.primary)
            }
            .width('100%')

            Row() {
              Text('Total:')
                .fontSize(AppTokens.TypographyTokens.titleSize)
                .fontWeight(AppTokens.TypographyTokens.titleWeight)
                .fontColor(AppTokens.Colors.onSurface)

              Blank()

              Text(`$${this.total.toFixed(2)}`)
                .fontSize(AppTokens.TypographyTokens.titleSize)
                .fontWeight(AppTokens.TypographyTokens.titleWeight)
                .fontColor(AppTokens.Colors.primary)
            }
            .width('100%')
          }
          .width('100%')
          .padding(AppTokens.Spacing.lg)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.ElevationMapping.level1.radius,
            offsetX: AppTokens.ElevationMapping.level1.x,
            offsetY: AppTokens.ElevationMapping.level1.y,
            color: 'rgba(10, 10, 10, 0.15)'
          })

          Button('Checkout')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(AppTokens.Colors.onSecondary)
            .width('100%')
            .height(56)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.large)
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
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