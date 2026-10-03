import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct FeedbackView {
  @State private isDismissed: boolean = false;

  build() {
    Column() {
      // Main Content Area
      Column() {
        // Header Section
        Column({ space: 8 }) {
          Text("Hello! 👋🏼")
            .fontSize(34)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .lineHeight(40)
          
          Text("I'm Uriel Ortega.")
            .fontSize(26)
            .fontWeight(FontWeight.Medium)
            .fontColor('#8E8E93') // iOS Secondary Label Color
            .lineHeight(32)
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .margin({ top: 60, bottom: 30 })

        // Details Section
        Column({ space: 12 }) {
          Text("Feel free to reach out and share your thoughts with me!\nWhether it's a bug report, a suggestion, or just a friendly chat—I'm here for you.")
            .fontSize(17)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .lineHeight(24)
            .textAlign(TextAlign.Start)
            
          Text("If you enjoy using the app and would like to support my work, you can also buy me a coffee. Every sip fuels more improvements for this and future apps. Thank you! ☕️✨")
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(Color.Black)
            .lineHeight(20)
            .textAlign(TextAlign.Start)
        }
        .width('100%')
        
        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24, top: 20 })

      // Bottom Buttons Section
      Column({ space: 12 }) {
        Button() {
          Row() {
            Text("💬") // Using emoji as icon placeholder
              .fontSize(22)
              .margin({ right: 8 })
            Text("iMessage Me")
              .fontSize(17)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
          }
          .width('100%')
          .height(50)
          .justifyContent(FlexAlign.Center)
        }
        .backgroundColor('#34C759') // iOS Green
        .borderRadius(25)
        .shadow({ radius: 10, color: '#33000000', offsetY: 4 })
        .onClick(() => {
          // Logic for iMessage
        })

        Button() {
          Row() {
            Text("☕️") // Using emoji as icon placeholder
              .fontSize(22)
              .margin({ right: 8 })
            Text("Buy Me A Coffee")
              .fontSize(17)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
          }
          .width('100%')
          .height(50)
          .justifyContent(FlexAlign.Center)
        }
        .backgroundColor('#262626') // Dark Grey/Black
        .borderRadius(25)
        .shadow({ radius: 10, color: '#33000000', offsetY: 4 })
        .onClick(() => {
          // Logic for Buy Me A Coffee
        })
      }
      .width('100%')
      .padding({ left: 24, right: 24, bottom: 40, top: 20 })

      // Close Button (Overlay)
      Row() {
        Image($r('app.media.close')) 
          .width(30)
          .height(30)
          .objectFit(ImageFit.Contain)
          .margin({ right: 20 })
      }
      .position({ x: '100%', y: 0 })
      .translate({ x: -45, y: 45 })
      .onClick(() => {
        // Dismiss logic
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}