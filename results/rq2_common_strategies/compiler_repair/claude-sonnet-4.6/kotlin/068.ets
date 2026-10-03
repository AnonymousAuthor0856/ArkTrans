import { router } from '@kit.ArkUI';

class MacroSet {
  title: string = '';
  reps: string = '';
  phase: string = '';

  constructor(title: string, reps: string, phase: string) {
    this.title = title;
    this.reps = reps;
    this.phase = phase;
  }
}

class PerformanceMetric {
  label: string = '';
  value: string = '';
  change: string = '';

  constructor(label: string, value: string, change: string) {
    this.label = label;
    this.value = value;
    this.change = change;
  }
}

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
};

@Entry
@Component
struct RootScreen {
  @State timerValue: string = '02:34';
  @State targetPhase: string = 'Macro tempo';

  private sets: MacroSet[] = [
    new MacroSet('Warm circuit', '3 sets', 'Energy'),
    new MacroSet('Core push', '4 rounds', 'Explosive'),
    new MacroSet('Cooldown flow', '6 min', 'Calm'),
  ];

  private metrics: PerformanceMetric[] = [
    new PerformanceMetric('Load', '72%', '+4%'),
    new PerformanceMetric('VO2', '41', '+1'),
    new PerformanceMetric('Focus', '88%', 'stable'),
  ];

  private tags: string[] = ['Macro', 'Tempo', 'Breath'];

  @Builder
  TopBar() {
    Row() {
      Stack() {
        Circle({ width: 24, height: 24 })
          .fill(Colors.surfaceVariant)
      }
      .width(40)
      .height(40)

      Column() {
        Text('MacroTrainer')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
        Text('Neon workout stack')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B0A8CC')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      Stack() {
        Circle({ width: 24, height: 24 })
          .fill(Colors.surfaceVariant)
      }
      .width(40)
      .height(40)
    }
    .width('100%')
    .height(56)
    .padding({ left: 8, right: 8 })
    .backgroundColor(Colors.surface)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BottomBar() {
    Row() {
      Column() {
        Text('Next macro')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
        Text(this.targetPhase)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Button('Prime')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSecondary)
        .backgroundColor(Colors.secondary)
        .borderRadius(18)
        .padding({ left: 28, right: 28, top: 8, bottom: 8 })
    }
    .width('100%')
    .padding({ left: 20, right: 20, top: 16, bottom: 16 })
    .backgroundColor(Colors.surfaceVariant)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TimerRing() {
    Stack({ alignContent: Alignment.Center }) {
      Circle({ width: 160, height: 160 })
        .fill(Colors.surface)
        .stroke(Colors.primary)
        .strokeWidth(10)

      Column() {
        Text(this.timerValue)
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
        Text('Timer')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B0A8CC')
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(160)
    .height(160)
  }

  @Builder
  TagRow() {
    Row({ space: 4 }) {
      ForEach(this.tags, (tag: string) => {
        Text(tag)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(8)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      })
    }
  }

  @Builder
  MetricCard(metric: PerformanceMetric) {
    Column() {
      Text(metric.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)
      Text(metric.value)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.secondary)
        .margin({ top: 4 })
      Text(metric.change)
        .fontSize(14)
        .fontColor('#B0A8CC')
        .margin({ top: 4 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Colors.surfaceVariant)
    .borderRadius(18)
    .padding(12)
  }

  @Builder
  SetCard(set: MacroSet) {
    Row() {
      Column() {
        Text(set.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
        Text(set.phase)
          .fontSize(14)
          .fontColor('#B0A8CC')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Column() {
        Text(set.reps)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.primary)
        Button('Start')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSecondary)
          .backgroundColor(Colors.secondary)
          .borderRadius(8)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#E61A0F2C')
    .borderRadius(18)
    .padding(16)
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: 20 }) {
          Row({ space: 12 }) {
            Column({ space: 12 }) {
              this.TimerRing()
              this.TagRow()
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .backgroundColor(Colors.surface)
            .borderRadius(28)
            .padding(16)

            Column({ space: 12 }) {
              ForEach(this.metrics, (metric: PerformanceMetric) => {
                this.MetricCard(metric)
              })
            }
            .width(120)
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .alignItems(VerticalAlign.Top)

          ForEach(this.sets, (set: MacroSet) => {
            this.SetCard(set)
          })
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(Colors.background)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}