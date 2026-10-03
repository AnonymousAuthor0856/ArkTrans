// AppTokens.ts
export class AppTokens {
  // Colors
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
    onSurface: '#FF1E293B'
  };

  // Typography
  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  // Shapes
  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16
  };

  // Spacing
  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  };

  // Elevation Mapping
  static readonly Elevation = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.14 },
    level3: { elevation: 8, radius: 12, dy: 6, opacity: 0.16 }
  };
}

// Helper to convert opacity to hex alpha for ArkUI colors
function withOpacity(hexColor: string, opacity: number): string {
  const alpha = Math.round(opacity * 255).toString(16).padStart(2, '0').toUpperCase();
  return `#${alpha}${hexColor.substring(3)}`;
}

// RootScreen.ets
@Entry
@Component
struct RootScreen {
  private topBarHeight: number = 64;
  private bottomBarHeight: number = 80;
  private fabSize: number = 56;

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // 1. Main Content Layer
      Column({ space: AppTokens.Spacing.lg }) {
        // Top spacer for custom app bar
        Blank().height(this.topBarHeight);

        Text('Sign In to Continue')
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .fontColor(AppTokens.Colors.onSurface);

        // Workout Preview Box
        Stack() {
          Text('Workout Preview')
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface);
        }
        .width('100%')
        .height(200)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.large });

        // Authenticate Button
        Button('Authenticate') {
          Text('Authenticate')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onPrimary);
        }
        .type(ButtonType.Capsule)
        .width('80%')
        .height(52)
        .backgroundColor(AppTokens.Colors.primary);

        // Push content to top
        Blank().layoutWeight(1);
      }
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 180,
        colors: [
          [withOpacity(AppTokens.Colors.secondary, 0.1), 0.0],
          [withOpacity(AppTokens.Colors.primary, 0.15), 1.0]
        ]
      })
      .backgroundColor(AppTokens.Colors.background)
      .padding({ bottom: this.bottomBarHeight })
      .expandSafeArea();

      // 2. Custom Top Bar Layer
      Column() {
        Text('Workout Plan')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onBackground);
      }
      .width('100%')
      .height(this.topBarHeight)
      .backgroundColor(AppTokens.Colors.surface)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .position({ x: 0, y: 0 })
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP]);

      // 3. Custom Bottom Bar Layer
      Row() {
        Text('Home')
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.primary)
          .layoutWeight(1)
          .textAlign(TextAlign.Center);

        Text('Plan')
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center);

        Text('Profile')
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center);
      }
      .width('100%')
      .height(this.bottomBarHeight)
      .backgroundColor(AppTokens.Colors.surface)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .shadow({
        radius: AppTokens.Elevation.level2.radius,
        color: withOpacity(AppTokens.Colors.onBackground, AppTokens.Elevation.level2.opacity),
        offsetY: AppTokens.Elevation.level2.dy
      })
      .position({ x: 0, y: '100%' })
      .markAnchor({ x: 0, y: '100%' })
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM]);

      // 4. Floating Action Button (FAB) Layer
      Button('+') {
        Text('+')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onPrimary);
      }
      .width(this.fabSize)
      .height(this.fabSize)
      .type(ButtonType.Circle)
      .backgroundColor(AppTokens.Colors.primary)
      .position({
        x: `100% - ${AppTokens.Spacing.lg + this.fabSize}`,
        y: `100% - ${this.bottomBarHeight + AppTokens.Spacing.lg + this.fabSize}`
      });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}