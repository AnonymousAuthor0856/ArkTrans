const AppColors = {
  primary: '#38BDF8',
  secondary: '#A78BFA',
  tertiary: '#7DD3FC',
  background: '#F1F5F9',
  surface: '#FFFFFF',
  surfaceVariant: '#E2E8F0',
  outline: '#CBD5E1',
  success: '#22C55E',
  warning: '#F59E0B',
  error: '#EF4444',
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
  xl: 24,
  xxl: 32
}

@Entry
@Component
struct Index {
  @State scrollY: number = 0
  private lines: number[] = [0, 1, 2, 3, 4, 5, 6, 7]

  build() {
    Column() {
      Text('Glass Doc Reader')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor(AppColors.background)

      Stack({ alignContent: Alignment.Center }) {
        Column({ space: AppSpacing.md }) {
          Text('Document Reader')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)
          ForEach(this.lines, (i: number) => {
            Text(`This is a sample line of text content number ${i + 1}.`)
              .fontSize(14)
              .fontColor(AppColors.onSurface)
          }, (i: number) => i.toString())
        }
        .width('90%')
        .height(400)
        .padding(AppSpacing.lg)
        .backgroundColor('#B3FFFFFF')
        .borderRadius(20)
        .margin({ top: this.scrollY / 5 })
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.TopBottom,
        colors: [['#CCE2E8F0', 0], ['#F1F5F9', 0.5], ['#CCE2E8F0', 1]]
      })
      .gesture(
        PanGesture()
          .onActionUpdate((event: GestureEvent) => {
            this.scrollY = this.scrollY + event.fingerList[0].localY
          })
      )
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}