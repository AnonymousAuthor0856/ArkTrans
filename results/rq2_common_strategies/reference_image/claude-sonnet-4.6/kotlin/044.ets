// OrderTrackingPage.ets
// Full-screen immersive mode is enabled in EntryAbility.onWindowStageCreate:
//   windowStage.getMainWindowSync().setWindowLayoutFullScreen(true);
//   windowStage.getMainWindowSync().setWindowSystemBarEnable([]);
// and the page declares: @Entry @Component ... build() { ... } as below.

class AppColors {
  static readonly primary: string = '#FF7043'
  static readonly secondary: string = '#FFB74D'
  static readonly tertiary: string = '#FFD180'
  static readonly background: string = '#FFF3E0'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#FFE0B2'
  static readonly outline: string = '#D7CCC8'
  static readonly success: string = '#66BB6A'
  static readonly warning: string = '#FFCA28'
  static readonly error: string = '#D32F2F'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#3E2723'
  static readonly onBackground: string = '#3E2723'
  static readonly onSurface: string = '#3E2723'
  static readonly shadowLevel2: string = '#26000000'
}

class AppSpacing {
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 16
  static readonly xl: number = 24
}

class AppRadius {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 16
}

class AppDimens {
  static readonly displaySize: number = 28
  static readonly titleSize: number = 18
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12
  static readonly progressTrackWidth: number = 10
  static readonly buttonHeight: number = 44
  static readonly orderNumber: string = '25491'
  static readonly deliveryEstimate: string = '2 days'
}

@Entry
@Component
struct OrderTrackingPage {
  @State progress: number = 42

  build() {
    Scroll() {
      Column({ space: AppSpacing.lg }) {
        Text('Order Tracking')
          .fontSize(AppDimens.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
          .width('100%')

        // ---- Order status card ----
        Column({ space: AppSpacing.md }) {
          Text(`Order #${AppDimens.orderNumber}`)
            .fontSize(AppDimens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .width('100%')

          Text(`Estimated Delivery: ${AppDimens.deliveryEstimate}`)
            .fontSize(AppDimens.bodySize)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.secondary)
            .width('100%')

          Progress({ value: this.progress, total: 100, type: ProgressType.Linear })
            .color(AppColors.primary)
            .backgroundColor(AppColors.surfaceVariant)
            .style({ strokeWidth: AppDimens.progressTrackWidth, strokeRadius: AppDimens.progressTrackWidth / 2 })
            .width('100%')

          Row() {
            Text('Processing')
              .fontSize(AppDimens.labelSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.secondary)

            Blank()

            Text(`${Math.round(this.progress)}%`)
              .fontSize(AppDimens.labelSize)
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
        .shadow({ radius: 8, color: AppColors.shadowLevel2, offsetX: 0, offsetY: 4 })

        // ---- Adjust progress card ----
        Column({ space: AppSpacing.md }) {
          Text('Adjust Progress')
            .fontSize(AppDimens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Slider({
            value: this.progress,
            min: 0,
            max: 100,
            step: 1,
            style: SliderStyle.OutSet
          })
            .blockColor(AppColors.primary)
            .selectedColor(AppColors.primary)
            .trackColor(AppColors.surfaceVariant)
            .width('100%')
            .onChange((value: number, mode: SliderChangeMode) => {
              this.progress = value
            })

          Button('Mark as Delivered', { type: ButtonType.Normal, stateEffect: true })
            .fontSize(AppDimens.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppRadius.medium)
            .height(AppDimens.buttonHeight)
            .width('100%')
            .onClick(() => {
              this.progress = 100
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppRadius.large)
        .shadow({ radius: 8, color: AppColors.shadowLevel2, offsetX: 0, offsetY: 4 })
      }
      .width('100%')
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .scrollBar(BarState.Off)
    .align(Alignment.TopStart)
  }
}