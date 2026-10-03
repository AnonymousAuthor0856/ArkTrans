import { curves } from '@kit.ArkUI';

interface MarkerData {
  x: number;
  y: number;
  label: string;
}

@Entry
@Component
struct RootScreen {
  @State markers: MarkerData[] = [
    { x: 120, y: 200, label: 'A1' },
    { x: 300, y: 400, label: 'B2' },
    { x: 520, y: 600, label: 'C3' },
  ];
  @State scanning: boolean = false;
  private canvasWidth: number = 0;
  private canvasHeight: number = 0;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawCanvas() {
    this.ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight);

    const cx = this.canvasWidth / 2;
    const cy = this.canvasHeight / 2;
    const minDim = Math.min(this.canvasWidth, this.canvasHeight);
    const radius = minDim / 2.5;

    // Draw background circle
    this.ctx.beginPath();
    this.ctx.arc(cx, cy, radius, 0, Math.PI * 2);
    this.ctx.fillStyle = '#E0F2FE';
    this.ctx.fill();

    // Draw markers
    this.markers.forEach((marker) => {
      this.ctx.beginPath();
      this.ctx.arc(marker.x, marker.y, 12, 0, Math.PI * 2);
      this.ctx.fillStyle = '#06B6D4';
      this.ctx.fill();

      this.ctx.fillStyle = '#FFFFFF';
      this.ctx.font = 'bold 10px sans-serif';
      this.ctx.textAlign = 'center';
      this.ctx.textBaseline = 'middle';
      this.ctx.fillText(marker.label, marker.x, marker.y);
    });
  }

  addMarker() {
    if (this.scanning) {
      const x = Math.floor(Math.random() * (580 - 80 + 1)) + 80;
      const y = Math.floor(Math.random() * (650 - 150 + 1)) + 150;
      const label = `N${this.markers.length + 1}`;
      this.markers = [...this.markers, { x, y, label }];
      this.drawCanvas();
    }
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Invoice Scanner')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#F0F9FF')

      // Main Content
      Column({ space: 16 }) {
        // Canvas Card
        Column() {
          Canvas(this.ctx)
            .width('100%')
            .height('100%')
            .borderRadius(20)
            .onReady(() => {
              this.canvasWidth = this.ctx.width;
              this.canvasHeight = this.ctx.height;
              this.drawCanvas();
            })
        }
        .width('100%')
        .height(360)
        .borderRadius(20)
        .backgroundColor('#FFFFFFE6')
        .shadow({
          radius: 8,
          color: '#2E000000',
          offsetX: 0,
          offsetY: 4
        })
        .clip(true)

        // Scanning Toggle Row
        Row() {
          Text('Scanning Active')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0F172A')

          Toggle({ type: ToggleType.Switch, isOn: this.scanning })
            .selectedColor('#3B82F6')
            .switchPointColor('#BAE6FD')
            .onChange((isOn: boolean) => {
              this.scanning = isOn;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .padding({ left: 4, right: 4 })

        // Add Marker Button
        Button('Add Marker')
          .width('100%')
          .height(48)
          .borderRadius(12)
          .backgroundColor(this.scanning ? '#06B6D4' : '#A5D8E6')
          .fontColor('#FFFFFF')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            this.addMarker();
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#4D3B82F6', 0.0],
          ['#F0F9FF', 0.5],
          ['#4D06B6D4', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}