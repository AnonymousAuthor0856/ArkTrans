// Typography token type
interface TypographyToken {
  size: number;
  weight: number;
}

// Elevation token type
interface ElevationToken {
  radius: number;
  dy: number;
  opacity: number;
}

// Pin data model
interface Pin {
  id: string;
  x: number;
  y: number;
  label: string;
}

// AppTokens - design tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FF8C00';
    export const secondary: string = '#FFC107';
    export const tertiary: string = '#FFE082';
    export const background: string = '#FFF8E1';
    export const surface: string = '#FFFFFF';
    export const surfaceVariant: string = '#FFECB3';
    export const outline: string = '#D7CCC8';
    export const success: string = '#4CAF50';
    export const warning: string = '#FFB300';
    export const error: string = '#E53935';
    export const onPrimary: string = '#3E2723';
    export const onSecondary: string = '#3E2723';
    export const onBackground: string = '#3E2723';
    export const onSurface: string = '#3E2723';
  }

  export namespace TypographyTokens {
    export const display: TypographyToken = { size: 28, weight: FontWeight.Bold };
    export const title: TypographyToken = { size: 18, weight: FontWeight.Medium };
    export const body: TypographyToken = { size: 14, weight: FontWeight.Normal };
    export const label: TypographyToken = { size: 12, weight: FontWeight.Medium };
  }

  export namespace Shapes {
    export const small: number = 6;
    export const medium: number = 10;
    export const large: number = 16;
  }

  export namespace Spacing {
    export const sm: number = 6;
    export const md: number = 10;
    export const lg: number = 16;
    export const xl: number = 24;
  }

  export namespace ElevationMapping {
    export const level1: ElevationToken = { radius: 4, dy: 2, opacity: 0.1 };
    export const level2: ElevationToken = { radius: 8, dy: 4, opacity: 0.15 };
    export const level3: ElevationToken = { radius: 12, dy: 6, opacity: 0.18 };
  }
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

  private canvasSettings = (ctx: CanvasRenderingContext2D) => {
    ctx.clearRect(0, 0, 600, 220);
    for (let i = 0; i < this.pins.length; i++) {
      const pin = this.pins[i];
      ctx.beginPath();
      ctx.arc(pin.x, pin.y, 14, 0, Math.PI * 2);
      ctx.fillStyle = AppTokens.Colors.primary;
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
            Canvas(this.canvasSettings)
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
          color: AppTokens.Colors.onSurface,
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
          color: AppTokens.Colors.onSurface,
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
