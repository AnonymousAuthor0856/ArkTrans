// MARK: - AppTokens
// Design tokens ported from SwiftUI: colors, typography, shapes, spacing, and elevation.

class AppTokens {
  static Colors = class {
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
  };

  static TypographyTokens = class {
    static readonly displaySize: number = 28;
    static readonly displayWeight: FontWeight = FontWeight.Bold;
    static readonly headlineSize: number = 20;
    static readonly headlineWeight: FontWeight = FontWeight.SemiBold;
    static readonly titleSize: number = 16;
    static readonly titleWeight: FontWeight = FontWeight.Medium;
    static readonly bodySize: number = 14;
    static readonly bodyWeight: FontWeight = FontWeight.Regular;
    static readonly labelSize: number = 12;
    static readonly labelWeight: FontWeight = FontWeight.Medium;
  };

  static Shapes = class {
    static readonly small: Length = 8;
    static readonly medium: Length = 12;
    static readonly large: Length = 16;
  };

  static Spacing = class {
    static readonly xs: Length = 4;
    static readonly sm: Length = 8;
    static readonly md: Length = 12;
    static readonly lg: Length = 16;
    static readonly xl: Length = 24;
    static readonly xxl: Length = 36;
  };

  static ElevationMapping = class {
    static readonly level1Radius: number = 4;
    static readonly level1Y: number = 2;
    static readonly level2Radius: number = 8;
    static readonly level2Y: number = 4;
    static readonly level3Radius: number = 12;
    static readonly level3Y: number = 6;
  };
}

// MARK: - RootScreen Component
// Corresponds to Kotlin RootScreen Composable and SwiftUI RootScreen View.

@Component
struct RootScreen {
  private readonly topBarHeight: Length = 64;
  private readonly bottomBarHeight: Length = 80;
  private readonly fabSize: Length = 56;

  build() {
    Stack() {
      // 1. Main content layer
      Column({ space: AppTokens.Spacing.lg }) {
        Blank()
          .height(this.topBarHeight)

        Text('Sign In to Continue')
          .fontSize(AppTokens.TypographyTokens.headlineSize)
          .fontWeight(AppTokens.TypographyTokens.headlineWeight)
          .fontColor(AppTokens.Colors.onSurface)

        // Workout Preview Box
        Stack() {
          Text('Workout Preview')
            .fontSize(AppTokens.TypographyTokens.bodySize)
            .fontWeight(AppTokens.TypographyTokens.bodyWeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(200)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.large })

        // Authenticate Button
        Button('Authenticate')
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('80%')
          .height(52)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
          .onClick(() => {})

        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .background(this.buildBackgroundGradient())
      .padding({ bottom: this.bottomBarHeight })

      // 2. Custom top bar layer
      Column() {
        Text('Workout Plan')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(AppTokens.TypographyTokens.displayWeight)
          .fontColor(AppTokens.Colors.onBackground)
      }
      .width('100%')
      .height(this.topBarHeight)
      .backgroundColor(AppTokens.Colors.surface)
      .alignContent(Alignment.Center)
      .position({ x: 0, y: 0 })

      // 3. Custom bottom bar layer
      Column() {
        Row() {
          Text('Home')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(AppTokens.Colors.primary)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Text('Plan')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Text('Profile')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(this.bottomBarHeight)
        .backgroundColor(AppTokens.Colors.surface)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .shadow({
          radius: AppTokens.ElevationMapping.level2Radius,
          color: AppTokens.Colors.onBackground + '24',
          offsetY: AppTokens.ElevationMapping.level2Y
        })
      }
      .width('100%')
      .position({ x: 0, y: 0 })
      .alignContent(Alignment.Bottom)

      // 4. Floating Action Button layer
      Button('+')
        .fontSize(AppTokens.TypographyTokens.displaySize)
        .fontColor(AppTokens.Colors.onPrimary)
        .width(this.fabSize)
        .height(this.fabSize)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(this.fabSize as number / 2)
        .position({
          x: 0,
          y: 0
        })
        .margin({
          right: AppTokens.Spacing.lg,
          bottom: (this.bottomBarHeight as number) + (AppTokens.Spacing.lg as number)
        })
        .onClick(() => {})
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  buildBackgroundGradient() {
    Stack() {
      LinearGradient({
        angle: 180,
        colors: [
          AppTokens.Colors.secondary + '1A',
          AppTokens.Colors.primary + '26'
        ],
        direction: GradientDirection.Bottom
      })
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - App Entry Point

@Entry
@Component
struct Index {
  build() {
    RootScreen()
      .width('100%')
      .height('100%')
  }
}
