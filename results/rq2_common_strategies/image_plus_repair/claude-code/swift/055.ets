// MARK: - AppTokens
class AppColors {
  static readonly primary: string = '#FF2563EB'
  static readonly secondary: string = '#FF38BDF8'
  static readonly tertiary: string = '#FF3B82F6'
  static readonly background: string = '#FFF8FAFC'
  static readonly surface: string = '#FFFFFFFF'
  static readonly surfaceVariant: string = '#FFE2E8F0'
  static readonly outline: string = '#FFCBD5E1'
  static readonly success: string = '#FF22C55E'
  static readonly warning: string = '#FFF59E0B'
  static readonly error: string = '#FFEF4444'
  static readonly onPrimary: string = '#FFFFFFFF'
  static readonly onSecondary: string = '#FF0F172A'
  static readonly onTertiary: string = '#FFFFFFFF'
  static readonly onBackground: string = '#FF0F172A'
  static readonly onSurface: string = '#FF1E293B'
}

class AppTypography {
  static readonly displaySize: number = 28
  static readonly displayWeight: FontWeight = FontWeight.Bold
  static readonly headlineSize: number = 20
  static readonly headlineWeight: FontWeight = FontWeight.Medium
  static readonly titleSize: number = 16
  static readonly titleWeight: FontWeight = FontWeight.Medium
  static readonly bodySize: number = 14
  static readonly bodyWeight: FontWeight = FontWeight.Normal
  static readonly labelSize: number = 12
  static readonly labelWeight: FontWeight = FontWeight.Medium
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

// MARK: - RootScreen Component
@Entry
@Component
struct RootScreen {
  private readonly topBarHeight: number = 64
  private readonly bottomBarHeight: number = 80
  private readonly fabSize: number = 56

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // 1. Main content layer - gradient background + content
      Column() {
        Blank().height(this.topBarHeight)

        Text('Sign In to Continue')
          .fontSize(AppTypography.headlineSize)
          .fontWeight(AppTypography.headlineWeight)
          .fontColor(AppColors.onSurface)
          .margin({ bottom: AppSpacing.lg })

        // Workout Preview Box
        Stack() {
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
          color: AppColors.outline,
          radius: AppShapes.large
        })
        .margin({ bottom: AppSpacing.lg })

        // Authenticate Button
        Button('Authenticate')
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.onPrimary)
          .width('80%')
          .height(52)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.large)

        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppColors.secondary, 0.1],
          [AppColors.primary, 0.15]
        ]
      })
      .backgroundColor(AppColors.background)
      .padding({ bottom: this.bottomBarHeight })

      // 2. Top bar
      Row() {
        Text('Workout Plan')
          .fontSize(AppTypography.displaySize)
          .fontWeight(AppTypography.displayWeight)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .height(this.topBarHeight)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.surface)
      .alignSelf(ItemAlign.Start)

      // 3. Bottom bar
      Row() {
        Text('Home')
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.primary)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Plan')
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Profile')
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(this.bottomBarHeight)
      .backgroundColor(AppColors.surface)
      .shadow({
        radius: 8,
        color: AppColors.onBackground,
        offsetY: 4
      })
      .alignSelf(ItemAlign.End)

      // 4. Floating Action Button
      Button('+')
        .fontSize(AppTypography.displaySize)
        .fontColor(AppColors.onPrimary)
        .width(this.fabSize)
        .height(this.fabSize)
        .backgroundColor(AppColors.primary)
        .borderRadius(this.fabSize / 2)
        .margin({
          right: AppSpacing.lg,
          bottom: this.bottomBarHeight + AppSpacing.lg
        })
        .alignSelf(ItemAlign.End)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
