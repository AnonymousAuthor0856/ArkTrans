// AppTokens.Colors
class AppColors {
  static readonly primary: string = '#2563EB';
  static readonly secondary: string = '#38BDF8';
  static readonly tertiary: string = '#60A5FA';
  static readonly background: string = '#E6F0FF';
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

// AppTokens.TypographyTokens
class TypographyStyle {
  size: number = 0;
  weight: number = 0;

  constructor(size: number, weight: number) {
    this.size = size;
    this.weight = weight;
  }
}

class AppTypographyTokens {
  static readonly display: TypographyStyle = new TypographyStyle(28, 700);
  static readonly headline: TypographyStyle = new TypographyStyle(20, 600);
  static readonly title: TypographyStyle = new TypographyStyle(16, 500);
  static readonly body: TypographyStyle = new TypographyStyle(14, 400);
  static readonly label: TypographyStyle = new TypographyStyle(12, 500);
}

// AppTokens.Shapes
class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 16;
}

// AppTokens.Spacing
class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

// RootScreen
@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      // Top Bar
      Row() {
        // Navigation Icon (Left)
        Button() {
          Text('<')
            .fontSize(AppTypographyTokens.label.size)
            .fontColor(AppColors.onPrimary)
        }
        .type(ButtonType.Circle)
        .backgroundColor(AppColors.primary)
        .width(48)
        .height(48)
        .padding({ left: AppSpacing.lg })

        Blank()

        // Title
        Text('Sleep Cycle')
          .fontSize(AppTypographyTokens.display.size)
          .fontWeight(AppTypographyTokens.display.weight)
          .fontColor(AppColors.onBackground)

        Blank()

        // Actions Icon (Right)
        Button() {
          Text('?')
            .fontSize(AppTypographyTokens.label.size)
            .fontColor(AppColors.onSecondary)
        }
        .type(ButtonType.Circle)
        .backgroundColor(AppColors.secondary)
        .width(48)
        .height(48)
        .padding({ right: AppSpacing.lg })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.surface)

      // Main Content Area
      Column() {
        Blank()

        // Central Emoji Circle
        Stack() {
          Circle()
            .fill(AppColors.surface)
            .stroke({ color: AppColors.outline, width: 2 })
            .width(160)
            .height(160)
          Text('😴')
            .fontSize(48)
        }

        // Welcome Back Text
        Text('Welcome Back')
          .fontSize(AppTypographyTokens.headline.size)
          .fontWeight(AppTypographyTokens.headline.weight)
          .fontColor(AppColors.onSurface)
          .margin({ top: AppSpacing.xl })

        // Description Text
        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(AppTypographyTokens.body.size)
          .fontWeight(AppTypographyTokens.body.weight)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .margin({ top: AppSpacing.xl })

        // Sign In Button
        Button('Sign In')
          .type(ButtonType.Normal)
          .fontSize(AppTypographyTokens.title.size)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.large)
          .width('80%')
          .height(52)
          .margin({ top: AppSpacing.xl })

        Blank()
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
