@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column({ space: 0 }) {
        Text('QUICK ACTIONS')
          .padding({ bottom: 8 }) // Approximation for Dimensions.quickActionsTitleBottomPadding
          .fontColor('#999999')   // Approximation for .textGray
          .fontSize(12)           // Approximation for Dimensions.fontSizeLabelSmall
          .fontWeight(FontWeight.Bold)

        Row({ space: 16 }) { // Approximation for Dimensions.quickActionsRowSpacing
          // Card 1
          Column() {
            Image($r('app.media.startIcon'))
              .width(24) // Approximation for Dimensions.quickActionCardIconSize
              .height(24)
              .padding({ bottom: 8 })
              .fillColor('#000000') // Approximation for .textBlack (assuming !isActive default or static)
            
            Blank()

            Column() {
              Text('Label')
                .fontColor('#000000')
                .fontSize(14) // Approximation for Dimensions.fontSizeLabelMedium
                .fontWeight(FontWeight.Medium)
              
              Text('Status')
                .fontColor('#999999')
                .fontSize(12) // Approximation for Dimensions.fontSizeBodySmall
                .fontWeight(FontWeight.Regular)
            }
          }
          .width('50%') // Approximation for maxWidth: .infinity within row
          .height(100)  // Approximation for Dimensions.quickActionCardHeight
          .padding(16)  // Approximation for Dimensions.quickActionCardPadding
          .borderRadius(12) // Approximation for Dimensions.quickActionCardCornerRadius
          .backgroundColor('#F5F5F5') // Approximation for Color.softGrayBg

          // Card 2
          Column() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .padding({ bottom: 8 })
              .fillColor('#000000')
            
            Blank()

            Column() {
              Text('Label')
                .fontColor('#000000')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
              
              Text('Status')
                .fontColor('#999999')
                .fontSize(12)
                .fontWeight(FontWeight.Regular)
            }
          }
          .width('50%')
          .height(100)
          .padding(16)
          .borderRadius(12)
          .backgroundColor('#F5F5F5')
        }

        Blank().height(16) // Approximation for Dimensions.quickActionsRowSpacing

        Row({ space: 16 }) {
          // Card 3
          Column() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .padding({ bottom: 8 })
              .fillColor('#000000')
            
            Blank()

            Column() {
              Text('Label')
                .fontColor('#000000')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
              
              Text('Status')
                .fontColor('#999999')
                .fontSize(12)
                .fontWeight(FontWeight.Regular)
            }
          }
          .width('50%')
          .height(100)
          .padding(16)
          .borderRadius(12)
          .backgroundColor('#F5F5F5')

          // Card 4
          Column() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .padding({ bottom: 8 })
              .fillColor('#000000')
            
            Blank()

            Column() {
              Text('Label')
                .fontColor('#000000')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
              
              Text('Status')
                .fontColor('#999999')
                .fontSize(12)
                .fontWeight(FontWeight.Regular)
            }
          }
          .width('50%')
          .height(100)
          .padding(16)
          .borderRadius(12)
          .backgroundColor('#F5F5F5')
        }
      }.width('100%').alignItems(HorizontalAlign.Start)
    }.width('100%').height('100%')
  }
}