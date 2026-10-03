class TeaGuide {
  id: number
  name: string
  origin: string
  temp: string
  time: string
  colorCode: ResourceColor
  borderColor: ResourceColor

  constructor(
    id: number,
    name: string,
    origin: string,
    temp: string,
    time: string,
    colorCode: ResourceColor,
    borderColor: ResourceColor
  ) {
    this.id = id
    this.name = name
    this.origin = origin
    this.temp = temp
    this.time = time
    this.colorCode = colorCode
    this.borderColor = borderColor
  }
}

const PRIMARY_BLACK: ResourceColor = '#121212'
const TEXT_GREY: ResourceColor = '#757575'
const BACKGROUND_WHITE: ResourceColor = '#FFFFFF'
const CARD_BACKGROUND: ResourceColor = '#F9F9F9'
const PROMO_CARD_BACKGROUND: ResourceColor = '#F0F0F0'
const LIGHT_GREY_BORDER: ResourceColor = '#EEEEEE'
const VERY_LIGHT_GREY_BORDER: ResourceColor = '#E0E0E0'

const SAMPLE_TEAS: TeaGuide[] = [
  new TeaGuide(1, 'Sencha Green', 'Japan', '70°C / 158°F', '1-2 min', '#8BC34A', '#4D8BC34A'),
  new TeaGuide(2, 'Earl Grey', 'Blend', '95°C / 203°F', '3-5 min', '#795548', '#4D795548'),
  new TeaGuide(3, 'Silver Needle', 'China', '80°C / 176°F', '3-4 min', '#E0E0E0', '#4DE0E0E0'),
  new TeaGuide(4, 'Darjeeling', 'India', '90°C / 194°F', '3 min', '#D7CCC8', '#4DD7CCC8'),
  new TeaGuide(5, 'Chamomile', 'Egypt', '100°C / 212°F', '5-7 min', '#FFEB3B', '#4DFFEB3B'),
  new TeaGuide(6, 'Matcha', 'Japan', '80°C / 176°F', 'Whisk', '#4CAF50', '#4D4CAF50'),
  new TeaGuide(7, 'Oolong', 'Taiwan', '85°C / 185°F', '3-5 min', '#FF9800', '#4DFF9800')
]

@Entry
@Component
struct ZenBrewApp {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Scroll() {
        Column({ space: 16 }) {
          Row() {
            Column() {
              Text('ZenBrew')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(PRIMARY_BLACK)
                .letterSpacing(-0.5)

              Text('Mindful Steeping Guide')
                .fontSize(14)
                .fontWeight(FontWeight.Regular)
                .fontColor(TEXT_GREY)
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Button({ type: ButtonType.Normal, stateEffect: true }) {
              Text('⚙')
                .fontSize(32)
                .fontColor(PRIMARY_BLACK)
            }
            .width(44)
            .height(44)
            .backgroundColor(Color.Transparent)
          }
          .width('100%')
          .padding({ left: 20, right: 20, top: 10 })
          .alignItems(VerticalAlign.Top)

          PromoCard()
            .margin({ left: 20, right: 20 })

          Text('Collections')
            .width('100%')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(PRIMARY_BLACK)
            .padding({ left: 20, right: 20, top: 8, bottom: 8 })
            .textAlign(TextAlign.Start)

          ForEach(SAMPLE_TEAS, (tea: TeaGuide) => {
            TeaItemCard({ tea: tea })
              .margin({ left: 20, right: 20 })
          }, (tea: TeaGuide) => tea.id.toString())

          Blank()
            .height(80)
        }
        .width('100%')
        .padding({ top: 10, bottom: 10 })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .backgroundColor(BACKGROUND_WHITE)

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Row({ space: 8 }) {
          Text('+')
            .fontSize(38)
            .fontWeight(FontWeight.Regular)
            .fontColor(Color.White)
            .height(42)

          Text('Custom Brew')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
        }
        .height(56)
        .padding({ left: 24, right: 24 })
        .alignItems(VerticalAlign.Center)
      }
      .height(56)
      .backgroundColor(PRIMARY_BLACK)
      .borderRadius(16)
      .margin({ right: 20, bottom: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND_WHITE)
  }
}

@Component
struct PromoCard {
  build() {
    Row() {
      Column() {
        Text('Tip of the day')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#8E8E93')
          .margin({ bottom: 4 })

        Text('Use filtered water for a purer taste profile.')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(PRIMARY_BLACK)
          .lineHeight(23)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Blank()
        .width(16)

      Stack({ alignContent: Alignment.Center }) {
        Stack({ alignContent: Alignment.Center }) {
          Text('i')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
        .width(48)
        .height(48)
        .backgroundColor(Color.White)
        .borderRadius(24)

        Stack({ alignContent: Alignment.Center }) {
          Text('i')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
        .width(28)
        .height(28)
        .backgroundColor('#8E8E93')
        .borderRadius(14)
      }
      .width(48)
      .height(48)
    }
    .width('100%')
    .padding(24)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(PROMO_CARD_BACKGROUND)
    .borderRadius(20)
  }
}

@Component
struct TeaItemCard {
  tea: TeaGuide = SAMPLE_TEAS[0]

  build() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Text(this.tea.name.charAt(0))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.tea.colorCode)
      }
      .width(50)
      .height(50)
      .backgroundColor(Color.White)
      .borderRadius(25)
      .border({
        width: 2,
        color: this.tea.borderColor,
        radius: 25
      })

      Blank()
        .width(16)

      Column() {
        Text(this.tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(PRIMARY_BLACK)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.tea.origin)
          .fontSize(12)
          .fontColor(TEXT_GREY)
          .margin({ top: 1 })

        Blank()
          .height(6)

        Row({ space: 8 }) {
          InfoBadge({ label: this.tea.temp })
          InfoBadge({ label: this.tea.time })
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('▶')
          .fontSize(24)
          .fontColor(PRIMARY_BLACK)
          .margin({ left: 3 })
      }
      .width(40)
      .height(40)
      .backgroundColor(Color.White)
      .borderRadius(20)
      .border({
        width: 1,
        color: VERY_LIGHT_GREY_BORDER,
        radius: 20
      })
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(CARD_BACKGROUND)
    .borderRadius(16)
    .border({
      width: 1,
      color: LIGHT_GREY_BORDER,
      radius: 16
    })
  }
}

@Component
struct InfoBadge {
  label: string = ''

  build() {
    Text(this.label)
      .fontSize(11)
      .fontColor('#000000')
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor(Color.White)
      .borderRadius(6)
      .border({
        width: 1,
        color: VERY_LIGHT_GREY_BORDER,
        radius: 6
      })
  }
}