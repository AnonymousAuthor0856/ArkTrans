class AppColors {
  static readonly primary: ResourceColor = '#FFFF7042';
  static readonly secondary: ResourceColor = '#FFFFB84D';
  static readonly tertiary: ResourceColor = '#FFFFD180';
  static readonly background: ResourceColor = '#FFFFF2E0';
  static readonly surface: ResourceColor = '#FFFFFFFF';
  static readonly surfaceVariant: ResourceColor = '#FFFFE0B3';
  static readonly outline: ResourceColor = '#FFD6CCC7';
  static readonly success: ResourceColor = '#FF66BA6B';
  static readonly warning: ResourceColor = '#FFFFC928';
  static readonly error: ResourceColor = '#FFD42E2E';
  static readonly onPrimary: ResourceColor = '#FFFFFFFF';
  static readonly onSecondary: ResourceColor = '#FF3D2624';
  static readonly onBackground: ResourceColor = '#FF3D2624';
  static readonly onSurface: ResourceColor = '#FF3D2624';
}

class AppTypography {
  static readonly display: number = 28;
  static readonly title: number = 18;
  static readonly body: number = 14;
  static readonly label: number = 12;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 16;
}

class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

@Component
struct CustomSlider {
  @Link value: number;

  activeColor: ResourceColor = AppColors.primary;
  inactiveColor: ResourceColor = AppColors.surfaceVariant;
  thumbColor: ResourceColor = AppColors.primary;
  trackHeight: number = 10;
  thumbDiameter: number = 20;

  build() {
    Slider({
      value: this.value * 100,
      min: 0,
      max: 100,
      step: 1,
      style: SliderStyle.OutSet
    })
      .width('100%')
      .height(this.thumbDiameter)
      .trackColor(this.inactiveColor)
      .selectedColor(this.activeColor)
      .blockColor(this.thumbColor)
      .trackThickness(this.trackHeight)
      .blockSize({
        width: this.thumbDiameter,
        height: this.thumbDiameter
      })
      .showSteps(false)
      .showTips(false)
      .onChange((sliderValue: number) => {
        this.value = sliderValue / 100;
      })
  }
}

@Component
struct ProgressBar {
  value: number = 0.42;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(10)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(5)

      Row()
        .width(`${this.value * 100}%`)
        .height(10)
        .backgroundColor(AppColors.primary)
        .borderRadius(5)
    }
    .width('100%')
    .height(10)
  }
}

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.42;

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Column({ space: AppSpacing.lg }) {
        Text('Order Tracking')
          .width('100%')
          .fontSize(AppTypography.display)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
          .textAlign(TextAlign.Start)

        Column({ space: AppSpacing.md }) {
          Text('Order #25491')
            .width('100%')
            .fontSize(AppTypography.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .textAlign(TextAlign.Start)

          Text('Estimated Delivery: 2 days')
            .width('100%')
            .fontSize(AppTypography.body)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.secondary)
            .textAlign(TextAlign.Start)

          ProgressBar({ value: this.progress })

          Row() {
            Text('Processing')
              .fontSize(AppTypography.label)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.secondary)

            Blank()

            Text(`${Math.round(this.progress * 100)}%`)
              .fontSize(AppTypography.label)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.primary)
          }
          .width('100%')
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.large)
        .shadow({
          radius: 8,
          color: '#26000000',
          offsetX: 0,
          offsetY: 4
        })

        Column({ space: AppSpacing.md }) {
          Text('Adjust Progress')
            .width('100%')
            .fontSize(AppTypography.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .textAlign(TextAlign.Center)

          CustomSlider({
            value: $progress,
            activeColor: AppColors.primary,
            inactiveColor: AppColors.surfaceVariant,
            thumbColor: AppColors.primary
          })

          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('Mark as Delivered')
              .fontSize(AppTypography.label)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onPrimary)
          }
          .width('100%')
          .padding({
            top: AppSpacing.md,
            bottom: AppSpacing.md
          })
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.medium)
          .onClick(() => {
            this.progress = 1.0;
          })
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.large)
      }
      .width('100%')
      .padding(AppSpacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}