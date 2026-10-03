@Entry
@Component
struct ReceiptScreen {
  @State amount: string = '$1,249.00'

  build() {
    Column() {
      // --- Header Section ---
      Column() {
        // Success Icon
        Row() {
          Image($r('app.media.ic_check'))
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
          .fontColor(Color.Gray)
          .margin({ top: 16 })

        Text(this.amount)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Center)
      .margin({ top: 20 })

      // --- Receipt Card ---
      Column() {
        // To Merchant Row
        Row() {
          Row() {
            Image($r('app.media.ic_info'))
              .width(18)
              .height(18)
              .fillColor(Color.Gray)
            Text('To Merchant')
              .fontSize(14)
              .fontColor(Color.Gray)
              .margin({ left: 8 })
          }
          Text('TechSpace Solutions')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ top: 20, bottom: 16 })

        Divider().color('#E0E0E0')

        // Date Row
        Row() {
          Row() {
            Image($r('app.media.ic_calendar'))
              .width(18)
              .height(18)
              .fillColor(Color.Gray)
            Text('Date')
              .fontSize(14)
              .fontColor(Color.Gray)
              .margin({ left: 8 })
          }
          Text('Dec 02, 2025 - 11:30 PM')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ top: 16, bottom: 16 })

        Divider().color('#E0E0E0')

        // Ref Number Row
        Row() {
          Text('Ref Number')
            .fontSize(14)
            .fontColor(Color.Gray)
          Text('009281-XX-99')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ top: 16, bottom: 16 })

        // Payment Method Row
        Row() {
          Text('Payment Method')
            .fontSize(14)
            .fontColor(Color.Gray)
          Text('Credit Card •••• 4242')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ top: 16, bottom: 20 })
      }
      .width('100%')
      .backgroundColor('#F8F9FA')
      .borderRadius(12)
      .border({ width: 1, color: '#EEEEEE' })
      .margin({ top: 32 })

      Blank() // Spacer to push buttons down

      // --- Action Buttons ---
      Column() {
        // Done Button
        Button('Done')
          .type(ButtonType.Normal)
          .backgroundColor(Color.Black)
          .fontColor(Color.White)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .height(50)
          .borderRadius(8)

        // Share Receipt Button
        Button() {
          Row() {
            Image($r('app.media.ic_share'))
              .width(18)
              .height(18)
              .fillColor(Color.Black)
            Text('Share Receipt')
              .fontSize(16)
              .fontColor(Color.Black)
              .margin({ left: 8 })
          }
        }
        .type(ButtonType.Capsule) // Using Capsule style but overriding border radius manually usually looks better for this specific look
        .backgroundColor(Color.Transparent)
        .border({ width: 1, color: '#DDDDDD', radius: 8 })
        .height(50)
        .margin({ top: 12 })
      }
      .width('100%')
      .margin({ bottom: 16 })
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
  }
}