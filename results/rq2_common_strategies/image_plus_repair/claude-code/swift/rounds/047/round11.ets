// AppTokens - design tokens
class AppTokens {
  static Colors = {
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
    onSurface: '#3E2723'
  };

  static TypographyTokens = {
    displaySize: 28,
    displayWeight: FontWeight.Bold,
    titleSize: 18,
    titleWeight: FontWeight.Medium,
    bodySize: 14,
    bodyWeight: FontWeight.Normal,
    labelSize: 12,
    labelWeight: FontWeight.Medium
  };

  static Shapes = {
    small: 6,
    medium: 10,
    large: 16
  };

  static Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24
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

  private addGroup() {
    const randomX = 100 + Math.random() * 450;
    const randomY = 150 + Math.random() * 300;
    this.pins.push({ id: Date.now().toString(), x: randomX, y: randomY, label: 'New' });
  }

  private clearAll() {
    this.pins = [];
  }

  build() {
    Stack() {
      Column({ space: AppTokens.Spacing.lg }) {
        Text('Retro Group Buy')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(AppTokens.TypographyTokens.displayWeight)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        // Live Deals Map Card
        Column() {
          Text('Live Deals Map')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ bottom: AppTokens.Spacing.md })

          Stack() {
            Canvas(this.pins)
              .width('100%')
              .height(220)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .padding(8)
              .onReady((ctx: CanvasRenderingContext2D) => {
                this.drawPins(ctx);
              })
          }
          .width('100%')
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: 6,
          color: 'rgba(62, 39, 35, 0.15)',
          offsetY: 4
        })

        Blank()
          .height(AppTokens.Spacing.sm)

        // Buttons Row
        Row({ space: AppTokens.Spacing.md }) {
          Button('Add Group')
            .onClick(() => {
              this.addGroup();
            })
            .fontSize(AppTokens.TypographyTokens.labelSize)
            .fontWeight(AppTokens.TypographyTokens.labelWeight)
            .fontColor(AppTokens.Colors.onSecondary)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.medium)
            .height(48)
            .layoutWeight(1)

          Button('Clear')
            .onClick(() => {
              this.clearAll();
            })
            .fontSize(AppTokens.TypographyTokens.labelSize)
            .fontWeight(AppTokens.TypographyTokens.labelWeight)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .height(48)
            .layoutWeight(1)
        }
        .width('100%')

        // Active Groups Card
        Column({ space: AppTokens.Spacing.sm }) {
          Text('Active Groups')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(AppTokens.Colors.primary)
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ bottom: AppTokens.Spacing.sm })

          ForEach(this.pins, (pin: Pin) => {
            Row() {
              Text(pin.label)
                .fontSize(AppTokens.TypographyTokens.bodySize)
                .fontWeight(AppTokens.TypographyTokens.bodyWeight)
                .fontColor(AppTokens.Colors.onSurface)

              Blank()

              Circle({ width: 14, height: 14 })
                .fill(AppTokens.Colors.primary)
            }
            .width('100%')
            .padding({ top: 4, bottom: 4 })
          }, (pin: Pin) => pin.id)
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: 2,
          color: 'rgba(62, 39, 35, 0.1)',
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

  private drawPins(ctx: CanvasRenderingContext2D) {
    for (const pin of this.pins) {
      ctx.beginPath();
      ctx.arc(pin.x, pin.y, 14, 0, Math.PI * 2);
      ctx.fillStyle = AppTokens.Colors.primary;
      ctx.fill();
    }
  }
}
