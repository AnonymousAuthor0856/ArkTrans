class AppColors {
  static primary: string = '#2563EB';
  static secondary: string = '#38BDF8';
  static tertiary: string = '#60A5FA';
  static background: string = '#E6F0FF';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#E2E8F0';
  static outline: string = '#CBD5E1';
  static success: string = '#22C55E';
  static warning: string = '#F59E0B';
  static error: string = '#EF4444';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#0F172A';
  static onTertiary: string = '#FFFFFF';
  static onBackground: string = '#0F172A';
  static onSurface: string = '#1E293B';
}

class AppSpacing {
  static xs: number = 4;
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 24;
  static xxl: number = 36;
}

@Entry
@Component
struct RootScreen {
  @Builder
  private TopBar() {
    Row() {
      Stack() {
        Circle()
          .width(24)
          .height(24)
          .fill(AppColors.primary)
        Text('<')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
      }
      .width(24)
      .height(24)
      .margin({ left: AppSpacing.lg })

      Blank()

      Text('Sleep Cycle')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)

      Blank()

      Stack() {
        Circle()
          .width(24)
          .height(24)
          .fill(AppColors.secondary)
        Text('?')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
      }
      .width(24)
      .height(24)
      .margin({ right: AppSpacing.lg })
    }
    .width('100%')
    .height(56)
    .backgroundColor(AppColors.surface)
  }

  build() {
    Column({ space: 0 }) {
      this.TopBar()

      Column({ space: AppSpacing.xl }) {
        Blank()

        Stack() {
          Circle()
            .width(160)
            .height(160)
            .fill(AppColors.surface)
            .stroke(AppColors.outline)
            .strokeWidth(2)
          Text('😴')
            .fontSize(48)
        }
        .width(160)
        .height(160)

        Text('Welcome Back')
          .fontSize(20)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)

        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(14)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)

        Button('Sign In')
          .width('80%')
          .height(52)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(16)

        Blank()
      }
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
