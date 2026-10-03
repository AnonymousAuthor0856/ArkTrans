// Colors
const primaryColor = '#6D4C41';
const surfaceVariant = '#FAFAFA';
const outlineColor = '#EEEEEE';
const backgroundTint = '#F5F5F5';
const teaLeafDetail = '#8D6E63';
const favoriteTint = '#FFCDD2';
const leafCircleBg = '#EFEBE9';

@Entry
@Component
struct TeaBrewingScreen {
  build() {
    Scroll() {
      Column({ space: 0 }) {
        HeaderSection()
          .margin({ top: 48, bottom: 32 })

        TeaSelectionCard()
          .margin({ bottom: 32 })

        TimerDisplay()
          .margin({ bottom: 40 })

        ControlButtons()
          .margin({ bottom: 24 })

        PreparationSteps()
          .margin({ bottom: 24 })
      }
      .padding({ left: 24, right: 24 })
      .width('100%')
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column({ space: 2 }) {
        Text('Good Morning,')
          .fontSize(14)
          .fontColor('#888888')
        Text('Tea Master')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Text('⚙')
          .fontSize(22)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor(backgroundTint)
      .type(ButtonType.Normal)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TeaSelectionCard {
  build() {
    Row({ space: 16 }) {
      Stack() {
        Circle()
          .width(60)
          .height(60)
          .fill(leafCircleBg)

        Stack() {
          Circle()
            .width(30)
            .height(30)
            .fillOpacity(0)
            .stroke(primaryColor)
            .strokeWidth(2)

          Line()
            .startPoint([15, 7])
            .endPoint([15, 23])
            .stroke(primaryColor)
            .strokeWidth(2)
            .strokeLineCap(LineCapStyle.Round)
        }
        .width(30)
        .height(30)
      }
      .width(60)
      .height(60)

      Column({ space: 2 }) {
        Text('Earl Grey Reserve')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text('Black Tea • 95°C')
          .fontSize(12)
          .fontColor(teaLeafDetail)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('♥')
        .fontSize(22)
        .fontColor(favoriteTint)
    }
    .padding(20)
    .width('100%')
    .backgroundColor(surfaceVariant)
    .borderRadius(24)
    .border({ width: 1, color: outlineColor, radius: 24 })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TimerDisplay {
  build() {
    Stack() {
      Circle()
        .width(220)
        .height(220)
        .fillOpacity(0)
        .stroke(backgroundTint)
        .strokeWidth(12)

      TimerArcCanvas()
        .width(220)
        .height(220)

      Column({ space: 4 }) {
        Text('Steeping')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#888888')
          .letterSpacing(2)

        Text('02:00')
          .fontSize(45)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Color.Black)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width(220)
    .height(220)
  }
}

@Component
struct TimerArcCanvas {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Canvas(this.context)
      .width(220)
      .height(220)
      .onReady(() => {
        this.drawArc();
      })
  }

  drawArc() {
    const ctx = this.context;
    const cx = 110;
    const cy = 110;
    const radius = 104;

    ctx.clearRect(0, 0, 220, 220);
    ctx.beginPath();
    const startAngle = (-210) * Math.PI / 180;
    const endAngle = startAngle + (0.66 * 2 * Math.PI);

    ctx.arc(cx, cy, radius, startAngle, endAngle, false);
    ctx.strokeStyle = primaryColor;
    ctx.lineWidth = 12;
    ctx.lineCap = 'round';
    ctx.stroke();
  }
}

@Component
struct ControlButtons {
  build() {
    Row({ space: 24 }) {
      Button() {
        Text('↺')
          .fontSize(22)
          .fontColor('#888888')
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor(Color.White)
      .border({ width: 1, color: '#E0E0E0', radius: 30 })
      .type(ButtonType.Normal)

      Button() {
        Row({ space: 8 }) {
          Text('▶')
            .fontSize(16)
            .fontColor(Color.White)
          Text('Start')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width(140)
      .height(60)
      .borderRadius(30)
      .backgroundColor(primaryColor)
      .type(ButtonType.Normal)

      Button() {
        Text('+')
          .fontSize(24)
          .fontColor('#888888')
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor(Color.White)
      .border({ width: 1, color: '#E0E0E0', radius: 30 })
      .type(ButtonType.Normal)
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .width('100%')
  }
}

@Component
struct PreparationSteps {
  build() {
    Column({ space: 0 }) {
      Text('PREPARATION')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#AAAAAA')
        .margin({ bottom: 12 })

      StepItem({ step: '1', text: 'Boil fresh water to 95°C' })
      Divider()
        .color(backgroundTint)
        .strokeWidth(1)
      StepItem({ step: '2', text: 'Add 1 tsp of loose leaf per cup' })
      Divider()
        .color(backgroundTint)
        .strokeWidth(1)
      StepItem({ step: '3', text: 'Pour water and wait for timer' })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct StepItem {
  step: string = '';
  text: string = '';

  build() {
    Row({ space: 12 }) {
      Text(this.step)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .width(24)
        .height(24)
        .textAlign(TextAlign.Center)
        .backgroundColor(backgroundTint)
        .borderRadius(12)

      Text(this.text)
        .fontSize(14)
        .fontColor('#888888')
        .layoutWeight(1)

      Text('✓')
        .fontSize(12)
        .fontColor(outlineColor)
    }
    .width('100%')
    .padding({ top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Start)
  }
}