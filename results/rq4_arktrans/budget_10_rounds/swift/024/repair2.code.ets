import { canvas } from '@kit.ArkGraphics';

@Entry
@Component
struct Index {
  @State points: Point[] = []
  private drawingContext: DrawingContext = new DrawingContext()

  build() {
    Stack() {
      // === Canvas (Drawing Area) ===
      Canvas(this.drawingContext).width('100%').height('100%')

      // === Top Title Bar ===
      Column() {
        Text('Retro Whiteboard')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding({ top: 40, bottom: 8 })
      .backgroundColor('#FFFDF5')

      // === Bottom Toolbar ===
      Column() {
        Row() {
          Blank()
          
          Button() {
            Text('Red')
              .fontSize(14)
              .fontColor('#FFFFFF')
          }
          .backgroundColor('#EF476F')
          .borderRadius(8)
          .width('30%')
          .height(48)
          .onClick(() => { this.points = [] }) // Reset for demo purposes or color change logic

          Blank()

          Button() {
            Text('Yellow')
              .fontSize(14)
              .fontColor('#1E1E1E')
          }
          .backgroundColor('#FFD166')
          .borderRadius(8)
          .width('30%')
          .height(48)
          .onClick(() => { this.points = [] })

          Blank()

          Button() {
            Text('Green')
              .fontSize(14)
              .fontColor('#1E1E1E')
          }
          .backgroundColor('#06D6A0')
          .borderRadius(8)
          .width('30%')
          .height(48)
          .onClick(() => { this.points = [] })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
        
        // Spacer to push buttons up slightly if needed, though layout handles it
        Blank()
      }
      .width('100%')
      .alignItems(HorizontalAlign.End)
      .position({ x: 0, y: 0 })
      .margin({ bottom: 20 })
      
      // === Floating Action Button (Clear) ===
      Button() {
        Text('Clear')
          .fontSize(12)
          .fontColor('#1E1E1E')
      }
      .backgroundColor('#FFD166')
      .borderRadius(100)
      .width(80)
      .height(80)
      .shadow({ radius: 10, color: '#33000000', offsetX: 0, offsetY: 4 })
      .position({ x: 'auto', y: 'auto' })
      .margin({ right: 20, bottom: 90 })
      .onClick(() => {
        this.points = []
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFDF5')
  }
}

// Helper interface for canvas drawing
interface Point {
  x: number;
  y: number;
}

// Context wrapper for Canvas
class DrawingContext implements canvas.CanvasRenderingContext2D {
  private ctx: canvas.CanvasRenderingContext2D | null = null;

  onReady(context: canvas.CanvasRenderingContext2D, content: canvas.CanvasRenderingContext2D) {
    this.ctx = context;
    context.lineWidth = 5;
    context.lineCap = canvas.LineCap.Round;
    context.lineJoin = canvas.LineJoin.Round;
    context.strokeStyle = '#EF476F'; // Default Red
  }

  // Stub methods to satisfy interface implementation if strictly required by compiler in some versions, 
  // though usually just passing the instance is enough if not calling methods directly on class.
  // For simplicity in this fix, we rely on the fact that ArkTS Canvas accepts an object with onReady.
}

const ctx = new DrawingContext();