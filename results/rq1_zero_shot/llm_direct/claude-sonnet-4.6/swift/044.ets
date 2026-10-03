import { curves } from '@kit.ArkUI';

// Design tokens
const AppColors = {
  primary: '#FF7043',
  secondary: '#FFB84D',
  tertiary: '#FFD180',
  background: '#FFF3E0',
  surface: '#FFFFFF',
  surfaceVariant: '#FFE0B2',
  outline: '#D6CCC7',
  success: '#66BB6A',
  warning: '#FFCA28',
  error: '#D42E2E',
  onPrimary: '#FFFFFF',
  onSecondary: '#3D2623',
  onBackground: '#3D2623',
  onSurface: '#3D2623',
};

const AppSpacing = {
  sm: 6,
  md: 10,
  lg: 16,
  xl: 24,
};

const AppShapes = {
  small: 6,
  medium: 10,
  large: 16,
};

@Component
struct CustomSlider {
  @Link value: number;
  activeColor: string = AppColors.primary;
  inactiveColor: string = AppColors.surfaceVariant;
  thumbColor: string = AppColors.primary;
  trackHeight: number = 10;
  thumbDiameter: number = 20;
  private sliderWidth: number = 0;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Inactive track
      Row()
        .width('100%')
        .height(this.trackHeight)
        .borderRadius(this.trackHeight / 2)
        .backgroundColor(this.inactiveColor)

      // Active track
      Row()
        .width(`${this.value * 100}%`)
        .height(this.trackHeight)
        .borderRadius(this.trackHeight / 2)
        .backgroundColor(this.activeColor)

      // Thumb
      Row()
        .width(this.thumbDiameter)
        .height(this.thumbDiameter)
        .borderRadius(this.thumbDiameter / 2)
        .backgroundColor(this.thumbColor)
        .offset({ x: `${this.value * 100}%` })
        .translate({ x: -this.thumbDiameter / 2 })
    }
    .width('100%')
    .height(this.thumbDiameter)
    .onAreaChange((_oldVal, newVal) => {
      this.sliderWidth = newVal.width as number;
    })
    .gesture(
      PanGesture()
        .onActionStart((event: GestureEvent) => {
          if (this.sliderWidth > 0) {
            const x = event.offsetX;
            const newValue = Math.min(Math.max(0, x / this.sliderWidth), 1);
            this.value = newValue;
          }
        })
        .onActionUpdate((event: GestureEvent) => {
          if (this.sliderWidth > 0) {
            const x = event.offsetX;
            const newValue = Math.min(Math.max(0, x / this.sliderWidth), 1);
            this.value = newValue;
          }
        })
    )
  }
}

@Entry
@Component
struct RootScreen {
  @State private progress: number = 0.42;

  build() {
    Stack() {
      // Background
      Row()
        .width('100%')
        .height('100%')
        .backgroundColor(AppColors.background)

      // Main content
      Column({ space: AppSpacing.lg }) {
        // Title
        Text('Order Tracking')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        // Order info card
        Column({ space: AppSpacing.md }) {
          Text('Order #25491')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)

          Text('Estimated Delivery: 2 days')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.secondary)
            .width('100%')
            .textAlign(TextAlign.Start)

          // Progress bar
          Stack({ alignContent: Alignment.Start }) {
            Row()
              .width('100%')
              .height(10)
              .borderRadius(5)
              .backgroundColor(AppColors.surfaceVariant)

            Row()
              .width(`${this.progress * 100}%`)
              .height(10)
              .borderRadius(5)
              .backgroundColor(AppColors.primary)
          }
          .width('100%')
          .height(10)

          // Progress text row
          Row() {
            Text('Processing')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.secondary)

            Blank()

            Text(`${Math.round(this.progress * 100)}%`)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.primary)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .padding(AppSpacing.lg)
        .width('100%')
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.large)
        .shadow({
          radius: 8,
          color: '#26000000',
          offsetX: 0,
          offsetY: 4,
        })

        // Adjust progress card
        Column({ space: AppSpacing.md }) {
          Text('Adjust Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Center)

          CustomSlider({
            value: $progress,
            activeColor: AppColors.primary,
            inactiveColor: AppColors.surfaceVariant,
            thumbColor: AppColors.primary,
          })

          Button('Mark as Delivered')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .width('100%')
            .height(undefined)
            .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.medium)
            .onClick(() => {
              this.progress = 1.0;
            })
        }
        .padding(AppSpacing.lg)
        .width('100%')
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.large)
      }
      .padding(AppSpacing.lg)
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
  }
}