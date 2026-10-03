// Design System Tokens
interface AppColors {
  primary: ResourceColor;
  secondary: ResourceColor;
  background: ResourceColor;
  surface: ResourceColor;
  outline: ResourceColor;
  onPrimary: ResourceColor;
  onBackground: ResourceColor;
  onSurface: ResourceColor;
  accent: ResourceColor;
}

interface AppTypography {
  display: (size?: number) => string;
  headline: string;
  title: string;
  body: string;
}

interface AppSpacing {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

class AppTokens {
  static Colors: AppColors = {
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

  static Typography: AppTypography = {
    display: (size: number = 24) => `bold ${size}vp sans-serif`,
    headline: `semibold 18vp sans-serif`,
    title: `medium 14vp sans-serif`,
    body: `regular 12vp sans-serif`
  };

  static Spacing: AppSpacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 40
  };
}

// Entry Point
@Entry
@Component
struct EntryPage {
  build() {
    Column() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}

// Main Content View
@Component
struct RootScreen {
  @State progress: number = 0.45;

  simulateCharge() {
    this.progress += 0.1;
    if (this.progress > 1.0) {
      this.progress = 0.0;
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

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

            Text(`${Math.round(this.progress * 100)}%`)
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
          Button('Simulate Charge')
            .onClick(() => {
              this.simulateCharge();
            })
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(24)
            .margin({ top: AppTokens.Spacing.lg })

          // Status Text
          Text(this.progress < 1.0 ? 'Charging...' : 'Fully Charged!')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.progress < 1.0 ? AppTokens.Colors.primary : AppTokens.Colors.secondary)
            .margin({ top: AppTokens.Spacing.md })

          // Spacer
          Blank()
        }
        .width('100%')
        .height('100%')
        .padding(AppTokens.Spacing.lg)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

// Components
@Component
struct CustomTopBar {
  build() {
    Row() {
      // Navigation Icon
      Text('⚡')
        .fontSize(24)
        .fontColor(AppTokens.Colors.primary)
        .margin({ left: 8 })

      // Title
      Text('Charging Progress')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      // Action Icon
      Button('⚙️')
        .onClick(() => {})
        .fontSize(24)
        .fontColor(AppTokens.Colors.accent)
        .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .backgroundColor(AppTokens.Colors.surface)
  }
}

@Component
struct BatteryIcon {
  progress: number = 0.0;

  build() {
    Stack({ alignContent: Alignment.Center }) {
      // Battery Body
      Column()
        .width(50)
        .height(90)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(8)

      // Battery Cap
      Column()
        .width(20)
        .height(10)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(3)
        .position({ x: '50%', y: 0 })
        .translate({ y: -5 })

      // Lightning Bolt
      Text('⚡')
        .fontSize(30)
        .fontColor(AppTokens.Colors.onPrimary)
    }
    .width(60)
    .height(100)
  }
}

@Component
struct CustomProgressBar {
  progress: number = 0.0;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.surface)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .borderRadius(6)

      // Indicator
      Column()
        .width(`${Math.min(Math.max(this.progress, 0), 1) * 100}%`)
        .height('100%')
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(6)
        .margin(1)
    }
    .width('100%')
    .height('100%')
    .clip(true)
    .borderRadius(6)
  }
}