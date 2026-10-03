// App.ets
import { drawing } from '@kit.ArkGraphics';

@Entry
@Component
struct RetroWhiteboard {
  @State points: Point[] = [];
  @State currentColor: string = '#EF476F'; // Primary color (Red)
  
  private canvasContext?: drawing.DrawingRenderingContext;
  private isDrawing: boolean = false;
  private lastX: number = 0;
  private lastY: number = 0;
  
  // Color constants matching the original design
  private readonly COLORS: Record<string, string> = {
    primary: '#EF476F',
    secondary: '#FFD166', 
    tertiary: '#06D6A0',
    background: '#FFF8E7',
    surface: '#FFFFFF'
  };
  
  build() {
    Column() {
      // Header
      Text('Retro Whiteboard')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 10 })
        .textAlign(TextAlign.Center)
      
      // Drawing canvas area
      Stack() {
        Canvas()
          .width('100%')
          .height('100%')
          .backgroundColor(Color.Transparent)
          .onReady((context: drawing.DrawingRenderingContext) => {
            this.canvasContext = context;
            this.drawPoints();
          })
          .gesture(
            PanGesture()
              .onActionStart((event: GestureEvent) => {
                this.isDrawing = true;
                this.lastX = event.localX;
                this.lastY = event.localY;
              })
              .onActionUpdate((event: GestureEvent) => {
                if (this.isDrawing) {
                  const point = new Point(event.localX, event.localY);
                  this.points.push(point);
                  this.drawPoints();
                }
              })
              .onActionEnd(() => {
                this.isDrawing = false;
              })
          )
        
        // Clear button (floating action button)
        Button('Clear')
          .type(ButtonType.Circle)
          .backgroundColor('#FFD166')
          .fontColor('#1E1E1E')
          .position({ right: 20, bottom: 120 })
          .onClick(() => {
            this.points = [];
            this.clearCanvas();
          })
      }
      .layoutWeight(1)
      .backgroundColor(this.COLORS.background)
      
      // Bottom toolbar with color buttons
      Row() {
        Button('Red')
          .backgroundColor('#EF476F')
          .fontColor('#FFFFFF')
          .borderRadius(8)
          .width('30%')
          .height(50)
          .onClick(() => {
            this.currentColor = this.COLORS.primary;
          })
        
        Button('Yellow')
          .backgroundColor('#FFD166')
          .fontColor('#1E1E1E')
          .borderRadius(8)
          .width('30%')
          .height(50)
          .margin({ left: 10, right: 10 })
          .onClick(() => {
            this.currentColor = this.COLORS.secondary;
          })
        
        Button('Green')
          .backgroundColor('#06D6A0')
          .fontColor('#1E1E1E')
          .borderRadius(8)
          .width('30%')
          .height(50)
          .onClick(() => {
            this.currentColor = this.COLORS.tertiary;
          })
      }
      .width('100%')
      .padding(20)
      .justifyContent(FlexAlign.SpaceEvenly)
      .backgroundColor('#FFF8E7')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.COLORS.background)
  }
  
  private drawPoints(): void {
    if (!this.canvasContext) return;
    
    const ctx = this.canvasContext;
    ctx.clearRect(0, 0, ctx.width, ctx.height);
    
    for (const point of this.points) {
      ctx.beginPath();
      ctx.arc(point.x, point.y, 10, 0, Math.PI * 2);
      ctx.fillStyle = this.currentColor;
      ctx.fill();
    }
  }
  
  private clearCanvas(): void {
    if (this.canvasContext) {
      this.canvasContext.clearRect(0, 0, this.canvasContext.width, this.canvasContext.height);
    }
  }
}

class Point {
  x: number;
  y: number;
  
  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}