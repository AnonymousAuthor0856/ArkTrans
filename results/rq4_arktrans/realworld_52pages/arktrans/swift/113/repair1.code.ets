@Entry
@Component
struct Index {
  build() {
    Stack() {
      // === ZStack ===
      Stack({ alignContent: Alignment.Center }) {
        // === AnimatedGradientView ===
        // Simulating gradient background with a colored rectangle and opacity
        Column() {
          Text('')
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#F2E8D5') // Approximating the warm gradient tone
        .opacity(0.9)

        // === ScrollView ===
        Scroll() {
          // === VStack ===
          Column({ space: 40 }) {
            Blank().layoutWeight(1)

            // Title Section
            Column() {
              Text("What's New")
                .fontSize(36)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
                .textAlign(TextAlign.Start)
              
              Text("in CleanPad")
                .fontSize(36)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
                .textAlign(TextAlign.Start)
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .margin({ top: 60, bottom: 20 })

            // Feature 1
            Row() {
              // Icon: List/Burger menu style
              Image($r('app.media.startIcon')) 
                .width(48)
                .height(48)
                .borderRadius(24)
                .backgroundColor('#CBA882')
                .objectFit(ImageFit.Contain)
                .margin({ right: 20 })

              Column() {
                Text("Every thought finds its place")
                  .fontSize(22)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#000000')
                  .lineHeight(28)
                
                Text("Easily create and assign categories to organize your notes better")
                  .fontSize(18)
                  .fontColor('#555555')
                  .lineHeight(26)
                  .margin({ top: 8 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
            }
            .width('100%')

            // Feature 2
            Row() {
              // Icon: Lock style (using startIcon as placeholder per rules, styled differently)
              Image($r('app.media.startIcon'))
                .width(48)
                .height(48)
                .borderRadius(12)
                .backgroundColor('#B89B7A')
                .objectFit(ImageFit.Contain)
                .margin({ right: 20 })

              Column() {
                Text("Your private notes,\nstill personal")
                  .fontSize(22)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#000000')
                  .lineHeight(28)
                
                Text("Personal Notes are now called Private Notes to make things clearer")
                  .fontSize(18)
                  .fontColor('#555555')
                  .lineHeight(26)
                  .margin({ top: 8 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
            }
            .width('100%')

            // Feature 3
            Row() {
              // Icon: Sparkles style (using startIcon as placeholder per rules)
              Image($r('app.media.startIcon'))
                .width(48)
                .height(48)
                .borderRadius(24)
                .backgroundColor('#D4BC9A')
                .objectFit(ImageFit.Contain)
                .margin({ right: 20 })

              Column() {
                Text("A smoother,\ncomfier experience")
                  .fontSize(22)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#000000')
                  .lineHeight(28)
                
                Text("Say hello to a refreshed interface that makes CleanPad smoother, more intuitive, and easier to navigate")
                  .fontSize(18)
                  .fontColor('#555555')
                  .lineHeight(26)
                  .margin({ top: 8 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
            }
            .width('100%')

            Blank().layoutWeight(1)
            
            // Bottom Button Area
            Column() {
               Button() {
                 Text("Great!")
                   .fontSize(20)
                   .fontWeight(FontWeight.Medium)
                   .fontColor('#000000')
               }
               .width('100%')
               .height(56)
               .backgroundColor('#FFFFFF')
               .borderRadius(28)
               .shadow({ radius: 10, color: '#00000020', offsetY: 4 })
               .border({ width: 1, color: '#E0E0E0' })
            }
            .width('100%')
            .margin({ bottom: 40 })

          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .height('100%')
        .scrollBar(BarState.Off)
        
        // Overlay for presentation effect if needed, though standard stack handles layout
        Column() {
           Blank()
        }.width('100%').height('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}