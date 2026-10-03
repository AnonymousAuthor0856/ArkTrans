@Entry
@Component
struct FurnitureApp {
  build() {
    Column() {
      // === ZStack (Root) ===
      Stack() {
        // Background
        Column().width('100%').height('100%').backgroundColor('#FFFFFF')

        // Main Content Column
        Column({ space: 0 }) {
          // Header
          Row() {
            Button() {
              Image($r('app.media.startIcon'))
                .width(24).height(24).objectFit(ImageFit.Contain)
                .fillColor('#000000')
            }
            .width(48).height(48)
            .borderRadius(24)
            .border({ width: 1, color: '#E0E0E0' })
            .margin({ right: 'auto', left: 0 }) // Spacer equivalent logic handled by layout or margins if needed, but here we use explicit spacing in parent usually. 
            // Note: In ArkTS Row, to mimic HStack with Spacers, we often use layoutWeight on children or fixed widths.
            // The SwiftUI code uses Spacers. Let's replicate the visual structure.
            
            Text('Details')
              .fontSize(18).fontWeight(FontWeight.Medium).fontColor('#000000')
              .textAlign(TextAlign.Center)
              .layoutWeight(1) // Acts as spacer between buttons
            
            Button() {
              Image($r('app.media.startIcon'))
                .width(24).height(24).objectFit(ImageFit.Contain)
                .fillColor('#000000')
            }
            .width(48).height(48)
            .borderRadius(24)
            .border({ width: 1, color: '#E0E0E0' })
          }
          .width('100%').padding({ top: 16, left: 24, right: 24 })

          // Scrollable Content
          Scroll() {
            Column({ space: 0 }) {
              Blank().height(24)

              // Product Image Placeholder
              Stack() {
                Column().width('100%').height('100%').backgroundColor('#F5F5F5').borderRadius(32)
                
                Image($r('app.media.startIcon'))
                  .width(80).height(80).objectFit(ImageFit.Contain)
                  .fillColor('#BDBDBD')
              }
              .width('100%').height(300)

              Blank().height(32)

              // Product Info Section
              Column({ space: 0 }) {
                // Title & Price Row
                Row() {
                  Column({ space: 8 }) {
                    Text('Modern Lounge\nChair')
                      .fontSize(26).fontWeight(FontWeight.Bold).fontColor('#000000')
                      .lineHeight(32) // Approximating lineSpacing
                    
                    Text('Minimalist Series')
                      .fontSize(16).fontColor('#999999')
                  }
                  
                  Text('$1299')
                    .fontSize(24).fontWeight(FontWeight.Bold).fontColor('#000000')
                    .layoutWeight(1) // Pushes to right
                    .textAlign(TextAlign.End)
                }

                Blank().height(24)

                // Rating Row
                Row() {
                  Image($r('app.media.startIcon'))
                    .width(20).height(20).objectFit(ImageFit.Contain)
                    .fillColor('#FFC107')
                  
                  Text('4.8')
                    .fontSize(16).fontWeight(FontWeight.Bold).fontColor('#000000')
                    .margin({ left: 4 })
                  
                  Text('(238 Reviews)')
                    .fontSize(14).fontColor('#999999')
                    .margin({ left: 8 })
                }

                Blank().height(24)

                // Colors Section
                Text('Colors')
                  .fontSize(18).fontWeight(FontWeight.Medium).fontColor('#000000')
                
                Blank().height(12)

                Row({ space: 12 }) {
                  // Color Selector 1 (Selected)
                  Stack() {
                    Column().width(32).height(32).backgroundColor('#212121').borderRadius(16)
                    Column().width(32).height(32).borderRadius(16).border({ width: 2, color: '#808080' }) // Gray opacity approx
                    Column().width(10).height(10).backgroundColor('#FFFFFF').borderRadius(5)
                  }

                  // Color Selector 2
                  Stack() {
                    Column().width(32).height(32).backgroundColor('#795548').borderRadius(16)
                  }

                  // Color Selector 3
                  Stack() {
                    Column().width(32).height(32).backgroundColor('#9E9E9E').borderRadius(16)
                  }
                }
              }

              Blank().height(24)
            }
            .padding({ left: 24, right: 24 })
          }
          .layoutWeight(1) // Takes up remaining space

          // Bottom Actions
          Row({ space: 16 }) {
            Button('Add to Cart')
              .fontSize(16).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
              .backgroundColor('#000000')
              .borderRadius(16)
              .height(56)
              .layoutWeight(1)

            Stack() {
              Column().width(56).height(56).backgroundColor('#F5F5F5').borderRadius(16)
              Image($r('app.media.startIcon'))
                .width(24).height(24).objectFit(ImageFit.Contain)
                .fillColor('#000000')
            }
          }
          .width('100%').padding({ bottom: 24, left: 24, right: 24 })
        }
        .width('100%').height('100%')
      }
      .width('100%').height('100%')
    }
    .width('100%').height('100%')
  }
}