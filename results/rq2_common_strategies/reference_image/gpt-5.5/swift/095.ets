@Entry
@Component
struct ContentView {
  build() {
    ReceiptScreen()
  }
}

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
          .fontColor('#8E8E93')

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
          .layoutWeight(1)

        ActionButtons()

        Blank()
          .height(16)
      }
      .width('100%')
      .height('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct SuccessIcon {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text('✓')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2E7D32')
        .textAlign(TextAlign.Center)
    }
    .width(72)
    .height(72)
    .borderRadius(36)
    .backgroundColor('#E8F5E9')
  }
}

@Component
struct ReceiptDetailsCard {
  build() {
    Column({ space: 16 }) {
      RowDetail({
        label: 'To Merchant',
        value: 'TechSpace Solutions',
        iconType: 'info'
      })

      Divider()
        .width('100%')
        .strokeWidth(1)
        .color('#E0E0E0')

      RowDetail({
        label: 'Date',
        value: 'Dec 02, 2025 - 11:30 PM',
        iconType: 'calendar'
      })

      Divider()
        .width('100%')
        .strokeWidth(1)
        .color('#E0E0E0')

      Row() {
        Text('Ref Number')
          .fontSize(14)
          .fontColor('#8E8E93')

        Blank()
          .layoutWeight(1)

        Text('009281-XX-99')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
          .maxLines(1)
          .textAlign(TextAlign.End)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Row() {
        Text('Payment Method')
          .fontSize(14)
          .fontColor('#8E8E93')

        Blank()
          .layoutWeight(1)

        Text('Credit Card •••• 4242')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
          .maxLines(1)
          .textAlign(TextAlign.End)
      }
      .width('100%')
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
}

@Component
struct RowDetail {
  label: string = ''
  value: string = ''
  iconType: string = 'info'

  build() {
    Row() {
      Row({ space: 8 }) {
        if (this.iconType === 'calendar') {
          CalendarIcon()
        } else {
          InfoIcon()
        }

        Text(this.label)
          .fontSize(14)
          .fontColor('#8E8E93')
      }
      .alignItems(VerticalAlign.Center)

      Blank()
        .layoutWeight(1)

      Text(this.value)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .maxLines(1)
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct InfoIcon {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text('i')
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .textAlign(TextAlign.Center)
    }
    .width(18)
    .height(18)
    .borderRadius(9)
    .backgroundColor('#8E8E93')
  }
}

@Component
struct CalendarIcon {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text('•••')
        .fontSize(8)
        .fontColor('#8E8E93')
        .textAlign(TextAlign.Center)
    }
    .width(18)
    .height(18)
    .borderRadius(3)
    .border({
      width: 2,
      color: '#8E8E93'
    })
  }
}

@Component
struct ActionButtons {
  build() {
    Column({ space: 12 }) {
      Button('Done', {
        type: ButtonType.Normal,
        stateEffect: true
      })
        .width('100%')
        .height(50)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .backgroundColor(Color.Black)
        .borderRadius(8)

      Button({
        type: ButtonType.Normal,
        stateEffect: true
      }) {
        Row({ space: 8 }) {
          ShareIcon()

          Text('Share Receipt')
            .fontSize(16)
            .fontColor(Color.Black)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(50)
      .backgroundColor(Color.White)
      .borderRadius(8)
      .border({
        width: 1,
        color: '#DDDDDD'
      })
    }
    .width('100%')
  }
}

@Component
struct ShareIcon {
  build() {
    Text('⇧')
      .fontSize(24)
      .fontColor(Color.Black)
      .fontWeight(FontWeight.Medium)
      .width(18)
      .height(24)
      .textAlign(TextAlign.Center)
  }
}