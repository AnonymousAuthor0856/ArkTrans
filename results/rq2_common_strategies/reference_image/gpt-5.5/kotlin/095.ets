@Entry
@Component
struct ReceiptPage {
  build() {
    Column() {
      Blank().height(20)

      SuccessIcon()

      Blank().height(16)

      Text('Payment Success')
        .fontSize(16)
        .fontColor('#888888')
        .fontWeight(FontWeight.Medium)

      Blank().height(8)

      Text('$1,249.00')
        .fontSize(46)
        .fontColor('#000000')
        .fontWeight(FontWeight.Bold)

      Blank().height(32)

      ReceiptDetailsCard()

      Blank().layoutWeight(1)

      ActionButtons()

      Blank().height(16)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24 })
    .backgroundColor('#FFFFFF')
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct SuccessIcon {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text('✓')
        .fontSize(44)
        .fontColor('#2E7D32')
        .fontWeight(FontWeight.Bold)
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

      Row()
        .width('100%')
        .height(1)
        .backgroundColor('#E0E0E0')

      RowDetail({
        label: 'Date',
        value: 'Dec 02, 2025 - 11:30 PM',
        iconType: 'date'
      })

      Row()
        .width('100%')
        .height(1)
        .backgroundColor('#E0E0E0')

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
  @Prop label: string = ''
  @Prop value: string = ''
  @Prop iconType: string = 'info'

  @Builder
  DetailIcon() {
    if (this.iconType === 'info') {
      Stack({ alignContent: Alignment.Center }) {
        Text('i')
          .fontSize(12)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
      }
      .width(18)
      .height(18)
      .borderRadius(9)
      .backgroundColor('#888888')
    } else {
      Stack({ alignContent: Alignment.Center }) {
        Text('▣')
          .fontSize(18)
          .fontColor('#888888')
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
      }
      .width(18)
      .height(18)
    }
  }

  build() {
    Row() {
      Row() {
        this.DetailIcon()

        Blank().width(8)

        Text(this.label)
          .fontSize(14)
          .fontColor('#888888')
      }
      .alignItems(VerticalAlign.Center)

      Text(this.value)
        .fontSize(14)
        .fontColor('#000000')
        .fontWeight(600)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
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
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold)
      }
      .type(ButtonType.Normal)
      .width('100%')
      .height(50)
      .borderRadius(8)
      .backgroundColor('#000000')
      .stateEffect(false)
      .onClick(() => {
      })

      Button() {
        Row() {
          ShareIcon()

          Blank().width(8)

          Text('Share Receipt')
            .fontSize(16)
            .fontColor('#000000')
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
      }
      .type(ButtonType.Normal)
      .width('100%')
      .height(50)
      .borderRadius(8)
      .backgroundColor('#FFFFFF')
      .border({
        width: 1,
        color: '#DDDDDD'
      })
      .stateEffect(false)
      .onClick(() => {
      })
    }
    .width('100%')
  }
}

@Component
struct ShareIcon {
  build() {
    Stack() {
      Row()
        .width(10)
        .height(2)
        .backgroundColor('#000000')
        .rotate({ angle: -30 })
        .translate({ x: -1, y: -3 })

      Row()
        .width(10)
        .height(2)
        .backgroundColor('#000000')
        .rotate({ angle: 30 })
        .translate({ x: -1, y: 4 })

      Stack()
        .width(6)
        .height(6)
        .borderRadius(3)
        .backgroundColor('#000000')
        .translate({ x: -7, y: 0 })

      Stack()
        .width(6)
        .height(6)
        .borderRadius(3)
        .backgroundColor('#000000')
        .translate({ x: 6, y: -7 })

      Stack()
        .width(6)
        .height(6)
        .borderRadius(3)
        .backgroundColor('#000000')
        .translate({ x: 6, y: 7 })
    }
    .width(18)
    .height(18)
  }
}