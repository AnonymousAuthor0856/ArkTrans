import { router } from '@kit.ArkUI';

interface BrewStep {
  title: string;
  description: string;
  waterTarget: string;
  time: string;
  isCompleted: boolean;
}

@Entry
@Component
struct BrewingScreen {
  private steps: BrewStep[] = [
    { title: "Bloom", description: "Wet the grounds evenly to release CO2.", waterTarget: "60g", time: "0:00 - 0:45", isCompleted: true },
    { title: "First Pour", description: "Pour slowly in concentric circles.", waterTarget: "180g", time: "0:45 - 1:30", isCompleted: false },
    { title: "Second Pour", description: "Gently pour remaining water.", waterTarget: "300g", time: "1:30 - 2:15", isCompleted: false },
    { title: "Draw Down", description: "Wait for the water to drain completely.", waterTarget: "300g", time: "2:15 - 3:00", isCompleted: false }
  ];

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
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)

        Button({ type: ButtonType.Circle }) {
          Image($r('sys.media.ohos_ic_public_settings'))
            .width(22)
            .height(22)
            .fillColor(Color.Black)
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.Transparent)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 48, bottom: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Scrollable Content
      Scroll() {
        Column() {
          // Timer Display
          Column() {
            Text("00:45")
              .fontSize(80)
              .fontWeight(FontWeight.Lighter)
              .fontColor(Color.Black)
              .fontFamily('monospace')
              .letterSpacing(-2)
            Text("Target: 300g")
              .fontSize(12)
              .fontColor(Color.Gray)
              .margin({ top: 4 })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
          .padding({ top: 24, bottom: 24 })

          // Stats Row
          Row() {
            StatItem({ label: "Ratio", value: "1:15" })
            StatItem({ label: "Beans", value: "20g" })
            StatItem({ label: "Temp", value: "93°C" })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          .margin({ bottom: 32 })

          // Divider
          Divider()
            .color(0xFFF0F0F0)
            .strokeWidth(1)

          // Brewing Steps Title
          Text("Brewing Steps")
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .margin({ top: 24, bottom: 16 })
            .width('100%')

          // Steps List
          Column({ space: 16 }) {
            ForEach(this.steps, (step: BrewStep, index: number) => {
              StepCard({ number: index + 1, step: step })
            })
            // Bottom padding
            Column()
              .height(80)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Bar
      Column() {
        Button() {
          Row({ space: 8 }) {
            Image($r('sys.media.ohos_ic_public_play'))
              .width(20)
              .height(20)
              .fillColor(Color.White)
            Text("Start Brewing")
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
          }
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .height(64)
        .backgroundColor(Color.Black)
        .borderRadius(16)
        .type(ButtonType.Normal)
      }
      .width('100%')
      .padding(24)
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct StatItem {
  label: string = '';
  value: string = '';

  build() {
    Column({ space: 8 }) {
      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill(Color.Transparent)
          .stroke(0xFFE0E0E0)
          .strokeWidth(1)

        if (this.label === "Ratio") {
          Image($r('sys.media.ohos_ic_public_add'))
            .width(20)
            .height(20)
            .fillColor(Color.Gray)
        } else if (this.label === "Beans") {
          Image($r('sys.media.ohos_ic_public_highlight'))
            .width(20)
            .height(20)
            .fillColor(Color.Gray)
        } else {
          Image($r('sys.media.ohos_ic_public_refresh'))
            .width(20)
            .height(20)
            .fillColor(Color.Gray)
        }
      }
      .width(48)
      .height(48)

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)

      Text(this.label)
        .fontSize(11)
        .fontColor(Color.Gray)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StepCard {
  number: number = 0;
  step: BrewStep = {
    title: '',
    description: '',
    waterTarget: '',
    time: '',
    isCompleted: false
  };

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
            Image($r('sys.media.ohos_ic_public_ok'))
              .width(14)
              .height(14)
              .fillColor(Color.White)
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
      .margin({ end: 16, top: 4 })

      // Content Card
      Column() {
        Column({ space: 4 }) {
          Row() {
            Text(this.step.title)
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.step.isCompleted ? Color.Gray : Color.Black)

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
            .width('100%')

          Row() {
            Text(this.step.time)
              .fontSize(11)
              .fontColor(Color.Gray)
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          }
          .backgroundColor(0xFFF5F5F5)
          .borderRadius(4)
          .margin({ top: 4 })
        }
        .padding(16)
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
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