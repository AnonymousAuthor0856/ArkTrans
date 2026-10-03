const PRIMARY: string = '#8B5CF6';
const SECONDARY: string = '#D946EF';
const BACKGROUND: string = '#F9F5FF';
const SURFACE: string = '#FFFFFF';
const SURFACE_VARIANT: string = '#F1E9FE';
const ON_SURFACE: string = '#1E1E1E';

@Entry
@Component
struct Index {
  @State private fontSizeValue: number = 24;
  @State private syncProgress: number = 0.3;

  private increaseProgress(): void {
    this.syncProgress = Math.min(1, Math.round((this.syncProgress + 0.1) * 10) / 10);
  }

  private decreaseProgress(): void {
    this.syncProgress = Math.max(0, Math.round((this.syncProgress - 0.1) * 10) / 10);
  }

  build() {
    Column() {
      Text('Subtitle Editor')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(ON_SURFACE)
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 42, bottom: 72 })

      Column() {
        Text('Sample Subtitle Line')
          .fontSize(this.fontSizeValue)
          .fontColor(ON_SURFACE)
          .fontWeight(FontWeight.Regular)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(200)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(SURFACE)
      .borderRadius(22)
      .shadow({
        radius: 12,
        color: '#2E000000',
        offsetX: 0,
        offsetY: 6
      })

      Text(`Font Size: ${Math.round(this.fontSizeValue)}sp`)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(ON_SURFACE)
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 16, bottom: 10 })

      Slider({
        value: this.fontSizeValue,
        min: 16,
        max: 48,
        step: 1,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .height(44)
        .selectedColor(PRIMARY)
        .trackColor(SURFACE_VARIANT)
        .blockColor(SECONDARY)
        .showTips(false)
        .showSteps(false)
        .onChange((value: number, mode: SliderChangeMode) => {
          this.fontSizeValue = value;
        })

      Text('Sync Progress')
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(ON_SURFACE)
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 22, bottom: 18 })

      Progress({
        value: this.syncProgress * 100,
        total: 100,
        type: ProgressType.Linear
      })
        .width('100%')
        .height(6)
        .color(PRIMARY)
        .backgroundColor(SURFACE_VARIANT)
        .borderRadius(3)
        .style({
          strokeWidth: 6
        })

      Row() {
        Button() {
          Text('Sync +')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
        .layoutWeight(1)
        .height(48)
        .borderRadius(14)
        .backgroundColor(PRIMARY)
        .onClick(() => {
          this.increaseProgress();
        })

        Button() {
          Text('Sync -')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
        .layoutWeight(1)
        .height(48)
        .borderRadius(14)
        .backgroundColor(SECONDARY)
        .onClick(() => {
          this.decreaseProgress();
        })
      }
      .width('100%')
      .height(48)
      .margin({ top: 32 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .columnGap(24)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 16, right: 16 })
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      angle: 180,
      colors: [
        [SURFACE_VARIANT, 0.0],
        [BACKGROUND, 0.45],
        [SURFACE, 1.0]
      ]
    })
  }
}