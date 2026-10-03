import { BusinessError } from '@kit.BasicServicesKit';
import { common, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

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
          .fontWeight(FontWeight.Semibold)
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
          .position({ x: 0, y: 0 })
          .width('100%')
          .height('100%')

        Column() {
          Blank()

          // Map Container
          Stack() {
            // Radial Gradient Background
            Circle()
              .fill(Color.Transparent)
              .border({ width: 0 })
              .shadow({ radius: 0 })
              .clipShape(RoundedRectangle({ cornerRadius: 24 }))
              .radialGradient({
                angle: 0,
                center: { x: '50%', y: '50%' },
                focus: { x: '50%', y: '50%' },
                radius: '100%',
                colors: [
                  ['rgba(255, 255, 255, 0.8)', 0],
                  ['rgba(239, 246, 255, 0.6)', 1]
                ]
              })
              .width('100%')
              .height('100%')

            // Border
            Rect()
              .width('100%')
              .height('100%')
              .border({ width: 1, color: '#FFD1D5DB' })
              .borderRadius(24)

            // Draw Circles and Marker
            Canvas(this.renderContext)
              .width('100%')
              .height('100%')
          }
          .height(400)
          .padding({ left: 16, right: 16 })

          // Bottom Control Area
          Column({ space: 16 }) {
            Text(`Spot Coordinates: ${this.displayedCoordinates}`)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FF111827')

            Button("Save Marker") {
              // Save marker action
            }
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
            .width('100%')
            .height(48)
            .backgroundColor('#FF60A5FA')
            .borderRadius(16)

            // Saved Markers List
            Column({ space: 12 }) {
              Text("Saved Markers")
                .fontSize(18)
                .fontWeight(FontWeight.Semibold)
                .fontColor('#FF111827')
                .alignSelf(ItemAlign.Start)

              Column({ space: 8 }) {
                this.SavedMarkerItem()
                this.SavedMarkerItem()
              }
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({ top: 8 })
          }
          .padding({ left: 16, right: 16, top: 0, bottom: 24 })
        }
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF9FAFB')
  }

  @Builder
  SavedMarkerItem() {
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

  private renderContext?: CanvasRenderingContext2D;

  aboutToAppear() {
    // Initialize canvas context if needed
  }

  draw(context: CanvasRenderingContext2D, size: Size) {
    const centerX = size.width / 2;
    const centerY = size.height / 2;

    // Inner circle (radius = 120)
    context.beginPath();
    context.arc(centerX, centerY, 120, 0, Math.PI * 2);
    context.fillStyle = 'rgba(147, 197, 253, 0.3)';
    context.fill();

    // Outer circle (radius = 180)
    context.beginPath();
    context.arc(centerX, centerY, 180, 0, Math.PI * 2);
    context.fillStyle = 'rgba(147, 197, 253, 0.2)';
    context.fill();

    // Marker point solid circle (radius = 4)
    context.beginPath();
    context.arc(this.markerPosition.x, this.markerPosition.y, 4, 0, Math.PI * 2);
    context.fillStyle = '#FF60A5FA';
    context.fill();

    // Marker point outer circle (radius = 12, stroke width = 1)
    context.beginPath();
    context.arc(this.markerPosition.x, this.markerPosition.y, 12, 0, Math.PI * 2);
    context.strokeStyle = 'rgba(96, 165, 250, 0.3)';
    context.lineWidth = 1;
    context.stroke();
  }
}