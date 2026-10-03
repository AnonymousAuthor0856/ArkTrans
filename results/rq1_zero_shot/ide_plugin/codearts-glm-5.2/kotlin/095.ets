class AppTokens {
  static readonly Colors = {
    black: '#FF000000',
    white: '#FFFFFFFF',
    gray: '#FF888888',
    successBg: '#FFE8F5E9',
    successGreen: '#FF2E7D32',
    cardBg: '#FFF8F9FA',
    cardBorder: '#FFEEEEEE',
    divider: '#FFE0E0E0',
    outlineBorder: '#FFDDDDDD'
  }
}

@Entry
@Component
struct ReceiptScreen {
  build() {
    Column() {
      Column() {
        Row() {
          Text('✓')
            .fontSize(36)
            .fontColor(AppTokens.Colors.successGreen)
        }
        .width(72)
        .height(72)
        .borderRadius(36)
        .backgroundColor(AppTokens.Colors.successBg)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        Text('Payment Success')
          .fontSize(16)
          .fontColor(AppTokens.Colors.gray)
          .margin({ top: 16 })

        Text('$1,249.00')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.black)
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Center)
      .margin({ top: 20 })

      Column() {
        Row() {
          Row() {
            Text('ℹ')
              .fontSize(18)
              .fontColor(AppTokens.Colors.gray)
            Text('To Merchant')
              .fontSize(14)
              .fontColor(AppTokens.Colors.gray)
              .margin({ left: 8 })
          }
          .alignItems(VerticalAlign.Center)

          Text('TechSpace Solutions')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.black)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Divider()
          .color(AppTokens.Colors.divider)
          .strokeWidth(1)

        Row() {
          Row() {
            Text('▦')
              .fontSize(18)
              .fontColor(AppTokens.Colors.gray)
            Text('Date')
              .fontSize(14)
              .fontColor(AppTokens.Colors.gray)
              .margin({ left: 8 })
          }
          .alignItems(VerticalAlign.Center)

          Text('Dec 02, 2025 - 11:30 PM')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.black)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Divider()
          .color(AppTokens.Colors.divider)
          .strokeWidth(1)

        Row() {
          Text('Ref Number')
            .fontSize(14)
            .fontColor(AppTokens.Colors.gray)
          Text('009281-XX-99')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.black)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Row() {
          Text('Payment Method')
            .fontSize(14)
            .fontColor(AppTokens.Colors.gray)
          Text('Credit Card •••• 4242')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.black)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding(20)
      .borderRadius(12)
      .backgroundColor(AppTokens.Colors.cardBg)
      .border({ width: 1, color: AppTokens.Colors.cardBorder })
      .margin({ top: 32 })

      Column()
        .layoutWeight(1)

      Column() {
        Row() {
          Text('Done')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.white)
        }
        .width('100%')
        .height(50)
        .borderRadius(8)
        .backgroundColor(AppTokens.Colors.black)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        Row() {
          Text('↗')
            .fontSize(18)
            .fontColor(AppTokens.Colors.black)
          Text('Share Receipt')
            .fontSize(16)
            .fontColor(AppTokens.Colors.black)
            .margin({ left: 8 })
        }
        .width('100%')
        .height(50)
        .borderRadius(8)
        .backgroundColor(AppTokens.Colors.white)
        .border({ width: 1, color: AppTokens.Colors.outlineBorder })
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 12 })
      }
      .width('100%')
      .margin({ bottom: 16 })
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(AppTokens.Colors.white)
  }
}