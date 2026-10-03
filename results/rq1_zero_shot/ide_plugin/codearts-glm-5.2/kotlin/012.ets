const AppColors = {
  primary: '#60A5FA',
  secondary: '#93C5FD',
  tertiary: '#A5B4FC',
  background: '#F9FAFB',
  surface: '#FFFFFF',
  surfaceVariant: '#EFF6FF',
  outline: '#D1D5DB',
  success: '#16A34A',
  warning: '#F59E0B',
  error: '#DC2626',
  onPrimary: '#FFFFFF',
  onSecondary: '#1E293B',
  onTertiary: '#1E1E2F',
  onBackground: '#111827',
  onSurface: '#111827'
}

const AppSpacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32
}

@Entry
@Component
struct Index {
  @State markerX: number = 200
  @State markerY: number = 400

  build() {
    Column() {
      Text('Favorite Spots Map')
        .fontSize(28)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor(AppColors.background)

      Stack({ alignContent: Alignment.Center }) {
        Stack({ alignContent: Alignment.Center }) {
          Column()
            .width(440)
            .height(440)
            .backgroundColor('#3393C5FD')
            .borderRadius(220)

          Column()
            .width(680)
            .height(680)
            .backgroundColor('#3393C5FD')
            .borderRadius(340)

          Column()
            .width(28)
            .height(28)
            .backgroundColor(AppColors.primary)
            .borderRadius(14)

          Column()
            .width(60)
            .height(60)
            .border({ width: 3, color: '#4D60A5FA' })
            .borderRadius(30)
        }
        .width('100%')
        .height(400)
        .linearGradient({
          direction: GradientDirection.Center,
          colors: [['#CCFFFFFF', 0], ['#99EFF6FF', 1]]
        })
        .border({ width: 1, color: AppColors.outline, radius: 24 })

        Column({ space: AppSpacing.md }) {
          Text(`Spot Coordinates: (${Math.floor(this.markerX)}, ${Math.floor(this.markerY)})`)
            .fontSize(14)
            .fontColor(AppColors.onSurface)

          Button('Save Marker')
            .type(ButtonType.Normal)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(16)
            .width('100%')
            .height(48)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .linearGradient({
        direction: GradientDirection.TopBottom,
        colors: [['#99FFFFFF', 0], ['#80EFF6FF', 0.5], ['#B3FFFFFF', 1]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}