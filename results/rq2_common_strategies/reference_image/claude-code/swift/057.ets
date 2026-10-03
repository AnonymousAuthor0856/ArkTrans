// AppTokens
class AppTokens {
  static class Colors {
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

  static class TypographyTokens {
    static readonly display: { size: number; weight: FontWeight } = { size: 28, weight: FontWeight.Bold };
    static readonly headline: { size: number; weight: FontWeight } = { size: 20, weight: FontWeight.SemiBold };
    static readonly title: { size: number; weight: FontWeight } = { size: 16, weight: FontWeight.Medium };
    static readonly body: { size: number; weight: FontWeight } = { size: 14, weight: FontWeight.Regular };
    static readonly label: { size: number; weight: FontWeight } = { size: 12, weight: FontWeight.Medium };
  }

  static class Shapes {
    static readonly small: number = 8;
    static readonly medium: number = 12;
    static readonly large: number = 16;
  }

  static class Spacing {
    static readonly xs: number = 4;
    static readonly sm: number = 8;
    static readonly md: number = 12;
    static readonly lg: number = 16;
    static readonly xl: number = 24;
    static readonly xxl: number = 36;
  }
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
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .type(ButtonType.Circle)
        .backgroundColor(AppTokens.Colors.primary)
        .width(48)
        .height(48)
        .padding({ left: AppTokens.Spacing.lg })

        Blank()

        // Title
        Text('Sleep Cycle')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onBackground)

        Blank()

        // Actions Icon (Right)
        Button() {
          Text('?')
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontColor(AppTokens.Colors.onSecondary)
        }
        .type(ButtonType.Circle)
        .backgroundColor(AppTokens.Colors.secondary)
        .width(48)
        .height(48)
        .padding({ right: AppTokens.Spacing.lg })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)

      // Main Content Area
      Column() {
        Blank()

        // Central Emoji Circle
        Stack() {
          Circle()
            .fill(AppTokens.Colors.surface)
            .stroke(AppTokens.Colors.outline, 2)
            .width(160)
            .height(160)
          Text('😴')
            .fontSize(48)
        }

        // Welcome Back Text
        Text('Welcome Back')
          .fontSize(AppTokens.TypographyTokens.headline.size)
          .fontWeight(AppTokens.TypographyTokens.headline.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.xl })

        // Description Text
        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
          .margin({ top: AppTokens.Spacing.xl })

        // Sign In Button
        Button('Sign In')
          .type(ButtonType.Normal)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
          .width('80%')
          .height(52)
          .margin({ top: AppTokens.Spacing.xl })

        Blank()
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
