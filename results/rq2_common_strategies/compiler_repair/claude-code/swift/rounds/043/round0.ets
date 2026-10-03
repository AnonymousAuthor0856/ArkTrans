// AppTokens design system
class AppColors {
  static readonly primary: string = '#FF00E5FF'
  static readonly secondary: string = '#FF00BFA5'
  static readonly tertiary: string = '#FF69F0AE'
  static readonly background: string = '#FF0A0A0A'
  static readonly surface: string = '#FF121212'
  static readonly surfaceVariant: string = '#FF1E1E1E'
  static readonly outline: string = '#FF2C2C2C'
  static readonly success: string = '#FF00C853'
  static readonly warning: string = '#FFFFD600'
  static readonly error: string = '#FFD50000'
  static readonly onPrimary: string = '#FF0A0A0A'
  static readonly onSecondary: string = '#FF0A0A0A'
  static readonly onBackground: string = '#FFFFFFFF'
  static readonly onSurface: string = '#FFFFFFFF'
}

class AppTypography {
  static readonly displaySize: number = 28
  static readonly displayWeight: FontWeight = FontWeight.Bold
  static readonly titleSize: number = 18
  static readonly titleWeight: FontWeight = FontWeight.Medium
  static readonly bodySize: number = 14
  static readonly bodyWeight: FontWeight = FontWeight.Normal
  static readonly labelSize: number = 12
  static readonly labelWeight: FontWeight = FontWeight.Medium
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

class AppElevation {
  static readonly level1 = { radius: 4, x: 0, y: 2, opacity: 0.15 }
  static readonly level2 = { radius: 8, x: 0, y: 4, opacity: 0.18 }
  static readonly level3 = { radius: 12, x: 0, y: 6, opacity: 0.2 }
}

// CartItem data model
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
    { id: 3, name: 'Gaming Headset', price: 109.99 }
  ]

  get total(): number {
    return this.items.reduce((sum, item) => sum + item.price, 0.0)
  }

  build() {
    Stack() {
      // Background gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          colors: [[AppColors.background, 0.0], [AppColors.surfaceVariant, 1.0]],
          direction: GradientDirection.Bottom
        })

      Scroll() {
        Column({ space: AppSpacing.md }) {
          Text('Your Cart')
            .fontSize(AppTypography.displaySize)
            .fontWeight(AppTypography.displayWeight)
            .fontColor(AppColors.primary)
            .width('100%')
            .textAlign(TextAlign.Start)

          // Cart item list
          ForEach(this.items, (item: CartItem) => {
            this.cartItemCard(item)
          }, (item: CartItem) => item.id.toString())

          Blank()
            .height(AppSpacing.md)

          // Promo code input
          Row() {
            TextInput({ placeholder: 'Promo Code', text: this.promo })
              .fontSize(AppTypography.bodySize)
              .fontWeight(AppTypography.bodyWeight)
              .fontColor(AppColors.onSurface)
              .placeholderColor(AppColors.onSurface)
              .placeholderFont({ size: AppTypography.bodySize, weight: AppTypography.bodyWeight })
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(AppShapes.medium)
              .border({ width: 1, color: AppColors.outline })
              .padding(AppSpacing.md)
          }

          Blank()
            .height(AppSpacing.md)

          // Summary card
          Column({ space: AppSpacing.sm }) {
            Row() {
              Text('Items:')
                .fontSize(AppTypography.bodySize)
                .fontWeight(AppTypography.bodyWeight)
                .fontColor(AppColors.onSurface)
              Blank()
              Text(this.items.length.toString())
                .fontSize(AppTypography.bodySize)
                .fontWeight(AppTypography.bodyWeight)
                .fontColor(AppColors.primary)
            }
            .width('100%')

            Row() {
              Text('Total:')
                .fontSize(AppTypography.titleSize)
                .fontWeight(AppTypography.titleWeight)
                .fontColor(AppColors.onSurface)
              Blank()
              Text('$' + this.total.toFixed(2))
                .fontSize(AppTypography.titleSize)
                .fontWeight(AppTypography.titleWeight)
                .fontColor(AppColors.primary)
            }
            .width('100%')
          }
          .padding(AppSpacing.lg)
          .width('100%')
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.large)
          .shadow({
            radius: AppElevation.level1.radius,
            color: AppColors.background,
            offsetX: AppElevation.level1.x,
            offsetY: AppElevation.level1.y,
            fill: false
          })

          // Checkout button
          Button() {
            Text('Checkout')
              .fontSize(AppTypography.titleSize)
              .fontWeight(AppTypography.titleWeight)
              .fontColor(AppColors.onSecondary)
          }
          .type(ButtonType.Normal)
          .width('100%')
          .height(56)
          .backgroundColor(AppColors.secondary)
          .borderRadius(AppShapes.large)
          .onClick(() => {})
        }
        .padding(AppSpacing.lg)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.None)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  cartItemCard(item: CartItem) {
    Row() {
      Column({ space: 4 }) {
        Text(item.name)
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.onSurface)
        Text('$' + item.price.toFixed(2))
          .fontSize(AppTypography.bodySize)
          .fontWeight(AppTypography.bodyWeight)
          .fontColor(AppColors.secondary)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Text('Remove')
          .fontSize(AppTypography.labelSize)
          .fontWeight(AppTypography.labelWeight)
          .fontColor(AppColors.onPrimary)
      }
      .type(ButtonType.Normal)
      .backgroundColor(AppColors.primary)
      .borderRadius(AppShapes.medium)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .onClick(() => {})
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevation.level1.radius,
      color: AppColors.background,
      offsetX: AppElevation.level1.x,
      offsetY: AppElevation.level1.y,
      fill: false
    })
  }
}
