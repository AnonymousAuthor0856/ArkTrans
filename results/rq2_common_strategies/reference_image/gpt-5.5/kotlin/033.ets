class AppColors {
  static readonly primary: string = '#06B6D4'
  static readonly secondary: string = '#3B82F6'
  static readonly tertiary: string = '#8B5CF6'
  static readonly background: string = '#F0F9FF'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E0F2FE'
  static readonly outline: string = '#BAE6FD'
  static readonly success: string = '#22C55E'
  static readonly warning: string = '#FACC15'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#FFFFFF'
  static readonly onBackground: string = '#0F172A'
  static readonly onSurface: string = '#0F172A'
  static readonly gradientTop: string = '#BFDBFE'
  static readonly gradientBottom: string = '#CFFAFE'
}

class AppTypography {
  static readonly display: number = 28
  static readonly title: number = 18
  static readonly body: number = 14
  static readonly label: number = 12
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 12
  static readonly large: number = 20
}

class AppSpacing {
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
}

@Entry
@Component
struct RootScreen {
  @State private spending: number = 500
  private goal: number = 1000

  private progressWidth(): string {
    const progress: number = Math.max(0, Math.min(1, this.spending / this.goal))
    return `${progress * 100}%`
  }

  build() {
    Column() {
      Row() {
        Text('Bill Calendar')
          .fontSize(AppTypography.display)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(96)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.lg }) {
        Column() {
          Text('Current Spending')
            .fontSize(AppTypography.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)

          Text(`$${Math.floor(this.spending)} / $${Math.floor(this.goal)}`)
            .fontSize(AppTypography.display)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onSurface)

          Stack({ alignContent: Alignment.Start }) {
            Row()
              .width('100%')
              .height(8)
              .borderRadius(4)
              .backgroundColor(AppColors.surfaceVariant)

            Row()
              .width(this.progressWidth())
              .height(8)
              .borderRadius(4)
              .backgroundColor(AppColors.primary)
          }
          .width('100%')
          .height(8)
        }
        .width('100%')
        .height(160)
        .padding(AppSpacing.lg)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(HorizontalAlign.Start)
        .borderRadius(AppShapes.large)
        .backgroundColor(AppColors.surface)
        .shadow({
          radius: 8,
          color: '#2E000000',
          offsetX: 0,
          offsetY: 4
        })

        Text('Adjust Spending')
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Center)

        Slider({
          value: this.spending,
          min: 0,
          max: 2000,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .blockColor(AppColors.secondary)
          .selectedColor(AppColors.primary)
          .trackColor(AppColors.surfaceVariant)
          .onChange((value: number) => {
            this.spending = value
          })

        Button() {
          Text('Reset')
            .fontSize(AppTypography.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onTertiary)
        }
        .width('100%')
        .height(48)
        .borderRadius(AppShapes.medium)
        .backgroundColor(AppColors.tertiary)
        .onClick(() => {
          this.spending = 0
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: AppSpacing.lg
      })
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [
          [AppColors.gradientTop, 0.0],
          [AppColors.background, 0.5],
          [AppColors.gradientBottom, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}