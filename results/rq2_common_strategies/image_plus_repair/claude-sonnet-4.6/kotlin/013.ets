import { router } from '@kit.ArkUI';

interface TouchPoint {
  x: number;
  y: number;
}

@Entry
@Component
struct Index {
  @State knobX: number = 140;
  @State knobY: number = 140;

  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  );

  private drawCanvas() {
    const ctx = this.canvasContext;
    const w = ctx.width;
    const h = ctx.height;
    ctx.clearRect(0, 0, w, h);

    // Draw yellow ring
    ctx.beginPath();
    ctx.arc(w / 2, h / 2, Math.min(w, h) / 2 - 20, 0, Math.PI * 2);
    ctx.strokeStyle = '#FFD166';
    ctx.lineWidth = 12;
    ctx.stroke();

    // Draw red knob dot
    ctx.beginPath();
    ctx.arc(this.knobX, this.knobY, 20, 0, Math.PI * 2);
    ctx.fillStyle = '#EF476F';
    ctx.fill();
  }

  build() {
    Column() {
      // Top bar title
      Text('Retro Music Player')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1F1F1F')
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 24, bottom: 16 })
        .backgroundColor('#FFFCF2')

      Column() {
        // Canvas area with border
        Stack() {
          Canvas(this.canvasContext)
            .width(280)
            .height(280)
            .backgroundColor('#FFF8E1')
            .borderRadius(16)
            .onReady(() => {
              this.drawCanvas();
            })
            .onTouch((event: TouchEvent) => {
              if (event.type === TouchType.Move || event.type === TouchType.Down) {
                const touch = event.touches[0];
                this.knobX = touch.x;
                this.knobY = touch.y;
                this.drawCanvas();
              }
            })
        }
        .width(280)
        .height(280)
        .borderRadius(16)
        .border({ width: 3, color: '#BDBDBD', radius: 16 })
        .margin({ top: 8, bottom: 24 })

        // Track name
        Text('Track: Summer Nights')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1F1F1F')
          .margin({ bottom: 24 })

        // Play / Pause buttons
        Row() {
          Button('Play')
            .width(120)
            .height(48)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .backgroundColor('#EF476F')
            .borderRadius(12)
            .onClick(() => {})

          Button('Pause')
            .width(120)
            .height(48)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1F1F1F')
            .backgroundColor('#FFD166')
            .borderRadius(12)
            .onClick(() => {})
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ bottom: 24 })

        // Knob position label
        Text(`Knob X:${Math.round(this.knobX)} Y:${Math.round(this.knobY)}`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#06D6A0')
          .margin({ bottom: 32 })
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 16, right: 16, bottom: 16 })
      .backgroundColor('#FFFCF2')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFCF2')
  }
}