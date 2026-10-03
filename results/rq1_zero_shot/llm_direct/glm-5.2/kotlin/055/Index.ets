// 082_WorkoutPlan_en.ets
// UI Type: Health Auth
// Style Theme: Modern Blue
// Language: en
// Baseline Size: 720x1280

// --- Design Tokens ---
class AppTokens {
  static readonly Colors = {
    primary: '#FF2563EB',
    secondary: '#FF38BDF8',
    tertiary: '#FF3B82F6',
    background: '#FFF8FAFC',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE2E8F0',
    outline: '#FFCBD5E1',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF0F172A',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF0F172A',
    onSurface: '#FF1E293B',
  };
  static readonly TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  };
  static readonly Shapes = {
    small: { radius: 8 },
    medium: { radius: 12 },
    large: { radius: 16 },
  };
  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36,
  };
}

// --- Helper Functions ---
function rgba(hex: string, alpha: number): string {
  const r = parseInt(hex.slice(3, 5), 16);
  const g = parseInt(hex.slice(5, 7), 16);
  const b = parseInt(hex.slice(7, 9), 16);
  return `rgba(${r}, ${g}, ${b}, ${alpha})`;
}

// --- UI Structure ---
@Entry
@Component
struct RootScreen {
  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background Gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [
            [rgba(AppTokens.Colors.secondary, 0.1), 0.0],
            [rgba(AppTokens.Colors.primary, 0.15), 1.0]
          ]
        });

      // Main Content Column
      Column() {
        // Top App Bar
        Text('Workout Plan')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontColor(AppTokens.Colors.onBackground)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg });

        // Content Area
        Column() {
          Text('Sign In to Continue')
            .fontSize(AppTokens.TypographyTokens.headline.size)
            .fontColor(AppTokens.Colors.onSurface)
            .fontWeight(AppTokens.TypographyTokens.headline.weight)
            .margin({ bottom: AppTokens.Spacing.lg });

          // Workout Preview Box
          Column() {
            Text('Workout Preview')
              .fontSize(AppTokens.TypographyTokens.body.size)
              .fontColor(AppTokens.Colors.onSurface)
              .fontWeight(AppTokens.TypographyTokens.body.weight);
          }
          .width('100%')
          .height(200)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large.radius)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .margin({ bottom: AppTokens.Spacing.lg });

          // Authenticate Button
          Button('Authenticate')
            .width('80%')
            .height(52)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .borderRadius(AppTokens.Shapes.large.radius)
            .margin({ bottom: AppTokens.Spacing.lg });
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Center);

        // Spacer to push bottom bar down
        Blank().layoutWeight(1);

        // Bottom App Bar
        Row() {
          Text('Home')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontColor(AppTokens.Colors.primary)
            .fontWeight(AppTokens.TypographyTokens.title.weight);
          Text('Plan')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontColor(AppTokens.Colors.onSurface)
            .fontWeight(AppTokens.TypographyTokens.title.weight);
          Text('Profile')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontColor(AppTokens.Colors.onSurface)
            .fontWeight(AppTokens.TypographyTokens.title.weight);
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .backgroundColor(AppTokens.Colors.surface)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center);
      }
      .width('100%')
      .height('100%');

      // Floating Action Button
      Button('+')
        .width(56)
        .height(56)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .borderRadius(28)
        .position({ x: '85%', y: '85%' });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}