@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Blank().height(20)
        this.SuccessIcon()
        Blank().height(16)
        Text('Payment Success')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Gray)
        Blank().height(8)
        Text('$1,249.00')
          .fontSize(45)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Blank().height(32)
        this.ReceiptDetailsCard()
        Blank()
        this.ActionButtons()
        Blank().height(16)
      }
      .width('100%')
      .height('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  SuccessIcon() {
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

  @Builder
  ReceiptDetailsCard() {
    Column() {
      this.RowDetail('To Merchant', 'TechSpace Solutions', 'i')
      Blank().height(16)
      Divider().color('#E0E0E0')
      Blank().height(16)
      this.RowDetail('Date', 'Dec 02, 2025 - 11:30 PM', '□')
      Blank().height(16)
      Divider().color('#E0E0E0')
      Blank().height(16)
      Row() {
        Text('Ref Number')
          .fontSize(14)
          .fontColor(Color.Gray)
        Blank()
        Text('009281-XX-99')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
      }
      .width('100%')
      Blank().height(16)
      Row() {
        Text('Payment Method')
          .fontSize(14)
          .fontColor(Color.Gray)
        Blank()
        Text('Credit Card •••• 4242')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
      }
      .width('100%')
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#F8F9FA')
    .borderRadius(12)
    .border({ width: 1, color: '#EEEEEE' })
  }

  @Builder
  RowDetail(label: string, value: string, iconName: string) {
    Row() {
      Row() {
        Text(iconName)
          .fontSize(18)
          .fontColor(Color.Gray)
        Text(label)
          .fontSize(14)
          .fontColor(Color.Gray)
          .margin({ left: 8 })
      }
      Blank()
      Text(value)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
    }
    .width('100%')
  }

  @Builder
  ActionButtons() {
    Column() {
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
      Blank().height(12)
      Button() {
        Row() {
          Text('⇧')
            .fontSize(18)
            .fontColor(Color.Black)
          Text('Share Receipt')
            .fontSize(16)
            .fontColor(Color.Black)
            .margin({ left: 8 })
        }
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(50)
      .backgroundColor(Color.White)
      .borderRadius(8)
      .border({ width: 1, color: '#DDDDDD' })
    }
    .width('100%')
  }
}