// TeaMasterApp.ets
import { UIAbility } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct TeaMasterApp {
  build() {
    Column() {
      ContentView()
    }
    .backgroundColor(Color.White)
    .width('100%')
    .height('100%')
  }
}

@Component
struct ContentView {
  build() {
    Column() {
      TeaBrewingScreen()
    }
    .backgroundColor(Color.White)
    .width('100%')
    .height('100%')
  }
}

// MARK: - Models
interface TeaPreset {
  id: number;
  name: string;
  temp: string;
  time: string;
  description: string;
}

// MARK: - Main Screen
@Component
struct TeaBrewingScreen {
  // Sample Data
  private teaPresets: TeaPreset[] = [
    { id: 1, name: "Sencha", temp: "70°C", time: "1-2 min", description: "Japanese green tea, grassy and fresh." },
    { id: 2, name: "Earl Grey", temp: "98°C", time: "3-4 min", description: "Black tea flavored with bergamot oil." },
    { id: 3, name: "Oolong", temp: "85°C", time: "3-5 min", description: "Traditional semi-oxidized Chinese tea." },
    { id: 4, name: "Chamomile", temp: "100°C", time: "5 min", description: "Herbal infusion, calming and caffeine-free." },
    { id: 5, name: "Matcha", temp: "80°C", time: "Whisk", description: "Finely ground powder of green tea leaves." }
  ];

  @State selectedTeaIndex: number = 0;

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
        selectedIndex: $selectedTeaIndex
      })
      .padding({ left: 24, right: 24 })

      Blank()

      // Action Button
      StartBrewButton()
        .padding({ left: 24, right: 24, bottom: 32 })
    }
    .backgroundColor(Color.White)
    .width('100%')
    .height('100%')
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

      Blank()

      Button() {
        Image($r('app.media.settings_icon'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
      }
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
  }
}

@Component
struct BrewingVisualizer {
  @Prop tea: TeaPreset;

  build() {
    Column() {
      Image($r('app.media.heart_icon'))
        .width(48)
        .height(48)
        .objectFit(ImageFit.Contain)
        .fillColor('#8D6E63')

      Text(this.tea.name)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 8 })
    }
    .width(220)
    .height(220)
    .borderRadius(110)
    .backgroundColor('#F5F5F5')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct BrewStatsRow {
  @Prop tea: TeaPreset;

  build() {
    Row() {
      InfoItem({ label: "TEMP", value: this.tea.temp })
      
      Divider()
        .vertical(true)
        .color('#E0E0E0')
        .height(40)
        .margin({ left: 12, right: 12 })

      InfoItem({ label: "TIME", value: this.tea.time })
      
      Divider()
        .vertical(true)
        .color('#E0E0E0')
        .height(40)
        .margin({ left: 12, right: 12 })

      InfoItem({ label: "AMOUNT", value: "250ml" })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct InfoItem {
  @Prop label: string;
  @Prop value: string;

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
  @Prop presets: TeaPreset[];
  @Link selectedIndex: number;

  build() {
    Column() {
      Text("Select Variety")
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ bottom: 12 })

      Scroll() {
        Row() {
          ForEach(this.presets, (tea: TeaPreset, index: number) => {
            TeaChip({
              name: tea.name,
              isSelected: index === this.selectedIndex,
              onClick: () => {
                this.selectedIndex = index;
              }
            })
            .margin({ right: 12 })
          })
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct TeaChip {
  @Prop name: string;
  @Prop isSelected: boolean;
  @Prop onClick: () => void;

  build() {
    Button() {
      Text(this.name)
        .fontSize(14)
        .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Regular)
        .fontColor(this.isSelected ? Color.White : Color.Black)
    }
    .backgroundColor(this.isSelected ? Color.Black : Color.White)
    .borderWidth(1)
    .borderColor(this.isSelected ? Color.Black : '#E0E0E0')
    .borderRadius(20)
    .padding({ left: 20, right: 20, top: 10, bottom: 10 })
    .onClick(() => {
      this.onClick();
    })
  }
}

@Component
struct StartBrewButton {
  build() {
    Button() {
      Row() {
        Image($r('app.media.play_icon'))
          .width(20)
          .height(20)
          .objectFit(ImageFit.Contain)
          .fillColor(Color.White)

        Text("START TIMER")
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ left: 8 })
      }
      .justifyContent(FlexAlign.Center)
    }
    .backgroundColor(Color.Black)
    .borderRadius(16)
    .height(56)
    .width('100%')
  }
}