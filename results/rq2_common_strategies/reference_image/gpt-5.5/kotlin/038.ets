class Marker {
  x: number;
  y: number;
  label: string;

  constructor(x: number, y: number, label: string) {
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

const PRIMARY: string = '#06B6D4';
const SECONDARY: string = '#3B82F6';
const BACKGROUND: string = '#F0F9FF';
const SURFACE: string = '#E6FFFFFF';
const SURFACE_VARIANT: string = '#E0F2FE';
const OUTLINE: string = '#BAE6FD';
const ON_SURFACE: string = '#0F172A';
const ON_PRIMARY: string = '#FFFFFF';

const SPACING_MD: number = 12;
const SPACING_LG: number = 16;

@Entry
@Component
struct Index {
  @State private scanning: boolean = false;
  @State private markers: Marker[] = [
    new Marker(120, 200, 'A1'),
    new Marker(300, 400, 'B2'),
    new Marker(520, 600, 'C3')
  ];

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  private canvasReady: boolean = false;

  private randomInt(min: number, max: number): number {
    return Math.floor(Math.random() * (max - min)) + min;
  }

  private drawCanvas(): void {
    if (!this.canvasReady) {
      return;
    }

    const width: number = this.canvasContext.width;
    const height: number = this.canvasContext.height;

    if (width <= 0 || height <= 0) {
      return;
    }

    this.canvasContext.clearRect(0, 0, width, height);

    const centerX: number = width / 2;
    const centerY: number = height / 2;
    const mainRadius: number = Math.min(width, height) / 2.5;

    this.canvasContext.beginPath();
    this.canvasContext.fillStyle = SURFACE_VARIANT;
    this.canvasContext.arc(centerX, centerY, mainRadius, 0, Math.PI * 2);
    this.canvasContext.fill();
    this.canvasContext.closePath();

    const scaleX: number = width / 584;
    const scaleY: number = height / 728;
    const markerRadius: number = 12 * Math.min(scaleX, scaleY);

    for (let i = 0; i < this.markers.length; i++) {
      const marker: Marker = this.markers[i];

      this.canvasContext.beginPath();
      this.canvasContext.fillStyle = PRIMARY;
      this.canvasContext.arc(marker.x * scaleX, marker.y * scaleY, markerRadius, 0, Math.PI * 2);
      this.canvasContext.fill();
      this.canvasContext.closePath();
    }
  }

  build() {
    Column() {
      Row() {
        Text('Invoice Scanner')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(ON_SURFACE)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(BACKGROUND)

      Column({ space: SPACING_LG }) {
        Column() {
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.canvasReady = true;
              this.drawCanvas();
            })
            .onAreaChange((_oldValue: Area, _newValue: Area) => {
              this.drawCanvas();
            })
        }
        .width('100%')
        .height(400)
        .padding({
          left: SPACING_MD,
          right: SPACING_MD,
          top: SPACING_MD,
          bottom: SPACING_MD
        })
        .backgroundColor(SURFACE)
        .borderRadius(20)
        .shadow({
          radius: 8,
          color: '#2E0F172A',
          offsetX: 0,
          offsetY: 4
        })
        .clip(true)

        Row() {
          Text('Scanning Active')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(ON_SURFACE)

          Toggle({ type: ToggleType.Switch, isOn: this.scanning })
            .selectedColor('#BFDBFE')
            .switchPointColor(this.scanning ? SECONDARY : OUTLINE)
            .onChange((isOn: boolean) => {
              this.scanning = isOn;
            })
        }
        .width('100%')
        .height(48)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Add Marker')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(ON_PRIMARY)
        }
        .width('100%')
        .height(48)
        .borderRadius(12)
        .backgroundColor(PRIMARY)
        .onClick(() => {
          if (this.scanning) {
            const newMarker: Marker = new Marker(
              this.randomInt(80, 580),
              this.randomInt(150, 650),
              `N${this.markers.length + 1}`
            );
            this.markers = this.markers.concat([newMarker]);
            this.drawCanvas();
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(SPACING_LG)
      .linearGradient({
        angle: 180,
        colors: [
          ['#4D3B82F6', 0.0],
          [BACKGROUND, 0.5],
          ['#4D06B6D4', 1.0]
        ]
      })
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}