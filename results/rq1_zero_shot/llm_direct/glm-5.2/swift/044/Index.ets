// AppTokens - Design tokens for the application
class AppTokens {
  static readonly Colors: Record<string, ResourceColor> = {
    primary: '#FF7042',
    secondary: '#FFB84D',
    tertiary: '#FFD180',
    background: '#FFF2E0',
    surface: '#FFFFFF',
    surfaceVariant: '#FFE0B2',
    outline: '#D6CCC7',
    success: '#66BA6B',
    warning: '#FFCA29',
    error: '#D42E2E',
    onPrimary: '#FFFFFF',
    onSecondary: '#3D2623',
    onBackground: '#3D2623',
    onSurface: '#3D2623'
  };

  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static readonly Shapes = {
    small: 6.0,
    medium: 10.0,
    large: 16.0
  };

  static readonly Spacing = {
    sm: 6.0,
    md: 10.0,
    lg: 16.0,
    xl: 24.0
  };
}

// CustomSlider - A custom slider component
@Component
export struct CustomSlider {
  @Link value: number;
  @Prop activeColor: ResourceColor;
  @Prop inactiveColor: ResourceColor;
  @Prop thumbColor: ResourceColor;
  private trackHeight: number = 10;
  private thumbDiameter: number = 20;
  private containerWidth: number = 0;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Inactive Track
      Row()
        .width('100%')
        .height(this.trackHeight)
        .backgroundColor(this.inactiveColor)
        .borderRadius(this.trackHeight / 2)

      // Active Track
      Row()
        .width(this.containerWidth > 0 ? `${this.value * 100}%` : '0%')
        .height(this.trackHeight)
        .backgroundColor(this.activeColor)
        .borderRadius(this.trackHeight / 2)

      // Thumb
      Row()
        .width(this.thumbDiameter)
        .height(this.thumbDiameter)
        .backgroundColor(this.thumbColor)
        .borderRadius(this.thumbDiameter / 2)
        .margin({ left: this.containerWidth > 0 ? this.value * this.containerWidth - this.thumbDiameter / 2 : 0 })
        .gesture(
          PanGesture()
            .onActionStart((event: GestureEvent) => {
              this.containerWidth = event.target.area.width;
            })
            .onActionUpdate((event: GestureEvent) => {
              if (this.containerWidth <= 0) {
                this.containerWidth = event.target.area.width;
              }
              let dragLocation = event.fingerList[0].localX;
              let newValue = Math.min(Math.max(0, dragLocation / this.containerWidth), 1);
              this.value = newValue;
            })
        )
    }
    .width('100%')
    .height(this.thumbDiameter)
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.containerWidth = newValue.width as number;
    })
  }
}

// RootScreen - Main screen of the application
@Entry
@Component
struct RootScreen {
  @State progress: number = 0.42;

  build() {
    Stack() {
      Column({ space: AppTokens.Spacing.lg }) {
        // Title
        Text('Order Tracking')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        // Order Info Card
        Column({ space: AppTokens.Spacing.md }) {
          Text('Order #25491')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)

          Text('Estimated Delivery: 2 days')
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.secondary)
            .width('100%')
            .textAlign(TextAlign.Start)

          // Progress Bar
          Stack({ alignContent: Alignment.Start }) {
            Row()
              .width('100%')
              .height(10)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(5)

            Row()
              .width(`${this.progress * 100}%`)
              .height(10)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(5)
          }
          .width('100%')
          .height(10)

          // Progress Text
          Row() {
            Text('Processing')
              .fontSize(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .fontColor(AppTokens.Colors.secondary)

            Blank()

            Text(`${Math.round(this.progress * 100)}%`)
              .fontSize(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .fontColor(AppTokens.Colors.primary)
          }
          .width('100%')
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: 8,
          color: '#26000000',
          offsetX: 0,
          offsetY: 4
        })

        // Adjust Progress Card
        Column({ space: AppTokens.Spacing.md }) {
          Text('Adjust Progress')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Center)

          CustomSlider({
            value: $progress,
            activeColor: AppTokens.Colors.primary,
            inactiveColor: AppTokens.Colors.surfaceVariant,
            thumbColor: AppTokens.Colors.primary
          })

          Button('Mark as Delivered')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .height(40)
            .width('100%')
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.progress = 1.0;
            })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}