interface TeaGuide {
  id: number
  name: string
  origin: string
  temp: string
  time: string
  color: string
}

const TEAS: TeaGuide[] = [
  { id: 1, name: 'Sencha Green', origin: 'Japan', temp: '70°C / 158°F', time: '1-2 min', color: '#8BC34A' },
  { id: 2, name: 'Earl Grey', origin: 'Blend', temp: '95°C / 203°F', time: '3-5 min', color: '#795548' },
  { id: 3, name: 'Silver Needle', origin: 'China', temp: '80°C / 176°F', time: '3-4 min', color: '#E0E0E0' },
  { id: 4, name: 'Darjeeling', origin: 'India', temp: '90°C / 194°F', time: '3 min', color: '#D7CCC8' },
  { id: 5, name: 'Chamomile', origin: 'Egypt', temp: '100°C / 212°F', time: '5-7 min', color: '#F0C928' },
  { id: 6, name: 'Matcha', origin: 'Japan', temp: '80°C / 176°F', time: 'Whisk', color: '#4CAF50' },
  { id: 7, name: 'Oolong', origin: 'Taiwan', temp: '85°C / 185°F', time: '3-5 min', color: '#FF9800' }
]

@Entry
@Component
struct ZenBrewApp {
  @State private showCustomBrew: boolean = false

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.header()

        Scroll() {
          Column({ space: 16 }) {
            this.tipCard()

            Text('Collections')
              .fontSize(36)
              .fontWeight(FontWeight.Bold)
              .fontColor('#171717')
              .width('100%')
              .margin({ top: 28, bottom: 34 })

            ForEach(TEAS, (tea: TeaGuide) => {
              this.teaCard(tea)
            }, (tea: TeaGuide) => tea.id.toString())

            Blank().height(88)
          }
          .width('100%')
          .padding({ left: 40, right: 40, top: 8, bottom: 12 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)

      Button({ type: ButtonType.Capsule }) {
        Row({ space: 16 }) {
          Text('+')
            .fontSize(34)
            .fontWeight(FontWeight.Lighter)
            .fontColor(Color.White)
            .lineHeight(34)
          Text('Custom Brew')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
        .alignItems(VerticalAlign.Center)
      }
      .width(332)
      .height(112)
      .margin({ right: 32, bottom: 20 })
      .backgroundColor('#121212')
      .borderRadius(28)
      .onClick(() => {
        this.showCustomBrew = !this.showCustomBrew
      })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  header() {
    Row() {
      Column() {
        Text('ZenBrew')
          .fontSize(46)
          .fontWeight(FontWeight.Bold)
          .fontColor('#121212')
          .lineHeight(54)
        Text('Mindful Steeping Guide')
          .fontSize(28)
          .fontColor('#777777')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank().layoutWeight(1)

      Button({ type: ButtonType.Circle }) {
        Text('⚙')
          .fontSize(42)
          .fontColor('#121212')
      }
      .width(68)
      .height(68)
      .backgroundColor(Color.Transparent)
      .onClick(() => {
        this.showCustomBrew = !this.showCustomBrew
      })
    }
    .width('100%')
    .padding({ left: 32, right: 26, top: 20, bottom: 8 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  tipCard() {
    Row() {
      Column() {
        Text('Tip of the day')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#898989')
          .margin({ bottom: 20 })

        Text('Use filtered water for a')
          .fontSize(32)
          .fontWeight(FontWeight.Medium)
          .fontColor('#171717')
        Text('purer taste profile.')
          .fontSize(32)
          .fontWeight(FontWeight.Medium)
          .fontColor('#171717')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(96)
          .height(96)
          .fill(Color.White)
        Text('i')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#8A8A8A')
      }
      .margin({ left: 18 })
    }
    .width('100%')
    .height(248)
    .padding({ left: 48, right: 48 })
    .backgroundColor('#F0F0F0')
    .borderRadius(40)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  teaCard(tea: TeaGuide) {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(98)
          .height(98)
          .fill(Color.White)
          .stroke(tea.color)
          .strokeWidth(4)
          .opacity(0.32)
        Text(tea.name.substring(0, 1))
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor(tea.color)
      }
      .width(112)
      .height(112)

      Column() {
        Text(tea.name)
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor('#171717')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(tea.origin)
          .fontSize(25)
          .fontColor('#777777')
          .margin({ top: 10 })

        Row({ space: 16 }) {
          this.badge(tea.temp)
          this.badge(tea.time)
        }
        .margin({ top: 22 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 20 })

      Button({ type: ButtonType.Circle }) {
        Text('▶')
          .fontSize(25)
          .fontColor('#171717')
          .margin({ left: 4 })
      }
      .width(96)
      .height(96)
      .backgroundColor(Color.White)
      .border({ width: 2, color: '#E0E0E0' })
      .onClick(() => {
        this.showCustomBrew = !this.showCustomBrew
      })
    }
    .width('100%')
    .height(228)
    .padding({ left: 30, right: 24 })
    .backgroundColor('#FAFAFA')
    .border({ width: 2, color: '#EEEEEE' })
    .borderRadius(30)
  }

  @Builder
  badge(label: string) {
    Text(label)
      .fontSize(22)
      .fontColor('#171717')
      .padding({ left: 12, right: 12, top: 10, bottom: 10 })
      .backgroundColor(Color.White)
      .border({ width: 2, color: '#E0E0E0' })
      .borderRadius(12)
  }
}
