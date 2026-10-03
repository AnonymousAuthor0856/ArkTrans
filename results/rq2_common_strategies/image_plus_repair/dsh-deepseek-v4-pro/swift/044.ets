// SwiftUI -> ArkTS 翻译：主题令牌（颜色 / 字体 / 形状 / 间距）
interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onBackground: string;
  onSurface: string;
}

interface TextStyleToken {
  fontSize: number;
  fontWeight: FontWeight;
}

interface TypographyTokens {
  display: TextStyleToken;
  title: TextStyleToken;
  body: TextStyleToken;
  label: TextStyleToken;
}

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

interface SpacingTokens {
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

class AppTokens {
  static readonly Colors: ColorTokens = {
    primary: '#FF7042',
    secondary: '#FFB84D',
    tertiary: '#FFD180',
    background: '#FFF2E0',
    surface: '#FFFFFF',
    surfaceVariant: '#FFE0B3',
    outline: '#D6CCC7',
    success: '#66BA6B',
    warning: '#FFC929',
    error: '#D42E2E',
    onPrimary: '#FFFFFF',
    onSecondary: '#3D2624',
    onBackground: '#3D2624',
    onSurface: '#3D2624',
  };

  static readonly TypographyTokens: TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Regular },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  };

  static readonly Shapes: ShapeTokens = {
    small: 6.0,
    medium: 10.0,
    large: 16.0,
  };

  static readonly Spacing: SpacingTokens = {
    sm: 6.0,
    md: 10.0,
    lg: 16.0,
    xl: 24.0,
  };
}

@Component
struct CustomSlider {
  @Link value: number;
  activeColor: string = '#FF7042';
  inactiveColor: string = '#FFE0B3';
  thumbColor: string = '#FF7042';
  trackHeight: number = 10;
  thumbDiameter: number = 20;
  @State trackWidth: number = 0;
  @State dragStartValue: number = 0;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Rect()
        .width('100%')
        .height(this.trackHeight)
        .radius(this.trackHeight / 2)
        .fill(this.inactiveColor)

      Rect()
        .width(this.trackWidth * this.value)
        .height(this.trackHeight)
        .radius(this.trackHeight / 2)
        .fill(this.activeColor)

      Circle()
        .width(this.thumbDiameter)
        .height(this.thumbDiameter)
        .fill(this.thumbColor)
        .offset({ x: this.trackWidth * this.value - this.thumbDiameter / 2 })
        .gesture(
          PanGesture({ direction: PanDirection.Horizontal })
            .onActionStart(() => {
              this.dragStartValue = this.value;
            })
            .onActionUpdate((event: GestureEvent) => {
              let delta = event.offsetX / this.trackWidth;
              let newValue = this.dragStartValue + delta;
              newValue = Math.max(0, Math.min(1, newValue));
              this.value = newValue;
            })
        )
    }
    .width('100%')
    .height(this.thumbDiameter)
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.trackWidth = Number(newValue.width);
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.42; // 与原图42%进度保持一致

  build() {
    Stack() {
      Column({ space: AppTokens.Spacing.lg }) {
        // 标题：仅跟随容器统一内边距，无额外顶部间距
        Text('Order Tracking')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        // 订单信息卡片（与原 Kotlin Card 布局一致）
        Column({ space: AppTokens.Spacing.md }) {
          Text('Order #25491')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)

          Text('Estimated Delivery: 2 days')
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.secondary)
            .width('100%')
            .textAlign(TextAlign.Start)

          // 进度条（与原 Kotlin LinearProgressIndicator 尺寸一致）
          Stack({ alignContent: Alignment.Start }) {
            Rect()
              .width('100%')
              .height(10)
              .radius(5)
              .fill(AppTokens.Colors.surfaceVariant)

            Rect()
              .width(this.progress * 100 + '%')
              .height(10)
              .radius(5)
              .fill(AppTokens.Colors.primary)
          }
          .width('100%')
          .height(10)

          // 进度文本（左右对齐，与原图一致）
          Row() {
            Text('Processing')
              .fontSize(AppTokens.TypographyTokens.label.fontSize)
              .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
              .fontColor(AppTokens.Colors.secondary)

            Blank() // 用 Blank 确保左右对齐，比 width('100%') 更精准

            Text(Math.floor(this.progress * 100) + '%')
              .fontSize(AppTokens.TypographyTokens.label.fontSize)
              .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
              .fontColor(AppTokens.Colors.primary)
          }
          .width('100%')
        }
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({ radius: 8, color: '#26000000', offsetX: 0, offsetY: 4 }) // 与原 Kotlin ElevationMapping.level2 阴影参数一致

        // 进度调整区域（与原 Kotlin Box 布局一致）
        Column({ space: AppTokens.Spacing.md }) {
          Text('Adjust Progress')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Center)

          CustomSlider({
            value: $progress,
            activeColor: AppTokens.Colors.primary,
            inactiveColor: AppTokens.Colors.surfaceVariant,
            thumbColor: AppTokens.Colors.primary,
          })

          Button('Mark as Delivered')
            .type(ButtonType.Normal)
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
            .fontColor(AppTokens.Colors.onPrimary)
            .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
            .width('100%')
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.progress = 1.0; // 点击后进度设为100%（已送达）
            })
        }
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM]) // 隐藏状态栏，避免额外留白
  }
}
