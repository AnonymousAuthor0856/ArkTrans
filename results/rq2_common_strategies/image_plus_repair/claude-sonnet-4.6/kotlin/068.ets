interface MacroSetData {
  title: string
  reps: string
  phase: string
}

interface PerformanceMetricData {
  label: string
  value: string
  change: string
}

const colorPrimary: string = '#7C4DFF'
const colorSecondary: string = '#08D6FF'
const colorTertiary: string = '#FF8E3C'
const colorBackground: string = '#05030A'
const colorSurface: string = '#0D0616'
const colorSurfaceVariant: string = '#1A0F2C'
const colorOnSecondary: string = '#05030A'
const colorOnSurface: string = '#F8F4FF'
const colorOnSurfaceDim: string = '#B0A8C8'

const spacingXxs: number = 4
const spacingXs: number = 8
const spacingSm: number = 12
const spacingMd: number = 16
const spacingLg: number = 20
const spacingXl: number = 28

@Component
struct MetricCard {
  label: string = ''
  value: string = ''
  change: string = ''

  build() {
    Column({ space: spacingXxs }) {
      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(colorOnSurface)
      Text(this.value)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(colorSecondary)
      Text(this.change)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(colorOnSurfaceDim)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(spacingSm)
    .backgroundColor(colorSurfaceVariant)
    .borderRadius(18)
  }
}

@Component
struct MacroSetCard {
  title: string = ''
  reps: string = ''
  phase: string = ''

  build() {
    Row() {
      Column({ space: spacingXxs }) {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(colorOnSurface)
        Text(this.phase)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(colorOnSurfaceDim)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column({ space: spacingXxs }) {
        Text(this.reps)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(colorPrimary)
        Button('Start')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(colorOnSecondary)
          .backgroundColor(colorSecondary)
          .borderRadius(8)
          .padding({ left: spacingXs, right: spacingXs, top: spacingXxs, bottom: spacingXxs })
          .height(32)
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding(spacingMd)
    .backgroundColor(colorSurfaceVariant)
    .borderRadius(18)
  }
}

@Component
struct TimerRing {
  timerValue: string = '02:34'

  build() {
    Stack() {
      Circle()
        .width(160)
        .height(160)
        .fill(colorSurface)
        .stroke(colorPrimary)
        .strokeWidth(10)

      Column({ space: spacingXxs }) {
        Text(this.timerValue)
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(colorOnSurface)
        Text('Timer')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(colorOnSurfaceDim)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(160)
    .height(160)
  }
}

@Entry
@Component
struct Index {
  private sets: MacroSetData[] = [
    { title: 'Warm circuit', reps: '3 sets', phase: 'Energy' },
    { title: 'Core push', reps: '4 rounds', phase: 'Explosive' },
    { title: 'Cooldown flow', reps: '6 min', phase: 'Calm' }
  ]
  private metrics: PerformanceMetricData[] = [
    { label: 'Load', value: '72%', change: '+4%' },
    { label: 'VO2', value: '41', change: '+1' },
    { label: 'Focus', value: '88%', change: 'stable' }
  ]
  @State timerValue: string = '02:34'
  @State targetPhase: string = 'Macro tempo'
  private tags: string[] = ['Macro', 'Tempo', 'Breath']

  build() {
    Column() {
      // Top App Bar
      Row() {
        Stack() {
          Circle()
            .width(24)
            .height(24)
            .fill(colorSurfaceVariant)
        }
        .width(24)
        .height(24)

        Column({ space: 2 }) {
          Text('MacroTrainer')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(colorOnSurface)
          Text('Neon workout stack')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(colorOnSurfaceDim)
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)

        Stack() {
          Circle()
            .width(24)
            .height(24)
            .fill(colorSurfaceVariant)
        }
        .width(24)
        .height(24)
      }
      .width('100%')
      .padding({ left: spacingLg, right: spacingLg, top: spacingMd, bottom: spacingMd })
      .backgroundColor(colorSurface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Scrollable content
      Scroll() {
        Column({ space: spacingLg }) {
          // Timer + Metrics Row
          Row({ space: spacingSm }) {
            // Timer Card
            Column({ space: spacingSm }) {
              TimerRing({ timerValue: this.timerValue })

              Row({ space: spacingXxs }) {
                ForEach(this.tags, (tag: string) => {
                  Text(tag)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(colorOnSurface)
                    .padding({ left: spacingXs, right: spacingXs, top: spacingXxs, bottom: spacingXxs })
                    .backgroundColor(colorSurfaceVariant)
                    .borderRadius(8)
                })
              }
            }
            .alignItems(HorizontalAlign.Center)
            .layoutWeight(1)
            .padding(spacingMd)
            .backgroundColor(colorSurface)
            .borderRadius(28)

            // Metrics Column
            Column({ space: spacingSm }) {
              ForEach(this.metrics, (metric: PerformanceMetricData) => {
                MetricCard({
                  label: metric.label,
                  value: metric.value,
                  change: metric.change
                })
              })
            }
            .width(120)
          }
          .width('100%')
          .alignItems(VerticalAlign.Top)

          // Macro Set Cards
          ForEach(this.sets, (set: MacroSetData) => {
            MacroSetCard({
              title: set.title,
              reps: set.reps,
              phase: set.phase
            })
          })
        }
        .padding({ left: spacingLg, right: spacingLg, top: spacingMd, bottom: spacingMd })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Bar
      Row() {
        Column({ space: spacingXxs }) {
          Text('Next macro')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(colorOnSurface)
          Text(this.targetPhase)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(colorOnSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Button('Prime')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(colorOnSecondary)
          .backgroundColor(colorSecondary)
          .borderRadius(18)
          .padding({ left: spacingXl, right: spacingXl, top: spacingXs, bottom: spacingXs })
          .height(48)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: spacingLg, right: spacingLg, top: spacingMd, bottom: spacingMd })
      .backgroundColor(colorSurfaceVariant)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(colorBackground)
  }
}