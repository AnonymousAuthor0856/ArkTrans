class AppColors {
  static primary: string = '#2563EB'
  static secondary: string = '#38BDF8'
  static tertiary: string = '#60A5FA'
  static background: string = '#E6F0FF'
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
  @Builder
  CircleIcon(label: string, bgColor: string, textColor: string) {
    Stack() {
      Circle()
        .width(24)
        .height(24)
        .fill(bgColor)
      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(textColor)
        .textAlign(TextAlign.Center)
    }
    .width(40)
    .height(40)
  }

  @Builder
  TopBar() {
    Row() {
      this.CircleIcon('<', AppColors.primary, AppColors.onPrimary)

      Blank()
        .layoutWeight(1)

      Text('Sleep Cycle')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)

      Blank()
        .layoutWeight(1)

      this.CircleIcon('?', AppColors.secondary, AppColors.onSecondary)
    }
    .width('100%')
    .height(56)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
  }

  build() {
    Column() {
      this.TopBar()

      Column({ space: AppSpacing.xl }) {
        Blank()
          .layoutWeight(1)

        Stack() {
          Circle()
            .width(160)
            .height(160)
            .fill(AppColors.surface)
            .stroke(AppColors.outline)
            .strokeWidth(2)

          Text('Zzz')
            .fontSize(36)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.primary)
        }
        .width(160)
        .height(160)

        Text('Welcome Back')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)

        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(14)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')

        Button('Sign In')
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
      .layoutWeight(1)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
