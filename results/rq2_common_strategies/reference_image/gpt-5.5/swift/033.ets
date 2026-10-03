class AppColors {
  static readonly primary: string = '#06B6D4'
  static readonly secondary: string = '#3B82F6'
  static readonly tertiary: string = '#8B5CF6'
  static readonly background: string = '#F0F9FF'
  static readonly surface: string = 'rgba(255, 255, 255, 0.9)'
  static readonly surfaceVariant: string = '#E0F2FE'
  static readonly onTertiary: string = '#FFFFFF'
  static readonly onSurface: string = '#0F172A'
}

class AppSpacing {
  static readonly lg: number = 16
}

class AppShapes {
  static readonly medium: number = 12
  static readonly large: number = 20
}

@Entry
@Component
struct RootScreen {
  @State private spending: number = 500
  private readonly goal: number = 1000

  private formatNumber(value: number): string {
    const rounded: number = Math.round(value)

    if (rounded < 1000) {
      return `${rounded}`
    }

    const thousands: number = Math.floor(rounded / 1000)
    const rest: number = rounded % 1000

    if (rest === 0) {
      return `${thousands},000`
    }

    if (rest < 10) {
      return `${thousands},00${rest}`
    }

    if (rest < 100) {
      return `${thousands},0${rest}`
    }

    return `${thousands},${rest}`
  }

  private progressWidth(): string {
    const value: number = Math.max(0, Math.min(this.spending / this.goal, 1))
    return `${value * 100}%`
  }

  build() {
    Column() {
      Stack() {
        Text('Bill Calendar')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.background)

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Column() {
            Text('Current Spending')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.primary)

            Blank()

            Text(`$${this.formatNumber(this.spending)} / $${this.formatNumber(this.goal)}`)
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.onSurface)

            Blank()

            Stack({ alignContent: Alignment.Start }) {
              Row()
                .width('100%')
                .height(8)
                .backgroundColor(AppColors.surfaceVariant)
                .borderRadius(4)

              Row()
                .width(this.progressWidth())
                .height(8)
                .backgroundColor(AppColors.primary)
                .borderRadius(4)
            }
            .width('100%')
            .height(8)
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .height(160)
          .padding(AppSpacing.lg)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
          .shadow({
            radius: 8,
            color: 'rgba(0, 0, 0, 0.18)',
            offsetX: 0,
            offsetY: 4
          })

          Text('Adjust Spending')
            .width('100%')
            .textAlign(TextAlign.Center)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Slider({
            value: this.spending,
            min: 0,
            max: 2000,
            step: 1,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .selectedColor(AppColors.primary)
            .trackColor(AppColors.surfaceVariant)
            .blockColor('#FFFFFF')
            .trackThickness(4)
            .showTips(false)
            .onChange((value: number) => {
              this.spending = value
            })

          Button('Reset', { type: ButtonType.Normal, stateEffect: true })
            .width('100%')
            .height(48)
            .backgroundColor(AppColors.tertiary)
            .borderRadius(AppShapes.medium)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onTertiary)
            .onClick(() => {
              this.spending = 0
            })
        }
        .width('100%')
        .padding(AppSpacing.lg)
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['rgba(59, 130, 246, 0.3)', 0.0],
          [AppColors.background, 0.5],
          ['rgba(6, 182, 212, 0.2)', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}