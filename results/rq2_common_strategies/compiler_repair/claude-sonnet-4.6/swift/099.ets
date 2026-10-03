@Entry
@Component
struct MatchaBrewingScreen {
  build() {
    Stack() {
      // White background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(Color.White)

      Column({ space: 0 }) {
        // Top Section: Title
        Column({ space: 0 }) {
          Text('MATCHA RITUAL')
            .fontSize(14)
            .letterSpacing(4)
            .fontWeight(FontWeight.Bold)
            .fontColor('#808080')
            .margin({ top: 48 })

          Text('Ceremonial Grade')
            .fontSize(28)
            .fontWeight(FontWeight.Lighter)
            .fontColor(Color.Black)
            .margin({ top: 8 })
        }
        .alignItems(HorizontalAlign.Center)
        .width('100%')

        // Middle Section
        Column({ space: 0 }) {
          MatchaBowlCanvas()
            .width(160)
            .height(160)

          // Info Row
          Row({ space: 0 }) {
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
        .width('100%')

        // Bottom Section
        Column({ space: 0 }) {
          StepCard({ number: '01', text: 'Sift 2g of matcha powder.' })

          StepCard({ number: '02', text: "Add hot water. Whisk in 'M' shape." })
            .margin({ top: 12 })

          Button() {
            Row({ space: 8 }) {
              Image($r('sys.media.ohos_ic_public_play'))
                .width(20)
                .height(20)
                .fillColor(Color.White)
              Text('START TIMER')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.White)
            }
            .justifyContent(FlexAlign.Center)
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
      .padding(24)
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
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
        const ctx = this.context;
        const w = 160;
        const h = 160;

        // 1. Draw Bowl
        ctx.beginPath();
        ctx.moveTo(w * 0.15, h * 0.4);
        ctx.lineTo(w * 0.85, h * 0.4);
        ctx.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9);
        ctx.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4);
        ctx.closePath();
        ctx.fillStyle = '#333333';
        ctx.fill();

        // 2. Draw Matcha liquid (ellipse)
        ctx.beginPath();
        const ex = w * 0.2;
        const ey = h * 0.42;
        const ew = w * 0.6;
        const eh = h * 0.15;
        ctx.ellipse(ex + ew / 2, ey + eh / 2, ew / 2, eh / 2, 0, 0, Math.PI * 2);
        ctx.fillStyle = '#8BBD52';
        ctx.fill();

        // 3. Draw Steam
        ctx.strokeStyle = 'rgba(128,128,128,0.5)';
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
      })
  }
}

@Component
struct InfoItem {
  label: string = '';
  value: string = '';

  build() {
    Column({ space: 0 }) {
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('rgba(128,128,128,0.5)')

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
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
    Row({ space: 0 }) {
      Stack() {
        Circle()
          .width(32)
          .height(32)
          .fill('#F5F5F5')
        Text(this.number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
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