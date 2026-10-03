const AppColors = {
  primary: '#8B5CF6',
  secondary: '#D946EF',
  tertiary: '#3B82F6',
  background: '#F9F5FF',
  surface: '#FFFFFF',
  surfaceVariant: '#F1E9FE',
  outline: '#E3D7FE',
  success: '#22C55E',
  warning: '#FACC15',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#FFFFFF',
  onBackground: '#1E1E1E',
  onSurface: '#1E1E1E'
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
  @State fontSize: number = 24
  @State syncProgress: number = 0.3

  build() {
    Column() {
      Text('Subtitle Editor')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.lg }) {
        Column() {
          Text('Sample Subtitle Line')
            .fontSize(this.fontSize)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(200)
        .backgroundColor(AppColors.surface)
        .borderRadius(22)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        Text(`Font Size: ${Math.floor(this.fontSize)}sp`)
          .fontSize(14)
          .fontColor(AppColors.onSurface)

        Slider({
          value: this.fontSize,
          min: 16,
          max: 48,
          style: SliderStyle.OutSet
        })
          .blockColor(AppColors.secondary)
          .trackColor(AppColors.surfaceVariant)
          .selectedColor(AppColors.primary)
          .width('100%')
          .onChange((value: number) => {
            this.fontSize = value
          })

        Text('Sync Progress')
          .fontSize(14)
          .fontColor(AppColors.onSurface)

        Progress({
          value: this.syncProgress,
          total: 1,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(6)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)

        Row({ space: AppSpacing.md }) {
          Button('Sync +')
            .type(ButtonType.Normal)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(14)
            .layoutWeight(1)
            .height(48)
            .onClick(() => {
              this.syncProgress = Math.min(1, this.syncProgress + 0.1)
            })

          Button('Sync -')
            .type(ButtonType.Normal)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(14)
            .layoutWeight(1)
            .height(48)
            .onClick(() => {
              this.syncProgress = Math.max(0, this.syncProgress - 0.1)
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .linearGradient({
        direction: GradientDirection.TopBottom,
        colors: [['#F1E9FE', 0], ['#F9F5FF', 0.5], ['#FFFFFF', 1]]
      })
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}