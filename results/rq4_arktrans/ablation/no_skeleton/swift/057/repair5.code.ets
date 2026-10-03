@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      // === Top Bar ===
      Row() {
        Button() {
          Stack() {
            Circle().width(24).height(24).fill('#2563EB')
            Text('<').fontColor('#FFFFFF').fontSize(12).fontWeight(FontWeight.Medium)
          }
        }.padding({ left: 16 })

        Blank()

        Text('Sleep Cycle').fontColor('#0F172A').fontSize(28).fontWeight(FontWeight.Bold)

        Blank()

        Button() {
          Stack() {
            Circle().width(24).height(24).fill('#38BDF8')
            Text('?').fontColor('#0F172A').fontSize(12).fontWeight(FontWeight.Medium)
          }
        }.padding({ right: 16 })
      }.height(56).backgroundColor('#FFFFFF')

      // === Main Content Area ===
      Column() {
        Blank()

        // Central Emoji Box
        Stack() {
          Circle().width(160).height(160).fill('#FFFFFF').border({ width: 2, color: '#CBD5E1' })
          Text('😴').fontSize(48)
        }

        // Welcome Back Text
        Text('Welcome Back').fontColor('#1E293B').fontSize(20).fontWeight(FontWeight.SemiBold).margin({ top: 24 })

        // Description Text
        Text('Track your sleep patterns and improve rest quality.').fontColor('#1E293B').fontSize(14).textAlign(TextAlign.Center).margin({ top: 12 })

        // Sign In Button
        Button() {
          Text('Sign In').fontColor('#FFFFFF').fontSize(16).fontWeight(FontWeight.Medium)
        }.width('80%').height(52).backgroundColor('#2563EB').borderRadius(16).margin({ top: 24 })

        Blank()
      }.width('100%').layoutWeight(1).padding({ left: 16, right: 16 }).backgroundColor('#E6F0FF')
    }.width('100%').height('100%')
  }
}