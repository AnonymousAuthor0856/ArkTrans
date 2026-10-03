// Color tokens
const colorPrimary = '#FF8C00';
const colorSecondary = '#FFC107';
const colorTertiary = '#FFE082';
const colorBackground = '#FFF8E1';
const colorSurface = '#FFFFFF';
const colorSurfaceVariant = '#FFECB3';
const colorOutline = '#D7CCC8';
const colorSuccess = '#4CAF50';
const colorWarning = '#FFB300';
const colorError = '#E53935';
const colorOnPrimary = '#3E2723';
const colorOnSecondary = '#3E2723';
const colorOnBackground = '#3E2723';
const colorOnSurface = '#3E2723';

// Spacing tokens
const spacingSm = 6;
const spacingMd = 10;
const spacingLg = 16;
const spacingXl = 24;

interface PinData {
  id: string;
  x: number;
  y: number;
  label: string;
}

@Entry
@Component
struct RootScreen {
  @State pins: PinData[] = [
    { id: '1', x: 150, y: 200, label: 'Group A' },
    { id: '2', x: 280, y: 150, label: 'Group B' },
    { id: '3', x: 200, y: 100, label: 'Group C' },
  ];
  private nextId: number = 4;
  private mapWidth: number = 0;
  private mapHeight: number = 220;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawPins() {
    this.canvasContext.clearRect(0, 0, this.mapWidth, this.mapHeight);
    this.canvasContext.fillStyle = colorPrimary;
    for (const pin of this.pins) {
      this.canvasContext.beginPath();
      this.canvasContext.arc(pin.x, pin.y, 14, 0, Math.PI * 2);
      this.canvasContext.fill();
    }
  }

  build() {
    Stack() {
      // Background
      Column() {
      }
      .width('100%')
      .height('100%')
      .backgroundColor(colorBackground)

      Scroll() {
        Column({ space: spacingLg }) {
          // Title
          Text('Retro Group Buy')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(colorOnBackground)
            .width('100%')
            .textAlign(TextAlign.Start)

          // Live Deals Map Card
          Column({ space: spacingMd }) {
            Text('Live Deals Map')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(colorOnSurface)
              .width('100%')
              .textAlign(TextAlign.Start)

            // Map Canvas Area
            Stack() {
              Column() {
              }
              .width('100%')
              .height(220)
              .backgroundColor(colorSurfaceVariant)
              .borderRadius(10)

              Canvas(this.canvasContext)
                .width('100%')
                .height(220)
                .borderRadius(10)
                .onReady(() => {
                  this.mapWidth = this.canvasContext.width;
                  this.drawPins();
                })
            }
            .width('100%')
            .height(220)
            .borderRadius(10)
          }
          .padding(spacingLg)
          .width('100%')
          .backgroundColor(colorSurface)
          .borderRadius(16)
          .shadow({
            radius: 6,
            color: '#26000000',
            offsetX: 0,
            offsetY: 4
          })
          .alignItems(HorizontalAlign.Start)

          // Spacer
          Column() {
          }.height(spacingSm)

          // Buttons Row
          Row({ space: spacingMd }) {
            Button() {
              Text('Add Group')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(colorOnSecondary)
            }
            .height(48)
            .backgroundColor(colorSecondary)
            .borderRadius(10)
            .onClick(() => {
              const randomX = Math.random() * (550 - 100) + 100;
              const randomY = Math.random() * (450 - 150) + 150;
              const newPin: PinData = {
                id: String(this.nextId++),
                x: randomX,
                y: randomY,
                label: 'New'
              };
              this.pins = [...this.pins, newPin];
              this.drawPins();
            })
            .layoutWeight(1)

            Button() {
              Text('Clear')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(colorOnPrimary)
            }
            .height(48)
            .backgroundColor(colorPrimary)
            .borderRadius(10)
            .onClick(() => {
              this.pins = [];
              this.drawPins();
            })
            .layoutWeight(1)
          }
          .width('100%')

          // Active Groups Card
          Column({ space: spacingSm }) {
            Text('Active Groups')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(colorPrimary)
              .width('100%')
              .textAlign(TextAlign.Start)

            ForEach(this.pins, (pin: PinData) => {
              Row() {
                Text(pin.label)
                  .fontSize(14)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(colorOnSurface)

                Blank()

                Circle()
                  .width(14)
                  .height(14)
                  .fill(colorPrimary)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            }, (pin: PinData) => pin.id)
          }
          .padding(spacingLg)
          .width('100%')
          .backgroundColor(colorSurface)
          .borderRadius(16)
          .shadow({
            radius: 2,
            color: '#1A000000',
            offsetX: 0,
            offsetY: 2
          })
          .alignItems(HorizontalAlign.Start)

          // Bottom spacer
          Column() {
          }.height(spacingLg)
        }
        .padding(spacingLg)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
  }
}