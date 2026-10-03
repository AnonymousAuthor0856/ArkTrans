// Translated from 095.swift (Receipt App)

@Entry
@Component
struct Index {
  build() {
    ReceiptScreen()
  }
}

@Component
struct ReceiptScreen {
  build() {
    Stack() {
      Column() {
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

        ReceiptDetailsCard()

        Blank()

        ActionButtons()

        Blank().height(16)
      }
      .padding(24)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct SuccessIcon {
  build() {
    Stack() {
      Circle()
        .fill('#E8F5E8')
        .width(72)
        .height(72)
      Text('✓')
        .fontSize(36)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2E7D33')
        .width(36)
        .height(36)
    }
  }
}

@Component
struct ReceiptDetailsCard {
  build() {
    Column({ space: 16 }) {
      RowDetail({
        label: 'To Merchant',
        value: 'TechSpace Solutions',
        iconName: 'ⓘ'
      })

      Divider().color('#E0E0E0')

      RowDetail({
        label: 'Date',
        value: 'Dec 02, 2025 - 11:30 PM',
        iconName: '📅'
      })

      Divider().color('#E0E0E0')

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
    .padding(20)
    .width('100%')
    .backgroundColor('#F7FAFA')
    .borderRadius(12)
    .border({ width: 1, color: '#EDEDED', radius: 12 })
  }
}

@Component
struct RowDetail {
  @Prop label: string = ''
  @Prop value: string = ''
  @Prop iconName: string = ''

  build() {
    Row() {
      Row({ space: 8 }) {
        Text(this.iconName)
          .fontSize(18)
          .fontColor('#808080')
          .width(18)
          .height(18)
        Text(this.label)
          .fontSize(14)
          .fontColor('#808080')
      }
      Blank()
      Text(this.value)
        .fontSize(14)
        .fontWeight(FontWeight.Semibold)
        .fontColor('#000000')
    }
    .width('100%')
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
          .fontColor('#FFFFFF')
      }
      .width('100%')
      .height(50)
      .backgroundColor('#000000')
      .borderRadius(8)
      .onClick(() => {})

      Button() {
        Row({ space: 8 }) {
          Text('⇧')
            .fontSize(18)
            .fontColor('#000000')
            .width(18)
            .height(18)
          Text('Share Receipt')
            .fontSize(16)
            .fontColor('#000000')
        }
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(50)
      .backgroundColor('#00000000')
      .border({ width: 1, color: '#DEDEDE', radius: 8 })
      .onClick(() => {})
    }
  }
}
