@Entry
@Component
struct WorkoutPlanPage {
  build() {
    Stack() {
      Column() {
        Text('Workout Plan')
          .fontSize(55)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .lineHeight(66)
          .textAlign(TextAlign.Center)
          .width('100%')
          .margin({ top: 32 })

        Column() {
          Text('Sign In to Continue')
            .fontSize(38)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E293B')
            .lineHeight(46)
            .textAlign(TextAlign.Center)
            .width('100%')
            .margin({ top: 72, bottom: 32 })

          Stack() {
            Text('Workout Preview')
              .fontSize(28)
              .fontWeight(FontWeight.Regular)
              .fontColor('#1E293B')
              .textAlign(TextAlign.Center)
          }
          .width('100%')
          .height(398)
          .backgroundColor('#FFFFFF')
          .border({
            width: 2,
            color: '#CBD5E1',
            radius: 30
          })

          Button('Authenticate', { type: ButtonType.Capsule })
            .width(526)
            .height(104)
            .fontSize(30)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .backgroundColor('#2563EB')
            .borderRadius(30)
            .margin({ top: 34 })
        }
        .width('100%')
        .height(1080)
        .padding({ left: 32, right: 32 })
        .linearGradient({
          angle: 180,
          colors: [
            ['rgba(56, 189, 248, 0.10)', 0.0],
            ['rgba(37, 99, 235, 0.15)', 1.0]
          ]
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F8FAFC')

      Button({ type: ButtonType.Circle }) {
        Text('+')
          .fontSize(56)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .textAlign(TextAlign.Center)
          .offset({ y: -3 })
      }
      .width(112)
      .height(112)
      .backgroundColor('#2563EB')
      .shadow({
        radius: 16,
        color: 'rgba(15, 23, 42, 0.24)',
        offsetX: 0,
        offsetY: 8
      })
      .position({ x: 576, y: 976 })

      Row() {
        Text('Home')
          .fontSize(30)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2563EB')
          .textAlign(TextAlign.Start)
          .layoutWeight(1)

        Text('Plan')
          .fontSize(30)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)

        Text('Profile')
          .fontSize(30)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')
          .textAlign(TextAlign.End)
          .layoutWeight(1)
      }
      .width('100%')
      .height(104)
      .padding({ left: 40, right: 40 })
      .backgroundColor('#FFFFFF')
      .alignItems(VerticalAlign.Center)
      .position({ x: 0, y: 1176 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}
