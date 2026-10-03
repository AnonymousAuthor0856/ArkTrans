import { ComponentContent, UIContext, window } from '@kit.ArkUI';

// Design Tokens
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
    onSurface: '#F8F4FF'
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

  static readonly Radius = {
    small: 8,
    medium: 18,
    large: 28
  };
}

interface MacroSet {
  title: string;
  reps: string;
  phase: string;
}

interface PerformanceMetric {
  label: string;
  value: string;
  change: string;
}

@Entry
@Component
struct RootScreen {
  @State timerValue: string = '02:34';
  @State targetPhase: string = 'Macro tempo';

  private sets: MacroSet[] = [
    { title: 'Warm circuit', reps: '3 sets', phase: 'Energy' },
    { title: 'Core push', reps: '4 rounds', phase: 'Explosive' },
    { title: 'Cooldown flow', reps: '6 min', phase: 'Calm' }
  ];

  private metrics: PerformanceMetric[] = [
    { label: 'Load', value: '72%', change: '+4%' },
    { label: 'VO2', value: '41', change: '+1' },
    { label: 'Focus', value: '88%', change: 'stable' }
  ];

  @Builder
  TopBar() {
    Row() {
      Row() {
        // Navigation icon placeholder
        Row()
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor(DesignTokens.Colors.surfaceVariant)
      }
      .width(48)
      .height(48)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text('MacroTrainer')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)
        Text('Neon workout stack')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B3F8F4FF')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      Row() {
        // Action icon placeholder
        Row()
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor(DesignTokens.Colors.surfaceVariant)
      }
      .width(48)
      .height(48)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(64)
    .padding({ left: 8, right: 8 })
    .backgroundColor('#F20D0616')
  }

  @Builder
  TimerCard() {
    Column({ space: DesignTokens.Spacing.sm }) {
      Stack() {
        // Gradient ring simulation using border
        Column() {
          Text(this.timerValue)
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor(DesignTokens.Colors.onSurface)
          Text('Timer')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#B3F8F4FF')
        }
        .width(160)
        .height(160)
        .borderRadius(80)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor(DesignTokens.Colors.surface)
        .border({
          width: 10,
          color: DesignTokens.Colors.primary,
          radius: 80
        })
      }
      .width(180)
      .height(180)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Row({ space: DesignTokens.Spacing.xxs }) {
        ForEach(['Macro', 'Tempo', 'Breath'], (tag: string) => {
          Text(tag)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface)
            .padding({
              left: DesignTokens.Spacing.xs,
              right: DesignTokens.Spacing.xs,
              top: DesignTokens.Spacing.xxs,
              bottom: DesignTokens.Spacing.xxs
            })
            .backgroundColor(DesignTokens.Colors.surfaceVariant)
            .borderRadius(DesignTokens.Radius.small)
        })
      }
    }
    .padding(DesignTokens.Spacing.md)
    .backgroundColor(DesignTokens.Colors.surface)
    .borderRadius(DesignTokens.Radius.large)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  MetricCard(metric: PerformanceMetric) {
    Column({ space: DesignTokens.Spacing.xxs }) {
      Text(metric.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(DesignTokens.Colors.onSurface)
      Text(metric.value)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(DesignTokens.Colors.secondary)
      Text(metric.change)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor('#B3F8F4FF')
    }
    .width('100%')
    .padding(DesignTokens.Spacing.sm)
    .backgroundColor(DesignTokens.Colors.surfaceVariant)
    .borderRadius(DesignTokens.Radius.medium)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  SetCard(set: MacroSet) {
    Row() {
      Column({ space: DesignTokens.Spacing.xxs }) {
        Text(set.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)
        Text(set.phase)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#B3F8F4FF')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Column({ space: DesignTokens.Spacing.xxs }) {
        Text(set.reps)
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.primary)
        Button('Start')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSecondary)
          .backgroundColor(DesignTokens.Colors.secondary)
          .borderRadius(DesignTokens.Radius.small)
          .padding({
            left: DesignTokens.Spacing.xs,
            right: DesignTokens.Spacing.xs,
            top: DesignTokens.Spacing.xxs,
            bottom: DesignTokens.Spacing.xxs
          })
          .height(32)
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(DesignTokens.Spacing.md)
    .backgroundColor('#E61A0F2C')
    .borderRadius(DesignTokens.Radius.medium)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: DesignTokens.Spacing.xxs }) {
        Text('Next macro')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)
        Text(this.targetPhase)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Button('Prime')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(DesignTokens.Colors.onSecondary)
        .backgroundColor(DesignTokens.Colors.secondary)
        .borderRadius(DesignTokens.Radius.medium)
        .padding({
          left: DesignTokens.Spacing.xl,
          right: DesignTokens.Spacing.xl,
          top: DesignTokens.Spacing.xs,
          bottom: DesignTokens.Spacing.xs
        })
        .height(44)
    }
    .width('100%')
    .padding({
      left: DesignTokens.Spacing.lg,
      right: DesignTokens.Spacing.lg,
      top: DesignTokens.Spacing.md,
      bottom: DesignTokens.Spacing.md
    })
    .backgroundColor(DesignTokens.Colors.surfaceVariant)
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: DesignTokens.Spacing.lg }) {
          // Timer + Metrics row
          Row({ space: DesignTokens.Spacing.sm }) {
            Column() {
              this.TimerCard()
            }
            .layoutWeight(1)

            Column({ space: DesignTokens.Spacing.sm }) {
              ForEach(this.metrics, (metric: PerformanceMetric) => {
                this.MetricCard(metric)
              })
            }
            .width(120)
          }
          .width('100%')
          .alignItems(VerticalAlign.Top)

          // Set cards
          ForEach(this.sets, (set: MacroSet) => {
            this.SetCard(set)
          })
        }
        .width('100%')
        .padding({
          left: DesignTokens.Spacing.lg,
          right: DesignTokens.Spacing.lg,
          top: DesignTokens.Spacing.md,
          bottom: DesignTokens.Spacing.md
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.Colors.background)
  }
}