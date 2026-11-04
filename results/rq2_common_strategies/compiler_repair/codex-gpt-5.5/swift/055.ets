class AppColors {
  static primary: string = '#2563EB'
  static secondary: string = '#38BDF8'
  static tertiary: string = '#3B82F6'
  static background: string = '#F8FAFC'
  static surface: string = '#FFFFFF'
  static surfaceVariant: string = '#E2E8F0'
  static outline: string = '#CBD5E1'
  static success: string = '#22C55E'
  static warning: string = '#F59E0B'
  static error: string = '#EF4444'
  static onPrimary: string = '#FFFFFF'
  static onSecondary: string = '#0F172A'
  static onTertiary: string = '#FFFFFF'
  static onBackground: string = '#0F172A'
  static onSurface: string = '#1E293B'
}

class AppSpacing {
  static xs: number = 4
  static sm: number = 8
  static md: number = 12
  static lg: number = 16
  static xl: number = 24
  static xxl: number = 36
}

class AppShape {
  static small: number = 8
  static medium: number = 12
  static large: number = 16
}

@Entry
@Component
struct Index {
  private topBarHeight: number = 64
  private bottomBarHeight: number = 80
  private fabSize: number = 56

  @Builder
  TopBar() {
    Row() {
      Text('Workout Plan')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
    }
    .width('100%')
    .height(this.topBarHeight)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  BottomBar() {
    Row() {
      Text('Home')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('Plan')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('Profile')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(this.bottomBarHeight)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 8, color: '#240F172A', offsetY: -4 })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column({ space: AppSpacing.lg }) {
        Blank()
          .height(this.topBarHeight)

        Text('Sign In to Continue')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)

        Stack() {
          Text('Workout Preview')
            .fontSize(14)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(200)
        .backgroundColor(AppColors.surface)
        .border({ width: 1, color: AppColors.outline, radius: AppShape.large })

        Button('Authenticate')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .width('80%')
          .height(52)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShape.large)

        Blank()
          .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, bottom: this.bottomBarHeight })
      .linearGradient({
        angle: 180,
        colors: [['#1A38BDF8', 0.0], ['#262563EB', 1.0]]
      })

      Column() {
        this.TopBar()
        Blank()
          .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
          .layoutWeight(1)
        this.BottomBar()
      }
      .width('100%')
      .height('100%')

      Button('+')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onPrimary)
        .width(this.fabSize)
        .height(this.fabSize)
        .borderRadius(this.fabSize / 2)
        .backgroundColor(AppColors.primary)
        .margin({ right: AppSpacing.lg, bottom: this.bottomBarHeight + AppSpacing.lg })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
