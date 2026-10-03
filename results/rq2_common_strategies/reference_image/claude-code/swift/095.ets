@Entry
@Component
struct ReceiptScreen {
  build() {
    Stack() {
      Column() {
        // Success Icon
        Stack() {
          Circle({ width: 72, height: 72 })
            .fill('#E8F5E9')

          Text('✓')
            .fontSize(36)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E7D32')
        }
        .margin({ top: 20 })

        Text('Payment Success')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#888888')
          .margin({ top: 16 })

        Text('$1,249.00')
          .fontSize(45)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .margin({ top: 8 })

        // Receipt Card
        Column() {
          // To Merchant row
          Row() {
            Row() {
              Text('ⓘ')
                .fontSize(18)
                .fontColor('#888888')
                .margin({ right: 8 })

              Text('To Merchant')
                .fontSize(14)
                .fontColor('#888888')
            }

            Blank()

            Text('TechSpace Solutions')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
          }
          .width('100%')

          Divider()
            .color('#E0E0E0')
            .strokeWidth(1)
            .margin({ top: 16, bottom: 16 })

          // Date row
          Row() {
            Row() {
              Text('\u{1F5D3}')
                .fontSize(18)
                .fontColor('#888888')
                .margin({ right: 8 })

              Text('Date')
                .fontSize(14)
                .fontColor('#888888')
            }

            Blank()

            Text('Dec 02, 2025 - 11:30 PM')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
          }
          .width('100%')

          Divider()
            .color('#E0E0E0')
            .strokeWidth(1)
            .margin({ top: 16, bottom: 16 })

          // Ref Number row
          Row() {
            Text('Ref Number')
              .fontSize(14)
              .fontColor('#888888')

            Blank()

            Text('009281-XX-99')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
          }
          .width('100%')

          // Payment Method row
          Row() {
            Text('Payment Method')
              .fontSize(14)
              .fontColor('#888888')

            Blank()

            Text('Credit Card •••• 4242')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
          }
          .width('100%')
          .margin({ top: 16 })
        }
        .width('100%')
        .padding(20)
        .backgroundColor('#F8F9FA')
        .borderRadius(12)
        .border({ width: 1, color: '#EEEEEE' })
        .margin({ top: 32 })

        Blank()

        // Action Buttons
        Column() {
          Button('Done')
            .width('100%')
            .height(50)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .backgroundColor('#000000')
            .borderRadius(8)
            .onClick(() => {})

          Button() {
            Row() {
              Text('\u{21AA}')
                .fontSize(18)
                .fontColor('#000000')
                .margin({ right: 8 })

              Text('Share Receipt')
                .fontSize(16)
                .fontColor('#000000')
            }
          }
          .width('100%')
          .height(50)
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .border({ width: 1, color: '#DDDDDD' })
          .margin({ top: 12 })
          .onClick(() => {})
        }
        .width('100%')
        .margin({ bottom: 16 })
      }
      .width('100%')
      .height('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
