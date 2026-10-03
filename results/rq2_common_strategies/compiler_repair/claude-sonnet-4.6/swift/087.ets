class TeaColorSet {
  primary: string = '#6D4C41';
  secondary: string = '#A1887F';
  surfaceVariant: string = '#FAFAFA';
  outline: string = '#EEEEEE';
  backgroundTint: string = '#F5F5F5';
  teaLeafDetail: string = '#8D6E63';
  favoriteTint: string = '#FFCDD2';
  textSecondary: string = '#9E9E9E';
  textPrimary: string = '#000000';
  leafCircleBg: string = '#EFEBE9';
  divider: string = '#EEEEEE';
  resetBorder: string = '#E0E0E0';
}

const TeaColors = new TeaColorSet();

@Entry
@Component
struct TeaBrewingScreen {
  build() {
    Stack() {
      Scroll() {
        Column({ space: 0 }) {
          HeaderSection()
            .margin({ top: 48, bottom: 32 })

          TeaSelectionCard()
            .margin({ bottom: 32 })

          TimerDisplay()
            .margin({ bottom: 40 })

          ControlButtons()
            .margin({ bottom: 32 })

          PreparationSteps()
            .margin({ bottom: 24 })
        }
        .padding({ left: 24, right: 24 })
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
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
          .fontColor(TeaColors.textSecondary)
          .fontWeight(FontWeight.Normal)
        Text('Tea Master')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(TeaColors.textPrimary)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Text('⚙')
          .fontSize(22)
          .fontColor(TeaColors.textPrimary)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor(TeaColors.backgroundTint)
      .type(ButtonType.Circle)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TeaSelectionCard {
  private leafSettings: RenderingContextSettings = new RenderingContextSettings(true);
  private leafContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.leafSettings);

  build() {
    Row({ space: 16 }) {
      Stack() {
        Circle()
          .fill(TeaColors.leafCircleBg)
          .width(60)
          .height(60)

        Canvas(this.leafContext)
          .width(30)
          .height(30)
          .onReady(() => {
            const w: number = 30;
            const h: number = 30;
            const cx: number = w / 2;
            const cy: number = h / 2;
            const r: number = Math.min(w, h) / 2 - 1;

            this.leafContext.beginPath();
            this.leafContext.arc(cx, cy, r, 0, Math.PI * 2);
            this.leafContext.strokeStyle = TeaColors.primary;
            this.leafContext.lineWidth = 2;
            this.leafContext.stroke();

            this.leafContext.beginPath();
            this.leafContext.moveTo(cx, h / 4);
            this.leafContext.lineTo(cx, h * 0.75);
            this.leafContext.strokeStyle = TeaColors.primary;
            this.leafContext.lineWidth = 2;
            this.leafContext.lineCap = 'round';
            this.leafContext.stroke();
          })
      }
      .width(60)
      .height(60)

      Column({ space: 2 }) {
        Text('Earl Grey Reserve')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(TeaColors.textPrimary)
        Text('Black Tea • 95°C')
          .fontSize(12)
          .fontColor(TeaColors.teaLeafDetail)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('♥')
        .fontSize(22)
        .fontColor(TeaColors.favoriteTint)
    }
    .width('100%')
    .padding(20)
    .backgroundColor(TeaColors.surfaceVariant)
    .borderRadius(24)
    .border({ width: 1, color: TeaColors.outline, radius: 24 })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TimerDisplay {
  private timerSettings: RenderingContextSettings = new RenderingContextSettings(true);
  private timerContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.timerSettings);

  build() {
    Stack() {
      Canvas(this.timerContext)
        .width(220)
        .height(220)
        .onReady(() => {
          const cx: number = 110;
          const cy: number = 110;
          const r: number = 104;

          this.timerContext.beginPath();
          this.timerContext.arc(cx, cy, r, 0, Math.PI * 2);
          this.timerContext.strokeStyle = TeaColors.backgroundTint;
          this.timerContext.lineWidth = 12;
          this.timerContext.stroke();

          const startAngle: number = (-210 * Math.PI) / 180;
          const endAngle: number = startAngle + (0.66 * 2 * Math.PI);
          this.timerContext.beginPath();
          this.timerContext.arc(cx, cy, r, startAngle, endAngle);
          this.timerContext.strokeStyle = TeaColors.primary;
          this.timerContext.lineWidth = 12;
          this.timerContext.lineCap = 'round';
          this.timerContext.stroke();
        })

      Column({ space: 4 }) {
        Text('Steeping')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(TeaColors.textSecondary)
          .letterSpacing(2)
        Text('02:00')
          .fontSize(45)
          .fontWeight(FontWeight.Lighter)
          .fontColor(TeaColors.textPrimary)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(220)
    .height(220)
    .alignContent(Alignment.Center)
  }
}

@Component
struct ControlButtons {
  build() {
    Row({ space: 24 }) {
      Button() {
        Text('↺')
          .fontSize(24)
          .fontColor(TeaColors.textSecondary)
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor(Color.White)
      .border({ width: 1, color: TeaColors.resetBorder, radius: 30 })
      .type(ButtonType.Circle)

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
        .alignItems(VerticalAlign.Center)
      }
      .width(120)
      .height(60)
      .borderRadius(24)
      .backgroundColor(TeaColors.primary)
      .type(ButtonType.Normal)

      Button() {
        Text('+')
          .fontSize(26)
          .fontColor(TeaColors.textSecondary)
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor(Color.White)
      .border({ width: 1, color: TeaColors.resetBorder, radius: 30 })
      .type(ButtonType.Circle)
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct PreparationSteps {
  build() {
    Column({ space: 0 }) {
      Text('PREPARATION')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#9E9E9E')
        .margin({ bottom: 12 })

      StepItem({ step: '1', text: 'Boil fresh water to 95°C' })

      Divider()
        .color(TeaColors.backgroundTint)
        .strokeWidth(1)

      StepItem({ step: '2', text: 'Add 1 tsp of loose leaf per cup' })

      Divider()
        .color(TeaColors.backgroundTint)
        .strokeWidth(1)

      StepItem({ step: '3', text: 'Pour water and wait for timer' })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct StepItem {
  step: string = '';
  text: string = '';

  build() {
    Row({ space: 12 }) {
      Stack() {
        Circle()
          .fill(TeaColors.backgroundTint)
          .width(24)
          .height(24)
        Text(this.step)
          .fontSize(11)
          .fontWeight(FontWeight.Bold)
          .fontColor(TeaColors.textPrimary)
      }
      .width(24)
      .height(24)
      .alignContent(Alignment.Center)

      Text(this.text)
        .fontSize(14)
        .fontColor(TeaColors.textSecondary)
        .layoutWeight(1)

      Text('✓')
        .fontSize(12)
        .fontColor(TeaColors.outline)
    }
    .width('100%')
    .padding({ top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)
  }
}