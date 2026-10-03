// 058*OrderTracking*en
// UI_TYPE: ECommerce
// STYLE_THEME: Retro Flat
// LANG: en
// BASELINE_SIZE: 720x1280

const enum AppColors {
  primary = 0xFFFF7043,
  secondary = 0xFFFFB74D,
  tertiary = 0xFFFFD180,
  background = 0xFFFFF3E0,
  surface = 0xFFFFFFFF,
  surfaceVariant = 0xFFFFE0B2,
  outline = 0xFFD7CCC8,
  success = 0xFF66BB6A,
  warning = 0xFFFFCA28,
  error = 0xFFD32F2F,
  onPrimary = 0xFFFFFFFF,
  onSecondary = 0xFF3E2723,
  onBackground = 0xFF3E2723,
  onSurface = 0xFF3E2723
}

const enum AppSpacing {
  sm = 6,
  md = 10,
  lg = 16,
  xl = 24
}

const enum AppRadius {
  small = 6,
  medium = 10,
  large = 16
}

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.45;

  build() {
    Column() {
      Column() {
        Text('Order Tracking')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
          .margin({ bottom: AppSpacing.lg })

        // Card
        Column() {
          Text('Order #25491')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .margin({ bottom: AppSpacing.md })

          Text('Estimated Delivery: 2 days')
            .fontSize(14)
            .fontColor(AppColors.secondary)
            .margin({ bottom: AppSpacing.md })

          // Progress Bar
          Stack({ alignContent: Alignment.Start }) {
            // Track
            Column()
              .width('100%')
              .height(10)
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(5)

            // Progress
            Column()
              .width(`${(this.progress * 100).toFixed(0)}%`)
              .height(10)
              .backgroundColor(AppColors.primary)
              .borderRadius(5)
          }
          .width('100%')
          .margin({ bottom: AppSpacing.md })

          Row() {
            Text('Processing')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.secondary)

            Text(`${(this.progress * 100).toFixed(0)}%`)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.primary)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppRadius.large)
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.15)', offsetX: 0, offsetY: 4 })
        .margin({ bottom: AppSpacing.lg })

        // Box
        Column() {
          Text('Adjust Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .margin({ bottom: AppSpacing.md })

          Slider({
            value: this.progress,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .selectedColor(AppColors.primary)
            .trackColor(AppColors.surfaceVariant)
            .blockColor(AppColors.primary)
            .onChange((value: number) => {
              this.progress = value;
            })
            .margin({ bottom: AppSpacing.md })

          Button('Mark as Delivered')
            .width('100%')
            .backgroundColor(AppColors.primary)
            .fontColor(AppColors.onPrimary)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .borderRadius(AppRadius.medium)
            .onClick(() => {
              this.progress = 1;
            })
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppRadius.large)
      }
      .width('100%')
      .height('100%')
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
  }
}