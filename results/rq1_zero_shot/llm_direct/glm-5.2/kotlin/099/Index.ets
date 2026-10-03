// MatchaBrewingScreen.ets

// 1. Define the Matcha Bowl Canvas Component
@Component
struct MatchaBowlCanvas {
  private bowlColor: string = '#333333';
  private matchaColor: string = '#8BBD52';
  private steamColor: string = '#80D3D3D3'; // LightGray with 50% opacity

  build() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .onReady(() => {
        const w = this.context.width;
        const h = this.context.height;

        // 1. Draw the Bowl (Path)
        this.context.beginPath();
        this.context.moveTo(w * 0.15, h * 0.4);
        this.context.lineTo(w * 0.85, h * 0.4);
        this.context.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9);
        this.context.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4);
        this.context.closePath();
        this.context.fillStyle = this.bowlColor;
        this.context.fill();

        // 2. Draw the Liquid (Matcha)
        this.context.beginPath();
        this.context.ellipse(w * 0.5, h * 0.495, w * 0.3, h * 0.075, 0, 0, Math.PI * 2);
        this.context.fillStyle = this.matchaColor;
        this.context.fill();

        // 3. Draw Steam (Lines)
        this.context.lineWidth = 4;
        this.context.lineCap = 'round';
        this.context.strokeStyle = this.steamColor;
        
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

  private context: RenderingContext = new RenderingContext();
}

// 2. Define the Info Item Component
@Component
struct InfoItem {
  @Prop label: string;
  @Prop value: string;

  build() {
    Column() {
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#D3D3D3')
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// 3. Define the Step Card Component
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
        .width(32)
        .height(32)
        .backgroundColor('#F5F5F5')
        .borderRadius(16)
        .textAlign(TextAlign.Center)
        .markAnchor({ x: '50%', y: '50%' })
        .position({ x: 16, y: '50%' }) // Center vertically in padding

      // Step Text
      Text(this.text)
        .fontSize(14)
        .fontColor('#A9A9A9')
        .margin({ left: 48 }) // 32 (circle) + 16 (gap)
    }
    .width('100%')
    .padding(16)
    .border({ width: 1, color: '#EEEEEE', radius: 12 })
    .alignItems(VerticalAlign.Center)
  }
}

// 4. Main Screen Entry
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
          .fontColor('#808080')
          .margin({ top: 48 })

        Text('Ceremonial Grade')
          .fontSize(28)
          .fontWeight(FontWeight.Light)
          .fontColor('#000000')
          .margin({ top: 8 })
      }

      // Middle Section: Visual Art & Stats
      Column() {
        // Custom drawn Matcha Bowl
        MatchaBowlCanvas()
          .width(160)
          .height(160)
          .margin({ top: 40 })

        // Info Row
        Row() {
          InfoItem({ label: 'TEMP', value: '80°C' })
          InfoItem({ label: 'WATER', value: '70ml' })
          InfoItem({ label: 'BAMBOO', value: 'Whisk' })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: 40 })
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)

      // Bottom Section: Instructions & Action
      Column() {
        StepCard({ number: '01', text: 'Sift 2g of matcha powder.' })
        StepCard({ number: '02', text: 'Add hot water. Whisk in \'M\' shape.' })
          .margin({ top: 12 })

        // Start Timer Button
        Button() {
          Row() {
            Text('▶') // Play Arrow representation
              .fontSize(20)
              .fontColor('#FFFFFF')
            Text('START TIMER')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .margin({ left: 8 })
          }
        }
        .width('100%')
        .height(56)
        .backgroundColor('#556B2F')
        .borderRadius(28)
        .margin({ top: 32, bottom: 24 })
      }
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}