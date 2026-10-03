@Entry
@Component
struct ReceiptScreen {
  build() {
    Column() {
      Scroll() {
        Column({ space: 0 }) {
          // Spacer
          Column().height(20)

          // Success Icon
          SuccessIcon()

          // Spacer
          Column().height(16)

          // Payment Success text
          Text('Payment Success')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#888888')

          // Spacer
          Column().height(8)

          // Amount
          Text('$1,249.00')
            .fontSize(45)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')

          // Spacer
          Column().height(32)

          // Receipt Card
          ReceiptDetailsCard()

          // Spacer
          Column().height(32)

          // Action Buttons
          ActionButtons()

          // Spacer
          Column().height(16)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .padding(24)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct SuccessIcon {
  build() {
    Stack() {
      Circle()
        .fill('#E8F5E9')
        .width(72)
        .height(72)

      Text('✓')
        .fontSize(36)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2E7D32')
    }
    .width(72)
    .height(72)
    .alignContent(Alignment.Center)
  }
}

@Component
struct ReceiptDetailsCard {
  build() {
    Column({ space: 16 }) {
      // To Merchant Row
      Row() {
        Row({ space: 8 }) {
          Text('ℹ')
            .fontSize(18)
            .fontColor('#888888')
            .width(18)
            .height(18)
            .textAlign(TextAlign.Center)

          Text('To Merchant')
            .fontSize(14)
            .fontColor('#888888')
        }

        Blank()

        Text('TechSpace Solutions')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      // Divider
      Divider()
        .color('#E0E0E0')
        .strokeWidth(1)

      // Date Row
      Row() {
        Row({ space: 8 }) {
          Text('📅')
            .fontSize(16)
            .fontColor('#888888')
            .width(18)
            .height(18)
            .textAlign(TextAlign.Center)

          Text('Date')
            .fontSize(14)
            .fontColor('#888888')
        }

        Blank()

        Text('Dec 02, 2025 - 11:30 PM')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      // Divider
      Divider()
        .color('#E0E0E0')
        .strokeWidth(1)

      // Ref Number Row
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
      .justifyContent(FlexAlign.SpaceBetween)

      // Payment Method Row
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
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#F8F9FA')
    .borderRadius(12)
    .border({ width: 1, color: '#EEEEEE', radius: 12 })
  }
}

@Component
struct ActionButtons {
  build() {
    Column({ space: 12 }) {
      // Done Button
      Button('Done')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .width('100%')
        .height(50)
        .backgroundColor('#000000')
        .borderRadius(8)

      // Share Receipt Button
      Row({ space: 8 }) {
        Text('⬆')
          .fontSize(18)
          .fontColor('#000000')
          .width(18)
          .height(18)
          .textAlign(TextAlign.Center)

        Text('Share Receipt')
          .fontSize(16)
          .fontColor('#000000')
      }
      .width('100%')
      .height(50)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .border({ width: 1, color: '#DDDDDD', radius: 8 })
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
  }
}