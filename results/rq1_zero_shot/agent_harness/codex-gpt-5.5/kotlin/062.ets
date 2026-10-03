const NAME: string = "101_ThermoCurve_en";
const UI_TYPE: string = "SmartHome Form";
const STYLE_THEME: string = "Cold Gradient";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

class AppColors {
  static readonly primary: string = '#3B82F6';
  static readonly secondary: string = '#06B6D4';
  static readonly background: string = '#F0F9FF';
  static readonly surfaceVariant: string = '#E0F2FE';
  static readonly outline: string = '#CBD5E1';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#1E293B';
}

class AppSpacing {
  static readonly md: number = 12;
  static readonly lg: number = 18;
  static readonly xl: number = 26;
}

@Entry
@Component
struct MainActivity {
  @State targetTemp: number = 22;
  @State mode: string = 'Cool';

  private decreaseTemp(): void {
    if (this.targetTemp > 10) {
      this.targetTemp--;
    }
  }

  private increaseTemp(): void {
    if (this.targetTemp < 35) {
      this.targetTemp++;
    }
  }

  @Builder
  ModeButton(label: string, icon: string) {
    Column() {
      Text(icon)
        .fontSize(30)
        .fontColor(this.mode === label ? AppColors.onPrimary : AppColors.onSurface)
      Text(label)
        .fontSize(14)
        .fontColor(this.mode === label ? AppColors.onPrimary : AppColors.onSurface)
        .margin({ top: 6 })
    }
    .width(100)
    .height(100)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.mode === label ? AppColors.primary : AppColors.surfaceVariant)
    .borderRadius(50)
    .onClick(() => {
      this.mode = label;
    })
  }

  build() {
    Column() {
      Row() {
        Text('T')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .width(42)
        Text('ThermoCurve')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
        Text('☀')
          .fontSize(22)
          .fontColor(AppColors.secondary)
          .width(42)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            this.increaseTemp();
          })
      }
      .width('100%')
      .height(68)
      .padding({ left: 12, right: 12 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.surfaceVariant)

      Column({ space: AppSpacing.xl }) {
        Text('Target Temperature')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)

        Row({ space: AppSpacing.md }) {
          Button('−')
            .fontSize(20)
            .fontColor(AppColors.onPrimary)
            .width(72)
            .height(44)
            .backgroundColor(AppColors.primary)
            .borderRadius(10)
            .onClick(() => {
              this.decreaseTemp();
            })
          Button('+')
            .fontSize(20)
            .fontColor(AppColors.onPrimary)
            .width(72)
            .height(44)
            .backgroundColor(AppColors.primary)
            .borderRadius(10)
            .onClick(() => {
              this.increaseTemp();
            })
        }
        .alignItems(VerticalAlign.Center)

        Divider()
          .width('80%')
          .height(1)
          .color('#80CBD5E1')

        Text('Mode')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)

        Row({ space: AppSpacing.lg }) {
          this.ModeButton('Cool', '≋')
          this.ModeButton('Heat', '☀')
        }

        Text(`Current Mode: ${this.mode}`)
          .fontSize(12)
          .fontColor(AppColors.onSurface)
      }
      .layoutWeight(1)
      .width('100%')
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(AppColors.background)
      .linearGradient({
        angle: 180,
        colors: [['#2606B6D4', 0.0], ['#333B82F6', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
