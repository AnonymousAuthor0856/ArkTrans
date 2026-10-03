class TeaPreset {
  name: string
  temp: string
  time: string
  description: string

  constructor(name: string, temp: string, time: string, description: string) {
    this.name = name
    this.temp = temp
    this.time = time
    this.description = description
  }
}

@Entry
@Component
struct TeaMasterApp {
  @State selectedTeaIndex: number = 0

  private teaPresets: TeaPreset[] = [
    new TeaPreset('Sencha', '70°C', '1-2 min', 'Japanese green tea, grassy and fresh.'),
    new TeaPreset('Earl Grey', '98°C', '3-4 min', 'Black tea flavored with bergamot oil.'),
    new TeaPreset('Oolong', '85°C', '3-5 min', 'Traditional semi-oxidized Chinese tea.'),
    new TeaPreset('Chamomile', '100°C', '5 min', 'Herbal infusion, calming and caffeine-free.'),
    new TeaPreset('Matcha', '80°C', 'Whisk', 'Finely ground powder of green tea leaves.')
  ]

  build() {
    Column() {
      HeaderSection()

      Blank()
        .height(32)

      BrewingVisualizer({
        tea: this.teaPresets[this.selectedTeaIndex]
      })

      Blank()
        .height(40)

      BrewStatsRow({
        tea: this.teaPresets[this.selectedTeaIndex]
      })

      Blank()
        .height(40)

      TeaSelector({
        presets: this.teaPresets,
        selectedIndex: $selectedTeaIndex
      })

      Blank()
        .layoutWeight(1)

      StartBrewButton()
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
          .fontColor('#8E8E93')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Button({ type: ButtonType.Normal, stateEffect: false }) {
        Text('⚙')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)
      .padding(0)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BrewingVisualizer {
  @Prop tea: TeaPreset

  build() {
    Stack() {
      Column()
        .width(220)
        .height(220)
        .borderRadius(110)
        .backgroundColor('#F5F5F5')

      Column({ space: 8 }) {
        Text('♥')
          .fontSize(64)
          .fontColor('#8D6E63')

        Text(this.tea.name)
          .fontSize(22)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width(220)
    .height(220)
    .alignContent(Alignment.Center)
  }
}

@Component
struct BrewStatsRow {
  @Prop tea: TeaPreset

  build() {
    Row() {
      InfoItem({
        label: 'TEMP',
        value: this.tea.temp
      })
      .layoutWeight(1)

      VerticalDivider()

      InfoItem({
        label: 'TIME',
        value: this.tea.time
      })
      .layoutWeight(1)

      VerticalDivider()

      InfoItem({
        label: 'AMOUNT',
        value: '250ml'
      })
      .layoutWeight(1)
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
  @Prop label: string
  @Prop value: string

  build() {
    Column({ space: 4 }) {
      Text(this.label)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#8E8E93')
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
  presets: TeaPreset[] = []
  @Link selectedIndex: number

  build() {
    Column({ space: 12 }) {
      Text('Select Variety')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .padding({ left: 4 })
        .width('100%')
        .textAlign(TextAlign.Start)

      Scroll() {
        Row({ space: 12 }) {
          ForEach(
            this.presets,
            (preset: TeaPreset, index: number) => {
              TeaChip({
                name: preset.name,
                isSelected: index === this.selectedIndex,
                onClick: () => {
                  this.selectedIndex = index
                }
              })
            },
            (preset: TeaPreset) => preset.name
          )
        }
        .padding({ left: 4, right: 4 })
      }
      .width('100%')
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.None)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct TeaChip {
  @Prop name: string
  @Prop isSelected: boolean
  onClick: () => void = () => {
  }

  build() {
    Button({ type: ButtonType.Normal, stateEffect: false }) {
      Text(this.name)
        .fontSize(14)
        .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Regular)
        .fontColor(this.isSelected ? Color.White : Color.Black)
    }
    .height(46)
    .padding({
      left: 20,
      right: 20
    })
    .backgroundColor(this.isSelected ? Color.Black : Color.White)
    .borderRadius(23)
    .border({
      width: 1,
      color: this.isSelected ? Color.Black : '#E0E0E0'
    })
    .onClick(() => {
      this.onClick()
    })
  }
}

@Component
struct StartBrewButton {
  build() {
    Button({ type: ButtonType.Normal, stateEffect: false }) {
      Row({ space: 8 }) {
        Text('▶')
          .fontSize(22)
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
    .width('100%')
    .height(56)
    .backgroundColor(Color.Black)
    .borderRadius(16)
    .padding(0)
  }
}