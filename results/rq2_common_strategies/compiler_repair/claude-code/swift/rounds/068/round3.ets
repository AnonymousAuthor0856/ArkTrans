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
            .margin({ top: 0 })
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
  private sets: MacroSet[] = []
  private metrics: PerformanceMetric[] = []
  private tags: string[] = []
  @State timerValue: string = ""

  build() {
    Scroll() {
      Column() {
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
  private tags: string[] = []
  private metrics: PerformanceMetric[] = []
  @State timerValue: string = ""

  build() {
    Row() {
      TimerRing({ timerValue: this.timerValue, tags: this.tags })
        .layoutWeight(1)
      MetricsColumn({ metrics: this.metrics })
    }
    .width('100%')
  }
}

@Component
struct TimerRing {
  private tags: string[] = []
  @State timerValue: string = ""

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(DesignTokens.Colors.surface)
        .borderRadius(28)
        .shadow({
          radius: 6,
          color: 'rgba(0, 0, 0, 0.26)',
          offsetX: 0,
          offsetY: 4
        })

      Column() {
        Stack() {
          // Circular progress ring
          Progress({ value: 65, total: 100, type: ProgressType.Ring })
            .width(160)
            .height(160)
            .color(DesignTokens.Colors.primary)
            .backgroundColor(DesignTokens.Colors.surfaceVariant)
            .style({ strokeWidth: 10 })

          Column() {
            Text(this.timerValue)
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor(DesignTokens.Colors.onSurface)

            Text("Timer")
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(DesignTokens.Colors.onSurface)
              .opacity(0.7)
              .margin({ top: 4 })
          }
        }
        .alignContent(Alignment.Center)

        Row() {
          ForEach(this.tags, (tag: string) => {
            Text(tag)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .padding({ left: DesignTokens.Spacing.xs, right: DesignTokens.Spacing.xs, top: DesignTokens.Spacing.xxs, bottom: DesignTokens.Spacing.xxs })
              .backgroundColor(DesignTokens.Colors.surfaceVariant)
              .fontColor(DesignTokens.Colors.onSurface)
              .borderRadius(8)
              .margin({ right: DesignTokens.Spacing.xxs })
          }, (tag: string) => tag)
        }
        .margin({ top: DesignTokens.Spacing.sm })
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
  private metrics: PerformanceMetric[] = []

  build() {
    Column() {
      ForEach(this.metrics, (metric: PerformanceMetric) => {
        MetricCard({ metric: metric })
          .margin({ bottom: DesignTokens.Spacing.sm })
      }, (metric: PerformanceMetric) => metric.label)
    }
    .width(120)
  }
}

@Component
struct MetricCard {
  private metric: PerformanceMetric = { label: "", value: "", change: "" }

  build() {
    Column() {
      Text(this.metric.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(DesignTokens.Colors.onSurface)

      Text(this.metric.value)
        .fontSize(22)
        .fontWeight(600)
        .fontColor(DesignTokens.Colors.secondary)
        .margin({ top: DesignTokens.Spacing.xxs })

      Text(this.metric.change)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
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
  private sets: MacroSet[] = []

  build() {
    Column() {
      ForEach(this.sets, (set: MacroSet) => {
        SetListItemView({ set: set })
          .margin({ bottom: DesignTokens.Spacing.sm })
      }, (set: MacroSet) => set.title)
    }
    .width('100%')
  }
}

@Component
struct SetListItemView {
  private set: MacroSet = { title: "", reps: "", phase: "" }

  build() {
    Row() {
      Column() {
        Text(this.set.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)

        Text(this.set.phase)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(DesignTokens.Colors.onSurface)
          .opacity(0.7)
          .margin({ top: DesignTokens.Spacing.xxs })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Column() {
        Text(this.set.reps)
          .fontSize(22)
          .fontWeight(600)
          .fontColor(DesignTokens.Colors.primary)

        Button("Start")
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSecondary)
          .backgroundColor(DesignTokens.Colors.secondary)
          .borderRadius(8)
          .height(24)
          .padding({ left: DesignTokens.Spacing.xs, right: DesignTokens.Spacing.xs })
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
  @State targetPhase: string = ""

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(DesignTokens.Colors.surfaceVariant)
        .shadow({
          radius: 12,
          color: 'rgba(0, 0, 0, 0.26)',
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
          .height(40)
          .padding({ left: DesignTokens.Spacing.xl, right: DesignTokens.Spacing.xl })
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
  static Colors: ColorSet = {
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

  static Spacing: SpacingSet = {
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

interface ColorSet {
  primary: ResourceColor
  secondary: ResourceColor
  tertiary: ResourceColor
  background: ResourceColor
  surface: ResourceColor
  surfaceVariant: ResourceColor
  outline: ResourceColor
  success: ResourceColor
  warning: ResourceColor
  error: ResourceColor
  onPrimary: ResourceColor
  onSecondary: ResourceColor
  onTertiary: ResourceColor
  onBackground: ResourceColor
  onSurface: ResourceColor
}

interface SpacingSet {
  xxs: Length
  xs: Length
  sm: Length
  md: Length
  lg: Length
  xl: Length
  xxl: Length
  xxxl: Length
}
