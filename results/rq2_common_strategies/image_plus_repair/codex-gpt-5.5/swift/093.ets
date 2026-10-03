interface TeaPreset {
  name: string
  temp: string
  time: string
  description: string
}

@Entry
@Component
struct TeaMasterApp {
  private readonly teaPresets: TeaPreset[] = [
    {
      name: 'Sencha',
      temp: '70°C',
      time: '1-2 min',
      description: 'Japanese green tea, grassy and fresh.'
    },
    {
      name: 'Earl Grey',
      temp: '98°C',
      time: '3-4 min',
      description: 'Black tea flavored with bergamot oil.'
    },
    {
      name: 'Oolong',
      temp: '85°C',
      time: '3-5 min',
      description: 'Traditional semi-oxidized Chinese tea.'
    },
    {
      name: 'Chamomile',
      temp: '100°C',
      time: '5 min',
      description: 'Herbal infusion, calming and caffeine-free.'
    },
    {
      name: 'Matcha',
      temp: '80°C',
      time: 'Whisk',
      description: 'Finely ground powder of green tea leaves.'
    }
  ]

  @State private selectedTeaIndex: number = 0

  private get selectedTea(): TeaPreset {
    return this.teaPresets[this.selectedTeaIndex]
  }

  build() {
    Column() {
      this.header()

      Blank()
        .height(32)

      this.visualizer()

      Blank()
        .height(40)

      this.statsRow()

      Blank()
        .height(40)

      this.teaSelector()

      Blank()
        .layoutWeight(1)

      this.startButton()
    }
    .width('100%')
    .height('100%')
    .padding({
      top: 24,
      left: 24,
      right: 24,
      bottom: 32
    })
    .backgroundColor(Color.White)
  }

  @Builder
  header() {
    Row() {
      Column() {
        Text('Tea Master')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .alignSelf(ItemAlign.Start)

        Text('Perfect brew, every time')
          .fontSize(12)
          .fontColor('#929297')
          .margin({ top: 4 })
          .alignSelf(ItemAlign.Start)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Text('⚙')
        .fontSize(34)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Bold)
        .width(42)
        .height(42)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  visualizer() {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(220)
        .height(220)
        .fill('#F5F5F5')

      Column() {
        Text('♥')
          .fontSize(68)
          .fontColor('#8D6E63')
          .fontFamily('sans-serif')
          .height(76)
          .textAlign(TextAlign.Center)

        Text(this.selectedTea.name)
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height(220)
  }

  @Builder
  statsRow() {
    Row() {
      this.infoItem('TEMP', this.selectedTea.temp)

      Blank()
        .layoutWeight(1)

      this.divider()

      Blank()
        .layoutWeight(1)

      this.infoItem('TIME', this.selectedTea.time)

      Blank()
        .layoutWeight(1)

      this.divider()

      Blank()
        .layoutWeight(1)

      this.infoItem('AMOUNT', '250ml')
    }
    .width('100%')
    .height(80)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  infoItem(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#929297')
        .letterSpacing(1.5)

      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  divider() {
    Divider()
      .vertical(true)
      .strokeWidth(1)
      .color('#E0E0E0')
      .height(40)
  }

  @Builder
  teaSelector() {
    Column() {
      Text('Select Variety')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .alignSelf(ItemAlign.Start)
        .margin({ left: 4 })

      Scroll() {
        Row() {
          ForEach(this.teaPresets, (tea: TeaPreset, index: number) => {
            Button(tea.name)
              .fontSize(14)
              .fontWeight(index === this.selectedTeaIndex ? FontWeight.Bold : FontWeight.Regular)
              .fontColor(index === this.selectedTeaIndex ? Color.White : Color.Black)
              .backgroundColor(index === this.selectedTeaIndex ? Color.Black : Color.White)
              .border({
                width: 1,
                color: index === this.selectedTeaIndex ? Color.Black : '#E0E0E0'
              })
              .borderRadius(28)
              .height(48)
              .padding({ left: 20, right: 20 })
              .margin({ right: 12 })
              .onClick(() => {
                this.selectedTeaIndex = index
              })
          })
        }
        .padding({ left: 4, right: 4 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
      .height(56)
      .margin({ top: 12 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  startButton() {
    Button() {
      Row() {
        Text('▶')
          .fontSize(21)
          .fontColor(Color.White)

        Text('START TIMER')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ left: 8 })
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height(56)
    .backgroundColor(Color.Black)
    .borderRadius(16)
    .padding(0)
  }
}
