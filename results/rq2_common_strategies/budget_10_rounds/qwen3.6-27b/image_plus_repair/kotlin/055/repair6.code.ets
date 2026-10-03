import { window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';

interface ColorToken {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyStyle {
  fontSize: number;
  fontWeight: FontWeight;
}

interface TypographyToken {
  display: TypographyStyle;
  headline: TypographyStyle;
  title: TypographyStyle;
  body: TypographyStyle;
  label: TypographyStyle;
}

interface ShapeToken {
  small: number;
  medium: number;
  large: number;
}

interface SpacingToken {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface AppTokensConfig {
  Colors: ColorToken;
  Typography: TypographyToken;
  Shapes: ShapeToken;
  Spacing: SpacingToken;
}

const AppTokens: AppTokensConfig = {
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
    headline: { fontSize: 20, fontWeight: FontWeight.Medium },
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
    let context = getContext(this) as common.UIAbilityContext;
    let windowClass = (context as unknown as { getWindowSync: () => window.Window }).getWindowSync();
    if (windowClass) {
      try {
        windowClass.setWindowLayoutFullScreen(true);
        windowClass.setWindowSystemBarEnable([], []);
      } catch (e) {
        console.error('Failed to set full screen:', e);
      }
    }
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top Bar
        Row() {
          Text("Workout Plan")
            .fontColor(AppTokens.Colors.onBackground)
            .fontSize(AppTokens.Typography.display.fontSize)
            .fontWeight(AppTokens.Typography.display.fontWeight)
            .textAlign(TextAlign.Center)
            .width('100%')
        }
        .height(60)
        .backgroundColor(Color.White)

        // Main Content Area with Gradient Background
        Column() {
          Text("Sign In to Continue")
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.Typography.headline.fontSize)
            .fontWeight(AppTokens.Typography.headline.fontWeight)
            .margin({ top: AppTokens.Spacing.lg })

          // Workout Preview Box
          Row() {
            Text("Workout Preview")
              .fontColor(AppTokens.Colors.onSurface)
              .fontSize(AppTokens.Typography.body.fontSize)
          }
          .width('100%')
          .height(200)
          .backgroundColor(AppTokens.Colors.surface)
          .borderWidth(1)
          .borderColor(AppTokens.Colors.outline)
          .borderRadius(AppTokens.Shapes.large)
          .margin({ top: AppTokens.Spacing.lg })

          // Authenticate Button
          Button("Authenticate", { type: ButtonType.Capsule })
            .width('80%')
            .height(52)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
            .margin({ top: AppTokens.Spacing.lg })
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
        .alignItems(HorizontalAlign.Center)
      }

      // Floating Action Button
      Button("+", { type: ButtonType.Circle })
        .width(56)
        .height(56)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .position({ x: 'auto', y: 'auto' })
        .margin({ right: AppTokens.Spacing.lg, bottom: 80 })
        .shadow({ radius: 8, color: '#33000000', offsetY: 4 })

      // Bottom Navigation Bar
      Row() {
        Text("Home")
          .fontColor(AppTokens.Colors.primary)
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text("Plan")
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text("Profile")
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .height(60)
      .backgroundColor(AppTokens.Colors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}