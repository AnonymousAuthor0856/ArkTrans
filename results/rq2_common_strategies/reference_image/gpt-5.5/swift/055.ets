class AppColors {
  static readonly primary: string = '#2563EB'
  static readonly secondary: string = '#38BDF8'
  static readonly tertiary: string = '#3B82F6'
  static readonly background: string = '#F8FAFC'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E2E8F0'
  static readonly outline: string = '#CBD5E1'
  static readonly success: string = '#22C55E'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#0F172A'
  static readonly onTertiary: string = '#FFFFFF'
  static readonly onBackground: string = '#0F172A'
  static readonly onSurface: string = '#1E293B'

  static readonly secondary10: string = '#1A38BDF8'
  static readonly primary15: string = '#262563EB'
  static readonly shadowLevel2: string = '#240F172A'
}

class AppTypography {
  static readonly displaySize: number = 28
  static readonly headlineSize: number = 20
  static readonly titleSize: number = 16
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12

  static readonly displayWeight: number = 700
  static readonly headlineWeight: number = 600
  static readonly titleWeight: number = 500
  static readonly bodyWeight: number = 400
  static readonly labelWeight: number = 500
}

class AppShapes {
  static readonly small: number = 8
  static readonly medium: number = 12
  static readonly large: number = 16
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 36
}

class AppElevation {
  static readonly level2Radius: number = 8
  static readonly level2Dy: number = 4
}

@Entry
@Component
struct RootScreen {
  private readonly topBarHeight: number = 64
  private readonly bottomBarHeight: number = 80
  private readonly fabSize: number = 56

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column({ space: AppSpacing.lg }) {
        Blank()
          .height(this.topBarHeight)

        Text('Sign In to Continue')
          .fontSize(AppTypography.headlineSize)
          .fontWeight(AppTypography.headlineWeight)
          .fontColor(AppColors.onSurface)

        Stack({ alignContent: Alignment.Center }) {
          Text('Workout Preview')
            .fontSize(AppTypography.bodySize)
            .fontWeight(AppTypography.bodyWeight)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(200)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.large)
        .border({
          width: 1,
          color: AppColors.outline
        })

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Authenticate')
            .fontSize(AppTypography.titleSize)
            .fontWeight(AppTypography.titleWeight)
            .fontColor(AppColors.onPrimary)
        }
        .width('80%')
        .height(52)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.large)

        Blank()
          .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        bottom: this.bottomBarHeight
      })
      .backgroundColor(AppColors.background)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppColors.secondary10, 0.0],
          [AppColors.primary15, 1.0]
        ]
      })
      .align(Alignment.Center)

      Column() {
        Text('Workout Plan')
          .fontSize(AppTypography.displaySize)
          .fontWeight(AppTypography.displayWeight)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .height(this.topBarHeight)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.surface)
      .align(Alignment.Top)

      Row() {
        Text('Home')
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.primary)
          .textAlign(TextAlign.Center)
          .layoutWeight(1)

        Text('Plan')
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.onSurface)
          .margin({ right: AppSpacing.lg })

        Text('Profile')
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(this.bottomBarHeight)
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg
      })
      .backgroundColor(AppColors.surface)
      .shadow({
        radius: AppElevation.level2Radius,
        color: AppColors.shadowLevel2,
        offsetX: 0,
        offsetY: AppElevation.level2Dy
      })
      .align(Alignment.Bottom)

      Button({ type: ButtonType.Circle, stateEffect: true }) {
        Text('+')
          .fontSize(AppTypography.displaySize)
          .fontWeight(AppTypography.displayWeight)
          .fontColor(AppColors.onPrimary)
          .textAlign(TextAlign.Center)
      }
      .width(this.fabSize)
      .height(this.fabSize)
      .backgroundColor(AppColors.primary)
      .borderRadius(this.fabSize / 2)
      .margin({
        right: AppSpacing.lg,
        bottom: this.bottomBarHeight + AppSpacing.lg
      })
      .align(Alignment.BottomEnd)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}