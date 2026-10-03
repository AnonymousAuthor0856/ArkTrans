// TeaMasterApp.ets
import { Length, ResourceStr } from '@ohos.arkui.UIComponent';

// MARK: - Models
interface TeaPreset {
  name: string;
  temp: string;
  time: string;
  description: string;
}

// MARK: - Main Screen
@Entry
@Component
struct TeaBrewingScreen {
  private teaPresets: TeaPreset[] = [
    { name: "Sencha", temp: "70°C", time: "1-2 min", description: "Japanese green tea, grassy and fresh." },
    { name: "Earl Grey", temp: "98°C", time: "3-4 min", description: "Black tea flavored with bergamot oil." },
    { name: "Oolong", temp: "85°C", time: "3-5 min", description: "Traditional semi-oxidized Chinese tea." },
    { name: "Chamomile", temp: "100°C", time: "5 min", description: "Herbal infusion, calming and caffeine-free." },
    { name: "Matcha", temp: "80°C", time: "Whisk", description: "Finely ground powder of green tea leaves." }
  ];

  @State private selectedTeaIndex: number = 0;

  build() {
    Stack() {
      Column() {
        // Header
        HeaderSection()
          .padding({ top: 24, left: 24, right: 24 })

        // Visualization
        BrewingVisualizer({ tea: this.teaPresets[this.selectedTeaIndex] })
          .margin({ top: 32 })

        // Stats Row
        BrewStatsRow({ tea: this.teaPresets[this.selectedTeaIndex] })
          .padding({ left: 24, right: 24 })
          .margin({ top: 40 })

        // Selection List
        TeaSelector({
          presets: this.teaPresets,
          selectedIndex: this.selectedTeaIndex,
          onIndexChange: (newIndex: number) => {
            this.selectedTeaIndex = newIndex;
          }
        })
          .padding({ left: 24, right: 24 })
          .margin({ top: 40 })

        // Action Button
        StartBrewButton()
          .padding({ left: 24, right: 24, bottom: 32 })
          .margin({ top: 40 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

// MARK: - Components

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
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank() // Spacer

      Button() {
        Text("⚙️").fontSize(24).fontColor(Color.Black)
      }
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
  }
}

@Component
struct BrewingVisualizer {
  private tea: TeaPreset;

  build() {
    Stack() {
      Circle({ width: 220, height: 220 })
        .fillColor("#F5F5F5")

      Column() {
        Text("❤️")
          .fontSize(48)
          .fontColor("#8D6E63")
        Text(this.tea.name)
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
          .margin({ top: 8 })
      }
    }
  }
}

@Component
struct BrewStatsRow {
  private tea: TeaPreset;

  build() {
    Row() {
      InfoItem({ label: "TEMP", value: this.tea.temp })

      Blank().layoutWeight(1) // Spacer

      VerticalDivider()

      Blank().layoutWeight(1) // Spacer

      InfoItem({ label: "TIME", value: this.tea.time })

      Blank().layoutWeight(1) // Spacer

      VerticalDivider()

      Blank().layoutWeight(1) // Spacer

      InfoItem({ label: "AMOUNT", value: "250ml" })
    }
    .width('100%')
  }
}

@Component
struct VerticalDivider {
  build() {
    Rectangle()
      .width(1)
      .height(40)
      .fillColor("#E0E0E0")
  }
}

@Component
struct InfoItem {
  private label: string;
  private value: string;

  build() {
    Column() {
      Text(this.label)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Gray)
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 4 })
    }
  }
}

@Component
struct TeaSelector {
  private presets: TeaPreset[];
  private selectedIndex: number;
  private onIndexChange: (index: number) => void;

  build() {
    Column() {
      Text("Select Variety")
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ bottom: 12, left: 4 })

      Scroll() {
        Row({ space: 12 }) {
          ForEach(this.presets, (preset: TeaPreset, index: number) => {
            TeaChip({
              name: preset.name,
              isSelected: index === this.selectedIndex,
              onClick: () => {
                this.onIndexChange(index);
              }
            })
          }, (preset: TeaPreset) => preset.name)
        }
        .padding({ left: 4, right: 4 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct TeaChip {
  private name: string;
  private isSelected: boolean;
  private onClick: () => void;

  build() {
    Button(this.onClick) {
      Text(this.name)
        .fontSize(14)
        .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal)
        .fontColor(this.isSelected ? Color.White : Color.Black)
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })
    }
    .backgroundColor(this.isSelected ? Color.Black : Color.White)
    .borderRadius(20)
    .border({ width: 1, color: this.isSelected ? Color.Black : "#E0E0E0" })
  }
}

@Component
struct StartBrewButton {
  build() {
    Button() {
      Row({ space: 8 }) {
        Text("▶️").fontSize(20).fontColor(Color.White)
        Text("START TIMER")
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(56)
    .backgroundColor(Color.Black)
    .borderRadius(16)
  }
}