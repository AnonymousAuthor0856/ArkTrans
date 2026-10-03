// RetroWhiteboard.ets
import { drawing } from '@kit.ArkGraphics2D';

// Color constants matching the SwiftUI hex values
const Colors = {
  primary: '#EF476F',
  secondary: '#FFD166',
  tertiary: '#06D6A0',
  background: '#FFFCF2',
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
};

// Typography constants
const Typography = {
  displaySize: 26,
  titleSize: 18,
  bodySize: 14,
  labelSize: 12
};

// Shape constants
const Shapes = {
  smallCornerRadius: 6,
  mediumCornerRadius: 10,
  largeCornerRadius: 16
};

// Spacing constants
const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24
};

// Elevation constants
const Elevation = {
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
};

// Point interface for drawing
interface Point {
  x: number;
  y: number;
}

@Entry
@Component
struct RetroWhiteboard {
  @State private points: Point[] = [];
  @State private currentColor: string = Colors.primary;
  
  // Control dimensions
  private buttonHeight: number = 44;
  private fabSize: number = 56;
  private circleRadius: number = 10;
  
  // Top bar actual height
  private topBarActualHeight: number = 30 + (2 * Spacing.md); // 54
  
  // Bottom bar actual height
  private bottomBarActualHeight: number = this.buttonHeight + (2 * Spacing.md); // 68
  
  // FAB bottom margin
  private fabBottomMargin: number = Spacing.xl; // 24
  
  // Canvas bottom padding
  private canvasBottomPadding: number = Math.max(this.bottomBarActualHeight, this.fabSize + this.fabBottomMargin); // 80

  build() {
    Stack() {
      // 1. Background color
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(Colors.background)

      // 2. Drawing canvas area
      Canvas(this.drawCanvas)
        .width('100%')
        .height('100%')
        .padding({ top: this.topBarActualHeight, bottom: this.canvasBottomPadding })
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Down || event.type === TouchType.Move) {
            const touchInfo = event.touches[0];
            const x = touchInfo.x;
            const y = touchInfo.y;
            this.points.push({ x: x, y: y });
          }
        })

      // 3. Top bar
      Column() {
        Text('Retro Whiteboard')
          .fontSize(Typography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
          .padding({ top: Spacing.md, bottom: Spacing.md })
          .width('100%')
          .textAlign(TextAlign.Center)
          .backgroundColor(Colors.background)
      }
      .width('100%')
      .align(Alignment.Top)

      // 4. Bottom color selection bar
      Column() {
        Blank()
        Row() {
          Blank()
          
          // Red button
          Button('Red')
            .fontSize(Typography.bodySize)
            .fontColor(Colors.onPrimary)
            .layoutWeight(1)
            .height(this.buttonHeight)
            .backgroundColor(Colors.primary)
            .borderRadius(Shapes.smallCornerRadius)
            .onClick(() => {
              this.currentColor = Colors.primary;
            })
          
          Blank()
          
          // Yellow button
          Button('Yellow')
            .fontSize(Typography.bodySize)
            .fontColor(Colors.onSecondary)
            .layoutWeight(1)
            .height(this.buttonHeight)
            .backgroundColor(Colors.secondary)
            .borderRadius(Shapes.smallCornerRadius)
            .onClick(() => {
              this.currentColor = Colors.secondary;
            })
          
          Blank()
          
          // Green button
          Button('Green')
            .fontSize(Typography.bodySize)
            .fontColor(Colors.onTertiary)
            .layoutWeight(1)
            .height(this.buttonHeight)
            .backgroundColor(Colors.tertiary)
            .borderRadius(Shapes.smallCornerRadius)
            .onClick(() => {
              this.currentColor = Colors.tertiary;
            })
          
          Blank()
        }
        .width('100%')
        .padding(Spacing.md)
        .backgroundColor(Colors.surface)
        .shadow({
          radius: Elevation.level1.elevation,
          color: `rgba(0, 0, 0, ${Elevation.level1.opacity})`,
          offsetY: Elevation.level1.dy
        })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)

      // 5. Floating Action Button - Clear canvas
      Column() {
        Blank()
        Row() {
          Blank()
          Button('Clear')
            .fontSize(Typography.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSecondary)
            .width(this.fabSize)
            .height(this.fabSize)
            .backgroundColor(Colors.secondary)
            .borderRadius(this.fabSize / 2)
            .shadow({
              radius: Elevation.level1.elevation,
              color: `rgba(0, 0, 0, ${Elevation.level1.opacity})`,
              offsetY: Elevation.level1.dy
            })
            .margin({ right: Spacing.xl, bottom: this.fabBottomMargin })
            .onClick(() => {
              this.points = [];
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.End)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height('100%')
  }

  // Canvas drawing function
  private drawCanvas = (context: drawing.CanvasRenderingContext2D) => {
    context.clearRect(0, 0, context.width, context.height);
    
    for (const point of this.points) {
      context.beginPath();
      context.arc(point.x, point.y, this.circleRadius, 0, 2 * Math.PI);
      context.fillStyle = this.currentColor;
      context.fill();
    }
  }
}