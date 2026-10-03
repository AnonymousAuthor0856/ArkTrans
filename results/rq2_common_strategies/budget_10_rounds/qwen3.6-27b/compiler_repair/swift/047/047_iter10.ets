import { BusinessError } from '@kit.BasicServicesKit';
import { canvas, drawing } from '@kit.ArkGraphics2D';

// MARK: - AppTokens (Equivalent to Kotlin AppTokens object)

interface ColorMap {
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

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyMap {
  display: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface ShapeMap {
  small: number;
  medium: number;
  large: number;
}

interface SpacingMap {
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

interface ElevationSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface ElevationMap {
  level1: ElevationSpec;
  level2: ElevationSpec;
  level3: ElevationSpec;
}

class AppTokens {
  // MARK: Colors
  static readonly Colors: ColorMap = {
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

  // MARK: TypographyTokens
  static readonly TypographyTokens: TypographyMap = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  // MARK: Shapes
  static readonly Shapes: ShapeMap = {
    small: 6,
    medium: 10,
    large: 16
  };

  // MARK: Spacing
  static readonly Spacing: SpacingMap = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24
  };

  // MARK: ShadowSpec (for elevation mapping)
  static readonly ElevationMapping: ElevationMap = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.1 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.15 },
    level3: { elevation: 10, radius: 12, dy: 6, opacity: 0.18 }
  };
}

// MARK: - Pin Data Model (Equivalent to Kotlin data class Pin)
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

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background);

      Column() {
        Text('Retro Group Buy')
          .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
          .fontColor(AppTokens.Colors.onBackground)
          .alignSelf(ItemAlign.Start);

        // Card equivalent for "Live Deals Map"
        Column({ space: AppTokens.Spacing.md }) {
          Text('Live Deals Map')
            .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
            .fontColor(AppTokens.Colors.onSurface)
            .alignSelf(ItemAlign.Start);

          // Box equivalent for the map canvas
          Stack() {
            // Background for the map area
            Column()
              .width('100%')
              .height(220)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium);

            Canvas((context: canvas.CanvasRenderingContext2D | drawing.DrawingRenderingContext, event?: canvas.CanvasEvent) => {
              if (!event || !context) return;
              
              const width = event.width;
              const height = event.height;
              
              this.pins.forEach(pin => {
                context.beginPath();
                context.arc(pin.x, pin.y, 14, 0, 2 * Math.PI);
                context.fillStyle = AppTokens.Colors.primary;
                context.fill();
              });
            })
              .width('100%')
              .height(220)
              .padding({ left: 8, right: 8, top: 8, bottom: 8 });
          }
          .width('100%')
          .height(220)
          .clip(true);
        }
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: `${AppTokens.Colors.onSurface}${Math.round(AppTokens.ElevationMapping.level2.opacity * 255).toString(16).padStart(2, '0')}`,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        });

        Blank().height(AppTokens.Spacing.sm);

        // Row equivalent for buttons
        Row({ space: AppTokens.Spacing.md }) {
          Button('Add Group')
            .type(ButtonType.Capsule)
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              const randomX = Math.floor(Math.random() * (550 - 100)) + 100;
              const randomY = Math.floor(Math.random() * (450 - 150)) + 150;
              this.pins.push({
                id: Date.now().toString(),
                x: randomX,
                y: randomY,
                label: 'New'
              });
            });

          Button('Clear')
            .type(ButtonType.Capsule)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              this.pins = [];
            });
        }

        // Card equivalent for "Active Groups"
        Column({ space: AppTokens.Spacing.sm }) {
          Text('Active Groups')
            .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
            .fontColor(AppTokens.Colors.primary)
            .alignSelf(ItemAlign.Start);

          ForEach(this.pins, (pin: Pin) => {
            Row() {
              Text(pin.label)
                .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
                .fontColor(AppTokens.Colors.onSurface);
              
              Blank().layoutWeight(1);
              
              Circle()
                .width(14)
                .height(14)
                .fill(AppTokens.Colors.primary);
            }
          }, (pin: Pin) => pin.id);
        }
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level1.radius,
          color: `${AppTokens.Colors.onSurface}${Math.round(AppTokens.ElevationMapping.level1.opacity * 255).toString(16).padStart(2, '0')}`,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level1.dy
        });

        Blank().layoutWeight(1);
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%');
    }
    .width('100%')
    .height('100%')
  }
}