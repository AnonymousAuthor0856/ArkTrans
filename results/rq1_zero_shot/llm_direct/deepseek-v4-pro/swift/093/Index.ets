@Entry
@Component
struct TeaMasterApp {
  build() {
    Column() {
      TeaBrewingScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

// Models
class TeaPreset {
  id: string = ''
  name: string = ''
  temp: string = ''
  time: string = ''
  description: string = ''

  constructor(name: string, temp: string, time: string, description: string) {
    this.id = `${Date.now()}_${Math.random()}`
    this.name = name
    this.temp = temp
    this.time = time
    this.description = description
  }
}

@Component
struct TeaBrewingScreen {
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
      // Header
      HeaderSection()
        .padding({ top: 24, left: 24, right: 24 })

      Blank().height(32)

      // Visualization
      BrewingVisualizer({ tea: this.teaPresets[this.selectedTeaIndex] })

      Blank().height(40)

      // Stats Row
      BrewStatsRow({ tea: this.teaPresets[this.selectedTeaIndex] })
        .padding({ left: 24, right: 24 })

      Blank().height(40)

      // Selection List
      TeaSelector({
        presets: this.teaPresets,
        selectedIndex: this.selectedTeaIndex,
        onSelect: (index: number) => {
          this.selectedTeaIndex = index
        }
      })
        .padding({ left: 24, right: 24 })

      Blank()

      // Action Button
      StartBrewButton()
        .padding({ left: 24, right: 24, bottom: 32 })
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
      Column() {
        Text('Tea Master')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text('Perfect brew, every time')
          .fontSize(12)
          .fontColor(Color.Gray)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button() {
        // Settings action
      }
      .width(40)
      .height(40)
      .backgroundColor(Color.Transparent)
      .type(ButtonType.Normal)
      .borderRadius(20)
      .stateEffect(false)
      .onClick(() => {})
      .backgroundImage($r('sys.symbol.gearshape_fill'))
      .backgroundImageSize({ width: 24, height: 24 })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BrewingVisualizer {
  tea: TeaPreset = new TeaPreset('', '', '', '')

  build() {
    Stack() {
      Circle()
        .width(220)
        .height(220)
        .fill('#F5F5F5')

      Column() {
        Image($r('sys.symbol.heart_fill'))
          .width(48)
          .height(48)
          .fillColor('#8D6E63')

        Text(this.tea.name)
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(220)
    .height(220)
    .alignContent(Alignment.Center)
  }
}

@Component
struct BrewStatsRow {
  tea: TeaPreset = new TeaPreset('', '', '', '')

  build() {
    Row() {
      InfoItem({ label: 'TEMP', value: this.tea.temp })
        .layoutWeight(1)

      VerticalDivider()

      InfoItem({ label: 'TIME', value: this.tea.time })
        .layoutWeight(1)

      VerticalDivider()

      InfoItem({ label: 'AMOUNT', value: '250ml' })
        .layoutWeight(1)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct VerticalDivider {
  build() {
    Rect()
      .width(1)
      .height(40)
      .fill('#E0E0E0')
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
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Gray)
        .letterSpacing(1)

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct TeaSelector {
  presets: TeaPreset[] = []
  selectedIndex: number = 0
  onSelect: (index: number) => void = () => {}

  build() {
    Column() {
      Text('Select Variety')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ left: 4, bottom: 12 })
        .alignSelf(ItemAlign.Start)

      Scroll() {
        Row() {
          ForEach(this.presets, (tea: TeaPreset, index: number) => {
            TeaChip({
              name: tea.name,
              isSelected: index === this.selectedIndex,
              onClick: () => {
                this.onSelect(index)
              }
            })
              .margin({ right: 12 })
          })
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
  name: string = ''
  isSelected: boolean = false
  onClick: () => void = () => {}

  build() {
    Button() {
      Text(this.name)
        .fontSize(14)
        .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Regular)
        .fontColor(this.isSelected ? Color.White : Color.Black)
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })
    }
    .type(ButtonType.Normal)
    .borderRadius(25)
    .backgroundColor(this.isSelected ? Color.Black : Color.White)
    .border({
      width: 1,
      color: this.isSelected ? Color.Black : '#E0E0E0',
      style: BorderStyle.Solid
    })
    .stateEffect(false)
    .onClick(() => {
      this.onClick()
    })
  }
}

@Component
struct StartBrewButton {
  build() {
    Button() {
      Row() {
        Image($r('sys.symbol.play_fill'))
          .width(20)
          .height(20)
          .fillColor(Color.White)

        Text('START TIMER')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ left: 8 })
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .type(ButtonType.Normal)
    .width('100%')
    .height(56)
    .backgroundColor(Color.Black)
    .borderRadius(16)
    .stateEffect(false)
    .onClick(() => {})
  }
}