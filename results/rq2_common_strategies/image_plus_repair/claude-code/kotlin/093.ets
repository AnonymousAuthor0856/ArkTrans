// Tea Master - Tea Brewing Timer App
// Converted from Kotlin Compose to ArkTS

@Observed
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
      // Header
      this.HeaderSection()

      // Visualization Circle
      Column() {
        this.BrewingVisualizer(this.selectedTea)
      }
      .margin({ top: 32, bottom: 40 })

      // Stats Row
      Column() {
        this.BrewStatsRow(this.selectedTea)
      }
      .margin({ bottom: 40 })

      // Selection List
      this.TeaSelector(teaPresets, this.selectedTea, (preset: TeaPreset) => {
        this.selectedTea = preset;
      })

      // Spacer - push button to bottom
      Blank()

      // Action Button
      this.StartBrewButton()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text("Tea Master")
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text("Perfect brew, every time")
          .fontSize(20)
          .fontColor(0xFF888888)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      // Settings gear icon using Path
      Path()
        .commands(getSettingsPath())
        .width(32)
        .height(32)
        .fill(Color.Black)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BrewingVisualizer(tea: TeaPreset) {
    Stack({ alignContent: Alignment.Center }) {
      // Inner Circle
      Circle()
        .width(280)
        .height(280)
        .fill(0xFFF5F5F5)

      Column() {
        // Heart icon - using Path to draw a heart shape
        Path()
          .commands(getHeartPath())
          .width(64)
          .height(64)
          .fill(0xFF8D6E63)
          .margin({ bottom: 12 })

        Text(tea.name)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(320)
    .height(320)
  }

  @Builder
  BrewStatsRow(tea: TeaPreset) {
    Row() {
      Column() {
        this.InfoItem("TEMP", tea.temp)
      }
      .layoutWeight(1)

      this.VerticalDivider()

      Column() {
        this.InfoItem("TIME", tea.time)
      }
      .layoutWeight(1)

      this.VerticalDivider()

      Column() {
        this.InfoItem("AMOUNT", "250ml")
      }
      .layoutWeight(1)
    }
    .width('100%')
  }

  @Builder
  VerticalDivider() {
    Divider()
      .vertical(true)
      .height(40)
      .color(0xFFE0E0E0)
      .strokeWidth(1)
  }

  @Builder
  InfoItem(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(0xFF888888)
        .letterSpacing(1)
      Text(value)
        .fontSize(36)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
    .width('100%')
  }

  @Builder
  TeaSelector(presets: TeaPreset[], selected: TeaPreset, onSelect: (preset: TeaPreset) => void) {
    Column() {
      Text("Select Variety")
        .fontSize(28)
        .fontColor(Color.Black)
        .margin({ left: 4, bottom: 12 })

      List({ space: 12 }) {
        ForEach(presets, (preset: TeaPreset) => {
          ListItem() {
            this.TeaChip(preset, preset.name === selected.name, () => {
              onSelect(preset);
            })
          }
        }, (preset: TeaPreset) => preset.name)
      }
      .listDirection(Axis.Horizontal)
      .edgeEffect(EdgeEffect.None)
      .scrollBar(BarState.Off)
      .padding({ left: 4, right: 4 })
      .height(56)
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  TeaChip(preset: TeaPreset, isSelected: boolean, onClick: () => void) {
    Text(preset.name)
      .fontSize(28)
      .fontColor(isSelected ? Color.White : Color.Black)
      .fontWeight(isSelected ? FontWeight.Bold : FontWeight.Normal)
      .padding({ left: 28, right: 28, top: 14, bottom: 14 })
      .backgroundColor(isSelected ? Color.Black : Color.White)
      .border({
        width: 1,
        color: isSelected ? Color.Black : 0xFFE0E0E0
      })
      .borderRadius(999)
      .onClick(() => {
        onClick();
      })
  }

  @Builder
  StartBrewButton() {
    Row() {
      // Play arrow icon using Path
      Path()
        .commands(getPlayArrowPath())
        .width(24)
        .height(24)
        .fill(Color.White)

      Text("START TIMER")
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .margin({ left: 12 })
    }
    .width('100%')
    .height(64)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.Black)
    .borderRadius(24)
    .margin({ bottom: 8 })
    .onClick(() => {
      // No-op
    })
  }
}

// Path commands for heart shape
function getHeartPath(): string {
  const commands = `
    M 24 44
    C 10 34, 0 24, 0 14
    C 0 6, 6 0, 14 0
    C 18 0, 22 2, 24 6
    C 26 2, 30 0, 34 0
    C 42 0, 48 6, 48 14
    C 48 24, 38 34, 24 44
    Z
  `;
  return commands;
}

// Path commands for play arrow shape
function getPlayArrowPath(): string {
  const commands = `
    M 8 5
    L 8 19
    L 19 12
    Z
  `;
  return commands;
}

// Path commands for settings gear shape
function getSettingsPath(): string {
  const commands = `
    M 12 15.5
    A 2.5 2.5 0 1 0 12 10.5
    A 2.5 2.5 0 1 0 12 15.5
    Z
    M 19.43 12.98
    C 19.47 12.67 19.5 12.34 19.5 12
    C 19.5 11.66 19.47 11.33 19.43 11.02
    L 21.54 9.37
    C 21.73 9.22 21.82 8.95 21.73 8.71
    L 19.73 5.27
    C 19.62 5.08 19.4 4.97 19.16 5
    L 16.77 5.6
    C 16.34 5.25 15.87 4.96 15.37 4.74
    L 14.84 2.18
    C 14.8 1.93 14.59 1.75 14.34 1.75
    H 9.66
    C 9.41 1.75 9.2 1.93 9.16 2.18
    L 8.63 4.74
    C 8.13 4.96 7.66 5.25 7.23 5.6
    L 4.84 5
    C 4.6 4.97 4.38 5.08 4.27 5.27
    L 2.27 8.71
    C 2.18 8.95 2.27 9.22 2.46 9.37
    L 4.57 11.02
    C 4.53 11.33 4.5 11.66 4.5 12
    C 4.5 12.34 4.53 12.67 4.57 12.98
    L 2.46 14.63
    C 2.27 14.78 2.18 15.05 2.27 15.29
    L 4.27 18.73
    C 4.38 18.92 4.6 19.03 4.84 19
    L 7.23 18.4
    C 7.66 18.75 8.13 19.04 8.63 19.26
    L 9.16 21.82
    C 9.2 22.07 9.41 22.25 9.66 22.25
    H 14.34
    C 14.59 22.25 14.8 22.07 14.84 21.82
    L 15.37 19.26
    C 15.87 19.04 16.34 18.75 16.77 18.4
    L 19.16 19
    C 19.4 19.03 19.62 18.92 19.73 18.73
    L 21.73 15.29
    C 21.82 15.05 21.73 14.78 21.54 14.63
    Z
  `;
  return commands;
}
