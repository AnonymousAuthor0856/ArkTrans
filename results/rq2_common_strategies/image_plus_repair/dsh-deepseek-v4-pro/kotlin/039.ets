@Entry
@Component
struct RootScreen {
  @State paymentProgress: number = 0.3;
  @State canvasW: number = 328;
  @State canvasH: number = 208;

  private buildWavePath(): string {
    const w: number = this.canvasW;
    const h: number = this.canvasH;
    const step: number = w / 20;
    let cmd: string = '';
    for (let i = 0; i <= 20; i++) {
      const x: number = i * step;
      const y: number = h / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3);
      if (i === 0) {
        cmd += 'M' + x.toFixed(1) + ' ' + y.toFixed(1);
      } else {
        cmd += ' L' + x.toFixed(1) + ' ' + y.toFixed(1);
      }
    }
    return cmd;
  }

  build() {
    Column() {
      // Top app bar
      Row() {
        Text('Installment Plan')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: 16, bottom: 16 })
      .backgroundColor('#FFFBF2')

      // Main content
      Column({ space: 16 }) {
        // Surface card with sine-wave chart
        Stack() {
          Path({ width: '100%', height: '100%', commands: this.buildWavePath() })
            .fill(Color.Transparent)
            .stroke('#FFA500')
            .strokeWidth(5)
            .antiAlias(true)
            .onAreaChange((oldArea: Area, newArea: Area) => {
              this.canvasW = Number(newArea.width);
              this.canvasH = Number(newArea.height);
            })
        }
        .width('100%')
        .height(240)
        .padding(16)
        .backgroundColor('rgba(255,255,255,0.9)')
        .borderRadius(20)

        Text('Payment Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFA500')

        Progress({ value: this.paymentProgress, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color('#FFA500')
          .backgroundColor('#FFEED6')

        Slider({ value: this.paymentProgress, min: 0, max: 1, step: 0.01 })
          .width('100%')
          .selectedColor('#FFA500')
          .blockColor('#FFC107')
          .trackColor('#FFEED6')
          .onChange((value: number, mode: SliderChangeMode) => {
            this.paymentProgress = value;
          })

        Button('Reset Progress')
          .width('100%')
          .height(48)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E1E1E')
          .backgroundColor('#FFE066')
          .borderRadius(12)
          .onClick(() => {
            this.paymentProgress = 0;
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [['#FFECB7', 0.0], ['#FFFBF2', 0.5], ['#FFE6B6', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFBF2')
  }
}
