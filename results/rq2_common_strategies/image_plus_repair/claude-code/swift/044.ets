// AppTokens
class AppColors {
  primary: string = '#FF7043';
  secondary: string = '#FFB84D';
  tertiary: string = '#FFD180';
  background: string = '#FFF2DF';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#FFE0B3';
  outline: string = '#D6CCC9';
  success: string = '#66BA6B';
  warning: string = '#FFC929';
  error: string = '#D42E2E';
  onPrimary: string = '#FFFFFF';
  onSecondary: string = '#3E2723';
  onBackground: string = '#3E2723';
  onSurface: string = '#3E2723';
}

class AppSpacing {
  sm: number = 6;
  md: number = 10;
  lg: number = 16;
  xl: number = 24;
}

class AppShapes {
  small: number = 6;
  medium: number = 10;
  large: number = 16;
}

class AppTokens {
  static Colors: AppColors = new AppColors();
  static Spacing: AppSpacing = new AppSpacing();
  static Shapes: AppShapes = new AppShapes();
}

// Custom Slider Component
@Component
struct CustomSlider {
  @Link value: number;
  private activeColor: string = AppTokens.Colors.primary;
  private inactiveColor: string = AppTokens.Colors.surfaceVariant;
  private thumbColor: string = AppTokens.Colors.primary;

  build() {
    Slider({
      value: this.value,
      min: 0,
      max: 1,
      step: 0.01,
      style: SliderStyle.OutSet,
    })
      .width('100%')
      .blockColor(this.thumbColor)
      .selectedColor(this.activeColor)
      .trackColor(this.inactiveColor)
      .onChange((value: number) => {
        this.value = value;
      })
  }
}

// Progress bar (non-interactive)
@Component
struct ProgressBar {
  private progress: number = 0;
  private trackHeight: number = 10;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row() {
      }
      .width('100%')
      .height(this.trackHeight)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(this.trackHeight / 2)

      Row() {
      }
      .width(`${this.progress * 100}%`)
      .height(this.trackHeight)
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(this.trackHeight / 2)
    }
    .width('100%')
    .height(this.trackHeight)
  }
}

// Order Info Card
@Component
struct OrderInfoCard {
  private progress: number = 0;

  build() {
    Column() {
      Text('Order #25491')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)

      Text('Estimated Delivery: 2 days')
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppTokens.Colors.secondary)
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ top: AppTokens.Spacing.md })

      ProgressBar({ progress: this.progress })
        .margin({ top: AppTokens.Spacing.md })

      Row() {
        Text('Processing')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.secondary)

        Blank()

        Text(`${Math.round(this.progress * 100)}%`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
      }
      .width('100%')
      .margin({ top: AppTokens.Spacing.md })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: 8,
      color: 'rgba(0, 0, 0, 0.15)',
      offsetX: 0,
      offsetY: 4,
    })
  }
}

// Adjust Progress Section
@Component
struct AdjustProgressSection {
  @Link progress: number;

  build() {
    Column() {
      Text('Adjust Progress')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)

      CustomSlider({
        value: $progress,
        activeColor: AppTokens.Colors.primary,
        inactiveColor: AppTokens.Colors.surfaceVariant,
        thumbColor: AppTokens.Colors.primary,
      })
      .margin({ top: AppTokens.Spacing.md })

      Button('Mark as Delivered')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .width('100%')
        .height(40)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .margin({ top: AppTokens.Spacing.md })
        .onClick(() => {
          this.progress = 1.0;
        })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
  }
}

// Root Screen
@Entry
@Component
struct RootScreen {
  @State progress: number = 0.42;

  build() {
    Column() {
      Text('Order Tracking')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)
        .width('100%')
        .textAlign(TextAlign.Start)

      OrderInfoCard({ progress: this.progress })
        .margin({ top: AppTokens.Spacing.lg })

      AdjustProgressSection({ progress: $progress })
        .margin({ top: AppTokens.Spacing.lg })

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.background)
  }
}
