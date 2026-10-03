@Entry
@Component
struct ReceiptScreen {
  build() {
    Column() {
      // --- Header Section ---
      Column() {
        // Success Icon - green circle with checkmark
        Stack({ alignContent: Alignment.Center }) {
          Circle({ width: 72, height: 72 })
            .fill('#E8F5E9')
          Text('✓')
            .fontSize(36)
            .fontColor('#2E7D32')
            .fontWeight(FontWeight.Bold)
        }
        .width(72)
        .height(72)
        .margin({ top: 20 })

        Text('Payment Success')
          .fontSize(16)
          .fontColor('#888888')
          .margin({ top: 16 })

        Text('$1,249.00')
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .margin({ top: 8 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)

      // --- Receipt Card ---
      Column() {
        // Recipient
        Row() {
          Row() {
            Text('ℹ')
              .fontSize(18)
              .fontColor('#888888')
            Text('To Merchant')
              .fontSize(14)
              .fontColor('#888888')
              .margin({ left: 8 })
          }
          .alignItems(VerticalAlign.Center)

          Text('TechSpace Solutions')
            .fontSize(14)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Divider()
          .color('#E0E0E0')
          .margin({ top: 16, bottom: 16 })

        // Date
        Row() {
          Row() {
            Text('\u{1F4C5}')
              .fontSize(18)
              .fontColor('#888888')
            Text('Date')
              .fontSize(14)
              .fontColor('#888888')
              .margin({ left: 8 })
          }
          .alignItems(VerticalAlign.Center)

          Text('Dec 02, 2025 - 11:30 PM')
            .fontSize(14)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Divider()
          .color('#E0E0E0')
          .margin({ top: 16, bottom: 16 })

        // Transaction ID
        Row() {
          Text('Ref Number')
            .fontSize(14)
            .fontColor('#888888')
          Text('009281-XX-99')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        // Payment Method
        Row() {
          Text('Payment Method')
            .fontSize(14)
            .fontColor('#888888')
          Text('Credit Card •••• 4242')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: 16 })
      }
      .width('100%')
      .padding(20)
      .backgroundColor('#F8F9FA')
      .borderRadius(12)
      .border({ width: 1, color: '#EEEEEE' })
      .margin({ top: 32 })

      // --- Spacer to push buttons down ---
      Blank()

      // --- Action Buttons ---
      Column() {
        Button('Done')
          .width('100%')
          .height(50)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .backgroundColor('#000000')
          .borderRadius(8)

        Button() {
          Row() {
            Text('\u{1F4E4}')
              .fontSize(18)
              .fontColor('#000000')
            Text('Share Receipt')
              .fontSize(16)
              .fontColor('#000000')
              .margin({ left: 8 })
          }
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .height(50)
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
        .border({ width: 1, color: '#DDDDDD' })
        .margin({ top: 12 })
      }
      .width('100%')
      .margin({ bottom: 16 })
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
  }
}
