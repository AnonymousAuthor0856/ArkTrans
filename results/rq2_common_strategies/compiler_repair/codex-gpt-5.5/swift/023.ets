@Entry
@Component
struct Index {
  @State isRunning: boolean = false

  private cPrimary: string = '#FF8FAB'
  private cSecondary: string = '#B4E3D0'
  private cTertiary: string = '#FFD6A5'
  private cBackground: string = '#FFFCF9'
  private cSurface: string = '#FFFFFF'
  private cSurfaceVariant: string = '#FDE2E4'
  private cOutline: string = '#FCC2D7'
  private cSuccess: string = '#4ADE80'
  private cError: string = '#FB7185'
  private cText: string = '#1E1E1E'

  @Builder
  TimerCircle() {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(280)
        .height(280)
        .fill(this.cSurfaceVariant)
        .shadow({ radius: 8, color: '#2E000000', offsetY: 4 })
      Circle()
        .width(180)
        .height(180)
        .fill('#66B4E3D0')
      Circle()
        .width(60)
        .height(60)
        .fill(this.cPrimary)
        .translate({ x: 90, y: 0 })
    }
    .width(280)
    .height(280)
  }

  @Builder
  ProgressBar() {
    Stack({ alignContent: Alignment.Start }) {
      Rect()
        .width('100%')
        .height(8)
        .radius(4)
        .fill(this.cSurfaceVariant)
      Rect()
        .width('40%')
        .height(8)
        .radius(4)
        .fill(this.cPrimary)
    }
    .width('100%')
    .height(8)
    .padding({ left: 16, right: 16 })
  }

  build() {
    Stack() {
      Column() {
        Blank().height(16)
        Row() {
          Text('Pomodoro Timer')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.cText)
        }
        .width('100%')
        .height(64)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(this.cBackground)

        Column() {
          this.TimerCircle()
            
          Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isRunning ? this.cSuccess : this.cError)
            .margin({ top: 24 })

          Row() {
            Button('Start')
              .width(90)
              .height(90)
              .fontSize(14)
              .fontColor(Color.White)
              .backgroundColor(this.cPrimary)
              .borderRadius(45)
              .onClick(() => {
                this.isRunning = true
              })
            Blank().width(16)
            Button('Stop')
              .width(90)
              .height(90)
              .fontSize(14)
              .fontColor(this.cText)
              .backgroundColor(this.cTertiary)
              .borderRadius(45)
              .onClick(() => {
                this.isRunning = false
              })
          }
          .margin({ top: 24, bottom: 24 })

          this.ProgressBar()
        }
        .width('100%')
        .padding({ top: 16 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.cBackground)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cBackground)
  }
}
