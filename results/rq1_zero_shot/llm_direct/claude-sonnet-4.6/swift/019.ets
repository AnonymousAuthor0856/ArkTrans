import { router } from '@kit.ArkUI';

// MARK: - AppTokens
const AppTokens = {
  Colors: {
    primary: '#8B5CF6',
    secondary: '#D946EF',
    tertiary: '#3B82F6',
    background: '#F9F5FF',
    surface: '#FFFFFF',
    surfaceVariant: '#F1E9FE',
    outline: '#E3D7FE',
    success: '#22C55E',
    warning: '#FACC15',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E',
  },
  Typography: {
    displaySize: 48,
    displayWeight: FontWeight.Bold,
    titleSize: 18,
    titleWeight: FontWeight.Medium,
    bodySize: 14,
    bodyWeight: FontWeight.Normal,
    labelSize: 42,
    labelWeight: FontWeight.Medium,
  },
  Shapes: {
    small: 8,
    medium: 14,
    large: 22,
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  },
  Elevation: {
    level1: { radius: 4, dy: 2, opacity: 0.14 },
    level2: { radius: 8, dy: 6, opacity: 0.18 },
  },
};

@Entry
@Component
struct RootScreen {
  @State fontSize: number = 23.0;
  @State syncProgress: number = 0.3;

  build() {
    Column() {
      // TopAppBar equivalent
      Row() {
        Text('Subtitle Editor')
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(AppTokens.Typography.titleWeight)
          .fontColor(AppTokens.Colors.onBackground)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // Main content area
      Column({ space: AppTokens.Spacing.xl }) {

        // Surface card with subtitle text
        Column() {
          Text('Sample Subtitle Line')
            .fontSize(this.fontSize)
            .fontColor(AppTokens.Colors.onSurface)
            .textAlign(TextAlign.Center)
            .width('100%')
            .height('100%')
        }
        .width('100%')
        .height(200)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .shadow({
          radius: AppTokens.Elevation.level2.radius,
          color: `rgba(0,0,0,${AppTokens.Elevation.level2.opacity})`,
          offsetX: 0,
          offsetY: AppTokens.Elevation.level2.dy,
        })

        // Font size label
        Text(`Font Size: ${Math.round(this.fontSize)}sp`)
          .fontSize(AppTokens.Typography.bodySize)
          .fontWeight(AppTokens.Typography.bodyWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')

        // Slider for font size
        Slider({
          value: this.fontSize,
          min: 16,
          max: 48,
          style: SliderStyle.OutSet,
        })
          .selectedColor(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .blockColor(AppTokens.Colors.primary)
          .width('100%')
          .onChange((value: number) => {
            this.fontSize = value;
          })

        // Sync progress label
        Text('Sync Progress')
          .fontSize(AppTokens.Typography.bodySize)
          .fontWeight(AppTokens.Typography.bodyWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')

        // Linear progress indicator
        Progress({
          value: this.syncProgress * 100,
          total: 100,
          type: ProgressType.Linear,
        })
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .style({ strokeWidth: 6 })
          .width('100%')

        // Buttons row
        Row({ space: AppTokens.Spacing.md }) {
          // Sync + Button
          Button() {
            Text('Sync +')
              .fontSize(AppTokens.Typography.titleSize)
              .fontWeight(AppTokens.Typography.titleWeight)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .height(48)
          .layoutWeight(1)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => {
            this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0);
          })

          // Sync - Button
          Button() {
            Text('Sync -')
              .fontSize(AppTokens.Typography.titleSize)
              .fontWeight(AppTokens.Typography.titleWeight)
              .fontColor(AppTokens.Colors.onSecondary)
          }
          .height(48)
          .layoutWeight(1)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => {
            this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0);
          })
        }
        .width('100%')
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokens.Colors.surfaceVariant, 0.0],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.surface, 1.0],
        ],
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}