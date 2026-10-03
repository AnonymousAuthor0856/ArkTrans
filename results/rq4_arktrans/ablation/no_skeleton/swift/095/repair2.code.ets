@Entry
@Component
struct ReceiptScreen {
  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column() {
        // Header Section
        Column() {
          // Success Icon
          Row() {
            Image($r('app.media.startIcon'))
              .width(36)
              .height(36)
              .fillColor('#2E7D32')
          }
          .width(72)
          .height(72)
          .backgroundColor('#E8F5E9')
          .borderRadius(36)
          .justifyContent(FlexAlign.Center)

          Text('Payment Success')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#9E9E9E')
            .margin({ top: 16 })

          Text('$1,249.00')
            .fontSize(45)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .margin({ top: 8 })
        }
        .alignItems(HorizontalAlign.Center)
        .margin({ bottom: 32 })

        // Receipt Card
        Column() {
          // To Merchant
          Row() {
            Row({ space: 8 }) {
              Image($r('app.media.startIcon'))
                .width(18)
                .height(18)
                .fillColor('#9E9E9E')
              Text('To Merchant')
                .fontSize(14)
                .fontColor('#9E9E9E')
            }
            Blank()
            Text('TechSpace Solutions')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
          }
          .width('100%')

          Divider().color('#E0E0E0').margin({ top: 16, bottom: 16 })

          // Date
          Row() {
            Row({ space: 8 }) {
              Image($r('app.media.startIcon'))
                .width(18)
                .height(18)
                .fillColor('#9E9E9E')
              Text('Date')
                .fontSize(14)
                .fontColor('#9E9E9E')
            }
            Blank()
            Text('Dec 02, 2025 - 11:30 PM')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
          }
          .width('100%')

          Divider().color('#E0E0E0').margin({ top: 16, bottom: 16 })

          // Ref Number
          Row() {
            Text('Ref Number')
              .fontSize(14)
              .fontColor('#9E9E9E')
            Blank()
            Text('009281-XX-99')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
          }
          .width('100%')
          .margin({ bottom: 16 })

          // Payment Method
          Row() {
            Text('Payment Method')
              .fontSize(14)
              .fontColor('#9E9E9E')
            Blank()
            Text('Credit Card •••• 4242')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
          }
          .width('100%')
        }
        .padding(20)
        .width('100%')
        .backgroundColor('#F8F9FA')
        .borderRadius(12)
        .border({ width: 1, color: '#EEEEEE', radius: 12 })
        .margin({ bottom: 32 })

        // Action Buttons
        Column({ space: 12 }) {
          Button() {
            Text('Done')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
          }
          .width('100%')
          .height(50)
          .backgroundColor('#000000')
          .borderRadius(8)

          Button() {
            Row({ space: 8 }) {
              Image($r('app.media.startIcon'))
                .width(18)
                .height(18)
                .fillColor('#000000')
              Text('Share Receipt')
                .fontSize(16)
                .fontColor('#000000')
            }
            .justifyContent(FlexAlign.Center)
            .width('100%')
          }
          .width('100%')
          .height(50)
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .border({ width: 1, color: '#DDDDDD', radius: 8 })
        }
        .width('100%')
      }
      .width('100%')
      .padding(24)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}