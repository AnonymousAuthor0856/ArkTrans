import { BusinessError } from '@kit.BasicServicesKit';
import { common, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct AboutCleanPadView {
  @State private greeting: string = "Hello!";
  @State private gradientColors: Color[] = [Color.Purple, Color.Blue, Color.Green, Color.Yellow];
  @State private isDismissed: boolean = false;

  aboutToAppear() {
    this.updateBackgroundAndGreeting();
  }

  build() {
    Column() {
      // Background Gradient
      Row() {
        Text("")
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 135,
        colors: this.gradientColors.map(color => [color, 1])
      })
      .position({ x: 0, y: 0 })
      .zIndex(-1)

      // Close Button
      Row() {
        Text("✕")
          .fontSize(24)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            this.isDismissed = true;
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .padding({ right: 20, top: 50 })

      // Main Content
      Column() {
        // App Icon (Simulated with a rounded rectangle and letter C)
        Column() {
          Text("C")
            .fontSize(60)
            .fontColor('#3E2723')
            .fontWeight(FontWeight.Bold)
        }
        .width(120)
        .height(120)
        .backgroundColor('#FFE0B2')
        .borderRadius(30)
        .shadow({ radius: 20, color: '#80000000', offsetX: 0, offsetY: 10 })
        .margin({ top: 40, bottom: 30 })

        // Greeting
        Text(this.greeting)
          .fontSize(42)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
          .shadow({ radius: 10, color: '#40000000', offsetX: 0, offsetY: 5 })
          .margin({ bottom: 10 })

        // Description Title
        Text("CleanPad is the home for any of your thoughts.")
          .fontSize(32)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Medium)
          .shadow({ radius: 10, color: '#40000000', offsetX: 0, offsetY: 5 })
          .textAlign(TextAlign.Center)
          .margin({ bottom: 20 })

        // Body Text
        Column() {
          Text("It's your space to capture it all. Feel free to express yourself.\n\n" +
               "Your notes are yours alone, securely stored on your device and optionally protected with authentication.")
            .fontSize(20)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Medium)
            .lineHeight(30)
            .shadow({ radius: 10, color: '#40000000', offsetX: 0, offsetY: 5 })
            .textAlign(TextAlign.Center)
            .margin({ bottom: 20 })

          Text("Thank you for choosing CleanPad as your trusted companion. Here's to a clutter-free, inspired note-taking journey!")
            .fontSize(20)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Medium)
            .lineHeight(30)
            .shadow({ radius: 10, color: '#40000000', offsetX: 0, offsetY: 5 })
            .textAlign(TextAlign.Center)
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .padding({ left: 20, right: 20 })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Transparent)
  }

  private updateBackgroundAndGreeting(): void {
    const now = new Date();
    const hour = now.getHours();

    if (hour >= 6 && hour < 12) {
      this.greeting = "Good morning!";
      this.gradientColors = [Color.Orange, Color.Yellow, Color.Pink, Color.Red];
    } else if (hour >= 12 && hour < 17) {
      this.greeting = "Good afternoon!";
      this.gradientColors = [Color.Yellow, Color.Green, Color.Cyan, Color.Teal];
    } else if (hour >= 17 && hour < 20) {
      this.greeting = "Good evening!";
      this.gradientColors = [Color.Orange, Color.Pink, Color.Purple, Color.Indigo];
    } else {
      this.greeting = "Good night!";
      this.gradientColors = [Color.Indigo, Color.Purple, Color.Blue, Color.Teal];
    }
  }
}