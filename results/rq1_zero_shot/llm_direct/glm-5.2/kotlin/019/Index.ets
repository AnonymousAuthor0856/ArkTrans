import { LengthMetrics, LengthMetricsUnit } from '@ohos.arkui';

const NAME = '019SubtitleEditoren';
const UI_TYPE = 'Media';
const STYLE_THEME = 'Clay Morph';
const LANG = 'en';
const BASELINE_SIZE = '720x1280';

class AppTokens {
  static readonly Colors = {
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
  };
  static readonly TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  };
  static readonly Shapes = {
    small: 8,
    medium: 14,
    large: 22,
  };
  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };
  static readonly ElevationMapping = {
    level1: { elevation: 4, radius: 8, dy: 2, opacity: 0.14 },
    level2: { elevation: 8, radius: 12, dy: 6, opacity: 0.18 },
  };
}

@Entry
@Component
struct RootScreen {
  @State fontSize: number = 24;
  @State syncProgress: number = 0.3;

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Subtitle Editor')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding({ top: 12, bottom: 12, left: 16, right: 16 })
      .backgroundColor(AppTokens.Colors.background);

      // Content
      Column() {
        // Sample Subtitle Box
        Column() {
          Text('Sample Subtitle Line')
            .fontSize(this.fontSize)
            .fontColor(AppTokens.Colors.onSurface)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(200)
        .borderRadius(AppTokens.Shapes.large)
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center);

        // Font Size Label
        Text(`Font Size: ${this.fontSize}sp`)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.sm });

        // Font Size Slider
        Slider({
          value: this.fontSize,
          min: 16,
          max: 48,
          step: 1,
          style: SliderStyle.OutSet
        })
          .selectedColor(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .blockColor(AppTokens.Colors.secondary)
          .width('100%')
          .onChange((value: number) => {
            this.fontSize = Math.round(value);
          });

        // Sync Progress Label
        Text('Sync Progress')
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.sm });

        // Linear Progress Indicator
        Progress({ value: this.syncProgress * 100, type: ProgressType.Linear })
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .width('100%')
          .height(6)
          .borderRadius(3);

        // Sync Buttons Row
        Row() {
          Button('Sync +')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0);
            });

          Blank().width(AppTokens.Spacing.md);

          Button('Sync -')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSecondary)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.medium)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0);
            });
        }
        .width('100%')
        .margin({ top: AppTokens.Spacing.lg });
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.surfaceVariant, 0],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.surface, 1.0]
        ]
      });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}