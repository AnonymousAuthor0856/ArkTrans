const NAME: string = "086_SleepCycle_en";
const UI_TYPE: string = "Health Auth";
const STYLE_THEME: string = "Modern Blue";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

class AppColors {
  static readonly primary: string = '#2563EB';
  static readonly secondary: string = '#38BDF8';
  static readonly background: string = '#F8FAFC';
  static readonly surface: string = '#FFFFFF';
  static readonly outline: string = '#CBD5E1';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#0F172A';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#1E293B';
}

class AppSpacing {
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

@Entry
@Component
struct MainActivity {
  @Builder
  CircleLabel(label: string, bg: string, fg: string) {
    Text(label)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(fg)
      .textAlign(TextAlign.Center)
      .width(24)
      .height(24)
      .lineHeight(24)
      .backgroundColor(bg)
      .borderRadius(12)
  }

  build() {
    Column() {
      Row() {
        this.CircleLabel('<', AppColors.primary, AppColors.onPrimary)
        Text('Sleep Cycle')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
        this.CircleLabel('?', AppColors.secondary, AppColors.onSecondary)
      }
      .width('100%')
      .height(68)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.xl }) {
        Text('😴')
          .fontSize(48)
          .textAlign(TextAlign.Center)
          .width(160)
          .height(160)
          .lineHeight(160)
          .backgroundColor(AppColors.surface)
          .borderRadius(80)
          .border({ width: 2, color: AppColors.outline })

        Text('Welcome Back')
          .fontSize(20)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)

        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(14)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')

        Button('Sign In')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .width('80%')
          .height(52)
          .backgroundColor(AppColors.primary)
          .borderRadius(16)
      }
      .layoutWeight(1)
      .width('100%')
      .padding(AppSpacing.lg)
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(AppColors.background)
      .linearGradient({
        angle: 180,
        colors: [['#2638BDF8', 0.0], ['#1A2563EB', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
