@Entry
@Component
struct ReceiptScreen {
  build() {
    Stack() {
      Column() {
        Blank()
          .height(20)

        SuccessIcon()

        Blank()
          .height(16)

        Text('Payment Success')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Gray)

        Blank()
          .height(8)

        Text('$1,249.00')
          .fontSize(45)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Blank()
          .height(32)

        ReceiptDetailsCard()

        Blank()

        ActionButtons()

        Blank()
          .height(16)
      }
      .alignItems(HorizontalAlign.Center)
      .padding(24)
      .width('100%')
      .height('100%')
    }
    .backgroundColor(Color.White)
    .width('100%')
    .height('100%')
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
  }
}

@Component
struct ReceiptDetailsCard {
  build() {
    Column({ space: 16 }) {
      RowDetail({ label: 'To Merchant', value: 'TechSpace Solutions', iconName: 'info' })

      Divider()
        .color('#E0E0E0')

      RowDetail({ label: 'Date', value: 'Dec 02, 2025 - 11:30 PM', iconName: 'date' })

      Divider()
        .color('#E0E0E0')

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
    .padding(20)
    .width('100%')
    .backgroundColor('#F8F9FA')
    .borderRadius(12)
    .border({ width: 1, color: '#EEEEEE' })
  }
}

@Component
struct RowDetail {
  @Prop label: string;
  @Prop value: string;
  @Prop iconName: string;

  build() {
    Row() {
      Row({ space: 8 }) {
        Text(this.iconName)
          .fontSize(12)
          .fontColor(Color.Gray)
          .width(18)
          .height(18)
          .textAlign(TextAlign.Center)

        Text(this.label)
          .fontSize(14)
          .fontColor(Color.Gray)
      }
      .alignItems(VerticalAlign.Center)

      Blank()

      Text(this.value)
        .fontSize(14)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(Color.Black)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct ActionButtons {
  build() {
    Column({ space: 12 }) {
      Button() {
        Text('Done')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .width('100%')
          .textAlign(TextAlign.Center)
      }
      .height(50)
      .width('100%')
      .backgroundColor(Color.Black)
      .borderRadius(8)

      Button() {
        Row({ space: 8 }) {
          Text('↗')
            .fontSize(18)
            .fontColor(Color.Black)
            .width(18)
            .height(18)
            .textAlign(TextAlign.Center)

          Text('Share Receipt')
            .fontSize(16)
            .fontColor(Color.Black)
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
      }
      .height(50)
      .width('100%')
      .backgroundColor(Color.Transparent)
      .border({ width: 1, color: '#DDDDDD' })
      .borderRadius(8)
    }
    .width('100%')
  }
}
