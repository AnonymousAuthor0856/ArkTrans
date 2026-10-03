import { LengthMetrics } from '@kit.ArkUI'

// Color tokens
const primaryColor: ResourceColor = '#1E3A8A'
const secondaryColor: ResourceColor = '#3B82F6'
const tertiaryColor: ResourceColor = '#60A5FA'
const backgroundColor: ResourceColor = '#F5F8FF'
const surfaceColor: ResourceColor = '#FFFFFF'
const surfaceVariantColor: ResourceColor = '#E8EEFA'
const onPrimaryColor: ResourceColor = '#FFFFFF'
const onSurfaceColor: ResourceColor = '#0B1220'

interface LiveItem {
  id: number
  title: string
  viewers: number
  price: string
}

const liveList: LiveItem[] = [
  { id: 1, title: 'Smartphone Flash Deal', viewers: 1234, price: '$699' },
  { id: 2, title: 'Gaming Chair Special', viewers: 880, price: '$249' },
  { id: 3, title: 'Headphones Clearance', viewers: 1640, price: '$99' },
  { id: 4, title: 'Mechanical Keyboard', viewers: 512, price: '$129' }
]

@Component
struct LiveCard {
  item: LiveItem = { id: 0, title: '', viewers: 0, price: '' }

  build() {
    Column({ space: 6 }) {
      // Image placeholder
      Row() {
      }
      .width('100%')
      .height(160)
      .backgroundColor(secondaryColor)
      .borderRadius(10)

      Text(this.item.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(onSurfaceColor)

      Text(`${this.item.viewers} viewers`)
        .fontSize(14)
        .fontColor(tertiaryColor)

      Row() {
        Text(this.item.price)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(primaryColor)

        Button('Join Live')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(onPrimaryColor)
          .backgroundColor(primaryColor)
          .borderRadius(10)
          .height(36)
          .padding({ left: 16, right: 16 })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(surfaceColor)
    .borderRadius(16)
    .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
  }
}

@Entry
@Component
struct Index {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Main content
      Column() {
        // Header
        Text('Live Shop Events')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(primaryColor)
          .margin({ bottom: 10 })
          .alignSelf(ItemAlign.Start)

        // List
        List({ space: 10 }) {
          ForEach(liveList, (item: LiveItem) => {
            ListItem() {
              LiveCard({ item: item })
            }
          })
          ListItem().height(96)
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        angle: 180,
        colors: [
          [0xFFF5F8FF, 0.0],
          [0xFFE8EEFA, 0.5],
          [0xFFF5F8FF, 1.0]
        ]
      })

      // Bottom bar
      Column() {
        Row() {
          Text('Home')
            .fontSize(14)
            .fontColor(primaryColor)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          Text('Live')
            .fontSize(14)
            .fontColor(onSurfaceColor)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          Text('Cart')
            .fontSize(14)
            .fontColor(onSurfaceColor)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          Text('Profile')
            .fontSize(14)
            .fontColor(onSurfaceColor)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(56)
        .alignItems(VerticalAlign.Center)
        .padding({ left: 16, right: 16 })
        .backgroundColor(surfaceColor)
      }
      .width('100%')
      .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: -2 })

      // FAB
      Button('+')
        .fontSize(24)
        .fontColor(onPrimaryColor)
        .backgroundColor(secondaryColor)
        .width(56)
        .height(56)
        .borderRadius(28)
        .margin({ right: 16, bottom: 72 })
        .shadow({ radius: 8, color: '#3F000000', offsetX: 0, offsetY: 4 })
        .alignSelf(ItemAlign.End)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(backgroundColor)
  }
}