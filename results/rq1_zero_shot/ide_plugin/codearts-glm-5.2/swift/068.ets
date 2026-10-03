class DesignTokens {
  static readonly Colors = {
    primary: '#FF7C4DFF',
    secondary: '#FF08D6FF',
    tertiary: '#FFFF8E3C',
    background: '#FF05030A',
    surface: '#FF0D0616',
    surfaceVariant: '#FF1A0F2C',
    outline: '#FF3A2759',
    success: '#FF56F0A6',
    warning: '#FFFFC857',
    error: '#FFFF5B7A',
    onPrimary: '#FF05030A',
    onSecondary: '#FF05030A',
    onTertiary: '#FF120601',
    onBackground: '#FFF4ECFF',
    onSurface: '#FFF8F4FF',
  }
  static readonly Spacing = {
    xxs: 4,
    xs: 8,
    sm: 12,
    md: 16,
    lg: 20,
    xl: 28,
    xxl: 40,
    xxxl: 56,
  }
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
struct MetricCard {
  @Prop label: string
  @Prop value: string
  @Prop change: string

  build() {
    Column({ space: DesignTokens.Spacing.xxs }) {
      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(DesignTokens.Colors.onSurface)

      Text(this.value)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(DesignTokens.Colors.secondary)

      Text(this.change)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor('#B3F8F4FF')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(DesignTokens.Spacing.sm)
    .backgroundColor(DesignTokens.Colors.surfaceVariant)
    .borderRadius(18)
  }
}

@Component
struct SetListItemView {
  @Prop title: string
  @Prop reps: string
  @Prop phase: string

  build() {
    Row() {
      Column({ space: DesignTokens.Spacing.xxs }) {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)

        Text(this.phase)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#B3F8F4FF')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column({ space: DesignTokens.Spacing.xxs }) {
        Text(this.reps)
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.primary)

        Button('Start')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSecondary)
          .padding({ left: DesignTokens.Spacing.xs, right: DesignTokens.Spacing.xs, top: DesignTokens.Spacing.xxs, bottom: DesignTokens.Spacing.xxs })
          .backgroundColor(DesignTokens.Colors.secondary)
          .borderRadius(8)
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(DesignTokens.Spacing.md)
    .backgroundColor('#E61A0F2C')
    .borderRadius(18)
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
    new MacroSet('Cooldown flow', '6 min', 'Calm'),
  ]
  private metrics: PerformanceMetric[] = [
    new PerformanceMetric('Load', '72%', '+4%'),
    new PerformanceMetric('VO2', '41', '+1'),
    new PerformanceMetric('Focus', '88%', 'stable'),
  ]
  private tags: string[] = ['Macro', 'Tempo', 'Breath']
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  private drawRing() {
    const ctx = this.canvasContext
    const cx = 80
    const cy = 80
    const radius = 75
    ctx.clearRect(0, 0, 160, 160)
    const grad = ctx.createLinearGradient(0, 0, 160, 160)
    grad.addColorStop(0, DesignTokens.Colors.primary)
    grad.addColorStop(0.33, DesignTokens.Colors.secondary)
    grad.addColorStop(0.66, DesignTokens.Colors.tertiary)
    grad.addColorStop(1, DesignTokens.Colors.primary)
    ctx.strokeStyle = grad
    ctx.lineWidth = 10
    ctx.beginPath()
    ctx.arc(cx, cy, radius, 0, Math.PI * 2)
    ctx.stroke()
  }

  build() {
    Column() {
      Row() {
        Column()
          .width(24)
          .height(24)
          .backgroundColor(DesignTokens.Colors.surfaceVariant)
          .borderRadius(12)

        Blank()

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

        Blank()

        Column()
          .width(24)
          .height(24)
          .backgroundColor(DesignTokens.Colors.surfaceVariant)
          .borderRadius(12)
      }
      .width('100%')
      .height(60)
      .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
      .backgroundColor('#F20D0616')

      Scroll() {
        Column({ space: DesignTokens.Spacing.lg }) {
          Row({ space: DesignTokens.Spacing.sm }) {
            Column({ space: DesignTokens.Spacing.sm }) {
              Stack() {
                Canvas(this.canvasContext)
                  .width(160)
                  .height(160)
                  .onReady(() => {
                    this.drawRing()
                  })

                Column({ space: 4 }) {
                  Text(this.timerValue)
                    .fontSize(32)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(DesignTokens.Colors.onSurface)
                  Text('Timer')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#B3F8F4FF')
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
                    .padding({ left: DesignTokens.Spacing.xs, right: DesignTokens.Spacing.xs, top: DesignTokens.Spacing.xxs, bottom: DesignTokens.Spacing.xxs })
                    .backgroundColor(DesignTokens.Colors.surfaceVariant)
                    .borderRadius(8)
                })
              }
            }
            .padding(DesignTokens.Spacing.md)
            .backgroundColor(DesignTokens.Colors.surface)
            .borderRadius(28)
            .shadow({ radius: 6, color: '#42000000', offsetY: 4 })
            .layoutWeight(1)

            Column({ space: DesignTokens.Spacing.sm }) {
              ForEach(this.metrics, (m: PerformanceMetric) => {
                MetricCard({ label: m.label, value: m.value, change: m.change })
              })
            }
            .width(120)
          }
          .width('100%')

          ForEach(this.sets, (s: MacroSet) => {
            SetListItemView({ title: s.title, reps: s.reps, phase: s.phase })
          })
        }
        .width('100%')
        .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .width('100%')

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
        .layoutWeight(1)

        Button('Prime')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSecondary)
          .padding({ left: DesignTokens.Spacing.xl, right: DesignTokens.Spacing.xl, top: DesignTokens.Spacing.xs, bottom: DesignTokens.Spacing.xs })
          .backgroundColor(DesignTokens.Colors.secondary)
          .borderRadius(18)
      }
      .width('100%')
      .height(80)
      .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
      .backgroundColor(DesignTokens.Colors.surfaceVariant)
      .shadow({ radius: 12, color: '#42000000', offsetY: -6 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.Colors.background)
  }
}