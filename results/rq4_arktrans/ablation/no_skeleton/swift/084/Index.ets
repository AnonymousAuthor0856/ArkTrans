@Entry
@Component
struct V60GuideApp {
  build() {
    Column() {
      // === Header Section ===
      Row() {
        Column({ space: 4 }) {
          Text('V60 Guide').fontSize(34).fontWeight(FontWeight.Bold).fontColor('#000000')
          Text('Ethiopia Yirgacheffe').fontSize(16).fontColor('#8E8E93')
        }
        Blank()
        Button() {
          Image($r('app.media.startIcon')).width(24).height(24).fillColor('#000000')
        }.backgroundColor(Color.Transparent)
      }.padding({ left: 24, right: 24, top: 30, bottom: 30 }).width('100%')

      Blank()

      // === Timer Section ===
      Column({ space: 10 }) {
        Text('00:45').fontSize(90).fontWeight(FontWeight.Regular).fontColor('#000000').lineHeight(90)
        Text('Target: 300g').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#8E8E93')
      }

      Blank()

      // === Parameters Grid ===
      Row() {
        // Left: Ratio
        Column({ space: 12 }) {
          Stack() {
            Circle().width(64).height(64).borderWidth(1.5).borderColor('#D1D1D6')
            Image($r('app.media.startIcon')).width(24).height(24).fillColor('#8E8E93')
          }
          Column({ space: 4 }) {
            Text('1:15').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#000000')
            Text('Ratio').fontSize(13).fontWeight(FontWeight.Medium).fontColor('#8E8E93')
          }
        }.width(80)

        Blank()

        // Center: Beans
        Column({ space: 12 }) {
          Stack() {
            Circle().width(64).height(64).borderWidth(1.5).borderColor('#D1D1D6')
            Image($r('app.media.startIcon')).width(24).height(24).fillColor('#8E8E93')
          }
          Column({ space: 4 }) {
            Text('20g').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#000000')
            Text('Beans').fontSize(13).fontWeight(FontWeight.Medium).fontColor('#8E8E93')
          }
        }.width(80)

        Blank()

        // Right: Temperature
        Column({ space: 12 }) {
          Stack() {
            Circle().width(64).height(64).borderWidth(1.5).borderColor('#D1D1D6')
            Image($r('app.media.startIcon')).width(24).height(24).fillColor('#8E8E93')
          }
          Column({ space: 4 }) {
            Text('93°C').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#000000')
            Text('Temp').fontSize(13).fontWeight(FontWeight.Medium).fontColor('#8E8E93')
          }
        }.width(80)
      }.padding({ left: 30, right: 30 }).width('100%')

      Blank()

      // === Divider Line ===
      Divider().margin({ left: 24, right: 24, bottom: 20 }).color('#C7C7CC')

      // === Brewing Steps Section ===
      Column({ space: 15 }) {
        Text('Brewing Steps').fontSize(19).fontWeight(FontWeight.Bold).fontColor('#000000').margin({ left: 24, right: 24 })

        Row({ space: 16 }) {
          // Checkmark Icon
          Stack() {
            Circle().width(28).height(28).fill('#000000')
            Image($r('app.media.startIcon')).width(16).height(16).fillColor('#FFFFFF')
          }

          // Step Content Background
          Row() {
            Blank()
          }.width('100%').height(52).backgroundColor('#F2F2F7').borderRadius(10)
        }.margin({ left: 24, right: 24 })
      }

      Blank()

      // === Start Button ===
      Button() {
        Row({ space: 8 }) {
          Image($r('app.media.startIcon')).width(18).height(18).fillColor('#FFFFFF')
          Text('Start Brewing').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
        }
      }.width('100%').height(60).backgroundColor('#000000').borderRadius(18).margin({ left: 24, right: 24, bottom: 30 })
    }.width('100%').height('100%').backgroundColor('#FFFFFF')
  }
}