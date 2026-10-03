// App.ets
import { UIAbility } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

interface MarkerPosition {
  x: number;
  y: number;
}

@Entry
@Component
struct RootScreen {
  @State markerPosition: MarkerPosition = { x: 200, y:400 };
  
  // Color tokens - Use string literals for hex colors to avoid ResourceColor type issues with class properties
  private readonly primaryColor: string = '#60A5FA';
  private readonly secondaryColor: string = '#93C5FD';
  private readonly tertiaryColor: string = '#A5B4FC';
  private readonly backgroundColor: string = '#F9FAFB';
  private readonly surfaceColor: string = '#FFFFFF';
  private readonly surfaceVariantColor: string = '#EFF6FF';
  private readonly outlineColor: string = '#D1D5DB';
  private readonly onSurfaceColor: string = '#111827';
  private readonly onPrimaryColor: string = '#FFFFFF';
  
  build() {
    Column() {
      // Top bar with title
      Text('Favorite Spots Map')
        .fontSize(28)
        .fontWeight(FontWeight.Bold) // SemiBold is not standard in all versions, use Bold or 600
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
            .drawContent((canvas: CanvasRenderingContext2D, rect: Rect) => {
              const centerX = rect.width / 2;
              const centerY = rect.height / 2;
              
              // Draw outer circle
              canvas.beginPath();
              canvas.arc(centerX, centerY, 340, 0, 2 * Math.PI);
              canvas.closePath();
              canvas.fillStyle = this.secondaryColor + '33'; // 20% opacity
              canvas.fill();
              
              // Draw inner circle
              canvas.beginPath();
              canvas.arc(centerX, centerY, 220, 0, 2 * Math.PI);
              canvas.closePath();
              canvas.fillStyle = this.secondaryColor + '4D'; // 30% opacity
              canvas.fill();
              
              // Draw marker position indicator (outer ring)
              canvas.beginPath();
              canvas.arc(this.markerPosition.x, this.markerPosition.y, 30, 0, 2 * Math.PI);
              canvas.closePath();
              canvas.strokeStyle = this.primaryColor + '4D'; // 30% opacity
              canvas.lineWidth = 3;
              canvas.stroke();
              
              // Draw marker dot
              canvas.beginPath();
              canvas.arc(this.markerPosition.x, this.markerPosition.y, 14, 0, 2 * Math.PI);
              canvas.closePath();
              canvas.fillStyle = this.primaryColor;
              canvas.fill();
            })
        }
        .width('100%')
        .height(400)
        .borderRadius(24)
        .border({ width: 1, color: this.outlineColor })
        .backgroundColor(Color.White) 
        
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