// AppTokens - Design tokens using classes and namespaces

class ColorsTokens {
  primary: string = '#2563EB';
  secondary: string = '#38BDF8';
  tertiary: string = '#60A5FA';
  background: string = '#E6F0FF';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#E2E8F0';
  outline: string = '#CBD5E1';
  success: string = '#22C55E';
  warning: string = '#F59E0B';
  error: string = '#EF4444';
  onPrimary: string = '#FFFFFF';
  onSecondary: string = '#0F172A';
  onTertiary: string = '#FFFFFF';
  onBackground: string = '#0F172A';
  onSurface: string = '#1E293B';
}

class TypographyTokens {
  displaySize: number = 28;
  headlineSize: number = 20;
  titleSize: number = 16;
  bodySize: number = 14;
  labelSize: number = 12;
}

class ShapesTokens {
  small: number = 8;
  medium: number = 12;
  large: number = 16;
}

class SpacingTokens {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
  xxl: number = 36;
}

class AppTokensClass {
  Colors: ColorsTokens = new ColorsTokens();
  Typography: TypographyTokens = new TypographyTokens();
  Shapes: ShapesTokens = new ShapesTokens();
  Spacing: SpacingTokens = new SpacingTokens();
}

const AppTokens: AppTokensClass = new AppTokensClass();

@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      // Top Bar
      Row() {
        // Navigation Icon (Left)
        Button() {
          Stack() {
            Circle()
              .fill(AppTokens.Colors.primary)
              .width(24)
              .height(24)
            Text('<')
              .fontColor(AppTokens.Colors.onPrimary)
              .fontSize(AppTokens.Typography.labelSize)
              .fontWeight(FontWeight.Medium)
          }
        }
        .backgroundColor(Color.Transparent)
        .width(40)
        .height(40)

        Blank()

        // Title
        Text('Sleep Cycle')
          .fontSize(AppTokens.Typography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)

        Blank()

        // Actions Icon (Right)
        Button() {
          Stack() {
            Circle()
              .fill(AppTokens.Colors.secondary)
              .width(24)
              .height(24)
            Text('?')
              .fontColor(AppTokens.Colors.onSecondary)
              .fontSize(AppTokens.Typography.labelSize)
              .fontWeight(FontWeight.Medium)
          }
        }
        .backgroundColor(Color.Transparent)
        .width(40)
        .height(40)
      }
      .width('100%')
      .height(56)
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg
      })
      .backgroundColor(AppTokens.Colors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Main Content Area
      Column({ space: AppTokens.Spacing.xl }) {
        Blank()

        // Central Emoji Circle
        Stack() {
          Circle()
            .fill(AppTokens.Colors.surface)
            .width(160)
            .height(160)
            .border({
              width: 2,
              color: AppTokens.Colors.outline,
              style: BorderStyle.Solid
            })
          Text('😴')
            .fontSize(48)
        }
        .width(160)
        .height(160)

        // Welcome Back Text
        Text('Welcome Back')
          .fontSize(AppTokens.Typography.headlineSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)

        // Description Text
        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(AppTokens.Typography.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')

        // Sign In Button
        Button() {
          Text('Sign In')
            .fontSize(AppTokens.Typography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .width('80%')
        .height(52)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.large)

        Blank()
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg
      })
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.background, 0.0],
          [AppTokens.Colors.background, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .alignItems(HorizontalAlign.Center)
  }
}