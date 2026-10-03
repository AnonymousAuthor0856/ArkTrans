class RcColors {
  static readonly white: string = '#FFFFFFFF'
  static readonly black: string = '#FF000000'
  static readonly gray: string = '#FF808080'
  static readonly successBg: string = '#FFE8F5E9'
  static readonly successCheck: string = '#FF2E7D32'
  static readonly divider: string = '#FFE0E0E0'
  static readonly cardBg: string = '#FFF8F9FA'
  static readonly cardBorder: string = '#FFEEEEEE'
  static readonly shareBorder: string = '#FFDDDDDD'
}

@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Blank().height(20)

        Stack() {
          Circle({ width: 72, height: 72 })
            .fill(RcColors.successBg)
          Text('✓')
            .fontSize(36)
            .fontWeight(FontWeight.Bold)
            .fontColor(RcColors.successCheck)
        }

        Blank().height(16)

        Text('Payment Success')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(RcColors.gray)

        Blank().height(8)

        Text('$1,249.00')
          .fontSize(45)
          .fontWeight(FontWeight.Bold)
          .fontColor(RcColors.black)

        Blank().height(32)

        Column() {
          Row() {
            Row() {
              Text('ⓘ')
                .fontSize(18)
                .fontColor(RcColors.gray)
              Text('To Merchant')
                .fontSize(14)
                .fontColor(RcColors.gray)
                .margin({ left: 8 })
            }
            Blank()
            Text('TechSpace Solutions')
              .fontSize(14)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(RcColors.black)
          }

          Column() { Blank() }
            .width('100%')
            .height(1)
            .backgroundColor(RcColors.divider)
            .margin({ top: 16, bottom: 16 })

          Row() {
            Row() {
              Text('📅')
                .fontSize(18)
                .fontColor(RcColors.gray)
              Text('Date')
                .fontSize(14)
                .fontColor(RcColors.gray)
                .margin({ left: 8 })
            }
            Blank()
            Text('Dec 02, 2025 - 11:30 PM')
              .fontSize(14)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(RcColors.black)
          }

          Column() { Blank() }
            .width('100%')
            .height(1)
            .backgroundColor(RcColors.divider)
            .margin({ top: 16, bottom: 16 })

          Row() {
            Text('Ref Number')
              .fontSize(14)
              .fontColor(RcColors.gray)
            Blank()
            Text('009281-XX-99')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(RcColors.black)
          }

          Row() {
            Text('Payment Method')
              .fontSize(14)
              .fontColor(RcColors.gray)
            Blank()
            Text('Credit Card •••• 4242')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(RcColors.black)
          }
          .margin({ top: 16 })
        }
        .padding(20)
        .backgroundColor(RcColors.cardBg)
        .borderRadius(12)
        .border({ width: 1, color: RcColors.cardBorder })

        Blank()

        Column() {
          Text('Done')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(RcColors.white)
            .width('100%')
            .height(50)
            .textAlign(TextAlign.Center)
            .backgroundColor(RcColors.black)
            .borderRadius(8)

          Row() {
            Text('↗')
              .fontSize(18)
              .fontColor(RcColors.black)
            Text('Share Receipt')
              .fontSize(16)
              .fontColor(RcColors.black)
              .margin({ left: 8 })
          }
          .width('100%')
          .height(50)
          .justifyContent(FlexAlign.Center)
          .border({ width: 1, color: RcColors.shareBorder, radius: 8 })
          .margin({ top: 12 })
        }

        Blank().height(16)
      }
      .padding(24)
    }
    .backgroundColor(RcColors.white)
    .width('100%')
    .height('100%')
  }
}