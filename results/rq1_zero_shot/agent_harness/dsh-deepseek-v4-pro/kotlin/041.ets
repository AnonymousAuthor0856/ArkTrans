const Colors = {
  primary: '#111111',
  secondary: '#333333',
  tertiary: '#777777',
  background: '#FFFFFF',
  surface: '#F9F9F9',
  surfaceVariant: '#E5E5E5',
  outline: '#CCCCCC',
  success: '#16A34A',
  warning: '#F59E0B',
  error: '#DC2626',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#111111',
  onBackground: '#111111',
  onSurface: '#111111'
}

const Shapes = {
  small: 6,
  medium: 10,
  large: 14
}

const Spacing = {
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32
}

interface Marker {
  x: number
  y: number
  label: string
}

@Entry
@Component
struct Index {
  @State markers: Marker[] = [
    { x: 120, y: 200, label: 'Store A' },
    { x: 360, y: 400, label: 'Store B' }
  ]

  build() {
    Scroll() {
      Column({ space: Spacing.lg }) {
        Text('Product Detail')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.primary)

        Column({ space: Spacing.md }) {
          Row()
            .width('100%')
            .height(160)
            .backgroundColor(Colors.surfaceVariant)
          Text('Monochrome Bag')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text('A minimalist and timeless design piece.')
            .fontSize(14)
            .fontColor(Colors.tertiary)
          Text('$79.00')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.primary)
          Button('Add to Cart', { type: ButtonType.Normal })
            .width('100%')
            .height(48)
            .borderRadius(Shapes.medium)
            .backgroundColor(Colors.primary)
            .fontColor(Colors.onPrimary)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {})
        }
        .width('100%')
        .padding(Spacing.lg)
        .backgroundColor(Colors.surface)
        .borderRadius(Shapes.large)
        .shadow({ radius: 8, color: '#1F000000', offsetY: 4 })

        Stack({ alignContent: Alignment.TopStart }) {
          ForEach(this.markers, (m: Marker) => {
            Row()
              .width(28)
              .height(28)
              .borderRadius(14)
              .backgroundColor(Colors.primary)
              .position({ x: m.x, y: m.y })
          }, (m: Marker) => m.label + m.x + m.y)
        }
        .width('100%')
        .height(240)
        .backgroundColor(Colors.surfaceVariant)
        .borderRadius(Shapes.large)

        Row() {
          Button('Add Marker', { type: ButtonType.Normal })
            .layoutWeight(1)
            .height(44)
            .borderRadius(Shapes.medium)
            .backgroundColor(Colors.secondary)
            .fontColor(Colors.onSecondary)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.markers.push({
                x: 100 + Math.floor(Math.random() * 400),
                y: 150 + Math.floor(Math.random() * 300),
                label: 'New'
              })
            })
          Blank().width(Spacing.md)
          Button('Clear', { type: ButtonType.Normal })
            .layoutWeight(1)
            .height(44)
            .borderRadius(Shapes.medium)
            .backgroundColor(Colors.tertiary)
            .fontColor(Colors.onTertiary)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.markers = []
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding(Spacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
