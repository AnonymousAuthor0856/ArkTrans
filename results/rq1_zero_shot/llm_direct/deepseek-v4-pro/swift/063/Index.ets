@Entry
@Component
struct ChargingProgressApp {
  build() {
    RootScreen()
  }
}

// Design System Tokens
class AppTokens {
  static readonly Colors = {
    primary: '#3B82F6',
    secondary: '#22C55E',
    background: '#F5F5F4',
    surface: '#FFFFFFFF',
    outline: '#D4D4D8',
    onPrimary: '#FFFFFFFF',
    onBackground: '#111827',
    onSurface: '#1F2937',
    accent: '#F59E0B'
  }

  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 40
  }
}

@Component
struct RootScreen {
  @State private progress: number = 0.45

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column({ space: 0 }) {
        // Top Bar
        CustomTopBar()

        // Content
        Column({ space: AppTokens.Spacing.lg }) {
          // Battery and percentage
          Column({ space: AppTokens.Spacing.md }) {
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
          Button('Simulate Charge')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(25)
            .onClick(() => {
              this.progress += 0.1
              if (this.progress > 1.0) {
                this.progress = 0.0
              }
            })
            .padding({ top: AppTokens.Spacing.lg })

          // Status Text
          Text(this.progress < 1.0 ? 'Charging...' : 'Fully Charged!')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
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
  }
}

@Component
struct CustomTopBar {
  build() {
    Row() {
      // Navigation Icon (Electric Car)
      Text('⚡')
        .fontSize(24)
        .fontColor(AppTokens.Colors.primary)
        .padding({ left: 8 })

      Blank()

      // Title
      Text('Charging Progress')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)

      Blank()

      // Action Icon (Settings)
      Text('⚙')
        .fontSize(24)
        .fontColor(AppTokens.Colors.accent)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .backgroundColor(AppTokens.Colors.surface)
  }
}

@Component
struct BatteryIcon {
  @Prop progress: number = 0.45

  build() {
    Stack({ alignContent: Alignment.Center }) {
      // Battery body
      Column()
        .width(50)
        .height(90)
        .borderRadius(8)
        .backgroundColor(AppTokens.Colors.primary)

      // Battery top cap
      Column()
        .width(20)
        .height(10)
        .borderRadius(3)
        .backgroundColor(AppTokens.Colors.primary)
        .translate({ y: -50 })

      // Lightning bolt using Path
      Path()
        .width(25)
        .height(40)
        .commands('M12.5 5 L4.5 20 L14.5 20 L7.5 35 L20.5 20 L10.5 20 Z')
        .fill(AppTokens.Colors.onPrimary)
    }
    .width(60)
    .height(100)
  }
}

@Component
struct CustomProgressBar {
  @Prop progress: number = 0.45

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Row()
        .width('100%')
        .height('100%')
        .borderRadius(6)
        .backgroundColor(AppTokens.Colors.surface)
        .border({
          width: 1,
          color: AppTokens.Colors.outline,
          radius: 6
        })

      // Indicator
      Row()
        .width(`${Math.min(Math.max(this.progress, 0), 1) * 100}%`)
        .height('100%')
        .borderRadius(6)
        .backgroundColor(AppTokens.Colors.primary)
        .margin(1)
    }
    .width('100%')
    .height('100%')
    .clip(true)
  }
}