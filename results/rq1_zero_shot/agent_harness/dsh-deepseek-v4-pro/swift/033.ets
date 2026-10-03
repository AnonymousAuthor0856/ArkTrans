// 033.ets - translated from 033.swift (Bill Calendar)

// MARK: - AppTokens

const CLEAR: string = '#00000000';

class AppTokensColors {
  static readonly primary: string = '#06B6D4';
  static readonly secondary: string = '#3B82F6';
  static readonly tertiary: string = '#8B5CF6';
  static readonly background: string = '#F0F9FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E0F2FE';
  static readonly outline: string = '#BAE6FD';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#FACC15';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#0F172A';
}

class AppTokensTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppTokensShapes {
  static readonly small: number = 6;
  static readonly medium: number = 12;
  static readonly large: number = 20;
}

class AppTokensSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokensElevation {
  static readonly level1: ShadowSpec = { elevation: 2, radius: 4, dy: 2, opacity: 0.12 };
  static readonly level2: ShadowSpec = { elevation: 6, radius: 8, dy: 4, opacity: 0.18 };
}

class AppTokens {
  static readonly Colors = AppTokensColors;
  static readonly TypographyTokens = AppTokensTypography;
  static readonly Shapes = AppTokensShapes;
  static readonly Spacing = AppTokensSpacing;
  static readonly ElevationMapping = AppTokensElevation;
}

// MARK: - RootScreen

@Component
struct RootScreen {
  @State spending: number = 500.0;
  readonly goal: number = 1000.0;

  progressPercent(): string {
    const frac = this.goal > 0 ? this.spending / this.goal : 0;
    const pct = Math.min(Math.max(frac, 0), 1) * 100;
    return pct.toString() + '%';
  }

  build() {
    Column({ space: 0 }) {
      // Top Bar
      Stack() {
        Column()
          .width('100%')
          .height(56)
          .backgroundColor(AppTokens.Colors.background)
        Text('Bill Calendar')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(AppTokens.TypographyTokens.displayWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)

      // Main content area
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Surface Card
          Stack() {
            Column()
              .width('100%')
              .height(160)
              .backgroundColor('rgba(255,255,255,0.9)')
              .borderRadius(AppTokens.Shapes.large)
              .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: 'rgba(0,0,0,0.18)', offsetX: 0, offsetY: AppTokens.ElevationMapping.level2.dy })

            Column({ space: 0 }) {
              Text('Current Spending')
                .fontSize(AppTokens.TypographyTokens.titleSize)
                .fontWeight(AppTokens.TypographyTokens.titleWeight)
                .fontColor(AppTokens.Colors.primary)

              Text('$' + Math.floor(this.spending) + ' / $' + Math.floor(this.goal))
                .fontSize(AppTokens.TypographyTokens.displaySize)
                .fontWeight(AppTokens.TypographyTokens.displayWeight)
                .fontColor(AppTokens.Colors.onSurface)

              // LinearProgressIndicator
              Stack({ alignContent: Alignment.Start }) {
                Row()
                  .width('100%')
                  .height(8)
                  .backgroundColor(AppTokens.Colors.surfaceVariant)
                  .borderRadius(4)
                Row()
                  .width(this.progressPercent())
                  .height(8)
                  .backgroundColor(AppTokens.Colors.primary)
                  .borderRadius(4)
              }
              .width('100%')
              .height(8)
            }
            .width('100%')
            .height('100%')
            .padding(AppTokens.Spacing.lg)
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .width('100%')
          .height(160)

          Text('Adjust Spending')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(AppTokens.Colors.onSurface)

          // Slider
          Slider({ value: this.spending, min: 0, max: 2000, step: 1, style: SliderStyle.OutSet })
            .selectedColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .blockColor(AppTokens.Colors.secondary)
            .width('100%')
            .onChange((value: number) => {
              this.spending = value;
            })

          // Button
          Button('Reset')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(AppTokens.Colors.onTertiary)
            .width('100%')
            .height(48)
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.spending = 0.0;
            })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .linearGradient({
        angle: 180,
        colors: [['rgba(59,130,246,0.3)', 0.0], [AppTokens.Colors.background, 0.5], ['rgba(6,182,212,0.2)', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// MARK: - App Entry Point

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}
