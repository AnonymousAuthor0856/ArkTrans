import { curves } from '@kit.ArkUI';

@Entry
@Component
struct RootScreen {
  @State paymentProgress: number = 0.3;

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Installment Plan')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFFBF2')

      // Main Content
      Column({ space: 16 }) {
        // Wave Chart Card
        Stack() {
          Column()
            .width('100%')
            .height(240)
            .borderRadius(20)
            .backgroundColor('#FFFFFFFF')
            .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 4 })

          Canvas(this.context)
            .width('100%')
            .height(240)
            .borderRadius(20)
            .onReady(() => {
              this.drawWave();
            })
        }
        .width('100%')
        .height(240)

        // Payment Progress Label
        Text('Payment Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFA500')
          .alignSelf(ItemAlign.Start)

        // Progress Bar
        Progress({
          value: this.paymentProgress * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(8)
          .color('#FFA500')
          .backgroundColor('#FFEED6')

        // Slider
        Slider({
          value: this.paymentProgress * 100,
          min: 0,
          max: 100,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .trackColor('#FFEED6')
          .selectedColor('#FFA500')
          .blockColor('#FFC107')
          .onChange((value: number) => {
            this.paymentProgress = value / 100;
            this.drawWave();
          })

        // Reset Button
        Button('Reset Progress')
          .width('100%')
          .height(48)
          .borderRadius(12)
          .backgroundColor('#FFE066')
          .fontColor('#1E1E1E')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            this.paymentProgress = 0;
            this.drawWave();
          })
      }
      .width('100%')
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#40FFC107', 0.0],
          ['#FFFBF2', 0.5],
          ['#40FFA500', 1.0]
        ]
      })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFBF2')
  }

  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  );

  private drawWave() {
    const ctx = this.context;
    if (!ctx) return;

    const w = ctx.width;
    const h = ctx.height;

    ctx.clearRect(0, 0, w, h);

    const step = w / 20;
    let prevY = h / 2;

    ctx.strokeStyle = '#FFA500';
    ctx.lineWidth = 5;
    ctx.beginPath();

    for (let i = 0; i <= 20; i++) {
      const x = i * step;
      const y = h / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3);
      if (i === 0) {
        ctx.moveTo(x, y);
      } else {
        ctx.lineTo(x, y);
      }
      prevY = y;
    }

    ctx.stroke();
  }
}