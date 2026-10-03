import { RenderingContext, DrawTask } from '@kit.ArkGraphics';

export interface ColorToken {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  onPrimary: string;
  onSecondary: string;
  onBackground: string;
  onSurface: string;
}

export interface TypographyToken {
  size: number;
  weight: FontWeight;
}

export interface TypographyTokens {
  display: TypographyToken;
  headline: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
}

export interface ShapeToken {
  smallCornerRadius: number;
  mediumCornerRadius: number;
  largeCornerRadius: number;
}

export interface SpacingToken {
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

export class AppTokens {
  static readonly Colors: ColorToken = {
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

  static readonly TypographyTokens: TypographyTokens = {
    display: { size: 26, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Medium },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Regular }
  }

  static readonly Shapes: ShapeToken = {
    smallCornerRadius: 6,
    mediumCornerRadius: 10,
    largeCornerRadius: 16
  }

  static readonly Spacing: SpacingToken = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 22
  }
}

export interface Point {
  x: number;
  y: number;
}

@Component
export struct ParcelCanvas {
  @State dragOffset: Point = { x: 0, y: 0 };
  @State parcelPoints: Array<Point> = [];
  private canvasWidth: number = 0;
  private canvasHeight: number = 300;
  private renderContext: RenderingContext = new RenderingContext(false);
  private drawTask: DrawTask = new DrawTask((context: CanvasRenderingContext2D, size: Size) => {
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

  aboutToAppear() {
    this.generateRandomPoints();
    this.dragOffset = {
      x: Math.random() * (this.canvasWidth - 40) + 20,
      y: Math.random() * (this.canvasHeight - 40) + 20
    };
  }

  private generateRandomPoints(): void {
    const points: Array<Point> = [];
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
          .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(this.canvasHeight)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.largeCornerRadius)
      .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.largeCornerRadius })
      .gesture(
        PanGesture()
          .onActionUpdate((event: GestureEvent) => {
            const newX = Math.max(20, Math.min(event.offsetX + AppTokens.Spacing.md, this.canvasWidth - 20));
            const newY = Math.max(20, Math.min(event.offsetY + AppTokens.Spacing.md, this.canvasHeight - 20));
            this.dragOffset = { x: newX, y: newY };
          })
      )
    }
    .width('100%')
  }
}

@Component
export struct RootScreen {
  build() {
    Column() {
      Text("Parcel Tracker")
        .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
        .fontColor(AppTokens.Colors.onBackground)
        .textAlign(TextAlign.Center)
        .width('100%')
      
      ParcelCanvas()
      
      Text("Visualize parcel movements and positions.")
        .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
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
  }
}

@Entry
@Component
struct EntryComponent {
  build() {
    Column() {
      RootScreen()
    }
  }
}