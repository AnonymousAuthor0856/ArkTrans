@Entry
@Component
struct MatchaBrewingScreen {
  build() {
    Stack() {
      Column() {
        Column() {
          Blank()
            .height(48)

          Text('MATCHA RITUAL')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(4)
            .fontColor('#8E8E93')

          Blank()
            .height(8)

          Text('Ceremonial Grade')
            .fontSize(28)
            .fontWeight(300)
            .fontColor(Color.Black)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        Column() {
          MatchaBowlCanvas()
            .width(160)
            .height(160)

          Blank()
            .height(40)

          Row() {
            InfoItem({ label: 'TEMP', value: '80°C' })
            InfoItem({ label: 'WATER', value: '70ml' })
            InfoItem({ label: 'BAMBOO', value: 'Whisk' })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
        }
        .width('100%')
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)

        Column() {
          StepCard({ number: '01', text: 'Sift 2g of matcha powder.' })

          Blank()
            .height(12)

          StepCard({ number: '02', text: 'Add hot water. Whisk in \'M\' shape.' })

          Blank()
            .height(32)

          Button() {
            Row() {
              Text('▶')
                .fontSize(22)
                .fontColor(Color.White)
                .fontWeight(FontWeight.Medium)

              Blank()
                .width(8)

              Text('START TIMER')
                .fontSize(16)
                .fontWeight(600)
                .fontColor(Color.White)
            }
            .alignItems(VerticalAlign.Center)
            .justifyContent(FlexAlign.Center)
            .width('100%')
            .height(56)
          }
          .width('100%')
          .height(56)
          .backgroundColor('#556B2F')
          .borderRadius(28)
          .stateEffect(false)

          Blank()
            .height(24)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .padding(24)
      .backgroundColor(Color.White)
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
        const w: number = 160;
        const h: number = 160;

        this.context.clearRect(0, 0, w, h);

        this.context.fillStyle = '#333333';
        this.context.beginPath();
        this.context.moveTo(w * 0.15, h * 0.4);
        this.context.lineTo(w * 0.85, h * 0.4);
        this.context.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9);
        this.context.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4);
        this.context.closePath();
        this.context.fill();

        this.context.fillStyle = '#8BBD52';
        this.context.beginPath();
        this.context.ellipse(w * 0.5, h * 0.495, w * 0.3, h * 0.075, 0, 0, Math.PI * 2);
        this.context.fill();

        this.context.strokeStyle = 'rgba(128, 128, 128, 0.5)';
        this.context.lineWidth = 4;
        this.context.lineCap = 'round';

        this.context.beginPath();
        this.context.moveTo(w * 0.4, h * 0.3);
        this.context.lineTo(w * 0.4, h * 0.15);
        this.context.stroke();

        this.context.beginPath();
        this.context.moveTo(w * 0.5, h * 0.25);
        this.context.lineTo(w * 0.5, h * 0.1);
        this.context.stroke();

        this.context.beginPath();
        this.context.moveTo(w * 0.6, h * 0.3);
        this.context.lineTo(w * 0.6, h * 0.15);
        this.context.stroke();
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
        .fontColor('rgba(142, 142, 147, 0.5)')

      Blank()
        .height(4)

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
          .fill('#F5F5F5')

        Text(this.number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width(32)
      .height(32)

      Blank()
        .width(16)

      Text(this.text)
        .fontSize(14)
        .fontColor('#4D4D4D')
        .maxLines(1)
    }
    .width('100%')
    .height(64)
    .padding(16)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.White)
    .border({
      width: 1,
      color: '#EEEEEE',
      radius: 12
    })
  }
}
