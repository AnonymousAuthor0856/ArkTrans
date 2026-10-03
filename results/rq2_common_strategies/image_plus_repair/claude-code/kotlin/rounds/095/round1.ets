@Entry
@Component
struct ReceiptPage {
  build() {
    Column() {
      ReceiptScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct ReceiptScreen {
  build() {
    Column() {
      // Header Section
      Blank().height(20)

      SuccessIcon()

      Blank().height(16)

      Text('Payment Success')
        .fontSize(28)
        .fontColor('#999999')

      Blank().height(8)

      Text('$1,249.00')
        .fontSize(72)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Blank().height(32)

      // Receipt Card
      ReceiptDetailsCard()

      Blank()

      // Action Buttons
      ActionButtons()

      Blank().height(16)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(Color.White)
  }
}

@Component
struct SuccessIcon {
  build() {
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
  }
}

@Component
struct ReceiptDetailsCard {
  build() {
    Column() {
      // Recipient
      RowDetail({
        label: 'To Merchant',
        value: 'TechSpace Solutions',
        icon: 'ⓘ'
      })

      Divider()
        .color('#E0E0E0')
        .strokeWidth(1)

      // Date
      RowDetail({
        label: 'Date',
        value: 'Dec 02, 2025 - 11:30 PM',
        icon: '\u{1F5C5}'
      })

      Divider()
        .color('#E0E0E0')
        .strokeWidth(1)

      // Ref Number
      Row() {
        Text('Ref Number')
          .fontSize(16)
          .fontColor('#888888')

        Blank()

        Text('009281-XX-99')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      // Payment Method
      Row() {
        Text('Payment Method')
          .fontSize(16)
          .fontColor('#888888')

        Blank()

        Text('Credit Card •••• 4242')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#F8F9FA')
    .borderRadius(24)
    .border({ width: 1, color: '#EEEEEE' })
  }
}

@Component
struct RowDetail {
  label: string = ''
  value: string = ''
  icon: string = ''

  build() {
    Row() {
      Row() {
        Text(this.icon)
          .fontSize(18)
          .fontColor('#888888')

        Blank().width(8)

        Text(this.label)
          .fontSize(18)
          .fontColor('#888888')
      }
      .alignItems(VerticalAlign.Center)

      Blank()

      Text(this.value)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct ActionButtons {
  build() {
    Column() {
      // Done Button
      Button('Done', { type: ButtonType.Normal })
        .width('100%')
        .height(50)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .backgroundColor(Color.Black)
        .borderRadius(16)
        .onClick(() => {})

      // Share Receipt Button
      Button() {
        Row() {
          Text('\u{1F517}')
            .fontSize(18)
            .fontColor(Color.Black)

          Blank().width(8)

          Text('Share Receipt')
            .fontSize(20)
            .fontColor(Color.Black)
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(50)
      .backgroundColor(Color.White)
      .borderRadius(16)
      .border({ width: 1, color: '#DDDDDD' })
      .onClick(() => {})
    }
    .width('100%')
  }
}
