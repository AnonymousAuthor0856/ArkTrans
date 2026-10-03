class AppColors {
  static readonly primary: string = '#3B82F6'
  static readonly secondary: string = '#22C55E'
  static readonly background: string = '#F5F5F4'
  static readonly surface: string = '#FFFFFF'
  static readonly outline: string = '#D4D4D8'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onBackground: string = '#111827'
  static readonly onSurface: string = '#1F2937'
  static readonly accent: string = '#F59E0B'
}

class AppSpacing {
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 14
  static readonly xl: number = 20
  static readonly xxl: number = 40
}

@Entry
@Component
struct ContentView {
  build() {
    RootScreen()
  }
}

@Component
struct RootScreen {
  @State progress: number = 0.45

  private clampedProgress(): number {
    return Math.min(Math.max(this.progress, 0), 1)
  }

  build() {
    Stack() {
      Column() {
        CustomTopBar()

        Column({ space: AppSpacing.lg }) {
          Column({ space: AppSpacing.md }) {
            BatteryIcon({ progress: this.progress })
              .width(60)
              .height(100)

            Text(`${Math.floor(this.clampedProgress() * 100)}%`)
              .fontSize(36)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.onBackground)
          }
          .margin({ top: AppSpacing.md })

          CustomProgressBar({ progress: this.progress })
            .height(12)
            .width('70%')
            .margin({ top: AppSpacing.lg })

          Button('Simulate Charge')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .padding({
              left: 24,
              right: 24,
              top: 12,
              bottom: 12
            })
            .backgroundColor(AppColors.secondary)
            .borderRadius(24)
            .margin({ top: AppSpacing.lg })
            .onClick(() => {
              animateTo({
                duration: 250,
                curve: Curve.EaseInOut
              }, () => {
                this.progress += 0.1
                if (this.progress > 1.0) {
                  this.progress = 0.0
                }
              })
            })

          Text(this.progress < 1.0 ? 'Charging...' : 'Fully Charged!')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(this.progress < 1.0 ? AppColors.primary : AppColors.secondary)
            .margin({ top: AppSpacing.md })

          Blank()
        }
        .padding(AppSpacing.lg)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

@Component
struct CustomTopBar {
  build() {
    Row() {
      Text('🚘')
        .fontSize(24)
        .fontColor(AppColors.primary)
        .width(40)
        .textAlign(TextAlign.Start)
        .padding({ left: 8 })

      Blank()

      Text('Charging Progress')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)

      Blank()

      Button() {
        Text('⚙')
          .fontSize(24)
          .fontColor(AppColors.accent)
      }
      .width(40)
      .height(40)
      .backgroundColor(Color.Transparent)
      .borderRadius(20)
      .padding(0)
      .onClick(() => {})
    }
    .width('100%')
    .padding({
      left: 16,
      right: 16,
      top: 8,
      bottom: 8
    })
    .backgroundColor(AppColors.surface)
  }
}

@Component
struct BatteryIcon {
  @Prop progress: number

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Column()
        .width(50)
        .height(90)
        .backgroundColor(AppColors.primary)
        .borderRadius(8)

      Column()
        .width(20)
        .height(10)
        .backgroundColor(AppColors.primary)
        .borderRadius(3)
        .translate({ y: -50 })

      LightningBolt()
        .width(25)
        .height(40)
    }
    .width(60)
    .height(100)
  }
}

@Component
struct LightningBolt {
  build() {
    Path()
      .width(25)
      .height(40)
      .commands('M12.5 5 L4.5 20 L14.5 20 L7.5 35 L20.5 20 L10.5 20 Z')
      .fill(AppColors.onPrimary)
  }
}

@Component
struct CustomProgressBar {
  @Prop progress: number

  private clampedProgress(): number {
    return Math.min(Math.max(this.progress, 0), 1)
  }

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(12)
        .backgroundColor(AppColors.surface)
        .border({
          width: 1,
          color: AppColors.outline
        })
        .borderRadius(6)

      Row()
        .width(`${this.clampedProgress() * 100}%`)
        .height(10)
        .backgroundColor(AppColors.primary)
        .borderRadius(5)
        .margin({ left: 1 })
    }
    .width('100%')
    .height(12)
    .clip(true)
  }
}