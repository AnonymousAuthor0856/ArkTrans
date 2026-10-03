const AppColors = {
  primary: '#FF8FAB',
  secondary: '#B4E3D0',
  tertiary: '#FFD6A5',
  background: '#FFFCF9',
  surface: '#FFFFFF',
  surfaceVariant: '#FDE2E4',
  outline: '#FCC2D7',
  success: '#4ADE80',
  warning: '#FACC15',
  error: '#FB7185',
  onPrimary: '#FFFFFF',
  onSecondary: '#1E1E1E',
  onTertiary: '#1E1E1E',
  onBackground: '#1E1E1E',
  onSurface: '#1E1E1E'
}

const AppSpacing = {
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24
}

@Entry
@Component
struct Index {
  @State knobX: number = 0
  @State knobY: number = 0
  @State isRunning: boolean = false

  build() {
    Column() {
      Text('Pomodoro Timer')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.xl }) {
        Stack({ alignContent: Alignment.Center }) {
          Column()
            .width(360)
            .height(360)
            .backgroundColor('#66B4E3D0')
            .borderRadius(180)

          Column()
            .width(60)
            .height(60)
            .backgroundColor(AppColors.primary)
            .borderRadius(30)
            .margin({ left: this.knobX, top: this.knobY })
        }
        .width(280)
        .height(280)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(140)
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              this.knobX = event.fingerList[0].localX - 140
              this.knobY = event.fingerList[0].localY - 140
            })
        )

        Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isRunning ? AppColors.success : AppColors.error)

        Row({ space: AppSpacing.lg }) {
          Button('Start')
            .type(ButtonType.Normal)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(45)
            .width(90)
            .height(90)
            .onClick(() => {
              this.isRunning = true
            })

          Button('Stop')
            .type(ButtonType.Normal)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.tertiary)
            .borderRadius(45)
            .width(90)
            .height(90)
            .onClick(() => {
              this.isRunning = false
            })
        }
        .alignItems(VerticalAlign.Center)

        Progress({
          value: (this.knobX + this.knobY) % 400 / 400,
          total: 1,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(8)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.background)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}