class AppColors {
  static primary: string = '#3B82F6'
  static secondary: string = '#22C55E'
  static background: string = '#F5F5F4'
  static surface: string = '#FFFFFF'
  static outline: string = '#D4D4D8'
  static onPrimary: string = '#FFFFFF'
  static onBackground: string = '#111827'
  static onSurface: string = '#1F2937'
  static accent: string = '#F59E0B'
}

class AppSpacing {
  static sm: number = 6
  static md: number = 10
  static lg: number = 14
  static xl: number = 20
  static xxl: number = 40
}

@Entry
@Component
struct Index {
  @State progress: number = 0.45

  @Builder
  CustomTopBar() {
    Row() {
      Text('EV')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .width(48)
        .textAlign(TextAlign.Start)

      Blank()
        .layoutWeight(1)

      Text('Charging Progress')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)

      Blank()
        .layoutWeight(1)

      Button('Set')
        .fontSize(12)
        .fontColor(AppColors.accent)
        .width(48)
        .height(36)
        .backgroundColor('#00FFFFFF')
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  BatteryIcon() {
    Stack() {
      Rect()
        .width(50)
        .height(90)
        .fill(AppColors.primary)
        .radius(8)
        .position({ x: '50%', y: '55%' })

      Rect()
        .width(20)
        .height(10)
        .fill(AppColors.primary)
        .radius(3)
        .position({ x: '50%', y: '8%' })

      Text('⚡')
        .fontSize(32)
        .fontColor(AppColors.onPrimary)
        .fontWeight(FontWeight.Bold)
        .position({ x: '50%', y: '55%' })
    }
    .width(60)
    .height(100)
  }

  @Builder
  ProgressBar() {
    Stack({ alignContent: Alignment.Start }) {
      Rect()
        .width('100%')
        .height(12)
        .fill(AppColors.surface)
        .stroke(AppColors.outline)
        .strokeWidth(1)
        .radius(6)
      Rect()
        .width((this.progress * 100).toString() + '%')
        .height(10)
        .fill(AppColors.primary)
        .radius(5)
        .margin(1)
    }
    .width('70%')
    .height(12)
  }

  build() {
    Stack() {
      Column() {
        this.CustomTopBar()

        Column({ space: AppSpacing.lg }) {
          Column({ space: AppSpacing.md }) {
            this.BatteryIcon()

            Text(Math.floor(this.progress * 100).toString() + '%')
              .fontSize(36)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.onBackground)
          }
          .margin({ top: AppSpacing.md })
          .alignItems(HorizontalAlign.Center)

          Column() {
            this.ProgressBar()
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
          .margin({ top: AppSpacing.lg })

          Button('Simulate Charge')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(AppColors.secondary)
            .borderRadius(24)
            .margin({ top: AppSpacing.lg })
            .onClick(() => {
              this.progress += 0.1
              if (this.progress > 1.0) {
                this.progress = 0.0
              }
            })

          Text(this.progress < 1.0 ? 'Charging...' : 'Fully Charged!')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.progress < 1.0 ? AppColors.primary : AppColors.secondary)
            .margin({ top: AppSpacing.md })

          Blank()
            .layoutWeight(1)
        }
        .width('100%')
        .layoutWeight(1)
        .padding(AppSpacing.lg)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
