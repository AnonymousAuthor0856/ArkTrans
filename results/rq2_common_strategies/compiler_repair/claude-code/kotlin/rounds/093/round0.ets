@Entry
@Component
struct TeaBrewingApp {
  build() {
    Stack() {
      TeaBrewingScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

interface TeaPreset {
  name: string
  temp: string
  time: string
  description: string
}

const teaPresets: TeaPreset[] = [
  { name: 'Sencha', temp: '70°C', time: '1-2 min', description: 'Japanese green tea, grassy and fresh.' },
  { name: 'Earl Grey', temp: '98°C', time: '3-4 min', description: 'Black tea flavored with bergamot oil.' },
  { name: 'Oolong', temp: '85°C', time: '3-5 min', description: 'Traditional semi-oxidized Chinese tea.' },
  { name: 'Chamomile', temp: '100°C', time: '5 min', description: 'Herbal infusion, calming and caffeine-free.' },
  { name: 'Matcha', temp: '80°C', time: 'Whisk', description: 'Finely ground powder of green tea leaves.' }
]

@Component
struct TeaBrewingScreen {
  @State selectedTea: TeaPreset = teaPresets[0]

  build() {
    Column() {
      HeaderSection()

      BrewingVisualizer({ tea: this.selectedTea })
        .margin({ top: 32 })

      BrewStatsRow({ tea: this.selectedTea })
        .margin({ top: 40 })

      TeaSelector({
        presets: teaPresets,
        selected: this.selectedTea,
        onSelect: (preset: TeaPreset) => {
          this.selectedTea = preset
        }
      })
        .margin({ top: 40 })

      Blank()
        .layoutWeight(1)

      StartBrewButton()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
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
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)
        Text('Perfect brew, every time')
          .fontSize(14)
          .fontColor(Color.Gray)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Image($r('sys.media.ohos_ic_public_settings'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .type(ButtonType.Circle)
      .backgroundColor(Color.Transparent)
      .width(48)
      .height(48)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct BrewingVisualizer {
  tea: TeaPreset

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Column() {
        Image($r('sys.media.ohos_ic_public_heart'))
          .width(48)
          .height(48)
          .fillColor('#8D6E63')
        Text(this.tea.name)
          .fontSize(22)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Medium)
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(180)
    .height(180)
    .borderRadius(90)
    .backgroundColor('#F5F5F5')
  }
}

@Component
struct BrewStatsRow {
  tea: TeaPreset

  build() {
    Row() {
      InfoItem({ label: 'TEMP', value: this.tea.temp })
      VerticalDivider()
      InfoItem({ label: 'TIME', value: this.tea.time })
      VerticalDivider()
      InfoItem({ label: 'AMOUNT', value: '250ml' })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct VerticalDivider {
  build() {
    Divider()
      .vertical(true)
      .height(40)
      .width(1)
      .color('#E0E0E0')
  }
}

@Component
struct InfoItem {
  label: string
  value: string

  build() {
    Column() {
      Text(this.label)
        .fontSize(12)
        .fontColor(Color.Gray)
        .fontWeight(FontWeight.Bold)
      Text(this.value)
        .fontSize(18)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Medium)
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct TeaSelector {
  presets: TeaPreset[]
  selected: TeaPreset
  onSelect: (preset: TeaPreset) => void

  build() {
    Column() {
      Text('Select Variety')
        .fontSize(16)
        .fontColor(Color.Black)
        .padding({ left: 4, bottom: 12 })

      List({ space: 12 }) {
        ForEach(this.presets, (preset: TeaPreset) => {
          ListItem() {
            TeaChip({
              preset: preset,
              isSelected: preset.name === this.selected.name,
              onClick: () => this.onSelect(preset)
            })
          }
        }, (preset: TeaPreset) => preset.name)
      }
      .width('100%')
      .height(56)
      .listDirection(Axis.Horizontal)
      .padding({ left: 4, right: 4 })
      .scrollBar(BarState.Off)
    }
    .width('100%')
  }
}

@Component
struct TeaChip {
  preset: TeaPreset
  isSelected: boolean
  onClick: () => void

  build() {
    Text(this.preset.name)
      .fontSize(14)
      .fontColor(this.isSelected ? Color.White : Color.Black)
      .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal)
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      .backgroundColor(this.isSelected ? Color.Black : Color.White)
      .border({
        width: 1,
        color: this.isSelected ? Color.Black : '#E0E0E0'
      })
      .borderRadius(50)
      .onClick(() => this.onClick())
  }
}

@Component
struct StartBrewButton {
  build() {
    Button() {
      Row() {
        Image($r('sys.media.ohos_ic_public_play'))
          .width(20)
          .height(20)
          .fillColor(Color.White)
        Text('START TIMER')
          .fontSize(14)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 8 })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(56)
    .backgroundColor(Color.Black)
    .borderRadius(16)
  }
}
