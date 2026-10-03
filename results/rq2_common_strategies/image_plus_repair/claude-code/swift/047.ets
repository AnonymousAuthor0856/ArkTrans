class ColorTokens {
  primary: string = '#FF8C00';
  secondary: string = '#FFC107';
  tertiary: string = '#FFE082';
  background: string = '#FFF8E1';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#FFECB3';
  outline: string = '#D7CCC8';
  success: string = '#4CAF50';
  warning: string = '#FFB300';
  error: string = '#E53935';
  onPrimary: string = '#3E2723';
  onSecondary: string = '#3E2723';
  onBackground: string = '#3E2723';
  onSurface: string = '#3E2723';
}

class TypographyTokens {
  displaySize: number = 28;
  displayWeight: number = FontWeight.Bold;
  titleSize: number = 18;
  titleWeight: number = FontWeight.Medium;
  bodySize: number = 14;
  bodyWeight: number = FontWeight.Normal;
  labelSize: number = 12;
  labelWeight: number = FontWeight.Medium;
}

class ShapeTokens {
  small: number = 6;
  medium: number = 10;
  large: number = 16;
}

class SpacingTokens {
  sm: number = 6;
  md: number = 10;
  lg: number = 16;
  xl: number = 24;
}

class AppTokens {
  static Colors: ColorTokens = new ColorTokens();
  static Typography: TypographyTokens = new TypographyTokens();
  static Shapes: ShapeTokens = new ShapeTokens();
  static Spacing: SpacingTokens = new SpacingTokens();
}

class Pin {
  id: string;
  x: number;
  y: number;
  label: string;

  constructor(id: string, x: number, y: number, label: string) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

@Entry
@Component
struct RootScreen {
  @State pins: Pin[] = [
    new Pin('1', 150, 120, 'Group A'),
    new Pin('2', 300, 180, 'Group B'),
    new Pin('3', 220, 80, 'Group C')
  ];

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private addGroup(): void {
    const randomX: number = 50 + Math.random() * 300;
    const randomY: number = 40 + Math.random() * 140;
    this.pins.push(new Pin(Date.now().toString(), randomX, randomY, 'New'));
    this.drawPins();
  }

  private clearAll(): void {
    this.pins = [];
    this.drawPins();
  }

  build() {
    Stack() {
      Column({ space: AppTokens.Spacing.lg }) {
        Text('Retro Group Buy')
          .fontSize(AppTokens.Typography.displaySize)
          .fontWeight(AppTokens.Typography.displayWeight)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        Column() {
          Text('Live Deals Map')
            .fontSize(AppTokens.Typography.titleSize)
            .fontWeight(AppTokens.Typography.titleWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ bottom: AppTokens.Spacing.md })

          Stack() {
            Canvas(this.canvasCtx)
              .width('100%')
              .height(220)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .padding(8)
              .onReady(() => {
                this.drawPins();
              })
          }
          .width('100%')
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: 8,
          color: 'rgba(0, 0, 0, 0.15)',
          offsetY: 4
        })

        Blank()
          .height(AppTokens.Spacing.sm)

        Row({ space: AppTokens.Spacing.md }) {
          Button('Add Group')
            .onClick(() => {
              this.addGroup();
            })
            .fontSize(AppTokens.Typography.labelSize)
            .fontWeight(AppTokens.Typography.labelWeight)
            .fontColor(AppTokens.Colors.onSecondary)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.medium)
            .height(48)
            .layoutWeight(1)

          Button('Clear')
            .onClick(() => {
              this.clearAll();
            })
            .fontSize(AppTokens.Typography.labelSize)
            .fontWeight(AppTokens.Typography.labelWeight)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .height(48)
            .layoutWeight(1)
        }
        .width('100%')

        Column({ space: AppTokens.Spacing.sm }) {
          Text('Active Groups')
            .fontSize(AppTokens.Typography.titleSize)
            .fontWeight(AppTokens.Typography.titleWeight)
            .fontColor(AppTokens.Colors.primary)
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ bottom: AppTokens.Spacing.sm })

          ForEach(this.pins, (pin: Pin) => {
            Row() {
              Text(pin.label)
                .fontSize(AppTokens.Typography.bodySize)
                .fontWeight(AppTokens.Typography.bodyWeight)
                .fontColor(AppTokens.Colors.onSurface)

              Blank()

              Circle({ width: 28, height: 28 })
                .fill(AppTokens.Colors.primary)
            }
            .width('100%')
            .padding({ top: 6, bottom: 6 })
          }, (pin: Pin) => pin.id)
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: 4,
          color: 'rgba(0, 0, 0, 0.1)',
          offsetY: 2
        })

        Blank()
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  private drawPins(): void {
    this.canvasCtx.clearRect(0, 0, 600, 220);
    for (let i: number = 0; i < this.pins.length; i++) {
      const pin: Pin = this.pins[i];
      this.canvasCtx.beginPath();
      this.canvasCtx.arc(pin.x, pin.y, 14, 0, Math.PI * 2);
      this.canvasCtx.fillStyle = AppTokens.Colors.primary;
      this.canvasCtx.fill();
    }
  }
}
