interface TeaGuide {
  id: number
  name: string
  origin: string
  temp: string
  time: string
  colorCode: string
}

const sampleTeas: TeaGuide[] = [
  { id: 1, name: 'Sencha Green', origin: 'Japan', temp: '70°C / 158°F', time: '1-2 min', colorCode: '#8BC34A' },
  { id: 2, name: 'Earl Grey', origin: 'Blend', temp: '95°C / 203°F', time: '3-5 min', colorCode: '#795548' },
  { id: 3, name: 'Silver Needle', origin: 'China', temp: '80°C / 176°F', time: '3-4 min', colorCode: '#E0E0E0' },
  { id: 4, name: 'Darjeeling', origin: 'India', temp: '90°C / 194°F', time: '3 min', colorCode: '#D7CCC8' },
  { id: 5, name: 'Chamomile', origin: 'Egypt', temp: '100°C / 212°F', time: '5-7 min', colorCode: '#FFEB3B' },
  { id: 6, name: 'Matcha', origin: 'Japan', temp: '80°C / 176°F', time: 'Whisk', colorCode: '#4CAF50' },
  { id: 7, name: 'Oolong', origin: 'Taiwan', temp: '85°C / 185°F', time: '3-5 min', colorCode: '#FF9800' }
]

@Entry
@Component
struct Index {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        TopAppBar()

        List({ space: 16 }) {
          ListItem() {
            PromoCard()
          }

          ListItem() {
            Text('Collections')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 8, bottom: 8 })
          }

          ForEach(sampleTeas, (tea: TeaGuide) => {
            ListItem() {
              TeaItemCard({ name: tea.name, origin: tea.origin, temp: tea.temp, time: tea.time, colorCode: tea.colorCode })
            }
          }, (tea: TeaGuide) => tea.id.toString())

          ListItem() {
            Blank().height(80)
          }
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      Button() {
        Row() {
          Text('+').fontSize(20).fontColor('#FFFFFF')
          Blank().width(8)
          Text('Custom Brew').fontColor('#FFFFFF')
        }
      }
      .backgroundColor('#121212')
      .borderRadius(16)
      .height(56)
      .margin({ right: 20, bottom: 20 })
      .onClick(() => {})
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct TopAppBar {
  build() {
    Row() {
      Column() {
        Text('ZenBrew').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#121212').letterSpacing(-0.5)
        Text('Mindful Steeping Guide').fontSize(14).fontColor('#757575')
      }
      Stack() {
        Text('⚙').fontSize(24).fontColor('#121212')
      }
      .width(48).height(48)
      .onClick(() => {})
    }
    .width('100%')
    .padding({ left: 20, right: 20, top: 16, bottom: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct PromoCard {
  build() {
    Row() {
      Column() {
        Text('Tip of the day').fontSize(12).fontColor('#9E9E9E').fontWeight(FontWeight.Bold).margin({ bottom: 4 })
        Text('Use filtered water for a purer taste profile.').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#121212')
      }
      .layoutWeight(1)

      Blank().width(16)

      Stack() {
        Text('ⓘ').fontSize(24).fontColor('#9E9E9E')
      }
      .width(48).height(48)
      .borderRadius(24)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .padding(24)
    .borderRadius(20)
    .backgroundColor('#F0F0F0')
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct TeaItemCard {
  @Prop name: string = ''
  @Prop origin: string = ''
  @Prop temp: string = ''
  @Prop time: string = ''
  @Prop colorCode: string = ''

  withAlpha(hex: string, alpha: number): string {
    const r = parseInt(hex.substring(1, 3), 16)
    const g = parseInt(hex.substring(3, 5), 16)
    const b = parseInt(hex.substring(5, 7), 16)
    return 'rgba(' + r + ',' + g + ',' + b + ',' + alpha + ')'
  }

  build() {
    Row() {
      Stack() {
        Text(this.name.substring(0, 1))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.colorCode)
      }
      .width(50).height(50)
      .borderRadius(25)
      .backgroundColor('#FFFFFF')
      .border({ width: 2, color: this.withAlpha(this.colorCode, 0.3) })

      Blank().width(16)

      Column() {
        Text(this.name).fontSize(17).fontWeight(FontWeight.Bold).fontColor('#121212')
        Text(this.origin).fontSize(12).fontColor('#757575')
        Blank().height(6)
        Row() {
          InfoBadge({ label: this.temp })
          Blank().width(8)
          InfoBadge({ label: this.time })
        }
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)

      Stack() {
        Text('▶').fontSize(20).fontColor('#121212')
      }
      .width(40).height(40)
      .borderRadius(20)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: '#E0E0E0' })
      .onClick(() => {})
    }
    .width('100%')
    .padding(16)
    .borderRadius(16)
    .backgroundColor('#F9F9F9')
    .border({ width: 1, color: '#EEEEEE' })
    .alignItems(VerticalAlign.Center)
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
      .border({ width: 1, color: '#E0E0E0' })
  }
}
