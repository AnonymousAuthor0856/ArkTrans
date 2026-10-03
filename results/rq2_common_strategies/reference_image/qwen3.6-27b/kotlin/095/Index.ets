@Entry
@Component
struct PaymentSuccessPage {
  @State amount: string = '$1,249.00'

  build() {
    Column() {
      // --- Header Section ---
      Column() {
        // Success Icon
        Row() {
          Image($r('app.media.ic_check')) // Assuming a check icon exists, or use Symbol
            .width(36)
            .height(36)
            .fillColor(Color('#2E7D32'))
        }
        .width(72)
        .height(72)
        .backgroundColor(Color('#E8F5E9'))
        .borderRadius(36)
        .justifyContent(FlexAlign.Center)

        Text('Payment Success')
          .fontSize(18)
          .fontColor(Color.Gray)
          .margin({ top: 16 })

        Text(this.amount)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Center)
      .margin({ top: 40 })

      // --- Receipt Card ---
      Column() {
        // To Merchant Row
        Row() {
          Row() {
            Image($r('app.media.ic_info')) // Placeholder for Info icon
              .width(18)
              .height(18)
              .fillColor(Color.Gray)
            Text('To Merchant')
              .fontSize(16)
              .fontColor(Color.Gray)
              .margin({ left: 8 })
          }
          Text('TechSpace Solutions')
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(Color.Black)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ top: 20, bottom: 16 })

        Divider().color(Color('#E0E0E0'))

        // Date Row
        Row() {
          Row() {
            Image($r('app.media.ic_calendar')) // Placeholder for Calendar icon
              .width(18)
              .height(18)
              .fillColor(Color.Gray)
            Text('Date')
              .fontSize(16)
              .fontColor(Color.Gray)
              .margin({ left: 8 })
          }
          Text('Dec 02, 2025 - 11:30 PM')
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(Color.Black)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ top: 16, bottom: 16 })

        Divider().color(Color('#E0E0E0'))

        // Ref Number Row
        Row() {
          Text('Ref Number')
            .fontSize(16)
            .fontColor(Color.Gray)
          Text('009281-XX-99')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ top: 16, bottom: 16 })

        // Payment Method Row
        Row() {
          Text('Payment Method')
            .fontSize(16)
            .fontColor(Color.Gray)
          Text('Credit Card •••• 4242')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ top: 0, bottom: 20 })
      }
      .width('100%')
      .backgroundColor(Color('#F8F9FA'))
      .borderRadius(12)
      .border({ width: 1, color: Color('#EEEEEE') })
      .margin({ top: 32 })

      Blank() // Spacer to push buttons down

      // --- Action Buttons ---
      Column() {
        // Done Button
        Button('Done')
          .width('100%')
          .height(50)
          .backgroundColor(Color.Black)
          .fontColor(Color.White)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .borderRadius(8)

        // Share Receipt Button
        Button() {
          Row() {
            Image($r('app.media.ic_share')) // Placeholder for Share icon
              .width(18)
              .height(18)
              .fillColor(Color.Black)
            Text('Share Receipt')
              .fontSize(18)
              .fontColor(Color.Black)
              .margin({ left: 8 })
          }
        }
        .width('100%')
        .height(50)
        .backgroundColor(Color.Transparent)
        .border({ width: 1, color: Color('#DDDDDD'), radius: 8 })
        .margin({ top: 12 })
      }
      .margin({ bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
  }
}