class AppTokens {
  static readonly Colors = {
    primary: '#FF3B82F6',
    secondary: '#FF22C55E',
    background: '#FFF5F5F4',
    surface: '#FFFFFFFF',
    outline: '#FFD4D4D8',
    onPrimary: '#FFFFFFFF',
    onBackground: '#FF111827',
    onSurface: '#FF1F2937',
    accent: '#FFF59E0B',
  }
  static readonly Typography = {
    display: { size: 24, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Medium },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Normal },
  }
  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 40,
  }
}

@Component
struct CustomTopBar {
  build() {
    Row() {
      Text('🚗')
        .fontSize(24)
        .fontColor(AppTokens.Colors.primary)
        .margin({ left: 8 })

      Blank()

      Text('Charging Progress')
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .fontColor(AppTokens.Colors.onBackground)

      Blank()

      Text('⚙')
        .fontSize(24)
        .fontColor(AppTokens.Colors.accent)
        .margin({ right: 8 })
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .backgroundColor(AppTokens.Colors.surface)
  }
}

@Component
struct BatteryIcon {
  @Prop progress: number

  build() {
    Stack() {
      Column()
        .width(50)
        .height(90)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(8)

      Column()
        .width(20)
        .height(10)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(3)
        .position({ x: 20, y: 0 })

      Text('⚡')
        .fontSize(32)
        .fontColor(AppTokens.Colors.onPrimary)
    }
    .width(60)
    .height(100)
  }
}

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.45

  build() {
    Stack() {
      Column() {
        CustomTopBar()

        Column({ space: AppTokens.Spacing.lg }) {
          Column({ space: AppTokens.Spacing.md }) {
            BatteryIcon({ progress: this.progress })

            Text(`${Math.round(this.progress * 100)}%`)
              .fontSize(36)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokens.Colors.onBackground)
          }
          .margin({ top: AppTokens.Spacing.md })

          Stack({ alignContent: Alignment.Start }) {
            Column()
              .width(`${Math.min(Math.max(this.progress, 0), 1) * 100}%`)
              .height('100%')
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(6)
              .margin({ top: 1, bottom: 1, left: 1 })
          }
          .width('70%')
          .height(12)
          .backgroundColor(AppTokens.Colors.surface)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .borderRadius(6)
          .margin({ top: AppTokens.Spacing.lg })

          Button('Simulate Charge')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(20)
            .margin({ top: AppTokens.Spacing.lg })
            .onClick(() => {
              this.progress += 0.1
              if (this.progress > 1.0) {
                this.progress = 0.0
              }
            })

          Text(this.progress < 1.0 ? 'Charging...' : 'Fully Charged!')
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(this.progress < 1.0 ? AppTokens.Colors.primary : AppTokens.Colors.secondary)
            .margin({ top: AppTokens.Spacing.md })

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
    .backgroundColor(AppTokens.Colors.background)
  }
}