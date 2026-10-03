const Colors = {
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
}

const Spacing = {
  xxs: 4,
  xs: 8,
  sm: 12,
  md: 16,
  lg: 20,
  xl: 28,
  xxl: 40,
  xxxl: 56,
}

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

@Entry
@Component
struct Index {
  @State timerValue: string = '02:34'
  @State targetPhase: string = 'Macro tempo'
  private sets: MacroSet[] = [
    { title: 'Warm circuit', reps: '3 sets', phase: 'Energy' },
    { title: 'Core push', reps: '4 rounds', phase: 'Explosive' },
    { title: 'Cooldown flow', reps: '6 min', phase: 'Calm' },
  ]
  private metrics: PerformanceMetric[] = [
    { label: 'Load', value: '72%', change: '+4%' },
    { label: 'VO2', value: '41', change: '+1' },
    { label: 'Focus', value: '88%', change: 'stable' },
  ]

  build() {
    Column() {
      Row() {
        Blank()
          .width(24)
          .height(24)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(12)
        Column({ space: Spacing.xxs }) {
          Text('MacroTrainer')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text('Neon workout stack')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        Blank()
          .width(24)
          .height(24)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(12)
      }
      .width('100%')
      .height(56)
      .padding({ left: Spacing.lg, right: Spacing.lg })
      .backgroundColor(Colors.surface)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column({ space: Spacing.lg }) {
          Row({ space: Spacing.sm }) {
            Column({ space: Spacing.sm }) {
              Stack({ alignContent: Alignment.Center }) {
                Blank()
                  .width(160)
                  .height(160)
                  .borderRadius(80)
                  .linearGradient({
                    direction: GradientDirection.Right,
                    colors: [[Colors.primary, 0], [Colors.secondary, 0.5], [Colors.tertiary, 1]]
                  })
                Column({ space: Spacing.xs }) {
                  Text(this.timerValue)
                    .fontSize(32)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Colors.onSurface)
                  Text('Timer')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                }
                .width(140)
                .height(140)
                .borderRadius(70)
                .backgroundColor(Colors.surface)
                .justifyContent(FlexAlign.Center)
              }
              Row({ space: Spacing.xxs }) {
                ForEach(['Macro', 'Tempo', 'Breath'], (tag: string) => {
                  Text(tag)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                    .padding({ left: Spacing.xs, right: Spacing.xs, top: Spacing.xxs, bottom: Spacing.xxs })
                    .backgroundColor(Colors.surfaceVariant)
                    .borderRadius(8)
                }, (tag: string) => tag)
              }
            }
            .layoutWeight(1)
            .padding(Spacing.md)
            .backgroundColor(Colors.surface)
            .borderRadius(28)
            .alignItems(HorizontalAlign.Center)

            Column({ space: Spacing.sm }) {
              ForEach(this.metrics, (metric: PerformanceMetric) => {
                Column({ space: Spacing.xxs }) {
                  Text(metric.label)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                  Text(metric.value)
                    .fontSize(22)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Colors.secondary)
                  Text(metric.change)
                    .fontSize(14)
                    .fontColor(Colors.onSurface)
                }
                .width('100%')
                .padding(Spacing.sm)
                .backgroundColor(Colors.surfaceVariant)
                .borderRadius(18)
                .alignItems(HorizontalAlign.Start)
              }, (metric: PerformanceMetric) => metric.label)
            }
            .width(120)
          }
          .width('100%')

          ForEach(this.sets, (set: MacroSet) => {
            Row() {
              Column({ space: Spacing.xxs }) {
                Text(set.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                Text(set.phase)
                  .fontSize(14)
                  .fontColor(Colors.onSurface)
              }
              .alignItems(HorizontalAlign.Start)

              Column({ space: Spacing.xxs }) {
                Text(set.reps)
                  .fontSize(22)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Colors.primary)
                Button('Start')
                  .type(ButtonType.Normal)
                  .fontSize(12)
                  .fontColor(Colors.onSecondary)
                  .backgroundColor(Colors.secondary)
                  .borderRadius(8)
                  .padding({ left: Spacing.xs, right: Spacing.xs, top: Spacing.xxs, bottom: Spacing.xxs })
                  .onClick(() => {})
              }
              .alignItems(HorizontalAlign.End)
            }
            .width('100%')
            .padding(Spacing.md)
            .backgroundColor(Colors.surfaceVariant)
            .borderRadius(18)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
          }, (set: MacroSet) => set.title)
        }
        .layoutWeight(1)
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .width('100%')
        .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
      }
      .layoutWeight(1)
      .width('100%')

      Row() {
        Column({ space: Spacing.xxs }) {
          Text('Next macro')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text(this.targetPhase)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Button('Prime')
          .type(ButtonType.Normal)
          .fontSize(16)
          .fontColor(Colors.onSecondary)
          .backgroundColor(Colors.secondary)
          .borderRadius(18)
          .padding({ left: Spacing.xl, right: Spacing.xl, top: Spacing.xs, bottom: Spacing.xs })
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
      .backgroundColor(Colors.surfaceVariant)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
