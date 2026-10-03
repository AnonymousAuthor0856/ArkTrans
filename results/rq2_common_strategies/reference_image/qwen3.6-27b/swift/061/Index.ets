// AppTokens.ets
export class AppTokens {
  static readonly Colors = {
    primary: '#111827',
    secondary: '#374151',
    tertiary: '#6B7280',
    background: '#F9FAFB',
    surface: '#FFFFFF',
    surfaceVariant: '#E5E7EB',
    outline: '#D1D5DB',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onBackground: '#111827',
    onSurface: '#1F2937'
  }

  static readonly TypographyTokens = {
    display: { size: 26, weight: 700 }, // bold
    headline: { size: 18, weight: 600 }, // semibold
    title: { size: 14, weight: 500 }, // medium
    body: { size: 12, weight: 400 } // regular
  }

  static readonly Shapes = {
    smallCornerRadius: 6,
    mediumCornerRadius: 10,
    largeCornerRadius: 16
  }

  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 22
  }
}

// ParcelCanvas.ets
import { AppTokens } from './AppTokens';

@Component
export struct ParcelCanvas {
  @State dragOffset: { x: number, y: number } = { x: 0, y: 0 };
  @State parcelPoints: Array<{ x: number, y: number }> = [];
  private canvasWidth: number = 0;
  private canvasHeight: number = 300;

  aboutToAppear() {
    this.generateRandomPoints();
    this.dragOffset = {
      x: Math.random() * (this.canvasWidth - 40) + 20,
      y: Math.random() * (this.canvasHeight - 40) + 20
    };
  }

  private generateRandomPoints(): void {
    const points: Array<{ x: number, y: number }> = [];
    for (let i = 0; i < 25; i++) {
      points.push({
        x: Math.random() * this.canvasWidth,
        y: Math.random() * this.canvasHeight
      });
    }
    this.parcelPoints = points;
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Canvas(this.renderContext)
          .width('100%')
          .height('100%')
          .padding(AppTokens.Spacing.md)
        
        Text("Drag to locate parcel")
          .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight as FontWeight })
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(this.canvasHeight)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.largeCornerRadius)
      .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.largeCornerRadius })
      .gesture(
        PanGesture()
          .onAction((event: GestureEvent) => {
            if (event.state === GestureStatus.Update) {
              const newX = Math.max(20, Math.min(event.offsetX + event.startX, this.canvasWidth - 20));
              const newY = Math.max(20, Math.min(event.offsetY + event.startY, this.canvasHeight - 20));
              this.dragOffset = { x: newX, y: newY };
            }
          })
      )
    }
    .width('100%')
  }

  private renderContext = new RenderingContext(false);
  private drawTask = new DrawTask((context: CanvasRenderingContext2D, size: Size) => {
    this.canvasWidth = size.width;
    
    // Draw parcel points
    for (const point of this.parcelPoints) {
      context.beginPath();
      context.arc(point.x, point.y, 4, 0, 2 * Math.PI);
      context.fillStyle = AppTokens.Colors.secondary;
      context.fill();
    }

    // Draw draggable circle
    context.beginPath();
    context.arc(this.dragOffset.x, this.dragOffset.y, 20, 0, 2 * Math.PI);
    context.strokeStyle = AppTokens.Colors.primary;
    context.lineWidth = 3;
    context.stroke();
  });
}

// RootScreen.ets
import { AppTokens } from './AppTokens';
import { ParcelCanvas } from './ParcelCanvas';

@Component
export struct RootScreen {
  build() {
    Column() {
      Text("Parcel Tracker")
        .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight as FontWeight })
        .fontColor(AppTokens.Colors.onBackground)
        .textAlign(TextAlign.Center)
        .width('100%')
      
      ParcelCanvas()
      
      Text("Visualize parcel movements and positions.")
        .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight as FontWeight })
        .fontColor(AppTokens.Colors.onSurface)
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 'auto' })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 90,
      colors: [
        [AppTokens.Colors.surfaceVariant, 0],
        [AppTokens.Colors.background, 1]
      ]
    })
    .padding(AppTokens.Spacing.lg)
    .spacing(AppTokens.Spacing.xl)
  }
}

// entryability.ets
@Entry
@Component
struct EntryComponent {
  build() {
    RootScreen()
  }
}