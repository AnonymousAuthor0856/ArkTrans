const Colors = {
  primary: '#7B61FF',
  secondary: '#26C6DA',
  tertiary: '#FF8A80',
  background: '#F5F7FF',
  surface: '#FFFFFF',
  surfaceVariant: '#F0F2F8',
  outline: '#E0E3EB',
  success: '#22C55E',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#0B1220',
  onTertiary: '#0B1220',
  onBackground: '#0B1220',
  onSurface: '#0B1220'
}

const Shapes = {
  small: 8,
  medium: 14,
  large: 20
}

const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32
}

interface Coupon {
  id: number
  title: string
  value: string
  colorA: string
  colorB: string
}

interface MapPin {
  x: number
  y: number
  label: string
  tint: string
}

@Entry
@Component
struct Index {
  @State coupons: Coupon[] = [
    { id: 1, title: 'Grocery Pack', value: '-$5', colorA: Colors.primary, colorB: Colors.secondary },
    { id: 2, title: 'Cafe Bundle', value: '-15%', colorA: Colors.secondary, colorB: Colors.tertiary },
    { id: 3, title: 'Electro Deal', value: '-$20', colorA: Colors.tertiary, colorB: Colors.primary },
    { id: 4, title: 'Fashion Duo', value: '-10%', colorA: Colors.secondary, colorB: Colors.primary }
  ]
  @State pins: MapPin[] = [
    { x: 140, y: 220, label: 'A', tint: Colors.primary },
    { x: 320, y: 400, label: 'B', tint: Colors.secondary },
    { x: 520, y: 300, label: 'C', tint: Colors.tertiary }
  ]

  build() {
    Column() {
      Row() {
        Row()
          .width(20)
          .height(20)
          .borderRadius(10)
          .backgroundColor(Colors.onSurface)
          .margin({ left: Spacing.lg })
        Text('Coupon Pack')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Row()
          .width(20)
          .height(20)
          .borderRadius(10)
          .backgroundColor(Colors.primary)
          .margin({ right: Spacing.lg })
      }
      .width('100%')
      .height(56)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column({ space: Spacing.lg }) {
          Text('Nearby Packs')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)

          Stack({ alignContent: Alignment.TopEnd }) {
            ForEach(this.pins, (p: MapPin) => {
              Row()
                .width(28)
                .height(28)
                .borderRadius(14)
                .backgroundColor(p.tint)
                .position({ x: p.x, y: p.y })
            }, (p: MapPin) => p.label + p.x + p.y)
            Row({ space: Spacing.sm }) {
              Row().width(10).height(10).borderRadius(5).backgroundColor(Colors.primary)
              Text('A').fontSize(12).fontWeight(FontWeight.Medium).fontColor(Colors.onSurface)
              Row().width(10).height(10).borderRadius(5).backgroundColor(Colors.secondary)
              Text('B').fontSize(12).fontWeight(FontWeight.Medium).fontColor(Colors.onSurface)
              Row().width(10).height(10).borderRadius(5).backgroundColor(Colors.tertiary)
              Text('C').fontSize(12).fontWeight(FontWeight.Medium).fontColor(Colors.onSurface)
            }
            .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.xs, bottom: Spacing.xs })
            .backgroundColor('#E6FFFFFF')
            .borderRadius(Shapes.small)
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .aspectRatio(16 / 9)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(Shapes.large)
          .padding(Spacing.md)

          Text('Your Coupon Packs')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)

          Scroll() {
            Row({ space: Spacing.lg }) {
              ForEach(this.coupons, (c: Coupon) => {
                Column({ space: Spacing.sm }) {
                  Row({ space: Spacing.sm }) {
                    Row().width(14).height(14).borderRadius(7).backgroundColor(Colors.primary)
                    Text(c.title)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(Colors.onSurface)
                  }
                  .alignItems(VerticalAlign.Center)
                  Text(c.value)
                    .fontSize(28)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Colors.onSurface)
                  Button('Redeem', { type: ButtonType.Normal })
                    .width('100%')
                    .height(40)
                    .borderRadius(Shapes.medium)
                    .backgroundColor(Colors.primary)
                    .fontColor(Colors.onPrimary)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .onClick(() => {})
                }
                .width(200)
                .height(140)
                .padding(Spacing.lg)
                .linearGradient({
                  direction: GradientDirection.Right,
                  colors: [['#2E' + c.colorA.substring(1), 0.0], ['#2E' + c.colorB.substring(1), 1.0]]
                })
                .backgroundColor(Colors.surface)
                .borderRadius(Shapes.large)
                .shadow({ radius: 10, color: '#29000000', offsetY: 6 })
                .alignItems(HorizontalAlign.Start)
              }, (c: Coupon) => c.id.toString())
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .width('100%')

          Blank().height(Spacing.sm)

          Row({ space: Spacing.md }) {
            Button('My Coupons', { type: ButtonType.Normal })
              .layoutWeight(1)
              .height(52)
              .borderRadius(Shapes.large)
              .backgroundColor(Colors.secondary)
              .fontColor(Colors.onSecondary)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .onClick(() => {})
            Button('Explore More', { type: ButtonType.Normal })
              .layoutWeight(1)
              .height(52)
              .borderRadius(Shapes.large)
              .backgroundColor(Colors.primary)
              .fontColor(Colors.onPrimary)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .onClick(() => {})
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .padding(Spacing.lg)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#4026C6DA', 0.0], ['#F5F7FF', 0.5], ['#407B61FF', 1.0]]
        })
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
