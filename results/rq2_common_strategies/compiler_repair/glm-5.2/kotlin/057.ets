// 086_SleepCycle_en
// UI_TYPE: Health Auth
// STYLE_THEME: Modern Blue
// LANG: en
// BASELINE_SIZE: 720x1280

const enum AppColors {
  primary = 0xFF2563EB,
  secondary = 0xFF38BDF8,
  tertiary = 0xFF60A5FA,
  background = 0xFFF8FAFC,
  surface = 0xFFFFFFFF,
  surfaceVariant = 0xFFE2E8F0,
  outline = 0xFFCBD5E1,
  success = 0xFF22C55E,
  warning = 0xFFF59E0B,
  error = 0xFFEF4444,
  onPrimary = 0xFFFFFFFF,
  onSecondary = 0xFF0F172A,
  onTertiary = 0xFFFFFFFF,
  onBackground = 0xFF0F172A,
  onSurface = 0xFF1E293B
}

const enum AppSpacing {
  xs = 4,
  sm = 8,
  md = 12,
  lg = 16,
  xl = 24,
  xxl = 36
}

@Entry
@Component
struct RootScreen {
  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background Gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [[AppColors.secondary, 0.15], [AppColors.primary, 0.1]]
        });

      // Main Content
      Column() {
        // Top App Bar
        Row() {
          // Back Button
          Text('<')
            .width(24)
            .height(24)
            .backgroundColor(AppColors.primary)
            .fontColor(AppColors.onPrimary)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .textAlign(TextAlign.Center)
            .borderRadius(12);

          // Title
          Text('Sleep Cycle')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground);

          // Help Button
          Text('?')
            .width(24)
            .height(24)
            .backgroundColor(AppColors.secondary)
            .fontColor(AppColors.onSecondary)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .textAlign(TextAlign.Center)
            .borderRadius(12);
        }
        .width('100%')
        .height(56)
        .padding({ left: 16, right: 16 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center);

        // Content Area
        Column() {
          // Sleep Icon
          Text('😴')
            .width(160)
            .height(160)
            .fontSize(48)
            .textAlign(TextAlign.Center)
            .backgroundColor(AppColors.surface)
            .borderRadius(80)
            .border({ width: 2, color: AppColors.outline });

          // Welcome Text
          Text('Welcome Back')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .margin({ top: 24 });

          // Description
          Text('Track your sleep patterns and improve rest quality.')
            .fontSize(14)
            .fontColor(AppColors.onSurface)
            .textAlign(TextAlign.Center)
            .margin({ top: 8, bottom: 24 });

          // Sign In Button
          Button('Sign In')
            .width('80%')
            .height(52)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .backgroundColor(AppColors.primary)
            .fontColor(AppColors.onPrimary)
            .borderRadius(16);
        }
        .width('100%')
        .height('100%')
        .padding(16)
        .alignItems(HorizontalAlign.Center);
      }
      .width('100%')
      .height('100%');
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}