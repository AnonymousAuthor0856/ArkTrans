import { LengthMetrics } from '@kit.ArkUI';

// MARK: - AppTokens
class AppColors {
  static readonly primary: string = '#FF2563EB';
  static readonly secondary: string = '#FF38BDF8';
  static readonly tertiary: string = '#FF3B82F6';
  static readonly background: string = '#FFF8FAFC';
  static readonly surface: string = '#FFFFFFFF';
  static readonly surfaceVariant: string = '#FFE2E8F0';
  static readonly outline: string = '#FFCBD5E1';
  static readonly success: string = '#FF22C55E';
  static readonly warning: string = '#FFF59E0B';
  static readonly error: string = '#FFEF4444';
  static readonly onPrimary: string = '#FFFFFFFF';
  static readonly onSecondary: string = '#FF0F172A';
  static readonly onTertiary: string = '#FFFFFFFF';
  static readonly onBackground: string = '#FF0F172A';
  static readonly onSurface: string = '#FF1E293B';
}

class AppTypography {
  static readonly display: number = 28;
  static readonly headline: number = 20;
  static readonly title: number = 16;
  static readonly body: number = 14;
  static readonly label: number = 12;
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

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.14);
  static readonly level3: ShadowSpec = new ShadowSpec(8, 12, 6, 0.16);
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  private topBarHeight: number = 64;
  private bottomBarHeight: number = 80;
  private fabSize: number = 56;

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // 1. Main content layer
      Column({ space: AppSpacing.lg }) {
        // Top placeholder
        Blank()
          .height(this.topBarHeight)

        Text('Sign In to Continue')
          .fontSize(AppTypography.headline)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)

        // Workout Preview Box
        Stack() {
          Text('Workout Preview')
            .fontSize(AppTypography.body)
            .fontWeight(FontWeight.Normal)
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

        // Authenticate Button
        Button('Authenticate')
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .width('80%')
          .height(52)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.large)
          .onClick(() => {})

        Blank()
      }
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [`${AppColors.secondary}1A`, 0.0],
          [`${AppColors.primary}26`, 1.0]
        ]
      })
      .backgroundColor(AppColors.background)
      .padding({ bottom: this.bottomBarHeight })

      // 2. Custom Top Bar
      Row() {
        Text('Workout Plan')
          .fontSize(AppTypography.display)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .height(this.topBarHeight)
      .backgroundColor(AppColors.surface)
      .justifyContent(FlexAlign.Center)
      .alignSelf(ItemAlign.Start)

      // 3. Custom Bottom Bar
      Row({ space: 0 }) {
        Text('Home')
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Blank()
          .layoutWeight(1)

        Text('Plan')
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)

        Blank()
          .layoutWeight(1)

        Text('Profile')
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .width('100%')
      .height(this.bottomBarHeight)
      .backgroundColor(AppColors.surface)
      .shadow({
        color: `rgba(15,23,42,${AppElevation.level2.opacity})`,
        radius: AppElevation.level2.radius,
        offsetY: AppElevation.level2.dy
      })
      .alignSelf(ItemAlign.End)

      // 4. Floating Action Button
      Button('+')
        .fontSize(AppTypography.display)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onPrimary)
        .width(this.fabSize)
        .height(this.fabSize)
        .backgroundColor(AppColors.primary)
        .borderRadius(this.fabSize / 2)
        .margin({
          right: AppSpacing.lg,
          bottom: this.bottomBarHeight + AppSpacing.lg
        })
        .onClick(() => {})
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}