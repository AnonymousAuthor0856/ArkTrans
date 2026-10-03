import { LengthMetricsUnit } from '@kit.ArkUI';

interface MarkerPoint {
  x: number;
  y: number;
}

@Entry
@Component
struct ContentView {
  // 小蓝点实际位置在中心靠左，但坐标显示仍为 (200, 400)
  @State markerPosition: MarkerPoint = { x: 120, y: 200 };
  @State displayedCoordinates: string = '(200, 400)';
  @State savedMarkers: MarkerPoint[] = [{ x: 120, y: 200 }, { x: 120, y: 200 }];

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  // 使用 VP 作为绘制单位，保证与布局尺寸一致
  private ctx: CanvasRenderingContext2D =
    new CanvasRenderingContext2D(this.settings, LengthMetricsUnit.VP);

  private drawMap(): void {
    const ctx: CanvasRenderingContext2D = this.ctx;
    const w: number = ctx.width;
    const h: number = ctx.height;
    if (w <= 0 || h <= 0) {
      return;
    }
    const cx: number = w / 2;
    const cy: number = h / 2;

    ctx.clearRect(0, 0, w, h);

    // 径向渐变背景
    const bg: CanvasGradient = ctx.createRadialGradient(cx, cy, 0, cx, cy, 120);
    bg.addColorStop(0, 'rgba(255, 255, 255, 0.8)');
    bg.addColorStop(1, 'rgba(239, 246, 255, 0.6)');
    ctx.fillStyle = bg;
    ctx.fillRect(0, 0, w, h);

    // 外圈 (radius = 180)
    ctx.beginPath();
    ctx.arc(cx, cy, 180, 0, Math.PI * 2);
    ctx.fillStyle = 'rgba(147, 197, 253, 0.2)';
    ctx.fill();

    // 内圈 (radius = 120)
    ctx.beginPath();
    ctx.arc(cx, cy, 120, 0, Math.PI * 2);
    ctx.fillStyle = 'rgba(147, 197, 253, 0.3)';
    ctx.fill();

    // 标记点外圈 (radius = 12, stroke width = 1)
    ctx.beginPath();
    ctx.arc(this.markerPosition.x, this.markerPosition.y, 12, 0, Math.PI * 2);
    ctx.strokeStyle = 'rgba(96, 165, 250, 0.3)';
    ctx.lineWidth = 1;
    ctx.stroke();

    // 标记点实心圆 (radius = 4)
    ctx.beginPath();
    ctx.arc(this.markerPosition.x, this.markerPosition.y, 4, 0, Math.PI * 2);
    ctx.fillStyle = '#60A5FA';
    ctx.fill();
  }

  private saveMarker(): void {
    this.savedMarkers.push({ x: this.markerPosition.x, y: this.markerPosition.y });
    this.drawMap();
  }

  build() {
    Column() {
      // 顶部标题栏
      Column() {
        Text('Favorite Spots Map')
          .fontSize(28)
          .fontWeight(600)
          .fontColor('#111827')
      }
      .width('100%')
      .padding({ top: 10, bottom: 10 })
      .backgroundColor('#F9FAFB')

      // 主要内容区域
      Stack() {
        // 背景渐变
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            angle: 135,
            colors: [
              ['rgba(255, 255, 255, 0.6)', 0.0],
              ['rgba(239, 246, 255, 0.5)', 0.5],
              ['rgba(255, 255, 255, 0.7)', 1.0]
            ]
          })

        Column() {
          // 地图容器
          Stack() {
            Canvas(this.ctx)
              .width('100%')
              .height('100%')
              .onReady(() => {
                this.drawMap();
              })
          }
          .width('100%')
          .height(400)
          .borderRadius(24)
          .clip(true)
          .border({ width: 1, color: '#D1D5DB' })

          // 底部控制区域
          Column({ space: 16 }) {
            Text(`Spot Coordinates: ${this.displayedCoordinates}`)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111827')

            Button() {
              Text('Save Marker')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.White)
            }
            .type(ButtonType.Normal)
            .width('100%')
            .height(48)
            .backgroundColor('#60A5FA')
            .borderRadius(16)
            .onClick(() => {
              this.saveMarker();
            })

            // 已保存的标记列表
            Column({ space: 12 }) {
              Text('Saved Markers')
                .fontSize(18)
                .fontWeight(600)
                .fontColor('#111827')

              Column({ space: 8 }) {
                ForEach(this.savedMarkers, (item: MarkerPoint, index: number) => {
                  Row({ space: 8 }) {
                    Circle()
                      .width(8)
                      .height(8)
                      .fill('#60A5FA')
                    Text('Saved Marker')
                      .fontSize(14)
                      .fontWeight(FontWeight.Regular)
                      .fontColor('#111827')
                    Blank()
                  }
                  .width('100%')
                }, (item: MarkerPoint, index: number) => index.toString())
              }
              .width('100%')
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({ top: 8 })
          }
          .width('100%')
          .padding({ top: 0 })
          .margin({ top: 16 })
        }
        .width('100%')
        .height('100%')
        .padding({ left: 16, right: 16, bottom: 24 })
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }
}