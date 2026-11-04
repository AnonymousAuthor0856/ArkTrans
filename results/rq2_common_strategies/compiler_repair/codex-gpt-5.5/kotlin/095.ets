@Entry
@Component
struct Index {
  build() {
    Column() {
      Column() {
        this.SuccessIcon()
        Text('Payment Success')
          .fontSize(18)
          .fontColor(Color.Gray)
          .margin({ top: 16 })
        Text('$1,249.00')
          .fontSize(42)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 8 })
        this.ReceiptDetailsCard()
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .margin({ top: 20 })

      Blank()
      this.ActionButtons()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
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
  }

  @Builder
  ReceiptDetailsCard() {
    Column() {
      this.RowDetail('To Merchant', 'TechSpace Solutions', 'i')
      Divider().color('#E0E0E0')
      this.RowDetail('Date', 'Dec 02, 2025 - 11:30 PM', '□')
      Divider().color('#E0E0E0')
      this.SimpleRow('Ref Number', '009281-XX-99')
      this.SimpleRow('Payment Method', 'Credit Card •••• 4242')
    }
    .width('100%')
    .padding(20)
    .border({ width: 1, color: '#EEEEEE', radius: 12 })
    .backgroundColor('#F8F9FA')
    .margin({ top: 32 })
  }

  @Builder
  RowDetail(label: string, value: string, icon: string) {
    Row() {
      Row() {
        Text(icon)
          .fontSize(18)
          .fontColor(Color.Gray)
        Text(label)
          .fontSize(14)
          .fontColor(Color.Gray)
          .margin({ left: 8 })
      }
      .alignItems(VerticalAlign.Center)
      Text(value)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ top: 8, bottom: 8 })
  }

  @Builder
  SimpleRow(label: string, value: string) {
    Row() {
      Text(label)
        .fontSize(14)
        .fontColor(Color.Gray)
      Text(value)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ top: 8, bottom: 8 })
  }

  @Builder
  ActionButtons() {
    Column() {
      Button('Done')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .width('100%')
        .height(50)
        .borderRadius(8)
        .backgroundColor(Color.Black)
      Button() {
        Row() {
          Text('↗')
            .fontSize(18)
            .fontColor(Color.Black)
          Text('Share Receipt')
            .fontSize(16)
            .fontColor(Color.Black)
            .margin({ left: 8 })
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(50)
      .border({ width: 1, color: '#DDDDDD', radius: 8 })
      .backgroundColor(Color.Transparent)
      .margin({ top: 12 })
    }
    .width('100%')
    .margin({ bottom: 16 })
  }
}
