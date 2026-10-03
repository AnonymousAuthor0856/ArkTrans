// AppTokens - design tokens
class AppTokens {
  static Colors = class {
    static primary: Color = Color.rgb(255, 140, 0);
    static secondary: Color = Color.rgb(255, 193, 7);
    static tertiary: Color = Color.rgb(255, 224, 130);
    static background: Color = Color.rgb(255, 248, 225);
    static surface: Color = Color.White;
    static surfaceVariant: Color = Color.rgb(255, 236, 179);
    static outline: Color = Color.rgb(215, 204, 200);
    static success: Color = Color.rgb(76, 175, 80);
    static warning: Color = Color.rgb(255, 179, 0);
    static error: Color = Color.rgb(229, 57, 53);
    static onPrimary: Color = Color.rgb(62, 39, 35);
    static onSecondary: Color = Color.rgb(62, 39, 35);
    static onBackground: Color = Color.rgb(62, 39, 35);
    static onSurface: Color = Color.rgb(62, 39, 35);
  };

  static TypographyTokens = class {
    static display: { size: number; weight: number } = { size: 28, weight: FontWeight.Bold };
    static title: { size: number; weight: number } = { size: 18, weight: FontWeight.Medium };
    static body: { size: number; weight: number } = { size: 14, weight: FontWeight.Normal };
    static label: { size: number; weight: number } = { size: 12, weight: FontWeight.Medium };
  };

  static Shapes = class {
    static small: number = 6;
    static medium: number = 10;
    static large: number = 16;
  };

  static Spacing = class {
    static sm: number = 6;
    static md: number = 10;
    static lg: number = 16;
    static xl: number = 24;
  };

  static ElevationMapping = class {
    static level1: { radius: number; dy: number; opacity: number } = { radius: 4, dy: 2, opacity: 0.1 };
    static level2: { radius: number; dy: number; opacity: number } = { radius: 8, dy: 4, opacity: 0.15 };
    static level3: { radius: number; dy: number; opacity: number } = { radius: 12, dy: 6, opacity: 0.18 };
  };
}

// Pin data model
interface Pin {
  id: string;
  x: number;
  y: number;
  label: string;
}

@Entry
@Component
struct RootScreen {
  @State pins: Pin[] = [
    { id: '1', x: 150, y: 250, label: 'Group A' },
    { id: '2', x: 350, y: 420, label: 'Group B' },
    { id: '3', x: 520, y: 310, label: 'Group C' }
  ];
  private nextId: number = 4;

  private buildPinsSettings = (ctx: CanvasRenderingContext2D) => {
    ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
    for (let i = 0; i < this.pins.length; i++) {
      const pin = this.pins[i];
      ctx.beginPath();
      ctx.arc(pin.x, pin.y, 14, 0, Math.PI * 2);
      ctx.fillStyle = '#FF8C00';
      ctx.fill();
    }
  };

  build() {
    Stack() {
      Column({ space: AppTokens.Spacing.lg }) {
        Text('Retro Group Buy')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        // Live Deals Map card
        Column() {
          Text('Live Deals Map')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ bottom: AppTokens.Spacing.md })

          Stack() {
            Canvas(this.buildPinsSettings)
              .width('100%')
              .height('100%')
              .padding(8)
          }
          .width('100%')
          .height(220)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)
        }
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: AppTokens.Colors.onSurface.opacity(AppTokens.ElevationMapping.level2.opacity),
          offsetY: AppTokens.ElevationMapping.level2.dy
        })

        // Buttons row
        Row({ space: AppTokens.Spacing.md }) {
          Button('Add Group')
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.medium)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              const randomX = 100 + Math.random() * 450;
              const randomY = 150 + Math.random() * 300;
              this.pins.push({
                id: String(this.nextId++),
                x: randomX,
                y: randomY,
                label: 'New'
              });
            })

          Button('Clear')
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              this.pins = [];
            })
        }
        .width('100%')

        // Active Groups card
        Column({ space: AppTokens.Spacing.sm }) {
          Text('Active Groups')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.primary)
            .width('100%')
            .textAlign(TextAlign.Start)

          ForEach(this.pins, (pin: Pin) => {
            Row() {
              Text(pin.label)
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontWeight(AppTokens.TypographyTokens.body.weight)
                .fontColor(AppTokens.Colors.onSurface)

              Blank()

              Circle({ width: 14, height: 14 })
                .fill(AppTokens.Colors.primary)
            }
            .width('100%')
          }, (pin: Pin) => pin.id)
        }
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level1.radius,
          color: AppTokens.Colors.onSurface.opacity(AppTokens.ElevationMapping.level1.opacity),
          offsetY: AppTokens.ElevationMapping.level1.dy
        })

        Blank()
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
