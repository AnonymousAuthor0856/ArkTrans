@Entry
@Component
struct WorkoutPlanPage {
  private readonly primaryColor: string = '#FF2563EB'
  private readonly onSurfaceColor: string = '#FF1E293B'
  private readonly onBackgroundColor: string = '#FF0F172A'
  private readonly previewOutlineColor: string = '#FFCBD5E1'
  private readonly surfaceColor: string = '#FFFFFFFF'

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column({ space: 16 }) {
        Blank()
          .height(64)

        Text('Sign In to Continue')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurfaceColor)

        Stack() {
          Text('Workout Preview')
            .fontSize(14)
            .fontColor(this.onSurfaceColor)
        }
        .width('100%')
        .height(200)
        .backgroundColor(this.surfaceColor)
        .borderRadius(16)
        .border({
          width: 1,
          color: this.previewOutlineColor,
          radius: 16
        })

        Button('Authenticate')
          .width('80%')
          .height(52)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.surfaceColor)
          .backgroundColor(this.primaryColor)
          .borderRadius(16)
          .stateEffect(false)

        Blank()
          .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16, bottom: 80 })
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [
          ['#1A38BDF8', 0],
          ['#262563EB', 1]
        ]
      })

      Column() {
        Text('Workout Plan')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onBackgroundColor)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(this.surfaceColor)
      .align(Alignment.Top)

      Row() {
        Text('Home')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.primaryColor)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Plan')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurfaceColor)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Profile')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurfaceColor)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(80)
      .padding({ left: 16, right: 16 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor(this.surfaceColor)
      .shadow({
        radius: 8,
        color: '#241E293B',
        offsetY: 4
      })
      .align(Alignment.Bottom)

      Button('+')
        .width(56)
        .height(56)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.surfaceColor)
        .backgroundColor(this.primaryColor)
        .borderRadius(28)
        .stateEffect(false)
        .margin({ right: 16, bottom: 96 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8FAFC')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}
