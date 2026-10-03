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
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .letterSpacing(-0.5)
          Text("Ethiopia Yirgacheffe")
            .fontSize(14)
            .fontColor(Color.Gray)
            .margin({ top: 2 })
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
        .border({ width: 1, color: '#E0E0E0', radius: 20 })
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
              .fontSize(13)
              .fontColor(Color.Gray)
              .margin({ top: 4 })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
          .padding({ top: 24, bottom: 24 })

          // Stats Row
          Row() {
            StatItem({ label: "Ratio", value: "1:15", icon: "+" })
            StatItem({ label: "Beans", value: "20g", icon: "♥" })
            StatItem({ label: "Temp", value: "93°C", icon: "↻" })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          .margin({ bottom: 32 })

          // Divider
          Divider()
            .color('#F0F0F0')
            .strokeWidth(1)

          // Steps Header
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
          }
          .width('100%')
          .padding({ bottom: 24 })
        }
        .padding({ left: 24, right: 24 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Bar
      Row() {
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
  @Prop label: string = '';
  @Prop value: string = '';
  @Prop icon: string = '';

  build() {
    Column() {
      Row() {
        Text(this.icon)
          .fontSize(18)
          .fontColor(Color.Gray)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: '#E0E0E0', radius: 24 })
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Text(this.value)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
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
  @Prop number: number = 0;
  @Prop step: BrewStep = {
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
        Row() {
          if (this.step.isCompleted) {
            Text("✓")
              .fontSize(12)
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
        Column()
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
        }
        .backgroundColor('#F5F5F5')
        .borderRadius(4)
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .margin({ top: 8 })
      }
      .layoutWeight(1)
      .padding(16)
      .backgroundColor(this.step.isCompleted ? '#F8F8F8' : Color.White)
      .borderRadius(12)
      .border({
        width: this.step.isCompleted ? 0 : 1,
        color: this.step.isCompleted ? Color.Transparent : '#EEEEEE',
        radius: 12
      })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}