import { Font, FontWeight } from '@kit.ArkUI';
import { drawing } from '@kit.ArkGraphics';

// MARK: - AppTokens
// Corresponds to the Kotlin/SwiftUI AppTokens object, defining colors, fonts, spacing, shapes, and shadows.
interface ColorToken {
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
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyToken {
  size: number;
  weight: FontWeight;
  family: string;
}

interface ShapeToken {
  smallCornerRadius: number;
  mediumCornerRadius: number;
  largeCornerRadius: number;
}

interface SpacingToken {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

interface ElevationToken {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

const AppTokens = {
  Colors: {
    primary: '#EF476F',
    secondary: '#FFD166',
    tertiary: '#06D6A0',
    background: '#FFF8E7', // Adjusted slightly for better contrast with white surface if needed, or keep #FFF8E7
    surface: '#FFFFFF',
    surfaceVariant: '#F7EDE2',
    outline: '#E5D4B1',
    success: '#06D6A0',
    warning: '#FFA600',
    error: '#D62828',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  } as ColorToken,

  TypographyTokens: {
    display: { size: 26, weight: FontWeight.Bold, family: 'system' },
    title: { size: 18, weight: FontWeight.Medium, family: 'system' },
    body: { size: 14, weight: FontWeight.Normal, family: 'system' },
    label: { size: 12, weight: FontWeight.Medium, family: 'system' }
  } as Record<string, TypographyToken>,

  Shapes: {
    smallCornerRadius: 6,
    mediumCornerRadius: 10,
    largeCornerRadius: 16
  } as ShapeToken,

  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  } as SpacingToken,

  ElevationMapping: {
    level1: {
      elevation: 2,
      radius: 4,
      dy: 2,
      opacity: 0.12
    },
    level2: {
      elevation: 4,
      radius: 8,
      dy: 4,
      opacity: 0.16
    }
  } as Record<string, ElevationToken>
};

@Entry
@Component
struct RootScreen {
  @State points: Point[] = [];
  @State currentColor: string = AppTokens.Colors.primary;

  // Define control dimensions
  private readonly buttonHeight: number = 44;
  private readonly fabSize: number = 56;
  private readonly circleRadius: number = 10;

  // Calculate actual heights for padding calculations
  get topBarActualHeight(): number {
    return 30 + (2 * AppTokens.Spacing.md); // ~54
  }

  get bottomBarActualHeight(): number {
    return this.buttonHeight + (2 * AppTokens.Spacing.md); // 44 + 24 = 68
  }

  get fabBottomMargin(): number {
    return AppTokens.Spacing.xl; // 24
  }

  get canvasBottomPadding(): number {
    const fabBottomEdge = this.fabSize + this.fabBottomMargin; // 56 + 24 = 80
    return Math.max(this.bottomBarActualHeight, fabBottomEdge); // max(68, 80) = 80
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.TopStart }) {
        // 1. Background Color
        Row()
          .width('100%')
          .height('100%')
          .backgroundColor(AppTokens.Colors.background)

        // 2. Drawing Canvas Area
        DrawCanvas({
          points: $points,
          currentColor: $currentColor,
          circleRadius: this.circleRadius,
          topPadding: this.topBarActualHeight,
          bottomPadding: this.canvasBottomPadding
        })
          .width('100%')
          .height('100%')

        // 3. Top Bar
        Column() {
          Text("Retro Whiteboard")
            .font({
              size: AppTokens.TypographyTokens.display.size,
              weight: AppTokens.TypographyTokens.display.weight,
              family: AppTokens.TypographyTokens.display.family
            })
            .fontColor(AppTokens.Colors.onSurface)
            .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
            .textAlign(TextAlign.Center)
            .width('100%')
        }
        .width('100%')
        .backgroundColor(AppTokens.Colors.background)
        .position({ x: 0, y: 0 })

        // 4. Bottom Color Selection Bar
        Column() {
          Row() {
            Button() {
              Text("Red")
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontWeight(AppTokens.TypographyTokens.body.weight)
            }
              .type(ButtonType.Normal)
              .backgroundColor(AppTokens.Colors.primary)
              .fontColor(AppTokens.Colors.onPrimary)
              .height(this.buttonHeight)
              .borderRadius(AppTokens.Shapes.smallCornerRadius)
              .layoutWeight(1)
              .margin({ right: AppTokens.Spacing.md })
              .onClick(() => {
                this.currentColor = AppTokens.Colors.primary;
              })

            Button() {
              Text("Yellow")
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontWeight(AppTokens.TypographyTokens.body.weight)
            }
              .type(ButtonType.Normal)
              .backgroundColor(AppTokens.Colors.secondary)
              .fontColor(AppTokens.Colors.onSecondary)
              .height(this.buttonHeight)
              .borderRadius(AppTokens.Shapes.smallCornerRadius)
              .layoutWeight(1)
              .margin({ right: AppTokens.Spacing.md })
              .onClick(() => {
                this.currentColor = AppTokens.Colors.secondary;
              })

            Button() {
              Text("Green")
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontWeight(AppTokens.TypographyTokens.body.weight)
            }
              .type(ButtonType.Normal)
              .backgroundColor(AppTokens.Colors.tertiary)
              .fontColor(AppTokens.Colors.onTertiary)
              .height(this.buttonHeight)
              .borderRadius(AppTokens.Shapes.smallCornerRadius)
              .layoutWeight(1)
          }
          .width('100%')
          .padding(AppTokens.Spacing.md)
          .backgroundColor(AppTokens.Colors.surface)
          .shadow({
            radius: AppTokens.ElevationMapping.level1.radius,
            color: '#000000'.opacity(AppTokens.ElevationMapping.level1.opacity),
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level1.dy
          })
        }
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.End)
        .width('100%')
        .height('100%')

        // 5. Floating Action Button (Clear)
        Column() {
          Row() {
            Button() {
              Text("Clear")
                .fontSize(AppTokens.TypographyTokens.label.size)
                .fontWeight(AppTokens.TypographyTokens.label.weight)
            }
              .type(ButtonType.Normal)
              .backgroundColor(AppTokens.Colors.secondary)
              .fontColor(AppTokens.Colors.onSecondary)
              .width(this.fabSize)
              .height(this.fabSize)
              .borderRadius(this.fabSize / 2)
              .shadow({
                radius: AppTokens.ElevationMapping.level1.radius,
                color: '#000000'.opacity(AppTokens.ElevationMapping.level1.opacity),
                offsetX: 0,
                offsetY: AppTokens.ElevationMapping.level1.dy
              })
              .margin({ right: AppTokens.Spacing.xl, bottom: this.fabBottomMargin })
              .onClick(() => {
                this.points = [];
              })
          }
          .justifyContent(FlexAlign.End)
          .width('100%')
        }
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.End)
        .width('100%')
        .height('100%')

      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

interface Point {
  x: number;
  y: number;
}

@Component
struct DrawCanvas {
  @Link points: Point[];
  @Link currentColor: string;
  readonly circleRadius: number;
  readonly topPadding: number;
  readonly bottomPadding: number;

  private context: drawing.DrawingRenderingContext | null = null;

  build() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .onReady((context: drawing.DrawingRenderingContext) => {
        this.context = context;
        this.drawPoints();
      })
      .gesture(
        PanGesture()
          .onActionUpdate((event?: GestureEvent) => {
            if (event) {
              const location = event.offsetX;
              const locationY = event.offsetY;
              // Add point relative to canvas coordinates
              this.points.push({ x: location, y: locationY });
              this.drawPoints();
            }
          })
      )
      .padding({ top: this.topPadding, bottom: this.bottomPadding })
  }

  aboutToAppear() {
    // Context will be set in onReady
  }

  drawPoints() {
    if (!this.context) return;

    const ctx = this.context;
    
    // Get canvas dimensions
    const width = ctx.width;
    const height = ctx.height;
    
    // Clear entire canvas
    ctx.clearRect(new drawing.Rect(0, 0, width, height));

    // Draw all points
    for (const point of this.points) {
      ctx.beginPath();
      ctx.arc(point.x, point.y, this.circleRadius, 0, 2 * Math.PI);
      ctx.fillStyle = new drawing.Color(this.currentColor); 
      ctx.fill();
    }
  }
}