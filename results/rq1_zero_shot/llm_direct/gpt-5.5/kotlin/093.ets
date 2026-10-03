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

const teaPresets: TeaPreset[] = [
  new TeaPreset('Sencha', '70°C', '1-2 min', 'Japanese green tea, grassy and fresh.'),
  new TeaPreset('Earl Grey', '98°C', '3-4 min', 'Black tea flavored with bergamot oil.'),
  new TeaPreset('Oolong', '85°C', '3-5 min', 'Traditional semi-oxidized Chinese tea.'),
  new TeaPreset('Chamomile', '100°C', '5 min', 'Herbal infusion, calming and caffeine-free.'),
  new TeaPreset('Matcha', '80°C', 'Whisk', 'Finely ground powder of green tea leaves.')
]

@Entry
@Component
struct TeaBrewingScreen {
  @State selectedIndex: number = 0

  build() {
    Column() {
      HeaderSection()

      Blank()
        .height(32)

      BrewingVisualizer({
        tea: teaPresets[this.selectedIndex]
      })

      Blank()
        .height(40)

      BrewStatsRow({
        tea: teaPresets[this.selectedIndex]
      })

      Blank()
        .height(40)

      TeaSelector({
        presets: teaPresets,
        selectedIndex: this.selectedIndex,
        onSelect: (index: number) => {
          this.selectedIndex = index
        }
      })

      Blank()
        .layoutWeight(1)

      StartBrewButton()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('Tea Master')
          .fontSize(28)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)

        Text('Perfect brew, every time')
          .fontSize(12)
          .fontColor('#808080')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Button({ type: ButtonType.Circle }) {
        Text('⚙')
          .fontSize(24)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)
      .onClick(() => {
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BrewingVisualizer {
  tea: TeaPreset = teaPresets[0]

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Column() {
        Text('♥')
          .fontSize(48)
          .fontColor('#8D6E63')

        Blank()
          .height(8)

        Text(this.tea.name)
          .fontSize(22)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Medium)
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
}

@Component
struct BrewStatsRow {
  tea: TeaPreset = teaPresets[0]

  build() {
    Row() {
      InfoItem({
        label: 'TEMP',
        value: this.tea.temp
      })

      VerticalDivider()

      InfoItem({
        label: 'TIME',
        value: this.tea.time
      })

      VerticalDivider()

      InfoItem({
        label: 'AMOUNT',
        value: '250ml'
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct VerticalDivider {
  build() {
    Blank()
      .width(1)
      .height(40)
      .backgroundColor('#E0E0E0')
  }
}

@Component
struct InfoItem {
  label: string = ''
  value: string = ''

  build() {
    Column() {
      Text(this.label)
        .fontSize(11)
        .fontColor('#808080')
        .fontWeight(FontWeight.Bold)
        .letterSpacing(1)

      Blank()
        .height(4)

      Text(this.value)
        .fontSize(18)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Medium)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct TeaSelector {
  presets: TeaPreset[] = []
  selectedIndex: number = 0
  onSelect: (index: number) => void = () => {
  }

  build() {
    Column() {
      Text('Select Variety')
        .fontSize(14)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Medium)
        .margin({ left: 4, bottom: 12 })
        .alignSelf(ItemAlign.Start)

      Scroll() {
        Row({ space: 12 }) {
          ForEach(this.presets, (preset: TeaPreset, index: number) => {
            TeaChip({
              preset: preset,
              isSelected: index === this.selectedIndex,
              onClick: () => {
                this.onSelect(index)
              }
            })
          }, (preset: TeaPreset) => preset.name)
        }
        .padding({ left: 4, right: 4 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct TeaChip {
  preset: TeaPreset = teaPresets[0]
  isSelected: boolean = false
  onClick: () => void = () => {
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text(this.preset.name)
        .fontSize(14)
        .fontColor(this.isSelected ? Color.White : Color.Black)
        .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal)
    }
    .padding({ left: 20, right: 20, top: 10, bottom: 10 })
    .backgroundColor(this.isSelected ? Color.Black : Color.White)
    .border({
      width: 1,
      color: this.isSelected ? Color.Black : '#E0E0E0'
    })
    .borderRadius(50)
    .onClick(() => {
      this.onClick()
    })
  }
}

@Component
struct StartBrewButton {
  build() {
    Button({ type: ButtonType.Normal }) {
      Row() {
        Text('▶')
          .fontSize(20)
          .fontColor(Color.White)

        Blank()
          .width(8)

        Text('START TIMER')
          .fontSize(14)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
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