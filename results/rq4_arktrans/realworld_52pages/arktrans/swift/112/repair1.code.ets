@Entry
@Component
struct Index {
  build() {
    Stack() {
      // === ZStack ===
      Stack({ alignContent: Alignment.Center }) {
        // === AnimatedGradientView ===
        // Simulating gradient background with a colored container
        Column() {
          Text('')
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#F2E8D9') // Approximating the warm beige tone from screenshot
        .opacity(0.9)

        // === ScrollView ===
        Scroll() {
          // === VStack ===
          Column({ space: 24 }) {
            Blank().layoutWeight(1)

            // Icon Area
            Image($r('app.media.startIcon'))
              .width(120)
              .height(120)
              .borderRadius(30)
              .shadow({ radius: 20, color: '#33000000', offsetY: 10 })

            // Title Section
            Column({ space: 8 }) {
              Text('Welcome to CleanPad')
                .fontSize(36)
                .fontWeight(FontWeight.Bold)
                .fontColor('#1A1A1A')
                .textAlign(TextAlign.Center)
                .lineHeight(44)
              
              Text('The home for your thoughts')
                .fontSize(28)
                .fontWeight(FontWeight.Medium)
                .fontColor('#555555')
                .textAlign(TextAlign.Center)
                .lineHeight(36)
            }

            // Description Section
            Column({ space: 16 }) {
              Text('This app is your canvas for capturing your thoughts, feelings, ideas and all you can imagine.')
                .fontSize(18)
                .fontColor('#1A1A1A')
                .textAlign(TextAlign.Center)
                .lineHeight(28)
                .letterSpacing(0.5)

              Text('Feel free to write anything you like. Your data is securely stored on your device and can be protected with authentication if you choose.')
                .fontSize(18)
                .fontColor('#1A1A1A')
                .textAlign(TextAlign.Center)
                .lineHeight(28)
                .letterSpacing(0.5)
                
              Text('Enjoy it! 🤎')
                .fontSize(18)
                .fontColor('#1A1A1A')
                .textAlign(TextAlign.Center)
            }

            Blank().layoutWeight(1)
          }
          .width('100%')
          .padding({ left: 32, right: 32, top: 40, bottom: 100 })
        }.width('100%').height('100%')

        // === Bottom Button Overlay (Simulated from screenshot visual) ===
        Column() {
          Button() {
            Text('Great!')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1A1A1A')
          }
          .width('85%')
          .height(56)
          .backgroundColor('#FFFFFF')
          .borderRadius(28)
          .shadow({ radius: 10, color: '#22000000', offsetY: 4 })
          .margin({ bottom: 40 })
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.End)
        .width('100%')
        .height('100%')
        
      }.width('100%').height('100%')
    }.width('100%').height('100%')
  }
}