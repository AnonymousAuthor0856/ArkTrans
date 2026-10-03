@Entry
@Component
struct ReceiptScreen {
  build() {
    Column() {
      // Header Section
      Column({ space: 16 }) {
        // Success Icon
        Row() {
          Image($r('app.media.startIcon'))
            .width(36)
            .height(36)
            .objectFit(ImageFit.Contain)
            .fillColor('#2E7D32')
        }
        .width(72)
        .height(72)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor('#E8F5E9')
        .borderRadius(36)

        Text('Payment Success')
          .fontSize(16)
          .fontColor('#808080')

        Text('$1,249.00')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .margin({ top: 20, bottom: 32 })

      // Receipt Card
      Column({ space: 16 }) {
        // To Merchant
        Row() {
          Row({ space: 8 }) {
            Image($r('app.media.startIcon'))
              .width(18)
              .height(18)
              .objectFit(ImageFit.Contain)
              .fillColor('#808080')
            Text('To Merchant')
              .fontSize(14)
              .fontColor('#808080')
          }
          Blank()
          Text('TechSpace Solutions')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')

        Divider().color('#E0E0E0')

        // Date
        Row() {
          Row({ space: 8 }) {
            Image($r('app.media.startIcon'))
              .width(18)
              .height(18)
              .objectFit(ImageFit.Contain)
              .fillColor('#808080')
            Text('Date')
              .fontSize(14)
              .fontColor('#808080')
          }
          Blank()
          Text('Dec 02, 2025 - 11:30 PM')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')

        Divider().color('#E0E0E0')

        // Ref Number
        Row() {
          Text('Ref Number')
            .fontSize(14)
            .fontColor('#808080')
          Blank()
          Text('009281-XX-99')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')

        // Payment Method
        Row() {
          Text('Payment Method')
            .fontSize(14)
            .fontColor('#808080')
          Blank()
          Text('Credit Card •••• 4242')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')
      }
      .width('100%')
      .padding(20)
      .backgroundColor('#F8F9FA')
      .borderRadius(12)
      .border({ width: 1, color: '#EEEEEE' })

      Blank()

      // Action Buttons
      Column({ space: 12 }) {
        Button('Done')
          .width('100%')
          .height(50)
          .backgroundColor('#000000')
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold)
          .fontSize(16)
          .borderRadius(8)

        Button() {
          Row({ space: 8 }) {
            Image($r('app.media.startIcon'))
              .width(18)
              .height(18)
              .objectFit(ImageFit.Contain)
              .fillColor('#000000')
            Text('Share Receipt')
              .fontSize(16)
              .fontColor('#000000')
          }
        }
        .width('100%')
        .height(50)
        .backgroundColor('#FFFFFF')
        .border({ width: 1, color: '#DDDDDD' })
        .borderRadius(8)
      }
      .margin({ bottom: 16 })
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
    .alignItems(HorizontalAlign.Center)
  }
}