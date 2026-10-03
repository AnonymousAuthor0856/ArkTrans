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
        .fontColor('#888888')
        .fontWeight(FontWeight.Medium)
      Blank().height(8)
      Text('$1,249.00')
        .fontSize(45)
        .fontColor('#000000')
        .fontWeight(FontWeight.Bold)
      Blank().height(32)

      this.ReceiptDetailsCard()

      Blank().layoutWeight(1)

      this.ActionButtons()
      Blank().height(16)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  SuccessIcon() {
    Stack() {
      Text('✓')
        .fontSize(36)
        .fontColor('#2E7D32')
    }
    .width(72)
    .height(72)
    .borderRadius(36)
    .backgroundColor('#E8F5E9')
  }

  @Builder
  ReceiptDetailsCard() {
    Column({ space: 16 }) {
      this.RowDetail('To Merchant', 'TechSpace Solutions', 'ⓘ')
      Divider().color('#E0E0E0')
      this.RowDetail('Date', 'Dec 02, 2025 - 11:30 PM', '📅')
      Divider().color('#E0E0E0')

      Row() {
        Text('Ref Number')
          .fontSize(14)
          .fontColor('#888888')
        Text('009281-XX-99')
          .fontSize(14)
          .fontColor('#000000')
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Row() {
        Text('Payment Method')
          .fontSize(14)
          .fontColor('#888888')
        Text('Credit Card •••• 4242')
          .fontSize(14)
          .fontColor('#000000')
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(20)
    .borderRadius(12)
    .backgroundColor('#F8F9FA')
    .border({ width: 1, color: '#EEEEEE' })
  }

  @Builder
  RowDetail(label: string, value: string, icon: string) {
    Row() {
      Row() {
        Text(icon)
          .fontSize(18)
          .fontColor('#888888')
        Blank().width(8)
        Text(label)
          .fontSize(14)
          .fontColor('#888888')
      }
      Text(value)
        .fontSize(14)
        .fontColor('#000000')
        .fontWeight(FontWeight.Bold)
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
          .fontSize(17)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold)
      }
      .onClick(() => {})
      .width('100%')
      .height(50)
      .borderRadius(8)
      .backgroundColor('#000000')

      Button() {
        Row() {
          Text('↗')
            .fontSize(18)
            .fontColor('#000000')
          Blank().width(8)
          Text('Share Receipt')
            .fontSize(17)
            .fontColor('#000000')
        }
      }
      .onClick(() => {})
      .width('100%')
      .height(50)
      .borderRadius(8)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: '#DDDDDD' })
    }
    .width('100%')
  }
}
