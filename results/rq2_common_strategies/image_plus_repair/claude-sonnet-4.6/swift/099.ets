@Entry
@Component
struct MatchaBrewingScreen {
  build() {
    Column() {
      // Top Section: Title
      Column() {
        Text('MATCHA RITUAL')
          .fontSize(14)
          .letterSpacing(4)
          .fontWeight(FontWeight.Bold)
          .fontColor('#999999')
          .margin({ top: 48 })

        Text('Ceremonial Grade')
          .fontSize(28)
          .fontWeight(FontWeight.Lighter)
          .fontColor('#000000')
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')

      // Middle Section
      Column() {
        MatchaBowlCanvas()
          .width(160)
          .height(160)

        // Info Row
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
        .margin({ top: 40 })
      }
      .alignItems(HorizontalAlign.Center)
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)

      // Bottom Section
      Column() {
        StepCard({ number: '01', text: 'Sift 2g of matcha powder.' })

        StepCard({ number: '02', text: "Add hot water. Whisk in 'M' shape." })
          .margin({ top: 12 })

        Button() {
          Row({ space: 8 }) {
            Text('▶')
              .fontSize(16)
              .fontColor('#FFFFFF')
            Text('START TIMER')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
          }
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .height(56)
        .backgroundColor('#556B2F')
        .borderRadius(28)
        .margin({ top: 32 })

        Blank().height(24)
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct MatchaBowlCanvas {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Canvas(this.context)
      .width(160)
      .height(160)
      .onReady(() => {
        const context = this.context;
        const w = 160;
        const h = 160;

        // Draw steam lines
        context.strokeStyle = 'rgba(128,128,128,0.5)';
        context.lineWidth = 4;
        context.lineCap = 'round';

        context.beginPath();
        context.moveTo(w * 0.4, h * 0.3);
        context.lineTo(w * 0.4, h * 0.15);
        context.stroke();

        context.beginPath();
        context.moveTo(w * 0.5, h * 0.25);
        context.lineTo(w * 0.5, h * 0.1);
        context.stroke();

        context.beginPath();
        context.moveTo(w * 0.6, h * 0.3);
        context.lineTo(w * 0.6, h * 0.15);
        context.stroke();

        // Draw bowl
        context.fillStyle = '#333333';
        context.beginPath();
        context.moveTo(w * 0.15, h * 0.4);
        context.lineTo(w * 0.85, h * 0.4);
        context.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9);
        context.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4);
        context.closePath();
        context.fill();

        // Draw matcha liquid
        context.fillStyle = '#8BBD52';
        context.beginPath();
        context.ellipse(
          w * 0.2 + (w * 0.6) / 2,
          h * 0.42 + (h * 0.15) / 2,
          (w * 0.6) / 2,
          (h * 0.15) / 2,
          0, 0, Math.PI * 2
        );
        context.fill();
      })
  }
}

@Component
struct InfoItem {
  label: string = '';
  value: string = '';

  build() {
    Column() {
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('rgba(128,128,128,0.5)')

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StepCard {
  number: string = '';
  text: string = '';

  build() {
    Row() {
      Stack() {
        Circle()
          .width(32)
          .height(32)
          .fill('#F5F5F5')
        Text(this.number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .width(32)
      .height(32)

      Text(this.text)
        .fontSize(14)
        .fontColor('#4D4D4D')
        .margin({ left: 16 })
        .layoutWeight(1)
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .border({
      width: 1,
      color: '#EEEEEE',
      radius: 12
    })
  }
}