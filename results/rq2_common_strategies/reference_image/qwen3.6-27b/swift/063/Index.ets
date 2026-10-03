import { window } from '@kit.ArkUI';

// MARK: - Entry Point
@Entry
@Component
struct ChargingProgressApp {
  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Design System Tokens
class AppTokens {
  static Colors = {
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

  static Typography = {
    display: (size: number = 24) => ({ fontSize: size, fontWeight: FontWeight.Bold }),
    headline: { fontSize: 18, fontWeight: FontWeight.SemiBold },
    title: { fontSize: 14, fontWeight: FontWeight.Medium },
    body: { fontSize: 12, fontWeight: FontWeight.Regular }
  };

  static Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 40
  };
}

// MARK: - Main Content View
@Component
struct ContentView {
  build() {
    RootScreen()
  }
}

@Component
struct RootScreen {
  @State progress: number = 0.45;

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column() {
        // Top Bar
        CustomTopBar()

        // Content
        Column({ spacing: AppTokens.Spacing.lg }) {
          // Battery and Percentage
          Column({ spacing: AppTokens.Spacing.md }) {
            BatteryIcon({ progress: this.progress })
              .width(60)
              .height(100)

            Text(`${Math.floor(this.progress * 100)}%`)
              .fontSize(36)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokens.Colors.onBackground)
          }
          .padding({ top: AppTokens.Spacing.md })

          // Progress Bar
          CustomProgressBar({ progress: this.progress })
            .height(12)
            .width('70%')
            .padding({ top: AppTokens.Spacing.lg })

          // Simulate Button
          Button("Simulate Charge") {
            animateTo({ duration: 300, curve: Curve.EaseInOut }) {
              this.progress += 0.1;
              if (this.progress > 1.0) {
                this.progress = 0.0;
              }
            }
          }
          .font(AppTokens.Typography.title)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(24)
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .margin({ top: AppTokens.Spacing.lg })

          // Status Text
          Text(this.progress < 1.0 ? "Charging..." : "Fully Charged!")
            .font(AppTokens.Typography.headline)
            .fontColor(this.progress < 1.0 ? AppTokens.Colors.primary : AppTokens.Colors.secondary)
            .margin({ top: AppTokens.Spacing.md })

          Blank()
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
      }
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Components

@Component
struct CustomTopBar {
  build() {
    Row() {
      // Navigation Icon (Electric Car)
      Image($r('app.media.ic_car')) // Placeholder for car icon
        .width(24)
        .height(24)
        .fillColor(AppTokens.Colors.primary)
        .margin({ left: 8 })

      Flex({ justifyContent: FlexAlign.Center }) {
        Text("Charging Progress")
          .font(AppTokens.Typography.display())
          .fontColor(AppTokens.Colors.onBackground)
      }

      // Action Icon (Settings)
      Button() {
        Image($r('app.media.ic_settings')) // Placeholder for settings icon
          .width(24)
          .height(24)
          .fillColor(AppTokens.Colors.accent)
      }
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .backgroundColor(AppTokens.Colors.surface)
  }
}

@Component
struct BatteryIcon {
  progress: number;

  build() {
    Stack() {
      // Battery Body
      Rectangle()
        .width(50)
        .height(90)
        .borderRadius(8)
        .fill(AppTokens.Colors.primary)

      // Battery Terminal
      Rectangle()
        .width(20)
        .height(10)
        .borderRadius(3)
        .fill(AppTokens.Colors.primary)
        .position({ x: '50%', y: '-50%' })
        .translate({ x: '-50%', y: '-50%' })

      // Lightning Bolt
      Path() {
        moveTo(12.5, 5)
        lineTo(4.5, 20)
        lineTo(14.5, 20)
        lineTo(7.5, 35)
        lineTo(20.5, 20)
        lineTo(10.5, 20)
        close()
      }
      .width(25)
      .height(40)
      .fill(AppTokens.Colors.onPrimary)
    }
  }
}

@Component
struct CustomProgressBar {
  progress: number;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Capsule()
        .width('100%')
        .height('100%')
        .fill(AppTokens.Colors.surface)
        .border({ width: 1, color: AppTokens.Colors.outline })

      // Indicator
      Capsule()
        .width(`${Math.min(Math.max(this.progress, 0), 1) * 100}%`)
        .height('100%')
        .fill(AppTokens.Colors.primary)
        .margin({ left: 1, right: 1, top: 1, bottom: 1 })
    }
    .clip(true)
  }
}