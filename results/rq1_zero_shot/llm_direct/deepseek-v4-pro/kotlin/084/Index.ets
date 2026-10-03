@Entry
@Component
struct BrewingScreen {
  @State steps: BrewStep[] = [
    new BrewStep("Bloom", "Wet the grounds evenly to release CO2.", "60g", "0:00 - 0:45", true),
    new BrewStep("First Pour", "Pour slowly in concentric circles.", "180g", "0:45 - 1:30", false),
    new BrewStep("Second Pour", "Gently pour remaining water.", "300g", "1:30 - 2:15", false),
    new BrewStep("Draw Down", "Wait for the water to drain completely.", "300g", "2:15 - 3:00", false)
  ]

  build() {
    Column() {
      // Top Bar
      Row() {
        Column() {
          Text("V60 Guide")
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .letterSpacing(-0.5)
          Text("Ethiopia Yirgacheffe")
            .fontSize(14)
            .fontColor(Color.Gray)
        }
        .layoutWeight(1)

        Button() {
          Text("⚙")
            .fontSize(24)
            .fontColor(Color.Black)
        }
        .backgroundColor(Color.Transparent)
        .width(48)
        .height(48)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 48, bottom: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Main Content
      Column() {
        // Timer Display
        Column() {
          Text("00:45")
            .fontSize(80)
            .fontWeight(FontWeight.Light)
            .fontColor(Color.Black)
            .fontFamily('monospace')
            .letterSpacing(-2)
          Text("Target: 300g")
            .fontSize(12)
            .fontColor(Color.Gray)
        }
        .width('100%')
        .padding({ top: 24, bottom: 24 })
        .alignItems(HorizontalAlign.Center)

        // Stats Row
        Row() {
          StatItem({ label: "Ratio", value: "1:15", icon: "+" })
          StatItem({ label: "Beans", value: "20g", icon: "♥" })
          StatItem({ label: "Temp", value: "93°C", icon: "↻" })
        }
        .width('100%')
        .padding({ bottom: 32 })
        .justifyContent(FlexAlign.SpaceEvenly)

        // Divider
        Divider()
          .strokeWidth(1)
          .color('#F0F0F0')

        // Brewing Steps Title
        Text("Brewing Steps")
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .padding({ top: 24, bottom: 16 })

        // Steps List
        List() {
          ForEach(this.steps, (step: BrewStep, index: number) => {
            ListItem() {
              StepCard({ number: index + 1, step: step })
            }
            .padding({ bottom: 16 })
          })

          ListItem() {
            Row()
              .height(80)
          }
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 24, right: 24 })

      // Bottom Button
      Button("Start Brewing")
        .width('100%')
        .height(64)
        .backgroundColor(Color.Black)
        .fontColor(Color.White)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .borderRadius(16)
        .margin({ left: 24, right: 24, bottom: 24, top: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct StatItem {
  label: string = ''
  value: string = ''
  icon: string = ''

  build() {
    Column() {
      Row() {
        Text(this.icon)
          .fontSize(20)
          .fontColor(Color.Gray)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: '#E0E0E0' })
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 8 })

      Text(this.label)
        .fontSize(11)
        .fontColor(Color.Gray)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StepCard {
  number: number = 0
  step: BrewStep = new BrewStep("", "", "", "", false)

  build() {
    Row() {
      // Timeline Indicator
      Column() {
        Row() {
          if (this.step.isCompleted) {
            Text("✓")
              .fontSize(14)
              .fontColor(Color.White)
          } else {
            Text(this.number.toString())
              .fontSize(11)
              .fontColor(Color.White)
          }
        }
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(this.step.isCompleted ? Color.Black : '#E0E0E0')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        // Vertical line
        Row()
          .width(1)
          .height(60)
          .backgroundColor('#F0F0F0')
      }
      .alignItems(HorizontalAlign.Center)
      .margin({ right: 16, top: 4 })

      // Content Card
      Column() {
        Row() {
          Text(this.step.title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.step.isCompleted ? Color.Gray : Color.Black)
            .layoutWeight(1)

          Text(this.step.waterTarget)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontFamily('monospace')
            .fontColor(this.step.isCompleted ? Color.Gray : Color.Black)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Text(this.step.description)
          .fontSize(14)
          .fontColor(Color.Gray)
          .margin({ top: 4 })

        Row() {
          Text(this.step.time)
            .fontSize(11)
            .fontColor(Color.Gray)
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        }
        .backgroundColor('#F5F5F5')
        .borderRadius(4)
        .margin({ top: 8 })
      }
      .layoutWeight(1)
      .padding(16)
      .backgroundColor(this.step.isCompleted ? '#F8F8F8' : Color.White)
      .borderRadius(12)
      .border({ width: 1, color: this.step.isCompleted ? Color.Transparent : '#EEEEEE' })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}

class BrewStep {
  title: string
  description: string
  waterTarget: string
  time: string
  isCompleted: boolean

  constructor(title: string, description: string, waterTarget: string, time: string, isCompleted: boolean = false) {
    this.title = title
    this.description = description
    this.waterTarget = waterTarget
    this.time = time
    this.isCompleted = isCompleted
  }
}