import { LengthMetrics } from '@kit.ArkUI'

interface BrewStep {
  title: string
  description: string
  waterTarget: string
  time: string
  isCompleted: boolean
}

@Entry
@Component
struct BrewingScreen {
  private steps: BrewStep[] = [
    { title: "Bloom", description: "Wet the grounds evenly to release CO2.", waterTarget: "60g", time: "0:00 - 0:45", isCompleted: true },
    { title: "First Pour", description: "Pour slowly in concentric circles.", waterTarget: "180g", time: "0:45 - 1:30", isCompleted: false },
    { title: "Second Pour", description: "Gently pour remaining water.", waterTarget: "300g", time: "1:30 - 2:15", isCompleted: false },
    { title: "Draw Down", description: "Wait for the water to drain completely.", waterTarget: "300g", time: "2:15 - 3:00", isCompleted: false }
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
          Text("Ethiopia Yirgacheffe")
            .fontSize(14)
            .fontColor(Color.Gray)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button({ type: ButtonType.Circle }) {
          Text("⚙")
            .fontSize(20)
            .fontColor(Color.Black)
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.White)
        .border({ width: 0 })
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 48, bottom: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Main Timer Display
      Column() {
        Text("00:45")
          .fontSize(80)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Color.Black)
          .fontFamily('monospace')
          .letterSpacing(-2)
        Text("Target: 300g")
          .fontSize(14)
          .fontColor(Color.Gray)
          .margin({ top: 8 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .padding({ top: 24, bottom: 24 })

      // Stats Row
      Row() {
        StatItem({ label: "Ratio", value: "1:15", iconType: "ratio" })
        StatItem({ label: "Beans", value: "20g", iconType: "beans" })
        StatItem({ label: "Temp", value: "93°C", iconType: "temp" })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding({ bottom: 24 })

      // Divider
      Divider()
        .color(0xFFF0F0F0)
        .strokeWidth(1)
        .margin({ left: 24, right: 24 })

      // Brewing Steps Title
      Text("Brewing Steps")
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .width('100%')
        .padding({ left: 24, right: 24, top: 24, bottom: 16 })

      // Steps List
      List({ space: 16 }) {
        ForEach(this.steps, (step: BrewStep, index: number) => {
          ListItem() {
            StepCard({ number: index + 1, step: step })
          }
          .padding({ left: 24, right: 24 })
        })
        ListItem() {
          Column().height(80)
        }
      }
      .layoutWeight(1)
      .width('100%')

      // Bottom Button
      Button() {
        Row() {
          Text("▶")
            .fontSize(18)
            .fontColor(Color.White)
            .margin({ right: 8 })
          Text("Start Brewing")
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(64)
      .backgroundColor(Color.Black)
      .borderRadius(16)
      .margin({ left: 24, right: 24, bottom: 24, top: 8 })
      .padding({ left: 24, right: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct StatItem {
  @Prop label: string = ''
  @Prop value: string = ''
  @Prop iconType: string = ''

  build() {
    Column() {
      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill(Color.White)
          .stroke(0xFFE0E0E0)
          .strokeWidth(1)

        if (this.iconType === "ratio") {
          Text("+")
            .fontSize(20)
            .fontColor(Color.Gray)
        } else if (this.iconType === "beans") {
          Text("♥")
            .fontSize(18)
            .fontColor(Color.Gray)
        } else {
          Text("↺")
            .fontSize(20)
            .fontColor(Color.Gray)
        }
      }
      .width(48)
      .height(48)

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ top: 8 })

      Text(this.label)
        .fontSize(11)
        .fontColor(Color.Gray)
        .margin({ top: 2 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StepCard {
  @Prop number: number = 0
  @Prop step: BrewStep = {
    title: '',
    description: '',
    waterTarget: '',
    time: '',
    isCompleted: false
  }

  build() {
    Row() {
      // Timeline Indicator
      Column() {
        Stack() {
          Circle()
            .width(24)
            .height(24)
            .fill(this.step.isCompleted ? Color.Black : 0xFFE0E0E0)

          if (this.step.isCompleted) {
            Text("✓")
              .fontSize(12)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
          } else {
            Text(this.number.toString())
              .fontSize(11)
              .fontColor(Color.White)
          }
        }
        .width(24)
        .height(24)

        // Vertical line
        Column()
          .width(1)
          .height(60)
          .backgroundColor(0xFFF0F0F0)
      }
      .alignItems(HorizontalAlign.Center)
      .margin({ right: 16, top: 4 })

      // Content Card
      Column() {
        Row() {
          Text(this.step.title)
            .fontSize(15)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.step.isCompleted ? Color.Gray : Color.Black)
          Blank()
          Text(this.step.waterTarget)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.step.isCompleted ? Color.Gray : Color.Black)
            .fontFamily('monospace')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Text(this.step.description)
          .fontSize(13)
          .fontColor(Color.Gray)
          .margin({ top: 4 })
          .width('100%')

        Row() {
          Text(this.step.time)
            .fontSize(11)
            .fontColor(Color.Gray)
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        }
        .backgroundColor(0xFFF5F5F5)
        .borderRadius(4)
        .margin({ top: 8 })
      }
      .layoutWeight(1)
      .padding(16)
      .backgroundColor(this.step.isCompleted ? 0xFFF8F8F8 : Color.White)
      .borderRadius(12)
      .border({
        width: this.step.isCompleted ? 0 : 1,
        color: this.step.isCompleted ? Color.Transparent : 0xFFEEEEEE
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}