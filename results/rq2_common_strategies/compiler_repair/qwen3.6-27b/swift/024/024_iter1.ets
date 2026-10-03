import { Color, Font, FontWeight } from '@kit.ArkUI';

// MARK: - AppTokens
// Corresponds to the Kotlin/SwiftUI AppTokens object, defining colors, fonts, spacing, shapes, and shadows.
const AppTokens = {
  Colors: {
    primary: new Color('#EF476F'),
    secondary: new Color('#FFD166'),
    tertiary: new Color('#06D6A0'),
    background: new Color('#FFF8E7'), // Adjusted slightly for better contrast with white surface if needed, or keep #FFF8E7
    surface: new Color('#FFFFFF'),
    surfaceVariant: new Color('#F7EDE2'),
    outline: new Color('#E5D4B1'),
    success: new Color('#06D6A0'),
    warning: new Color('#FFA600'),
    error: new Color('#D62828'),
    onPrimary: new Color('#FFFFFF'),
    onSecondary: new Color('#1E1E1E'),
    onTertiary: new Color('#1E1E1E'),
    onBackground: new Color('#1E1E1E'),
    onSurface: new Color('#1E1E1E')
  },

  TypographyTokens: {
    display: { size: 26, weight: FontWeight.Bold, family: 'system' },
    title: { size: 18, weight: FontWeight.Medium, family: 'system' },
    body: { size: 14, weight: FontWeight.Normal, family: 'system' },
    label: { size: 12, weight: FontWeight.Medium, family: 'system' }
  },

  Shapes: {
    smallCornerRadius: 6,
    mediumCornerRadius: 10,
    largeCornerRadius: 16
  },

  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  },

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
  }
};

@Entry
@Component
struct RootScreen {
  @State points: Point[] = [];
  @State currentColor: Color = AppTokens.Colors.primary;

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
          points: this.points,
          currentColor: this.currentColor,
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
              weight: AppTokens.TypographyTokens.display.weight as FontWeight,
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
                .fontWeight(AppTokens.TypographyTokens.body.weight as FontWeight)
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
                .fontWeight(AppTokens.TypographyTokens.body.weight as FontWeight)
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
                .fontWeight(AppTokens.TypographyTokens.body.weight as FontWeight)
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
            color: Color.Black.opacity(AppTokens.ElevationMapping.level1.opacity),
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
                .fontWeight(AppTokens.TypographyTokens.label.weight as FontWeight)
            }
              .type(ButtonType.Normal)
              .backgroundColor(AppTokens.Colors.secondary)
              .fontColor(AppTokens.Colors.onSecondary)
              .width(this.fabSize)
              .height(this.fabSize)
              .borderRadius(this.fabSize / 2)
              .shadow({
                radius: AppTokens.ElevationMapping.level1.radius,
                color: Color.Black.opacity(AppTokens.ElevationMapping.level1.opacity),
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
  @Link currentColor: Color;
  readonly circleRadius: number;
  readonly topPadding: number;
  readonly bottomPadding: number;

  build() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .onReady(() => {
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

  private context: CanvasRenderingContext2D | null = null;

  aboutToAppear() {
    // Context will be set in onReady
  }

  drawPoints() {
    if (!this.context) return;

    const ctx = this.context;
    // Clear previous drawings? No, we redraw all points every time for simplicity in this model
    // Or we could just draw the new one. The SwiftUI version draws all points in a loop.
    // To mimic SwiftUI's Canvas behavior exactly, we should clear and redraw all.
    
    // Get canvas dimensions
    const width = ctx.canvas.width;
    const height = ctx.canvas.height;
    
    // Clear entire canvas
    ctx.clearRect(0, 0, width, height);

    // Draw all points
    for (const point of this.points) {
      ctx.beginPath();
      ctx.arc(point.x, point.y, this.circleRadius, 0, 2 * Math.PI);
      ctx.fillStyle = this.currentColor.toString(); // Convert ArkTS Color to string hex/rgb
      ctx.fill();
    }
  }
}