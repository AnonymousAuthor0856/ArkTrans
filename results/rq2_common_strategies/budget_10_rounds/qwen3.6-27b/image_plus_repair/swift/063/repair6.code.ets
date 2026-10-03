import { window } from '@kit.ArkUI';
import { common, UIAbility } from '@kit.AbilityKit';

// MARK: - Design System Tokens
interface ColorTokens {
  primary: string;
  secondary: string;
  background: string;
  surface: string;
  outline: string;
  onPrimary: string;
  onBackground: string;
  onSurface: string;
  accent: string;
}

interface TypographyConfig {
  fontSize: number;
  fontWeight: FontWeight;
}

interface TypographyTokens {
  display: (size?: number) => TypographyConfig;
  headline: TypographyConfig;
  title: TypographyConfig;
  body: TypographyConfig;
}

interface SpacingTokens {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

class AppTokens {
  static Colors: ColorTokens = {
    primary: '#3B82F6',
    secondary: '#22C55E',
    background: '#F5F5F4',
    surface: '#FFFFFF',
    outline: '#D4D4D8',
    onPrimary: '#FFFFFF',
    onBackground: '#111827',
    onSurface: '#1F2937',
    accent: '#F59E0B'
  };

  static Typography: TypographyTokens = {
    display: (size: number = 24): TypographyConfig => ({ fontSize: size, fontWeight: FontWeight.Bold }),
    headline: { fontSize: 18, fontWeight: FontWeight.Medium },
    title: { fontSize: 14, fontWeight: FontWeight.Medium },
    body: { fontSize: 12, fontWeight: FontWeight.Normal }
  };

  static Spacing: SpacingTokens = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 40
  };
}

// MARK: - Custom Shapes
@Extend(Path)
function lightning() {
  .commands("M12 2L4.5 13H9.5L7.5 22L19.5 10H14.5L12 2Z")
}

// MARK: - Components
@Component
struct BatteryIcon {
  @Prop progress: number;

  build() {
    Column() {
      // Battery Top Cap
      Row()
        .width(20)
        .height(10)
        .borderRadius(3)
        .backgroundColor(AppTokens.Colors.primary)
        .margin({ bottom: -5 }) // Overlap slightly

      // Battery Body
      Column() {
        // Lightning Icon
        Path()
          .lightning()
          .fill(AppTokens.Colors.onPrimary)
          .width(25)
          .height(40)
      }
      .width(50)
      .height(90)
      .borderRadius(8)
      .backgroundColor(AppTokens.Colors.primary)
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct CustomProgressBar {
  @Prop progress: number;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Row()
        .width('100%')
        .height(12)
        .borderRadius(6)
        .backgroundColor(AppTokens.Colors.surface)
        .border({ width: 1, color: AppTokens.Colors.outline })

      // Indicator
      Row()
        .width(`${Math.min(Math.max(this.progress, 0), 1) * 100}%`)
        .height(10) // Slightly smaller to create padding effect
        .borderRadius(5)
        .backgroundColor(AppTokens.Colors.primary)
    }
    .width('100%')
    .clip(true)
  }
}

@Component
struct CustomTopBar {
  build() {
    Row() {
      // Navigation Icon (Electric Car)
      Image($r('app.media.ic_car')) // Placeholder for system icon
        .width(24)
        .height(24)
        .fillColor(AppTokens.Colors.primary)
        .margin({ left: 8 })

      Flex().layoutWeight(1)

      // Title
      Text("Charging Progress")
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)

      Flex().layoutWeight(1)

      // Action Icon (Settings)
      Button() {
        Image($r('app.media.ic_settings')) // Placeholder for system icon
          .width(24)
          .height(24)
          .fillColor(AppTokens.Colors.accent)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .padding({ top: 8, bottom: 8, left: 16, right: 16 })
    .backgroundColor(AppTokens.Colors.surface)
  }
}

// MARK: - Main Content View
@Entry
@Component
struct RootScreen {
  @State progress: number = 0.45;

  aboutToAppear() {
    // Hide status bar
    let context = getContext(this) as common.UIAbilityContext;
    window.getLastWindow(context).then((windowClass: window.Window) => {
      if (windowClass) {
        windowClass.setWindowSystemBarEnable([window.SystemBarType.STATUS_BAR], false);
      }
    });
  }

  build() {
    Column() {
      // Top Bar
      CustomTopBar()

      // Content
      Column({ space: AppTokens.Spacing.lg }) {
        // Battery and Percentage
        Column({ space: AppTokens.Spacing.md }) {
          BatteryIcon({ progress: this.progress })
            .width(60)
            .height(100)

          Text(`${Math.floor(this.progress * 100)}%`)
            .fontSize(36)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onBackground)
        }
        .margin({ top: AppTokens.Spacing.md })

        // Progress Bar
        CustomProgressBar({ progress: this.progress })
          .height(12)
          .width('70%')
          .margin({ top: AppTokens.Spacing.lg })

        // Simulate Button
        Button("Simulate Charge")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(24)
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .onClick(() => {
            animateTo({ duration: 300, curve: Curve.EaseInOut }, () => {
              this.progress += 0.1;
              if (this.progress > 1.0) {
                this.progress = 0.0;
              }
            });
          })
          .margin({ top: AppTokens.Spacing.lg })

        // Status Text
        Text(this.progress < 1.0 ? "Charging..." : "Fully Charged!")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.progress < 1.0 ? AppTokens.Colors.primary : AppTokens.Colors.secondary)
          .margin({ top: AppTokens.Spacing.md })

        Flex().layoutWeight(1)
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}