import { window } from '@kit.ArkUI';

class AppColors {
  static readonly primary: string = '#FF7042';
  static readonly secondary: string = '#FFB84D';
  static readonly tertiary: string = '#FFD180';
  static readonly background: string = '#FFF2E0';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFE0B3';
  static readonly outline: string = '#D6CCC7';
  static readonly success: string = '#66BA6B';
  static readonly warning: string = '#FFC929';
  static readonly error: string = '#D42E2E';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#3D2624';
  static readonly onBackground: string = '#3D2624';
  static readonly onSurface: string = '#3D2624';
  static readonly shadow: string = '#26000000';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
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

@Entry
@Component
struct RootScreen {
  @State progress: number = 42;

  aboutToAppear(): void {
    try {
      window.getLastWindow(getContext(this))
        .then((win: window.Window) => {
          win.setWindowLayoutFullScreen(true);
          win.setWindowSystemBarEnable([]);
        })
        .catch((err: Error) => {
          console.error(`window setup failed: ${err.message}`);
        });
    } catch (err) {
      console.error(`window setup failed: ${(err as Error).message}`);
    }
  }

  @Builder
  ProgressBar(widthPercent: number) {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(10)
        .borderRadius(5)
        .backgroundColor(AppColors.surfaceVariant)

      Row()
        .width(`${widthPercent}%`)
        .height(10)
        .borderRadius(5)
        .backgroundColor(AppColors.primary)
    }
    .width('100%')
    .height(10)
  }

  @Builder
  OrderCard() {
    Column({ space: AppSpacing.md }) {
      Text('Order #25491')
        .fontSize(AppTypography.titleSize)
        .fontWeight(AppTypography.titleWeight)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)

      Text('Estimated Delivery: 2 days')
        .fontSize(AppTypography.bodySize)
        .fontWeight(AppTypography.bodyWeight)
        .fontColor(AppColors.secondary)
        .width('100%')
        .textAlign(TextAlign.Start)

      this.ProgressBar(this.progress)

      Row() {
        Text('Processing')
          .fontSize(AppTypography.labelSize)
          .fontWeight(AppTypography.labelWeight)
          .fontColor(AppColors.secondary)

        Blank()

        Text(`${Math.round(this.progress).toString()}%`)
          .fontSize(AppTypography.labelSize)
          .fontWeight(AppTypography.labelWeight)
          .fontColor(AppColors.primary)
      }
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: 8,
      color: AppColors.shadow,
      offsetX: 0,
      offsetY: 4
    })
  }

  @Builder
  AdjustCard() {
    Column({ space: AppSpacing.md }) {
      Text('Adjust Progress')
        .fontSize(AppTypography.titleSize)
        .fontWeight(AppTypography.titleWeight)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)

      Slider({
        value: this.progress,
        min: 0,
        max: 100,
        step: 1,
        style: SliderStyle.OutSet,
        direction: Axis.Horizontal,
        reverse: false
      })
        .width('100%')
        .blockColor(AppColors.primary)
        .trackColor(AppColors.surfaceVariant)
        .selectedColor(AppColors.primary)
        .trackThickness(10)
        .blockSize({ width: 20, height: 20 })
        .showTips(false)
        .onChange((value: number, mode: SliderChangeMode) => {
          this.progress = value;
        })

      Button('Mark as Delivered')
        .type(ButtonType.Normal)
        .fontSize(AppTypography.labelSize)
        .fontWeight(AppTypography.labelWeight)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .width('100%')
        .height(40)
        .onClick(() => {
          this.progress = 100;
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: 8,
      color: AppColors.shadow,
      offsetX: 0,
      offsetY: 4
    })
  }

  build() {
    Column({ space: AppSpacing.lg }) {
      Text('Order Tracking')
        .fontSize(AppTypography.displaySize)
        .fontWeight(AppTypography.displayWeight)
        .fontColor(AppColors.onBackground)
        .width('100%')
        .textAlign(TextAlign.Start)

      this.OrderCard()

      this.AdjustCard()
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}