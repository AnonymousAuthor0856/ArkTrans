// SleepCyclePage.ets
// ArkTS (HarmonyOS) translation of the SwiftUI SleepCycleApp.

// MARK: - AppTokens
// Atomic design tokens mirroring the Kotlin/SwiftUI AppTokens object.

class AppTokensColors {
  static readonly primary: string = '#2563EB';
  static readonly secondary: string = '#38BDF8';
  static readonly tertiary: string = '#60A5FA';
  static readonly background: string = '#E6F0FF';      // deeper blue background
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
}

class AppTokensTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;

  static readonly headlineSize: number = 20;
  static readonly headlineWeight: FontWeight = FontWeight.Medium;

  static readonly titleSize: number = 16;
  static readonly titleWeight: FontWeight = FontWeight.Medium;

  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;

  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppTokensShapes {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 16;
}

class AppTokensSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

// MARK: - RootScreen

@Entry
@Component
struct SleepCyclePage {
  build() {
    Column() {
      this.TopBar()

      // Main content area (Scaffold content Column)
      this.MainContent()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokensColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  // CenterAlignedTopAppBar equivalent
  @Builder
  TopBar() {
    Stack({ alignContent: Alignment.Center }) {
      Row() {
        // Navigation icon (left)
        this.IconCircle('<', AppTokensColors.primary, AppTokensColors.onPrimary)

        Blank()

        // Actions icon (right)
        this.IconCircle('?', AppTokensColors.secondary, AppTokensColors.onSecondary)
      }
      .width('100%')
      .padding({ left: AppTokensSpacing.lg, right: AppTokensSpacing.lg })

      // Title
      Text('Sleep Cycle')
        .fontSize(AppTokensTypography.displaySize)
        .fontWeight(AppTokensTypography.displayWeight)
        .fontColor(AppTokensColors.onBackground)
    }
    .width('100%')
    .height(56)
    .backgroundColor(AppTokensColors.surface)
  }

  @Builder
  IconCircle(label: string, background: string, foreground: string) {
    Text(label)
      .width(24)
      .height(24)
      .borderRadius(12)
      .backgroundColor(background)
      .fontColor(foreground)
      .fontSize(AppTokensTypography.labelSize)
      .fontWeight(AppTokensTypography.labelWeight)
      .textAlign(TextAlign.Center)
  }

  @Builder
  MainContent() {
    Column({ space: AppTokensSpacing.xl }) {
      Blank()

      // Central emoji box
      Stack() {
        Circle({ width: 160, height: 160 })
          .fill(AppTokensColors.surface)
          .stroke(AppTokensColors.outline)
          .strokeWidth(2)

        Text('😴')
          .fontSize(48)
      }
      .width(160)
      .height(160)

      // Welcome Back text
      Text('Welcome Back')
        .fontSize(AppTokensTypography.headlineSize)
        .fontWeight(AppTokensTypography.headlineWeight)
        .fontColor(AppTokensColors.onSurface)

      // Description text
      Text('Track your sleep patterns and improve rest quality.')
        .fontSize(AppTokensTypography.bodySize)
        .fontWeight(AppTokensTypography.bodyWeight)
        .fontColor(AppTokensColors.onSurface)
        .textAlign(TextAlign.Center)

      // Sign In button (fillMaxWidth(0.8f) inside the padded column)
      Button('Sign In', { type: ButtonType.Normal, stateEffect: true })
        .width('80%')
        .height(52)
        .backgroundColor(AppTokensColors.primary)
        .fontColor(AppTokensColors.onPrimary)
        .fontSize(AppTokensTypography.titleSize)
        .fontWeight(AppTokensTypography.titleWeight)
        .borderRadius(AppTokensShapes.large)

      Blank()
    }
    .width('100%')
    .layoutWeight(1)
    .padding({ left: AppTokensSpacing.lg, right: AppTokensSpacing.lg })
    .linearGradient({
      angle: 180,
      colors: [
        [AppTokensColors.background, 0.0],
        [AppTokensColors.background, 1.0]
      ]
    })
  }
}