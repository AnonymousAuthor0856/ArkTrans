// MatchaBrewingScreen.ets

// MARK: - MatchaBrewingScreen
@Entry
@Component
struct MatchaBrewingScreen {
  build() {
    Stack() {
      // STRICT: Pure White Background
      Column().width('100%').height('100%').backgroundColor(Color.White)

      // Main Content Overlay
      Column() {
        // Top Section: Title
        Column() {
          Blank().height(48)
          Text('MATCHA RITUAL')
            .fontSize(14)
            .letterSpacing(4)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Gray)
          Blank().height(8)
          Text('Ceremonial Grade')
            .fontSize(28)
            .fontWeight(FontWeight.Lighter)
            .fontColor(Color.Black)
        }

        // Middle Section: Visual Art & Stats
        Column() {
          MatchaBowlCanvas()
            .width(160)
            .height(160)

          Blank().height(40)

          // Info Row - SpaceEvenly
          Row() {
            Blank()
            InfoItem({ label: 'TEMP', value: '80°C' })
            Blank()
            InfoItem({ label: 'WATER', value: '70ml' })
            Blank()
            InfoItem({ label: 'BAMBOO', value: 'Whisk' })
            Blank()
          }
          .width('100%')
        }
        .layoutWeight(1) // Allows middle section to take available space

        // Bottom Section: Instructions & Action
        Column() {
          StepCard({ number: '01', text: 'Sift 2g of matcha powder.' })
          Blank().height(12)
          StepCard({ number: '02', text: 'Add hot water. Whisk in \'M\' shape.' })

          Blank().height(32)

          Button() {
            Row() {
              Image($r('sys.symbol.play_fill'))
                .width(20)
                .height(20)
                .fillColor(Color.White)
              Text('START TIMER')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.White)
            }
          }
          .backgroundColor('#FF556B2F')
          .borderRadius(28)
          .width('100%')
          .height(56)

          Blank().height(24)
        }
        .width('100%')
      }
      .padding(24)
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - MatchaBowlCanvas
// Custom drawing for Matcha Bowl and Steam
@Component
struct MatchaBowlCanvas {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.draw();
      })
  }

  draw() {
    const ctx = this.context;
    const w = 160; // Matches the fixed size in parent
    const h = 160;

    // 1. Draw the Bowl
    ctx.beginPath();
    ctx.moveTo(w * 0.15, h * 0.4);
    ctx.lineTo(w * 0.85, h * 0.4);
    ctx.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9);
    ctx.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4);
    ctx.closePath();
    ctx.fillStyle = '#FF333333';
    ctx.fill();

    // 2. Draw the Liquid (Matcha)
    ctx.beginPath();
    ctx.ellipse(w * 0.5, h * 0.495, w * 0.3, h * 0.075, 0, 0, Math.PI * 2);
    ctx.fillStyle = '#FF8BBD52';
    ctx.fill();

    // 3. Draw Steam
    ctx.strokeStyle = 'rgba(128, 128, 128, 0.5)';
    ctx.lineWidth = 4;
    ctx.lineCap = 'round';

    ctx.beginPath();
    ctx.moveTo(w * 0.4, h * 0.3);
    ctx.lineTo(w * 0.4, h * 0.15);
    ctx.stroke();

    ctx.beginPath();
    ctx.moveTo(w * 0.5, h * 0.25);
    ctx.lineTo(w * 0.5, h * 0.1);
    ctx.stroke();

    ctx.beginPath();
    ctx.moveTo(w * 0.6, h * 0.3);
    ctx.lineTo(w * 0.6, h * 0.15);
    ctx.stroke();
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
        .fontColor('rgba(128, 128, 128, 0.5)')
      Blank().height(4)
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
  }
}

// MARK: - StepCard
@Component
struct StepCard {
  @Prop number: string;
  @Prop text: string;

  build() {
    Row() {
      Stack() {
        Text(this.number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width(32)
      .height(32)
      .backgroundColor('#FFF5F5F5')
      .borderRadius(16) // Circle

      Blank().width(16)

      Text(this.text)
        .fontSize(14)
        .fontColor('#FF4D4D4D') // Dark Gray
    }
    .width('100%')
    .padding(16)
    .border({ width: 1, color: '#FFEEEEEE', radius: 12 })
  }
}