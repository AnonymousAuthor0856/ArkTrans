@Entry
@Component
struct Index {
  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column() {
        Blank().height(20)

        // Success Icon
        Stack({ alignContent: Alignment.Center }) {
          Image($r('app.media.startIcon'))
            .width(36)
            .height(36)
            .objectFit(ImageFit.Contain)
            .fillColor('#2E7D32')
        }
        .width(72)
        .height(72)
        .backgroundColor('#E8F5E9')
        .borderRadius(36)

        Blank().height(16)

        Text('Payment Success')
          .fontSize(16)
          .fontColor('#757575')

        Blank().height(8)

        Text('$1,249.00')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Blank().height(32)

        // Receipt Card
        Column() {
          Column({ space: 16 }) {
            // Row 1: To Merchant
            Row() {
              Row() {
                Image($r('app.media.startIcon'))
                  .width(18)
                  .height(18)
                  .objectFit(ImageFit.Contain)
                  .fillColor('#757575')
                Blank().width(8)
                Text('To Merchant')
                  .fontSize(14)
                  .fontColor('#757575')
              }
              .alignItems(VerticalAlign.Center)

              Blank()

              Text('TechSpace Solutions')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#000000')
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)

            Divider()
              .color('#E0E0E0')
              .strokeWidth(1)

            // Row 2: Date
            Row() {
              Row() {
                Image($r('app.media.startIcon'))
                  .width(18)
                  .height(18)
                  .objectFit(ImageFit.Contain)
                  .fillColor('#757575')
                Blank().width(8)
                Text('Date')
                  .fontSize(14)
                  .fontColor('#757575')
              }
              .alignItems(VerticalAlign.Center)

              Blank()

              Text('Dec 02, 2025 - 11:30 PM')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#000000')
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)

            Divider()
              .color('#E0E0E0')
              .strokeWidth(1)

            // Row 3: Ref Number
            Row() {
              Text('Ref Number')
                .fontSize(14)
                .fontColor('#757575')
              Blank()
              Text('009281-XX-99')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#000000')
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)

            // Row 4: Payment Method
            Row() {
              Text('Payment Method')
                .fontSize(14)
                .fontColor('#757575')
              Blank()
              Text('Credit Card •••• 4242')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#000000')
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
          }
          .padding(20)
        }
        .width('100%')
        .backgroundColor('#F8F9FA')
        .borderRadius(12)
        .shadow({ radius: 4, color: '#1A000000' })

        Blank().layoutWeight(1)

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
            Row() {
              Image($r('app.media.startIcon'))
                .width(18)
                .height(18)
                .objectFit(ImageFit.Contain)
                .fillColor('#000000')
              Blank().width(8)
              Text('Share Receipt')
                .fontSize(16)
                .fontColor('#000000')
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .height(50)
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .border({ width: 1, color: '#DDDDDD' })
        }

        Blank().height(16)
      }
      .width('100%')
      .height('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}