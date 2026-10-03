// Translated from 098.swift (ZenBrew App)

class TeaGuide {
  id: number
  name: string
  origin: string
  temp: string
  time: string
  colorCode: string
  constructor(id: number, name: string, origin: string, temp: string, time: string, colorCode: string) {
    this.id = id
    this.name = name
    this.origin = origin
    this.temp = temp
    this.time = time
    this.colorCode = colorCode
  }
}

const sampleTeas: TeaGuide[] = [
  new TeaGuide(1, 'Sencha Green', 'Japan', '70°C / 158°F', '1-2 min', '#8BC34A'),
  new TeaGuide(2, 'Earl Grey', 'Blend', '95°C / 203°F', '3-5 min', '#795548'),
  new TeaGuide(3, 'Silver Needle', 'China', '80°C / 176°F', '3-4 min', '#E0E0E0'),
  new TeaGuide(4, 'Darjeeling', 'India', '90°C / 194°F', '3 min', '#D7CCC8'),
  new TeaGuide(5, 'Chamomile', 'Egypt', '100°C / 212°F', '5-7 min', '#FFEB3B'),
  new TeaGuide(6, 'Matcha', 'Japan', '80°C / 176°F', 'Whisk', '#4CAF50'),
  new TeaGuide(7, 'Oolong', 'Taiwan', '85°C / 185°F', '3-5 min', '#FF9800')
]

@Entry
@Component
struct Index {
  build() {
    ZenBrewAppView()
  }
}

@Component
struct ZenBrewAppView {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Scroll() {
        Column({ space: 16 }) {
          Row() {
            Column() {
              Text('ZenBrew')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#121212')
                .letterSpacing(-0.5)
              Text('Mindful Steeping Guide')
                .fontSize(14)
                .fontWeight(FontWeight.Regular)
                .fontColor('#757575')
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Button() {
              Text('⚙')
                .fontSize(24)
                .fontColor('#121212')
                .width(24)
                .height(24)
            }
            .width(44)
            .height(44)
            .onClick(() => { console.log('Settings tapped') })
          }
          .alignItems(VerticalAlign.Top)
          .padding({ left: 20, right: 20, top: 10 })
          .width('100%')

          PromoCard()
            .padding({ left: 20, right: 20 })

          Text('Collections')
            .fontSize(18)
            .fontWeight(FontWeight.Semibold)
            .fontColor('#121212')
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ top: 8, bottom: 8, left: 20, right: 20 })

          ForEach(sampleTeas, (tea: TeaGuide) => {
            TeaItemCard({ tea: tea })
              .padding({ left: 20, right: 20 })
          }, (tea: TeaGuide) => tea.id.toString())

          Blank().height(80)
        }
        .padding({ top: 10, bottom: 10 })
      }
      .scrollBar(BarState.Off)
      .backgroundColor('#FFFFFF')

      Button() {
        Row({ space: 8 }) {
          Text('+')
            .fontSize(20)
            .fontColor('#FFFFFF')
          Text('Custom Brew')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
        .height(56)
        .padding({ left: 24, right: 24 })
        .backgroundColor('#121212')
        .borderRadius(16)
      }
      .onClick(() => { console.log('Custom Brew tapped') })
      .padding({ right: 20, bottom: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
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
          .fontColor('#808080')
          .padding({ bottom: 4 })
        Text('Use filtered water for a purer taste profile.')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#121212')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Blank().width(16)

      Stack() {
        Circle()
          .fill('#FFFFFF')
          .width(48)
          .height(48)
        Text('ⓘ')
          .fontSize(24)
          .fontColor('#808080')
          .width(24)
          .height(24)
      }
    }
    .width('100%')
    .padding(24)
    .backgroundColor('#F0F0F0')
    .borderRadius(20)
  }
}

@Component
struct TeaItemCard {
  @Prop tea: TeaGuide = new TeaGuide(0, '', '', '', '', '#000000')

  build() {
    Row() {
      Stack() {
        Circle()
          .fill('#FFFFFF')
          .stroke('#4D' + this.tea.colorCode.substring(1))
          .strokeWidth(2)
          .width(50)
          .height(50)
        Text(this.tea.name.substring(0, 1))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.tea.colorCode)
      }

      Blank().width(16)

      Column() {
        Text(this.tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor('#121212')
        Text(this.tea.origin)
          .fontSize(12)
          .fontColor('#757575')
        Blank().height(6)
        Row() {
          InfoBadge({ label: this.tea.temp })
          Blank().width(8)
          InfoBadge({ label: this.tea.time })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button() {
        Text('▶')
          .fontSize(20)
          .fontColor('#121212')
          .width(20)
          .height(20)
      }
      .width(40)
      .height(40)
      .backgroundColor('#FFFFFF')
      .borderRadius(20)
      .border({ width: 1, color: '#E0E0E0', radius: 20 })
      .onClick(() => { console.log('Play for ' + this.tea.name + ' tapped') })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE', radius: 16 })
  }
}

@Component
struct InfoBadge {
  @Prop label: string = ''

  build() {
    Text(this.label)
      .fontSize(11)
      .fontColor('#000000')
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor('#FFFFFF')
      .borderRadius(6)
      .border({ width: 1, color: '#E0E0E0', radius: 6 })
  }
}
