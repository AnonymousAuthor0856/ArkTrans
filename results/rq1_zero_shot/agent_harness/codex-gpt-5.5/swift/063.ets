class AppColors {
  static primary: string = '#3B82F6';
  static secondary: string = '#22C55E';
  static background: string = '#F5F5F4';
  static surface: string = '#FFFFFF';
  static outline: string = '#D4D4D8';
  static onPrimary: string = '#FFFFFF';
  static onBackground: string = '#111827';
  static onSurface: string = '#1F2937';
  static accent: string = '#F59E0B';
}

class AppSpacing {
  static sm: number = 6;
  static md: number = 10;
  static lg: number = 14;
  static xl: number = 20;
  static xxl: number = 40;
}

@Entry
@Component
struct RootScreen {
  @State private progress: number = 0.45;

  @Builder
  private CustomTopBar() {
    Row() {
      Text('⚡')
        .fontSize(24)
        .fontColor(AppColors.primary)
        .margin({ left: 8 })
      Blank()
      Text('Charging Progress')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
      Blank()
      Text('⚙')
        .fontSize(24)
        .fontColor(AppColors.accent)
    }
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .width('100%')
    .backgroundColor(AppColors.surface)
  }

  @Builder
  private BatteryIcon() {
    Stack() {
      Rect()
        .width(50)
        .height(90)
        .fill(AppColors.primary)
        .radius(8)
      Rect()
        .width(20)
        .height(10)
        .fill(AppColors.primary)
        .radius(3)
        .position({ x: '50%', y: 0 })
      Text('⚡')
        .fontSize(34)
        .fontColor(AppColors.onPrimary)
    }
    .width(60)
    .height(100)
  }

  @Builder
  private CustomProgressBar() {
    Stack({ alignContent: Alignment.Start }) {
      Rect()
        .width('100%')
        .height(12)
        .fill(AppColors.surface)
        .stroke(AppColors.outline)
        .strokeWidth(1)
        .radius(6)
      Rect()
        .width(`${Math.min(Math.max(this.progress, 0), 1) * 100}%`)
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
      Column({ space: 0 }) {
        this.CustomTopBar()

        Column({ space: AppSpacing.lg }) {
          Column({ space: AppSpacing.md }) {
            this.BatteryIcon()
            Text(`${Math.floor(this.progress * 100)}%`)
              .fontSize(36)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.onBackground)
          }
          .margin({ top: AppSpacing.md })

          this.CustomProgressBar()
            .margin({ top: AppSpacing.lg })

          Button('Simulate Charge')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(AppColors.secondary)
            .borderRadius(22)
            .margin({ top: AppSpacing.lg })
            .onClick(() => {
              this.progress += 0.1;
              if (this.progress > 1.0) {
                this.progress = 0.0;
              }
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
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
