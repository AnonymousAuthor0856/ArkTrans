import { canvas, drawing } from '@kit.ArkGraphics';

@Entry
@Component
struct Index {
  private matchaPainter: MatchaPainter = new MatchaPainter();

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Column() {
        // Header Section
        Column({ space: 8 }) {
          Text('MATCHA RITUAL')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(4)
            .fontColor('#9E9E9E')
            .margin({ top: 48 })

          Text('Ceremonial Grade')
            .fontSize(28)
            .fontWeight(FontWeight.Normal)
            .fontColor('#000000')
        }.width('100%').alignItems(HorizontalAlign.Center)

        // Matcha Bowl Graphic (Canvas)
        Canvas(this.matchaPainter).width(160).height(160).margin({ top: 32, bottom: 40 })

        // Info Row
        Row({ space: 24 }) {
          this.InfoItem('TEMP', '80°C')
          this.InfoItem('WATER', '70ml')
          this.InfoItem('BAMBOO', 'Whisk')
        }.width('100%').justifyContent(FlexAlign.SpaceEvenly)

        // Steps Section
        Column({ space: 12 }) {
          this.StepCard('01', 'Sift 2g of matcha powder.')
          this.StepCard('02', "Add hot water. Whisk in 'M' shape.")
        }.width('100%').margin({ top: 24 })

        // Button Section
        Column({ space: 24 }) {
          Button() {
            Row({ space: 8 }) {
              Image($r('app.media.startIcon'))
                .width(20)
                .height(20)
                .fillColor(Color.White)
              Text('START TIMER')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.White)
            }
          }
          .width('100%')
          .height(56)
          .backgroundColor('#556B2F')
          .borderRadius(28)
        }
      }
      .width('100%')
      .height('100%')
      .padding(24)
      .justifyContent(FlexAlign.SpaceBetween)
    }.width('100%').height('100%')
  }

  @Builder
  InfoItem(label: string, value: string) {
    Column({ space: 4 }) {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#CCCCCC')
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
    }.alignItems(HorizontalAlign.Center)
  }

  @Builder
  StepCard(number: string, text: string) {
    Row({ space: 16 }) {
      Stack({ alignContent: Alignment.Center }) {
        Text(number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .width(32)
      .height(32)
      .backgroundColor('#F5F5F5')
      .borderRadius(16)

      Text(text)
        .fontSize(14)
        .fontColor('#424242')
        .layoutWeight(1)
        .textAlign(TextAlign.Start)
    }
    .width('100%')
    .height(64)
    .padding(16)
    .backgroundColor(Color.White)
    .border({ width: 1, color: '#EEEEEE' })
    .borderRadius(12)
  }
}

// Custom Painter for the Matcha Bowl
class MatchaPainter implements canvas.CanvasRenderingContext2D {
  draw(context: canvas.CanvasRenderingContext2D, rect: drawing.DrawingRect): void {
    const ctx = context;
    const w: number = rect.width;
    const h: number = rect.height;
    const cx: number = w / 2;
    
    // Steam lines
    ctx.beginPath();
    ctx.strokeStyle = '#E0E0E0';
    ctx.lineWidth = 2;
    ctx.moveTo(cx - 10, 20); ctx.lineTo(cx - 10, 50);
    ctx.moveTo(cx, 10); ctx.lineTo(cx, 60);
    ctx.moveTo(cx + 10, 20); ctx.lineTo(cx + 10, 50);
    ctx.stroke();

    // Bowl Body
    ctx.beginPath();
    ctx.fillStyle = '#333333';
    ctx.arc(cx, h * 0.6, w * 0.45, 0, Math.PI, false);
    ctx.fill();

    // Tea Surface
    ctx.beginPath();
    ctx.fillStyle = '#8BC34A';
    ctx.ellipse(cx, h * 0.6, w * 0.4, h * 0.1, 0, 0, 2 * Math.PI);
    ctx.fill();
  }
}