import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens
// Centralized management of application colors, fonts, shapes, and spacing.

interface ColorTokens {
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

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokens {
  display: TypographyToken;
  headline: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
}

interface ShapeTokens {
  smallCornerRadius: number;
  mediumCornerRadius: number;
  largeCornerRadius: number;
}

interface SpacingTokens {
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

const AppTokens = {
  Colors: {
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
  } as ColorTokens,
  TypographyTokens: {
    display: { size: 26, weight: 'bold' as FontWeight },
    headline: { size: 18, weight: 'semibold' as FontWeight },
    title: { size: 14, weight: 'medium' as FontWeight },
    body: { size: 12, weight: 'regular' as FontWeight }
  } as TypographyTokens,
  Shapes: {
    smallCornerRadius: 6,
    mediumCornerRadius: 10,
    largeCornerRadius: 16
  } as ShapeTokens,
  Spacing: {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 22
  } as SpacingTokens
};

type FontWeight = 'thin' | 'extra-light' | 'light' | 'normal' | 'regular' | 'medium' | 'semi-bold' | 'bold' | 'extra-bold' | 'black';

interface Point {
  x: number;
  y: number;
}

@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      Text('Parcel Tracker')
        .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
        .fontColor(AppTokens.Colors.onBackground)

      ParcelCanvas()

      Text('Visualize parcel movements and positions.')
        .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Transparent)
    .linearGradient({
      angle: 90,
      colors: [
        [AppTokens.Colors.surfaceVariant, 0],
        [AppTokens.Colors.background, 1]
      ]
    })
    .padding(AppTokens.Spacing.lg)
    .safeArea({ right: true, left: true, top: false, bottom: false })
  }
}

@Component
struct ParcelCanvas {
  @State dragOffset: Point = { x: 0, y: 0 };
  @State parcelPoints: Point[] = [];
  private canvasWidth: number = 0;
  private canvasHeight: number = 0;
  private ctx: CanvasRenderingContext2D | null = null;

  aboutToAppear() {
    // Initialize points when component appears
    this.initPoints();
  }

  private initPoints(): void {
    const count = 25;
    this.parcelPoints = [];
    for (let i = 0; i < count; i++) {
      this.parcelPoints.push({
        x: Math.random() * 300, // Placeholder width, will be updated in onAreaChange
        y: Math.random() * 300  // Placeholder height
      });
    }
    // Initial drag position
    this.dragOffset = {
      x: Math.random() * 260 + 20,
      y: Math.random() * 260 + 20
    };
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.getContext())
        .width('100%')
        .height('100%')
        .onReady(() => {
          // Get actual dimensions after layout
          this.updatePointsAndBounds();
        })
        .onAreaChange((oldValue: Area, newValue: Area) => {
          if (newValue.width > 0 && newValue.height > 0) {
            this.canvasWidth = Number(newValue.width);
            this.canvasHeight = Number(newValue.height);
            this.updatePointsAndBounds();
          }
        })

      Text('Drag to locate parcel')
        .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(300)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.largeCornerRadius)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.largeCornerRadius })
    .gesture(
      PanGesture()
        .onActionUpdate((event: GestureEvent) => {
          const effectiveWidth = this.canvasWidth - (AppTokens.Spacing.md * 2);
          const effectiveHeight = this.canvasHeight - (AppTokens.Spacing.md * 2);
          
          // Calculate offset relative to the padding area
          let newX = event.offsetX + AppTokens.Spacing.md;
          let newY = event.offsetY + AppTokens.Spacing.md;

          // Clamp values
          newX = Math.max(20, Math.min(newX, effectiveWidth - 20));
          newY = Math.max(20, Math.min(newY, effectiveHeight - 20));

          this.dragOffset = { x: newX, y: newY };
        })
    )
  }

  private getContext(): CanvasRenderingContext2D {
    return new CanvasRenderingContext2D();
  }

  private updatePointsAndBounds(): void {
    const effectiveWidth = this.canvasWidth - (AppTokens.Spacing.md * 2);
    const effectiveHeight = this.canvasHeight - (AppTokens.Spacing.md * 2);

    // Regenerate points within new bounds
    this.parcelPoints = [];
    for (let i = 0; i < 25; i++) {
      this.parcelPoints.push({
        x: Math.random() * effectiveWidth,
        y: Math.random() * effectiveHeight
      });
    }

    // Ensure drag offset is within bounds
    if (this.dragOffset.x < 20 || this.dragOffset.x > effectiveWidth - 20 ||
        this.dragOffset.y < 20 || this.dragOffset.y > effectiveHeight - 20) {
      this.dragOffset = {
        x: Math.random() * (effectiveWidth - 40) + 20,
        y: Math.random() * (effectiveHeight - 40) + 20
      };
    }
  }
}