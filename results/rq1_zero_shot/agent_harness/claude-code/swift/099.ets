@Entry
@Component
struct MatchaBrewingScreen {
  build() {
    Column() {
      // Top Section: Title
      Column() {
        Blank().height(48)
        Text("MATCHA RITUAL")
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
          .letterSpacing(4)
        Blank().height(8)
        Text("Ceremonial Grade")
          .fontSize(28)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Color.Black)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)

      // Middle Section: Visual Art & Stats
      Column() {
        MatchaBowlCanvas()
          .width(160)
          .height(160)

        Blank().height(40)

        // Info Row
        Row() {
          InfoItem({ label: "TEMP", value: "80°C" })
          InfoItem({ label: "WATER", value: "70ml" })
          InfoItem({ label: "BAMBOO", value: "Whisk" })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)

      // Bottom Section: Instructions & Action
      Column() {
        StepCard({ number: "01", text: "Sift 2g of matcha powder." })
        Blank().height(12)
        StepCard({ number: "02", text: "Add hot water. Whisk in 'M' shape." })

        Blank().height(32)

        Button() {
          Row() {
            Text("\u{25B6}")
              .fontSize(20)
              .fontColor(Color.White)
            Blank().width(8)
            Text("START TIMER")
              .fontSize(16)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(Color.White)
          }
          .width('100%')
          .height(56)
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .height(56)
        .backgroundColor('#FF556B2F')
        .borderRadius(28)

        Blank().height(24)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
  }
}

@Component
struct MatchaBowlCanvas {
  private bowlColor: string = '#FF333333';
  private matchaColor: string = '#FF8BBD52';

  build() {
    Canvas(this.onPress)
      .width('100%')
      .height('100%')
      .onReady(() => {
        const ctx = this.onPress.getContext('2d') as CanvasRenderingContext2D;
        const w = this.onPress.width;
        const h = this.onPress.height;

        // 1. Draw the Bowl (Trapezoid-like shape with rounded bottom)
        ctx.beginPath();
        ctx.moveTo(w * 0.15, h * 0.4);
        ctx.lineTo(w * 0.85, h * 0.4);
        ctx.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9);
        ctx.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4);
        ctx.closePath();
        ctx.fillStyle = this.bowlColor;
        ctx.fill();

        // 2. Draw the Liquid (Matcha) inside
        ctx.beginPath();
        const matchaX = w * 0.2;
        const matchaY = h * 0.42;
        const matchaW = w * 0.6;
        const matchaH = h * 0.15;
        ctx.ellipse(matchaX + matchaW / 2, matchaY + matchaH / 2, matchaW / 2, matchaH / 2, 0, 0, Math.PI * 2);
        ctx.fillStyle = this.matchaColor;
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
      })
  }

  private onPress: CanvasRenderingContext2D = new CanvasRenderingContext2D();
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
        .fontColor('rgba(128, 128, 128, 0.5)')
      Blank().height(4)
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
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
          .fill('#FFF5F5F5')
        Text(this.number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width(32)
      .height(32)

      Blank().width(16)

      Text(this.text)
        .fontSize(14)
        .fontColor('#FF4D4D4D')
        .layoutWeight(1)
    }
    .width('100%')
    .padding(16)
    .border({ width: 1, color: '#FFEEEEEE', radius: 12 })
    .alignItems(VerticalAlign.Center)
  }
}
