// Data Model
interface Pin {
  id: string;
  x: number;
  y: number;
  label: string;
}

// Utility for generating unique IDs
function generateId(): string {
  return Math.random().toString(36).substring(2, 10) + Date.now().toString(36);
}

// AppTokens
interface TypographyToken {
  fontSize: number;
  fontWeight: FontWeight;
}

interface ElevationToken {
  radius: number;
  dy: number;
  opacity: number;
}

interface ShadowOptions {
  radius: number;
  color: string;
  offsetX?: number;
  offsetY: number;
}

class AppTokens {
  static readonly Colors: Record<string, string> = {
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
  }

  static readonly Typography: Record<string, TypographyToken> = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  }

  static readonly Shapes: Record<string, number> = {
    small: 6,
    medium: 10,
    large: 16
  }

  static readonly Spacing: Record<string, number> = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24
  }

  static readonly Elevation: Record<string, ElevationToken> = {
    level1: { radius: 2, dy: 2, opacity: 0.1 },
    level2: { radius: 6, dy: 4, opacity: 0.15 },
    level3: { radius: 10, dy: 6, opacity: 0.18 }
  }
}

// RootScreen.ets
@Entry
@Component
struct RootScreen {
  @State pins: Pin[] = [
    { id: generateId(), x: 150, y: 250, label: 'Group A' },
    { id: generateId(), x: 350, y: 420, label: 'Group B' },
    { id: generateId(), x: 520, y: 310, label: 'Group C' }
  ];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Main Content
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

          // Map Canvas Area
          Stack() {
            // Draw Pins
            ForEach(this.pins, (pin: Pin) => {
              Circle({ width: 28, height: 28 })
                .fill(AppTokens.Colors.primary)
                .position({ x: pin.x - 14, y: pin.y - 14 })
            }, (pin: Pin) => pin.id)
          }
          .width('100%')
          .height(220)
          .padding(8)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.Elevation.level2.radius,
          color: `rgba(62, 39, 35, ${AppTokens.Elevation.level2.opacity})`,
          offsetY: AppTokens.Elevation.level2.dy
        } as ShadowOptions)

        Blank().height(AppTokens.Spacing.sm)

        // Buttons Row
        Row({ space: AppTokens.Spacing.md }) {
          Button('Add Group', { type: ButtonType.Normal })
            .fontSize(AppTokens.Typography.label.fontSize)
            .fontWeight(AppTokens.Typography.label.fontWeight)
            .fontColor(AppTokens.Colors.onSecondary)
            .layoutWeight(1)
            .height(48)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              const randomX = Math.floor(Math.random() * (550 - 100 + 1)) + 100;
              const randomY = Math.floor(Math.random() * (450 - 150 + 1)) + 150;
              this.pins.push({ id: generateId(), x: randomX, y: randomY, label: 'New' });
            })

          Button('Clear', { type: ButtonType.Normal })
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

          ForEach(this.pins, (pin: Pin) => {
            Row() {
              Text(pin.label)
                .fontSize(AppTokens.Typography.body.fontSize)
                .fontWeight(AppTokens.Typography.body.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)
              
              Blank() // Pushes circle to the right

              Circle({ width: 14, height: 14 })
                .fill(AppTokens.Colors.primary)
            }
            .width('100%')
          }, (pin: Pin) => pin.id)
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.Elevation.level1.radius,
          color: `rgba(62, 39, 35, ${AppTokens.Elevation.level1.opacity})`,
          offsetY: AppTokens.Elevation.level1.dy
        } as ShadowOptions)

        Blank() // Fills remaining space
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
  }
}