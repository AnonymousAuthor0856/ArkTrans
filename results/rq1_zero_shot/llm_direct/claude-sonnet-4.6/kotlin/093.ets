import { router } from '@kit.ArkUI';

// --- Domain Models ---
interface TeaPreset {
  name: string;
  temp: string;
  time: string;
  description: string;
}

// --- Sample Data ---
const teaPresets: TeaPreset[] = [
  { name: "Sencha", temp: "70°C", time: "1-2 min", description: "Japanese green tea, grassy and fresh." },
  { name: "Earl Grey", temp: "98°C", time: "3-4 min", description: "Black tea flavored with bergamot oil." },
  { name: "Oolong", temp: "85°C", time: "3-5 min", description: "Traditional semi-oxidized Chinese tea." },
  { name: "Chamomile", temp: "100°C", time: "5 min", description: "Herbal infusion, calming and caffeine-free." },
  { name: "Matcha", temp: "80°C", time: "Whisk", description: "Finely ground powder of green tea leaves." }
];

// --- Header Section ---
@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text("Tea Master")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Text("Perfect brew, every time")
          .fontSize(12)
          .fontColor(Color.Gray)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button({ type: ButtonType.Circle }) {
        Image($r('app.media.ic_settings'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(40)
      .height(40)
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

// --- Brewing Visualizer ---
@Component
struct BrewingVisualizer {
  @Prop tea: TeaPreset = teaPresets[0];

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(220)
        .height(220)
        .fill('#00000000')

      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(180)
          .height(180)
          .fill('#F5F5F5')

        Column() {
          Image($r('app.media.ic_favorite'))
            .width(48)
            .height(48)
            .fillColor('#8D6E63')

          Text(this.tea.name)
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
            .margin({ top: 8 })
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
      }
      .width(180)
      .height(180)
    }
    .width(220)
    .height(220)
  }
}

// --- Info Item ---
@Component
struct InfoItem {
  @Prop label: string = '';
  @Prop value: string = '';

  build() {
    Column() {
      Text(this.label)
        .fontSize(10)
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

// --- Vertical Divider ---
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

// --- Brew Stats Row ---
@Component
struct BrewStatsRow {
  @Prop tea: TeaPreset = teaPresets[0];

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

// --- Tea Chip ---
@Component
struct TeaChip {
  @Prop preset: TeaPreset = teaPresets[0];
  @Prop isSelected: boolean = false;
  onClickCallback: () => void = () => {};

  build() {
    Text(this.preset.name)
      .fontSize(14)
      .fontColor(this.isSelected ? Color.White : Color.Black)
      .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal)
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      .backgroundColor(this.isSelected ? Color.Black : Color.White)
      .borderRadius(50)
      .border({
        width: 1,
        color: this.isSelected ? Color.Black : '#E0E0E0'
      })
      .onClick(() => {
        this.onClickCallback();
      })
  }
}

// --- Tea Selector ---
@Component
struct TeaSelector {
  @Prop presets: TeaPreset[] = [];
  @Prop selected: TeaPreset = teaPresets[0];
  onSelect: (preset: TeaPreset) => void = () => {};

  build() {
    Column() {
      Text("Select Variety")
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ left: 4, bottom: 12 })

      Scroll() {
        Row({ space: 12 }) {
          ForEach(this.presets, (preset: TeaPreset) => {
            TeaChip({
              preset: preset,
              isSelected: preset.name === this.selected.name,
              onClickCallback: () => {
                this.onSelect(preset);
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
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

// --- Start Brew Button ---
@Component
struct StartBrewButton {
  build() {
    Button() {
      Row({ space: 8 }) {
        Image($r('app.media.ic_play_arrow'))
          .width(20)
          .height(20)
          .fillColor(Color.White)

        Text("START TIMER")
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(56)
    .backgroundColor(Color.Black)
    .borderRadius(16)
    .shadow({ radius: 0, color: Color.Transparent, offsetX: 0, offsetY: 0 })
    .onClick(() => {})
  }
}

// --- Main Tea Brewing Screen ---
@Component
struct TeaBrewingScreen {
  @State selectedTea: TeaPreset = teaPresets[0];

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
          this.selectedTea = preset;
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

// --- Entry Point ---
@Entry
@Component
struct Index {
  build() {
    TeaBrewingScreen()
  }
}