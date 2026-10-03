const NAME: string = "128*MacroTrainer*en";
const UI_TYPE: string = "Workout";
const STYLE_THEME: string = "Dark Neon";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";
const COLOR_PALETTE: string = "primary:#7C4DFF secondary:#08D6FF tertiary:#FF8E3C background:#05030A surface:#0D0616 surfaceVariant:#1A0F2C outline:#3A2759 success:#56F0A6 warning:#FFC857 error:#FF5B7A onPrimary:#05030A onSecondary:#05030A onTertiary:#120601 onBackground:#F4ECFF onSurface:#F8F4FF";
const DENSITY_SPACING: string = "Compact";
const COMPLEXITY: string = "Timer,ProgressRing,CTA";
const EXTRA: string = "Neon macro workout controller";

class AppColors {
  static readonly primary: string = '#7C4DFF';
  static readonly secondary: string = '#08D6FF';
  static readonly tertiary: string = '#FF8E3C';
  static readonly background: string = '#05030A';
  static readonly surface: string = '#0D0616';
  static readonly surfaceVariant: string = '#1A0F2C';
  static readonly outline: string = '#3A2759';
  static readonly onPrimary: string = '#05030A';
  static readonly onSecondary: string = '#05030A';
  static readonly onBackground: string = '#F4ECFF';
  static readonly onSurface: string = '#F8F4FF';
}

class AppSpacing {
  static readonly xxs: number = 4;
  static readonly xs: number = 8;
  static readonly sm: number = 12;
  static readonly md: number = 16;
  static readonly lg: number = 20;
  static readonly xl: number = 28;
}

class MacroSet {
  title: string;
  reps: string;
  phase: string;

  constructor(title: string, reps: string, phase: string) {
    this.title = title;
    this.reps = reps;
    this.phase = phase;
  }
}

class PerformanceMetric {
  label: string;
  value: string;
  change: string;

  constructor(label: string, value: string, change: string) {
    this.label = label;
    this.value = value;
    this.change = change;
  }
}

@Entry
@Component
struct MainActivity {
  @State timerValue: string = '02:34';
  @State targetPhase: string = 'Macro tempo';

  private sets: MacroSet[] = [
    new MacroSet('Warm circuit', '3 sets', 'Energy'),
    new MacroSet('Core push', '4 rounds', 'Explosive'),
    new MacroSet('Cooldown flow', '6 min', 'Calm')
  ];
  private metrics: PerformanceMetric[] = [
    new PerformanceMetric('Load', '72%', '+4%'),
    new PerformanceMetric('VO2', '41', '+1'),
    new PerformanceMetric('Focus', '88%', 'stable')
  ];

  @Builder
  TopBar() {
    Row() {
      Blank()
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
          .fontColor(AppColors.onSurface)
          .opacity(0.7)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      Blank()
        .width(24)
        .height(24)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(12)
    }
    .width('100%')
    .height(68)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#F20D0616')
  }

  @Builder
  TimerPanel() {
    Column({ space: AppSpacing.sm }) {
      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(160)
          .height(160)
          .fill(AppColors.surface)
          .stroke(AppColors.primary)
          .strokeWidth(10)
          .shadow({ radius: 18, color: '#667C4DFF', offsetY: 0 })
        Circle()
          .width(132)
          .height(132)
          .fill(AppColors.surface)
          .stroke(AppColors.secondary)
          .strokeWidth(4)
        Column() {
          Text(this.timerValue)
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onSurface)
          Text('Timer')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .opacity(0.7)
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(170)
      .height(170)

      Row({ space: AppSpacing.xxs }) {
        ForEach(['Macro', 'Tempo', 'Breath'], (tag: string) => {
          Text(tag)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .padding({ left: AppSpacing.xs, right: AppSpacing.xs, top: AppSpacing.xxs, bottom: AppSpacing.xxs })
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(8)
        })
      }
    }
    .layoutWeight(1)
    .padding(AppSpacing.md)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(28)
    .shadow({ radius: 8, color: '#38000000', offsetY: 4 })
  }

  @Builder
  MetricTile(metric: PerformanceMetric) {
    Column({ space: AppSpacing.xxs }) {
      Text(metric.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
      Text(metric.value)
        .fontSize(22)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.secondary)
      Text(metric.change)
        .fontSize(14)
        .fontColor(AppColors.onSurface)
        .opacity(0.7)
    }
    .width('100%')
    .padding(AppSpacing.sm)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(18)
  }

  @Builder
  SetRow(set: MacroSet) {
    Row() {
      Column({ space: AppSpacing.xxs }) {
        Text(set.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(set.phase)
          .fontSize(14)
          .fontColor(AppColors.onSurface)
          .opacity(0.7)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Column({ space: AppSpacing.xxs }) {
        Text(set.reps)
          .fontSize(22)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.primary)
        Button('Start')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .height(30)
          .backgroundColor(AppColors.secondary)
          .borderRadius(8)
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor('#E61A0F2C')
    .borderRadius(18)
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: AppSpacing.xxs }) {
        Text('Next macro')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(this.targetPhase)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button('Prime')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .height(42)
        .padding({ left: AppSpacing.xl, right: AppSpacing.xl })
        .backgroundColor(AppColors.secondary)
        .borderRadius(18)
    }
    .width('100%')
    .height(76)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surfaceVariant)
    .shadow({ radius: 12, color: '#42000000', offsetY: -4 })
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Row({ space: AppSpacing.sm }) {
            this.TimerPanel()
            Column({ space: AppSpacing.sm }) {
              ForEach(this.metrics, (metric: PerformanceMetric) => {
                this.MetricTile(metric)
              })
            }
            .width(120)
          }
          .width('100%')

          ForEach(this.sets, (set: MacroSet) => {
            this.SetRow(set)
          })
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
