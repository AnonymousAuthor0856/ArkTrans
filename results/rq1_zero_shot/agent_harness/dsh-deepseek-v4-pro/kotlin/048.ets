const Colors = {
  primary: '#1E3A8A',
  secondary: '#3B82F6',
  tertiary: '#60A5FA',
  background: '#F5F8FF',
  surface: '#FFFFFF',
  surfaceVariant: '#E8EEFA',
  outline: '#CBD5E1',
  success: '#22C55E',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#0B1220',
  onBackground: '#0B1220',
  onSurface: '#0B1220'
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
  xl: 24,
  xxl: 36
}

interface LiveItem {
  id: number
  title: string
  viewers: number
  price: string
}

@Entry
@Component
struct Index {
  @State liveList: LiveItem[] = [
    { id: 1, title: 'Smartphone Flash Deal', viewers: 1234, price: '$699' },
    { id: 2, title: 'Gaming Chair Special', viewers: 880, price: '$249' },
    { id: 3, title: 'Headphones Clearance', viewers: 1640, price: '$99' },
    { id: 4, title: 'Mechanical Keyboard', viewers: 512, price: '$129' }
  ]

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Column({ space: Spacing.md }) {
          Text('Live Shop Events')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.primary)
          List({ space: Spacing.md }) {
            ForEach(this.liveList, (item: LiveItem) => {
              ListItem() {
                Column({ space: Spacing.sm }) {
                  Row()
                    .width('100%')
                    .height(160)
                    .backgroundColor(Colors.secondary)
                    .borderRadius(Shapes.medium)
                  Text(item.title)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                  Text(item.viewers + ' viewers')
                    .fontSize(14)
                    .fontColor(Colors.tertiary)
                  Row() {
                    Text(item.price)
                      .fontSize(18)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(Colors.primary)
                    Button('Join Live', { type: ButtonType.Normal })
                      .borderRadius(Shapes.medium)
                      .backgroundColor(Colors.primary)
                      .fontColor(Colors.onPrimary)
                      .fontSize(12)
                      .fontWeight(FontWeight.Medium)
                      .onClick(() => {})
                  }
                  .width('100%')
                  .justifyContent(FlexAlign.SpaceBetween)
                  .alignItems(VerticalAlign.Center)
                }
                .width('100%')
                .padding(Spacing.lg)
                .backgroundColor(Colors.surface)
                .borderRadius(Shapes.large)
                .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
              }
            }, (item: LiveItem) => item.id.toString())
          }
          .layoutWeight(1)
          .width('100%')
          .scrollBar(BarState.Off)
        }
        .layoutWeight(1)
        .width('100%')
        .padding(Spacing.lg)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#F5F8FF', 0.0], ['#E8EEFA', 0.5], ['#F5F8FF', 1.0]]
        })

        Row() {
          Text('Home')
            .fontSize(14)
            .fontColor(Colors.primary)
          Text('Live')
            .fontSize(14)
            .fontColor(Colors.onSurface)
          Text('Cart')
            .fontSize(14)
            .fontColor(Colors.onSurface)
          Text('Profile')
            .fontSize(14)
            .fontColor(Colors.onSurface)
        }
        .width('100%')
        .height(56)
        .padding({ left: Spacing.lg, right: Spacing.lg })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(Colors.surface)
      }
      .width('100%')
      .height('100%')

      Button('+', { type: ButtonType.Normal })
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor(Colors.secondary)
        .fontColor(Colors.onSecondary)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .margin({ right: Spacing.lg, bottom: Spacing.lg })
        .onClick(() => {})
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
