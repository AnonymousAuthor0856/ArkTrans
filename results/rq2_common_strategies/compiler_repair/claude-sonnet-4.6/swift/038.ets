// Data model for markers
interface Marker {
  id: string;
  x: number;
  y: number;
  label: string;
}

// Color tokens
const PRIMARY_COLOR = '#FF06B6D4';
const SECONDARY_COLOR = '#FF3B82F6';
const BACKGROUND_COLOR = '#FFF0F9FF';
const SURFACE_VARIANT_COLOR = '#FFE0F2FE';
const OUTLINE_COLOR = '#FFBAE6FD';
const ON_PRIMARY_COLOR = '#FFFFFFFF';
const ON_SURFACE_COLOR = '#FF0F172A';

// Spacing tokens
const SPACING_SM = 8;
const SPACING_MD = 12;
const SPACING_LG = 16;
const SPACING_XL = 24;
const SPACING_XXL = 32;

// Shape tokens
const SHAPE_SMALL = 6;
const SHAPE_MEDIUM = 12;
const SHAPE_LARGE = 20;

@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    { id: '1', x: 120, y: 200, label: 'A1' },
    { id: '2', x: 300, y: 400, label: 'B2' },
    { id: '3', x: 520, y: 600, label: 'C3' },
  ];
  @State scanning: boolean = false;
  private canvasWidth: number = 0;
  private canvasHeight: number = 0;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawCanvas() {
    const ctx = this.context;
    ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight);

    const centerX = this.canvasWidth / 2;
    const centerY = this.canvasHeight / 2;
    const minDim = Math.min(this.canvasWidth, this.canvasHeight);
    const innerRadius = minDim / 2.5;

    // Draw inner circle (surfaceVariant)
    ctx.beginPath();
    ctx.arc(centerX, centerY, innerRadius, 0, Math.PI * 2);
    ctx.fillStyle = SURFACE_VARIANT_COLOR;
    ctx.fill();
    ctx.closePath();

    // Draw markers
    for (const marker of this.markers) {
      ctx.beginPath();
      ctx.arc(marker.x, marker.y, 12, 0, Math.PI * 2);
      ctx.fillStyle = PRIMARY_COLOR;
      ctx.fill();
      ctx.closePath();

      // Draw label
      ctx.fillStyle = ON_PRIMARY_COLOR;
      ctx.font = '12px sans-serif';
      ctx.textAlign = 'center';
      ctx.textBaseline = 'middle';
      ctx.fillText(marker.label, marker.x, marker.y);
    }
  }

  build() {
    Column() {
      // Top Bar
      Text('Invoice Scanner')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(ON_SURFACE_COLOR)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: SPACING_LG, bottom: SPACING_LG })
        .backgroundColor(BACKGROUND_COLOR)

      // Main Content Area
      Column({ space: SPACING_LG }) {
        // Canvas Surface
        Stack() {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.canvasWidth = this.context.width;
              this.canvasHeight = this.context.height;
              this.drawCanvas();
            })
            .padding(SPACING_MD)
        }
        .width('100%')
        .height(400)
        .backgroundColor('#E6FFFFFF')
        .borderRadius(SHAPE_LARGE)
        .shadow({
          radius: 8,
          color: '#2E000000',
          offsetX: 0,
          offsetY: 4,
        })

        // Scanning Active Row
        Row() {
          Text('Scanning Active')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(ON_SURFACE_COLOR)

          Blank()

          // Custom Toggle
          Stack({ alignContent: Alignment.Center }) {
            // Track
            Row()
              .width(50)
              .height(30)
              .borderRadius(15)
              .backgroundColor(this.scanning ? SECONDARY_COLOR : SURFACE_VARIANT_COLOR)
              .animation({
                duration: 200,
                curve: Curve.EaseInOut,
              })

            // Thumb
            Row()
              .width(26)
              .height(26)
              .borderRadius(13)
              .backgroundColor(this.scanning ? ON_PRIMARY_COLOR : OUTLINE_COLOR)
              .margin({ left: this.scanning ? 20 : 0, right: this.scanning ? 0 : 20 })
              .animation({
                duration: 200,
                curve: Curve.EaseInOut,
              })
          }
          .width(50)
          .height(30)
          .onClick(() => {
            this.scanning = !this.scanning;
          })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        // Add Marker Button
        Button('Add Marker')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_PRIMARY_COLOR)
          .width('100%')
          .height(48)
          .backgroundColor(PRIMARY_COLOR)
          .borderRadius(SHAPE_MEDIUM)
          .onClick(() => {
            if (this.scanning) {
              const newId: string = Date.now().toString();
              const newX: number = Math.random() * (580 - 80) + 80;
              const newY: number = Math.random() * (650 - 150) + 150;
              const newLabel: string = `N${this.markers.length + 1}`;
              const newMarker: Marker = {
                id: newId,
                x: newX,
                y: newY,
                label: newLabel,
              };
              const updatedMarkers: Marker[] = [...this.markers, newMarker];
              this.markers = updatedMarkers;
              this.drawCanvas();
            }
          })
      }
      .padding(SPACING_LG)
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#4D3B82F6', 0.0],
          ['#FFF0F9FF', 0.5],
          ['#4D06B6D4', 1.0],
        ],
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND_COLOR)
  }
}