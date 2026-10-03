// AppTokens
class AppTokens {
  static Colors = {
    primary: '#FF7043',
    secondary: '#FFB84D',
    tertiary: '#FFD180',
    background: '#FFF2DF',
    surface: '#FFFFFF',
    surfaceVariant: '#FFE0B3',
    outline: '#D6CCC9',
    success: '#66BA6B',
    warning: '#FFC929',
    error: '#D42E2E',
    onPrimary: '#FFFFFF',
    onSecondary: '#3E2723',
    onBackground: '#3E2723',
    onSurface: '#3E2723',
  };

  static Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
  };

  static Shapes = {
    small: 6,
    medium: 10,
    large: 16,
  };
}

// Custom Slider Component (wraps built-in Slider with custom styling)
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
