// MARK: - AppTokens (原子级对应 Kotlin 的 AppTokens)

interface FontStyle {
  size: number;
  weight: FontWeight;
}

class AppTokens {
  static readonly Colors: Record<string, string> = {
    primary: '#2563EB',
    secondary: '#38BDF8',
    tertiary: '#60A5FA',
    background: '#F8FAFC',
    surface: '#FFFFFF',
    surfaceVariant: '#E2E8F0',
    outline: '#CBD5E1',
    onPrimary: '#FFFFFF',
    onSecondary: '#0F172A',
    onTertiary: '#FFFFFF',
    onBackground: '#0F172A',
    onSurface: '#1E293B',
  };

  static readonly Typography: Record<string, FontStyle> = {
    display: { size: 24, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Semibold },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Regular },
  };

  static readonly Shapes: Record<string, number> = {
    small: 6,
    medium: 10,
    large: 14,
  };

  static readonly Spacing: Record<string, number> = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    buttonContentHorizontal: 16,
    buttonContentVertical: 8,
  };
}

@Component
struct MarkerBox {
  unit: string = '';
  value: string = '';
  active: boolean = false;

  build() {
    Column() {
      Text(this.unit)
        .fontSize(AppTokens.Typography.headline.size)
        .fontWeight(AppTokens.Typography.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)
      Text(this.value)
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.md)
    .width('100%')
    .height(80)
    .backgroundColor(this.active ? '#4D38BDF8' : AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

@Component
struct MapArea {
  selected: string = '';

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text('Unit Map Visualization')
        .fontSize(AppTokens.Typography.headline.size)
        .fontWeight(AppTokens.Typography.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)
      Text('Active Unit: ' + this.selected)
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(240)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .margin(AppTokens.Spacing.lg)
  }
}

@Component
struct RootScreen {
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed'];
  @State active: string = 'Length';

  build() {
    Column({ space: AppTokens.Spacing.lg }) {
      Text('Unit Converter')
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .fontColor(AppTokens.Colors.onBackground)

      MapArea({ selected: this.active })

      ForEach(this.markers, (marker: string) => {
        MarkerBox({ unit: marker, value: 'Tap to convert', active: this.active === marker })
      }, (marker: string) => marker)

      Blank().height(AppTokens.Spacing.md)

      Row({ space: AppTokens.Spacing.md }) {
        ForEach(this.markers, (marker: string) => {
          Button() {
            Text(marker)
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(this.active === marker ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
              .padding({
                left: AppTokens.Spacing.buttonContentHorizontal,
                right: AppTokens.Spacing.buttonContentHorizontal,
                top: AppTokens.Spacing.buttonContentVertical,
                bottom: AppTokens.Spacing.buttonContentVertical
              })
          }
          .backgroundColor(this.active === marker ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)
          .onClick(() => {
            this.active = marker;
          })
        }, (marker: string) => marker)
      }
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#2638BDF8', 0.0],
        ['#262563EB', 1.0]
      ]
    })
  }
}

@Entry
@Component
struct Index {
  build() {
    // statusBarHidden(true) has no direct ArkUI declarative equivalent.
    RootScreen()
  }
}
