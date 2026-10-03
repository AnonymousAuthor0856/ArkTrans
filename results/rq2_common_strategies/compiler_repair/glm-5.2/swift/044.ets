// Index.ets
interface ColorsType {
  primary: ResourceColor;
  secondary: ResourceColor;
  tertiary: ResourceColor;
  background: ResourceColor;
  surface: ResourceColor;
  surfaceVariant: ResourceColor;
  outline: ResourceColor;
  success: ResourceColor;
  warning: ResourceColor;
  error: ResourceColor;
  onPrimary: ResourceColor;
  onSecondary: ResourceColor;
  onBackground: ResourceColor;
  onSurface: ResourceColor;
}

interface TypographyItem {
  size: number;
  weight: FontWeight;
}

interface TypographyType {
  display: TypographyItem;
  title: TypographyItem;
  body: TypographyItem;
  label: TypographyItem;
}

interface ShapesType {
  small: number;
  medium: number;
  large: number;
}

interface SpacingType {
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

class AppTokens {
  static Colors: ColorsType = {
    primary: '#FF7042',
    secondary: '#FFB84D',
    tertiary: '#FFD180',
    background: '#FFF2E0',
    surface: '#FFFFFF',
    surfaceVariant: '#FFE0B3',
    outline: '#D6CCC7',
    success: '#66BA6B',
    warning: '#FFCA29',
    error: '#D42E2E',
    onPrimary: '#FFFFFF',
    onSecondary: '#3D2624',
    onBackground: '#3D2624',
    onSurface: '#3D2624'
  };

  static Typography: TypographyType = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes: ShapesType = {
    small: 6.0,
    medium: 10.0,
    large: 16.0
  };

  static Spacing: SpacingType = {
    sm: 6.0,
    md: 10.0,
    lg: 16.0,
    xl: 24.0
  };
}

@Component
export struct CustomSlider {
  @Link value: number;
  activeColor: ResourceColor = AppTokens.Colors.primary;
  inactiveColor: ResourceColor = AppTokens.Colors.surfaceVariant;
  thumbColor: ResourceColor = AppTokens.Colors.primary;
  trackHeight: number = 10;
  thumbDiameter: number = 20;
  private sliderWidth: number = 0;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(this.trackHeight)
        .backgroundColor(this.inactiveColor)
        .borderRadius(this.trackHeight / 2)

      Row()
        .width(`${this.value * 100}%`)
        .height(this.trackHeight)
        .backgroundColor(this.activeColor)
        .borderRadius(this.trackHeight / 2)

      Row()
        .width(this.thumbDiameter)
        .height(this.thumbDiameter)
        .backgroundColor(this.thumbColor)
        .borderRadius(this.thumbDiameter / 2)
        .margin({ left: `${this.value * 100}%` })
        .markAnchor({ x: this.thumbDiameter / 2, y: this.thumbDiameter / 2 })
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              if (this.sliderWidth > 0) {
                const dragLocation = event.fingerList[0].localX;
                let newValue = dragLocation / this.sliderWidth;
                newValue = Math.min(1, Math.max(0, newValue));
                this.value = newValue;
              }
            })
        )
    }
    .height(this.thumbDiameter)
    .width('100%')
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.sliderWidth = newValue.width as number;
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.42;

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column({ space: AppTokens.Spacing.lg }) {
        Text('Order Tracking')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

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
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.15)', offsetX: 0, offsetY: 4 })

        Column({ space: AppTokens.Spacing.md }) {
          Text('Adjust Progress')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Center)

          CustomSlider({ value: $progress })
            .width('100%')

          Button('Mark as Delivered')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .width('100%')
            .height(40)
            .onClick(() => {
              this.progress = 1.0;
            })
        }
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
    .alignContent(Alignment.Top)
  }
}