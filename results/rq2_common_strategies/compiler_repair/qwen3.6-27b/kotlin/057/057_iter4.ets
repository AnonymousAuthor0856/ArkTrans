import { window } from '@kit.ArkUI'
import { UIAbility, Want } from '@kit.AbilityKit'
import { AbilityConstant } from '@kit.AbilityKit'

// Token Definitions matching the Kotlin source
interface AppColors {
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

interface AppSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface AppShapes {
  small: number;
  medium: number;
  large: number;
}

class AppTokensClass {
  Colors: AppColors = {
    primary: '#2563EB',
    secondary: '#38BDF8',
    tertiary: '#60A5FA',
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
  };
  Spacing: AppSpacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  };
  Shapes: AppShapes = {
    small: 8,
    medium: 12,
    large: 16
  };
}

const AppTokens = new AppTokensClass();

@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      // Top Bar Area
      Row() {
        // Back Button
        Button() {
          Text('<')
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
        }
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(AppTokens.Colors.primary)
        .onClick(() => {
          // Handle back click
        })

        Flex({ justifyContent: FlexAlign.End }) {
          Blank().layoutWeight(1)
        }

        // Title
        Text('Sleep Cycle')
          .fontColor(AppTokens.Colors.onBackground)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)

        Flex({ justifyContent: FlexAlign.Start }) {
          Blank().layoutWeight(1)
        }

        // Help Button
        Button() {
          Text('?')
            .fontColor(AppTokens.Colors.onSecondary)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
        }
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(AppTokens.Colors.secondary)
        .onClick(() => {
          // Handle help click
        })
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })

      // Main Content Area
      Column() {
        // Avatar Box
        Row() {
          Text('😴')
            .fontSize(48)
        }
        .width(160)
        .height(160)
        .borderRadius(80)
        .backgroundColor(AppTokens.Colors.surface)
        .border({ width: 2, color: AppTokens.Colors.outline })
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        Column() {
          Text('Welcome Back')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .margin({ top: AppTokens.Spacing.xl })

          Text('Track your sleep patterns and improve rest quality.')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .margin({ top: AppTokens.Spacing.sm })
        }
        .alignItems(HorizontalAlign.Center)

        // Sign In Button
        Button('Sign In')
          .width('80%')
          .height(52)
          .borderRadius(AppTokens.Shapes.large)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .margin({ top: AppTokens.Spacing.xl })
          .onClick(() => {
            // Handle sign in
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Center)
      // Simulating the vertical gradient background with a solid color close to the start of the gradient for simplicity in ArkTS without complex brush definitions, 
      // or using a linear gradient if supported by specific environment. Here we use a subtle tinted background.
      .linearGradient({
        direction: GradientDirection.Top,
        colors: [['#38BDF8', 0.15], ['#2563EB', 0.1]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// Entry Ability
export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    console.info('[ArkTS] EntryAbility onCreate');
  }

  onDestroy(): void {
    console.info('[ArkTS] EntryAbility onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    console.info('[ArkTS] EntryAbility onWindowStageCreate');

    windowStage.loadContent('pages/RootScreen', (err: BusinessError) => {
      if (err.code) {
        console.error('[ArkTS] Failed to load content. Cause:' + JSON.stringify(err));
        return;
      }
      console.info('[ArkTS] Succeeded in loading content.');
    });
  }

  onWindowStageDestroy(): void {
    console.info('[ArkTS] EntryAbility onWindowStageDestroy');
  }

  onForeground(): void {
    console.info('[ArkTS] EntryAbility onForeground');
  }

  onBackground(): void {
    console.info('[ArkTS] EntryAbility onBackground');
  }
}