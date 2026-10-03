// MatchaBrewingScreen.ets

@Entry
@Component
struct MatchaBrewingScreen {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Column() {
      // Top Section: Title
      Column() {
        Text('MATCHA RITUAL')
          .fontSize(14)
          .letterSpacing(4)
          .fontWeight(FontWeight.Bold)
          .fontColor('#888888')
          .margin({ top: 48 })

        Text('Ceremonial Grade')
          .fontSize(28)
          .fontWeight(FontWeight.Lighter)
          .fontColor('#000000')
          .margin({ top: 8 })
      }

      // Middle Section: Visual Art & Stats
      Column() {
        // Custom drawn Matcha Bowl
        Canvas(this.context)
          .width(160)
          .height(160)
          .onReady(() => {
            this.drawMatchaBowl();
          })
          .margin({ top: 40 })

        // Info Row
        Row() {
          this.InfoItem('TEMP', '80°C')
          this.InfoItem('WATER', '70ml')
          this.InfoItem('BAMBOO', 'Whisk')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: 40 })
      }

      // Bottom Section: Instructions & Action
      Column() {
        this.StepCard('01', 'Sift 2g of matcha powder.')
        this.StepCard('02', 'Add hot water. Whisk in \'M\' shape.')

        Button() {
          Row() {
            Text('▶').fontSize(20).fontColor('#FFFFFF')
            Text('START TIMER')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .margin({ left: 8 })
          }
          .width('100%')
          .height(56)
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .height(56)
        .borderRadius(28)
        .backgroundColor('#556B2F')
        .margin({ top: 32 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .margin({ bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Center)
  }

  private drawMatchaBowl() {
    const ctx = this.context;
    const w = 160;
    const h = 160;

    // 1. Draw the Bowl
    ctx.beginPath();
    ctx.moveTo(w * 0.15, h * 0.4);
    ctx.lineTo(w * 0.85, h * 0.4);
    ctx.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9);
    ctx.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4);
    ctx.closePath();
    ctx.fillStyle = '#333333';
    ctx.fill();

    // 2. Draw the Liquid (Matcha)
    ctx.beginPath();
    ctx.ellipse(w * 0.5, h * 0.495, w * 0.3, h * 0.075, 0, 0, Math.PI * 2);
    ctx.fillStyle = '#8BBD52';
    ctx.fill();

    // 3. Draw Steam
    ctx.strokeStyle = 'rgba(211, 211, 211, 0.5)';
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

  @Builder
  InfoItem(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#D3D3D3')
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  StepCard(number: string, text: string) {
    Row() {
      Text(number)
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .width(32)
        .height(32)
        .textAlign(TextAlign.Center)
        .borderRadius(16)
        .backgroundColor('#F5F5F5')

      Text(text)
        .fontSize(14)
        .fontColor('#A9A9A9')
        .margin({ left: 16 })
    }
    .width('100%')
    .padding(16)
    .border({ width: 1, color: '#EEEEEE', radius: 12 })
    .alignItems(VerticalAlign.Center)
    .margin({ top: 12 })
  }
}