// MARK: - AppTokens

interface FontStyle {
  size: number;
  weight: FontWeight;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokens {
  static readonly Colors: Record<string, string> = {
    primary: '#2563EB',
    secondary: '#38BDF8',
    tertiary: '#3B82F6',
    background: '#F8FAFC',
    surface: '#FFFFFF',
    surfaceVariant: '#E2E8F0',
    outline: '#CBD5E1',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#0F172A',
    onTertiary: '#FFFFFF',
    onBackground: '#0F172A',
    onSurface: '#1E293B',
  };

  static readonly Typography: Record<string, FontStyle> = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Semibold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium },
  };

  static readonly Shapes: Record<string, number> = {
    small: 8,
    medium: 12,
    large: 16,
  };

  static readonly Spacing: Record<string, number> = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36,
  };

  static readonly ElevationMapping: Record<string, ShadowSpec> = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.14 },
    level3: { elevation: 8, radius: 12, dy: 6, opacity: 0.16 },
  };
}

@Component
struct RootScreen {
  private topBarHeight: number = 64;
  private bottomBarHeight: number = 80;
  private fabSize: number = 56;

  build() {
    Stack() {
      // Main content layer
      Column({ space: AppTokens.Spacing.lg }) {
        Blank().height(this.topBarHeight)

        Text('Sign In to Continue')
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Stack() {
          Text('Workout Preview')
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(200)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .border({ width: 1, color: AppTokens.Colors.outline })

        Button() {
          Text('Authenticate')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .width('100%')
            .height(52)
        }
        .width('80%')
        .height(52)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.large)
        .onClick(() => {})

        Blank()
      }
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .width('100%')
      .height('100%')
      .padding({ bottom: this.bottomBarHeight })
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#1A38BDF8', 0.0],
          ['#262563EB', 1.0]
        ]
      })

      // Custom top bar layer
      Column() {
        Column() {
          Text('Workout Plan')
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .fontColor(AppTokens.Colors.onBackground)
        }
        .alignItems(HorizontalAlign.Center)
        .width('100%')
        .height(this.topBarHeight)
        .backgroundColor(AppTokens.Colors.surface)
      }
      .width('100%')
      .height('100%')

      // Custom bottom bar layer
      Column() {
        Blank()
        Row() {
          Text('Home')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.primary)
            .width('33.33%')
            .textAlign(TextAlign.Center)
          Blank()
          Text('Plan')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
          Blank()
          Text('Profile')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .width('100%')
        .height(this.bottomBarHeight)
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: '#241E293B',
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })
      }
      .width('100%')
      .height('100%')

      // Floating action button layer
      Column() {
        Blank()
        Row() {
          Blank()
          Button() {
            Text('+')
              .fontSize(AppTokens.Typography.display.size)
              .fontWeight(AppTokens.Typography.display.weight)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .width(this.fabSize)
          .height(this.fabSize)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(this.fabSize / 2)
          .margin({ right: AppTokens.Spacing.lg, bottom: this.bottomBarHeight + AppTokens.Spacing.lg })
          .onClick(() => {})
        }
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    // statusBarHidden(true) has no direct ArkUI declarative equivalent.
    RootScreen()
  }
}
