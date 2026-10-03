import { window } from '@kit.ArkUI';
import { common, UIAbility, Want } from '@kit.AbilityKit';
import { canvas } from '@kit.ArkGraphics';

interface MarkerPosition {
  x: number;
  y: number;
}

@Entry
@Component
struct RootScreen {
  @State markerPosition: MarkerPosition = { x: 200, y: 400 };
  private context: UIAbility | null = null;

  aboutToAppear() {
    // Attempt to hide system bars for immersive experience similar to the Android code
    try {
      let mainWindowSync = window.getWindowSync(this.context as unknown as common.UIAbilityContext);
      if (mainWindowSync) {
        mainWindowSync.setWindowLayoutFullScreen(true);
        mainWindowSync.setWindowSystemBarEnable([window.SystemBarType.STATUS_BAR], {
          statusBarColor: '#F9FAFB',
          statusBarContentColor: '#111827'
        });
      }
    } catch (e) {
      console.error('Failed to set window properties', e);
    }
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Text("Favorite Spots Map")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F9FAFB')

      // Main Content Area
      Column() {
        // Map Container
        Column() {
          // Canvas for drawing map elements
          Canvas()
            .width('100%')
            .height(400)
            .onDraw((canvasRenderingContext2D: canvas.CanvasRenderingContext2D, canvasRect: canvas.CanvasRenderingContext2D.CanvasRect) => {
              const centerX = canvasRect.width / 2;
              const centerY = canvasRect.height / 2;

              // Draw background circles
              canvasRenderingContext2D.beginPath();
              canvasRenderingContext2D.arc(centerX, centerY, 220, 0, Math.PI * 2, false);
              canvasRenderingContext2D.fillStyle = Color('#93C5FD').withAlpha(0.3).toArgbString();
              canvasRenderingContext2D.fill();

              canvasRenderingContext2D.beginPath();
              canvasRenderingContext2D.arc(centerX, centerY, 340, 0, Math.PI * 2, false);
              canvasRenderingContext2D.fillStyle = Color('#93C5FD').withAlpha(0.2).toArgbString();
              canvasRenderingContext2D.fill();

              // Draw Marker
              const mx = this.markerPosition.x;
              const my = this.markerPosition.y;

              // Outer ring
              canvasRenderingContext2D.beginPath();
              canvasRenderingContext2D.arc(mx, my, 30, 0, Math.PI * 2, false);
              canvasRenderingContext2D.strokeStyle = Color('#60A5FA').withAlpha(0.3).toArgbString();
              canvasRenderingContext2D.lineWidth = 3;
              canvasRenderingContext2D.stroke();

              // Inner dot
              canvasRenderingContext2D.beginPath();
              canvasRenderingContext2D.arc(mx, my, 14, 0, Math.PI * 2, false);
              canvasRenderingContext2D.fillStyle = Color('#60A5FA').toArgbString();
              canvasRenderingContext2D.fill();
            })
            .borderRadius(24)
            .border({ width: 1, color: '#D1D5DB', style: BorderStyle.Solid })
            .onClick(() => {
              // Simple interaction to move marker randomly for demonstration
              this.markerPosition = {
                x: Math.random() * 300 + 50,
                y: Math.random() * 300 + 50
              };
            })
        }
        .width('100%')
        .height(400)
        .borderRadius(24)
        .linearGradient({
          direction: GradientDirection.RADIAL,
          colors: [
            ['rgba(255, 255, 255, 0.8)', 0],
            ['rgba(239, 246, 255, 0.6)', 1]
          ]
        })
        .margin({ bottom: 16 })

        // Coordinates Text
        Text(`Spot Coordinates: (${this.markerPosition.x.toFixed(0)}, ${this.markerPosition.y.toFixed(0)})`)
          .fontSize(14)
          .fontColor('#111827')
          .margin({ bottom: 12 })

        // Save Button
        Button("Save Marker")
          .type(ButtonType.Normal)
          .backgroundColor('#60A5FA')
          .fontColor('#FFFFFF')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .borderRadius(16)
          .width('100%')
          .height(48)
          .onClick(() => {
            // Handle save action
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.End)
      .linearGradient({
        direction: GradientDirection.LINEAR,
        angle: 180,
        colors: [
          ['rgba(255, 255, 255, 0.6)', 0],
          ['rgba(239, 246, 255, 0.5)', 0.5],
          ['rgba(255, 255, 255, 0.7)', 1]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }
}