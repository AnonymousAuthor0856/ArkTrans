@Entry
@Component
struct ReceiptApp {
  @Builder
  successIcon() {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(72)
        .height(72)
        .fill('#E8F5E9')

      Text('✓')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2E7D32')
        .lineHeight(54)
        .margin({ top: -4 })
    }
    .width(72)
    .height(72)
  }

  @Builder
  detailRow(label: string, value: string, icon: string, emphasize: boolean = true) {
    Row() {
      Row({ space: 8 }) {
        if (icon.length > 0) {
          Text(icon)
            .fontSize(22)
            .fontColor('#929398')
            .width(24)
            .textAlign(TextAlign.Center)
        }

        Text(label)
          .fontSize(14)
          .fontColor('#929398')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .layoutWeight(1)
      .alignItems(VerticalAlign.Center)

      Text(value)
        .fontSize(14)
        .fontWeight(emphasize ? FontWeight.Medium : FontWeight.Normal)
        .fontColor(Color.Black)
        .textAlign(TextAlign.End)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .constraintSize({ maxWidth: '58%' })
    }
    .width('100%')
    .height(32)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  separator() {
    Divider()
      .strokeWidth(1)
      .color('#E0E0E0')
      .width('100%')
  }

  @Builder
  receiptCard() {
    Column({ space: 16 }) {
      this.detailRow('To Merchant', 'TechSpace Solutions', 'ⓘ')
      this.separator()
      this.detailRow('Date', 'Dec 02, 2025 - 11:30 PM', '▦')
      this.separator()
      this.detailRow('Ref Number', '009281-XX-99', '')
      this.detailRow('Payment Method', 'Credit Card •••• 4242', '')
    }
    .width('100%')
    .padding({ left: 20, right: 20, top: 20, bottom: 20 })
    .backgroundColor('#F8F9FA')
    .border({ width: 1, color: '#EEEEEE' })
    .borderRadius(12)
  }

  @Builder
  actionButtons() {
    Column({ space: 12 }) {
      Button('Done', { type: ButtonType.Capsule, stateEffect: true })
        .width('100%')
        .height(50)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .backgroundColor(Color.Black)
        .borderRadius(8)

      Button({ type: ButtonType.Capsule, stateEffect: true }) {
        Row({ space: 8 }) {
          Text('⇧')
            .fontSize(27)
            .fontColor(Color.Black)
            .lineHeight(24)

          Text('Share Receipt')
            .fontSize(16)
            .fontColor(Color.Black)
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height(50)
      .backgroundColor(Color.White)
      .border({ width: 1, color: '#DDDDDD' })
      .borderRadius(8)
    }
    .width('100%')
  }

  build() {
    Column() {
      Column({ space: 0 }) {
        Blank()
          .height(20)

        this.successIcon()

        Blank()
          .height(16)

        Text('Payment Success')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#929398')

        Blank()
          .height(8)

        Text('$1,249.00')
          .fontSize(45)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .lineHeight(54)

        Blank()
          .height(32)

        this.receiptCard()

        Blank()
          .layoutWeight(1)

        this.actionButtons()

        Blank()
          .height(16)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24 })
    .backgroundColor(Color.White)
  }
}
