import display from '@ohos.display';

@Entry
@Component
struct VideoPlayerPage {
  @State screenScale: number = 1.0;

  aboutToAppear(): void {
    let displayInfo = display.getDefaultDisplaySync();
    let sw = px2vp(displayInfo.width);
    let sh = px2vp(displayInfo.height);
    this.screenScale = Math.min(sw / 720.0, sh / 1280.0);
  }

  build() {
    Column({ space: 10 }) {
      Text('Video Player')
        .fontSize(18 * this.screenScale)
        .fontWeight(FontWeight.Medium)
        .fontColor('#E2E8F0')
        .height(56 * this.screenScale)
        .padding({ top: 12 * this.screenScale, bottom: 12 * this.screenScale })

      Stack() {
        Text('Video Surface')
          .fontSize(16 * this.screenScale)
          .fontWeight(FontWeight.Medium)
          .fontColor('rgba(226,232,240,0.9)')
      }
      .width('100%')
      .height(300 * this.screenScale)
      .backgroundColor('#334155')
      .borderRadius(24 * this.screenScale)
      .padding({ right: 10 * this.screenScale })

      Text('Journey through the Skies')
        .fontSize(18 * this.screenScale)
        .fontWeight(FontWeight.Medium)
        .fontColor('#E0E8F0')
        .width('100%')
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })
        .textAlign(TextAlign.Start)

      Column({ space: 10 * this.screenScale }) {
        Row({ space: 18 * this.screenScale }) {
          Blank()

          Row()
            .width('40%')
            .height(32 * this.screenScale)
            .backgroundColor('#1E3A8A')
            .borderRadius(9999)

          Row()
            .width(6 * this.screenScale)
            .height(72 * this.screenScale)
            .backgroundColor('#1E3A8A')
            .borderRadius(3 * this.screenScale)

          Stack({ alignContent: Alignment.End }) {
            Row()
              .width('100%')
              .height(32 * this.screenScale)
              .backgroundColor('#475569')
              .borderRadius(9999)
            Row()
              .width(12 * this.screenScale)
              .height(12 * this.screenScale)
              .backgroundColor('#1E3A8A')
              .borderRadius(9999)
              .margin({ right: 10 * this.screenScale })
          }
          .width('47%')

          Blank()
        }
        .width('100%')

        Row() {
          Text('1:35')
            .fontSize(12 * this.screenScale)
            .fontWeight(FontWeight.Medium)
            .fontColor('#A3AAB5')
            .padding({ left: 10 * this.screenScale })
          Blank()
          Text('4:00')
            .fontSize(12 * this.screenScale)
            .fontWeight(FontWeight.Medium)
            .fontColor('#A3AAB5')
            .padding({ right: 10 * this.screenScale })
        }
        .width('100%')
      }
      .width('100%')
      .padding({ left: 24 * this.screenScale, right: 24 * this.screenScale, top: 8 * this.screenScale, bottom: 6 * this.screenScale })

      Row({ space: 24 * this.screenScale }) {
        this.TonalButton('−10s')

        Stack() {
          Row()
            .width(120 * this.screenScale)
            .height(120 * this.screenScale)
            .backgroundColor('#1E3A8A')
            .borderRadius(9999)
          Path()
            .commands('M0,0 L40,24 L0,48 Z')
            .fill('#FFFFFF')
            .width(40 * this.screenScale)
            .height(48 * this.screenScale)
        }
        .width(120 * this.screenScale)
        .height(120 * this.screenScale)

        this.TonalButton('+30s')
      }
      .padding({ top: 10 * this.screenScale, bottom: 10 * this.screenScale })

      Button('Fullscreen')
        .fontSize(18 * this.screenScale)
        .fontWeight(FontWeight.Medium)
        .fontColor('#47434E')
        .width(220 * this.screenScale)
        .height(64 * this.screenScale)
        .backgroundColor(Color.Transparent)
        .borderRadius(12 * this.screenScale)
        .border({ width: 1, color: '#475569' })
        .margin({ top: 12 * this.screenScale })

      Blank()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0F172A')
  }

  @Builder
  TonalButton(title: string) {
    Text(title)
      .fontSize(18 * this.screenScale)
      .fontWeight(FontWeight.Medium)
      .fontColor('#1D192B')
      .width(180 * this.screenScale)
      .height(96 * this.screenScale)
      .textAlign(TextAlign.Center)
      .backgroundColor('#E8DEF8')
      .borderRadius(18 * this.screenScale)
  }
}
