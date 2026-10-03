interface MacroSet {
  title: string
  reps: string
  phase: string
}

interface PerformanceMetric {
  label: string
  value: string
  change: string
}

class AppColors {
  static readonly primary: string = '#7C4DFF'
  static readonly secondary: string = '#08D6FF'
  static readonly tertiary: string = '#FF8E3C'
  static readonly background: string = '#05030A'
  static readonly surface: string = '#0D0616'
  static readonly surfaceVariant: string = '#1A0F2C'
  static readonly outline: string = '#3A2759'
  static readonly success: string = '#56F0A6'
  static readonly warning: string = '#FFC857'
  static readonly error: string = '#FF5B7A'
  static readonly onPrimary: string = '#05030A'
  static readonly onSecondary: string = '#05030A'
  static readonly onTertiary: string = '#120601'
  static readonly onBackground: string = '#F4ECFF'
  static readonly onSurface: string = '#F8F4FF'
  static readonly muted: string = '#B9B0C8'
}

class Spacing {
  static readonly xxs: number = 4
  static readonly xs: number = 8
  static readonly sm: number = 12
  static readonly md: number = 16
  static readonly lg: number = 20
  static readonly xl: number = 28
  static readonly xxl: number = 40
  static readonly xxxl: number = 56
}

class Radius {
  static readonly small: number = 8
  static readonly medium: number = 18
  static readonly large: number = 28
}

@Entry
@Component
struct Index {
  @State private timerValue: string = '02:34'
  @State private targetPhase: string = 'Macro tempo'

  private readonly sets: MacroSet[] = [
    { title: 'Warm circuit', reps: '3 sets', phase: 'Energy' },
    { title: 'Core push', reps: '4 rounds', phase: 'Explosive' },
    { title: 'Cooldown flow', reps: '6 min', phase: 'Calm' }
  ]

  private readonly metrics: PerformanceMetric[] = [
    { label: 'Load', value: '72%', change: '+4%' },
    { label: 'VO2', value: '41', change: '+1' },
    { label: 'Focus', value: '88%', change: 'stable' }
  ]

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: Spacing.lg }) {
          this.HeroSection()

          ForEach(this.sets, (item: MacroSet) => {
            this.MacroSetCard(item)
          }, (item: MacroSet) => item.title)
        }
        .width('100%')
        .padding({
          left: Spacing.lg,
          right: Spacing.lg,
          top: Spacing.md,
          bottom: Spacing.lg
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppColors.background)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  private TopBar() {
    Row() {
      Circle()
        .width(24)
        .height(24)
        .fill(AppColors.surfaceVariant)

      Column() {
        Text('MacroTrainer')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .lineHeight(20)
          .fontColor(AppColors.onSurface)

        Text('Neon workout stack')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .lineHeight(16)
          .fontColor(AppColors.muted)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      Circle()
        .width(24)
        .height(24)
        .fill(AppColors.surfaceVariant)
    }
    .width('100%')
    .height(80)
    .padding({
      left: 32,
      right: 32,
      top: 20,
      bottom: 12
    })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(AppColors.background)
  }

  @Builder
  private HeroSection() {
    Row({ space: Spacing.sm }) {
      Column({ space: Spacing.sm }) {
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(150)
            .height(150)
            .fill(AppColors.primary)
            .linearGradient({
              angle: 135,
              colors: [
                [AppColors.tertiary, 0.0],
                [AppColors.secondary, 0.55],
                [AppColors.primary, 1.0]
              ]
            })

          Circle()
            .width(130)
            .height(130)
            .fill(AppColors.surface)

          Column() {
            Text(this.timerValue)
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .lineHeight(38)
              .fontColor(AppColors.onSurface)

            Text('Timer')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .lineHeight(16)
              .fontColor(AppColors.muted)
          }
          .alignItems(HorizontalAlign.Center)
        }
        .width(160)
        .height(160)

        Row({ space: Spacing.xs }) {
          ForEach(['Macro', 'Tempo', 'Breath'], (tag: string) => {
            Text(tag)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .lineHeight(16)
              .fontColor(AppColors.onSurface)
              .textAlign(TextAlign.Center)
              .padding({
                left: Spacing.xs,
                right: Spacing.xs,
                top: Spacing.xxs,
                bottom: Spacing.xxs
              })
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(Radius.small)
          }, (tag: string) => tag)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
      .height(242)
      .layoutWeight(1)
      .padding(Spacing.md)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(Radius.large)

      Column({ space: Spacing.sm }) {
        ForEach(this.metrics, (metric: PerformanceMetric) => {
          this.MetricCard(metric)
        }, (metric: PerformanceMetric) => metric.label)
      }
      .width(120)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  private MetricCard(metric: PerformanceMetric) {
    Column({ space: Spacing.xxs }) {
      Text(metric.label)
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .lineHeight(16)
        .fontColor(AppColors.onSurface)

      Text(metric.value)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .lineHeight(28)
        .fontColor(AppColors.secondary)

      Text(metric.change)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .lineHeight(20)
        .fontColor(AppColors.muted)
    }
    .width('100%')
    .height(89)
    .padding(Spacing.sm)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(Radius.medium)
  }

  @Builder
  private MacroSetCard(set: MacroSet) {
    Row() {
      Column({ space: Spacing.xxs }) {
        Text(set.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .lineHeight(22)
          .fontColor(AppColors.onSurface)

        Text(set.phase)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .lineHeight(20)
          .fontColor(AppColors.muted)
      }

      Column({ space: Spacing.xs }) {
        Text(set.reps)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .lineHeight(28)
          .fontColor(AppColors.primary)

        Button('Start', { type: ButtonType.Normal, stateEffect: true })
          .width(58)
          .height(40)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .backgroundColor(AppColors.secondary)
          .borderRadius(Radius.small)
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .height(110)
    .padding(Spacing.md)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(Radius.medium)
  }

  @Builder
  private BottomBar() {
    Row() {
      Column({ space: Spacing.xxs }) {
        Text('Next macro')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .lineHeight(16)
          .fontColor(AppColors.onSurface)

        Text(this.targetPhase)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .lineHeight(22)
          .fontColor(AppColors.onSurface)
      }

      Button('Prime', { type: ButtonType.Capsule, stateEffect: true })
        .width(100)
        .height(40)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
    }
    .width('100%')
    .height(120)
    .padding({
      left: Spacing.lg,
      right: Spacing.lg,
      top: Spacing.md,
      bottom: Spacing.md
    })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(AppColors.surfaceVariant)
  }
}