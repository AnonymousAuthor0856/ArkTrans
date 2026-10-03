@Entry
@Component
struct ReceiptScreen {
  build() {
    Stack() {
      Column() {
        Column() {
          SuccessIcon()

          Text('Payment Success')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Gray)
            .margin({ top: 16 })

          Text('$1,249.00')
            .fontSize(45)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .margin({ top: 8 })

          ReceiptDetailsCard()
            .margin({ top: 32 })

          Blank()

          ActionButtons()
        }
        .width('100%')
        .padding(24)
        .margin({ top: 20 })
      }
      .width('100%')
      .height('100%')
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
    Stack() {
      Circle({ width: 72, height: 72 })
        .fill(Color.rgb(232, 245, 233))

      Text('✓')
        .fontSize(36)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.rgb(46, 125, 50))
    }
    .width(72)
    .height(72)
  }
}

@Component
struct ReceiptDetailsCard {
  build() {
    Column() {
      RowDetail({ label: 'To Merchant', value: 'TechSpace Solutions', iconName: 'ⓘ' })

      Divider()
        .color(Color.rgb(224, 224, 224))
        .margin({ top: 16, bottom: 16 })

      RowDetail({ label: 'Date', value: 'Dec 02, 2025 - 11:30 PM', iconName: '\u{1F4C5}' })

      Divider()
        .color(Color.rgb(224, 224, 224))
        .margin({ top: 16, bottom: 16 })

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
      .margin({ top: 16 })
    }
    .width('100%')
    .padding(20)
    .backgroundColor(Color.rgb(248, 249, 250))
    .borderRadius(12)
    .border({ width: 1, color: Color.rgb(238, 238, 238) })
  }
}

@Component
struct RowDetail {
  label: string = ''
  value: string = ''
  iconName: string = ''

  build() {
    Row() {
      Row() {
        Text(this.iconName)
          .fontSize(18)
          .fontColor(Color.Gray)
          .width(18)
          .height(18)
          .textAlign(TextAlign.Center)

        Text(this.label)
          .fontSize(14)
          .fontColor(Color.Gray)
          .margin({ left: 8 })
      }

      Blank()

      Text(this.value)
        .fontSize(14)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(Color.Black)
    }
    .width('100%')
  }
}

@Component
struct ActionButtons {
  build() {
    Column() {
      Button('Done')
        .width('100%')
        .height(50)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .backgroundColor(Color.Black)
        .borderRadius(8)
        .onClick(() => {})

      Button() {
        Row() {
          Text('↪')
            .fontSize(18)
            .fontColor(Color.Black)
            .width(18)
            .height(18)
            .textAlign(TextAlign.Center)

          Text('Share Receipt')
            .fontSize(16)
            .fontColor(Color.Black)
            .margin({ left: 8 })
        }
        .width('100%')
        .height(50)
      }
      .width('100%')
      .height(50)
      .backgroundColor(Color.Transparent)
      .borderRadius(8)
      .border({ width: 1, color: Color.rgb(221, 221, 221) })
      .margin({ top: 12 })
      .onClick(() => {})
    }
    .width('100%')
  }
}
