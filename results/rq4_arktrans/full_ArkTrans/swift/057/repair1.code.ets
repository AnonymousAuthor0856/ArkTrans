@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Row() {
          Button() {
            Stack() {
              Circle().width(24).height(24).fill('#2563EB')
              Text('<').fontSize(12).fontColor('#FFFFFF')
            }
          }.padding({ left: 12 })

          Blank()

          Text('Sleep Cycle').fontColor('#0F172A').fontSize(28)

          Blank()

          Button() {
            Stack() {
              Circle().width(24).height(24).fill('#38BDF8')
              Text('?').fontSize(12).fontColor('#0F172A')
            }
          }.padding({ right: 12 })
        }.backgroundColor('#FFFFFF').height(56)

        Column() {
          Blank()

          Stack() {
            Circle().width(160).height(160).fill('#FFFFFF')
            Circle().width(160).height(160).stroke('#CBD5E1').strokeWidth(2)
            Text('😴').fontSize(48)
          }

          Text('Welcome Back').fontColor('#1E293B').fontSize(20)

          Text('Track your sleep patterns and improve rest quality.').textAlign(TextAlign.Center).fontColor('#1E293B').fontSize(14)

          Button() {
            Text('Sign In').borderRadius(20).backgroundColor('#2563EB').height(52).width('100%').fontColor('#FFFFFF').fontSize(16)
          }.width('80%')

          Blank()

          Stack() {
            Rect().linearGradient({
              direction: GradientDirection.Bottom,
              colors: [['#E6EEFF', 0], ['#FFFFFF', 1]]
            }).width('100%').height('100%')
          }.width('100%').height('100%')
        }.backgroundColor('#E6EEFF').layoutWeight(1).padding({ left: 12, right: 12 }).space(24)
      }.width('100%').height('100%')
    }.width('100%').height('100%')
  }
}