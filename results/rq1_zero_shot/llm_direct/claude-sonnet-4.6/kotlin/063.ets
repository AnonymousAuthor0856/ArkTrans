import { router } from '@kit.ArkUI';

// Design tokens
const AppColors = {
  primary: '#3B82F6',
  secondary: '#22C55E',
  background: '#F5F5F4',
  surface: '#FFFFFF',
  outline: '#D4D4D8',
  onPrimary: '#FFFFFF',
  onBackground: '#111827',
  onSurface: '#1F2937',
  accent: '#F59E0B',
};

const AppSpacing = {
  sm: 6,
  md: 10,
  lg: 14,
  xl: 20,
};

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.45;

  build() {
    Column() {
      // Top App Bar
      Row() {
        // Navigation icon placeholder (electric car icon)
        Text('🚗')
          .fontSize(24)
          .fontColor(AppColors.primary)
          .margin({ left: 8 })

        Text('Charging Progress')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // Settings icon
        Text('⚙️')
          .fontSize(24)
          .fontColor(AppColors.accent)
          .margin({ right: 8 })
          .onClick(() => {})
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.surface)
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)

      // Main content
      Column() {
        // Battery charging icon
        Text('🔋')
          .fontSize(72)
          .margin({ bottom: AppSpacing.xl })

        // Progress percentage
        Text(`${Math.floor(this.progress * 100)}%`)
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
          .margin({ bottom: AppSpacing.xl })

        // Progress bar container
        Stack({ alignContent: Alignment.Start }) {
          // Track
          Row()
            .width('80%')
            .height(14)
            .backgroundColor(AppColors.surface)
            .borderRadius(7)
            .border({ width: 1, color: AppColors.outline, radius: 7 })

          // Fill
          Row()
            .width(`${this.progress * 80}%`)
            .height(14)
            .backgroundColor(AppColors.primary)
            .borderRadius(7)
        }
        .width('100%')
        .height(14)
        .margin({ bottom: AppSpacing.xl })

        // Simulate Charge button
        Button('Simulate Charge')
          .backgroundColor(AppColors.secondary)
          .fontColor(AppColors.onPrimary)
          .fontSize(14)
          .borderRadius(50)
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .margin({ bottom: AppSpacing.xl })
          .onClick(() => {
            this.progress += 0.1;
            if (this.progress > 1.0) {
              this.progress = 0;
            }
          })

        // Status text
        Text(this.progress < 1.0 ? 'Charging...' : 'Fully Charged!')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.progress < 1.0 ? AppColors.primary : AppColors.secondary)
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppColors.background)
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}