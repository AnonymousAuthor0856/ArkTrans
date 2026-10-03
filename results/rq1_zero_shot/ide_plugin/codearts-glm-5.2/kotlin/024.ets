const AppColors = {
  primary: '#EF476F',
  secondary: '#FFD166',
  tertiary: '#06D6A0',
  background: '#FFFCF2',
  surface: '#FFFFFF',
  surfaceVariant: '#F7EDE2',
  outline: '#E5D4B1',
  success: '#06D6A0',
  warning: '#FFA600',
  error: '#D62828',
  onPrimary: '#FFFFFF',
  onSecondary: '#1E1E1E',
  onTertiary: '#1E1E1E',
  onBackground: '#1E1E1E',
  onSurface: '#1E1E1E'
}

const AppSpacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24
}

@Entry
@Component
struct Index {
  @State pointsX: number[] = []
  @State pointsY: number[] = []
  @State currentColor: string = '#EF476F'

  build() {
    Column() {
      Text('Retro Whiteboard')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor(AppColors.background)

      Stack() {
        ForEach(this.pointsX, (px: number, index: number) => {
          Column()
            .width(20)
            .height(20)
            .backgroundColor(this.currentColor)
            .borderRadius(10)
            .margin({ left: px - 10, top: this.pointsY[index] - 10 })
        }, (px: number, index: number) => index.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppColors.background)
      .gesture(
        PanGesture()
          .onActionUpdate((event: GestureEvent) => {
            this.pointsX.push(event.fingerList[0].localX)
            this.pointsY.push(event.fingerList[0].localY)
          })
      )

      Row() {
        Button('Clear')
          .type(ButtonType.Normal)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .backgroundColor(AppColors.secondary)
          .borderRadius(20)
          .margin({ right: AppSpacing.md })
          .onClick(() => {
            this.pointsX = []
            this.pointsY = []
          })
      }
      .width('100%')
      .padding({ right: AppSpacing.lg, top: AppSpacing.sm })
      .justifyContent(FlexAlign.End)

      Row() {
        Button('Red')
          .type(ButtonType.Normal)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(6)
          .onClick(() => {
            this.currentColor = '#EF476F'
          })

        Button('Yellow')
          .type(ButtonType.Normal)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .backgroundColor(AppColors.secondary)
          .borderRadius(6)
          .onClick(() => {
            this.currentColor = '#FFD166'
          })

        Button('Green')
          .type(ButtonType.Normal)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onTertiary)
          .backgroundColor(AppColors.tertiary)
          .borderRadius(6)
          .onClick(() => {
            this.currentColor = '#06D6A0'
          })
      }
      .width('100%')
      .padding(AppSpacing.md)
      .backgroundColor(AppColors.surface)
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}