// AppTokens.ets
export class AppTokens {
  static readonly Colors = {
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

  static readonly Typography = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 16
  };

  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24
  };

  static readonly Elevation = {
    level1: { radius: 2, offsetY: 2, opacity: 0.1 },
    level2: { radius: 6, offsetY: 4, opacity: 0.15 },
    level3: { radius: 10, offsetY: 6, opacity: 0.18 }
  };
}

// PinModel.ets
export class Pin {
  id: string;
  x: number;
  y: number;
  label: string;

  constructor(x: number, y: number, label: string) {
    this.id = `${Date.now()}_${Math.random()}`;
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

// RootScreen.ets
import { AppTokens } from './AppTokens';
import { Pin } from './PinModel';

@Entry
@Component
struct RootScreen {
  @State pins: Pin[] = [
    new Pin(150, 250, 'Group A'),
    new Pin(350, 420, 'Group B'),
    new Pin(520, 310, 'Group C')
  ];

  @Builder
  PinCanvas() {
    Stack() {
      // Canvas background
      Rect()
        .fill(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)
        .width('100%')
        .height(220)

      // Draw pins using Canvas
      Canvas(this.pins.length > 0 ? this.pins : [])
        .width('100%')
        .height(220)
        .onReady(() => {
          // Canvas drawing is handled by the renderer
        })
    }
    .width('100%')
    .height(220)
  }

  @Builder
  PinItem(pin: Pin) {
    Row() {
      Text(pin.label)
        .fontSize(AppTokens.Typography.body.fontSize)
        .fontWeight(AppTokens.Typography.body.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)

      Blank()

      Circle()
        .fill(AppTokens.Colors.primary)
        .width(14)
        .height(14)
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
  }

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Main content
      Column({ space: AppTokens.Spacing.lg }) {
        Text('Retro Group Buy')
          .fontSize(AppTokens.Typography.display.fontSize)
          .fontWeight(AppTokens.Typography.display.fontWeight)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        // Live Deals Map Card
        Column({ space: AppTokens.Spacing.md }) {
          Text('Live Deals Map')
            .fontSize(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)

          // Map canvas area
          Stack() {
            Rect()
              .fill(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .width('100%')
              .height(220)

            // Draw pins
            ForEach(this.pins, (pin: Pin) => {
              Circle()
                .fill(AppTokens.Colors.primary)
                .width(28)
                .height(28)
                .position({ x: pin.x, y: pin.y })
            })
          }
          .width('100%')
          .height(220)
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.Elevation.level2.radius,
          color: 'rgba(62, 39, 35, 0.15)',
          offsetY: AppTokens.Elevation.level2.offsetY
        })

        Blank()
          .height(AppTokens.Spacing.sm)

        // Buttons Row
        Row({ space: AppTokens.Spacing.md }) {
          Button('Add Group')
            .fontSize(AppTokens.Typography.label.fontSize)
            .fontWeight(AppTokens.Typography.label.fontWeight)
            .fontColor(AppTokens.Colors.onSecondary)
            .layoutWeight(1)
            .height(48)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              const randomX = Math.floor(Math.random() * 450) + 100;
              const randomY = Math.floor(Math.random() * 300) + 150;
              this.pins.push(new Pin(randomX, randomY, 'New'));
            })

          Button('Clear')
            .fontSize(AppTokens.Typography.label.fontSize)
            .fontWeight(AppTokens.Typography.label.fontWeight)
            .fontColor(AppTokens.Colors.onPrimary)
            .layoutWeight(1)
            .height(48)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.pins = [];
            })
        }
        .width('100%')

        // Active Groups Card
        Column({ space: AppTokens.Spacing.sm }) {
          Text('Active Groups')
            .fontSize(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
            .fontColor(AppTokens.Colors.primary)
            .width('100%')
            .textAlign(TextAlign.Start)

          ForEach(this.pins, (pin: Pin) => {
            this.PinItem(pin)
          })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.Elevation.level1.radius,
          color: 'rgba(62, 39, 35, 0.1)',
          offsetY: AppTokens.Elevation.level1.offsetY
        })

        Blank()
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
  }
}