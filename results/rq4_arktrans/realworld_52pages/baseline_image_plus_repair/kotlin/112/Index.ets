import { router } from '@kit.ArkUI'

@Entry
@Component
struct SettingsPage {
  @State title: string = "Settings"

  build() {
    Column() {
      // Header
      Row() {
        Image($r("app.media.ic_arrow_back"))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back()
          })
        Text(this.title)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 8 })
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })

      // Preferences Card
      Column() {
        Text("Preferences")
          .fontWeight(FontWeight.Medium)
          .fontSize(16)
        Text("Settings preferences will appear here")
          .fontSize(12)
          .fontColor('#666666')
          .margin({ top: 8 })
      }
      .width('90%')
      .backgroundColor('#F5F5F5')
      .borderRadius(12)
      .padding(16)
      .margin({ top: 16 })

      Divider()
        .color('#E0E000')
        .margin({ top: 24, bottom: 16 })

      // About Section
      Row() {
        Image($r("app.media.ic_info"))
          .width(24)
          .height(24)
        Column() {
          Text("About")
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
          Text("App version, Licence and more")
            .fontSize(11)
            .fontColor('#666666')
        }
        .margin({ left: 16 })
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
      .onClick(() => {
        // Navigate to about page if needed
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFECF1')
  }
}