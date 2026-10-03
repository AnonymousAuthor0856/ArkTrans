import { display } from '@kit.ArkUI';

@Entry
@Component
struct MainPage {
  @State spending: number = 500;
  private goal: number = 1000;

  // AppTokens
  private readonly colors = {
    primary: '#06B6D4',
    secondary: '#3B82F6',
    tertiary: '#8B5CF6',
    background: '#F0F9FF',
    surface: '#FFFFFF',
    surfaceVariant: '#E0F2FE',
    outline: '#BAE6FD',
    success: '#22C55E',
    warning: '#FACC15',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#0F172A',
    onSurface: '#0F172A'
  };

  private readonly spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };

  private readonly shapes = {
    small: 6,
    medium: 12,
    large: 20
  };

  private readonly typography = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  private readonly elevation = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 }
  };

  @Builder
  TopBar() {
    Row() {
      Text('Bill Calendar')
        .fontSize(this.typography.display.fontSize)
        .fontWeight(this.typography.display.fontWeight)
        .fontColor(this.colors.onSurface)
        .textAlign(TextAlign.Center)
        .width('100%')
    }
    .width('100%')
    .height(56)
    .backgroundColor(this.colors.background)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SpendingCard() {
    Column({ space: this.spacing.lg }) {
      Text('Current Spending')
        .fontSize(this.typography.title.fontSize)
        .fontWeight(this.typography.title.fontWeight)
        .fontColor(this.colors.primary)

      Text(`$${Math.floor(this.spending)} / $${this.goal}`)
        .fontSize(this.typography.display.fontSize)
        .fontWeight(this.typography.display.fontWeight)
        .fontColor(this.colors.onSurface)

      Progress({ value: Math.min(Math.max(this.spending / this.goal, 0), 1), total: 1 })
        .width('100%')
        .height(8)
        .color(this.colors.primary)
        .backgroundColor(this.colors.surfaceVariant)
        .style({ strokeWidth: 8 })
    }
    .width('100%')
    .height(160)
    .padding(this.spacing.lg)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#E6FFFFFF')
    .borderRadius(this.shapes.large)
    .shadow({
      radius: this.elevation.level2.radius,
      color: `rgba(0,0,0,${this.elevation.level2.opacity})`,
      offsetY: this.elevation.level2.dy
    })
  }

  @Builder
  SliderSection() {
    Column({ space: this.spacing.lg }) {
      Text('Adjust Spending')
        .fontSize(this.typography.title.fontSize)
        .fontWeight(this.typography.title.fontWeight)
        .fontColor(this.colors.onSurface)

      Slider({
        value: this.spending,
        min: 0,
        max: 2000,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .blockColor(this.colors.secondary)
        .selectedColor(this.colors.primary)
        .trackColor(this.colors.surfaceVariant)
        .onChange((value: number) => {
          this.spending = value;
        })

      Button('Reset')
        .width('100%')
        .height(48)
        .fontSize(this.typography.title.fontSize)
        .fontWeight(this.typography.title.fontWeight)
        .fontColor(this.colors.onTertiary)
        .backgroundColor(this.colors.tertiary)
        .borderRadius(this.shapes.medium)
        .onClick(() => {
          this.spending = 0;
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }

  build() {
    Column() {
      this.TopBar()

      Column({ space: this.spacing.lg }) {
        this.SpendingCard()
        this.SliderSection()
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: this.spacing.lg,
        right: this.spacing.lg,
        top: this.spacing.lg,
        bottom: this.spacing.lg
      })
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#4D3B82F6', 0.0],
          [this.colors.background, 0.5],
          ['#3306B6D4', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
  }
}