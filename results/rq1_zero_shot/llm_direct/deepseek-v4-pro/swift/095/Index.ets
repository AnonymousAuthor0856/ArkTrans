@Entry
@Component
struct ReceiptApp {
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
    Column({ space: 0 }) {
      // Header
      Blank().height(20)

      SuccessIcon()

      Blank().height(16)

      Text('Payment Success')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#808080')

      Blank().height(8)

      Text('$1,249.00')
        .fontSize(45)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

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
    .padding(24)
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct SuccessIcon {
  build() {
    Stack() {
      Circle()
        .width(72)
        .height(72)
        .fill('#E8F5E9')

      Text('✓')
        .fontSize(36)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2E7D32')
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
      RowDetail({
        label: 'To Merchant',
        value: 'TechSpace Solutions',
        icon: 'ℹ'
      })

      Divider()
        .strokeWidth(1)
        .color('#E0E0E0')

      // Date
      RowDetail({
        label: 'Date',
        value: 'Dec 02, 2025 - 11:30 PM',
        icon: '📅'
      })

      Divider()
        .strokeWidth(1)
        .color('#E0E0E0')

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
    .border({
      width: 1
      color: '#EEEEEE'
      radius: 12
    })
  }
}

@Component
struct RowDetail {
  label: string = ''
  value: string = ''
  icon: string = ''

  build() {
    Row() {
      Row({ space: 8 }) {
        Text(this.icon)
          .fontSize(18)
          .fontColor('#808080')

        Text(this.label)
          .fontSize(14)
          .fontColor('#808080')
      }

      Blank()

      Text(this.value)
        .fontSize(14)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#000000')
    }
    .width('100%')
  }
}

@Component
struct ActionButtons {
  build() {
    Column({ space: 12 }) {
      Button('Done')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .width('100%')
        .height(50)
        .backgroundColor('#000000')
        .borderRadius(8)

      Button() {
        Row({ space: 8 }) {
          Text('↗')
            .fontSize(18)
            .fontColor('#000000')

          Text('Share Receipt')
            .fontSize(16)
            .fontColor('#000000')
        }
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(50)
      .backgroundColor(Color.Transparent)
      .borderRadius(8)
      .border({
        width: 1
        color: '#DDDDDD'
        radius: 8
      })
    }
    .width('100%')
  }
}