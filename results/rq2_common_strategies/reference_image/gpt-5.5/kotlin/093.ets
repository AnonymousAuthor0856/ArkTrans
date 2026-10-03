interface TeaPreset {
  name: string
  temp: string
  time: string
  description: string
}

@Entry
@Component
struct Index {
  @State selectedIndex: number = 0

  private teaPresets: TeaPreset[] = [
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

  build() {
    Column() {
      this.HeaderSection()

      Blank()
        .height(32)

      this.BrewingVisualizer(this.teaPresets[this.selectedIndex])

      Blank()
        .height(40)

      this.BrewStatsRow(this.teaPresets[this.selectedIndex])

      Blank()
        .height(40)

      this.TeaSelector()

      Blank()
        .layoutWeight(1)

      this.StartBrewButton()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Tea Master')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Text('Perfect brew, every time')
          .fontSize(14)
          .fontColor('#888888')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Text('⚙')
        .fontSize(34)
        .fontColor(Color.Black)
        .width(48)
        .height(48)
        .textAlign(TextAlign.Center)
        .onClick(() => {
        })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BrewingVisualizer(tea: TeaPreset) {
    Stack({ alignContent: Alignment.Center }) {
      Column() {
        Text('♥')
          .fontSize(64)
          .fontColor('#8D6E63')
          .height(70)
          .textAlign(TextAlign.Center)

        Blank()
          .height(8)

        Text(tea.name)
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width(180)
      .height(180)
      .borderRadius(90)
      .backgroundColor('#F5F5F5')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width(220)
    .height(220)
  }

  @Builder
  BrewStatsRow(tea: TeaPreset) {
    Row() {
      this.InfoItem('TEMP', tea.temp)

      this.VerticalDivider()

      this.InfoItem('TIME', tea.time)

      this.VerticalDivider()

      this.InfoItem('AMOUNT', '250ml')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  VerticalDivider() {
    Column()
      .width(1)
      .height(40)
      .backgroundColor('#E0E0E0')
  }

  @Builder
  InfoItem(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(13)
        .fontWeight(FontWeight.Bold)
        .fontColor('#888888')
        .letterSpacing(1)

      Blank()
        .height(4)

      Text(value)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  TeaSelector() {
    Column() {
      Text('Select Variety')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .padding({ left: 4, bottom: 12 })

      Scroll() {
        Row({ space: 12 }) {
          ForEach(this.teaPresets, (preset: TeaPreset, index: number) => {
            this.TeaChip(preset, index)
          }, (preset: TeaPreset) => preset.name)
        }
        .padding({ left: 4, right: 4 })
      }
      .width('100%')
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  TeaChip(preset: TeaPreset, index: number) {
    Text(preset.name)
      .height(40)
      .padding({ left: 20, right: 20 })
      .fontSize(16)
      .fontWeight(index === this.selectedIndex ? FontWeight.Bold : FontWeight.Regular)
      .fontColor(index === this.selectedIndex ? Color.White : Color.Black)
      .backgroundColor(index === this.selectedIndex ? Color.Black : Color.White)
      .borderRadius(20)
      .border({
        width: 1,
        color: index === this.selectedIndex ? Color.Black : '#E0E0E0'
      })
      .textAlign(TextAlign.Center)
      .onClick(() => {
        this.selectedIndex = index
      })
  }

  @Builder
  StartBrewButton() {
    Button() {
      Row() {
        Text('▶')
          .fontSize(20)
          .fontColor(Color.White)

        Blank()
          .width(8)

        Text('START TIMER')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(56)
    .backgroundColor(Color.Black)
    .borderRadius(16)
    .stateEffect(false)
    .onClick(() => {
    })
  }
}