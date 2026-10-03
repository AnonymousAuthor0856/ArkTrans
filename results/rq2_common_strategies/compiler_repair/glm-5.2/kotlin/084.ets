// Data model for a brewing step
class BrewStep {
  title: string;
  description: string;
  waterTarget: string;
  time: string;
  isCompleted: boolean;

  constructor(title: string, description: string, waterTarget: string, time: string, isCompleted: boolean = false) {
    this.title = title;
    this.description = description;
    this.waterTarget = waterTarget;
    this.time = time;
    this.isCompleted = isCompleted;
  }
}

@Entry
@Component
struct BrewingScreen {
  private steps: BrewStep[] = [
    new BrewStep("Bloom", "Wet the grounds evenly to release CO2.", "60g", "0:00 - 0:45", true),
    new BrewStep("First Pour", "Pour slowly in concentric circles.", "180g", "0:45 - 1:30", false),
    new BrewStep("Second Pour", "Gently pour remaining water.", "300g", "1:30 - 2:15", false),
    new BrewStep("Draw Down", "Wait for the water to drain completely.", "300g", "2:15 - 3:00", false)
  ];

  @Builder
  StatItem(label: string, value: string) {
    Column() {
      Stack() {
        if (label === "Ratio") {
          Text("+")
            .fontSize(20)
            .fontColor(Color.Gray)
            .fontWeight(FontWeight.Bold);
        } else if (label === "Beans") {
          Text("♥")
            .fontSize(20)
            .fontColor(Color.Gray);
        } else {
          Text("↻")
            .fontSize(20)
            .fontColor(Color.Gray);
        }
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: "#E0E0E0" })

      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 8 })

      Text(label)
        .fontSize(12)
        .fontColor(Color.Gray)
        .margin({ top: 2 })
    }
  }

  @Builder
  StepCard(number: number, step: BrewStep) {
    Row() {
      // Timeline Indicator
      Column() {
        Stack() {
          if (step.isCompleted) {
            Text("✓")
              .fontSize(14)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold);
          } else {
            Text(number.toString())
              .fontSize(12)
              .fontColor(Color.White)
          }
        }
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(step.isCompleted ? Color.Black : "#E0E0E0")

        // Vertical line connection visual
        Line()
          .width(1)
          .height(60)
          .backgroundColor("#F0F0F0")
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Center)
      .margin({ right: 16, top: 4 })

      // Content Card
      Column() {
        Row() {
          Text(step.title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(step.isCompleted ? Color.Gray : Color.Black)

          Text(step.waterTarget)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(step.isCompleted ? Color.Gray : Color.Black)
            .margin({ left: 8 })
        }
        .width("100%")
        .justifyContent(FlexAlign.SpaceBetween)

        Text(step.description)
          .fontSize(14)
          .fontColor(Color.Gray)
          .margin({ top: 4 })

        Text(step.time)
          .fontSize(12)
          .fontColor(Color.Gray)
          .backgroundColor("#F5F5F5")
          .borderRadius(4)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .margin({ top: 8 })
      }
      .width("100%")
      .padding(16)
      .borderRadius(12)
      .backgroundColor(step.isCompleted ? "#F8F8F8" : Color.White)
      .border({ width: 1, color: step.isCompleted ? Color.Transparent : "#EEEEEE" })
      .alignItems(HorizontalAlign.Start)
    }
    .width("100%")
    .alignItems(VerticalAlign.Top)
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Column() {
          Text("V60 Guide")
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
          Text("Ethiopia Yirgacheffe")
            .fontSize(14)
            .fontColor(Color.Gray)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)

        Text("⚙")
          .fontSize(24)
          .fontColor(Color.Black)
      }
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 24, right: 24, top: 48, bottom: 24 })

      // Main Content
      Scroll() {
        Column() {
          // Main Timer Display
          Column() {
            Text("00:45")
              .fontSize(80)
              .fontWeight(FontWeight.Lighter)
              .fontColor(Color.Black)
            Text("Target: 300g")
              .fontSize(14)
              .fontColor(Color.Gray)
              .margin({ top: 4 })
          }
          .width("100%")
          .alignItems(HorizontalAlign.Center)
          .padding({ top: 24, bottom: 24 })

          // Stats Row
          Row() {
            this.StatItem("Ratio", "1:15")
            this.StatItem("Beans", "20g")
            this.StatItem("Temp", "93°C")
          }
          .width("100%")
          .justifyContent(FlexAlign.SpaceEvenly)
          .padding({ bottom: 32 })

          Divider()
            .color("#F0F0F0")
            .strokeWidth(1)
            .margin({ bottom: 24 })

          Text("Brewing Steps")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .margin({ bottom: 16 })

          ForEach(this.steps, (step: BrewStep, index: number) => {
            this.StepCard(index + 1, step)
          }, (step: BrewStep) => step.title)

          // Bottom padding for scrolling list
          Blank().height(80)
        }
        .width("100%")
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top)

      // Bottom Control Area
      Row() {
        Button() {
          Row() {
            Text("▶")
              .fontSize(20)
              .fontColor(Color.White)
            Text("Start Brewing")
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .margin({ left: 8 })
          }
          .width("100%")
          .height(64)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .type(ButtonType.Capsule)
        .backgroundColor(Color.Black)
        .width("100%")
        .height(64)
      }
      .width("100%")
      .padding({ left: 24, right: 24, top: 16, bottom: 48 })
    }
    .width("100%")
    .height("100%")
    .backgroundColor(Color.White)
  }
}