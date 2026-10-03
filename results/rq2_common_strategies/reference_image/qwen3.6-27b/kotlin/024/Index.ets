// App.ets
import { UIAbility } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct RetroWhiteboard {
  @State points: Point[] = [];
  @State currentColor: Color = '#EF476F'; // Primary color (Red)
  
  private canvasContext?: CanvasRenderingContext2D;
  private isDrawing: boolean = false;
  
  // Color constants matching the original design
  private readonly COLORS = {
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
        Canvas(this)
          .width('100%')
          .height('100%')
          .backgroundColor(Color.Transparent)
          .onReady((context: CanvasRenderingContext2D) => {
            this.canvasContext = context;
            this.drawPoints();
          })
          .gesture(
            PanGesture()
              .onActionStart(() => {
                this.isDrawing = true;
              })
              .onActionUpdate((event: GestureEvent) => {
                if (this.isDrawing && event.offsetX !== 0 && event.offsetY !== 0) {
                  const point = new Point(event.offsetX + event.x, event.offsetY + event.y);
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
          .backgroundColor(Color.parseColor('#FFD166'))
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
          .backgroundColor(Color.parseColor('#EF476F'))
          .fontColor('#FFFFFF')
          .borderRadius(8)
          .width('30%')
          .height(50)
          .onClick(() => {
            this.currentColor = this.COLORS.primary;
          })
        
        Button('Yellow')
          .backgroundColor(Color.parseColor('#FFD166'))
          .fontColor('#1E1E1E')
          .borderRadius(8)
          .width('30%')
          .height(50)
          .margin({ left: 10, right: 10 })
          .onClick(() => {
            this.currentColor = this.COLORS.secondary;
          })
        
        Button('Green')
          .backgroundColor(Color.parseColor('#06D6A0'))
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