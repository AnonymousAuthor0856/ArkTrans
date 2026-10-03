const PRIMARY: string = '#FF8B5CF6';
const SECONDARY: string = '#FFD946EF';
const BACKGROUND: string = '#FFF9F5FF';
const SURFACE: string = '#FFFFFFFF';
const SURFACE_VARIANT: string = '#FFF1E9FE';
const TEXT: string = '#FF1E1E1E';

@Entry
@Component
struct MainPage {
  @State private fontSize: number = 23;
  @State private syncProgress: number = 0.3;

  private increaseProgress(): void {
    this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0);
  }

  private decreaseProgress(): void {
    this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0);
  }

  build() {
    Column() {
      Text('Subtitle Editor')
        .width('100%')
        .height(88)
        .fontSize(34)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FF000000')
        .textAlign(TextAlign.Center)
        .padding({ top: 25, bottom: 16 })
        .backgroundColor(BACKGROUND)
        .border({
          width: { bottom: 1 },
          color: '#FF9E9AA3',
          style: BorderStyle.Solid
        });

      Column() {
        Text('Sample Subtitle Line')
          .width('100%')
          .height(400)
          .fontSize(this.fontSize)
          .fontColor(TEXT)
          .textAlign(TextAlign.Center)
          .backgroundColor(SURFACE)
          .borderRadius(48)
          .shadow({
            radius: 18,
            color: '#2E000000',
            offsetX: 0,
            offsetY: 10
          });

        Text(`Font Size: ${Math.round(this.fontSize)}sp`)
          .fontSize(28)
          .fontColor(TEXT)
          .margin({ top: 48, bottom: 30 });

        Slider({
          value: this.fontSize,
          min: 16,
          max: 48,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .height(32)
          .selectedColor(PRIMARY)
          .trackColor('#FFDCD9E2')
          .blockColor(SURFACE)
          .blockSize({ width: 54, height: 54 })
          .onChange((value: number) => {
            this.fontSize = value;
          });

        Text('Sync Progress')
          .fontSize(28)
          .fontColor(TEXT)
          .margin({ top: 46, bottom: 38 });

        Stack() {
          Row()
            .width('100%')
            .height(8)
            .backgroundColor('#FFDCD3E8')
            .borderRadius(4);

          Row()
            .width(`${this.syncProgress * 100}%`)
            .height(8)
            .alignSelf(ItemAlign.Start)
            .backgroundColor(PRIMARY)
            .borderRadius(4);
        }
        .width('100%')
        .height(8);

        Row() {
          Button('Sync +')
            .layoutWeight(1)
            .height(96)
            .margin({ right: 12 })
            .fontSize(36)
            .fontColor(SURFACE)
            .backgroundColor(PRIMARY)
            .borderRadius(30)
            .onClick(() => {
              this.increaseProgress();
            });

          Button('Sync -')
            .layoutWeight(1)
            .height(96)
            .margin({ left: 12 })
            .fontSize(36)
            .fontColor(SURFACE)
            .backgroundColor(SECONDARY)
            .borderRadius(30)
            .onClick(() => {
              this.decreaseProgress();
            });
        }
        .width('100%')
        .height(96)
        .margin({ top: 52 });
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 32, right: 32, top: 134, bottom: 50 })
      .backgroundColor(BACKGROUND)
      .linearGradient({
        angle: 180,
        colors: [[SURFACE_VARIANT, 0.0], [BACKGROUND, 0.55], [SURFACE, 1.0]]
      });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND);
  }
}
