import { display } from '@kit.ArkUI';

const VP_VIDEO_SURFACE_RATIO = 0.50;

const VP_COLORS = {
  primary: '#1E3A8A',
  background: '#0F172A',
  surface: '#1E293B',
  surfaceVariant: '#334155',
  outline: '#475569',
  onSurface: '#E2E8F0',
  chip: '#E8DEF8',
};

@Entry
@Component
struct VideoPlayerRoot {
  @State screenWidth: number = 0;
  @State screenHeight: number = 0;

  aboutToAppear() {
    const d = display.getDefaultDisplaySync();
    const density = d.densityPixels;
    this.screenWidth = d.width / density;
    this.screenHeight = d.height / density;
  }

  @Builder
  TonalButton(title: string, scale: number) {
    Text(title)
      .fontSize(18 * scale)
      .fontWeight(FontWeight.Bold)
      .fontColor('#1d192b')
      .width(180 * scale)
      .height(96 * scale)
      .textAlign(TextAlign.Center)
      .backgroundColor(VP_COLORS.chip)
      .borderRadius(18 * scale)
  }

  build() {
    const sw = this.screenWidth;
    const sh = this.screenHeight;
    const scale = Math.min(sw / 720.0, sh / 1280.0);
    const padX = 24.0 * scale;
    const titleH = 56.0 * scale;
    const contentW = sw - 2 * padX;
    const leftW = contentW * 0.40;
    const rightW = contentW * 0.47;

    Column({ space: 10 }) {
      // Title
      Text('Video Player')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#e2e8f0')
        .height(titleH)
        .padding({ top: 12, bottom: 12 })

      // Video Surface
      Stack() {
        Text('Video Surface')
          .fontSize(16 * scale)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E2E8F0')
          .opacity(0.9)
      }
      .width('100%')
      .height(300)
      .backgroundColor(VP_COLORS.surfaceVariant)
      .borderRadius(24 * scale)
      .padding({ right: 10 })

      // Title text
      Text('Journey through the Skies')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#e0e8f0')
        .width('100%')
        .textAlign(TextAlign.Start)
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })

      // Progress area
      Column({ space: 10 * scale }) {
        Row({ space: 18 * scale }) {
          Blank()
          // Left capsule
          Text('')
            .width(leftW)
            .height(32 * scale)
            .backgroundColor(VP_COLORS.primary)
            .borderRadius(16 * scale)

          // Vertical bar
          Text('')
            .width(6 * scale)
            .height(72 * scale)
            .backgroundColor(VP_COLORS.primary)
            .borderRadius(3 * scale)

          // Right track with dot
          Stack({ alignContent: Alignment.End }) {
            Text('')
              .width(rightW)
              .height(32 * scale)
              .backgroundColor('#475569')
              .borderRadius(16 * scale)

            Text('')
              .width(12 * scale)
              .height(12 * scale)
              .backgroundColor(VP_COLORS.primary)
              .borderRadius(6 * scale)
              .margin({ right: 10 * scale })
          }
          .width(rightW)
          .height(32 * scale)

          Blank()
        }
        .width('100%')

        // Time labels
        Row() {
          Text('1:35')
            .fontSize(12 * scale)
            .fontWeight(FontWeight.Medium)
            .fontColor('#a3aab5')
            .margin({ left: 10 })
          Blank()
          Text('4:00')
            .fontSize(12 * scale)
            .fontWeight(FontWeight.Medium)
            .fontColor('#a3aab5')
            .margin({ right: 10 })
        }
        .width('100%')
      }
      .width('100%')
      .padding({
        left: padX,
        right: padX,
        top: 8 * scale,
        bottom: 6 * scale
      })
      .alignItems(HorizontalAlign.Start)

      // Controls: -10s / Play / +30s
      Row({ space: 24 * scale }) {
        this.TonalButton('−10s', scale)

        Stack() {
          Circle()
            .width(120 * scale)
            .height(120 * scale)
            .fill(VP_COLORS.primary)
          Image($r('sys.media.ohos_ic_public_play'))
            .width(40 * scale)
            .height(40 * scale)
            .fillColor('#ffffff')
        }
        .width(120 * scale)
        .height(120 * scale)

        this.TonalButton('+30s', scale)
      }
      .padding({ top: 10 * scale, bottom: 10 })

      // Fullscreen button (outlined)
      Button({ type: ButtonType.Normal }) {
        Text('Fullscreen')
          .fontSize(18 * scale)
          .fontWeight(FontWeight.Bold)
          .fontColor('#47434e')
      }
      .width(220 * scale)
      .height(64 * scale)
      .backgroundColor(Color.Transparent)
      .borderRadius(12 * scale)
      .border({ width: 1, color: VP_COLORS.outline })
      .margin({ top: 12 * scale })

      Blank()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(VP_COLORS.background)
    .alignItems(HorizontalAlign.Center)
  }
}