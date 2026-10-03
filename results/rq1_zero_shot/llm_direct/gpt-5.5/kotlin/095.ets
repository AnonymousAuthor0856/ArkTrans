@Entry
@Component
struct ReceiptScreen {
  build() {
    Column() {
      Blank().height(20)

      this.SuccessIcon()

      Blank().height(16)

      Text('Payment Success')
        .fontSize(16)
        .fontColor('#808080')
        .fontWeight(FontWeight.Medium)

      Blank().height(8)

      Text('$1,249.00')
        .fontSize(44)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Blank().height(32)

      this.ReceiptDetailsCard()

      Blank().layoutWeight(1)

      this.ActionButtons()

      Blank().height(16)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  SuccessIcon() {
    Stack() {
      Text('✓')
        .fontSize(36)
        .fontColor('#2E7D32')
        .fontWeight(FontWeight.Bold)
    }
    .width(72)
    .height(72)
    .borderRadius(36)
    .backgroundColor('#E8F5E9')
    .alignContent(Alignment.Center)
  }

  @Builder
  ReceiptDetailsCard() {
    Column({ space: 16 }) {
      this.RowDetail('To Merchant', 'TechSpace Solutions', 'ℹ')

      Divider()
        .color('#E0E0E0')
        .strokeWidth(1)

      this.RowDetail('Date', 'Dec 02, 2025 - 11:30 PM', '📅')

      Divider()
        .color('#E0E0E0')
        .strokeWidth(1)

      Row() {
        Text('Ref Number')
          .fontSize(14)
          .fontColor('#808080')

        Text('009281-XX-99')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Row() {
        Text('Payment Method')
          .fontSize(14)
          .fontColor('#808080')

        Text('Credit Card •••• 4242')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#F8F9FA')
    .borderRadius(12)
    .border({
      width: 1,
      color: '#EEEEEE'
    })
  }

  @Builder
  RowDetail(label: string, value: string, icon: string) {
    Row() {
      Row() {
        Text(icon)
          .fontSize(18)
          .fontColor('#808080')
          .width(18)
          .height(18)
          .textAlign(TextAlign.Center)

        Blank().width(8)

        Text(label)
          .fontSize(14)
          .fontColor('#808080')
      }
      .alignItems(VerticalAlign.Center)

      Text(value)
        .fontSize(14)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(Color.Black)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  ActionButtons() {
    Column({ space: 12 }) {
      Button() {
        Text('Done')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      }
      .width('100%')
      .height(50)
      .backgroundColor(Color.Black)
      .borderRadius(8)
      .onClick(() => {
      })

      Button({ type: ButtonType.Normal }) {
        Row() {
          Text('↗')
            .fontSize(18)
            .fontColor(Color.Black)

          Blank().width(8)

          Text('Share Receipt')
            .fontSize(16)
            .fontColor(Color.Black)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(50)
      .backgroundColor(Color.Transparent)
      .borderRadius(8)
      .border({
        width: 1,
        color: '#DDDDDD'
      })
      .onClick(() => {
      })
    }
    .width('100%')
  }
}