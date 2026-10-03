class AppTokens {
  static readonly Colors = {
    primary: '#FFFF00E5',
    secondary: '#FF00BFA5',
    tertiary: '#FF69F0AE',
    background: '#FF0A0A0A',
    surface: '#FF121212',
    surfaceVariant: '#FF1E1E1E',
    outline: '#FF2C2C2C',
    success: '#FF00C853',
    warning: '#FFFFD600',
    error: '#FFD50000',
    onPrimary: '#FF0A0A0A',
    onSecondary: '#FF0A0A0A',
    onBackground: '#FFFFFFFF',
    onSurface: '#FFFFFFFF',
  }
  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  }
  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14,
  }
  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28,
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

@Component
struct CartItemCard {
  @Prop name: string
  @Prop price: number

  build() {
    Row() {
      Column({ space: 4 }) {
        Text(this.name)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Text(`$${this.price.toFixed(2)}`)
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.secondary)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Remove')
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 4, color: '#260A0A0A', offsetY: 2 })
  }
}

@Entry
@Component
struct RootScreen {
  private items: CartItem[] = [
    new CartItem(1, 'Neon Keyboard', 89.99),
    new CartItem(2, 'Wireless Mouse', 49.99),
    new CartItem(3, 'Gaming Headset', 109.99),
  ]
  @State promo: string = ''

  private getTotal(): number {
    let sum = 0
    for (let i = 0; i < this.items.length; i++) {
      sum += this.items[i].price
    }
    return sum
  }

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [[AppTokens.Colors.background, 0.0], [AppTokens.Colors.surfaceVariant, 1.0]]
        })

      Scroll() {
        Column({ space: AppTokens.Spacing.md }) {
          Text('Your Cart')
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .fontColor(AppTokens.Colors.primary)
            .width('100%')

          ForEach(this.items, (item: CartItem) => {
            CartItemCard({ name: item.name, price: item.price })
          })

          TextInput({ placeholder: 'Promo Code', text: this.promo })
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .placeholderColor('#80FFFFFF')
            .width('100%')
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .onChange((value: string) => {
              this.promo = value
            })
            .margin({ top: AppTokens.Spacing.md })

          Column({ space: AppTokens.Spacing.sm }) {
            Row() {
              Text('Items:')
                .fontSize(AppTokens.Typography.body.size)
                .fontWeight(AppTokens.Typography.body.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .layoutWeight(1)
              Text(`${this.items.length}`)
                .fontSize(AppTokens.Typography.body.size)
                .fontWeight(AppTokens.Typography.body.weight)
                .fontColor(AppTokens.Colors.primary)
            }
            .width('100%')

            Row() {
              Text('Total:')
                .fontSize(AppTokens.Typography.title.size)
                .fontWeight(AppTokens.Typography.title.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .layoutWeight(1)
              Text(`$${this.getTotal().toFixed(2)}`)
                .fontSize(AppTokens.Typography.title.size)
                .fontWeight(AppTokens.Typography.title.weight)
                .fontColor(AppTokens.Colors.primary)
            }
            .width('100%')
          }
          .width('100%')
          .padding(AppTokens.Spacing.lg)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({ radius: 4, color: '#260A0A0A', offsetY: 2 })
          .margin({ top: AppTokens.Spacing.md })

          Button('Checkout')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .width('100%')
            .height(56)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.large)
            .margin({ top: AppTokens.Spacing.md })
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}