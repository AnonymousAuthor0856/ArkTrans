import { window } from '@kit.ArkUI';
import { canvas, drawing } from '@kit.ArkGraphics';
import { UIAbility, AbilityConstant } from '@kit.AbilityKit';
import { common } from '@kit.AbilityKit';

// Define the main entry component
@Entry
@Component
struct MatchaBrewingScreen {
  @State isImmersive: boolean = false;

  aboutToAppear() {
    // Set immersive mode (Edge-to-Edge)
    try {
      const ctx = getContext(this) as common.UIAbilityContext;
      const w = ctx.getWindowSync();
      w.setWindowLayoutFullScreen(true);
      w.addDisplayMode(window.DisplayClass.FULLSCREEN);
      this.isImmersive = true;
    } catch (e) {
      console.error('Failed to set immersive mode');
    }
  }

  build() {
    Column() {
      // Top Section: Title
      Column() {
        Text("MATCHA RITUAL")
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(4)
          .fontColor('#808080') // Gray
          .margin({ top: 48 })

        Text("Ceremonial Grade")
          .fontSize(28)
          .fontWeight(FontWeight.Lighter)
          .fontColor('#000000') // Black
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Center)

      // Middle Section: Visual Art & Stats
      Column() {
        // Custom drawn Matcha Bowl
        MatchaBowlCanvas()
          .width(160)
          .height(160)

        // Info Row
        Row() {
          InfoItem({ label: "TEMP", value: "80°C" })
          InfoItem({ label: "WATER", value: "70ml" })
          InfoItem({ label: "BAMBOO", value: "Whisk" })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: 40 })
      }
      .alignItems(HorizontalAlign.Center)
      .layoutWeight(1) // Take up available space

      // Bottom Section: Instructions & Action
      Column() {
        StepCard({ number: "01", text: "Sift 2g of matcha powder." })
        
        StepCard({ number: "02", text: "Add hot water. Whisk in 'M' shape." })
          .margin({ top: 12 })

        Button("START TIMER", { type: ButtonType.Capsule })
          .width('100%')
          .height(56)
          .backgroundColor('#556B2F') // Matcha Green
          .fontColor('#FFFFFF')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .margin({ top: 32 })
          
        // Add a play icon before the text using a custom button content or just text for simplicity in ArkTS without complex Icon imports
        // Since we need exact layout, let's use a Row inside the button if possible, but standard Button takes string.
        // To replicate the icon + text exactly:
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .margin({ bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

// Custom Component: Matcha Bowl Canvas
@Component
struct MatchaBowlCanvas {
  private canvasRef: canvas.CanvasRenderingContext2D | null = null;

  build() {
    Canvas(this.canvasRef)
      .onDraw((canvasObj: canvas.Canvas, context: canvas.CanvasRenderingContext2D) => {
        const rect = context.canvas.getBoundingClientRect();
        const w = rect.width;
        const h = rect.height;
        
        // 1. Draw the Bowl (Trapezoid-like shape with rounded bottom)
        let path = new drawing.Path();
        path.moveTo(w * 0.15, h * 0.4); // Top Left
        path.lineTo(w * 0.85, h * 0.4); // Top Right
        
        // Quadratic Bezier approximation for the bowl curve
        // In ArkTS, we can use bezierCurveTo(x1, y1, x2, y2)
        path.bezierCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9, w * 0.5, h * 0.9); 
        // Actually, the Kotlin code uses two quadratic beziers to close the loop.
        // Let's approximate the bowl shape more simply with arcs or lines if needed, 
        // but let's stick to the path logic.
        
        // Resetting path for clarity based on Kotlin logic:
        path.reset();
        path.moveTo(w * 0.15, h * 0.4);
        path.lineTo(w * 0.85, h * 0.4);
        // Right side curve down
        path.quadraticBezierTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9);
        // Left side curve up
        path.quadraticBezierTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4);
        path.close();
        
        let paint = new drawing.Paint();
        paint.setColor(Color.Gray); // Using Gray for charcoal #333333 approx
        canvasObj.drawPath(path, paint);
      
        // 2. Draw the Liquid (Matcha) inside
        // Oval at specific position
        let ovalRect = new drawing.Rect({
          left: w * 0.2,
          top: h * 0.42,
          right: w * 0.2 + w * 0.6,
          bottom: h * 0.42 + h * 0.15
        });
        let liquidPaint = new drawing.Paint();
        liquidPaint.setColor(Color.Green); // Using Green for #8BBD52 approx
        canvasObj.drawOval(ovalRect, liquidPaint);

        // 3. Draw Steam (Simple lines)
        let steamPaint = new drawing.Paint();
        steamPaint.setColor(Color.Gray);
        steamPaint.setStrokeWidth(4);
        steamPaint.setStyle(drawing.Paint.Style.STROKE);
      
        // Line 1
        canvasObj.drawLine(w * 0.4, h * 0.3, w * 0.4, h * 0.15, steamPaint);
        // Line 2
        canvasObj.drawLine(w * 0.5, h * 0.25, w * 0.5, h * 0.1, steamPaint);
        // Line 3
        canvasObj.drawLine(w * 0.6, h * 0.3, w * 0.6, h * 0.15, steamPaint);
      })
  }
}

// Helper Component: Info Item
@Component
struct InfoItem {
  private label: string = '';
  private value: string = '';

  build() {
    Column() {
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#D3D3D3') // LightGray

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000') // Black
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// Helper Component: Step Card
@Component
struct StepCard {
  private number: string = '';
  private text: string = '';

  build() {
    Row() {
      // Number Circle
      Text(this.number)
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .textAlign(TextAlign.Center)
        .width(32)
        .height(32)
        .backgroundColor('#F5F5F5')
        .borderRadius(16) // CircleShape

      Text(this.text)
        .fontSize(14)
        .fontColor('#A9A9A9') // DarkGray
        .margin({ left: 16 })
    }
    .width('100%')
    .padding(16)
    .borderRadius(12)
    .border({ width: 1, color: '#EEEEEE', radius: 12 })
  }
}