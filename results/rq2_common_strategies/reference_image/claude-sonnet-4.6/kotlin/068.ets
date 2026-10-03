// MacroTrainerPage.ets
// Kotlin Compose (Material3) -> ArkTS / ArkUI declarative conversion.

const COLOR_PRIMARY: string = '#7C4DFF';
const COLOR_SECONDARY: string = '#08D6FF';
const COLOR_TERTIARY: string = '#FF8E3C';
const COLOR_BACKGROUND: string = '#05030A';
const COLOR_SURFACE: string = '#0D0616';
const COLOR_SURFACE_VARIANT: string = '#1A0F2C';
const COLOR_OUTLINE: string = '#3A2759';
const COLOR_SUCCESS: string = '#56F0A6';
const COLOR_WARNING: string = '#FFC857';
const COLOR_ERROR: string = '#FF5B7A';
const COLOR_ON_PRIMARY: string = '#05030A';
const COLOR_ON_SECONDARY: string = '#05030A';
const COLOR_ON_TERTIARY: string = '#120601';
const COLOR_ON_BACKGROUND: string = '#F4ECFF';
const COLOR_ON_SURFACE: string = '#F8F4FF';
const COLOR_ON_SURFACE_MUTED: string = '#B3F8F4FF';
const COLOR_TOP_BAR: string = '#F20D0616';
const COLOR_SET_ROW: string = '#E61A0F2C';

const SPACE_XXS: number = 4;
const SPACE_XS: number = 8;
const SPACE_SM: number = 12;
const SPACE_MD: number = 16;
const SPACE_LG: number = 20;
const SPACE_XL: number = 28;
const SPACE_XXL: number = 40;
const SPACE_XXXL: number = 56;

const FONT_DISPLAY: number = 32;
const FONT_HEADLINE: number = 22;
const FONT_TITLE: number = 16;
const FONT_BODY: number = 14;
const FONT_LABEL: number = 12;

const RADIUS_SMALL: number = 8;
const RADIUS_MEDIUM: number = 18;
const RADIUS_LARGE: number = 28;

const RING_SIZE: number = 160;
const RING_INNER: number = 140;
const METRIC_COLUMN_WIDTH: number = 120;
const TOP_ICON_SIZE: number = 24;

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
struct MacroTrainerPage {
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
    Column() {
      Row() {
        Column()
          .width(TOP_ICON_SIZE)
          .height(TOP_ICON_SIZE)
          .borderRadius(TOP_ICON_SIZE / 2)
          .backgroundColor(COLOR_SURFACE_VARIANT)

        Column() {
          Text('MacroTrainer')
            .fontSize(FONT_TITLE)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_SURFACE)
          Text('Neon workout stack')
            .fontSize(FONT_LABEL)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_SURFACE_MUTED)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Column()
          .width(TOP_ICON_SIZE)
          .height(TOP_ICON_SIZE)
          .borderRadius(TOP_ICON_SIZE / 2)
          .backgroundColor(COLOR_SURFACE_VARIANT)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .padding({ left: SPACE_SM, right: SPACE_SM, top: SPACE_XS, bottom: SPACE_SM })
    }
    .width('100%')
    .backgroundColor(COLOR_TOP_BAR)
    .border({ width: { bottom: 1 }, color: COLOR_OUTLINE })
  }

  @Builder
  RingBlock() {
    Stack() {
      Column()
        .width(RING_SIZE)
        .height(RING_SIZE)
        .borderRadius(RING_SIZE / 2)
        .sweepGradient({
          center: [RING_SIZE / 2, RING_SIZE / 2],
          start: 0,
          end: 360,
          rotation: -90,
          colors: [
            [COLOR_PRIMARY, 0.0],
            [COLOR_TERTIARY, 0.18],
            [COLOR_SUCCESS, 0.42],
            [COLOR_SECONDARY, 0.62],
            [COLOR_PRIMARY, 1.0]
          ]
        })

      Column() {
        Text(this.timerValue)
          .fontSize(FONT_DISPLAY)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
        Text('Timer')
          .fontSize(FONT_LABEL)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE_MUTED)
      }
      .width(RING_INNER)
      .height(RING_INNER)
      .borderRadius(RING_INNER / 2)
      .backgroundColor(COLOR_SURFACE)
      .justifyContent(FlexAlign.Center)
    }
    .width(RING_SIZE)
    .height(RING_SIZE)
  }

  @Builder
  TimerCard() {
    Column({ space: SPACE_SM }) {
      this.RingBlock()

      Row({ space: SPACE_XS }) {
        ForEach(['Macro', 'Tempo', 'Breath'], (tag: string) => {
          Text(tag)
            .fontSize(FONT_LABEL)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_SURFACE)
            .padding({ left: SPACE_XS, right: SPACE_XS, top: SPACE_XXS, bottom: SPACE_XXS })
            .backgroundColor(COLOR_SURFACE_VARIANT)
            .borderRadius(RADIUS_SMALL)
        }, (tag: string) => tag)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
    .padding(SPACE_MD)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(RADIUS_LARGE)
    .shadow({ radius: 8, color: '#38000000', offsetX: 0, offsetY: 4 })
  }

  @Builder
  MetricCard(metric: PerformanceMetric) {
    Column({ space: SPACE_XXS }) {
      Text(metric.label)
        .fontSize(FONT_LABEL)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_SURFACE)
      Text(metric.value)
        .fontSize(FONT_HEADLINE)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(COLOR_SECONDARY)
      Text(metric.change)
        .fontSize(FONT_BODY)
        .fontColor(COLOR_ON_SURFACE_MUTED)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(SPACE_SM)
    .backgroundColor(COLOR_SURFACE_VARIANT)
    .borderRadius(RADIUS_MEDIUM)
  }

  @Builder
  HeroRow() {
    Row({ space: SPACE_SM }) {
      this.TimerCard()

      Column({ space: SPACE_SM }) {
        ForEach(this.metrics, (metric: PerformanceMetric) => {
          this.MetricCard(metric)
        }, (metric: PerformanceMetric) => metric.label)
      }
      .width(METRIC_COLUMN_WIDTH)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  SetRow(item: MacroSet) {
    Row() {
      Column({ space: SPACE_XXS }) {
        Text(item.title)
          .fontSize(FONT_TITLE)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
        Text(item.phase)
          .fontSize(FONT_BODY)
          .fontColor(COLOR_ON_SURFACE_MUTED)
      }
      .alignItems(HorizontalAlign.Start)

      Column({ space: SPACE_XXS }) {
        Text(item.reps)
          .fontSize(FONT_HEADLINE)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(COLOR_PRIMARY)
        Button('Start')
          .type(ButtonType.Normal)
          .height(32)
          .padding({ left: SPACE_SM, right: SPACE_SM })
          .borderRadius(RADIUS_SMALL)
          .backgroundColor(COLOR_SECONDARY)
          .fontColor(COLOR_ON_SECONDARY)
          .fontSize(FONT_LABEL)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
          })
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding(SPACE_MD)
    .backgroundColor(COLOR_SET_ROW)
    .borderRadius(RADIUS_MEDIUM)
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: SPACE_XXS }) {
        Text('Next macro')
          .fontSize(FONT_LABEL)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
        Text(this.targetPhase)
          .fontSize(FONT_TITLE)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button('Prime')
        .type(ButtonType.Normal)
        .height(44)
        .padding({ left: SPACE_XL, right: SPACE_XL })
        .borderRadius(RADIUS_MEDIUM)
        .backgroundColor(COLOR_SECONDARY)
        .fontColor(COLOR_ON_SECONDARY)
        .fontSize(FONT_TITLE)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
        })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ left: SPACE_LG, right: SPACE_LG, top: SPACE_MD, bottom: SPACE_MD })
    .backgroundColor(COLOR_SURFACE_VARIANT)
    .border({ width: { top: 1 }, color: COLOR_OUTLINE })
    .shadow({ radius: 12, color: '#44000000', offsetX: 0, offsetY: 6 })
  }

  build() {
    Column() {
      this.TopBar()

      List({ space: SPACE_LG }) {
        ListItem() {
          this.HeroRow()
        }

        ForEach(this.sets, (item: MacroSet) => {
          ListItem() {
            this.SetRow(item)
          }
        }, (item: MacroSet) => item.title)
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)
      .padding({ left: SPACE_LG, right: SPACE_LG, top: SPACE_MD, bottom: SPACE_MD })

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}