interface TeaPreset {
  name: string
  temp: string
  time: string
  description: string
}

@Entry
@Component
struct TeaMasterApp {
  @State selectedTeaIndex: number = 0

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
    Stack() {
      Column() {
        HeaderSection()
          .padding({ top: 24, left: 24, right: 24 })

        Blank()
          .height(32)

        BrewingVisualizer({ tea: this.teaPresets[this.selectedTeaIndex] })

        Blank()
          .height(40)

        BrewStatsRow({ tea: this.teaPresets[this.selectedTeaIndex] })
          .padding({ left: 24, right: 24 })

        Blank()
          .height(40)

        TeaSelector({
          presets: this.teaPresets,
          selectedIndex: $selectedTeaIndex
        })
          .padding({ left: 24, right: 24 })

        Blank()
          .layoutWeight(1)

        StartBrewButton()
          .padding({ left: 24, right: 24, bottom: 32 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column({ space: 4 }) {
        Text('Tea Master')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Text('Perfect brew, every time')
          .fontSize(12)
          .fontColor(Color.Gray)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Text('⚙')
        .fontSize(24)
        .fontColor(Color.Black)
        .onClick(() => {
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BrewingVisualizer {
  @Prop tea: TeaPreset = {
    name: '',
    temp: '',
    time: '',
    description: ''
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(220)
        .height(220)
        .fill('#F5F5F5')

      Column({ space: 8 }) {
        Text('♥')
          .fontSize(48)
          .fontColor('#8D6E63')

        Text(this.tea.name)
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(220)
    .height(220)
  }
}

@Component
struct BrewStatsRow {
  @Prop tea: TeaPreset = {
    name: '',
    temp: '',
    time: '',
    description: ''
  }

  build() {
    Row() {
      InfoItem({
        label: 'TEMP',
        value: this.tea.temp
      })

      Blank()
        .layoutWeight(1)

      VerticalDivider()

      Blank()
        .layoutWeight(1)

      InfoItem({
        label: 'TIME',
        value: this.tea.time
      })

      Blank()
        .layoutWeight(1)

      VerticalDivider()

      Blank()
        .layoutWeight(1)

      InfoItem({
        label: 'AMOUNT',
        value: '250ml'
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct VerticalDivider {
  build() {
    Column()
      .width(1)
      .height(40)
      .backgroundColor('#E0E0E0')
  }
}

@Component
struct InfoItem {
  @Prop label: string = ''
  @Prop value: string = ''

  build() {
    Column({ space: 4 }) {
      Text(this.label)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Gray)
        .letterSpacing(1)

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct TeaSelector {
  @Prop presets: TeaPreset[] = []
  @Link selectedIndex: number

  build() {
    Column({ space: 12 }) {
      Text('Select Variety')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .padding({ left: 4 })

      Scroll() {
        Row({ space: 12 }) {
          ForEach(this.presets, (preset: TeaPreset, index: number) => {
            TeaChip({
              name: preset.name,
              isSelected: index === this.selectedIndex,
              onClick: () => {
                this.selectedIndex = index
              }
            })
          }, (preset: TeaPreset, index: number) => `${index}-${preset.name}`)
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
}

@Component
struct TeaChip {
  @Prop name: string = ''
  @Prop isSelected: boolean = false
  onClick: () => void = () => {
  }

  build() {
    Text(this.name)
      .fontSize(14)
      .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Regular)
      .fontColor(this.isSelected ? Color.White : Color.Black)
      .padding({
        left: 20,
        right: 20,
        top: 10,
        bottom: 10
      })
      .backgroundColor(this.isSelected ? Color.Black : Color.White)
      .border({
        width: 1,
        color: this.isSelected ? Color.Black : '#E0E0E0'
      })
      .borderRadius(24)
      .onClick(() => {
        this.onClick()
      })
  }
}

@Component
struct StartBrewButton {
  build() {
    Button() {
      Row({ space: 8 }) {
        Text('▶')
          .fontSize(20)
          .fontColor(Color.White)

        Text('START TIMER')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .type(ButtonType.Normal)
    .width('100%')
    .height(56)
    .backgroundColor(Color.Black)
    .borderRadius(16)
    .onClick(() => {
    })
  }
}