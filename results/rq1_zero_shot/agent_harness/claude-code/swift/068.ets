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
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(DesignTokens.Colors.background)

      Column() {
        TopAppBar()
        MainContent({ sets: this.sets, metrics: this.metrics, tags: this.tags, timerValue: this.timerValue })
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

        Blank()

        Column({ space: 0 }) {
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
        .alignItems(HorizontalAlign.Center)

        Blank()

        Circle()
          .width(24)
          .height(24)
          .fill(DesignTokens.Colors.surfaceVariant)
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
    }
    .width('100%')
    .height(60)
  }
}

// MARK: - Main Content
@Component
struct MainContent {
  @Link sets: MacroSet[]
  @Link metrics: PerformanceMetric[]
  @Link tags: string[]
  @Link timerValue: string

  build() {
    Scroll() {
      Column({ space: DesignTokens.Spacing.lg }) {
        TimerSection({ tags: this.tags, metrics: this.metrics, timerValue: this.timerValue })
        SetsListSection({ sets: this.sets })
      }
      .width('100%')
      .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.None)
  }
}

// MARK: - Timer Section
@Component
struct TimerSection {
  @Link tags: string[]
  @Link metrics: PerformanceMetric[]
  @Link timerValue: string

  build() {
    Row({ space: DesignTokens.Spacing.sm }) {
      TimerRing({ timerValue: this.timerValue, tags: this.tags })
        .layoutWeight(1)
      MetricsColumn({ metrics: this.metrics })
    }
    .width('100%')
  }
}

@Component
struct TimerRing {
  @Link timerValue: string
  @Link tags: string[]

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
          offsetX: 0,
          offsetY: 4
        })

      Column({ space: DesignTokens.Spacing.sm }) {
        Stack() {
          // Gradient ring using Circle with sweep gradient stroke
          Circle()
            .width(160)
            .height(160)
            .stroke(
              {
                color: DesignTokens.Colors.primary,
                width: 10
              }
            )
            .fill(Color.Transparent)

          // Draw gradient effect with multiple arc segments
          Canvas() {
            Arc(
              { x: 0, y: 0, width: 160, height: 160, startAngle: -90, endAngle: 180 }
            )
              .stroke({ color: DesignTokens.Colors.primary, width: 10 })
            Arc(
              { x: 0, y: 0, width: 160, height: 160, startAngle: 90, endAngle: 180 }
            )
              .stroke({ color: DesignTokens.Colors.secondary, width: 10 })
            Arc(
              { x: 0, y: 0, width: 160, height: 160, startAngle: 270, endAngle: 90 }
            )
              .stroke({ color: DesignTokens.Colors.tertiary, width: 10 })
          }
          .width(160)
          .height(160)

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
        .alignContent(Alignment.Center)

        Row({ space: DesignTokens.Spacing.xxs }) {
          ForEach(this.tags, (tag: string) => {
            Text(tag)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .padding({ left: DesignTokens.Spacing.xs, right: DesignTokens.Spacing.xs, top: DesignTokens.Spacing.xxs, bottom: DesignTokens.Spacing.xxs })
              .backgroundColor(DesignTokens.Colors.surfaceVariant)
              .fontColor(DesignTokens.Colors.onSurface)
              .borderRadius(8)
          }, (tag: string) => tag)
        }
      }
      .padding(DesignTokens.Spacing.md)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .aspectRatio(1)
  }
}

@Component
struct MetricsColumn {
  @Link metrics: PerformanceMetric[]

  build() {
    Column({ space: DesignTokens.Spacing.sm }) {
      ForEach(this.metrics, (metric: PerformanceMetric) => {
        MetricCard({ metric: metric })
      }, (metric: PerformanceMetric) => metric.label)
    }
    .width(120)
  }
}

@Component
struct MetricCard {
  @Link metric: PerformanceMetric

  build() {
    Column() {
      Text(this.metric.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(DesignTokens.Colors.onSurface)

      Text(this.metric.value)
        .fontSize(22)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(DesignTokens.Colors.secondary)
        .margin({ top: DesignTokens.Spacing.xxs })

      Text(this.metric.change)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(DesignTokens.Colors.onSurface)
        .opacity(0.7)
        .margin({ top: DesignTokens.Spacing.xxs })
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
  @Link sets: MacroSet[]

  build() {
    Column({ space: DesignTokens.Spacing.sm }) {
      ForEach(this.sets, (set: MacroSet) => {
        SetListItemView({ set: set })
      }, (set: MacroSet) => set.title)
    }
    .width('100%')
  }
}

@Component
struct SetListItemView {
  @Link set: MacroSet

  build() {
    Row() {
      Column() {
        Text(this.set.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)

        Text(this.set.phase)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(DesignTokens.Colors.onSurface)
          .opacity(0.7)
          .margin({ top: DesignTokens.Spacing.xxs })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Column() {
        Text(this.set.reps)
          .fontSize(22)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(DesignTokens.Colors.primary)

        Button("Start")
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSecondary)
          .backgroundColor(DesignTokens.Colors.secondary)
          .borderRadius(8)
          .padding({ left: DesignTokens.Spacing.xs, right: DesignTokens.Spacing.xs, top: DesignTokens.Spacing.xxs, bottom: DesignTokens.Spacing.xxs })
          .height(24)
          .onClick(() => {})
          .margin({ top: DesignTokens.Spacing.xxs })
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
  @Link targetPhase: string

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(DesignTokens.Colors.surfaceVariant)
        .shadow({
          radius: 12,
          color: '#42000000',
          offsetX: 0,
          offsetY: -6
        })

      Row() {
        Column() {
          Text("Next macro")
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface)

          Text(this.targetPhase)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface)
            .margin({ top: DesignTokens.Spacing.xxs })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button("Prime")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSecondary)
          .backgroundColor(DesignTokens.Colors.secondary)
          .borderRadius(18)
          .padding({ left: DesignTokens.Spacing.xl, right: DesignTokens.Spacing.xl, top: DesignTokens.Spacing.xs, bottom: DesignTokens.Spacing.xs })
          .height(40)
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
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
class DesignTokens {
  static Colors = {
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
  }

  static Spacing = {
    xxs: 4,
    xs: 8,
    sm: 12,
    md: 16,
    lg: 20,
    xl: 28,
    xxl: 40,
    xxxl: 56
  }
}
