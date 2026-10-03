const NAME: string = '128*MacroTrainer*en'
const UI_TYPE: string = 'Workout'
const STYLE_THEME: string = 'Dark Neon'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'
const COLOR_PALETTE: string = 'primary:#7C4DFF secondary:#08D6FF tertiary:#FF8E3C background:#05030A surface:#0D0616 surfaceVariant:#1A0F2C outline:#3A2759 success:#56F0A6 warning:#FFC857 error:#FF5B7A onPrimary:#05030A onSecondary:#05030A onTertiary:#120601 onBackground:#F4ECFF onSurface:#F8F4FF'
const DENSITY_SPACING: string = 'Compact'
const COMPLEXITY: string = 'Timer,ProgressRing,CTA'
const EXTRA: string = 'Neon macro workout controller'

class DesignColors {
  static readonly primary: string = '#7C4DFF'
  static readonly secondary: string = '#08D6FF'
  static readonly tertiary: string = '#FF8E3C'
  static readonly background: string = '#05030A'
  static readonly surface: string = '#0D0616'
  static readonly surface95: string = '#F20D0616'
  static readonly surfaceVariant: string = '#1A0F2C'
  static readonly surfaceVariant90: string = '#E61A0F2C'
  static readonly outline: string = '#3A2759'
  static readonly success: string = '#56F0A6'
  static readonly warning: string = '#FFC857'
  static readonly error: string = '#FF5B7A'
  static readonly onPrimary: string = '#05030A'
  static readonly onSecondary: string = '#05030A'
  static readonly onTertiary: string = '#120601'
  static readonly onBackground: string = '#F4ECFF'
  static readonly onSurface: string = '#F8F4FF'
  static readonly onSurface70: string = '#B3F8F4FF'
}

class DesignTypography {
  static readonly displaySize: number = 32
  static readonly displayLineHeight: number = 38
  static readonly headlineSize: number = 22
  static readonly headlineLineHeight: number = 28
  static readonly titleSize: number = 16
  static readonly titleLineHeight: number = 22
  static readonly bodySize: number = 14
  static readonly bodyLineHeight: number = 20
  static readonly labelSize: number = 12
  static readonly labelLineHeight: number = 16
}

class DesignShape {
  static readonly small: number = 8
  static readonly medium: number = 18
  static readonly large: number = 28
}

class DesignSpacing {
  static readonly xxs: number = 4
  static readonly xs: number = 8
  static readonly sm: number = 12
  static readonly md: number = 16
  static readonly lg: number = 20
  static readonly xl: number = 28
  static readonly xxl: number = 40
  static readonly xxxl: number = 56
}

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.18)
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.22)
  static readonly level3: ShadowSpec = new ShadowSpec(12, 12, 6, 0.26)
  static readonly level4: ShadowSpec = new ShadowSpec(18, 18, 8, 0.3)
  static readonly level5: ShadowSpec = new ShadowSpec(24, 24, 10, 0.34)
}

class MacroSet {
  title: string
  reps: string
  phase: string

  constructor(title: string, reps: string, phase: string) {
    this.title = title
    this.reps = reps
    this.phase = phase
  }
}

class PerformanceMetric {
  label: string
  value: string
  change: string

  constructor(label: string, value: string, change: string) {
    this.label = label
    this.value = value
    this.change = change
  }
}

@Component
struct TopBar {
  build() {
    Row() {
      Button({ type: ButtonType.Circle, stateEffect: true }) {
        Blank()
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor(DesignColors.surfaceVariant)
      }
      .width(48)
      .height(48)
      .backgroundColor('#00000000')
      .padding(0)

      Column() {
        Text('MacroTrainer')
          .fontSize(DesignTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .lineHeight(DesignTypography.titleLineHeight)
          .fontColor(DesignColors.onSurface)

        Text('Neon workout stack')
          .fontSize(DesignTypography.labelSize)
          .fontWeight(FontWeight.Medium)
          .lineHeight(DesignTypography.labelLineHeight)
          .fontColor(DesignColors.onSurface70)
      }
      .alignItems(HorizontalAlign.Center)
      .layoutWeight(1)

      Button({ type: ButtonType.Circle, stateEffect: true }) {
        Blank()
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor(DesignColors.surfaceVariant)
      }
      .width(48)
      .height(48)
      .backgroundColor('#00000000')
      .padding(0)
    }
    .width('100%')
    .height(72)
    .padding({ left: 8, right: 8 })
    .backgroundColor(DesignColors.surface95)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BottomBar {
  targetPhase: string = ''

  build() {
    Row() {
      Column({ space: DesignSpacing.xxs }) {
        Text('Next macro')
          .fontSize(DesignTypography.labelSize)
          .fontWeight(FontWeight.Medium)
          .lineHeight(DesignTypography.labelLineHeight)
          .fontColor(DesignColors.onSurface)

        Text(this.targetPhase)
          .fontSize(DesignTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .lineHeight(DesignTypography.titleLineHeight)
          .fontColor(DesignColors.onSurface)
      }

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Prime')
          .fontSize(DesignTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .lineHeight(DesignTypography.titleLineHeight)
          .fontColor(DesignColors.onSecondary)
      }
      .backgroundColor(DesignColors.secondary)
      .borderRadius(DesignShape.medium)
      .padding({
        left: DesignSpacing.xl,
        right: DesignSpacing.xl,
        top: DesignSpacing.xs,
        bottom: DesignSpacing.xs
      })
    }
    .width('100%')
    .padding({
      left: DesignSpacing.lg,
      right: DesignSpacing.lg,
      top: DesignSpacing.md,
      bottom: DesignSpacing.md
    })
    .backgroundColor(DesignColors.surfaceVariant)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .shadow({
      radius: ElevationMapping.level3.radius,
      color: '#4208D6FF',
      offsetX: 0,
      offsetY: ElevationMapping.level3.dy
    })
  }
}

@Component
struct TagChip {
  label: string = ''

  build() {
    Text(this.label)
      .fontSize(DesignTypography.labelSize)
      .fontWeight(FontWeight.Medium)
      .lineHeight(DesignTypography.labelLineHeight)
      .fontColor(DesignColors.onSurface)
      .padding({
        left: DesignSpacing.xs,
        right: DesignSpacing.xs,
        top: DesignSpacing.xxs,
        bottom: DesignSpacing.xxs
      })
      .backgroundColor(DesignColors.surfaceVariant)
      .borderRadius(DesignShape.small)
  }
}

@Component
struct TimerCard {
  timerValue: string = ''

  private tags: string[] = ['Macro', 'Tempo', 'Breath']

  build() {
    Column({ space: DesignSpacing.sm }) {
      Stack({ alignContent: Alignment.Center }) {
        Circle({ width: 160, height: 160 })
          .fill(DesignColors.primary)
          .sweepGradient({
            center: [0.5, 0.5],
            start: 0,
            end: 359,
            colors: [
              [DesignColors.primary, 0.0],
              [DesignColors.secondary, 0.36],
              [DesignColors.tertiary, 0.72],
              [DesignColors.primary, 1.0]
            ]
          })

        Circle({ width: 140, height: 140 })
          .fill(DesignColors.surface)

        Column() {
          Text(this.timerValue)
            .fontSize(DesignTypography.displaySize)
            .fontWeight(FontWeight.Bold)
            .lineHeight(DesignTypography.displayLineHeight)
            .fontColor(DesignColors.onSurface)
            .textAlign(TextAlign.Center)

          Text('Timer')
            .fontSize(DesignTypography.labelSize)
            .fontWeight(FontWeight.Medium)
            .lineHeight(DesignTypography.labelLineHeight)
            .fontColor(DesignColors.onSurface70)
            .textAlign(TextAlign.Center)
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(160)
      .height(160)

      Row({ space: DesignSpacing.xxs }) {
        ForEach(this.tags, (tag: string) => {
          TagChip({ label: tag })
        }, (tag: string) => tag)
      }
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(DesignSpacing.md)
    .backgroundColor(DesignColors.surface)
    .borderRadius(DesignShape.large)
    .alignItems(HorizontalAlign.Center)
    .shadow({
      radius: ElevationMapping.level2.radius,
      color: '#3808D6FF',
      offsetX: 0,
      offsetY: ElevationMapping.level2.dy
    })
  }
}

@Component
struct MetricCard {
  metric: PerformanceMetric = new PerformanceMetric('', '', '')

  build() {
    Column({ space: DesignSpacing.xxs }) {
      Text(this.metric.label)
        .fontSize(DesignTypography.labelSize)
        .fontWeight(FontWeight.Medium)
        .lineHeight(DesignTypography.labelLineHeight)
        .fontColor(DesignColors.onSurface)

      Text(this.metric.value)
        .fontSize(DesignTypography.headlineSize)
        .fontWeight(FontWeight.SemiBold)
        .lineHeight(DesignTypography.headlineLineHeight)
        .fontColor(DesignColors.secondary)

      Text(this.metric.change)
        .fontSize(DesignTypography.bodySize)
        .fontWeight(FontWeight.Normal)
        .lineHeight(DesignTypography.bodyLineHeight)
        .fontColor(DesignColors.onSurface70)
    }
    .width('100%')
    .padding(DesignSpacing.sm)
    .backgroundColor(DesignColors.surfaceVariant)
    .borderRadius(DesignShape.medium)
  }
}

@Component
struct SetRow {
  set: MacroSet = new MacroSet('', '', '')

  build() {
    Row() {
      Column({ space: DesignSpacing.xxs }) {
        Text(this.set.title)
          .fontSize(DesignTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .lineHeight(DesignTypography.titleLineHeight)
          .fontColor(DesignColors.onSurface)

        Text(this.set.phase)
          .fontSize(DesignTypography.bodySize)
          .fontWeight(FontWeight.Normal)
          .lineHeight(DesignTypography.bodyLineHeight)
          .fontColor(DesignColors.onSurface70)
      }

      Column({ space: DesignSpacing.xxs }) {
        Text(this.set.reps)
          .fontSize(DesignTypography.headlineSize)
          .fontWeight(FontWeight.SemiBold)
          .lineHeight(DesignTypography.headlineLineHeight)
          .fontColor(DesignColors.primary)
          .textAlign(TextAlign.End)

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Start')
            .fontSize(DesignTypography.labelSize)
            .fontWeight(FontWeight.Medium)
            .lineHeight(DesignTypography.labelLineHeight)
            .fontColor(DesignColors.onSecondary)
        }
        .backgroundColor(DesignColors.secondary)
        .borderRadius(DesignShape.small)
        .padding({
          left: DesignSpacing.xs,
          right: DesignSpacing.xs,
          top: DesignSpacing.xxs,
          bottom: DesignSpacing.xxs
        })
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(DesignSpacing.md)
    .backgroundColor(DesignColors.surfaceVariant90)
    .borderRadius(DesignShape.medium)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct HeroSection {
  timerValue: string = ''
  metrics: PerformanceMetric[] = []

  build() {
    Row({ space: DesignSpacing.sm }) {
      TimerCard({ timerValue: this.timerValue })
        .layoutWeight(1)

      Column({ space: DesignSpacing.sm }) {
        ForEach(this.metrics, (metric: PerformanceMetric) => {
          MetricCard({ metric: metric })
        }, (metric: PerformanceMetric) => metric.label)
      }
      .width(120)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}

@Entry
@Component
struct RootScreen {
  @State timerValue: string = '02:34'
  @State targetPhase: string = 'Macro tempo'

  private sets: MacroSet[] = [
    new MacroSet('Warm circuit', '3 sets', 'Energy'),
    new MacroSet('Core push', '4 rounds', 'Explosive'),
    new MacroSet('Cooldown flow', '6 min', 'Calm')
  ]

  private metrics: PerformanceMetric[] = [
    new PerformanceMetric('Load', '72%', '+4%'),
    new PerformanceMetric('VO2', '41', '+1'),
    new PerformanceMetric('Focus', '88%', 'stable')
  ]

  build() {
    Column() {
      TopBar()

      Scroll() {
        Column({ space: DesignSpacing.lg }) {
          HeroSection({
            timerValue: this.timerValue,
            metrics: this.metrics
          })

          ForEach(this.sets, (set: MacroSet) => {
            SetRow({ set: set })
          }, (set: MacroSet) => set.title)
        }
        .width('100%')
        .padding({
          left: DesignSpacing.lg,
          right: DesignSpacing.lg,
          top: DesignSpacing.md,
          bottom: DesignSpacing.lg
        })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      BottomBar({ targetPhase: this.targetPhase })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignColors.background)
  }
}