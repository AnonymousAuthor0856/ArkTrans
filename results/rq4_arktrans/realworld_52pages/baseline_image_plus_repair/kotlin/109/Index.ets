// AboutPage.ets

import { router } from '@kit.ArkUI';

@Entry
@Component
struct AboutPage {
  @State private isBack: boolean = false;

  build() {
    Column() {
      // Header Row
      Row() {
        Image($r('app.media.ic_arrow_back'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
          .onClick(() => {
            this.isBack = true;
            router.back();
          })
        
        Text("About")
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ left: 8 })
      }
      .width('100%')
      .padding({ top: 16, bottom: 16, left: 24, right: 24 })
      
      // Main Content Area
      Column() {
        // Logo Card
        Row() {
          Image($r('app.media.ic_logo_audio_note'))
            .width(64)
            .height(64)
        }
        .width(80)
        .height(80)
        .borderRadius(16)
        .backgroundColor('#EFB8C8')
        .shadow({ radius: 4, color: '#33000000', offsetY: 2 })
        
        Text("Audio Notes")
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 12 })
          
        Text("v0.1.5.2(02052023)")
          .fontSize(12)
          .fontColor('#666666')
          .margin({ top: 4 })
          
        Divider()
          .color('#E0E0E0')
          .strokeWidth(1)
          .margin({ top: 24, bottom: 24 })
          
        // Attribution Card
        Column() {
          Text("Attributions & Licence")
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            
          Text("Licenced under Apache Licence, Version 2.0")
            .fontSize(12)
            .fontColor('#666666')
            .margin({ top: 8 })
        }
        .width('100%')
        .padding(16)
        .borderRadius(10)
        .backgroundColor('#EFB8C8')
        .shadow({ radius: 4, color: '#33000000', offsetY: 2 })
        
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .padding({ left: 24, right: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFECF1')
  }
}