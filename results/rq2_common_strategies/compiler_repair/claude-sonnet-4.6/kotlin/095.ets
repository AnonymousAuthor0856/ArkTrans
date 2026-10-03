@Entry
@Component
struct ReceiptScreen {
  build() {
    Column({space: 0}) {
      Scroll() {
        Column({ space: 0 }) {
          // Header Section
          Column({ space: 0 }) {
            // Success Icon
            Stack({ alignContent: Alignment.Center }) {
              Circle({ width: 72, height: 72 })
                .fill('#E8F5E9')
              Text('✓')
                .fontSize(32)
                .fontColor('#2E7D32')
                .fontWeight(FontWeight.Bold)
            }
            .width(72)
            .height(72)
            .margin({ top: 20, bottom: 16 })

            Text('Payment Success')
              .fontSize(16)
              .fontColor('#888888')
              .margin({ bottom: 8 })

            Text('$1,249.00')
              .fontSize(40)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
              .margin({ bottom: 32 })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)

          // Receipt Card
          Column({ space: 0 }) {
            // To Merchant Row
            Row() {
              Row({ space: 8 }) {
                Text('ℹ')
                  .fontSize(16)
                  .fontColor('#888888')
                Text('To Merchant')
                  .fontSize(14)
                  .fontColor('#888888')
              }
              .alignItems(VerticalAlign.Center)

              Text('TechSpace Solutions')
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .padding({ top: 4, bottom: 16 })

            Divider()
              .color('#E0E0E0')
              .strokeWidth(1)

            // Date Row
            Row() {
              Row({ space: 8 }) {
                Text('📅')
                  .fontSize(16)
                  .fontColor('#888888')
                Text('Date')
                  .fontSize(14)
                  .fontColor('#888888')
              }
              .alignItems(VerticalAlign.Center)

              Text('Dec 02, 2025 - 11:30 PM')
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .padding({ top: 16, bottom: 16 })

            Divider()
              .color('#E0E0E0')
              .strokeWidth(1)

            // Ref Number Row
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
            .alignItems(VerticalAlign.Center)
            .padding({ top: 16, bottom: 16 })

            // Payment Method Row
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
            .alignItems(VerticalAlign.Center)
            .padding({ top: 0, bottom: 4 })
          }
          .width('100%')
          .padding(20)
          .backgroundColor('#F8F9FA')
          .borderRadius(12)
          .border({ width: 1, color: '#EEEEEE' })

          // Spacer
          Column()
            .layoutWeight(1)

          // Action Buttons
          Column({ space: 12 }) {
            Button('Done')
              .width('100%')
              .height(50)
              .backgroundColor('#000000')
              .fontColor('#FFFFFF')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .borderRadius(8)

            Button() {
              Row({ space: 8 }) {
                Text('⬆')
                  .fontSize(16)
                  .fontColor('#000000')
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
          .width('100%')
          .margin({ bottom: 16 })
        }
        .padding(24)
        .width('100%')
        .constraintSize({ minHeight: '100%' })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}