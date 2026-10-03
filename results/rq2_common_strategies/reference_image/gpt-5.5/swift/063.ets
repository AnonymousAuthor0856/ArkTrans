class AppTokens {
  static readonly primary: string = '#3B82F6'
  static readonly secondary: string = '#22C55E'
  static readonly background: string = '#F5F5F4'
  static readonly surface: string = '#FFFFFF'
  static readonly outline: string = '#D4D4D8'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onBackground: string = '#111827'
  static readonly onSurface: string = '#1F2937'
  static readonly accent: string = '#F59E0B'

  static readonly spacingSm: number = 6
  static readonly spacingMd: number = 10
  static readonly spacingLg: number = 14
  static readonly spacingXl: number = 20
  static readonly spacingXxl: number = 40
}

@Entry
@Component
struct ChargingProgressApp {
  build() {
    RootScreen()
  }
}

@Component
struct RootScreen {
  @State private progress: number = 0.45

  private charge(): void {
    animateTo({ duration: 250, curve: Curve.EaseInOut }, () => {
      this.progress += 0.1
      if (this.progress > 1.0) {
        this.progress = 0.0
      }
    })
  }

  build() {
    Column() {
      CustomTopBar()

      Column({ space: AppTokens.spacingLg }) {
        Column({ space: AppTokens.spacingMd }) {
          BatteryIcon({ progress: this.progress })
            .width(60)
            .height(100)

          Text(`${Math.floor(this.progress * 100)}%`)
            .fontSize(36)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.onBackground)
        }
        .margin({ top: AppTokens.spacingMd })

        CustomProgressBar({ progress: this.progress })
          .height(12)
          .width('70%')
          .margin({ top: AppTokens.spacingLg })

        Button({ type: ButtonType.Capsule }) {
          Text('Simulate Charge')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.onPrimary)
        }
        .height(40)
        .padding({ left: 24, right: 24 })
        .backgroundColor(AppTokens.secondary)
        .margin({ top: AppTokens.spacingLg })
        .onClick(() => {
          this.charge()
        })

        Text(this.progress < 1.0 ? 'Charging...' : 'Fully Charged!')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(this.progress < 1.0 ? AppTokens.primary : AppTokens.secondary)
          .margin({ top: AppTokens.spacingMd })

        Blank()
          .layoutWeight(1)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.spacingLg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)
  }
}

@Component
struct CustomTopBar {
  build() {
    Row() {
      CarBoltIcon()
        .width(48)
        .height(32)

      Text('Charging Progress')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.onBackground)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)

      Text('⚙')
        .width(48)
        .height(32)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.accent)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(45)
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .backgroundColor(AppTokens.surface)
  }
}

@Component
struct CarBoltIcon {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Blank()
        .width(24)
        .height(16)
        .backgroundColor(AppTokens.primary)
        .borderRadius(8)
        .offset({ x: 0, y: -7 })

      Blank()
        .width(34)
        .height(23)
        .backgroundColor(AppTokens.primary)
        .borderRadius(6)
        .offset({ x: 0, y: 3 })

      Blank()
        .width(7)
        .height(9)
        .backgroundColor(AppTokens.primary)
        .borderRadius(2)
        .offset({ x: -14, y: 12 })

      Blank()
        .width(7)
        .height(9)
        .backgroundColor(AppTokens.primary)
        .borderRadius(2)
        .offset({ x: 14, y: 12 })

      Text('⚡')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.onPrimary)
        .textAlign(TextAlign.Center)
        .offset({ x: 0, y: -1 })
    }
    .width(48)
    .height(32)
  }
}

@Component
struct BatteryIcon {
  progress: number = 0.45

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Blank()
        .width(50)
        .height(90)
        .backgroundColor(AppTokens.primary)
        .borderRadius(8)
        .offset({ x: 0, y: 5 })

      Blank()
        .width(20)
        .height(10)
        .backgroundColor(AppTokens.primary)
        .borderRadius(3)
        .offset({ x: 0, y: -45 })

      Text('⚡')
        .fontSize(34)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.onPrimary)
        .textAlign(TextAlign.Center)
        .offset({ x: 0, y: 5 })
    }
    .width(60)
    .height(100)
  }
}

@Component
struct CustomProgressBar {
  progress: number = 0.45

  private normalizedProgress(): number {
    if (this.progress < 0) {
      return 0
    }
    if (this.progress > 1) {
      return 1
    }
    return this.progress
  }

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(12)
        .backgroundColor(AppTokens.surface)
        .border({
          width: 1,
          color: AppTokens.outline
        })
        .borderRadius(6)

      Row()
        .width(`${this.normalizedProgress() * 100}%`)
        .height(10)
        .backgroundColor(AppTokens.primary)
        .borderRadius(5)
        .margin({ left: 1 })
    }
    .width('100%')
    .height(12)
    .clip(true)
  }
}