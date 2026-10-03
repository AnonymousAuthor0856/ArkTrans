@Entry
@Component
struct Index {
  @State paymentSuccess: string = 'Payment Success'
  @State amount: string = '$1,249.00'
  @State refNumber: string = '009281-XX-99'
  @State paymentMethod: string = 'Credit Card •••• 4242'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 0 }) {
        // Spacer
        Blank().height(20)

        // SuccessIcon
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

        // Spacer
        Blank().height(16)

        // Text Payment Success
        Text(this.paymentSuccess)
          .fontSize(16)
          .fontColor('#757575')

        // Spacer
        Blank().height(8)

        // Text Amount
        Text(this.amount)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        // Spacer
        Blank().height(32)

        // ReceiptDetailsCard
        Column() {
          Column({ space: 16 }) {
            // RowDetail To Merchant
            Row({ space: 0 }) {
              Row({ space: 0 }) {
                Image($r('app.media.startIcon'))
                  .width(18)
                  .height(18)
                  .objectFit(ImageFit.Contain)
                  .fillColor('#757575')
                Blank().width(8)
                Text('To Merchant')
                  .fontSize(14)
                  .fontColor('#757575')
              }.alignItems(VerticalAlign.Center)
              Blank().layoutWeight(1)
              Text('TechSpace Solutions')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#000000')
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')

            Divider()
              .vertical(false)
              .color('#E0E0E0')
              .strokeWidth(1)

            // RowDetail Date
            Row({ space: 0 }) {
              Row({ space: 0 }) {
                Image($r('app.media.startIcon'))
                  .width(18)
                  .height(18)
                  .objectFit(ImageFit.Contain)
                  .fillColor('#757575')
                Blank().width(8)
                Text('Date')
                  .fontSize(14)
                  .fontColor('#757575')
              }.alignItems(VerticalAlign.Center)
              Blank().layoutWeight(1)
              Text('Dec 02, 2025 - 11:30 PM')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#000000')
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')

            Divider()
              .vertical(false)
              .color('#E0E0E0')
              .strokeWidth(1)

            // Ref Number
            Row({ space: 0 }) {
              Text('Ref Number')
                .fontSize(14)
                .fontColor('#757575')
              Blank().layoutWeight(1)
              Text(this.refNumber)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#000000')
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')

            // Payment Method
            Row({ space: 0 }) {
              Text('Payment Method')
                .fontSize(14)
                .fontColor('#757575')
              Blank().layoutWeight(1)
              Text(this.paymentMethod)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#000000')
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')
          }
          .padding(20)
        }
        .width('100%')
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })

        // Spacer Weight
        Blank().layoutWeight(1)

        // ActionButtons
        Column({ space: 12 }) {
          // Button Done
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
          .onClick(() => {
            // No logic allowed
          })

          // OutlinedButton Share Receipt
          Button() {
            Row({ space: 0 }) {
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
          }
          .width('100%')
          .height(50)
          .backgroundColor(Color.Transparent)
          .border({ width: 1, color: '#DDDDDD' })
          .borderRadius(8)
          .onClick(() => {
            // No logic allowed
          })
        }

        // Spacer
        Blank().height(16)
      }
      .alignItems(HorizontalAlign.Center)
      .padding(24)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}