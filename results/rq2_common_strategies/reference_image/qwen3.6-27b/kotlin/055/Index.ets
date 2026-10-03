import { Window } from '@kit.ArkUI';
import { window } from '@kit.ArkGraphics';

// Define App Tokens for Colors, Typography, Shapes, and Spacing
const AppTokens = {
  Colors: {
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
    onSurface: '#1E293B'
  },
  Typography: {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    headline: { fontSize: 20, fontWeight: FontWeight.SemiBold },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  },
  Shapes: {
    small: 8,
    medium: 12,
    large: 16
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  }
};

@Entry
@Component
struct RootScreen {
  @State private showSystemBar: boolean = false;

  aboutToAppear() {
    // Hide system bars for immersive experience similar to Android implementation
    let windowClass: window.Window = null;
    try {
      windowClass = getContext(this).getWindowSync();
      windowClass.setWindowLayoutFullScreen(true);
      windowClass.setWindowSystemBarProperties({
        statusBarColor: '#00000000',
        navigationBarColor: '#00000000',
        statusBarContentColor: '#FFFFFFFF',
        navigationBarContentColor: '#FFFFFFFF'
      });
    } catch (e) {
      console.error('Failed to set window properties');
    }
  }

  build() {
    Stack() {
      Column() {
        // Top Bar
        Row() {
          Text("Workout Plan")
            .font-size(AppTokens.Typography.display.fontSize)
            .fontWeight(AppTokens.Typography.display.fontWeight)
            .fontColor(AppTokens.Colors.onBackground)
            .textAlign(TextAlign.Center)
            .width('100%')
        }
        .height(60)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(Color.White)

        // Main Content Area with Gradient Background
        Column() {
          Text("Sign In to Continue")
            .font-size(AppTokens.Typography.headline.fontSize)
            .fontWeight(AppTokens.Typography.headline.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.lg })

          // Workout Preview Box
          Row() {
            Text("Workout Preview")
              .font-size(AppTokens.Typography.body.fontSize)
              .fontWeight(AppTokens.Typography.body.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
          }
          .width('100%')
          .height(200)
          .borderRadius(AppTokens.Shapes.large)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .backgroundColor(AppTokens.Colors.surface)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .margin({ top: AppTokens.Spacing.lg })

          // Authenticate Button
          Button("Authenticate")
            .type(ButtonType.Capsule)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .font-size(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
            .width('80%')
            .height(52)
            .margin({ top: AppTokens.Spacing.lg })
            .onClick(() => {
              // Handle authentication click
            })
        }
        .layoutWeight(1)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            [AppTokens.Colors.secondary, 0.1],
            [AppTokens.Colors.primary, 0.15]
          ]
        })
        .padding(AppTokens.Spacing.lg)

        // Bottom Navigation Bar
        Row() {
          Text("Home")
            .font-size(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
            .fontColor(AppTokens.Colors.primary)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Text("Plan")
            .font-size(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Text("Profile")
            .font-size(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
        }
        .height(60)
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 8, color: '#1A000000', offsetY: -2 })
      }
      .width('100%')
      .height('100%')

      // Floating Action Button
      Button("+")
        .type(ButtonType.Circle)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .width(56)
        .height(56)
        .position({ x: 'calc(100% - 72px)', y: 'calc(100% - 120px)' })
        .shadow({ radius: 12, color: '#33000000', offsetY: 4 })
        .onClick(() => {
          // Handle FAB click
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}