class AppColors {
  static readonly primary: ResourceColor = '#00E5FF'
  static readonly secondary: ResourceColor = '#00BFA5'
  static readonly tertiary: ResourceColor = '#69F0AE'
  static readonly background: ResourceColor = '#0A0A0A'
  static readonly surface: ResourceColor = '#121212'
  static readonly surfaceVariant: ResourceColor = '#1E1E1E'
  static readonly outline: ResourceColor = '#2C2C2C'
  static readonly success: ResourceColor = '#00C853'
  static readonly warning: ResourceColor = '#FFD600'
  static readonly error: ResourceColor = '#D50000'
  static readonly onPrimary: ResourceColor = '#0A0A0A'
  static readonly onSecondary: ResourceColor = '#0A0A0A'
  static readonly onBackground: ResourceColor = '#FFFFFF'
  static readonly onSurface: ResourceColor = '#FFFFFF'
}

class AppTypography {
  static readonly displaySize: number = 28
  static readonly titleSize: number = 18
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 14
}

class AppSpacing {
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 14
  static readonly xl: number = 20
  static readonly xxl: number = 28
}

class ShadowSpec {
  radius: number
  x: number
  y: number
  opacity: number

  constructor(radius: number, x: number, y: number, opacity: number) {
    this.radius = radius
    this.x = x
    this.y = y
    this.opacity = opacity
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(4, 0, 2, 0.15)
  static readonly level2: ShadowSpec = new ShadowSpec(8, 0, 4, 0.18)
  static readonly level3: ShadowSpec = new ShadowSpec(12, 0, 6, 0.2)
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
  @State private promo: string = ''

  private items: CartItem[] = [
    new CartItem(1, 'Neon Keyboard', 89.99),
    new CartItem(2, 'Wireless Mouse', 49.99),
    new CartItem(3, 'Gaming Headset', 109.99)
  ]

  private total(): number {
    let sum: number = 0
    this.items.forEach((item: CartItem) => {
      sum += item.price
    })
    return sum
  }

  @Builder
  private CartItemCard(item: CartItem) {
    Row() {
      Column({ space: 4 }) {
        Text(item.name)
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(`$${item.price.toFixed(2)}`)
          .fontSize(AppTypography.bodySize)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.secondary)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Remove', { type: ButtonType.Normal })
        .fontSize(AppTypography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .padding({
          left: AppSpacing.md,
          right: AppSpacing.md,
          top: AppSpacing.sm,
          bottom: AppSpacing.sm
        })
        .onClick(() => {
        })
    }
    .width('100%')
    .padding(AppSpacing.md)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevation.level1.radius,
      offsetX: AppElevation.level1.x,
      offsetY: AppElevation.level1.y,
      color: 'rgba(0, 0, 0, 0.35)'
    })
  }

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [
            [AppColors.background, 0.0],
            [AppColors.surfaceVariant, 1.0]
          ]
        })

      Scroll() {
        Column({ space: AppSpacing.md }) {
          Text('Your Cart')
            .width('100%')
            .fontSize(AppTypography.displaySize)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.primary)
            .textAlign(TextAlign.Start)

          ForEach(this.items, (item: CartItem) => {
            this.CartItemCard(item)
          }, (item: CartItem) => item.id.toString())

          Blank()
            .height(AppSpacing.md)

          Row() {
            TextInput({
              placeholder: 'Promo Code',
              text: this.promo
            })
              .width('100%')
              .height(56)
              .fontSize(AppTypography.bodySize)
              .fontWeight(FontWeight.Regular)
              .fontColor(AppColors.onSurface)
              .placeholderColor('rgba(255, 255, 255, 0.5)')
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(AppShapes.medium)
              .border({
                width: 1,
                color: AppColors.outline,
                radius: AppShapes.medium
              })
              .padding({
                left: AppSpacing.md,
                right: AppSpacing.md
              })
              .onChange((value: string) => {
                this.promo = value
              })
          }
          .width('100%')

          Blank()
            .height(AppSpacing.md)

          Column({ space: AppSpacing.sm }) {
            Row() {
              Text('Items:')
                .fontSize(AppTypography.bodySize)
                .fontWeight(FontWeight.Regular)
                .fontColor(AppColors.onSurface)

              Blank()

              Text(`${this.items.length}`)
                .fontSize(AppTypography.bodySize)
                .fontWeight(FontWeight.Regular)
                .fontColor(AppColors.primary)
            }
            .width('100%')

            Row() {
              Text('Total:')
                .fontSize(AppTypography.titleSize)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)

              Blank()

              Text(`$${this.total().toFixed(2)}`)
                .fontSize(AppTypography.titleSize)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.primary)
            }
            .width('100%')
          }
          .width('100%')
          .padding(AppSpacing.lg)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.large)
          .shadow({
            radius: AppElevation.level1.radius,
            offsetX: AppElevation.level1.x,
            offsetY: AppElevation.level1.y,
            color: 'rgba(0, 0, 0, 0.35)'
          })

          Button('Checkout', { type: ButtonType.Normal })
            .width('100%')
            .height(56)
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(AppShapes.large)
            .onClick(() => {
            })
        }
        .width('100%')
        .padding(AppSpacing.lg)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}