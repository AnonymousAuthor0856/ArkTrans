// MacroTrainer.ets
// ArkTS conversion of the Kotlin Compose "MacroTrainer" UI.

// --- Design Tokens ---
class DesignTokens {
  static readonly Colors = {
    primary: '#7C4DFF',
    secondary: '#08D6FF',
    tertiary: '#FF8E3C',
    background: '#05030A',
    surface: '#0D0616',
    surfaceVariant: '#1A0F2C',
    outline: '#3A2759',
    success: '#56F0A6',
    warning: '#FFC857',
    error: '#FF5B7A',
    onPrimary: '#05030A',
    onSecondary: '#05030A',
    onTertiary: '#120601',
    onBackground: '#F4ECFF',
    onSurface: '#F8F4FF',
    onSurface70: 'rgba(248, 244, 255, 0.7)',
    surface95: 'rgba(13, 6, 22, 0.95)',
    surfaceVariant90: 'rgba(26, 15, 44, 0.9)'
  };

  static readonly Typography = {
    display: { fontSize: 32, fontWeight: FontWeight.Bold, lineHeight: 38, letterSpacing: 0 },
    headline: { fontSize: 22, fontWeight: FontWeight.Medium, lineHeight: 28, letterSpacing: 0.1 },
    title: { fontSize: 16, fontWeight: FontWeight.Medium, lineHeight: 22, letterSpacing: 0.2 },
    body: { fontSize: 14, fontWeight: FontWeight.Normal, lineHeight: 20, letterSpacing: 0.2 },
    label: { fontSize: 12, fontWeight: FontWeight.Medium, lineHeight: 16, letterSpacing: 0.3 }
  };

  static readonly Shapes = {
    small: 8,
    medium: 18,
    large: 28
  };

  static readonly Spacing = {
    xxs: 4,
    xs: 8,
    sm: 12,
    md: 16,
    lg: 20,
    xl: 28,
    xxl: 40,
    xxxl: 56
  };

  static readonly Elevation = {
    level1: 2,
    level2: 6,
    level3: 12,
    level4: 18,
    level5: 24
  };
}

// --- Data Models ---
class MacroSet {
  title: string;
  reps: string;
  phase: string;

  constructor(title: string, reps: string, phase: string) {
    this.title = title;
    this.reps = reps;
    this.phase = phase;
  }
}

class PerformanceMetric {
  label: string;
  value: string;
  change: string;

  constructor(label: string, value: string, change: string) {
    this.label = label;
    this.value = value;
    this.change = change;
  }
}

// --- Main Entry Point ---
@Entry
@Component
struct MacroTrainerApp {
  private sets: MacroSet[] = [
    new MacroSet('Warm circuit', '3 sets', 'Energy'),
    new MacroSet('Core push', '4 rounds', 'Explosive'),
    new MacroSet('Cooldown flow', '6 min', 'Calm')
  ];

  private metrics: PerformanceMetric[] = [
    new PerformanceMetric('Load', '72%', '+4%'),
    new PerformanceMetric('VO2', '41', '+1'),
    new PerformanceMetric('Focus', '88%', 'stable')
  ];

  @State private timerValue: string = '02:34';
  @State private targetPhase: string = 'Macro tempo';

  build() {
    Column() {
      // Top App Bar
      TopAppBar()

      // Content List
      Scroll() {
        Column() {
          // Hero Section: Timer & Metrics
          Row() {
            // Timer Card
            Column() {
              // Progress Ring
              Stack() {
                // Gradient Border
                Circle()
                  .width(160)
                  .height(160)
                  .fill(DesignTokens.Colors.surface)
                  .stroke(new LinearGradient({
                    angle: 135,
                    colors: [
                      [DesignTokens.Colors.primary, 0.0],
                      [DesignTokens.Colors.secondary, 0.33],
                      [DesignTokens.Colors.tertiary, 0.66],
                      [DesignTokens.Colors.primary, 1.0]
                    ]
                  }))
                  .strokeWidth(10);

                // Timer Text
                Column() {
                  Text(this.timerValue)
                    .fontSize(DesignTokens.Typography.display.fontSize)
                    .fontWeight(DesignTokens.Typography.display.fontWeight)
                    .fontColor(DesignTokens.Colors.onSurface)
                  Text('Timer')
                    .fontSize(DesignTokens.Typography.label.fontSize)
                    .fontWeight(DesignTokens.Typography.label.fontWeight)
                    .fontColor(DesignTokens.Colors.onSurface70)
                    .margin({ top: DesignTokens.Spacing.xxs })
                }
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)
              }
              .width(160)
              .height(160)

              // Tags
              Row() {
                ForEach(['Macro', 'Tempo', 'Breath'], (tag: string) => {
                  Text(tag)
                    .fontSize(DesignTokens.Typography.label.fontSize)
                    .fontWeight(DesignTokens.Typography.label.fontWeight)
                    .fontColor(DesignTokens.Colors.onSurface)
                    .backgroundColor(DesignTokens.Colors.surfaceVariant)
                    .borderRadius(DesignTokens.Shapes.small)
                    .padding({
                      left: DesignTokens.Spacing.xs,
                      right: DesignTokens.Spacing.xs,
                      top: DesignTokens.Spacing.xxs,
                      bottom: DesignTokens.Spacing.xxs
                    })
                    .margin({ right: DesignTokens.Spacing.xxs })
                });
              }
              .margin({ top: DesignTokens.Spacing.sm })
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .padding(DesignTokens.Spacing.md)
            .backgroundColor(DesignTokens.Colors.surface)
            .borderRadius(DesignTokens.Shapes.large)
            .shadow({ radius: DesignTokens.Elevation.level2, color: 'rgba(0,0,0,0.5)', offsetY: 4 });

            // Metrics Column
            Column() {
              ForEach(this.metrics, (metric: PerformanceMetric) => {
                Column() {
                  Text(metric.label)
                    .fontSize(DesignTokens.Typography.label.fontSize)
                    .fontWeight(DesignTokens.Typography.label.fontWeight)
                    .fontColor(DesignTokens.Colors.onSurface)
                  Text(metric.value)
                    .fontSize(DesignTokens.Typography.headline.fontSize)
                    .fontWeight(DesignTokens.Typography.headline.fontWeight)
                    .fontColor(DesignTokens.Colors.secondary)
                    .margin({ top: DesignTokens.Spacing.xxs })
                  Text(metric.change)
                    .fontSize(DesignTokens.Typography.body.fontSize)
                    .fontWeight(DesignTokens.Typography.body.fontWeight)
                    .fontColor(DesignTokens.Colors.onSurface70)
                    .margin({ top: DesignTokens.Spacing.xxs })
                }
                .width('100%')
                .alignItems(HorizontalAlign.Start)
                .backgroundColor(DesignTokens.Colors.surfaceVariant)
                .borderRadius(DesignTokens.Shapes.medium)
                .padding(DesignTokens.Spacing.sm)
                .margin({ bottom: DesignTokens.Spacing.sm });
              });
            }
            .width(120)
            .margin({ left: DesignTokens.Spacing.sm });
          }
          .width('100%')
          .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md });

          // Sets List
          ForEach(this.sets, (set: MacroSet) => {
            Row() {
              // Left Info
              Column() {
                Text(set.title)
                  .fontSize(DesignTokens.Typography.title.fontSize)
                  .fontWeight(DesignTokens.Typography.title.fontWeight)
                  .fontColor(DesignTokens.Colors.onSurface)
                Text(set.phase)
                  .fontSize(DesignTokens.Typography.body.fontSize)
                  .fontWeight(DesignTokens.Typography.body.fontWeight)
                  .fontColor(DesignTokens.Colors.onSurface70)
                  .margin({ top: DesignTokens.Spacing.xxs })
              }
              .alignItems(HorizontalAlign.Start);

              // Right Action
              Column() {
                Text(set.reps)
                  .fontSize(DesignTokens.Typography.headline.fontSize)
                  .fontWeight(DesignTokens.Typography.headline.fontWeight)
                  .fontColor(DesignTokens.Colors.primary)
                Button('Start')
                  .fontSize(DesignTokens.Typography.label.fontSize)
                  .fontWeight(DesignTokens.Typography.label.fontWeight)
                  .fontColor(DesignTokens.Colors.onSecondary)
                  .backgroundColor(DesignTokens.Colors.secondary)
                  .borderRadius(DesignTokens.Shapes.small)
                  .padding({
                    left: DesignTokens.Spacing.xs,
                    right: DesignTokens.Spacing.xs,
                    top: DesignTokens.Spacing.xxs,
                    bottom: DesignTokens.Spacing.xxs
                  })
                  .margin({ top: DesignTokens.Spacing.xxs })
                  .height(28);
              }
              .alignItems(HorizontalAlign.End);
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .backgroundColor(DesignTokens.Colors.surfaceVariant90)
            .borderRadius(DesignTokens.Shapes.medium)
            .padding(DesignTokens.Spacing.md)
            .margin({
              left: DesignTokens.Spacing.lg,
              right: DesignTokens.Spacing.lg,
              bottom: DesignTokens.Spacing.lg
            });
          });
        }
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off);

      // Bottom Bar
      BottomBar({ targetPhase: this.targetPhase });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.Colors.background);
  }
}

// --- Sub-Components ---

@Component
struct TopAppBar {
  build() {
    Row() {
      // Navigation Icon
      Circle()
        .width(24)
        .height(24)
        .fill(DesignTokens.Colors.surfaceVariant);

      // Title
      Column() {
        Text('MacroTrainer')
          .fontSize(DesignTokens.Typography.title.fontSize)
          .fontWeight(DesignTokens.Typography.title.fontWeight)
          .fontColor(DesignTokens.Colors.onSurface)
        Text('Neon workout stack')
          .fontSize(DesignTokens.Typography.label.fontSize)
          .fontWeight(DesignTokens.Typography.label.fontWeight)
          .fontColor(DesignTokens.Colors.onSurface70)
          .margin({ top: 2 });
      }
      .alignItems(HorizontalAlign.Center);

      // Action Icon
      Circle()
        .width(24)
        .height(24)
        .fill(DesignTokens.Colors.surfaceVariant);
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })
    .backgroundColor(DesignTokens.Colors.surface95);
  }
}

@Component
struct BottomBar {
  @Prop targetPhase: string;

  build() {
    Row() {
      Column() {
        Text('Next macro')
          .fontSize(DesignTokens.Typography.label.fontSize)
          .fontWeight(DesignTokens.Typography.label.fontWeight)
          .fontColor(DesignTokens.Colors.onSurface)
        Text(this.targetPhase)
          .fontSize(DesignTokens.Typography.title.fontSize)
          .fontWeight(DesignTokens.Typography.title.fontWeight)
          .fontColor(DesignTokens.Colors.onSurface)
          .margin({ top: DesignTokens.Spacing.xxs })
      }
      .alignItems(HorizontalAlign.Start);

      Button('Prime')
        .fontSize(DesignTokens.Typography.title.fontSize)
        .fontWeight(DesignTokens.Typography.title.fontWeight)
        .fontColor(DesignTokens.Colors.onSecondary)
        .backgroundColor(DesignTokens.Colors.secondary)
        .borderRadius(DesignTokens.Shapes.medium)
        .padding({
          left: DesignTokens.Spacing.xl,
          right: DesignTokens.Spacing.xl,
          top: DesignTokens.Spacing.xs,
          bottom: DesignTokens.Spacing.xs
        })
        .height(40);
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({
      left: DesignTokens.Spacing.lg,
      right: DesignTokens.Spacing.lg,
      top: DesignTokens.Spacing.md,
      bottom: DesignTokens.Spacing.md
    })
    .backgroundColor(DesignTokens.Colors.surfaceVariant)
    .shadow({ radius: DesignTokens.Elevation.level3, color: 'rgba(0,0,0,0.5)', offsetY: -2 });
  }
}