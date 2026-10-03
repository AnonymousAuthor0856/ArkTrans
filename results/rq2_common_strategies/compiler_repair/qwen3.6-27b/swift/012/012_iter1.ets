import { common, window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct ContentView {
  @State markerPosition: Point = { x: 120, y: 200 };
  @State displayedCoordinates: string = "(200, 400)";

  build() {
    Column() {
      // Top App Bar
      Column() {
        Text("Favorite Spots Map")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF111827')
      }
      .width('100%')
      .padding({ top: 10, bottom: 10 })
      .backgroundColor('#FFF9FAFB')

      // Main Content Area
      Stack() {
        // Background Gradient
        Column()
          .linearGradient({
            angle: 135,
            colors: [
              ['rgba(255, 255, 255, 0.6)', 0],
              ['rgba(239, 246, 255, 0.5)', 0.5],
              ['rgba(255, 255, 255, 0.7)', 1]
            ]
          })
          .height('100%')
          .width('100%')

        Column() {
          Blank()

          // Map Container
          Stack() {
            // Radial Gradient Background
            Rectangle()
              .fill(Color.Transparent)
              .border({ width: 1, color: '#FFD1D5DB' })
              .borderRadius(24)
              .clip(RoundedRectangle({ radius: 24 }))
              .linearGradient({
                angle: 0,
                colors: [
                  ['rgba(255, 255, 255, 0.8)', 0],
                  ['rgba(239, 246, 255, 0.6)', 1]
                ],
                center: { x: '50%', y: '50%' },
                startWidth: 0,
                endWidth: 240 // Approximating radial effect with linear for simplicity or use custom drawing
              })
            
            // Using Canvas for precise circle drawing as in SwiftUI
            Canvas(this.ctx)
              .onReady(() => {
                this.ctx = new CanvasRenderingContext2D();
              })
              .onDraw((ctx: CanvasRenderingContext2D, size: Size) => {
                const centerX = size.width / 2;
                const centerY = size.height / 2;

                // Inner Circle (radius = 120)
                ctx.beginPath();
                ctx.arc(centerX, centerY, 120, 0, 2 * Math.PI);
                ctx.fillStyle = 'rgba(147, 197, 253, 0.3)'; // #FF93C5FD with opacity
                ctx.fill();

                // Outer Circle (radius = 180)
                ctx.beginPath();
                ctx.arc(centerX, centerY, 180, 0, 2 * Math.PI);
                ctx.fillStyle = 'rgba(147, 197, 253, 0.2)'; // #FF93C5FD with opacity
                ctx.fill();

                // Marker Solid Circle (radius = 4)
                // Note: In ArkTS Canvas, coordinates are relative to the canvas size.
                // The SwiftUI code used absolute points relative to the view, but here we map them.
                // Assuming the marker position is relative to the center or specific offset.
                // To mimic the SwiftUI behavior where markerPosition was (120, 200) in a 400h container,
                // we need to adjust. Let's assume the SwiftUI CGPoint was relative to the top-left of the Canvas.
                ctx.beginPath();
                ctx.arc(this.markerPosition.x, this.markerPosition.y, 4, 0, 2 * Math.PI);
                ctx.fillStyle = '#FF60A5FA';
                ctx.fill();

                // Marker Outer Ring (radius = 12)
                ctx.beginPath();
                ctx.arc(this.markerPosition.x, this.markerPosition.y, 12, 0, 2 * Math.PI);
                ctx.strokeStyle = 'rgba(96, 165, 250, 0.3)'; // #FF60A5FA with opacity
                ctx.lineWidth = 1;
                ctx.stroke();
              })
              .frame({ width: '100%', height: '100%' })

          }
          .height(400)
          .padding({ left: 16, right: 16 })
          .borderRadius(24)
          .shadow({ radius: 10, color: 'rgba(0, 0, 0, 0.05)', offsetY: 4 })

          // Bottom Control Area
          Column({ space: 16 }) {
            Text(`Spot Coordinates: ${this.displayedCoordinates}`)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FF111827')

            Button({ type: ButtonType.Normal }) {
              Text("Save Marker")
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.White)
            }
            .width('100%')
            .height(48)
            .backgroundColor('#FF60A5FA')
            .borderRadius(16)

            // Saved Markers List
            Column({ space: 12 }) {
              Text("Saved Markers")
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FF111827')
                .alignSelf(ItemAlign.Start)

              Column({ space: 8 }) {
                Row() {
                  Circle()
                    .fill('#FF60A5FA')
                    .width(8)
                    .height(8)
                  Text("Saved Marker")
                    .fontSize(14)
                    .fontWeight(FontWeight.Regular)
                    .fontColor('#FF111827')
                  Blank()
                }
                
                Row() {
                  Circle()
                    .fill('#FF60A5FA')
                    .width(8)
                    .height(8)
                  Text("Saved Marker")
                    .fontSize(14)
                    .fontWeight(FontWeight.Regular)
                    .fontColor('#FF111827')
                  Blank()
                }
              }
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({ top: 8 })
          }
          .padding({ left: 16, right: 16, top: 0, bottom: 24 })
        }
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF9FAFB')
    .systemBarProperties({ safeArea: SafeArea.NONE })
  }
}