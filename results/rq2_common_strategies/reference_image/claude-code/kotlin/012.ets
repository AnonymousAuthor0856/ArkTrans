@Entry
@Component
struct Index {
  @State markerX: number = 200;
  @State markerY: number = 400;

  private readonly colors = {
    primary: '#60A5FA',
    secondary: '#93C5FD',
    tertiary: '#A5B4FC',
    background: '#F9FAFB',
    surface: '#FFFFFF',
    surfaceVariant: '#EFF6FF',
    outline: '#D1D5DB',
    onSurface: '#111827',
    onPrimary: '#FFFFFF',
  };

  build() {
    Column() {
      Text('Favorite Spots Map')
        .fontSize(28)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(this.colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor(this.colors.background)

      Stack({ alignContent: Alignment.Center }) {
        Column() {
          Stack({ alignContent: Alignment.Center }) {
            Canvas()
              .width('100%')
              .height(400)
              .backgroundColor(this.colors.surface)
              .borderRadius(24)
              .border({ width: 1, color: this.colors.outline })
              .onReady((ctx: CanvasRenderingContext2D) => {
                const w = ctx.canvas.width;
                const h = ctx.canvas.height;
                const cx = w / 2;
                const cy = h / 2;

                ctx.fillStyle = 'rgba(147, 197, 253, 0.3)';
                ctx.beginPath();
                ctx.arc(cx, cy, 220, 0, Math.PI * 2);
                ctx.fill();

                ctx.fillStyle = 'rgba(147, 197, 253, 0.2)';
                ctx.beginPath();
                ctx.arc(cx, cy, 340, 0, Math.PI * 2);
                ctx.fill();

                ctx.fillStyle = this.colors.primary;
                ctx.beginPath();
                ctx.arc(this.markerX, this.markerY, 14, 0, Math.PI * 2);
                ctx.fill();

                ctx.strokeStyle = 'rgba(96, 165, 250, 0.3)';
                ctx.lineWidth = 3;
                ctx.beginPath();
                ctx.arc(this.markerX, this.markerY, 30, 0, Math.PI * 2);
                ctx.stroke();
              })
          }
          .width('100%')
          .height(400)

          Column() {
            Text(`Spot Coordinates: (${Math.round(this.markerX)}, ${Math.round(this.markerY)})`)
              .fontSize(14)
              .fontColor(this.colors.onSurface)
              .margin({ bottom: 12 })

            Button('Save Marker')
              .width('100%')
              .height(48)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colors.onPrimary)
              .backgroundColor(this.colors.primary)
              .borderRadius(16)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
          .margin({ top: 12 })
        }
        .width('100%')
        .padding(16)
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.LeftRight,
        colors: [
          ['rgba(255, 255, 255, 0.6)', 0.0],
          ['rgba(239, 246, 255, 0.5)', 0.5],
          ['rgba(255, 255, 255, 0.7)', 1.0],
        ],
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
  }
}
