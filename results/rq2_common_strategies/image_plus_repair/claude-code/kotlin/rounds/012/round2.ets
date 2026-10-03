interface AppColors {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  onSurface: string;
  onPrimary: string;
}

interface CanvasSize {
  width: number;
  height: number;
}

@Entry
@Component
struct Index {
  @State markerX: number = 200;
  @State markerY: number = 400;
  private canvasSettings: CanvasRenderingContext2D = new CanvasRenderingContext2D();
  private canvasSize: CanvasSize = { width: 0, height: 0 };

  private readonly colors: AppColors = {
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

  aboutToAppear(): void {
    this.drawCanvas();
  }

  private drawCanvas(): void {
    const ctx: CanvasRenderingContext2D = this.canvasSettings;
    const w: number = this.canvasSize.width;
    const h: number = this.canvasSize.height;
    const cx: number = w / 2;
    const cy: number = h / 2;

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
  }

  build() {
    Column() {
      Text('Favorite Spots Map')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor(this.colors.background)

      Stack({ alignContent: Alignment.Center }) {
        Column() {
          Stack({ alignContent: Alignment.Center }) {
            Canvas(this.canvasSettings)
              .width('100%')
              .height(400)
              .backgroundColor(this.colors.surface)
              .borderRadius(24)
              .border({ width: 1, color: this.colors.outline })
              .onReady(() => {
                this.canvasSize.width = this.canvasSettings.width;
                this.canvasSize.height = this.canvasSettings.height;
                this.drawCanvas();
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
        direction: GradientDirection.Left,
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
