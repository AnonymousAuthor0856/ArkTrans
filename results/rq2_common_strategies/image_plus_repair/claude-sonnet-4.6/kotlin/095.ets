// entry/src/main/ets/pages/Index.ets

@Entry
@Component
struct ReceiptScreen {
  build() {
    Column({ space: 0 }) {
      // Header Section
      Blank().height(20)

      // Success Icon
      Stack({ alignContent: Alignment.Center }) {
        Circle({ width: 72, height: 72 })
          .fill('#E8F5E9')

        Text('✓')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E7D32')
      }
      .width(72)
      .height(72)

      Blank().height(16)

      Text('Payment Success')
        .fontSize(16)
        .fontColor('#9E9E9E')
        .fontWeight(FontWeight.Medium)

      Blank().height(8)

      Text('$1,249.00')
        .fontSize(45)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Blank().height(32)

      // Receipt Card
      ReceiptDetailsCard()

      Blank().layoutWeight(1)

      // Action Buttons
      ActionButtons()

      Blank().height(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ReceiptDetailsCard {
  build() {
    Column({ space: 0 }) {
      // To Merchant Row
      Row() {
        Row({ space: 8 }) {
          Text('ℹ')
            .fontSize(16)
            .fontColor('#9E9E9E')
            .width(18)
            .height(18)
            .textAlign(TextAlign.Center)

          Text('To Merchant')
            .fontSize(14)
            .fontColor('#9E9E9E')
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
            .fontSize(14)
            .fontColor('#9E9E9E')
            .width(18)
            .height(18)
            .textAlign(TextAlign.Center)

          Text('Date')
            .fontSize(14)
            .fontColor('#9E9E9E')
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
          .fontColor('#9E9E9E')

        Text('009281-XX-99')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ top: 16, bottom: 8 })

      // Payment Method Row
      Row() {
        Text('Payment Method')
          .fontSize(14)
          .fontColor('#9E9E9E')

        Text('Credit Card •••• 4242')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ top: 8, bottom: 4 })
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#F8F9FA')
    .borderRadius(12)
    .border({ width: 1, color: '#EEEEEE' })
  }
}

@Component
struct ActionButtons {
  build() {
    Column({ space: 12 }) {
      // Done Button
      Button('Done')
        .width('100%')
        .height(50)
        .backgroundColor('#000000')
        .fontColor('#FFFFFF')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .borderRadius(8)

      // Share Receipt Button
      Row({ space: 8 }) {
        Text('⤴')
          .fontSize(18)
          .fontColor('#000000')

        Text('Share Receipt')
          .fontSize(16)
          .fontColor('#000000')
      }
      .width('100%')
      .height(50)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .border({ width: 1, color: '#DDDDDD' })
      .borderRadius(8)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
  }
}