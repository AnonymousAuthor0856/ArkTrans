import { common } from '@kit.AbilityKit';

// Color tokens
const COLOR_PRIMARY = '#FFFF8C00';
const COLOR_SECONDARY = '#FFFFC107';
const COLOR_TERTIARY = '#FFFFE082';
const COLOR_BACKGROUND = '#FFFFF8E1';
const COLOR_SURFACE = '#FFFFFFFF';
const COLOR_SURFACE_VARIANT = '#FFFFECB3';
const COLOR_OUTLINE = '#FFD7CCC8';
const COLOR_ON_PRIMARY = '#FF3E2723';
const COLOR_ON_SECONDARY = '#FF3E2723';
const COLOR_ON_BACKGROUND = '#FF3E2723';
const COLOR_ON_SURFACE = '#FF3E2723';

interface PinData {
  x: number;
  y: number;
  label: string;
}

@Entry
@Component
struct RootScreen {
  @State pins: PinData[] = [
    { x: 150, y: 250, label: 'Group A' },
    { x: 350, y: 420, label: 'Group B' },
    { x: 520, y: 310, label: 'Group C' }
  ];

  addRandomPin() {
    const x = Math.floor(Math.random() * 450) + 100;
    const y = Math.floor(Math.random() * 300) + 150;
    const newPin: PinData = { x: x, y: y, label: 'New' };
    this.pins = [...this.pins, newPin];
  }

  clearPins() {
    this.pins = [];
  }

  build() {
    Scroll() {
      Column({ space: 16 }) {
        // Title
        Text('Retro Group Buy')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_BACKGROUND)
          .width('100%')

        // Map Card
        Column({ space: 10 }) {
          Text('Live Deals Map')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_SURFACE)
            .width('100%')

          // Map Canvas Area
          Stack() {
            Canvas(this.mapContext)
              .width('100%')
              .height(220)
              .backgroundColor(COLOR_SURFACE_VARIANT)
              .borderRadius(10)
              .onReady(() => {
                this.drawMap();
              })
          }
          .width('100%')
          .height(220)
          .borderRadius(10)
          .backgroundColor(COLOR_SURFACE_VARIANT)
        }
        .width('100%')
        .padding(16)
        .backgroundColor(COLOR_SURFACE)
        .borderRadius(16)
        .shadow({ radius: 8, color: '#26000000', offsetX: 0, offsetY: 4 })

        // Buttons Row
        Row({ space: 10 }) {
          Button('Add Group')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_SECONDARY)
            .backgroundColor(COLOR_SECONDARY)
            .borderRadius(10)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              this.addRandomPin();
              this.drawMap();
            })

          Button('Clear')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_PRIMARY)
            .backgroundColor(COLOR_PRIMARY)
            .borderRadius(10)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              this.clearPins();
              this.drawMap();
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        // Active Groups Card
        Column({ space: 6 }) {
          Text('Active Groups')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_PRIMARY)
            .width('100%')

          ForEach(this.pins, (pin: PinData) => {
            Row() {
              Text(pin.label)
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor(COLOR_ON_SURFACE)

              Circle({ width: 14, height: 14 })
                .fill(COLOR_PRIMARY)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
          }, (pin: PinData, index: number) => index.toString() + pin.label)
        }
        .width('100%')
        .padding(16)
        .backgroundColor(COLOR_SURFACE)
        .borderRadius(16)
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
      }
      .width('100%')
      .padding(16)
      .backgroundColor(COLOR_BACKGROUND)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }

  private mapContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  );

  drawMap() {
    const ctx = this.mapContext;
    if (!ctx) return;

    ctx.clearRect(0, 0, ctx.width, ctx.height);

    // Draw background
    ctx.fillStyle = COLOR_SURFACE_VARIANT;
    ctx.fillRect(0, 0, ctx.width, ctx.height);

    // Draw grid lines
    ctx.strokeStyle = '#FFECB3';
    ctx.lineWidth = 1;
    for (let i = 0; i < ctx.width; i += 50) {
      ctx.beginPath();
      ctx.moveTo(i, 0);
      ctx.lineTo(i, ctx.height);
      ctx.stroke();
    }
    for (let j = 0; j < ctx.height; j += 50) {
      ctx.beginPath();
      ctx.moveTo(0, j);
      ctx.lineTo(ctx.width, j);
      ctx.stroke();
    }

    // Draw pins
    this.pins.forEach((pin: PinData) => {
      // Pin circle
      ctx.beginPath();
      ctx.arc(pin.x, pin.y, 14, 0, Math.PI * 2);
      ctx.fillStyle = COLOR_PRIMARY;
      ctx.fill();

      // Pin inner circle
      ctx.beginPath();
      ctx.arc(pin.x, pin.y, 6, 0, Math.PI * 2);
      ctx.fillStyle = COLOR_ON_PRIMARY;
      ctx.fill();

      // Pin label
      ctx.fillStyle = COLOR_ON_BACKGROUND;
      ctx.font = '11px sans-serif';
      ctx.textAlign = 'center';
      ctx.fillText(pin.label, pin.x, pin.y + 28);
    });
  }
}