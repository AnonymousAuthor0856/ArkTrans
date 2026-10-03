import { drawing } from '@kit.ArkGraphics2D';

const colorPrimary = '#FF60A5FA';
const colorSecondary = '#FF93C5FD';
const colorSurfaceVariant = '#FFEFF6FF';
const colorSurface = '#FFFFFFFF';
const colorOutline = '#FFD1D5DB';
const colorOnSurface = '#FF111827';
const colorOnPrimary = '#FFFFFFFF';
const colorBackground = '#FFF9FAFB';

@Entry
@Component
struct RootScreen {
  @State markerX: number = 200;
  @State markerY: number = 400;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawCanvas() {
    const ctx = this.context;
    const w = ctx.width;
    const h = ctx.height;
    ctx.clearRect(0, 0, w, h);

    // Outer ring
    ctx.beginPath();
    ctx.arc(w / 2, h / 2, 170, 0, Math.PI * 2);
    ctx.fillStyle = 'rgba(147,197,253,0.2)';
    ctx.fill();

    // Inner ring
    ctx.beginPath();
    ctx.arc(w / 2, h / 2, 110, 0, Math.PI * 2);
    ctx.fillStyle = 'rgba(147,197,253,0.3)';
    ctx.fill();

    // Marker dot
    ctx.beginPath();
    ctx.arc(this.markerX, this.markerY, 14, 0, Math.PI * 2);
    ctx.fillStyle = colorPrimary;
    ctx.fill();

    // Marker ring
    ctx.beginPath();
    ctx.arc(this.markerX, this.markerY, 30, 0, Math.PI * 2);
    ctx.strokeStyle = 'rgba(96,165,250,0.3)';
    ctx.lineWidth = 3;
    ctx.stroke();
  }

  build() {
    Column() {
      // Top bar
      Row() {
        Text('Favorite Spots Map')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(colorOnSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(colorBackground)

      // Main content
      Stack({ alignContent: Alignment.Bottom }) {
        // Map card
        Stack() {
          // Background gradient simulation
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor(colorSurface)
            .opacity(0.85)
            .borderRadius(24)

          Canvas(this.context)
            .width('100%')
            .height('100%')
            .borderRadius(24)
            .border({ width: 1, color: colorOutline, radius: 24 })
            .onReady(() => {
              this.drawCanvas();
            })
        }
        .width('100%')
        .height(400)
        .borderRadius(24)
        .border({ width: 1, color: colorOutline, radius: 24 })
        .backgroundColor(colorSurface)

        // Bottom controls
        Column({ space: 12 }) {
          Text(`Spot Coordinates: (${this.markerX}, ${this.markerY})`)
            .fontSize(14)
            .fontColor(colorOnSurface)
            .textAlign(TextAlign.Center)

          Button('Save Marker')
            .width('100%')
            .height(48)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(colorOnPrimary)
            .backgroundColor(colorPrimary)
            .borderRadius(16)
            .onClick(() => {})
        }
        .width('100%')
        .padding({ bottom: 8 })
        .alignItems(HorizontalAlign.Center)
        .translate({ y: 80 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(colorBackground)
  }
}