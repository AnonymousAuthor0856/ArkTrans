@Entry
@Component
struct UnlockNotesView {
  @State isLocked: boolean = true

  build() {
    Column() {
      // Lock Icon
      Image($r('app.media.ic_lock'))
        .width(50)
        .height(50)
        .fillColor('#A68B6D') // Brownish color from screenshot
        .margin({ top: 100 })

      // Title Text
      Text('Private notes are protected')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ top: 20 })

      // Subtitle Text
      Text('Unlock to enable access')
        .fontSize(16)
        .fontColor(Color.Gray)
        .margin({ top: 8 })

      // Unlock Button
      Button('Unlock')
        .type(ButtonType.Capsule)
        .backgroundColor(Color.Transparent)
        .borderWidth(0)
        .fontColor('#A68B6D')
        .fontSize(18)
        .margin({ top: 30 })
        .onClick(() => {
          this.handleUnlock()
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(Color.White)
  }

  private handleUnlock(): void {
    // Implement unlock logic here
    console.info('Unlock button clicked')
  }
}