// Index.ets
@Entry
@Component
struct ReceiptPage {
  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column().width('100%').height('100%').backgroundColor('#FFFFFF')

      // Content
      Column({ space: 0 }) {
        // Top spacing
        Blank().height(20)

        // Success Icon
        SuccessIcon()

        Blank().height(16)

        // "Payment Success"
        Text('Payment Success')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#808080')

        Blank().height(8)

        // Amount
        Text('$1,249.00')
          .fontSize(45)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Blank().height(32)

        // Receipt Details Card
        ReceiptDetailsCard()

        // Push buttons to bottom
        Blank()

        // Action Buttons
        ActionButtons()

        Blank().height(16)
      }
      .width('100%')
      .height('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct SuccessIcon {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      // Light Green Circle Background
      Circle({ width: 72, height: 72 }).fill('#E8F5E9')

      // Checkmark Shape
      Shape() {
        Path()
          .commands('M 10 20 L 16 26 L 30 12')
      }
      .width(36)
      .height(36)
      .fillOpacity(0)
      .stroke('#2E7D32')
      .strokeWidth(4)
      .strokeLineCap(LineCapStyle.Round)
      .strokeLineJoin(LineJoinStyle.Round)
    }
    .width(72)
    .height(72)
  }
}

@Component
struct ReceiptDetailsCard {
  build() {
    Column({ space: 16 }) {
      // Recipient
      RowDetail({ label: 'To Merchant', value: 'TechSpace Solutions' })

      // Divider
      Divider().color('#E0E0E0').strokeWidth(1)

      // Date
      RowDetail({ label: 'Date', value: 'Dec 02, 2025 - 11:30 PM' })

      // Divider
      Divider().color('#E0E0E0').strokeWidth(1)

      // Ref Number
      Row() {
        Text('Ref Number')
          .fontSize(14)
          .fontColor('#808080')
        Blank()
        Text('009281-XX-99')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
      }
      .width('100%')

      // Payment Method
      Row() {
        Text('Payment Method')
          .fontSize(14)
          .fontColor('#808080')
        Blank()
        Text('Credit Card •••• 4242')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
      }
      .width('100%')
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#F8F9FA')
    .borderRadius(12)
    .border({ width: 1, color: '#EEEEEE', radius: 12 })
  }
}

@Component
struct RowDetail {
  @Prop label: string = ''
  @Prop value: string = ''

  build() {
    Row() {
      Row({ space: 8 }) {
        // Info Icon approximation
        Text('ℹ︎').fontSize(16).fontColor('#808080')
        Text(this.label)
          .fontSize(14)
          .fontColor('#808080')
      }

      Blank()

      Text(this.value)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
    }
    .width('100%')
  }
}

@Component
struct ActionButtons {
  build() {
    Column({ space: 12 }) {
      // Done Button
      Button({ type: ButtonType.Normal }) {
        Text('Done')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
      }
      .width('100%')
      .height(50)
      .backgroundColor('#000000')
      .borderRadius(8)

      // Share Receipt Button
      Button({ type: ButtonType.Normal }) {
        Row({ space: 8 }) {
          Text('↗').fontSize(18).fontColor('#000000')
          Text('Share Receipt')
            .fontSize(16)
            .fontColor('#000000')
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(50)
      .backgroundColor('#FFFFFF')
      .borderRadius(8)
      .border({ width: 1, color: '#DDDDDD', radius: 8 })
    }
    .width('100%')
  }
}