@Entry
@Component
struct ReceiptApp {
  build() {
    Column() {
      Column() {
        Blank().height(20)

        Row() {
          SymbolGlyph($r('sys.symbol.checkmark'))
            .fontSize(36)
            .fontColor(['#2E7D32'])
        }
        .width(72)
        .height(72)
        .borderRadius(36)
        .backgroundColor('#E8F5E9')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        Text('Payment Success')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#888888')
          .margin({ top: 16 })

        Text('$1,249.00')
          .fontSize(46)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 8 })

        Column() {
          Row() {
            Row() {
              SymbolGlyph($r('sys.symbol.info_circle'))
                .fontSize(18)
                .fontColor(['#888888'])
              Text('To Merchant')
                .fontSize(14)
                .fontColor('#888888')
                .margin({ left: 8 })
            }.alignItems(VerticalAlign.Center)
            Blank().layoutWeight(1)
            Text('TechSpace Solutions')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.Black)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)

          Divider().color('#E0E0E0').margin({ top: 16, bottom: 16 })

          Row() {
            Row() {
              SymbolGlyph($r('sys.symbol.calendar'))
                .fontSize(18)
                .fontColor(['#888888'])
              Text('Date')
                .fontSize(14)
                .fontColor('#888888')
                .margin({ left: 8 })
            }.alignItems(VerticalAlign.Center)
            Blank().layoutWeight(1)
            Text('Dec 02, 2025 - 11:30 PM')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.Black)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)

          Divider().color('#E0E0E0').margin({ top: 16, bottom: 16 })

          Row() {
            Text('Ref Number').fontSize(14).fontColor('#888888')
            Blank().layoutWeight(1)
            Text('009281-XX-99')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.Black)
          }.width('100%')

          Row() {
            Text('Payment Method').fontSize(14).fontColor('#888888')
            Blank().layoutWeight(1)
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
        .margin({ top: 32 })
        .backgroundColor('#F8F9FA')
        .borderRadius(12)
        .border({ width: 1, color: '#EEEEEE' })

        Blank().layoutWeight(1)

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

          Button() {
            Row() {
              SymbolGlyph($r('sys.symbol.share'))
                .fontSize(18)
                .fontColor([Color.Black])
              Text('Share Receipt')
                .fontSize(16)
                .fontColor(Color.Black)
                .margin({ left: 8 })
            }
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .height(50)
          .backgroundColor(Color.White)
          .border({ width: 1, color: '#DDDDDD', radius: 8 })
          .margin({ top: 12 })
        }
        .width('100%')
        .margin({ bottom: 16 })
      }
      .padding(24)
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
