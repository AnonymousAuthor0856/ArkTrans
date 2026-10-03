const NAME: string = "105_ChargingProgress_en";
const UI_TYPE: string = "SmartHome Dashboard";
const STYLE_THEME: string = "Retro Flat";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

class AppColors {
  static readonly primary: string = '#3B82F6';
  static readonly secondary: string = '#22C55E';
  static readonly background: string = '#F5F5F4';
  static readonly surface: string = '#FFFFFF';
  static readonly outline: string = '#D4D4D8';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onBackground: string = '#111827';
  static readonly accent: string = '#F59E0B';
}

class AppSpacing {
  static readonly lg: number = 14;
  static readonly xl: number = 20;
}

@Entry
@Component
struct MainActivity {
  @State progress: number = 0.45;

  private simulateCharge(): void {
    this.progress += 0.1;
    if (this.progress > 1) {
      this.progress = 0;
    }
  }

  build() {
    Column() {
      Row() {
        Text('⚡')
          .fontSize(24)
          .fontColor(AppColors.primary)
          .width(42)
        Text('Charging Progress')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
        Text('⚙')
          .fontSize(22)
          .fontColor(AppColors.accent)
          .width(42)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(66)
      .padding({ left: 8, right: 8 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.surface)

      Column({ space: AppSpacing.xl }) {
        Text('▰')
          .fontSize(72)
          .fontColor(AppColors.primary)

        Text(`${Math.floor(this.progress * 100)}%`)
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)

        Stack({ alignContent: Alignment.Start }) {
          Blank()
            .width('100%')
            .height(14)
            .backgroundColor(AppColors.surface)
            .borderRadius(7)
            .border({ width: 1, color: AppColors.outline })
          Blank()
            .width(`${Math.round(this.progress * 100)}%`)
            .height(14)
            .backgroundColor(AppColors.primary)
            .borderRadius(7)
        }
        .width('80%')
        .height(14)

        Button('Simulate Charge')
          .fontSize(14)
          .fontColor(AppColors.onPrimary)
          .height(44)
          .padding({ left: 18, right: 18 })
          .backgroundColor(AppColors.secondary)
          .borderRadius(22)
          .onClick(() => {
            this.simulateCharge();
          })

        Text(this.progress < 1 ? 'Charging...' : 'Fully Charged!')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(this.progress < 1 ? AppColors.primary : AppColors.secondary)
      }
      .layoutWeight(1)
      .width('100%')
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
