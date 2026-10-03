import { BusinessError } from '@kit.BasicServicesKit';
import { randomInt } from '@kit.ArkTS';

// --- Design Tokens & Constants ---

const AppTokens = {
  Colors: {
    primary: '#06B6D4',      // Cyan
    secondary: '#3B82F6',    // Blue
    tertiary: '#8B5CF6',     // Purple
    background: '#F0F9FF',   // Lightest Blue
    surface: '#FFFFFF',      // White
    surfaceVariant: '#E0F2FE', // Light Blue tint
    outline: '#BAE6FD',      // Pale Blue
    success: '#22C55E',
    warning: '#FACC15',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#0F172A', // Dark Slate
    onSurface: '#0F172A'
  },
  Spacing: {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  },
  Radius: {
    small: 6,
    medium: 12,
    large: 20
  }
};

interface Marker {
  x: number;
  y: number;
  label: string;
}

@Entry
@Component
struct InvoiceScanner {
  @State markers: Marker[] = [
    { x: 120, y: 200, label: 'A1' },
    { x: 300, y: 400, label: 'B2' },
    { x: 520, y: 600, label: 'C3' }
  ];
  @State isScanning: boolean = false;

  build() {
    Column() {
      // Header / Title Area
      Row() {
        Text('Invoice Scanner')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)

      // Main Content Area
      Column() {
        // Canvas Card
        Column() {
          Canvas(this)
            .width('100%')
            .height(400)
        }
        .width('100%')
        .borderRadius(AppTokens.Radius.large)
        .backgroundColor(Color.White)
        .shadow({ radius: 12, color: '#00000020', offsetY: 4 })
        .margin({ top: 16, bottom: 16 })

        // Controls Row
        Row() {
          Text('Scanning Active')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          
          Blank()

          Toggle({ type: ToggleType.Switch, isOn: this.isScanning })
            .onChange((isOn: boolean) => {
              this.isScanning = isOn;
            })
            .selectedColor(AppTokens.Colors.secondary)
            .width(50)
            .height(30)
        }
        .width('100%')
        .margin({ top: 16, bottom: 16 })

        // Action Button
        Button('Add Marker')
          .width('100%')
          .height(48)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .borderRadius(AppTokens.Radius.medium)
          .onClick(() => {
            if (this.isScanning) {
              const newMarker: Marker = {
                x: randomInt(80, 580),
                y: randomInt(150, 650),
                label: `N${this.markers.length + 1}`
              };
              this.markers.push(newMarker);
            }
          })
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 90,
      colors: [
        ['rgba(59, 130, 246, 0.3)', 0],
        ['#F0F9FF', 0.5],
        ['rgba(6, 182, 212, 0.3)', 1]
      ]
    })
  }

  draw(ctx: CanvasRenderingContext2D, canvasSize: Size) {
    const width = canvasSize.width;
    const height = canvasSize.height;
    
    // Draw Center Circle (Visual Element)
    ctx.beginPath();
    ctx.arc(width / 2, height / 2, Math.min(width, height) / 2.5, 0, 2 * Math.PI);
    ctx.fillStyle = AppTokens.Colors.surfaceVariant;
    ctx.fill();

    // Draw Markers
    this.markers.forEach(marker => {
      ctx.beginPath();
      ctx.arc(marker.x, marker.y, 12, 0, 2 * Math.PI);
      ctx.fillStyle = AppTokens.Colors.primary;
      ctx.fill();
    });
  }
}