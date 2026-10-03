class TeaGuide {
  id: number
  name: string
  origin: string
  temp: string
  time: string
  colorCode: string
  borderColor: string

  constructor(id: number, name: string, origin: string, temp: string, time: string, colorCode: string, borderColor: string) {
    this.id = id
    this.name = name
    this.origin = origin
    this.temp = temp
    this.time = time
    this.colorCode = colorCode
    this.borderColor = borderColor
  }
}

const sampleTeas: TeaGuide[] = [
  new TeaGuide(1, 'Sencha Green', 'Japan', '70°C / 158°F', '1-2 min', '#8BC34A', 'rgba(139, 195, 74, 0.3)'),
  new TeaGuide(2, 'Earl Grey', 'Blend', '95°C / 203°F', '3-5 min', '#795548', 'rgba(121, 85, 72, 0.3)'),
  new TeaGuide(3, 'Silver Needle', 'China', '80°C / 176°F', '3-4 min', '#E0E0E0', 'rgba(224, 224, 224, 0.3)'),
  new TeaGuide(4, 'Darjeeling', 'India', '90°C / 194°F', '3 min', '#D7CCC8', 'rgba(215, 204, 200, 0.3)'),
  new TeaGuide(5, 'Chamomile', 'Egypt', '100°C / 212°F', '5-7 min', '#FFEB3B', 'rgba(255, 235, 59, 0.3)'),
  new TeaGuide(6, 'Matcha', 'Japan', '80°C / 176°F', 'Whisk', '#4CAF50', 'rgba(76, 175, 80, 0.3)'),
  new TeaGuide(7, 'Oolong', 'Taiwan', '85°C / 185°F', '3-5 min', '#FF9800', 'rgba(255, 152, 0, 0.3)')
]

@Entry
@Component
struct Index {
  build() {
    ZenBrewApp()
  }
}

@Component
struct ZenBrewApp {
  private primaryBlack: string = '#121212'
  private textGrey: string = '#757575'
  private backgroundWhite: string = '#FFFFFF'
  private cardBackground: string = '#F9F9F9'

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Row() {
          Column() {
            Text('ZenBrew')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.primaryBlack)
              .letterSpacing(-0.5)

            Text('Mindful Steeping Guide')
              .fontSize(14)
              .fontColor(this.textGrey)
              .fontWeight(FontWeight.Normal)
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Button({ type: ButtonType.Circle, stateEffect: true }) {
            Text('⚙')
              .fontSize(24)
              .fontColor(this.primaryBlack)
          }
          .width(48)
          .height(48)
          .backgroundColor(Color.Transparent)
        }
        .width('100%')
        .height(88)
        .padding({ left: 20, right: 12, top: 16, bottom: 8 })
        .backgroundColor(this.backgroundWhite)
        .alignItems(VerticalAlign.Center)

        List({ space: 16 }) {
          ListItem() {
            PromoCard({ textColor: this.primaryBlack })
          }

          ListItem() {
            Text('Collections')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.primaryBlack)
              .padding({ top: 8, bottom: 8 })
          }

          ForEach(sampleTeas, (tea: TeaGuide) => {
            ListItem() {
              TeaItemCard({
                tea: tea,
                bgColor: this.cardBackground,
                titleColor: this.primaryBlack,
                subtitleColor: this.textGrey
              })
            }
          }, (tea: TeaGuide) => tea.id.toString())

          ListItem() {
            Blank()
              .height(80)
          }
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })
        .backgroundColor(this.backgroundWhite)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.backgroundWhite)

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Row() {
          Text('+')
            .fontSize(24)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Normal)

          Text('Custom Brew')
            .fontSize(14)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Medium)
            .margin({ left: 8 })
        }
        .alignItems(VerticalAlign.Center)
        .padding({ left: 16, right: 18 })
      }
      .height(56)
      .borderRadius(16)
      .backgroundColor(this.primaryBlack)
      .margin({ right: 20, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundWhite)
  }
}

@Component
struct PromoCard {
  textColor: string = '#121212'

  build() {
    Row() {
      Column() {
        Text('Tip of the day')
          .fontSize(12)
          .fontColor('#808080')
          .fontWeight(FontWeight.Bold)
          .padding({ bottom: 4 })

        Text('Use filtered water for a purer taste profile.')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.textColor)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Blank()
        .width(16)

      Stack({ alignContent: Alignment.Center }) {
        Text('i')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#808080')
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .padding(24)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#F0F0F0')
    .borderRadius(20)
  }
}

@Component
struct TeaItemCard {
  tea: TeaGuide = new TeaGuide(0, '', '', '', '', '#000000', 'rgba(0, 0, 0, 0.3)')
  bgColor: string = '#F9F9F9'
  titleColor: string = '#121212'
  subtitleColor: string = '#757575'

  build() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Text(this.tea.name.substring(0, 1))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.tea.colorCode)
      }
      .width(50)
      .height(50)
      .borderRadius(25)
      .backgroundColor('#FFFFFF')
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
          .fontColor(this.titleColor)

        Text(this.tea.origin)
          .fontSize(12)
          .fontColor(this.subtitleColor)

        Blank()
          .height(6)

        Row() {
          InfoBadge({ label: this.tea.temp })

          Blank()
            .width(8)

          InfoBadge({ label: this.tea.time })
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Stack({ alignContent: Alignment.Center }) {
        Text('▶')
          .fontSize(18)
          .fontColor(this.titleColor)
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor('#FFFFFF')
      .border({
        width: 1,
        color: '#E0E0E0',
        radius: 20
      })
      .onClick(() => {
      })
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(this.bgColor)
    .borderRadius(16)
    .border({
      width: 1,
      color: '#EEEEEE',
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
      .backgroundColor('#FFFFFF')
      .borderRadius(6)
      .border({
        width: 1,
        color: '#E0E0E0',
        radius: 6
      })
  }
}