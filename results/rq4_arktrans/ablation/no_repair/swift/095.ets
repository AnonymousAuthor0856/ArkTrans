@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Blank().height(20)

        // Success Icon
        Stack() {
          Circle().width(72).height(72).fill('#E8F5E9')
          Image($r('app.media.startIcon'))
            .width(36)
            .height(36)
            .objectFit(ImageFit.Contain)
            .fillColor('#2E7D32')
        }

        Blank().height(16)

        Text('Payment Success')
          .fontColor('#9CA3AF')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)

        Blank().height(8)

        Text('$1,249.00')
          .fontColor('#000000')
          .fontSize(45)
          .fontWeight(FontWeight.Bold)

        Blank().height(32)

        // Details Card
        Column() {
          // Row 1: To Merchant
          Row() {
            Row() {
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .objectFit(ImageFit.Contain)
                .fillColor('#9CA3AF')
              Text('To Merchant')
                .margin({ left: 8 })
                .fontColor('#9CA3AF')
                .fontSize(14)
            }
            Blank()
            Text('TechSpace Solutions')
              .fontColor('#000000')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .padding({ top: 20, bottom: 12 })

          Divider().color('#E5E7EB').strokeWidth(1)

          // Row 2: Date
          Row() {
            Row() {
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .objectFit(ImageFit.Contain)
                .fillColor('#9CA3AF')
              Text('Date')
                .margin({ left: 8 })
                .fontColor('#9CA3AF')
                .fontSize(14)
            }
            Blank()
            Text('Dec 02, 2025 - 11:30 PM')
              .fontColor('#000000')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .padding({ top: 12, bottom: 12 })

          Divider().color('#E5E7EB').strokeWidth(1)

          // Row 3: Ref Number
          Row() {
            Text('Ref Number')
              .fontColor('#9CA3AF')
              .fontSize(14)
            Blank()
            Text('009281-XX-99')
              .fontColor('#000000')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .padding({ top: 12, bottom: 12 })

          // Row 4: Payment Method
          Row() {
            Text('Payment Method')
              .fontColor('#9CA3AF')
              .fontSize(14)
            Blank()
            Text('Credit Card •••• 4242')
              .fontColor('#000000')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .padding({ top: 12, bottom: 20 })

        }
        .width('100%')
        .backgroundColor('#F9FAFB')
        .borderRadius(12)
        .border({ width: 1, color: '#F3F4F6' })

        Blank()

        // Buttons
        Column() {
          Button() {
            Text('Done')
              .fontColor('#FFFFFF')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
          }
          .width('100%')
          .height(50)
          .backgroundColor('#000000')
          .borderRadius(8)

          Button() {
            Row() {
              Image($r('app.media.startIcon'))
                .width(18)
                .height(18)
                .objectFit(ImageFit.Contain)
                .fillColor('#000000')
              Text('Share Receipt')
                .margin({ left: 8 })
                .fontColor('#000000')
                .fontSize(16)
            }
            .justifyContent(FlexAlign.Center)
          }
          .width('100%')
          .height(50)
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .border({ width: 1, color: '#DDDDDD' })
          .margin({ top: 12 })
        }

        Blank().height(16)
      }
      .width('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}