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
      this.BrewingVisualizer(this.selectedTea)
        .margin({ top: 32, bottom: 40 })

      // Stats Row
      this.BrewStatsRow(this.selectedTea)
        .margin({ bottom: 40 })

      // Selection List
      this.TeaSelector(teaPresets, this.selectedTea, (preset: TeaPreset) => {
        this.selectedTea = preset;
      })

      // Spacer - push button to bottom
      Blank()

      // Action Button
      this.StartBrewButton()
        .margin({ bottom: 8 })
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

      Image($r('sys.media.ohos_ic_public_settings'))
        .width(32)
        .height(32)
        .fillColor(Color.Black)
        .objectFit(ImageFit.Contain)
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
          .fontWeight(FontWeight.SemiBold)
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
      this.InfoItem("TEMP", tea.temp)
        .layoutWeight(1)

      this.VerticalDivider()

      this.InfoItem("TIME", tea.time)
        .layoutWeight(1)

      this.VerticalDivider()

      this.InfoItem("AMOUNT", "250ml")
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
    .onClick(() => {
      // No-op
    })
  }
}

// Path commands for heart shape
function getHeartPath(): string {
  // Draw a heart shape
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
