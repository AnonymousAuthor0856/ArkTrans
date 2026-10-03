// Build configuration: ohpm
// dependencies:
//   "@ohos/hypium": "1.0.6"
//   "@ohos/arkui": "1.0.6"

import { Length, ResourceStr } from '@ohos.arkui.UIContext';

class BrewStep {
  title: string;
  description: string;
  waterTarget: string;
  time: string;
  isCompleted: boolean;

  constructor(title: string, description: string, waterTarget: string, time: string, isCompleted: boolean) {
    this.title = title;
    this.description = description;
    this.waterTarget = waterTarget;
    this.time = time;
    this.isCompleted = isCompleted;
  }
}

@Entry
@Component
struct MainActivity {
  private steps: BrewStep[] = [
    new BrewStep("Bloom", "Wet the grounds evenly to release CO2.", "60g", "0:00 - 0:45", true),
    new BrewStep("First Pour", "Pour slowly in concentric circles.", "180g", "0:45 - 1:30", false),
    new BrewStep("Second Pour", "Gently pour remaining water.", "300g", "1:30 - 2:15", false),
    new BrewStep("Draw Down", "Wait for the water to drain completely.", "300g", "2:15 - 3:00", false)
  ];

  build() {
    Column() {
      // Top Bar
      Row() {
        Column() {
          Text("V60 Guide")
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor("#000000")
            .margin({ bottom: 4 })
          Text("Ethiopia Yirgacheffe")
            .fontSize(14)
            .fontColor("#808080")
        }
        .alignItems(HorizontalAlign.Start)

        Blank() // Pushes icon to the right

        Image($r("sys.media.ohos_ic_public_settings"))
          .width(24)
          .height(24)
          .fillColor("#000000")
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 48, bottom: 16 })
      .justifyContent(FlexAlign.SpaceBetween)

      // Main Content
      Scroll() {
        Column() {
          // Main Timer Display
          Column() {
            Text("00:45")
              .fontSize(80)
              .fontWeight(FontWeight.Lighter)
              .fontColor("#000000")
              .margin({ bottom: 8 })
            Text("Target: 300g")
              .fontSize(14)
              .fontColor("#808080")
          }
          .width('100%')
          .padding({ top: 24, bottom: 24 })
          .alignItems(HorizontalAlign.Center)

          // Stats Row
          Row() {
            this.StatItem("Ratio", "1:15", $r("sys.media.ohos_ic_public_add"))
            this.StatItem("Beans", "20g", $r("sys.media.ohos_ic_public_heart"))
            this.StatItem("Temp", "93°C", $r("sys.media.ohos_ic_public_refresh"))
          }
          .width('100%')
          .padding({ bottom: 32 })
          .justifyContent(FlexAlign.SpaceEvenly)

          // Divider
          Divider().color("#F0F0F0").strokeWidth(1).width('100%')

          Text("Brewing Steps")
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor("#000000")
            .margin({ top: 24, bottom: 16 })

          // Steps List
          ForEach(this.steps, (step: BrewStep, index: number) => {
            this.StepCard(index + 1, step)
          })

          // Bottom Spacing
          Blank().height(80)
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Control Area
      Row() {
        Button("Start Brewing") {
          Image($r("sys.media.ohos_ic_public_play")).width(20).height(20).fillColor("#FFFFFF").margin({ right: 8 })
          Text("Start Brewing").fontSize(16).fontWeight(FontWeight.Bold).fontColor("#FFFFFF")
        }
        .width('100%')
        .height(64)
        .backgroundColor("#000000")
        .borderRadius(16)
        .onClick(() => {})
      }
      .width('100%')
      .padding({ left: 24, right: 24, bottom: 24 })
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor("#FFFFFF")
  }

  @Builder
  StatItem(label: string, value: string, icon: Resource) {
    Column() {
      // Icon Container
      Column() {
        Image(icon)
          .width(20)
          .height(20)
          .fillColor("#808080")
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: "#E0E0E0" })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor("#000000")
        .margin({ top: 8 })

      Text(label)
        .fontSize(12)
        .fontColor("#808080")
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  StepCard(number: number, step: BrewStep) {
    Row() {
      // Timeline Indicator
      Column() {
        // Circle Indicator
        Column() {
          if (step.isCompleted) {
            Image($r("sys.media.ohos_ic_public_check"))
              .width(14)
              .height(14)
              .fillColor("#FFFFFF")
          } else {
            Text(number.toString())
              .fontSize(12)
              .fontColor("#FFFFFF")
          }
        }
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(step.isCompleted ? "#000000" : "#E0E0E0")
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        // Vertical Line
        Column() {
          Divider().color("#F0F0F0").strokeWidth(1).vertical(true).height('100%')
        }
        .width(1)
        .height(60)
        .backgroundColor("#F0F0F0")
      }
      .margin({ right: 16, top: 4 })

      // Content Card
      Column() {
        Row() {
          Text(step.title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(step.isCompleted ? "#808080" : "#000000")

          Blank()

          Text(step.waterTarget)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontFamily("monospace")
            .fontColor(step.isCompleted ? "#808080" : "#000000")
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Text(step.description)
          .fontSize(14)
          .fontColor("#808080")
          .margin({ top: 4 })

        // Time Badge
        Row() {
          Text(step.time)
            .fontSize(12)
            .fontColor("#808080")
        }
        .backgroundColor("#F5F5F5")
        .borderRadius(4)
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .margin({ top: 8 })
      }
      .width('100%')
      .padding(16)
      .backgroundColor(step.isCompleted ? "#F8F8F8" : "#FFFFFF")
      .borderRadius(12)
      .border({ width: 1, color: step.isCompleted ? Color.Transparent : "#EEEEEE" })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}