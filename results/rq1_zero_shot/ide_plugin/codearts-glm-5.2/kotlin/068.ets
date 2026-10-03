const AppColors = {
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
  onSurfaceAlpha70: '#B3F8F4FF',
  surfaceAlpha95: '#F20D0616',
  surfaceVariantAlpha90: '#E61A0F2C',
}

const AppSpacing = {
  xxs: 4,
  xs: 8,
  sm: 12,
  md: 16,
  lg: 20,
  xl: 28,
  xxl: 40,
  xxxl: 56,
}

const AppShapes = {
  small: 8,
  medium: 18,
  large: 28,
}

class MacroSet {
  title: string = ''
  reps: string = ''
  phase: string = ''
  constructor(title: string, reps: string, phase: string) {
    this.title = title
    this.reps = reps
    this.phase = phase
  }
}

class PerformanceMetric {
  label: string = ''
  value: string = ''
  change: string = ''
  constructor(label: string, value: string, change: string) {
    this.label = label
    this.value = value
    this.change = change
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

  @Builder
  TagBuilder(tag: string) {
    Text(tag)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppColors.onSurface)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.small)
      .padding({ left: AppSpacing.xs, right: AppSpacing.xs, top: AppSpacing.xxs, bottom: AppSpacing.xxs })
  }

  @Builder
  MetricCardBuilder(metric: PerformanceMetric) {
    Column() {
      Text(metric.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
      Text(metric.value)
        .fontSize(22)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.secondary)
        .margin({ top: AppSpacing.xxs })
      Text(metric.change)
        .fontSize(14)
        .fontColor(AppColors.onSurfaceAlpha70)
        .margin({ top: AppSpacing.xxs })
    }
    .width('100%')
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.medium)
    .padding(AppSpacing.sm)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  TimerCircleBuilder() {
    Stack() {
      Column() {}
        .width(160)
        .height(160)
        .borderRadius(80)
        .sweepGradient({
          center: [80, 80],
          colors: [[AppColors.primary, 0], [AppColors.secondary, 0.33], [AppColors.tertiary, 0.66], [AppColors.primary, 1]]
        })

      Column() {
        Text(this.timerValue)
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
        Text('Timer')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurfaceAlpha70)
          .margin({ top: AppSpacing.xxs })
      }
      .width(140)
      .height(140)
      .borderRadius(70)
      .backgroundColor(AppColors.surface)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width(160)
    .height(160)
    .alignContent(Alignment.Center)
  }

  @Builder
  MacroSetRowBuilder(set: MacroSet) {
    Row() {
      Column() {
        Text(set.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(set.phase)
          .fontSize(14)
          .fontColor(AppColors.onSurfaceAlpha70)
          .margin({ top: AppSpacing.xxs })
      }
      .alignItems(HorizontalAlign.Start)

      Column() {
        Text(set.reps)
          .fontSize(22)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.primary)
        Button('Start') {
          Text('Start')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
        }
          .type(ButtonType.Normal)
          .backgroundColor(AppColors.secondary)
          .borderRadius(AppShapes.small)
          .padding({ left: AppSpacing.xs, right: AppSpacing.xs, top: AppSpacing.xxs, bottom: AppSpacing.xxs })
          .height(32)
          .margin({ top: AppSpacing.xxs })
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surfaceVariantAlpha90)
    .borderRadius(AppShapes.medium)
  }

  build() {
    Column() {
      Row() {
        Column() {}
          .width(24)
          .height(24)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(12)

        Column() {
          Text('MacroTrainer')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text('Neon workout stack')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurfaceAlpha70)
            .margin({ top: 2 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Column() {}
          .width(24)
          .height(24)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(12)
      }
      .width('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
      .backgroundColor(AppColors.surfaceAlpha95)

      List({ space: AppSpacing.lg }) {
        ListItem() {
          Row() {
            Column() {
              this.TimerCircleBuilder()
              Row() {
                ForEach(this.tags, (tag: string) => {
                  this.TagBuilder(tag)
                }, (tag: string) => tag)
              }
              .margin({ top: AppSpacing.sm })
              .justifyContent(FlexAlign.Center)
            }
            .layoutWeight(1)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.large)
            .padding(AppSpacing.md)
            .alignItems(HorizontalAlign.Center)

            Column() {
              ForEach(this.metrics, (metric: PerformanceMetric) => {
                this.MetricCardBuilder(metric)
              }, (metric: PerformanceMetric) => metric.label)
            }
            .width(120)
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }

        ForEach(this.sets, (set: MacroSet) => {
          ListItem() {
            this.MacroSetRowBuilder(set)
          }
        }, (set: MacroSet) => set.title)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })

      Row() {
        Column() {
          Text('Next macro')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text(this.targetPhase)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .margin({ top: AppSpacing.xxs })
        }
        .alignItems(HorizontalAlign.Start)

        Button('Prime') {
          Text('Prime')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
        }
          .type(ButtonType.Normal)
          .backgroundColor(AppColors.secondary)
          .borderRadius(AppShapes.medium)
          .padding({ left: AppSpacing.xl, right: AppSpacing.xl, top: AppSpacing.xs, bottom: AppSpacing.xs })
      }
      .width('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
      .backgroundColor(AppColors.surfaceVariant)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}