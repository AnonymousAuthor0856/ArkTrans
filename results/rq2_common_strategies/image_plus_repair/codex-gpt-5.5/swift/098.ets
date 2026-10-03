interface TeaGuide {
  name: string
  origin: string
  temp: string
  time: string
  color: string
}

interface ZenBrewColors {
  black: string
  grey: string
  card: string
  promo: string
  border: string
  lightBorder: string
}

const TEAS: TeaGuide[] = [
  { name: 'Sencha Green', origin: 'Japan', temp: '70°C / 158°F', time: '1-2 min', color: '#8BC34A' },
  { name: 'Earl Grey', origin: 'Blend', temp: '95°C / 203°F', time: '3-5 min', color: '#795548' },
  { name: 'Silver Needle', origin: 'China', temp: '80°C / 176°F', time: '3-4 min', color: '#E0E0E0' },
  { name: 'Darjeeling', origin: 'India', temp: '90°C / 194°F', time: '3 min', color: '#D7CCC8' },
  { name: 'Chamomile', origin: 'Egypt', temp: '100°C / 212°F', time: '5-7 min', color: '#FFEB3B' },
  { name: 'Matcha', origin: 'Japan', temp: '80°C / 176°F', time: 'Whisk', color: '#4CAF50' },
  { name: 'Oolong', origin: 'Taiwan', temp: '85°C / 185°F', time: '3-5 min', color: '#FF9800' }
]

const COLORS: ZenBrewColors = {
  black: '#121212',
  grey: '#757575',
  card: '#F9F9F9',
  promo: '#F0F0F0',
  border: '#EEEEEE',
  lightBorder: '#E0E0E0'
}

@Entry
@Component
struct ZenBrewApp {
  @State private showSettings: boolean = false

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Scroll() {
        Column({ space: 16 }) {
          Row() {
            Column() {
              Text('ZenBrew')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(COLORS.black)
                .letterSpacing(-0.5)
              Text('Mindful Steeping Guide')
                .fontSize(14)
                .fontColor(COLORS.grey)
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)

            Blank()
              .layoutWeight(1)

            Button({ type: ButtonType.Normal }) {
              Text('⚙')
                .fontSize(29)
                .fontColor(COLORS.black)
            }
            .width(44)
            .height(44)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              this.showSettings = !this.showSettings
            })
          }
          .width('100%')
          .padding({ top: 10 })
          .alignItems(VerticalAlign.Top)

          Row() {
            Column() {
              Text('Tip of the day')
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .fontColor('#909096')
                .margin({ bottom: 8 })
              Text('Use filtered water for a purer\ntaste profile.')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLORS.black)
                .lineHeight(22)
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)

            Blank().width(16)

            Stack({ alignContent: Alignment.Center }) {
              Circle()
                .width(48)
                .height(48)
                .fill(Color.White)
              Text('ℹ')
                .fontSize(27)
                .fontWeight(FontWeight.Bold)
                .fontColor('#909096')
            }
            .width(48)
            .height(48)
          }
          .width('100%')
          .padding(24)
          .backgroundColor(COLORS.promo)
          .borderRadius(20)

          Text('Collections')
            .width('100%')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLORS.black)
            .padding({ top: 8, bottom: 8 })

          ForEach(TEAS, (tea: TeaGuide) => {
            this.buildTeaCard(tea)
          }, (tea: TeaGuide) => tea.name)

          Blank().height(80)
        }
        .width('100%')
        .padding({ top: 10, bottom: 10 })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

      Button({ type: ButtonType.Normal }) {
        Row({ space: 8 }) {
          Text('+')
            .fontSize(38)
            .fontWeight(FontWeight.Lighter)
            .lineHeight(38)
          Text('Custom Brew')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
        }
        .height(56)
        .padding({ left: 24, right: 24 })
        .alignItems(VerticalAlign.Center)
      }
      .height(56)
      .margin({ right: 20, bottom: 20 })
      .backgroundColor(COLORS.black)
      .fontColor(Color.White)
      .borderRadius(16)
      .onClick(() => {
        console.info('Custom Brew tapped')
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .padding({ left: 20, right: 20 })
  }

  @Builder
  buildTeaCard(tea: TeaGuide) {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(50)
          .height(50)
          .fill(Color.White)
          .stroke(tea.color)
          .strokeWidth(2)
        Text(tea.name.charAt(0))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(tea.color)
      }
      .width(50)
      .height(50)

      Blank().width(16)

      Column() {
        Text(tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.black)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Text(tea.origin)
          .fontSize(12)
          .fontColor(COLORS.grey)
          .margin({ top: 2 })
        Row({ space: 8 }) {
          this.buildBadge(tea.temp)
          this.buildBadge(tea.time)
        }
        .margin({ top: 6 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button({ type: ButtonType.Normal }) {
        Text('▶')
          .fontSize(22)
          .fontColor(COLORS.black)
          .margin({ left: 2 })
      }
      .width(40)
      .height(40)
      .backgroundColor(Color.White)
      .borderRadius(20)
      .border({ width: 1, color: COLORS.lightBorder })
      .onClick(() => {
        console.info(`Play for ${tea.name} tapped`)
      })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(COLORS.card)
    .borderRadius(16)
    .border({ width: 1, color: COLORS.border })
  }

  @Builder
  buildBadge(label: string) {
    Text(label)
      .fontSize(11)
      .fontColor(Color.Black)
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor(Color.White)
      .borderRadius(6)
      .border({ width: 1, color: COLORS.lightBorder })
  }
}
