@Entry
@Component
struct RootScreen {
  private topBarHeight: number = 64
  private bottomBarHeight: number = 80
  private fabSize: number = 56

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // 1. Main content layer
      Column({ space: 16 }) {
        // Top placeholder
        Row()
          .height(this.topBarHeight)

        Text('Sign In to Continue')
          .fontSize(20)
          .fontWeight(600)
          .fontColor('#1E293B')

        // Workout Preview Box
        Stack() {
          Text('Workout Preview')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor('#1E293B')
        }
        .width('100%')
        .height(200)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .border({ width: 1, color: '#CBD5E1', radius: 16 })

        // Authenticate Button
        Button('Authenticate')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .width('80%')
          .height(52)
          .backgroundColor('#2563EB')
          .borderRadius(16)

        Blank()
      }
      .padding({ left: 16, right: 16 })
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#1A38BDF8', 0.0],
          ['#262563EB', 1.0]
        ]
      })
      .backgroundColor('#F8FAFC')
      .padding({ bottom: this.bottomBarHeight })

      // 2. Top bar layer
      Row() {
        Text('Workout Plan')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
      }
      .width('100%')
      .height(this.topBarHeight)
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.Center)
      .alignSelf(ItemAlign.Start)
      .position({ x: 0, y: 0 })

      // 3. Bottom bar layer
      Row() {
        Text('Home')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2563EB')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Blank()
          .layoutWeight(1)

        Text('Plan')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')

        Blank()
          .layoutWeight(1)

        Text('Profile')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')
      }
      .padding({ left: 16, right: 16 })
      .width('100%')
      .height(this.bottomBarHeight)
      .backgroundColor('#FFFFFF')
      .shadow({
        color: '#1F0F172A',
        radius: 8,
        offsetX: 0,
        offsetY: 4
      })
      .alignSelf(ItemAlign.End)
      .position({ x: 0, y: 0 })
      .markAnchor({ x: 0, y: -1 * (this.bottomBarHeight) })
      .offset({ x: 0, y: '100%' })

      // 4. FAB layer
      Button('+')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .width(this.fabSize)
        .height(this.fabSize)
        .backgroundColor('#2563EB')
        .borderRadius(this.fabSize / 2)
        .margin({
          right: 16,
          bottom: this.bottomBarHeight + 16
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}