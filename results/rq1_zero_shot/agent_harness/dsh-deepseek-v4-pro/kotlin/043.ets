const Colors = {
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
}

const Shapes = {
  small: 6,
  medium: 10,
  large: 14
}

const Spacing = {
  sm: 6,
  md: 10,
  lg: 14,
  xl: 20,
  xxl: 28
}

interface CartItem {
  id: number
  name: string
  price: number
}

@Entry
@Component
struct Index {
  @State items: CartItem[] = [
    { id: 1, name: 'Neon Keyboard', price: 89.99 },
    { id: 2, name: 'Wireless Mouse', price: 49.99 },
    { id: 3, name: 'Gaming Headset', price: 109.99 }
  ]
  @State promo: string = ''

  build() {
    Scroll() {
      Column({ space: Spacing.md }) {
        Text('Your Cart')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.primary)

        ForEach(this.items, (it: CartItem) => {
          Row() {
            Column() {
              Text(it.name)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
              Text('$' + it.price.toFixed(2))
                .fontSize(14)
                .fontColor(Colors.secondary)
            }
            Button('Remove', { type: ButtonType.Normal })
              .borderRadius(Shapes.medium)
              .backgroundColor(Colors.primary)
              .fontColor(Colors.onPrimary)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .onClick(() => {})
          }
          .width('100%')
          .padding(Spacing.md)
          .backgroundColor(Colors.surface)
          .borderRadius(Shapes.large)
          .shadow({ radius: 4, color: '#26000000', offsetY: 2 })
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
        }, (it: CartItem) => it.id.toString())

        Blank().height(Spacing.md)

        TextInput({ placeholder: 'Promo Code', text: this.promo })
          .width('100%')
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(Shapes.medium)
          .placeholderColor('#80FFFFFF')
          .onChange((value: string) => {
            this.promo = value
          })

        Blank().height(Spacing.md)

        Column({ space: Spacing.sm }) {
          Row() {
            Text('Items:')
              .fontSize(14)
              .fontColor(Colors.onSurface)
            Text(this.items.length.toString())
              .fontSize(14)
              .fontColor(Colors.primary)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          Row() {
            Text('Total:')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
            Text('$' + this.items.reduce((a: number, b: CartItem) => a + b.price, 0).toFixed(2))
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.primary)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .width('100%')
        .padding(Spacing.lg)
        .backgroundColor(Colors.surfaceVariant)
        .borderRadius(Shapes.large)
        .shadow({ radius: 4, color: '#26000000', offsetY: 2 })

        Button('Checkout', { type: ButtonType.Normal })
          .width('100%')
          .height(56)
          .borderRadius(Shapes.large)
          .backgroundColor(Colors.secondary)
          .fontColor(Colors.onSecondary)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {})
      }
      .width('100%')
      .padding(Spacing.lg)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#0A0A0A', 0.0], ['#1E1E1E', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
