import { display } from '@kit.ArkUI';

// Domain Models
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

// Sample Data
const teaPresets: TeaPreset[] = [
  new TeaPreset("Sencha", "70°C", "1-2 min", "Japanese green tea, grassy and fresh."),
  new TeaPreset("Earl Grey", "98°C", "3-4 min", "Black tea flavored with bergamot oil."),
  new TeaPreset("Oolong", "85°C", "3-5 min", "Traditional semi-oxidized Chinese tea."),
  new TeaPreset("Chamomile", "100°C", "5 min", "Herbal infusion, calming and caffeine-free."),
  new TeaPreset("Matcha", "80°C", "Whisk", "Finely ground powder of green tea leaves.")
];

@Entry
@Component
struct TeaMasterApp {
  @State selectedTea: TeaPreset = teaPresets[0];

  build() {
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
    .padding(24)
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text("Tea Master")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text("Perfect brew, every time")
          .fontSize(12)
          .fontColor(Color.Gray)
      }
      .alignItems(HorizontalAlign.Start)

      Blank().layoutWeight(1)

      Button() {
        Text("⚙")
          .fontSize(24)
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

  @Builder
  BrewingVisualizer(tea: TeaPreset) {
    Stack() {
      Column() {
        Text("♥")
          .fontSize(48)
          .fontColor('#8D6E63')
        Blank().height(8)
        Text(tea.name)
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width(180)
    .height(180)
    .borderRadius(90)
    .backgroundColor('#F5F5F5')
    .alignContent(Alignment.Center)
  }

  @Builder
  BrewStatsRow(tea: TeaPreset) {
    Row() {
      this.InfoItem("TEMP", tea.temp)
      this.VerticalDivider()
      this.InfoItem("TIME", tea.time)
      this.VerticalDivider()
      this.InfoItem("AMOUNT", "250ml")
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  @Builder
  VerticalDivider() {
    Divider()
      .vertical(true)
      .height(40)
      .width(1)
      .color('#E0E0E0')
  }

  @Builder
  InfoItem(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Gray)
        .letterSpacing(1)
      Blank().height(4)
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  TeaSelector() {
    Column() {
      Text("Select Variety")
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ left: 4, bottom: 12 })

      Scroll() {
        Row() {
          ForEach(teaPresets, (preset: TeaPreset) => {
            this.TeaChip(preset, preset.name === this.selectedTea.name)
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

  @Builder
  TeaChip(preset: TeaPreset, isSelected: boolean) {
    Row() {
      Text(preset.name)
        .fontSize(14)
        .fontWeight(isSelected ? FontWeight.Bold : FontWeight.Normal)
        .fontColor(isSelected ? Color.White : Color.Black)
    }
    .padding({ left: 20, right: 20, top: 10, bottom: 10 })
    .backgroundColor(isSelected ? Color.Black : Color.White)
    .borderRadius(50)
    .border({
      width: 1,
      color: isSelected ? Color.Black : '#E0E0E0'
    })
    .margin({ right: 12 })
    .onClick(() => {
      this.selectedTea = preset;
    })
  }

  @Builder
  StartBrewButton() {
    Row() {
      Text("▶")
        .fontSize(20)
        .fontColor(Color.White)
      Blank().width(8)
      Text("START TIMER")
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.Black)
    .borderRadius(16)
    .onClick(() => {
      // No-op
    })
  }
}