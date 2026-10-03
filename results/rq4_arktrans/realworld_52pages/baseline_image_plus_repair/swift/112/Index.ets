@Entry
@Component
struct WelcomeView {
  @State gradientColors: string[] = ['#FFFFFF', '#F5E6D3', '#FFFFFF']

  build() {
    Column() {
      // App Icon
      Row() {
        Text('C')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3E2723')
          .width(100)
          .height(100)
          .borderRadius(20)
          .backgroundColor('#FFF3E0')
          .shadow({ radius: 10, color: '#00000020', offsetX: 0, offsetY: 4 })
      }
      .width(120)
      .height(120)
      .borderRadius(24)
      .backgroundColor('#FFE0B2')
      .shadow({ radius: 15, color: '#00000030', offsetX: 0, offsetY: 6 })
      .margin({ top: 60, bottom: 40 })

      // Header Texts
      Text('Welcome to CleanPad')
        .fontSize(36)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .textAlign(TextAlign.Center)
        .lineHeight(44)
        .margin({ bottom: 8 })

      Text('The home for your thoughts')
        .fontSize(28)
        .fontWeight(FontWeight.Medium)
        .fontColor('#424242')
        .textAlign(TextAlign.Center)
        .lineHeight(36)
        .margin({ bottom: 30 })

      // Details Texts
      Text('This app is your canvas for capturing your thoughts, feelings, ideas and all you can imagine.')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .textAlign(TextAlign.Center)
        .lineHeight(26)
        .margin({ left: 20, right: 20, bottom: 16 })

      Text('Feel free to write anything you like. Your data is securely stored on your device and can be protected with authentication if you choose.')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .textAlign(TextAlign.Center)
        .lineHeight(26)
        .margin({ left: 20, right: 20, bottom: 12 })

      Text('Enjoy it! 🫶🏼')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .textAlign(TextAlign.Center)
        .margin({ bottom: 20 })

      // Dismiss Button
      Button('Great!', { type: ButtonType.Capsule })
        .width('90%')
        .height(50)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .backgroundColor('#F5F5F5')
        .border({ width: 1, color: '#E0E0E0' })
        .borderRadius(25)
        .shadow({ radius: 8, color: '#00000010', offsetX: 0, offsetY: 2 })
        .onClick(() => {
          // Handle dismiss action here
        })
    }
    .width('100%')
    .height('100%')
    .padding({ top: 40 })
    .backgroundColor('#FAFAFA')
  }
}