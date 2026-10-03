@Entry
@Component
struct MacroTrainerApp {
  @State timerValue: string = "02:34"
  @State targetPhase: string = "Macro tempo"

  private sets: MacroSet[] = [
    { title: "Warm circuit", reps: "3 sets", phase: "Energy" },
    { title: "Core push", reps: "4 rounds", phase: "Explosive" },
    { title: "Cooldown flow", reps: "6 min", phase: "Calm" }
  ]

  private metrics: PerformanceMetric[] = [
    { label: "Load", value: "72%", change: "+4%" },
    { label: "VO2", value: "41", change: "+1" },
    { label: "Focus", value: "88%", change: "stable" }
  ]

  private tags: string[] = ["Macro", "Tempo", "Breath"]

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(DesignTokens.Colors.background)

      Column() {
        TopAppBar()
        MainContent({
          sets: this.sets,
          metrics: this.metrics,
          tags: this.tags,
          timerValue: this.timerValue
        })
        .layoutWeight(1)
        BottomBar({ targetPhase: this.targetPhase })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Top App Bar
@Component
struct TopAppBar {
  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(DesignTokens.Colors.surface)
        .opacity(0.95)

      Row() {
        Circle()
          .width(24)
          .height(24)
          .fill(DesignTokens.Colors.surfaceVariant)
          .onClick(() => {})

        Column() {
          Text("MacroTrainer")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface)
          Text("Neon workout stack")
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface)
            .opacity(0.7)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Circle()
          .width(24)
          .height(24)
          .fill(DesignTokens.Colors.surfaceVariant)
          .onClick(() => {})
      }
      .width('100%')
      .padding({
        left: DesignTokens.Spacing.lg,
        right: DesignTokens.Spacing.lg,
        top: DesignTokens.Spacing.md,
        bottom: DesignTokens.Spacing.md
      })
    }
    .width('100%')
    .height(60)
  }
}

// MARK: - Main Content
@Component
struct MainContent {
  @Prop sets: MacroSet[]
  @Prop metrics: PerformanceMetric[]
  @Prop tags: string[]
  @Prop timerValue: string

  build() {
    Scroll() {
      Column({ space: DesignTokens.Spacing.lg }) {
        TimerSection({
          timerValue: this.timerValue,
          tags: this.tags,
          metrics: this.metrics
        })
        SetsListSection({ sets: this.sets })
      }
      .width('100%')
      .padding({
        left: DesignTokens.Spacing.lg,
        right: DesignTokens.Spacing.lg,
        top: DesignTokens.Spacing.md,
        bottom: DesignTokens.Spacing.md
      })
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
    .backgroundColor(DesignTokens.Colors.background)
  }
}

// MARK: - Timer Section
@Component
struct TimerSection {
  @Prop timerValue: string
  @Prop tags: string[]
  @Prop metrics: PerformanceMetric[]

  build() {
    Row({ space: DesignTokens.Spacing.sm }) {
      TimerRing({ timerValue: this.timerValue, tags: this.tags })
        .layoutWeight(1)
      MetricsColumn({ metrics: this.metrics })
        .width(120)
    }
    .width('100%')
  }
}

@Component
struct TimerRing {
  @Prop timerValue: string
  @Prop tags: string[]

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(DesignTokens.Colors.surface)
        .borderRadius(28)
        .shadow({
          radius: 6,
          color: '#42000000',
          offsetY: 4
        })

      Column({ space: DesignTokens.Spacing.sm }) {
        Stack() {
          Column()
            .width(160)
            .height(160)
            .borderRadius(80)
            .sweepGradient({
              center: [80, 80],
              start: 0,
              end: 360,
              colors: [
                [DesignTokens.Colors.secondary, 0],
                [DesignTokens.Colors.primary, 0.33],
                [DesignTokens.Colors.tertiary, 0.66],
                [DesignTokens.Colors.secondary, 1]
              ]
            })

          Column()
            .width(140)
            .height(140)
            .borderRadius(70)
            .backgroundColor(DesignTokens.Colors.surface)

          Column({ space: 4 }) {
            Text(this.timerValue)
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor(DesignTokens.Colors.onSurface)
            Text("Timer")
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(DesignTokens.Colors.onSurface)
              .opacity(0.7)
          }
        }
        .width(160)
        .height(160)

        Row({ space: DesignTokens.Spacing.xxs }) {
          ForEach(this.tags, (tag: string) => {
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
              .borderRadius(8)
          }, (tag: string) => tag)
        }
      }
      .width('100%')
      .padding(DesignTokens.Spacing.md)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct MetricsColumn {
  @Prop metrics: PerformanceMetric[]

  build() {
    Column({ space: DesignTokens.Spacing.sm }) {
      ForEach(this.metrics, (metric: PerformanceMetric) => {
        MetricCard({ metric: metric })
      }, (metric: PerformanceMetric) => metric.label)
    }
    .width('100%')
  }
}

@Component
struct MetricCard {
  @Prop metric: PerformanceMetric

  build() {
    Column({ space: DesignTokens.Spacing.xxs }) {
      Text(this.metric.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(DesignTokens.Colors.onSurface)
      Text(this.metric.value)
        .fontSize(22)
        .fontWeight(FontWeight.Bolder)
        .fontColor(DesignTokens.Colors.secondary)
      Text(this.metric.change)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(DesignTokens.Colors.onSurface)
        .opacity(0.7)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(DesignTokens.Spacing.sm)
    .backgroundColor(DesignTokens.Colors.surfaceVariant)
    .borderRadius(18)
  }
}

// MARK: - Sets List Section
@Component
struct SetsListSection {
  @Prop sets: MacroSet[]

  build() {
    Column({ space: DesignTokens.Spacing.lg }) {
      ForEach(this.sets, (set: MacroSet) => {
        SetListItemView({ set: set })
      }, (set: MacroSet) => set.title)
    }
    .width('100%')
  }
}

@Component
struct SetListItemView {
  @Prop set: MacroSet

  build() {
    Row() {
      Column({ space: DesignTokens.Spacing.xxs }) {
        Text(this.set.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)
        Text(this.set.phase)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(DesignTokens.Colors.onSurface)
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column({ space: DesignTokens.Spacing.xxs }) {
        Text(this.set.reps)
          .fontSize(22)
          .fontWeight(FontWeight.Bolder)
          .fontColor(DesignTokens.Colors.primary)
        Text("Start")
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSecondary)
          .padding({
            left: DesignTokens.Spacing.xs,
            right: DesignTokens.Spacing.xs,
            top: DesignTokens.Spacing.xxs,
            bottom: DesignTokens.Spacing.xxs
          })
          .backgroundColor(DesignTokens.Colors.secondary)
          .borderRadius(8)
          .onClick(() => {})
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(DesignTokens.Spacing.md)
    .backgroundColor(DesignTokens.Colors.surfaceVariant)
    .opacity(0.9)
    .borderRadius(18)
  }
}

// MARK: - Bottom Bar
@Component
struct BottomBar {
  @Prop targetPhase: string

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(DesignTokens.Colors.surfaceVariant)
        .shadow({
          radius: 12,
          color: '#42000000',
          offsetY: -6
        })

      Row() {
        Column({ space: DesignTokens.Spacing.xxs }) {
          Text("Next macro")
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface)
          Text(this.targetPhase)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text("Prime")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSecondary)
          .padding({
            left: DesignTokens.Spacing.xl,
            right: DesignTokens.Spacing.xl,
            top: DesignTokens.Spacing.xs,
            bottom: DesignTokens.Spacing.xs
          })
          .backgroundColor(DesignTokens.Colors.secondary)
          .borderRadius(18)
          .onClick(() => {})
      }
      .width('100%')
      .padding({
        left: DesignTokens.Spacing.lg,
        right: DesignTokens.Spacing.lg,
        top: DesignTokens.Spacing.md,
        bottom: DesignTokens.Spacing.md
      })
    }
    .width('100%')
    .height(80)
  }
}

// MARK: - Data Models
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

// MARK: - Design Tokens
namespace DesignTokens {
  export namespace Colors {
    export const primary: string = '#7C4DFF'
    export const secondary: string = '#08D6FF'
    export const tertiary: string = '#FF8E3C'
    export const background: string = '#05030A'
    export const surface: string = '#0D0616'
    export const surfaceVariant: string = '#1A0F2C'
    export const outline: string = '#3A2759'
    export const success: string = '#56F0A6'
    export const warning: string = '#FFC857'
    export const error: string = '#FF5B7A'
    export const onPrimary: string = '#05030A'
    export const onSecondary: string = '#05030A'
    export const onTertiary: string = '#120601'
    export const onBackground: string = '#F4ECFF'
    export const onSurface: string = '#F8F4FF'
  }

  export namespace Spacing {
    export const xxs: number = 4
    export const xs: number = 8
    export const sm: number = 12
    export const md: number = 16
    export const lg: number = 20
    export const xl: number = 28
    export const xxl: number = 40
    export const xxxl: number = 56
  }
}
