@Entry
@Component
struct AeroSensePage {
  @State aqiValue: number = 42

  build() {
    Column() {
      // Top Header
      Row() {
        Column() {
          Text('Living Room')
            .fontSize(24)
            .fontColor('#757575')
            .fontWeight(FontWeight.Normal)
          Text('AeroSense')
            .fontSize(48)
            .fontColor('#1A1A1A')
            .fontWeight(FontWeight.Bold)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        // Settings button
        Stack() {
          Image($r('sys.media.sys_ic_contacts_circle'))
            .width(48)
            .height(48)
            .fillColor('#1A1A1A')
        }
        .width(80)
        .height(80)
        .backgroundColor('#FAFAFA')
        .borderRadius(40)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 40, bottom: 24 })

      Scroll() {
        Column({ space: 32 }) {
          // Air Quality Circle
          Stack({ alignContent: Alignment.Center }) {
            // Background arc track
            Canvas() {
              Arc()
                .fill('none')
                .stroke('#FAFAFA')
                .strokeWidth(40)
                .strokeLineCap(LineCapStyle.Round)
                .startAngle(135)
                .endAngle(405)
                .centerX(110)
                .centerY(110)
                .radius(110)

              // Progress arc (green) - 42/100 * 270 degrees ≈ 113 degrees
              Arc()
                .fill('none')
                .stroke('#4CAF50')
                .strokeWidth(40)
                .strokeLineCap(LineCapStyle.Round)
                .startAngle(135)
                .endAngle(248)
                .centerX(110)
                .centerY(110)
                .radius(110)

              // Decorative dot
              Circle()
                .fill('#FFFFFF')
                .centerX(167)
                .centerY(167)
                .radius(12)
            }
            .width(220)
            .height(220)

            // Center text content
            Column() {
              Text('AQI')
                .fontSize(20)
                .fontColor('#757575')
                .fontWeight(FontWeight.Bold)
                .letterSpacing(2)
              Text('42')
                .fontSize(80)
                .fontColor('#1A1A1A')
                .fontWeight(FontWeight.Medium)
                .margin({ top: 4 })
              Text('Excellent')
                .fontSize(20)
                .fontColor('#4CAF50')
                .backgroundColor('rgba(76, 175, 80, 0.1)')
                .borderRadius(16)
                .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                .margin({ top: 8 })
            }
            .alignItems(HorizontalAlign.Center)
          }
          .width('100%')
          .height(260)
          .margin({ top: 16 })

          // Metrics Grid - Row 1
          Row({ space: 16 }) {
            // Temp Card
            Column() {
              Image($r('sys.media.sys_ic_contacts_circle'))
                .width(20)
                .height(20)
                .fillColor('#1A1A1A')
              Blank()
              Text('23°C')
                .fontSize(36)
                .fontColor('#1A1A1A')
                .fontWeight(FontWeight.SemiBold)
              Text('Temp')
                .fontSize(16)
                .fontColor('#757575')
                .margin({ top: 4 })
            }
            .width('50%')
            .height(150)
            .backgroundColor('#FAFAFA')
            .borderRadius(24)
            .padding(16)
            .alignItems(HorizontalAlign.Start)

            // Humidity Card
            Column() {
              Image($r('sys.media.sys_ic_contacts_circle'))
                .width(20)
                .height(20)
                .fillColor('#4CAF50')
              Blank()
              Text('45%')
                .fontSize(36)
                .fontColor('#1A1A1A')
                .fontWeight(FontWeight.SemiBold)
              Text('Humidity')
                .fontSize(16)
                .fontColor('#757575')
                .margin({ top: 4 })
            }
            .width('50%')
            .height(150)
            .backgroundColor('#FAFAFA')
            .borderRadius(24)
            .padding(16)
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })

          Blank()
        }
        .width('100%')
      }
      .layoutWeight(1)

      // Bottom Control Bar
      Column() {
        Divider()
          .color('#EEEEEE')
          .strokeWidth(1)

        Row() {
          // Menu icon
          Stack() {
            Image($r('sys.media.sys_ic_contacts_circle'))
              .width(24)
              .height(24)
              .fillColor('#1A1A1A')
          }
          .width(64)
          .height(64)
          .border({ width: 1, color: '#EEEEEE' })
          .borderRadius(32)

          Blank()

          // Refresh Data Button
          Row() {
            Image($r('sys.media.sys_ic_contacts_circle'))
              .width(20)
              .height(20)
              .fillColor('#FFFFFF')
            Text('Refresh Data')
              .fontSize(20)
              .fontColor('#FFFFFF')
              .fontWeight(FontWeight.Medium)
              .margin({ left: 8 })
          }
          .height(64)
          .padding({ left: 32, right: 32 })
          .backgroundColor('#1A1A1A')
          .borderRadius(24)

          Blank()

          // Add icon
          Stack() {
            Image($r('sys.media.sys_ic_contacts_circle'))
              .width(24)
              .height(24)
              .fillColor('#1A1A1A')
          }
          .width(64)
          .height(64)
          .border({ width: 1, color: '#EEEEEE' })
          .borderRadius(32)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 20, bottom: 24 })
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
