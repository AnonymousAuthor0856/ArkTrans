import window from '@ohos.window';

const NAME: string = '082_WorkoutPlan_en';
const UI_TYPE: string = 'Health Auth';
const STYLE_THEME: string = 'Modern Blue';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#2563EB';
  static readonly secondary: string = '#38BDF8';
  static readonly tertiary: string = '#3B82F6';
  static readonly background: string = '#F8FAFC';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E2E8F0';
  static readonly outline: string = '#CBD5E1';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#0F172A';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#1E293B';

  static readonly secondaryAlpha10: string = '#1A38BDF8';
  static readonly primaryAlpha15: string = '#262563EB';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly headlineSize: number = 20;
  static readonly titleSize: number = 16;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 16;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.14);
  static readonly level3: ShadowSpec = new ShadowSpec(8, 12, 6, 0.16);
}

@Entry
@Component
struct MainActivity {
  aboutToAppear(): void {
    window.getLastWindow(getContext(this)).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
    });
  }

  build() {
    RootScreen()
  }
}

@Component
struct RootScreen {
  @Builder
  TopBar() {
    Row() {
      Text('Workout Plan')
        .fontSize(AppTypography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(72)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.background)
  }

  @Builder
  BottomBar() {
    Row() {
      Text('Home')
        .fontSize(AppTypography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)

      Text('Plan')
        .fontSize(AppTypography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Text('Profile')
        .fontSize(AppTypography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(80)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: AppElevationMapping.level2.radius,
      color: 'rgba(15, 23, 42, 0.14)',
      offsetX: 0,
      offsetY: -AppElevationMapping.level2.dy
    })
  }

  @Builder
  FloatingButton() {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      Text('+')
        .fontSize(AppTypography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onPrimary)
    }
    .width(56)
    .height(56)
    .backgroundColor(AppColors.primary)
  }

  @Builder
  ContentArea() {
    Column({ space: AppSpacing.lg }) {
      Text('Sign In to Continue')
        .fontSize(AppTypography.headlineSize)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)

      Row() {
        Text('Workout Preview')
          .fontSize(AppTypography.bodySize)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(200)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.surface)
      .border({
        width: 1,
        color: AppColors.outline,
        radius: AppShapes.large
      })

      Button('Authenticate')
        .width('80%')
        .height(52)
        .fontSize(AppTypography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.large)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      angle: 180,
      colors: [
        [AppColors.secondaryAlpha10, 0.0],
        [AppColors.primaryAlpha15, 1.0]
      ]
    })
  }

  build() {
    Stack() {
      Column() {
        this.TopBar()

        this.ContentArea()
          .layoutWeight(1)

        this.BottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      this.FloatingButton()
        .position({ x: 'calc(100% - 72vp)', y: 'calc(100% - 152vp)' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}