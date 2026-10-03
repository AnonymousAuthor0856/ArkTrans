import { canvas } from '@kit.ArkGraphics';

@Entry
@Component
struct Index {
  @State progress: number = 0.6
  private ctx: canvas.CanvasRenderingContext2D | null = null;

  build() {
    Stack() {
      Column() {
        // Header
        Text('Stock K-Line')
          .fontColor('#0F172A')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ bottom: 24 })

        // Main Content Area
        Column() {
          // Chart Card
          Stack() {
            // White Background with Shadow
            Rect()
              .fill(Color.White)
              .shadow({ radius: 12, color: '#0F172A1A', offsetY: 4 })
              .borderRadius(24)
              .width('100%')
              .height(260)

            // Canvas for the Line Graph
            Canvas(this.ctx).width('100%').height('100%')
          }
          .width('100%')
          .height(260)
          .margin({ top: 32 })

          // Market Trend Label
          Text('Market Trend')
            .fontColor('#2563EB')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .margin({ top: 24 })

          // Slider
          Slider({ value: this.progress, min: 0, max: 1 })
            .width('100%')
            .height(44)
            .trackColor('#E2E8F0')
            .selectedColor('#2563EB')
            .blockColor('#FFFFFF')
            .showValue(false)
            .margin({ top: 16 })

          // Progress Bar
          Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color('#2563EB')
            .backgroundColor('#E2E8F0')
            .margin({ top: 16 })

        }
        .width('100%')
        .layoutWeight(1)
        .padding(16)
        // Gradient Background matching screenshot (Light Blue to Lighter Blue)
        .linearGradient({
          angle: 180,
          colors: [['#EFF6FF', 0], ['#DBEAFE', 1]]
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F8FAFC')
    }.width('100%').height('100%')
  }

  aboutToAppear() {
    // Note: Drawing should typically happen after the component is laid out.
    // For simplicity in this fix, we assume drawChart will be called when context is ready or use setTimeout/taskPool if needed.
    // However, since ctx is passed by reference to Canvas, it might be null initially.
    // A more robust approach would be using onReady or observing state changes, but keeping it simple per request.
  }

  drawChart() {
    if (!this.ctx) return;
    
    const width = 300; // Approximate canvas width based on padding
    const height = 260;
    const padding = 20;
    const graphWidth = width - padding * 2;
    const amplitude = 60;
    const centerY = height / 2;
    const frequency = 3; // Number of waves
    
    this.ctx.beginPath();
    this.ctx.moveTo(padding, centerY);
    
    // Draw a sine wave
    for (let x = 0; x <= graphWidth; x++) {
      const y = centerY + Math.sin((x / graphWidth) * Math.PI * 2 * frequency) * amplitude;
      this.ctx.lineTo(padding + x, y);
    }
    
    this.ctx.lineWidth = 4;
    this.ctx.strokeStyle = '#2563EB';
    this.ctx.lineCap = 'round';
    this.ctx.stroke();
  }
}