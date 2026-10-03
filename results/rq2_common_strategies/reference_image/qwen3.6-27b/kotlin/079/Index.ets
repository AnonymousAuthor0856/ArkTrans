import { window } from '@kit.ArkUI';

@Entry
@Component
struct SmartHomeApp {
  @State isDarkMode: boolean = false;
  private navPathStack: NavPathStack = new NavPathStack();

  build() {
    Navigation(this.navPathStack) {
      Column() {
        // Main content area
        Text("Smart Home App")
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 50 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.isDarkMode ? '#1E1E1E' : '#F5F6F8')
      
      // Bottom Navigation Bar
      Row() {
        Column() {
          Image($r('app.media.ic_home'))
            .width(24)
            .height(24)
            .fillColor('#4A6572')
          Text("Home")
            .fontSize(12)
            .fontColor('#4A6572')
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        
        Column() {
          Image($r('app.media.ic_star'))
            .width(24)
            .height(24)
            .fillColor('#333333')
          Text("Scenes")
            .fontSize(12)
            .fontColor('#333333')
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        
        Column() {
          Image($r('app.media.ic_settings'))
            .width(24)
            .height(24)
            .fillColor('#333333')
          Text("Settings")
            .fontSize(12)
            .fontColor('#333333')
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(60)
      .backgroundColor(Color.White)
      .borderRadius({ topLeft: 24, topRight: 24 })
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.1)', offsetY: -2 })
    }
    .navDestinationWidth('100%')
    .navDestinationHeight('100%')
    .hideTitleBar(true)
  }
}