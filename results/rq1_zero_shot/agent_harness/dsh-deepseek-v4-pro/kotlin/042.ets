const Colors = {
  primary: '#0EA5E9',
  secondary: '#38BDF8',
  tertiary: '#7DD3FC',
  background: '#F0F9FF',
  surface: '#FFFFFF',
  surfaceVariant: '#E0F2FE',
  outline: '#BAE6FD',
  success: '#22C55E',
  warning: '#FACC15',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#1E1E1E',
  onTertiary: '#0F172A',
  onBackground: '#0F172A',
  onSurface: '#0F172A'
}

const Shapes = {
  small: 6,
  medium: 10,
  large: 16
}

const Spacing = {
  sm: 6,
  md: 10,
  lg: 14,
  xl: 20,
  xxl: 28
}

interface Product {
  id: number
  name: string
  price: string
  store: string
}

@Entry
@Component
struct Index {
  @State products: Product[] = [
    { id: 1, name: 'Wireless Earbuds', price: '$59.99', store: 'ShopA' },
    { id: 2, name: 'Smart Watch', price: '$129.99', store: 'ShopB' },
    { id: 3, name: 'Laptop Stand', price: '$39.99', store: 'ShopC' },
    { id: 4, name: 'Mechanical Keyboard', price: '$89.99', store: 'ShopA' },
    { id: 5, name: 'Noise Cancel Headset', price: '$149.99', store: 'ShopB' },
    { id: 6, name: 'Ergo Mouse', price: '$45.99', store: 'ShopC' }
  ]

  build() {
    Scroll() {
      Column({ space: Spacing.lg }) {
        Text('Cold Gradient Price Compare')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onBackground)

        Grid() {
          ForEach(this.products, (p: Product) => {
            Column({ space: Spacing.sm }) {
              Row()
                .width(100)
                .height(100)
                .backgroundColor(Colors.surfaceVariant)
                .borderRadius(Shapes.medium)
              Text(p.name)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
              Text(p.price)
                .fontSize(14)
                .fontColor(Colors.primary)
              Text(p.store)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.tertiary)
              Button('Compare', { type: ButtonType.Normal })
                .width('100%')
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
            .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
            .alignItems(HorizontalAlign.Center)
          }, (p: Product) => p.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(Spacing.md)
        .rowsGap(Spacing.md)
        .width('100%')

        Text('Price Update Log')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.primary)

        Column({ space: Spacing.sm }) {
          ForEach(this.products, (p: Product) => {
            Row() {
              Text(p.name + ' (' + p.store + ')')
                .fontSize(14)
                .fontColor(Colors.onSurface)
              Text(p.price)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.secondary)
            }
            .width('100%')
            .padding(Spacing.md)
            .backgroundColor(Colors.surface)
            .borderRadius(Shapes.small)
            .justifyContent(FlexAlign.SpaceBetween)
          }, (p: Product) => 'log' + p.id.toString())
        }
        .width('100%')
      }
      .width('100%')
      .padding(Spacing.lg)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#4038BDF8', 0.0], ['#F0F9FF', 0.5], ['#400EA5E9', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
