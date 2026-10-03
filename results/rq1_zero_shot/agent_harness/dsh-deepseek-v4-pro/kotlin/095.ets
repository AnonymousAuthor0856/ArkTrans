@Entry
@Component
struct Index {
  build() {
    Column() {
      Blank().height(20)
      SuccessIcon()
      Blank().height(16)
      Text('Payment Success').fontSize(16).fontColor('#9E9E9E')
      Blank().height(8)
      Text('$1,249.00').fontSize(42).fontWeight(FontWeight.Bold).fontColor('#000000')
      Blank().height(32)
      ReceiptDetailsCard()
      Blank().layoutWeight(1)
      ActionButtons()
      Blank().height(16)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct SuccessIcon {
  build() {
    Stack() {
      Text('✓').fontSize(36).fontColor('#2E7D32')
    }
    .width(72).height(72)
    .borderRadius(36)
    .backgroundColor('#E8F5E9')
  }
}

@Component
struct ReceiptDetailsCard {
  build() {
    Column({ space: 16 }) {
      RowDetail({ label: 'To Merchant', value: 'TechSpace Solutions', icon: 'ⓘ' })

      Divider().color('#E0E0E0')

      RowDetail({ label: 'Date', value: 'Dec 02, 2025 - 11:30 PM', icon: '▦' })

      Divider().color('#E0E0E0')

      Row() {
        Text('Ref Number').fontSize(14).fontColor('#9E9E9E')
        Text('009281-XX-99').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Row() {
        Text('Payment Method').fontSize(14).fontColor('#9E9E9E')
        Text('Credit Card •••• 4242').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000')
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
}

@Component
struct RowDetail {
  @Prop label: string = ''
  @Prop value: string = ''
  @Prop icon: string = ''

  build() {
    Row() {
      Row() {
        Text(this.icon).fontSize(18).fontColor('#9E9E9E')
        Blank().width(8)
        Text(this.label).fontSize(14).fontColor('#9E9E9E')
      }
      .alignItems(VerticalAlign.Center)

      Text(this.value).fontSize(14).fontWeight(FontWeight.Bold).fontColor('#000000')
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
      Button('Done')
        .width('100%')
        .height(50)
        .backgroundColor('#000000')
        .fontColor('#FFFFFF')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .borderRadius(8)
        .onClick(() => {})

      Button() {
        Row() {
          Text('⇧').fontSize(18).fontColor('#000000')
          Blank().width(8)
          Text('Share Receipt').fontSize(16).fontColor('#000000')
        }
      }
      .width('100%')
      .height(50)
      .backgroundColor('#FFFFFF')
      .borderRadius(8)
      .border({ width: 1, color: '#DDDDDD' })
      .onClick(() => {})
    }
    .width('100%')
  }
}
