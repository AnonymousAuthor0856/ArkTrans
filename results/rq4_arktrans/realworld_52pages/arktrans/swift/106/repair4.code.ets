@Entry
@Component
struct Index {
  build() {
    Stack() {
      // === ZStack ===
      Stack({ alignContent: Alignment.Center }) {
        // === ScrollView ===
        Scroll() {
          // === HStack ===
          Row() {
            .width('100%')
            .height('100%')

            // === VStack ===
            Column({ alignItems: HorizontalAlign.Start }) {
              Blank()
              Blank()
              Blank()
            }
            Blank()
          }
        }

        // === VStack ===
        Column() {
          // === HStack ===
          Row() {
            Blank()
            // DismissViewButton
            Button() {
              Text('✕').fontColor(Color.White).fontSize(24)
            }
            .backgroundColor('#8E8E93')
            .borderRadius(20)
            .width(40)
            .height(40)
            .margin({ top: 50, right: 20 })
          }

          Blank()

          // === VStack (Content) ===
          Column() {
            .padding(20)
            .alignItems(HorizontalAlign.Start)

            // Title
            Text('Hello! 👋')
              .fontSize(48)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
              .margin({ bottom: 8 })

            // Subtitle
            Text("I'm Uriel Ortega.")
              .fontSize(36)
              .fontWeight(FontWeight.Medium)
              .fontColor('#8E8E93')
              .margin({ bottom: 24 })

            // Body Text 1
            Text('Feel free to reach out and share your thoughts with me!\nWhether it\'s a bug report, a suggestion,\nor just a friendly chat—I\'m here for you.')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
              .lineHeight(32)
              .margin({ bottom: 16 })

            // Body Text 2
            Text('If you enjoy using the app and would like to support my work, you can also buy me a coffee. Every sip fuels more improvements for this and future apps. Thank you! ☕️✨')
              .fontSize(18)
              .fontColor('#000000')
              .lineHeight(26)
              .margin({ bottom: 40 })

            // Buttons Container
            Column() {
              .width('100%')
              .space(16)

              // iMessage Button
              Button() {
                Row() {
                  Text('💬').fontSize(24).margin({ right: 12 })
                  Text('iMessage Me').fontSize(20).fontColor(Color.White).fontWeight(FontWeight.Medium)
                }.justifyContent(FlexAlign.Center)
              }
              .backgroundColor('#34C759')
              .borderRadius(50)
              .height(60)
              .shadow({ radius: 10, color: '#00000020', offsetY: 4 })

              // Coffee Button
              Button() {
                Row() {
                  Text('☕️').fontSize(24).margin({ right: 12 })
                  Text('Buy Me A Coffee').fontSize(20).fontColor(Color.White).fontWeight(FontWeight.Medium)
                }.justifyContent(FlexAlign.Center)
              }
              .backgroundColor('#2C2C2E')
              .borderRadius(50)
              .height(60)
              .shadow({ radius: 10, color: '#00000020', offsetY: 4 })
            }
          }
        }
      }
    }.width('100%').height('100%')
  }
}