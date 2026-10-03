// AppTokens Colors interface
interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onBackground: string;
  onSurface: string;
}

interface SpacingTokens {
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

const Colors: ColorTokens = {
  primary: '#FF8C00',
  secondary: '#FFC107',
  tertiary: '#FFE082',
  background: '#FFF8E1',
  surface: '#FFFFFF',
  surfaceVariant: '#FFECB3',
  outline: '#D7CCC8',
  success: '#4CAF50',
  warning: '#FFB300',
  error: '#E53935',
  onPrimary: '#3E2723',
  onSecondary: '#3E2723',
  onBackground: '#3E2723',
  onSurface: '#3E2723',
};

const Spacing: SpacingTokens = {
  sm: 6,
  md: 10,
  lg: 16,
  xl: 24,
};

interface PinData {
  id: number;
  x: number;
  y: number;
  label: string;
}

@Entry
@Component
struct RootScreen {
  @State pins: PinData[] = [
    { id: 1, x: 150, y: 180, label: 'Group A' } as PinData,
    { id: 2, x: 280, y: 120, label: 'Group B' } as PinData,
    { id: 3, x: 200, y: 60, label: 'Group C' } as PinData,
  ];
  @State nextId: number = 4;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawPins() {
    this.canvasContext.clearRect(0, 0, this.canvasContext.width, this.canvasContext.height);
    for (const pin of this.pins) {
      this.canvasContext.beginPath();
      this.canvasContext.arc(pin.x, pin.y, 14, 0, Math.PI * 2);
      this.canvasContext.fillStyle = Colors.primary;
      this.canvasContext.fill();
      this.canvasContext.closePath();
    }
  }

  build() {
    Stack() {
      // Background
      Column() {}
      .width('100%')
      .height('100%')
      .backgroundColor(Colors.background)

      Scroll() {
        Column({ space: Spacing.lg }) {
          // Title
          Text('Retro Group Buy')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onBackground)
            .width('100%')
            .textAlign(TextAlign.Start)

          // Live Deals Map Card
          Column({ space: Spacing.md }) {
            Text('Live Deals Map')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
              .width('100%')
              .textAlign(TextAlign.Start)

            Stack() {
              Column() {}
              .width('100%')
              .height(220)
              .backgroundColor(Colors.surfaceVariant)
              .borderRadius(10)

              Canvas(this.canvasContext)
                .width('100%')
                .height(220)
                .borderRadius(10)
                .onReady(() => {
                  this.drawPins();
                })
            }
            .width('100%')
            .height(220)
          }
          .padding(Spacing.lg)
          .width('100%')
          .backgroundColor(Colors.surface)
          .borderRadius(16)
          .shadow({
            radius: 6,
            color: '#26000000',
            offsetX: 0,
            offsetY: 4,
          } as ShadowOptions)

          // Spacer
          Column() {}
          .height(Spacing.sm)

          // Buttons Row
          Row({ space: Spacing.md }) {
            Button() {
              Text('Add Group')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSecondary)
            }
            .width('50%')
            .height(48)
            .backgroundColor(Colors.secondary)
            .borderRadius(10)
            .onClick(() => {
              const randomX: number = Math.random() * (550 - 100) + 100;
              const randomY: number = Math.random() * (220 - 30) + 30;
              const newPin: PinData = {
                id: this.nextId,
                x: randomX,
                y: randomY,
                label: 'New',
              } as PinData;
              this.pins = [...this.pins, newPin];
              this.nextId += 1;
              this.drawPins();
            })

            Button() {
              Text('Clear')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onPrimary)
            }
            .width('50%')
            .height(48)
            .backgroundColor(Colors.primary)
            .borderRadius(10)
            .onClick(() => {
              this.pins = [];
              this.drawPins();
            })
          }
          .width('100%')

          // Active Groups Card
          Column({ space: Spacing.sm }) {
            Text('Active Groups')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.primary)
              .width('100%')
              .textAlign(TextAlign.Start)

            ForEach(this.pins, (pin: PinData) => {
              Row() {
                Text(pin.label)
                  .fontSize(14)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(Colors.onSurface)

                Blank()

                Circle()
                  .width(14)
                  .height(14)
                  .fill(Colors.primary)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            }, (pin: PinData) => pin.id.toString())
          }
          .padding(Spacing.lg)
          .width('100%')
          .backgroundColor(Colors.surface)
          .borderRadius(16)
          .shadow({
            radius: 2,
            color: '#1A000000',
            offsetX: 0,
            offsetY: 2,
          } as ShadowOptions)
        }
        .padding(Spacing.lg)
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