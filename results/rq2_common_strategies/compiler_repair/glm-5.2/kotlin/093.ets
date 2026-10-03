// --- Domain Models ---
class TeaPreset {
  name: string;
  temp: string;
  time: string;
  description: string;

  constructor(name: string, temp: string, time: string, description: string) {
    this.name = name;
    this.temp = temp;
    this.time = time;
    this.description = description;
  }
}

// --- Sample Data ---
const teaPresets: TeaPreset[] = [
  new TeaPreset("Sencha", "70°C", "1-2 min", "Japanese green tea, grassy and fresh."),
  new TeaPreset("Earl Grey", "98°C", "3-4 min", "Black tea flavored with bergamot oil."),
  new TeaPreset("Oolong", "85°C", "3-5 min", "Traditional semi-oxidized Chinese tea."),
  new TeaPreset("Chamomile", "100°C", "5 min", "Herbal infusion, calming and caffeine-free."),
  new TeaPreset("Matcha", "80°C", "Whisk", "Finely ground powder of green tea leaves.")
];

@Entry
@Component
struct TeaMasterTheme {
  @State selectedTeaIndex: number = 0;

  get selectedTea(): TeaPreset {
    return teaPresets[this.selectedTeaIndex];
  }

  onSelectTea(index: number) {
    this.selectedTeaIndex = index;
  }

  build() {
    Column() {
      this.TeaBrewingScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder TeaBrewingScreen() {
    Column() {
      this.HeaderSection()

      Blank().height(32)

      this.BrewingVisualizer(this.selectedTea)

      Blank().height(40)

      this.BrewStatsRow(this.selectedTea)

      Blank().height(40)

      this.TeaSelector()

      Blank().layoutWeight(1)

      this.StartBrewButton()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .padding(24)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder HeaderSection() {
    Row() {
      Column() {
        Text("Tea Master")
          .fontSize(24)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)
        Text("Perfect brew, every time")
          .fontSize(12)
          .fontColor(Color.Gray)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Image($r('sys.media.ohos_ic_public_settings'))
        .width(24)
        .height(24)
        .fillColor(Color.Black)
        .onClick(() => {})
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder BrewingVisualizer(tea: TeaPreset) {
    Column() {
      Column() {
        Text("♥")
          .fontSize(48)
          .fontColor('#8D6E63')
        Text(tea.name)
          .fontSize(20)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Medium)
          .margin({ top: 8 })
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
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder BrewStatsRow(tea: TeaPreset) {
    Row() {
      this.InfoItem("TEMP", tea.temp)
      this.VerticalDivider()
      this.InfoItem("TIME", tea.time)
      this.VerticalDivider()
      this.InfoItem("AMOUNT", "250ml")
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
  }

  @Builder VerticalDivider() {
    Column()
      .width(1)
      .height(40)
      .backgroundColor('#E0E0E0')
  }

  @Builder InfoItem(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(10)
        .fontColor(Color.Gray)
        .fontWeight(FontWeight.Bold)
      Text(value)
        .fontSize(16)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Medium)
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder TeaSelector() {
    Column() {
      Text("Select Variety")
        .fontSize(14)
        .fontColor(Color.Black)
        .margin({ left: 4, bottom: 12 })
        .alignSelf(ItemAlign.Start)

      Scroll() {
        Row({ space: 12 }) {
          ForEach(teaPresets, (preset: TeaPreset, index: number) => {
            this.TeaChip(preset, index === this.selectedTeaIndex, () => {
              this.onSelectTea(index);
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

  @Builder TeaChip(preset: TeaPreset, isSelected: boolean, onClick: () => void) {
    Text(preset.name)
      .fontSize(14)
      .fontColor(isSelected ? Color.White : Color.Black)
      .fontWeight(isSelected ? FontWeight.Bold : FontWeight.Normal)
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      .backgroundColor(isSelected ? Color.Black : Color.White)
      .borderRadius(50)
      .border({ width: 1, color: isSelected ? Color.Black : '#E0E0E0' })
      .onClick(() => onClick())
  }

  @Builder StartBrewButton() {
    Button() {
      Row() {
        Text("▶")
          .fontSize(16)
          .fontColor(Color.White)
        Text("START TIMER")
          .fontSize(14)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 8 })
      }
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(56)
    .backgroundColor(Color.Black)
    .borderRadius(16)
    .onClick(() => {})
  }
}