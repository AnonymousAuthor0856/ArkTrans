@Entry
@Component
struct StockKLinePage {
  @State progress: number = 0.5;

  build() {
    Stack() {
      Column() {
        // Top bar
        Stack() {
          Text('Stock K-Line')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF0F172A')
        }
        .width('100%')
        .height(56)
        .backgroundColor('#FFF8FAFC')

        // Main content
        Column() {
          // Chart surface
          Stack() {
            // K-Line canvas
            KLineCanvas({ progress: this.progress })
          }
          .width('100%')
          .height(260)
          .backgroundColor('#FFFFFFFF')
          .borderRadius(16)
          .shadow({
            radius: 8,
            color: '#2E0F172A',
            offsetY: 4
          })

          Text('Market Trend')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF2563EB')
            .margin({ top: 14 })

          // Slider
          Slider({
            value: this.progress,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet
          })
            .blockColor('#FFFFFFFF')
            .selectedColor('#FF2563EB')
            .trackColor('#FFCBD5E1')
            .width('100%')
            .height(44)
            .onChange((value: number) => {
              this.progress = value;
            })

          // Linear progress indicator
          Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
            .color('#FF2563EB')
            .backgroundColor('#FFE2E8F0')
            .borderRadius(4)
            .width('100%')
            .height(8)
        }
        .width('100%')
        .layoutWeight(1)
        .padding(14)
        .background(this.gradientBackground())
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8FAFC')
  }

  @Builder
  gradientBackground() {
    LinearGradient({
      colors: ['#2660A5FA', '#FFF8FAFC', '#262563EB'],
      direction: GradientDirection.Bottom
    })
  }
}

@Component
struct KLineCanvas {
  @Link progress: number;

  build() {
    Canvas(this.kLineDrawer)
      .width('100%')
      .height('100%')
      .padding(14)
      .onReady(() => {
        this.drawKLine();
      })
  }

  private kLineDrawer: CanvasRenderingContext2D = new CanvasRenderingContext2D();

  aboutToUpdate(): void {
    this.drawKLine();
  }

  private drawKLine(): void {
    const ctx = this.kLineDrawer;
    const width = ctx.width;
    const height = ctx.height;
    const step = width / 50.0;
    const midY = height / 2.0;
    const amplitude = height / 3.0;

    ctx.clearRect(0, 0, width, height);
    ctx.beginPath();
    ctx.strokeStyle = '#FF2563EB';
    ctx.lineWidth = 4;
    ctx.lineCap = 'round';
    ctx.lineJoin = 'round';

    let firstPoint = true;
    for (let i = 0; i <= 50; i++) {
      const x = i * step;
      const y = midY + Math.sin(i * Math.PI / 8.0 + this.progress * Math.PI) * amplitude;
      if (firstPoint) {
        ctx.moveTo(x, y);
        firstPoint = false;
      } else {
        ctx.lineTo(x, y);
      }
    }

    ctx.stroke();
  }
}
