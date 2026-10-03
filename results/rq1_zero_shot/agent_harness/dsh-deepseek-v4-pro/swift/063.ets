// MARK: - Design System Tokens
const AppTokens = {
  Colors: {
    primary: '#3B82F6',
    secondary: '#22C55E',
    background: '#F5F5F4',
    surface: '#FFFFFF',
    outline: '#D4D4D8',
    onPrimary: '#FFFFFF',
    onBackground: '#111827',
    onSurface: '#1F2937',
    accent: '#F59E0B'
  },
  Typography: {
    display: { size: 24, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Semibold },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Regular }
  },
  Spacing: {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 40
  }
};

// MARK: - Custom Top Bar
@Component
struct CustomTopBar {
  build() {
    Row() {
      Text('⚡')
        .fontSize(24)
        .fontColor(AppTokens.Colors.primary)
        .padding({ left: 8 })

      Blank()

      Text('Charging Progress')
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .fontColor(AppTokens.Colors.onBackground)

      Blank()

      Button() {
        Text('⚙')
          .fontSize(24)
          .fontColor(AppTokens.Colors.accent)
      }
      .onClick(() => {})
    }
    .alignItems(VerticalAlign.Center)
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .backgroundColor(AppTokens.Colors.surface)
  }
}

// MARK: - Battery Icon
@Component
struct BatteryIcon {
  @Prop progress: number = 0.45;

  build() {
    Stack() {
      Row()
        .width(50)
        .height(90)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(8)

      Row()
        .width(20)
        .height(10)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(3)
        .offset({ x: 0, y: -50 })

      Text('⚡')
        .fontSize(40)
        .fontColor(AppTokens.Colors.onPrimary)
    }
    .width(60)
    .height(100)
  }
}

// MARK: - Custom Progress Bar
@Component
struct CustomProgressBar {
  @Prop progress: number = 0.45;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(12)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(6)
        .border({ width: 1, color: AppTokens.Colors.outline })

      Row()
        .width((Math.min(Math.max(this.progress, 0), 1) * 100).toString() + '%')
        .height(10)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(5)
        .margin(1)
    }
    .width('70%')
    .height(12)
  }
}

// MARK: - Root Screen
@Component
struct RootScreen {
  @State progress: number = 0.45;

  build() {
    Stack() {
      Column({ space: 0 }) {
        CustomTopBar()

        Column({ space: AppTokens.Spacing.lg }) {
          Column({ space: AppTokens.Spacing.md }) {
            BatteryIcon({ progress: this.progress })

            Text(Math.floor(this.progress * 100).toString() + '%')
              .fontSize(36)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokens.Colors.onBackground)
          }
          .padding({ top: AppTokens.Spacing.md })

          CustomProgressBar({ progress: this.progress })
            .height(12)
            .padding({ top: AppTokens.Spacing.lg })

          Button() {
            Text('Simulate Charge')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onPrimary)
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(24)
          }
          .onClick(() => {
            this.progress += 0.1;
            if (this.progress > 1.0) {
              this.progress = 0.0;
            }
          })
          .padding({ top: AppTokens.Spacing.lg })

          Text(this.progress < 1.0 ? 'Charging...' : 'Fully Charged!')
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(this.progress < 1.0 ? AppTokens.Colors.primary : AppTokens.Colors.secondary)
            .padding({ top: AppTokens.Spacing.md })

          Blank()
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.ALL])
  }
}

// MARK: - ChargingProgressApp
@Entry
@Component
struct ChargingProgressApp {
  build() {
    RootScreen()
  }
}
