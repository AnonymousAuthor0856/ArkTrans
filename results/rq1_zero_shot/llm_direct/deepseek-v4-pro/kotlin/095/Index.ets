@Entry
@Component
struct ReceiptScreen {
  build() {
    Column() {
      Column() {
        // Header Section
        Row() {
          Column({ space: 20 }) {
            // Success Icon
            Row() {
              Stack({ alignContent: Alignment.Center }) {
                Circle()
                  .fill(Color(0xFFE8F5E9))
                  .width(72)
                  .height(72)
                Text('✓')
                  .fontSize(36)
                  .fontColor(Color(0xFF2E7D32))
                  .fontWeight(FontWeight.Bold)
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)

            // Payment Success Text
            Text('Payment Success')
              .fontSize(16)
              .fontColor(Color.Gray)
              .textAlign(TextAlign.Center)
              .width('100%')

            // Amount
            Text('$1,249.00')
              .fontSize(36)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .textAlign(TextAlign.Center)
              .width('100%')
          }
        }
        .width('100%')
        .padding({ top: 40, bottom: 32 })

        // Receipt Card
        Column() {
          Column({ space: 16 }) {
            // To Merchant
            Row() {
              Row({ space: 8 }) {
                Text('ℹ')
                  .fontSize(18)
                  .fontColor(Color.Gray)
                Text('To Merchant')
                  .fontSize(14)
                  .fontColor(Color.Gray)
              }
              Text('TechSpace Solutions')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.Black)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

            Divider()
              .color(Color(0xFFE0E0E0))
              .strokeWidth(1)

            // Date
            Row() {
              Row({ space: 8 }) {
                Text('📅')
                  .fontSize(18)
                  .fontColor(Color.Gray)
                Text('Date')
                  .fontSize(14)
                  .fontColor(Color.Gray)
              }
              Text('Dec 02, 2025 - 11:30 PM')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.Black)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

            Divider()
              .color(Color(0xFFE0E0E0))
              .strokeWidth(1)

            // Ref Number
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
            .alignItems(VerticalAlign.Center)

            // Payment Method
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
            .alignItems(VerticalAlign.Center)
          }
          .padding(20)
        }
        .width('100%')
        .backgroundColor(Color(0xFFF8F9FA))
        .borderRadius(12)
        .border({ width: 1, color: Color(0xFFEEEEEE) })

        Blank()
          .height(32)

        // Action Buttons
        Column({ space: 12 }) {
          Button('Done')
            .width('100%')
            .height(50)
            .backgroundColor(Color.Black)
            .fontColor(Color.White)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .borderRadius(8)

          Button() {
            Row({ space: 8 }) {
              Text('↗')
                .fontSize(18)
                .fontColor(Color.Black)
              Text('Share Receipt')
                .fontSize(16)
                .fontColor(Color.Black)
            }
          }
          .width('100%')
          .height(50)
          .backgroundColor(Color.White)
          .borderRadius(8)
          .border({ width: 1, color: Color(0xFFDDDDDD) })
        }
        .width('100%')
      }
      .padding({ left: 24, right: 24, top: 20, bottom: 16 })
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}