import { router } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

// Data model for a brewing step
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
  // Hardcoded data for pure UI demonstration
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
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .fontSize(28)
            .letterSpacing(-0.5)
          Text("Ethiopia Yirgacheffe")
            .fontColor(Color.Gray)
            .fontSize(16)
        }
        Flex({ justifyContent: FlexAlign.End }) {
          Image($r('app.media.settings')) // Replace with actual settings icon
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .onClick(() => {
              // Handle settings click
            })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 48, bottom: 24 })

      // Main Timer Display
      Column() {
        Text("00:45")
          .fontSize(80)
          .fontWeight(FontWeight.Lighter)
          .fontFamily('monospace')
          .letterSpacing(-2)
          .fontColor(Color.Black)
        Text("Target: 300g")
          .fontColor(Color.Gray)
          .fontSize(16)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .padding({ top: 24, bottom: 24 })

      // Stats Row
      Row() {
        this.StatItem("Ratio", "1:15", $r('app.media.add')) // Replace with actual add icon
        this.StatItem("Beans", "20g", $r('app.media.favorite')) // Replace with actual favorite icon
        this.StatItem("Temp", "93°C", $r('app.media.refresh')) // Replace with actual refresh icon
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding({ bottom: 32 })

      Divider()
        .color('#F0F0F0')
        .strokeWidth(1)

      Text("Brewing Steps")
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .fontSize(18)
        .margin({ top: 24, bottom: 16 })

      // Steps List
      List({ space: 16 }) {
        ForEach(this.steps, (step: BrewStep, index: number) => {
          ListItem() {
            this.StepCard(index + 1, step)
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ bottom: 80 }) // Add some bottom padding for the scrolling list so it clears the button

      // Bottom Control Area
      Button({ type: ButtonType.Capsule }) {
        Row() {
          Image($r('app.media.play_arrow')) // Replace with actual play arrow icon
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .margin({ right: 8 })
          Text("Start Brewing")
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .fontSize(16)
        }
        .justifyContent(FlexAlign.Center)
      }
      .backgroundColor(Color.Black)
      .width('100%')
      .height(64)
      .borderRadius(16)
      .margin({ left: 24, right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  StatItem(label: string, value: string, iconResource: Resource) {
    Column() {
      Row() {
        Image(iconResource)
          .width(20)
          .height(20)
          .objectFit(ImageFit.Contain)
          .fillColor(Color.Gray)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: '#E0E0E0' })
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Text(value)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .fontSize(16)
        .margin({ top: 8 })

      Text(label)
        .fontColor(Color.Gray)
        .fontSize(12)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  StepCard(number: number, step: BrewStep) {
    Row() {
      // Timeline Indicator
      Column() {
        Row() {
          if (step.isCompleted) {
            Image($r('app.media.check')) // Replace with actual check icon
              .width(14)
              .height(14)
              .objectFit(ImageFit.Contain)
              .fillColor(Color.White)
          } else {
            Text(number.toString())
              .fontColor(Color.White)
              .fontSize(12)
          }
        }
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(step.isCompleted ? Color.Black : '#E0E0E0')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        Column() {
          Divider()
            .width(1)
            .height(60)
            .color('#F0F0F0')
        }
      }
      .alignItems(HorizontalAlign.Center)
      .margin({ right: 16, top: 4 })

      // Content Card
      Column() {
        Row() {
          Text(step.title)
            .fontWeight(FontWeight.Bold)
            .fontColor(step.isCompleted ? Color.Gray : Color.Black)
            .fontSize(16)
          Flex({ justifyContent: FlexAlign.End }) {
            Text(step.waterTarget)
              .fontWeight(FontWeight.Bold)
              .fontFamily('monospace')
              .fontColor(step.isCompleted ? Color.Gray : Color.Black)
              .fontSize(14)
          }
          .layoutWeight(1)
        }
        .width('100%')

        Text(step.description)
          .fontColor(Color.Gray)
          .fontSize(14)
          .margin({ top: 4 })

        Row() {
          Text(step.time)
            .fontColor(Color.Gray)
            .fontSize(12)
        }
        .backgroundColor('#F5F5F5')
        .borderRadius(4)
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .margin({ top: 8 })
      }
      .width('100%')
      .backgroundColor(step.isCompleted ? '#F8F8F8' : Color.White)
      .borderRadius(12)
      .border({ width: 1, color: step.isCompleted ? Color.Transparent : '#EEEEEE' })
      .padding(16)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}