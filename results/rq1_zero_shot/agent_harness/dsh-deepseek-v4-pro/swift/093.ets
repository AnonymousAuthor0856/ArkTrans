// Translated from 093.swift (Tea Master App)

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
struct Index {
  build() {
    TeaBrewingScreen()
  }
}

@Component
struct TeaBrewingScreen {
  teaPresets: TeaPreset[] = [
    new TeaPreset('Sencha', '70°C', '1-2 min', 'Japanese green tea, grassy and fresh.'),
    new TeaPreset('Earl Grey', '98°C', '3-4 min', 'Black tea flavored with bergamot oil.'),
    new TeaPreset('Oolong', '85°C', '3-5 min', 'Traditional semi-oxidized Chinese tea.'),
    new TeaPreset('Chamomile', '100°C', '5 min', 'Herbal infusion, calming and caffeine-free.'),
    new TeaPreset('Matcha', '80°C', 'Whisk', 'Finely ground powder of green tea leaves.')
  ]
  @State selectedTeaIndex: number = 0

  build() {
    Stack() {
      Column() {
        HeaderSection()
          .padding({ top: 24, left: 24, right: 24 })

        Blank().height(32)

        BrewingVisualizer({ tea: this.teaPresets[this.selectedTeaIndex] })

        Blank().height(40)

        BrewStatsRow({ tea: this.teaPresets[this.selectedTeaIndex] })
          .padding({ left: 24, right: 24 })

        Blank().height(40)

        TeaSelector({
          presets: this.teaPresets,
          selectedIndex: $this.selectedTeaIndex
        })
        .padding({ left: 24, right: 24 })

        Blank()

        StartBrewButton()
          .padding({ left: 24, right: 24, bottom: 32 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
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
          .fontColor('#000000')
        Text('Perfect brew, every time')
          .fontSize(12)
          .fontColor('#808080')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Text('⚙')
          .fontSize(24)
          .fontColor('#000000')
      }
      .onClick(() => {})
    }
    .width('100%')
  }
}

@Component
struct BrewingVisualizer {
  @Prop tea: TeaPreset = new TeaPreset('', '', '', '')

  build() {
    Stack() {
      Circle()
        .fill('#F5F5F5')
        .width(220)
        .height(220)

      Column({ space: 8 }) {
        Text('♥')
          .fontSize(48)
          .fontColor('#8C6E63')
          .width(48)
          .height(48)
        Text(this.tea.name)
          .fontSize(22)
          .fontWeight(FontWeight.Semibold)
          .fontColor('#000000')
      }
    }
  }
}

@Component
struct BrewStatsRow {
  @Prop tea: TeaPreset = new TeaPreset('', '', '', '')

  build() {
    Row() {
      InfoItem({ label: 'TEMP', value: this.tea.temp })
      Blank()
      VerticalDivider()
      Blank()
      InfoItem({ label: 'TIME', value: this.tea.time })
      Blank()
      VerticalDivider()
      Blank()
      InfoItem({ label: 'AMOUNT', value: '250ml' })
    }
    .width('100%')
  }
}

@Component
struct VerticalDivider {
  build() {
    Divider({ vertical: true })
      .color('#E0E0E0')
      .height(40)
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
        .fontColor('#808080')
        .letterSpacing(1)
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
    }
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
        .fontColor('#000000')
        .padding({ left: 4 })

      Scroll() {
        Row({ space: 12 }) {
          ForEach(this.presets, (preset: TeaPreset, index: number) => {
            TeaChip({
              name: preset.name,
              isSelected: index == this.selectedIndex,
              onClick: () => { this.selectedIndex = index }
            })
          }, (preset: TeaPreset) => preset.name)
        }
        .padding({ left: 4, right: 4 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct TeaChip {
  @Prop name: string = ''
  @Prop isSelected: boolean = false
  onClick: () => void = () => {}

  build() {
    Button() {
      Text(this.name)
        .fontSize(14)
        .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Regular)
        .fontColor(this.isSelected ? '#FFFFFF' : '#000000')
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })
        .backgroundColor(this.isSelected ? '#000000' : '#FFFFFF')
        .borderRadius(20)
        .border({
          width: 1,
          color: this.isSelected ? '#000000' : '#E0E0E0',
          radius: 20
        })
    }
    .onClick(() => { this.onClick() })
  }
}

@Component
struct StartBrewButton {
  build() {
    Button() {
      Row({ space: 8 }) {
        Text('▶')
          .fontSize(20)
          .fontColor('#FFFFFF')
        Text('START TIMER')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
      }
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(56)
    .backgroundColor('#000000')
    .borderRadius(16)
    .onClick(() => {})
  }
}
