const ZEN_GREEN: string = '#6A8E6A'
const ZEN_GREEN_LIGHT: string = '#E8F5E9'
const ZEN_BROWN: string = '#8D6E63'
const ZEN_TEXT: string = '#2C3E50'
const ZEN_MUTED: string = '#7F8C8D'
const SOFT_CIRCLE: string = '#F7F9F9'

@Entry
@Component
struct ZenGardenPage {
  @State selectedTab: number = 0

  @Builder
  StatusItem(icon: string, value: string, label: string, tint: string) {
    Column() {
      Stack() {
        Circle()
          .width(100)
          .height(100)
          .fill(SOFT_CIRCLE)
          .stroke('#ECEFF1')
          .strokeWidth(2)
        Text(icon)
          .fontSize(42)
          .fontColor(tint)
          .fontWeight(FontWeight.Medium)
      }
      .width(100)
      .height(100)

      Text(value)
        .fontSize(34)
        .fontWeight(FontWeight.Bold)
        .fontColor(ZEN_TEXT)
        .margin({ top: 18 })
      Text(label)
        .fontSize(22)
        .fontColor(ZEN_MUTED)
        .margin({ top: 4 })
    }
    .width('33%')
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  CareRow(title: string, subtitle: string, done: boolean) {
    Row() {
      Circle()
        .width(12)
        .height(12)
        .fill(done ? ZEN_GREEN : '#E0E0E0')
      Column() {
        Text(title)
          .fontSize(16)
          .fontColor(done ? ZEN_TEXT : ZEN_MUTED)
        Text(subtitle)
          .fontSize(12)
          .fontColor('#9E9E9E')
          .margin({ top: 3 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })
      if (done) {
        Text('✓')
          .fontSize(20)
          .fontColor(ZEN_GREEN)
      }
    }
    .width('100%')
    .height(68)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FAFAFA')
    .border({ width: 1, color: '#F0F0F0', radius: 12 })
  }

  @Builder
  Bonsai() {
    Stack({ alignContent: Alignment.Bottom }) {
      Stack() {
        // Pot rim and body
        Row()
          .width(240)
          .height(15)
          .backgroundColor('#A98980')
          .position({ x: 0, y: 310 })
        Row()
          .width(220)
          .height(66)
          .backgroundColor(ZEN_BROWN)
          .position({ x: 10, y: 310 })

        // Curving trunk, composed of rounded branch segments
        Row()
          .width(27)
          .height(145)
          .backgroundColor('#5D4037')
          .borderRadius(20)
          .rotate({ angle: -14 })
          .position({ x: 115, y: 180 })
        Row()
          .width(24)
          .height(90)
          .backgroundColor('#5D4037')
          .borderRadius(18)
          .rotate({ angle: 42 })
          .position({ x: 108, y: 112 })
        Row()
          .width(16)
          .height(58)
          .backgroundColor('#5D4037')
          .borderRadius(14)
          .rotate({ angle: -48 })
          .position({ x: 61, y: 156 })

        // Leaf clusters
        Circle().width(90).height(90).fill(ZEN_GREEN).position({ x: 111, y: 2 })
        Circle().width(70).height(70).fill('#89A889').position({ x: 153, y: 25 })
        Circle().width(60).height(60).fill(ZEN_GREEN).position({ x: 100, y: 0 })
        Circle().width(70).height(70).fill(ZEN_GREEN).position({ x: 61, y: 122 })
        Circle().width(50).height(50).fill('#89A889').position({ x: 48, y: 110 })
        Circle().width(50).height(50).fill(ZEN_GREEN).position({ x: 14, y: 97 })
      }
      .width(240)
      .height(376)
    }
    .width(240)
    .height(376)
    .margin({ top: 100 })
  }

  build() {
    Column() {
      Scroll() {
        Column() {
          Column() {
            Text('JUNIPER · #04')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(ZEN_MUTED)
              .letterSpacing(3)
            Text('Zen Garden')
              .fontSize(54)
              .fontWeight(FontWeight.Lighter)
              .fontColor(ZEN_TEXT)
              .margin({ top: 10 })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
          .margin({ top: 48 })

          this.Bonsai()

          Row() {
            this.StatusItem('♥', '98%', 'Health', '#E57373')
            this.StatusItem('▣', '4 Yrs', 'Age', ZEN_BROWN)
            this.StatusItem('✓', '2 Days', 'Water', '#64B5F6')
          }
          .width('100%')
          .margin({ top: 38 })

          Row() {
            Text('Care Schedule')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor('#202026')
            Stack() {
              Circle()
                .width(56)
                .height(56)
                .fill(ZEN_GREEN_LIGHT)
              Text('+')
                .fontSize(42)
                .fontColor(ZEN_GREEN)
                .fontWeight(FontWeight.Lighter)
            }
            .width(56)
            .height(56)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .margin({ top: 76, bottom: 18 })

          Column({ space: 12 }) {
            this.CareRow('Watering', 'Today, 8:00 AM', true)
            this.CareRow('Pruning', 'Tomorrow', false)
            this.CareRow('Fertilizer', 'In 5 days', false)
          }
          .width('100%')
          .padding({ bottom: 20 })
        }
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 12 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      Row() {
        Text('⌂')
          .fontSize(42)
          .fontColor(this.selectedTab === 0 ? ZEN_GREEN : '#CFD8DC')
          .onClick(() => this.selectedTab = 0)
        Text('●')
          .fontSize(28)
          .fontColor(this.selectedTab === 1 ? ZEN_GREEN : '#CFD8DC')
          .onClick(() => this.selectedTab = 1)
        Text('⚙')
          .fontSize(34)
          .fontColor(this.selectedTab === 2 ? ZEN_GREEN : '#CFD8DC')
          .onClick(() => this.selectedTab = 2)
      }
      .width('100%')
      .height(80)
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: '#F5F5F5' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
