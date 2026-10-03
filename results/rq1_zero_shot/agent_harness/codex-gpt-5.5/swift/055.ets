class AppColors {
  static primary: string = '#2563EB';
  static secondary: string = '#38BDF8';
  static tertiary: string = '#3B82F6';
  static background: string = '#F8FAFC';
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
  private topBarHeight: number = 64;
  private bottomBarHeight: number = 80;
  private fabSize: number = 56;

  @Builder
  private MainContent() {
    Column({ space: AppSpacing.lg }) {
      Blank()
        .height(this.topBarHeight)

      Text('Sign In to Continue')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)

      Stack() {
        Text('Workout Preview')
          .fontSize(14)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(200)
      .backgroundColor(AppColors.surface)
      .borderRadius(16)
      .border({ width: 1, color: AppColors.outline })

      Button('Authenticate')
        .width('80%')
        .height(52)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(16)

      Blank()
    }
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, bottom: this.bottomBarHeight })
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  private TopBar() {
    Column() {
      Text('Workout Plan')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height(this.topBarHeight)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  private BottomBar() {
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
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .width('100%')
    .height(this.bottomBarHeight)
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 8, color: '#0F172A24', offsetX: 0, offsetY: 4 })
  }

  @Builder
  private FloatingActionButton() {
    Button('+')
      .width(this.fabSize)
      .height(this.fabSize)
      .fontSize(28)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.onPrimary)
      .backgroundColor(AppColors.primary)
      .borderRadius(this.fabSize / 2)
  }

  build() {
    Stack() {
      this.MainContent()

      Column() {
        this.TopBar()
        Blank()
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
        this.BottomBar()
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
        Row() {
          Blank()
          this.FloatingActionButton()
            .margin({ right: AppSpacing.lg, bottom: this.bottomBarHeight + AppSpacing.lg })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
