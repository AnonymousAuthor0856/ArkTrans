import { LengthMetrics } from '@kit.ArkUI';

@Entry
@Component
struct ReceiptScreen {
  build() {
    Stack() {
      // White background
      Column() {}
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)

      Column({ space: 0 }) {
        // Spacer top
        Column() {}
        .height(20)

        // Success Icon
        SuccessIcon()

        // Spacer
        Column() {}
        .height(16)

        // Payment Success text
        Text('Payment Success')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#888888')

        // Spacer
        Column() {}
        .height(8)

        // Amount
        Text('$1,249.00')
          .fontSize(45)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        // Spacer
        Column() {}
        .height(32)

        // Receipt Card
        ReceiptDetailsCard()

        // Flexible spacer
        Column() {}
        .layoutWeight(1)

        // Action Buttons
        ActionButtons()

        // Bottom spacer
        Column() {}
        .height(16)
      }
      .padding(24)
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct SuccessIcon {
  build() {
    Stack() {
      // Circle background
      Circle()
        .fill('#E8F5E9')
        .width(72)
        .height(72)

      // Checkmark
      Text('✓')
        .fontSize(32)
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
    Column({ space: 0 }) {
      // To Merchant Row
      Row() {
        Row({ space: 8 }) {
          Text('ℹ')
            .fontSize(18)
            .fontColor('#888888')
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
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ top: 4, bottom: 4 })

      // Divider
      Divider()
        .color('#E0E0E0')
        .margin({ top: 8, bottom: 8 })

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

        Blank()

        Text('Dec 02, 2025 - 11:30 PM')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ top: 4, bottom: 4 })

      // Divider
      Divider()
        .color('#E0E0E0')
        .margin({ top: 8, bottom: 8 })

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
      .padding({ top: 4, bottom: 4 })

      // Spacer between rows
      Column() {}
      .height(8)

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
      .padding({ top: 4, bottom: 4 })
    }
    .padding(20)
    .width('100%')
    .backgroundColor('#F8F9FA')
    .borderRadius(12)
    .border({
      width: 1,
      color: '#EEEEEE',
      radius: 12
    })
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
        .fontColor(Color.White)
        .width('100%')
        .height(50)
        .backgroundColor('#000000')
        .borderRadius(8)

      // Share Receipt Button
      Row({ space: 8 }) {
        Text('⬆')
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
      .border({
        width: 1,
        color: '#DDDDDD',
        radius: 8
      })
      .backgroundColor(Color.White)
      .onClick(() => {})
    }
    .width('100%')
  }
}