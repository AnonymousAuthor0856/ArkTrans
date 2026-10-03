import { LengthMetrics } from '@kit.ArkUI'

// --- Domain Models ---
interface TeaPreset {
  name: string
  temp: string
  time: string
  description: string
}

// --- Sample Data ---
const teaPresets: TeaPreset[] = [
  { name: "Sencha", temp: "70°C", time: "1-2 min", description: "Japanese green tea, grassy and fresh." },
  { name: "Earl Grey", temp: "98°C", time: "3-4 min", description: "Black tea flavored with bergamot oil." },
  { name: "Oolong", temp: "85°C", time: "3-5 min", description: "Traditional semi-oxidized Chinese tea." },
  { name: "Chamomile", temp: "100°C", time: "5 min", description: "Herbal infusion, calming and caffeine-free." },
  { name: "Matcha", temp: "80°C", time: "Whisk", description: "Finely ground powder of green tea leaves." }
]

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text("Tea Master")
          .fontSize(24)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)
        Text("Perfect brew, every time")
          .fontSize(12)
          .fontColor(Color.Gray)
      }
      .alignItems(HorizontalAlign.Start)

      Button({ type: ButtonType.Circle }) {
        Text("⚙")
          .fontSize(20)
          .fontColor(Color.Black)
      }
      .width(40)
      .height(40)
      .backgroundColor(Color.White)
      .border({ width: 1, color: '#EEEEEE' })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BrewingVisualizer {
  @Prop tea: TeaPreset = teaPresets[0]

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Stack({ alignContent: Alignment.Center }) {
        Column() {
          Text("♥")
            .fontSize(48)
            .fontColor('#8D6E63')
          Blank().height(8)
          Text(this.tea.name)
            .fontSize(20)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(180)
      .height(180)
      .borderRadius(90)
      .backgroundColor('#F5F5F5')
    }
    .width(220)
    .height(220)
  }
}

@Component
struct VerticalDivider {
  build() {
    Column()
      .height(40)
      .width(1)
      .backgroundColor('#E0E0E0')
  }
}

@Component
struct InfoItem {
  @Prop label: string = ''
  @Prop value: string = ''

  build() {
    Column() {
      Text(this.label)
        .fontSize(10)
        .fontColor(Color.Gray)
        .fontWeight(FontWeight.Bold)
        .letterSpacing(1)
      Blank().height(4)
      Text(this.value)
        .fontSize(16)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Medium)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct BrewStatsRow {
  @Prop tea: TeaPreset = teaPresets[0]

  build() {
    Row() {
      InfoItem({ label: "TEMP", value: this.tea.temp })
      VerticalDivider()
      InfoItem({ label: "TIME", value: this.tea.time })
      VerticalDivider()
      InfoItem({ label: "AMOUNT", value: "250ml" })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TeaChip {
  @Prop preset: TeaPreset = teaPresets[0]
  @Prop isSelected: boolean = false
  onSelectCallback: () => void = () => {}

  build() {
    Text(this.preset.name)
      .fontSize(14)
      .fontColor(this.isSelected ? Color.White : Color.Black)
      .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal)
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      .backgroundColor(this.isSelected ? Color.Black : Color.White)
      .borderRadius(50)
      .border({ width: 1, color: this.isSelected ? Color.Black : '#E0E0E0' })
      .onClick(() => {
        this.onSelectCallback()
      })
  }
}

@Component
struct TeaSelector {
  @Prop presets: TeaPreset[] = []
  @Prop selected: TeaPreset = teaPresets[0]
  onSelect: (preset: TeaPreset) => void = () => {}

  build() {
    Column() {
      Text("Select Variety")
        .fontSize(14)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Medium)
        .margin({ left: 4, bottom: 12 })

      Scroll() {
        Row({ space: 12 }) {
          ForEach(this.presets, (preset: TeaPreset) => {
            TeaChip({
              preset: preset,
              isSelected: preset.name === this.selected.name,
              onSelectCallback: () => {
                this.onSelect(preset)
              }
            })
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
struct StartBrewButton {
  build() {
    Button() {
      Row() {
        Text("▶")
          .fontSize(16)
          .fontColor(Color.White)
        Blank().width(8)
        Text("START TIMER")
          .fontSize(14)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(56)
    .backgroundColor(Color.Black)
    .borderRadius(16)
    .type(ButtonType.Normal)
  }
}

@Entry
@Component
struct TeaBrewingScreen {
  @State selectedTea: TeaPreset = teaPresets[0]

  build() {
    Column() {
      HeaderSection()

      Blank().height(32)

      BrewingVisualizer({ tea: this.selectedTea })

      Blank().height(40)

      BrewStatsRow({ tea: this.selectedTea })

      Blank().height(40)

      TeaSelector({
        presets: teaPresets,
        selected: this.selectedTea,
        onSelect: (preset: TeaPreset) => {
          this.selectedTea = preset
        }
      })

      Blank()

      StartBrewButton()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .padding(24)
    .alignItems(HorizontalAlign.Center)
  }
}