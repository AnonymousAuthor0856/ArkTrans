@Entry
@Component
struct RootScreen {
  @State markerX: number = 200
  @State markerY: number = 400

  build() {
    Column() {
      // Top Bar
      Text('Favorite Spots Map')
        .fontSize(28)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#111827')
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 40, bottom: 24 })

      // Main Content Area
      Column() {
        // Map Container (Glassmorphic Card)
        Stack() {
          // Background Gradient Simulation for the card
          Column()
            .width('100%')
            .height(400)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .opacity(0.8)

          // Canvas for Circles and Marker
          Canvas()
            .width('100%')
            .height(400)
            .onReady((context: CanvasRenderingContext2D, canvas: CanvasRenderingContext2D) => {
              const ctx = context;
              if (!ctx) return;

              const w = canvas.width;
              const h = canvas.height;
              const cx = w / 2;
              const cy = h / 2;

              // Outer Circle (Secondary Color with alpha)
              ctx.beginPath();
              ctx.arc(cx, cy, 340, 0, Math.PI * 2);
              ctx.fillStyle = 'rgba(147, 197, 253, 0.2)'; // #93C5FD at 0.2 opacity approx
              ctx.fill();

              // Inner Circle (Secondary Color with alpha)
              ctx.beginPath();
              ctx.arc(cx, cy, 220, 0, Math.PI * 2);
              ctx.fillStyle = 'rgba(147, 197, 253, 0.3)'; // #93C5FD at 0.3 opacity approx
              ctx.fill();

              // Marker Pulse (Primary Color with alpha)
              ctx.beginPath();
              ctx.arc(this.markerX, this.markerY, 30, 0, Math.PI * 2);
              ctx.strokeStyle = 'rgba(96, 165, 250, 0.3)'; // #60A5FA at 0.3 opacity
              ctx.lineWidth = 3;
              ctx.stroke();

              // Marker Dot (Primary Color)
              ctx.beginPath();
              ctx.arc(this.markerX, this.markerY, 14, 0, Math.PI * 2);
              ctx.fillStyle = '#60A5FA';
              ctx.fill();
            })
            .borderRadius(24) // Clip canvas to shape
            .clip(true)

          // Border Overlay
          Column()
            .width('100%')
            .height(400)
            .border({ width: 1, color: '#D1D5DB' })
            .borderRadius(24)
        }
        .width('100%')
        .height(400)

        // Coordinates Text
        Text(`Spot Coordinates: (${this.markerX}, ${this.markerY})`)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#111827')
          .margin({ top: 12 })

        // Save Button
        Button('Save Marker')
          .width('100%')
          .height(48)
          .backgroundColor('#60A5FA')
          .fontColor('#FFFFFF')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .borderRadius(16)
          .margin({ top: 12 })
      }
      .layoutWeight(1)
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }
}