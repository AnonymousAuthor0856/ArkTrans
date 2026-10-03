// App.ets
import { UIAbility } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct RootScreen {
  @State markerPosition: { x: number, y: number } = { x: 200, y: 400 };
  
  // Color tokens
  private readonly primaryColor = '#60A5FA';
  private readonly secondaryColor = '#93C5FD';
  private readonly tertiaryColor = '#A5B4FC';
  private readonly backgroundColor = '#F9FAFB';
  private readonly surfaceColor = '#FFFFFF';
  private readonly surfaceVariantColor = '#EFF6FF';
  private readonly outlineColor = '#D1D5DB';
  private readonly onSurfaceColor = '#111827';
  private readonly onPrimaryColor = '#FFFFFF';
  
  build() {
    Column() {
      // Top bar with title
      Text('Favorite Spots Map')
        .fontSize(28)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(this.onSurfaceColor)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 20, bottom: 20 })
      
      // Main content area
      Column() {
        // Map container with glassmorphic effect
        Row() {
          // Canvas for drawing circles and marker
          Canvas()
            .width('100%')
            .height(400)
            .drawContent((canvas, canvasRect) => {
              const centerX = canvasRect.width / 2;
              const centerY = canvasRect.height / 2;
              
              // Draw outer circle
              canvas.beginPath();
              canvas.addCircle(centerX, centerY, 340);
              canvas.closePath();
              canvas.fillStyle = this.secondaryColor + '33'; // 20% opacity
              canvas.fill();
              
              // Draw inner circle
              canvas.beginPath();
              canvas.addCircle(centerX, centerY, 220);
              canvas.closePath();
              canvas.fillStyle = this.secondaryColor + '4D'; // 30% opacity
              canvas.fill();
              
              // Draw marker position indicator (outer ring)
              canvas.beginPath();
              canvas.addCircle(this.markerPosition.x, this.markerPosition.y, 30);
              canvas.closePath();
              canvas.strokeStyle = this.primaryColor + '4D'; // 30% opacity
              canvas.lineWidth = 3;
              canvas.stroke();
              
              // Draw marker dot
              canvas.beginPath();
              canvas.addCircle(this.markerPosition.x, this.markerPosition.y, 14);
              canvas.closePath();
              canvas.fillStyle = this.primaryColor;
              canvas.fill();
            })
        }
        .width('100%')
        .height(400)
        .borderRadius(24)
        .border({ width: 1, color: this.outlineColor })
        .backgroundColor(this.surfaceColor + 'CC') // 80% opacity white
        .margin({ bottom: 16 })
        
        // Coordinates text
        Text(`Spot Coordinates: (${this.markerPosition.x}, ${this.markerPosition.y})`)
          .fontSize(14)
          .fontColor(this.onSurfaceColor)
          .margin({ bottom: 16 })
        
        // Save button
        Button('Save Marker')
          .width('100%')
          .height(48)
          .backgroundColor(this.primaryColor)
          .fontColor(this.onPrimaryColor)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .borderRadius(16)
          .onClick(() => {
            // Handle save marker action
            console.info('Marker saved at:', this.markerPosition);
          })
      }
      .width('100%')
      .padding(16)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }
}