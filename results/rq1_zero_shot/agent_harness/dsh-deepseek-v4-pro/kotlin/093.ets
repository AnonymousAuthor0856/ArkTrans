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

@Entry
@Component
struct Index {
  @State selectedIndex: number = 0

  build() {
    Column() {
      HeaderSection()

      Blank().height(32)

      BrewingVisualizer({ name: teaPresets[this.selectedIndex].name })

      Blank().height(40)

      BrewStatsRow({ temp: teaPresets[this.selectedIndex].temp, time: teaPresets[this.selectedIndex].time })

      Blank().height(40)

      TeaSelector({
        selected: teaPresets[this.selectedIndex].name,
        onSelect: (name: string) => {
          for (let i = 0; i < teaPresets.length; i++) {
            if (teaPresets[i].name === name) {
              this.selectedIndex = i
              break
            }
          }
        }
      })

      Blank().layoutWeight(1)

      StartBrewButton()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('Tea Master').fontSize(24).fontColor('#000000').fontWeight(FontWeight.Bold)
        Text('Perfect brew, every time').fontSize(12).fontColor('#9E9E9E')
      }
      Stack() {
        Text('⚙').fontSize(24).fontColor('#000000')
      }
      .width(48).height(48)
      .onClick(() => {})
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BrewingVisualizer {
  @Prop name: string = ''

  build() {
    Stack() {
      Stack() {
        Column() {
          Text('♥').fontSize(48).fontColor('#8D6E63')
          Blank().height(8)
          Text(this.name).fontSize(20).fontColor('#000000').fontWeight(FontWeight.Bold)
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(180).height(180)
      .borderRadius(90)
      .backgroundColor('#F5F5F5')
    }
    .width(220).height(220)
    .alignContent(Alignment.Center)
  }
}

@Component
struct BrewStatsRow {
  @Prop temp: string = ''
  @Prop time: string = ''

  build() {
    Row() {
      InfoItem({ label: 'TEMP', value: this.temp })
      VerticalDivider()
      InfoItem({ label: 'TIME', value: this.time })
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
  @Prop label: string = ''
  @Prop value: string = ''

  build() {
    Column() {
      Text(this.label).fontSize(10).fontColor('#9E9E9E').fontWeight(FontWeight.Bold).letterSpacing(1)
      Blank().height(4)
      Text(this.value).fontSize(16).fontColor('#000000').fontWeight(FontWeight.Medium)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct TeaSelector {
  @Prop selected: string = ''
  onSelect: (name: string) => void = () => {}

  build() {
    Column() {
      Text('Select Variety')
        .fontSize(14)
        .fontColor('#000000')
        .margin({ left: 4, bottom: 12 })

      List({ space: 12 }) {
        ForEach(teaPresets, (preset: TeaPreset) => {
          ListItem() {
            TeaChip({ name: preset.name, isSelected: preset.name === this.selected, onClick: () => { this.onSelect(preset.name) } })
          }
        }, (preset: TeaPreset) => preset.name)
      }
      .listDirection(Axis.Horizontal)
      .scrollBar(BarState.Off)
      .height(40)
    }
    .width('100%')
  }
}

@Component
struct TeaChip {
  @Prop name: string = ''
  @Prop isSelected: boolean = false
  onClick: () => void = () => {}

  build() {
    const containerColor = this.isSelected ? '#000000' : '#FFFFFF'
    const contentColor = this.isSelected ? '#FFFFFF' : '#000000'
    const borderColor = this.isSelected ? '#000000' : '#E0E0E0'

    Button({ type: ButtonType.Capsule }) {
      Text(this.name)
        .fontSize(14)
        .fontColor(contentColor)
        .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal)
    }
    .backgroundColor(containerColor)
    .border({ width: 1, color: borderColor })
    .height(36)
    .padding({ left: 20, right: 20 })
    .onClick(() => { this.onClick() })
  }
}

@Component
struct StartBrewButton {
  build() {
    Button() {
      Row() {
        Text('▶').fontSize(20).fontColor('#FFFFFF')
        Blank().width(8)
        Text('START TIMER').fontSize(14).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
      }
    }
    .width('100%')
    .height(56)
    .backgroundColor('#000000')
    .borderRadius(16)
    .onClick(() => {})
  }
}
