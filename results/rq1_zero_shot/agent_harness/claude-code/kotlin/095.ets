@Entry
@Component
struct ReceiptScreen {
  build() {
    Column() {
      Column() {
        // Header Section
        SuccessIcon()

        Text('Payment Success')
          .fontSize(16)
          .fontColor(Color.Gray)
          .margin({ top: 16 })

        Text('$1,249.00')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 8 })

        // Receipt Card
        ReceiptDetailsCard()
          .margin({ top: 32 })

        // Spacer with weight
        Column() {
        }
        .layoutWeight(1)

        // Action Buttons
        ActionButtons()
          .margin({ bottom: 16 })
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
}

@Component
struct SuccessIcon {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Image($r('sys.media.ohos_ic_public_check'))
        .width(36)
        .height(36)
        .fillColor('#2E7D32')
    }
    .width(72)
    .height(72)
    .backgroundColor('#E8F5E9')
    .borderRadius(36)
    .margin({ top: 20 })
  }
}

@Component
struct ReceiptDetailsCard {
  build() {
    Column() {
      // Recipient
      RowDetail({ label: 'To Merchant', value: 'TechSpace Solutions', iconRes: $r('sys.media.ohos_ic_public_info') })

      Divider()
        .color('#E0E0E0')
        .margin({ top: 16, bottom: 16 })

      // Date
      RowDetail({ label: 'Date', value: 'Dec 02, 2025 - 11:30 PM', iconRes: $r('sys.media.ohos_ic_public_date') })

      Divider()
        .color('#E0E0E0')
        .margin({ top: 16, bottom: 16 })

      // Transaction ID
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

      // Payment Method
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
      .margin({ top: 16 })
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#F8F9FA')
    .borderRadius(12)
    .border({ width: 1, color: '#EEEEEE' })
  }
}

@Component
struct RowDetail {
  label: string = ''
  value: string = ''
  iconRes: ResourceStr = ''

  build() {
    Row() {
      Row() {
        Image(this.iconRes)
          .width(18)
          .height(18)
          .fillColor(Color.Gray)

        Text(this.label)
          .fontSize(14)
          .fontColor(Color.Gray)
          .margin({ left: 8 })
      }
      .alignItems(VerticalAlign.Center)

      Text(this.value)
        .fontSize(14)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(Color.Black)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct ActionButtons {
  build() {
    Column() {
      Button('Done')
        .width('100%')
        .height(50)
        .backgroundColor(Color.Black)
        .fontColor(Color.White)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .borderRadius(8)
        .onClick(() => {})

      Button() {
        Row() {
          Image($r('sys.media.ohos_ic_public_share'))
            .width(18)
            .height(18)
            .fillColor(Color.Black)

          Text('Share Receipt')
            .fontSize(16)
            .fontColor(Color.Black)
            .margin({ left: 8 })
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(50)
      .backgroundColor(Color.White)
      .borderRadius(8)
      .border({ width: 1, color: '#DDDDDD' })
      .onClick(() => {})
    }
    .width('100%')
    .gap(12)
  }
}
