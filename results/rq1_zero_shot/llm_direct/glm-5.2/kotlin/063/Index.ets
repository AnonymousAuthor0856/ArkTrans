// ChargingProgress.ets
// SmartHome Dashboard - Retro Flat Style - English

// ============= Design Tokens =============
class AppTokens {
  static readonly Colors = {
    primary: '#3B82F6',
    secondary: '#22C55E',
    background: '#F5F5F4',
    surface: '#FFFFFF',
    outline: '#D4D4D8',
    onPrimary: '#FFFFFF',
    onBackground: '#111827',
    onSurface: '#1F2937',
    accent: '#F59E0B'
  }
  
  static readonly Typography = {
    display: { fontSize: 24, fontWeight: FontWeight.Bold },
    headline: { fontSize: 18, fontWeight: FontWeight.Medium },
    title: { fontSize: 14, fontWeight: FontWeight.Medium },
    body: { fontSize: 12, fontWeight: FontWeight.Normal }
  }
  
  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20
  }
}

// ============= Main Entry Component =============
@Entry
@Component
struct ChargingProgress {
  @State progress: number = 0.45
  
  // ============= Lifecycle =============
  aboutToAppear() {
    // Set immersive mode
    window.getLastWindow(app.getContext())
      .then((win) => {
        win.setWindowLayoutFullScreen(true)
        win.setSystemBarEnable([])
      })
  }

  // ============= Build Method =============
  build() {
    Column() {
      // ============= Top App Bar =============
      Row() {
        // Navigation Icon
        Image($r('app.media.ic_electric_car'))
          .width(24)
          .height(24)
          .fillColor(AppTokens.Colors.primary)
          .margin({ left: 8 })

        // Title
        Text('Charging Progress')
          .fontSize(AppTokens.Typography.display.fontSize)
          .fontWeight(AppTokens.Typography.display.fontWeight)
          .fontColor(AppTokens.Colors.onBackground)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // Settings Icon
        Image($r('app.media.ic_settings'))
          .width(24)
          .height(24)
          .fillColor(AppTokens.Colors.accent)
          .margin({ right: 8 })
          .onClick(() => {
            console.log('Settings clicked')
          })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)
      .padding({ left: 12, right: 12 })

      // ============= Content Area =============
      Column() {
        // Battery Icon
        Image($r('app.media.ic_battery_charging'))
          .width(72)
          .height(72)
          .fillColor(AppTokens.Colors.primary)
          .margin({ bottom: AppTokens.Spacing.xl })

        // Progress Percentage
        Text(`${Math.floor(this.progress * 100)}%`)
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
          .margin({ bottom: AppTokens.Spacing.xl })

        // Progress Bar Container
        Stack({ alignContent: Alignment.Start }) {
          // Track
          Column()
            .width('100%')
            .height(14)
            .backgroundColor(AppTokens.Colors.surface)
            .border({ width: 1, color: AppTokens.Colors.outline, radius: 7 })

          // Progress Fill
          Column()
            .width(`${this.progress * 100}%`)
            .height(14)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(7)
        }
        .width('80%')
        .height(14)
        .margin({ bottom: AppTokens.Spacing.xl })

        // Simulate Button
        Button('Simulate Charge') {
          Text('Simulate Charge')
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
        }
        .height(40)
        .borderRadius(20)
        .backgroundColor(AppTokens.Colors.secondary)
        .margin({ bottom: AppTokens.Spacing.xl })
        .onClick(() => {
          this.progress += 0.1
          if (this.progress > 1) {
            this.progress = 0
          }
        })

        // Status Text
        Text(this.progress < 1 ? 'Charging...' : 'Fully Charged!')
          .fontSize(AppTokens.Typography.headline.fontSize)
          .fontWeight(AppTokens.Typography.headline.fontWeight)
          .fontColor(this.progress < 1 ? AppTokens.Colors.primary : AppTokens.Colors.secondary)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}