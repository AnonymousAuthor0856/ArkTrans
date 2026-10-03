import { curves } from '@kit.ArkUI';

// Design Tokens
namespace DesignTokens {
  export namespace Colors {
    export const primary: string = '#7C4DFF';
    export const secondary: string = '#08D6FF';
    export const tertiary: string = '#FF8E3C';
    export const background: string = '#05030A';
    export const surface: string = '#0D0616';
    export const surfaceVariant: string = '#1A0F2C';
    export const outline: string = '#3A2759';
    export const success: string = '#56F0A6';
    export const warning: string = '#FFC857';
    export const error: string = '#FF5B7A';
    export const onPrimary: string = '#05030A';
    export const onSecondary: string = '#05030A';
    export const onTertiary: string = '#120601';
    export const onBackground: string = '#F4ECFF';
    export const onSurface: string = '#F8F4FF';
  }

  export namespace Spacing {
    export const xxs: number = 4;
    export const xs: number = 8;
    export const sm: number = 12;
    export const md: number = 16;
    export const lg: number = 20;
    export const xl: number = 28;
    export const xxl: number = 40;
    export const xxxl: number = 56;
  }
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

@Component
struct MetricCard {
  metric: PerformanceMetric = { label: '', value: '', change: '' };

  build() {
    Column({ space: DesignTokens.Spacing.xxs }) {
      Text(this.metric.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(DesignTokens.Colors.onSurface)
      Text(this.metric.value)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(DesignTokens.Colors.secondary)
      Text(this.metric.change)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor('#B3F8F4FF')
    }
    .width('100%')
    .backgroundColor(DesignTokens.Colors.surfaceVariant)
    .borderRadius(18)
    .padding(DesignTokens.Spacing.sm)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct MacroSetCard {
  set: MacroSet = { title: '', reps: '', phase: '' };

  build() {
    Row() {
      Column({ space: DesignTokens.Spacing.xxs }) {
        Text(this.set.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)
        Text(this.set.phase)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#B3F8F4FF')
      }
      .alignItems(HorizontalAlign.Start)

      Column({ space: DesignTokens.Spacing.xxs }) {
        Text(this.set.reps)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(DesignTokens.Colors.primary)
        Button('Start')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSecondary)
          .backgroundColor(DesignTokens.Colors.secondary)
          .borderRadius(8)
          .height(28)
          .padding({ left: DesignTokens.Spacing.xs, right: DesignTokens.Spacing.xs, top: DesignTokens.Spacing.xxs, bottom: DesignTokens.Spacing.xxs })
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#E61A0F2C')
    .borderRadius(18)
    .padding(DesignTokens.Spacing.md)
  }
}

@Component
struct TimerRing {
  timerValue: string = '02:34';

  build() {
    Stack() {
      Circle({ width: 160, height: 160 })
        .fill(DesignTokens.Colors.surface)
        .stroke(DesignTokens.Colors.surfaceVariant)
        .strokeWidth(10)

      // Gradient ring simulation using arc shapes
      Circle({ width: 160, height: 160 })
        .fill('transparent')
        .stroke(DesignTokens.Colors.primary)
        .strokeWidth(10)
        .opacity(0.4)

      Circle({ width: 148, height: 148 })
        .fill(DesignTokens.Colors.surface)

      Column() {
        Text(this.timerValue)
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(DesignTokens.Colors.onSurface)
          .letterSpacing(0)
        Text('Timer')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B3F8F4FF')
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width(160)
    .height(160)
    .alignContent(Alignment.Center)
  }
}

@Component
struct TagChip {
  tag: string = '';

  build() {
    Text(this.tag)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(DesignTokens.Colors.onSurface)
      .backgroundColor(DesignTokens.Colors.surfaceVariant)
      .borderRadius(8)
      .padding({ left: DesignTokens.Spacing.xs, right: DesignTokens.Spacing.xs, top: DesignTokens.Spacing.xxs, bottom: DesignTokens.Spacing.xxs })
  }
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

  private tags: string[] = ['Macro', 'Tempo', 'Breath'];

  @Builder
  TopBar() {
    Row() {
      Button({ type: ButtonType.Circle }) {
        Stack() {}
        .width(24)
        .height(24)
        .backgroundColor(DesignTokens.Colors.surfaceVariant)
        .borderRadius(12)
      }
      .width(40)
      .height(40)
      .backgroundColor('transparent')

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

      Button({ type: ButtonType.Circle }) {
        Stack() {}
        .width(24)
        .height(24)
        .backgroundColor(DesignTokens.Colors.surfaceVariant)
        .borderRadius(12)
      }
      .width(40)
      .height(40)
      .backgroundColor('transparent')
    }
    .width('100%')
    .height(56)
    .padding({ left: DesignTokens.Spacing.md, right: DesignTokens.Spacing.md })
    .backgroundColor('#F20D0616')
    .justifyContent(FlexAlign.SpaceBetween)
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

      Button('Prime')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(DesignTokens.Colors.onSecondary)
        .backgroundColor(DesignTokens.Colors.secondary)
        .borderRadius(18)
        .padding({ left: DesignTokens.Spacing.xl, right: DesignTokens.Spacing.xl, top: DesignTokens.Spacing.xs, bottom: DesignTokens.Spacing.xs })
    }
    .width('100%')
    .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
    .backgroundColor(DesignTokens.Colors.surfaceVariant)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  HeroSection() {
    Row({ space: DesignTokens.Spacing.sm }) {
      // Timer ring card
      Column({ space: DesignTokens.Spacing.sm }) {
        TimerRing({ timerValue: this.timerValue })

        Row({ space: DesignTokens.Spacing.xxs }) {
          ForEach(this.tags, (tag: string) => {
            TagChip({ tag: tag })
          })
        }
      }
      .layoutWeight(1)
      .backgroundColor(DesignTokens.Colors.surface)
      .borderRadius(28)
      .padding(DesignTokens.Spacing.md)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      // Metrics column
      Column({ space: DesignTokens.Spacing.sm }) {
        ForEach(this.metrics, (metric: PerformanceMetric) => {
          MetricCard({ metric: metric })
        })
      }
      .width(120)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: DesignTokens.Spacing.lg }) {
          this.HeroSection()

          ForEach(this.sets, (set: MacroSet) => {
            MacroSetCard({ set: set })
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
      .backgroundColor(DesignTokens.Colors.background)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.Colors.background)
  }
}