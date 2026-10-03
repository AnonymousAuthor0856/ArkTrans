import { curves } from '@kit.ArkUI';

// MARK: - AppTokens
namespace AppTokens {
  export namespace Colors {
    export const primary = '#FF8C00';
    export const secondary = '#FFC107';
    export const tertiary = '#FFE082';
    export const background = '#FFF8E1';
    export const surface = '#FFFFFF';
    export const surfaceVariant = '#FFECB3';
    export const outline = '#D7CCC8';
    export const success = '#4CAF50';
    export const warning = '#FFB300';
    export const error = '#E53935';
    export const onPrimary = '#3E2723';
    export const onSecondary = '#3E2723';
    export const onBackground = '#3E2723';
    export const onSurface = '#3E2723';
  }

  export namespace Typography {
    export const displaySize = 28;
    export const titleSize = 18;
    export const bodySize = 14;
    export const labelSize = 12;
  }

  export namespace Spacing {
    export const sm = 6;
    export const md = 10;
    export const lg = 16;
    export const xl = 24;
  }

  export namespace Shapes {
    export const small = 6;
    export const medium = 10;
    export const large = 16;
  }

  export namespace Elevation {
    export const level1 = { radius: 4, dy: 2, opacity: 0.1 };
    export const level2 = { radius: 8, dy: 4, opacity: 0.15 };
    export const level3 = { radius: 12, dy: 6, opacity: 0.18 };
  }
}

// MARK: - Pin Data Model
interface Pin {
  id: string;
  x: number;
  y: number;
  label: string;
}

function randomInRange(min: number, max: number): number {
  return Math.random() * (max - min) + min;
}

function generateId(): string {
  return Math.random().toString(36).substring(2, 11);
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State pins: Pin[] = [
    { id: generateId(), x: 150, y: 250, label: 'Group A' },
    { id: generateId(), x: 350, y: 420, label: 'Group B' },
    { id: generateId(), x: 520, y: 310, label: 'Group C' },
  ];

  build() {
    Stack() {
      Column({ space: AppTokens.Spacing.lg }) {
        // Title
        Text('Retro Group Buy')
          .fontSize(AppTokens.Typography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        // Live Deals Map Card
        Column({ space: AppTokens.Spacing.md }) {
          Text('Live Deals Map')
            .fontSize(AppTokens.Typography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)

          // Map Canvas Area
          Stack() {
            Canvas(this.mapContext)
              .width('100%')
              .height('100%')
              .onReady(() => {
                this.drawPins();
              })
          }
          .width('100%')
          .height(220)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)
          .padding(8)
          .clip(true)
        }
        .alignItems(HorizontalAlign.Start)
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.Elevation.level2.radius,
          color: `rgba(62,39,35,${AppTokens.Elevation.level2.opacity})`,
          offsetX: 0,
          offsetY: AppTokens.Elevation.level2.dy,
        })

        // Spacer
        Row().height(AppTokens.Spacing.sm)

        // Buttons Row
        Row({ space: AppTokens.Spacing.md }) {
          Button('Add Group')
            .fontSize(AppTokens.Typography.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSecondary)
            .height(48)
            .layoutWeight(1)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              const randomX = randomInRange(100, 550);
              const randomY = randomInRange(150, 450);
              this.pins = [
                ...this.pins,
                { id: generateId(), x: randomX, y: randomY, label: 'New' },
              ];
              this.drawPins();
            })

          Button('Clear')
            .fontSize(AppTokens.Typography.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
            .height(48)
            .layoutWeight(1)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.pins = [];
              this.drawPins();
            })
        }
        .width('100%')

        // Active Groups Card
        Column({ space: AppTokens.Spacing.sm }) {
          Text('Active Groups')
            .fontSize(AppTokens.Typography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.primary)
            .width('100%')
            .textAlign(TextAlign.Start)

          ForEach(
            this.pins,
            (pin: Pin) => {
              Row() {
                Text(pin.label)
                  .fontSize(AppTokens.Typography.bodySize)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(AppTokens.Colors.onSurface)

                Blank()

                Circle()
                  .fill(AppTokens.Colors.primary)
                  .width(14)
                  .height(14)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
            },
            (pin: Pin) => pin.id
          )
        }
        .alignItems(HorizontalAlign.Start)
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.Elevation.level1.radius,
          color: `rgba(62,39,35,${AppTokens.Elevation.level1.opacity})`,
          offsetX: 0,
          offsetY: AppTokens.Elevation.level1.dy,
        })

        Blank()
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  private mapContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  );

  private drawPins(): void {
    const ctx = this.mapContext;
    if (!ctx) return;
    ctx.clearRect(0, 0, ctx.width, ctx.height);
    for (const pin of this.pins) {
      ctx.beginPath();
      ctx.arc(pin.x, pin.y, 14, 0, Math.PI * 2);
      ctx.fillStyle = AppTokens.Colors.primary;
      ctx.fill();
      ctx.closePath();
    }
  }
}