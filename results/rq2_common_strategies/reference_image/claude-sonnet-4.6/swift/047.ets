// EntryAbility / pages/Index.ets
// ArkTS (HarmonyOS ArkUI) port of the SwiftUI "Retro Group Buy" screen.

// MARK: - AppTokens
class AppTokens {
  // MARK: Colors
  static primary: string = '#FF8C00';
  static secondary: string = '#FFC107';
  static tertiary: string = '#FFE082';
  static background: string = '#FFF8E1';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#FFECB3';
  static outline: string = '#D7CCC8';
  static success: string = '#4CAF50';
  static warning: string = '#FFB300';
  static error: string = '#E53935';
  static onPrimary: string = '#3E2723';
  static onSecondary: string = '#3E2723';
  static onBackground: string = '#3E2723';
  static onSurface: string = '#3E2723';

  // MARK: Typography
  static displaySize: number = 28;
  static titleSize: number = 18;
  static bodySize: number = 14;
  static labelSize: number = 12;

  // MARK: Shapes (dp)
  static radiusSmall: number = 6;
  static radiusMedium: number = 10;
  static radiusLarge: number = 16;

  // MARK: Spacing (dp)
  static sm: number = 6;
  static md: number = 10;
  static lg: number = 16;
  static xl: number = 24;

  // MARK: Elevation mapping
  // #AARRGGBB -> alpha 0x1A = 0.10, 0x26 = 0.15
  static level1: ShadowOptions = {
    radius: 2,
    color: '#1A3E2723',
    offsetX: 0,
    offsetY: 2
  };
  static level2: ShadowOptions = {
    radius: 6,
    color: '#263E2723',
    offsetX: 0,
    offsetY: 4
  };
}

// MARK: - Pin model
class Pin {
  id: number;
  x: number;
  y: number;
  label: string;

  constructor(id: number, x: number, y: number, label: string) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

@Entry
@Component
struct RootScreen {
  @State @Watch('onPinsChanged') pins: Pin[] = [
    new Pin(1, 150, 250, 'Group A'),
    new Pin(2, 350, 420, 'Group B'),
    new Pin(3, 520, 310, 'Group C')
  ];

  private nextId: number = 4;
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true));
  private canvasReady: boolean = false;

  onPinsChanged(): void {
    if (this.canvasReady) {
      this.drawPins();
    }
  }

  private drawPins(): void {
    const w: number = this.ctx.width;
    const h: number = this.ctx.height;
    this.ctx.clearRect(0, 0, w, h);
    this.ctx.fillStyle = AppTokens.primary;
    for (let i = 0; i < this.pins.length; i++) {
      const pin: Pin = this.pins[i];
      // drawCircle(radius = 14f) -> arc with radius 14
      this.ctx.beginPath();
      this.ctx.arc(pin.x, pin.y, 14, 0, Math.PI * 2);
      this.ctx.fill();
    }
  }

  @Builder
  mapCanvas() {
    Canvas(this.ctx)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.canvasReady = true;
        this.drawPins();
      })
  }

  @Builder
  primaryButton(label: string, bg: string, fg: string, action: () => void) {
    Button(label, { type: ButtonType.Normal, stateEffect: true })
      .fontSize(AppTokens.labelSize)
      .fontWeight(FontWeight.Medium)
      .fontColor(fg)
      .backgroundColor(bg)
      .borderRadius(AppTokens.radiusMedium)
      .height(48)
      .layoutWeight(1)
      .onClick(action)
  }

  build() {
    Column({ space: AppTokens.lg }) {
      // Title
      Text('Retro Group Buy')
        .fontSize(AppTokens.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.onBackground)
        .width('100%')
        .textAlign(TextAlign.Start)

      // "Live Deals Map" card
      Column({ space: AppTokens.md }) {
        Text('Live Deals Map')
          .fontSize(AppTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.onSurface)

        Column() {
          this.mapCanvas()
        }
        .width('100%')
        .height(220)
        .padding(8)
        .backgroundColor(AppTokens.surfaceVariant)
        .borderRadius(AppTokens.radiusMedium)
        .clip(true)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .padding(AppTokens.lg)
      .backgroundColor(AppTokens.surface)
      .borderRadius(AppTokens.radiusLarge)
      .shadow(AppTokens.level2)

      // Spacer(sm)
      Blank().height(AppTokens.sm)

      // Button row
      Row({ space: AppTokens.md }) {
        this.primaryButton('Add Group', AppTokens.secondary, AppTokens.onSecondary, () => {
          const randomX: number = 100 + Math.floor(Math.random() * 450); // 100..<550
          const randomY: number = 150 + Math.floor(Math.random() * 300); // 150..<450
          const newPin: Pin = new Pin(this.nextId++, randomX, randomY, 'New');
          this.pins = this.pins.concat(newPin);
        })

        this.primaryButton('Clear', AppTokens.primary, AppTokens.onPrimary, () => {
          this.pins = [];
        })
      }
      .width('100%')

      // "Active Groups" card
      Column({ space: AppTokens.sm }) {
        Text('Active Groups')
          .fontSize(AppTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.primary)

        ForEach(this.pins, (pin: Pin) => {
          Row() {
            Text(pin.label)
              .fontSize(AppTokens.bodySize)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppTokens.onSurface)
            Blank()
            Circle({ width: 14, height: 14 })
              .fill(AppTokens.primary)
          }
          .width('100%')
        }, (pin: Pin) => pin.id.toString())
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .padding(AppTokens.lg)
      .backgroundColor(AppTokens.surface)
      .borderRadius(AppTokens.radiusLarge)
      .shadow(AppTokens.level1)

      Blank()
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .height('100%')
    .padding(AppTokens.lg)
    .backgroundColor(AppTokens.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}