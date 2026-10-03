// Bill Calendar — Finance / Gradient Flow (adapted from Compose)

const COLOR_PRIMARY: string = '#06B6D4';
const COLOR_SECONDARY: string = '#3B82F6';
const COLOR_TERTIARY: string = '#8B5CF6';
const COLOR_BACKGROUND: string = '#F0F9FF';
const COLOR_SURFACE_90: string = '#E6FFFFFF';
const COLOR_SURFACE_VARIANT: string = '#E0F2FE';
const COLOR_ON_SURFACE: string = '#0F172A';
const COLOR_ON_TERTIARY: string = '#FFFFFF';

const SPACE_SM: number = 8;
const SPACE_MD: number = 12;
const SPACE_LG: number = 16;
const SPACE_XL: number = 24;

const SHAPE_MEDIUM: number = 12;
const SHAPE_LARGE: number = 20;

@Entry
@Component
struct Index {
  @State spending: number = 500;
  private readonly goal: number = 1000;

  // (spending / goal) clamped to 0..1, converted to the 0..100 range Progress expects
  private progressValue(): number {
    const ratio: number = this.spending / this.goal;
    return Math.min(Math.max(ratio, 0), 1) * 100;
  }

  build() {
    Column() {
      // Top app bar
      Text('Bill Calendar')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_ON_SURFACE)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: SPACE_XL, bottom: SPACE_XL })
        .backgroundColor(COLOR_BACKGROUND)

      // Content area with vertical gradient
      Column({ space: SPACE_LG }) {
        // Spending card
        Column() {
          Text('Current Spending')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_PRIMARY)

          Text(`$${this.spending.toFixed(0)} / $${this.goal.toFixed(0)}`)
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLOR_ON_SURFACE)

          Progress({ value: this.progressValue(), total: 100, type: ProgressType.Linear })
            .color(COLOR_PRIMARY)
            .backgroundColor(COLOR_SURFACE_VARIANT)
            .style({ strokeWidth: 8 })
            .width('100%')
        }
        .width('100%')
        .height(160)
        .padding(SPACE_LG)
        .justifyContent(FlexAlign.SpaceBetween)
        .borderRadius(SHAPE_LARGE)
        .backgroundColor(COLOR_SURFACE_90)
        .shadow({ radius: 8, color: '#2E0F172A', offsetX: 0, offsetY: 4 })

        Text('Adjust Spending')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)

        Slider({
          value: this.spending,
          min: 0,
          max: 2000,
          step: 1,
          style: SliderStyle.OutSet
        })
          .selectedColor(COLOR_PRIMARY)
          .trackColor(COLOR_SURFACE_VARIANT)
          .blockColor(COLOR_SECONDARY)
          .blockSize({ width: 8, height: 32 })
          .width('100%')
          .onChange((value: number, mode: SliderChangeMode) => {
            this.spending = value;
          })

        Button('Reset')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_TERTIARY)
          .backgroundColor(COLOR_TERTIARY)
          .borderRadius(SHAPE_MEDIUM)
          .width('100%')
          .height(48)
          .onClick(() => {
            this.spending = 0;
          })
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .padding(SPACE_LG)
      .linearGradient({
        angle: 180,
        colors: [
          ['#4D3B82F6', 0.0],   // secondary @ 30%
          ['#FFF0F9FF', 0.5],   // background
          ['#3306B6D4', 1.0]    // primary @ 20%
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}