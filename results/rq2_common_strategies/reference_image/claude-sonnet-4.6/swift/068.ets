// MacroTrainer — ArkTS (HarmonyOS) port of the SwiftUI screen

const COLOR_PRIMARY: string = '#7C4DFF';
const COLOR_SECONDARY: string = '#08D6FF';
const COLOR_TERTIARY: string = '#FF8E3C';
const COLOR_BACKGROUND: string = '#05030A';
const COLOR_SURFACE: string = '#0D0616';
const COLOR_SURFACE_95: string = '#F20D0616';
const COLOR_SURFACE_VARIANT: string = '#1A0F2C';
const COLOR_SURFACE_VARIANT_90: string = '#E61A0F2C';
const COLOR_ON_SURFACE: string = '#F8F4FF';
const COLOR_ON_SURFACE_70: string = '#B3F8F4FF';
const COLOR_ON_SECONDARY: string = '#05030A';

const SPACE_XXS: number = 4;
const SPACE_XS: number = 8;
const SPACE_SM: number = 12;
const SPACE_MD: number = 16;
const SPACE_LG: number = 20;
const SPACE_XL: number = 28;

interface MacroSet {
  title: string;
  reps: string;
  phase: string;
}

interface PerformanceMetric {
  label: string;
  value: string;
  change: string;
}

// Angular gradient for the timer ring (primary -> secondary -> tertiary -> primary)
const RING_GRADIENT: SweepGradient = {
  center: [80, 80],
  start: 0,
  end: 360,
  rotation: 0,
  colors: [
    [COLOR_PRIMARY, 0.0],
    [COLOR_SECONDARY, 0.34],
    [COLOR_TERTIARY, 0.68],
    [COLOR_PRIMARY, 1.0]
  ]
};

@Entry
@Component
struct Index {
  @State timerValue: string = '02:34';
  @State targetPhase: string = 'Macro tempo';

  private sets: MacroSet[] = [
    { title: 'Warm circuit', reps: '3 sets', phase: 'Energy' },
    { title: 'Core push', reps: '4 rounds', phase: 'Explosive' },
    { title: 'Cooldown flow', reps: '6 min', phase: 'Calm' }
  ];

  private metrics: PerformanceMetric[] = [
    { label: 'Load', value: '72%', change: '+4%' },
    { label: 'VO2', value: '41', change: '+1' },
    { label: 'Focus', value: '88%', change: 'stable' }
  ];

  private tags: string[] = ['Macro', 'Tempo', 'Breath'];

  build() {
    Column() {
      TopAppBar()

      Scroll() {
        Column({ space: SPACE_LG }) {
          Row({ space: SPACE_SM }) {
            TimerCard({ timerValue: this.timerValue, tags: this.tags })
              .layoutWeight(1)
              .height(320)
            MetricsColumn({ metrics: this.metrics })
              .width(120)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)

          Column({ space: SPACE_LG }) {
            ForEach(this.sets, (item: MacroSet) => {
              SetListItem({ macroSet: item })
            }, (item: MacroSet) => item.title)
          }
          .width('100%')
        }
        .width('100%')
        .padding({
          left: SPACE_LG,
          right: SPACE_LG,
          top: SPACE_MD,
          bottom: SPACE_MD
        })
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)

      BottomBar({ targetPhase: this.targetPhase })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}

@Component
struct TopAppBar {
  build() {
    Row() {
      Circle()
        .width(24)
        .height(24)
        .fill(COLOR_SURFACE_VARIANT)
        .onClick(() => {
        })

      Blank()

      Column({ space: 0 }) {
        Text('MacroTrainer')
          .fontSize(16)
          .fontWeight(500)
          .fontColor(COLOR_ON_SURFACE)
        Text('Neon workout stack')
          .fontSize(12)
          .fontWeight(500)
          .fontColor(COLOR_ON_SURFACE_70)
      }

      Blank()

      Circle()
        .width(24)
        .height(24)
        .fill(COLOR_SURFACE_VARIANT)
        .onClick(() => {
        })
    }
    .width('100%')
    .height(60)
    .padding({ left: SPACE_LG, right: SPACE_LG })
    .backgroundColor(COLOR_SURFACE_95)
  }
}

@Component
struct TimerCard {
  private timerValue: string = '';
  private tags: string[] = [];

  build() {
    Column({ space: SPACE_SM }) {
      Stack() {
        Circle()
          .width(160)
          .height(160)
          .fill(Color.Transparent)
          .stroke(COLOR_SURFACE_VARIANT)
          .strokeWidth(10)

        Circle()
          .width(160)
          .height(160)
          .fill(Color.Transparent)
          .stroke(RING_GRADIENT)
          .strokeWidth(10)

        Column({ space: SPACE_XXS }) {
          Text(this.timerValue)
            .fontSize(32)
            .fontWeight(700)
            .fontColor(COLOR_ON_SURFACE)
          Text('Timer')
            .fontSize(12)
            .fontWeight(500)
            .fontColor(COLOR_ON_SURFACE_70)
        }
      }
      .width(160)
      .height(160)

      Row({ space: SPACE_XXS }) {
        ForEach(this.tags, (tag: string) => {
          Text(tag)
            .fontSize(12)
            .fontWeight(500)
            .fontColor(COLOR_ON_SURFACE)
            .padding({
              left: SPACE_XS,
              right: SPACE_XS,
              top: SPACE_XXS,
              bottom: SPACE_XXS
            })
            .backgroundColor(COLOR_SURFACE_VARIANT)
            .borderRadius(8)
        }, (tag: string) => tag)
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(SPACE_MD)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(28)
    .shadow({ radius: 6, color: '#42000000', offsetX: 0, offsetY: 4 })
  }
}

@Component
struct MetricsColumn {
  private metrics: PerformanceMetric[] = [];

  build() {
    Column({ space: SPACE_SM }) {
      ForEach(this.metrics, (item: PerformanceMetric) => {
        MetricCard({ metric: item })
      }, (item: PerformanceMetric) => item.label)
    }
    .width('100%')
  }
}

@Component
struct MetricCard {
  private metric: PerformanceMetric = { label: '', value: '', change: '' };

  build() {
    Column({ space: SPACE_XXS }) {
      Text(this.metric.label)
        .fontSize(12)
        .fontWeight(500)
        .fontColor(COLOR_ON_SURFACE)

      Text(this.metric.value)
        .fontSize(22)
        .fontWeight(600)
        .fontColor(COLOR_SECONDARY)

      Text(this.metric.change)
        .fontSize(14)
        .fontWeight(400)
        .fontColor(COLOR_ON_SURFACE_70)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(SPACE_SM)
    .backgroundColor(COLOR_SURFACE_VARIANT)
    .borderRadius(18)
  }
}

@Component
struct SetListItem {
  private macroSet: MacroSet = { title: '', reps: '', phase: '' };

  build() {
    Row() {
      Column({ space: SPACE_XXS }) {
        Text(this.macroSet.title)
          .fontSize(16)
          .fontWeight(500)
          .fontColor(COLOR_ON_SURFACE)

        Text(this.macroSet.phase)
          .fontSize(14)
          .fontWeight(400)
          .fontColor(COLOR_ON_SURFACE_70)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column({ space: SPACE_XXS }) {
        Text(this.macroSet.reps)
          .fontSize(22)
          .fontWeight(600)
          .fontColor(COLOR_PRIMARY)

        Button('Start', { type: ButtonType.Normal, stateEffect: true })
          .fontSize(12)
          .fontWeight(500)
          .fontColor(COLOR_ON_SECONDARY)
          .backgroundColor(COLOR_SECONDARY)
          .borderRadius(8)
          .height(26)
          .padding({ left: SPACE_XS, right: SPACE_XS })
          .onClick(() => {
          })
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(SPACE_MD)
    .backgroundColor(COLOR_SURFACE_VARIANT_90)
    .borderRadius(18)
  }
}

@Component
struct BottomBar {
  private targetPhase: string = '';

  build() {
    Row() {
      Column({ space: SPACE_XXS }) {
        Text('Next macro')
          .fontSize(12)
          .fontWeight(500)
          .fontColor(COLOR_ON_SURFACE)

        Text(this.targetPhase)
          .fontSize(16)
          .fontWeight(500)
          .fontColor(COLOR_ON_SURFACE)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button('Prime', { type: ButtonType.Normal, stateEffect: true })
        .fontSize(16)
        .fontWeight(500)
        .fontColor(COLOR_ON_SECONDARY)
        .backgroundColor(COLOR_SECONDARY)
        .borderRadius(18)
        .height(40)
        .padding({ left: SPACE_XL, right: SPACE_XL })
        .onClick(() => {
        })
    }
    .width('100%')
    .height(80)
    .padding({ left: SPACE_LG, right: SPACE_LG })
    .backgroundColor(COLOR_SURFACE_VARIANT)
    .shadow({ radius: 12, color: '#42000000', offsetX: 0, offsetY: -6 })
  }
}