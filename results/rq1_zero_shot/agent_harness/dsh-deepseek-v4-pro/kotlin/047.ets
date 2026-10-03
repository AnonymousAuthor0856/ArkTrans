const Colors = {
  primary: '#FF8C00',
  secondary: '#FFC107',
  tertiary: '#FFE082',
  background: '#FFF8E1',
  surface: '#FFFFFF',
  surfaceVariant: '#FFECB3',
  outline: '#D7CCC8',
  success: '#4CAF50',
  warning: '#FFB300',
  error: '#E53935',
  onPrimary: '#3E2723',
  onSecondary: '#3E2723',
  onBackground: '#3E2723',
  onSurface: '#3E2723'
}

const Shapes = {
  small: 6,
  medium: 10,
  large: 16
}

const Spacing = {
  sm: 6,
  md: 10,
  lg: 16,
  xl: 24
}

interface Pin {
  x: number
  y: number
  label: string
}

@Entry
@Component
struct Index {
  @State pins: Pin[] = [
    { x: 150, y: 250, label: 'Group A' },
    { x: 350, y: 420, label: 'Group B' },
    { x: 520, y: 310, label: 'Group C' }
  ]

  build() {
    Scroll() {
      Column({ space: Spacing.lg }) {
        Text('Retro Group Buy')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onBackground)

        Column({ space: Spacing.md }) {
          Text('Live Deals Map')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Stack({ alignContent: Alignment.TopStart }) {
            ForEach(this.pins, (p: Pin) => {
              Row()
                .width(28)
                .height(28)
                .borderRadius(14)
                .backgroundColor(Colors.primary)
                .position({ x: p.x, y: p.y })
            }, (p: Pin) => p.label + p.x + p.y)
          }
          .width('100%')
          .height(220)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(Shapes.medium)
          .padding(8)
        }
        .width('100%')
        .padding(Spacing.lg)
        .backgroundColor(Colors.surface)
        .borderRadius(Shapes.large)
        .shadow({ radius: 8, color: '#26000000', offsetY: 4 })

        Blank().height(Spacing.sm)

        Row() {
          Button('Add Group', { type: ButtonType.Normal })
            .layoutWeight(1)
            .height(48)
            .borderRadius(Shapes.medium)
            .backgroundColor(Colors.secondary)
            .fontColor(Colors.onSecondary)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.pins.push({
                x: 100 + Math.floor(Math.random() * 450),
                y: 150 + Math.floor(Math.random() * 300),
                label: 'New'
              })
            })
          Blank().width(Spacing.md)
          Button('Clear', { type: ButtonType.Normal })
            .layoutWeight(1)
            .height(48)
            .borderRadius(Shapes.medium)
            .backgroundColor(Colors.primary)
            .fontColor(Colors.onPrimary)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.pins = []
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Column({ space: Spacing.sm }) {
          Text('Active Groups')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.primary)
          ForEach(this.pins, (p: Pin) => {
            Row() {
              Text(p.label)
                .fontSize(14)
                .fontColor(Colors.onSurface)
              Row()
                .width(14)
                .height(14)
                .borderRadius(7)
                .backgroundColor(Colors.primary)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
          }, (p: Pin) => p.label + p.x + p.y)
        }
        .width('100%')
        .padding(Spacing.lg)
        .backgroundColor(Colors.surface)
        .borderRadius(Shapes.large)
        .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
      }
      .width('100%')
      .padding(Spacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
