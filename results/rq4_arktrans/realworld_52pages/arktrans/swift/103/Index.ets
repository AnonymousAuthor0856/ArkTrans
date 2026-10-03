@Entry
@Component
struct Index {
  build() {
    Stack() {
      // === ZStack ===
      Stack({ alignContent: Alignment.Center }) {
        // === AnimatedGradientView ===
        // Simulating gradient background with a colored container since custom components aren't available
        Column() {
          Text('')
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#E8F5E9') // Approximating the soft green/white gradient

        // === ScrollView ===
        Scroll() {
          // === VStack ===
          Column() {
            // === Spacer ===
            Blank()
            
            // App Icon Area (Simulated based on screenshot)
            Row() {
              Image($r('app.media.startIcon'))
                .width(120)
                .height(120)
                .borderRadius(30)
                .shadow({ radius: 20, color: '#4D000000', offsetY: 10 })
            }
            .margin({ top: 60, bottom: 40 })

            // Greeting Text
            Text('Good afternoon!')
              .fontSize(42)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
              .textAlign(TextAlign.Center)
              .shadow({ radius: 10, color: '#4D000000' })
              .margin({ bottom: 10 })

            Text('CleanPad is the home\nfor any of your thoughts.')
              .fontSize(32)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .textAlign(TextAlign.Center)
              .lineHeight(42)
              .shadow({ radius: 10, color: '#4D000000' })
              .margin({ bottom: 30 })

            // Body Text
            Text("It's your space to capture it all. Feel free to express yourself.\nYour notes are yours alone, securely stored on your device and optionally protected with authentication.")
              .fontSize(20)
              .fontColor('#FFFFFF')
              .opacity(0.9)
              .textAlign(TextAlign.Center)
              .lineHeight(30)
              .margin({ bottom: 20 })

            Text("Thank you for choosing CleanPad as your trusted companion. Here's to a clutter-free, inspired note-taking journey!")
              .fontSize(20)
              .fontColor('#FFFFFF')
              .opacity(0.9)
              .textAlign(TextAlign.Center)
              .lineHeight(30)

            // === Spacer ===
            Blank()
            // === Spacer ===
            Blank()
          }
          .width('100%')
          .height('100%')
          .padding({ left: 24, right: 24 })
        }

        // === VStack (Overlay UI) ===
        Column() {
          // === HStack ===
          Row() {
            // === Spacer ===
            Blank()
            
            // === DismissViewButton ===
            Button() {
              Text('×')
                .fontSize(24)
                .fontColor('#FFFFFF')
                .fontWeight(FontWeight.Bold)
            }
            .width(40)
            .height(40)
            .borderRadius(20)
            .backgroundColor('#80000000') // Semi-transparent black
            .margin({ top: 50, right: 20 })
          }
          .width('100%')
          
          // === Spacer ===
          Blank()
        }
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}