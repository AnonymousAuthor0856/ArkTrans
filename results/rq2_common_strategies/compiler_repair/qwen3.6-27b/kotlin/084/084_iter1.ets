import { Colors, FontFamily, FontWeight } from '@kit.ArkUI'

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
      // Top Bar Area
      Row() {
        Column() {
          Text("V60 Guide")
            .fontWeight(FontWeight.Bold)
            .letterSpacing(-0.5)
            .fontColor(Colors.Black)
            .fontSize(28) // Approximate headlineMedium
          
          Text("Ethiopia Yirgacheffe")
            .fontColor(Colors.Gray)
            .fontSize(14) // Approximate bodyMedium
        }
        
        Flex({ justifyContent: FlexAlign.End }) {
          Button("", { type: ButtonType.Circle, stateEffect: true })
            .width(48)
            .height(48)
            .backgroundColor(Colors.Transparent)
            .borderWidth(0)
            .onClick(() => {})
            .bindContentCover(this.settingsIconBuilder)
        }
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 48, bottom: 0 })
      .alignItems(VerticalAlign.Center)

      // Main Timer Display
      Column() {
        Text("00:45")
          .fontSize(80)
          .fontWeight(FontWeight.Light)
          .fontFamily(FontFamily.Monospace)
          .letterSpacing(-2)
          .fontColor(Colors.Black)
        
        Text("Target: 300g")
          .fontColor(Colors.Gray)
          .fontSize(14) // labelLarge approx
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .padding({ top: 24, bottom: 24 })

      // Stats Row
      Row() {
        this.StatItemComponent("Ratio", "1:15", 'Add')
        this.StatItemComponent("Beans", "20g", 'Favorite')
        this.StatItemComponent("Temp", "93°C", 'Refresh')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding({ bottom: 32 })

      Divider().color('#F0F0F0')
      
      Text("Brewing Steps")
        .fontWeight(FontWeight.Bold)
        .fontSize(18) // titleMedium approx
        .padding({ top: 24, bottom: 16 })

      // Steps List
      List({ space: 16 }) {
        ForEach(this.steps, (step: BrewStep, index: number) => {
          ListItem() {
            this.StepCardComponent(index + 1, step)
          }
        })
        // Add some bottom padding for the scrolling list so it clears the button
        ListItem() {
          Column().height(80)
        }
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: 24, right: 24 })

      // Bottom Control Area
      Button("Start Brewing")
        .type(ButtonType.Capsule)
        .backgroundColor(Colors.Black)
        .fontColor(Colors.White)
        .fontWeight(FontWeight.Bold)
        .fontSize(16)
        .height(64)
        .width('100%')
        .margin({ left: 24, right: 24, bottom: 24, top: 16 })
        .onClick(() => {})
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.White)
  }

  @Builder
  settingsIconBuilder() {
    Image($r('app.media.ic_settings')) // Placeholder for Settings Icon
      .width(24)
      .height(24)
      .fillColor(Colors.Black)
  }

  @Builder
  StatItemComponent(label: string, value: string, iconType: string) {
    Column() {
      Row() {
        // Using simple text or generic shapes as icons are not directly available without resources
        // Simulating the circle border and icon
        Circle({ width: 48, height: 48 })
          .borderWidth(1)
          .borderColor('#E0E0E0')
          .position({ x: 0, y: 0 })
        
        Text(iconType === 'Add' ? '+' : iconType === 'Favorite' ? '♥' : '↻')
          .fontSize(20)
          .fontColor(Colors.Gray)
      }
      .width(48)
      .height(48)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Text(value)
        .fontWeight(FontWeight.SemiBold)
        .fontSize(16)
        .fontColor(Colors.Black)
        .margin({ top: 8 })

      Text(label)
        .fontSize(12)
        .fontColor(Colors.Gray)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  StepCardComponent(number: number, step: BrewStep) {
    Row() {
      // Timeline Indicator
      Column() {
        Stack() {
          Circle({ width: 24, height: 24 })
            .fill(step.isCompleted ? Colors.Black : '#E0E0E0')
          
          if (step.isCompleted) {
            Text("✓")
              .fontSize(14)
              .fontColor(Colors.White)
          } else {
            Text(number.toString())
              .fontSize(12)
              .fontColor(Colors.White)
          }
        }
        .width(24)
        .height(24)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        Column()
          .width(1)
          .height(60)
          .backgroundColor('#F0F0F0')
          .margin({ top: 0 })
      }
      .alignItems(HorizontalAlign.Center)
      .margin({ end: 16, top: 4 })

      // Content Card
      Column() {
        Row() {
          Text(step.title)
            .fontWeight(FontWeight.Bold)
            .fontSize(16)
            .fontColor(step.isCompleted ? Colors.Gray : Colors.Black)
          
          Flex({ justifyContent: FlexAlign.End }) {
            Text(step.waterTarget)
              .fontWeight(FontWeight.Bold)
              .fontFamily(FontFamily.Monospace)
              .fontSize(14)
              .fontColor(step.isCompleted ? Colors.Gray : Colors.Black)
          }
        }
        .width('100%')

        Text(step.description)
          .fontSize(14)
          .fontColor(Colors.Gray)
          .margin({ top: 4 })

        Row() {
          Text(step.time)
            .fontSize(12)
            .fontColor(Colors.Gray)
        }
        .backgroundColor('#F5F5F5')
        .borderRadius(4)
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .margin({ top: 8 })
      }
      .width('100%')
      .backgroundColor(step.isCompleted ? '#F8F8F8' : Colors.White)
      .borderRadius(12)
      .borderWidth(step.isCompleted ? 0 : 1)
      .borderColor(step.isCompleted ? Colors.Transparent : '#EEEEEE')
      .padding(16)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}