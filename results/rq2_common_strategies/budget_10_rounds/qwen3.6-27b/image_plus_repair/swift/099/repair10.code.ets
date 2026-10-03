// MatchaBrewingScreen.ets

@Entry
@Component
struct MatchaBrewingScreen {
  @State private isTimerRunning: boolean = false;

  build() {
    Column() {
      // Top Section: Title
      Column() {
        Text('MATCHA RITUAL')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(4)
          .fontColor('#999999')
        
        Text('Ceremonial Grade')
          .margin({ top: 8 })
          .fontSize(28)
          .fontWeight(FontWeight.Lighter)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .margin({ top: 48 })

      // Middle Section: Visual Art & Stats
      Column() {
        // Custom Drawn Bowl
        MatchaBowlCanvas()
          .width(160)
          .height(160)

        // Info Row
        Row() {
          InfoItem({ label: 'TEMP', value: '80°C' })
          InfoItem({ label: 'WATER', value: '70ml' })
          InfoItem({ label: 'BAMBOO', value: 'Whisk' })
        }
        .justifyContent(FlexAlign.SpaceEvenly)
        .width('100%')
        .margin({ top: 40 })
      }
      .alignItems(HorizontalAlign.Center)
      .layoutWeight(1) // Takes up available space to push bottom section down

      // Bottom Section: Instructions & Action
      Column() {
        StepCard({ number: '01', text: 'Sift 2g of matcha powder.' })
        
        StepCard({ number: '02', text: "Add hot water. Whisk in 'M' shape." })
          .margin({ top: 12 })

        Button() {
          Row() {
            Image($r('app.media.ic_play')) 
              .width(20)
              .height(20)
              .fillColor(Color.White)
            
            Text('START TIMER')
              .margin({ left: 8 })
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
          }
          .justifyContent(FlexAlign.Center)
          .width('100%')
          .height(56)
        }
        .backgroundColor('#556B2F')
        .borderRadius(28)
        .margin({ top: 32 })
        .onClick(() => {
          this.isTimerRunning = !this.isTimerRunning;
        })
      }
      .width('100%')
      .margin({ bottom: 24 })
    }
    .padding(24)
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

// MARK: - MatchaBowlCanvas
// Custom drawing component for the bowl and steam
@Component
struct MatchaBowlCanvas {
  private canvasRenderingContext2D = new CanvasRenderingContext2D();

  build() {
    Canvas(this.canvasRenderingContext2D)
      .onReady((context: CanvasRenderingContext2D) => {
        const w = context.width;
        const h = context.height;

        // 1. Draw Steam (Lines)
        context.beginPath();
        context.strokeStyle = '#CCCCCC'; // Light gray
        context.lineWidth = 4;
        context.lineCap = 'round';

        // Left line
        context.moveTo(w * 0.4, h * 0.3);
        context.lineTo(w * 0.4, h * 0.15);
        
        // Middle line
        context.moveTo(w * 0.5, h * 0.25);
        context.lineTo(w * 0.5, h * 0.1);
        
        // Right line
        context.moveTo(w * 0.6, h * 0.3);
        context.lineTo(w * 0.6, h * 0.15);
        
        context.stroke();

        // 2. Draw the Bowl (Trapezoid-like shape with rounded bottom)
        context.beginPath();
        context.fillStyle = '#333333'; // Dark charcoal
        
        // Start top left
        context.moveTo(w * 0.15, h * 0.4);
        // Line to top right
        context.lineTo(w * 0.85, h * 0.4);
        // Curve to bottom center (Right side)
        context.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9);
        // Curve back to top left (Left side)
        context.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4);
        
        context.closePath();
        context.fill();

        // 3. Draw the Liquid (Matcha) inside
        context.beginPath();
        context.fillStyle = '#8BBD52'; // Bright matcha green
        
        // Ellipse for liquid surface
        // x, y, radiusX, radiusY, rotation, startAngle, endAngle
        context.ellipse(w * 0.5, h * 0.42, w * 0.3, h * 0.075, 0, 0, 2 * Math.PI);
        
        context.fill();
      })
      .width('100%')
      .height('100%')
  }
}

// MARK: - InfoItem
@Component
struct InfoItem {
  @Prop label: string;
  @Prop value: string;

  build() {
    Column() {
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#CCCCCC') // Light gray
      
      Text(this.value)
        .margin({ top: 4 })
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// MARK: - StepCard
@Component
struct StepCard {
  @Prop number: string;
  @Prop text: string;

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
        .borderRadius(16)
      
      Text(this.text)
        .margin({ left: 16 })
        .fontSize(14)
        .fontColor('#666666') // Dark gray
    }
    .width('100%')
    .padding(16)
    .borderRadius(12)
    .border({ width: 1, color: '#EEEEEE' })
  }
}