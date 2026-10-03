// Index.ets
@Entry
@Component
struct ReceiptScreen {
  @Builder
  SuccessIcon() {
    Stack() {
      Text('\u2713')
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
  RowDetail(label: string, value: string, iconStr: string) {
    Row() {
      Row() {
        Text(iconStr)
          .fontSize(16)
          .fontColor(Color.Gray)
        Text(' ')
          .fontSize(16)
        Text(label)
          .fontSize(14)
          .fontColor(Color.Gray)
      }

      Text(value)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  ReceiptDetailsCard() {
    Column() {
      this.RowDetail('To Merchant', 'TechSpace Solutions', '\u2139')
      Divider().color('#E0E0E0').strokeWidth(1).width('100%')
      this.RowDetail('Date', 'Dec 02, 2025 - 11:30 PM', '\uD83D\uDCC5')
      Divider().color('#E0E0E0').strokeWidth(1).width('100%')

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
    .borderRadius(12)
    .backgroundColor('#F8F9FA')
    .border({ width: 1, color: '#EEEEEE' })
  }

  @Builder
  ActionButtons() {
    Column({ space: 12 }) {
      Button('Done', { type: ButtonType.Capsule })
        .width('100%')
        .height(50)
        .backgroundColor(Color.Black)
        .fontColor(Color.White)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)

      Button() {
        Row() {
          Text('\uD83D\uDD17')
            .fontSize(16)
            .fontColor(Color.Black)
          Text(' ')
            .fontSize(16)
          Text('Share Receipt')
            .fontSize(16)
            .fontColor(Color.Black)
        }
      }
      .width('100%')
      .height(50)
      .borderRadius(8)
      .backgroundColor(Color.White)
      .border({ width: 1, color: '#DDDDDD' })
    }
  }

  build() {
    Column() {
      // --- Header Section ---
      Blank().height(20)
      this.SuccessIcon()
      Blank().height(16)
      Text('Payment Success')
        .fontSize(16)
        .fontColor(Color.Gray)
      Blank().height(8)
      Text('$1,249.00')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
      Blank().height(32)

      // --- Receipt Card ---
      this.ReceiptDetailsCard()

      // --- Spacer ---
      Blank().layoutWeight(1)

      // --- Action Buttons ---
      this.ActionButtons()
      Blank().height(16)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Center)
  }
}