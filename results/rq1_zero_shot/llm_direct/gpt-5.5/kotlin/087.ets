import window from '@ohos.window';

@Entry
@Component
struct TeaBrewingScreen {
  aboutToAppear(): void {
    window.getLastWindow(getContext(this), (err, win) => {
      if (err.code === 0) {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      }
    });
  }

  build() {
    Column() {
      HeaderSection()

      Blank().height(32)

      TeaSelectionCard()

      Blank().height(32)

      TimerDisplay({ time: '02:00' })

      Blank().height(40)

      ControlButtons()

      Blank().layoutWeight(1)

      PreparationSteps()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('Good Morning,')
          .fontSize(14)
          .fontColor(Color.Gray)

        Text('Tea Master')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      Button() {
        Text('⚙')
          .fontSize(22)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .padding(0)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TeaSelectionCard {
  build() {
    Row() {
      Stack() {
        TeaLeafCanvas()
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor('#EFEBE9')
      .alignContent(Alignment.Center)

      Blank().width(16)

      Column() {
        Text('Earl Grey Reserve')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Text('Black Tea • 95°C')
          .fontSize(12)
          .fontColor('#8D6E63')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('♥')
        .fontSize(24)
        .fontColor('#FFCDD2')
    }
    .width('100%')
    .padding(20)
    .borderRadius(24)
    .border({
      width: 1,
      color: '#EEEEEE'
    })
    .backgroundColor('#FAFAFA')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TeaLeafCanvas {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Canvas(this.context)
      .width(30)
      .height(30)
      .onReady(() => {
        this.context.clearRect(0, 0, 30, 30);
        this.context.strokeStyle = '#6D4C41';
        this.context.lineWidth = 2;

        this.context.beginPath();
        this.context.arc(15, 15, 14, 0, Math.PI * 2);
        this.context.stroke();

        this.context.beginPath();
        this.context.lineCap = 'round';
        this.context.moveTo(15, 7.5);
        this.context.lineTo(15, 22.5);
        this.context.stroke();
      })
  }
}

@Component
struct TimerDisplay {
  @Prop time: string;

  build() {
    Stack() {
      TimerCanvas()

      Column() {
        Text('Steeping')
          .fontSize(13)
          .fontColor(Color.Gray)
          .letterSpacing(2)

        Text(this.time)
          .fontSize(46)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(220)
    .height(220)
    .alignContent(Alignment.Center)
  }
}

@Component
struct TimerCanvas {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Canvas(this.context)
      .width(220)
      .height(220)
      .onReady(() => {
        const center: number = 110;
        const radius: number = 104;

        this.context.clearRect(0, 0, 220, 220);

        this.context.strokeStyle = '#F5F5F5';
        this.context.lineWidth = 12;
        this.context.beginPath();
        this.context.arc(center, center, radius, 0, Math.PI * 2);
        this.context.stroke();

        this.context.strokeStyle = '#6D4C41';
        this.context.lineWidth = 12;
        this.context.lineCap = 'round';
        this.context.beginPath();
        this.context.arc(center, center, radius, -Math.PI / 2, -Math.PI / 2 + Math.PI * 4 / 3);
        this.context.stroke();
      })
  }
}

@Component
struct ControlButtons {
  build() {
    Row() {
      Button() {
        Text('↻')
          .fontSize(24)
          .fontColor(Color.Gray)
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .padding(0)
      .backgroundColor(Color.Transparent)
      .border({
        width: 1,
        color: '#E0E0E0'
      })

      Blank().width(24)

      Button() {
        Row() {
          Text('▶')
            .fontSize(18)
            .fontColor(Color.White)

          Blank().width(8)

          Text('Start')
            .fontSize(16)
            .fontColor(Color.White)
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
      }
      .width(120)
      .height(60)
      .borderRadius(24)
      .backgroundColor('#6D4C41')

      Blank().width(24)

      Button() {
        Text('+')
          .fontSize(28)
          .fontColor(Color.Gray)
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .padding(0)
      .backgroundColor(Color.Transparent)
      .border({
        width: 1,
        color: '#E0E0E0'
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct PreparationSteps {
  build() {
    Column() {
      Text('PREPARATION')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Grey)
        .margin({ bottom: 12 })
        .alignSelf(ItemAlign.Start)

      StepItem({
        step: '1',
        text: 'Boil fresh water to 95°C'
      })

      StepItem({
        step: '2',
        text: 'Add 1 tsp of loose leaf per cup'
      })

      StepItem({
        step: '3',
        text: 'Pour water and wait for timer'
      })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct StepItem {
  @Prop step: string;
  @Prop text: string;

  build() {
    Column() {
      Row() {
        Stack() {
          Text(this.step)
            .fontSize(11)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
        }
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor('#F5F5F5')
        .alignContent(Alignment.Center)

        Blank().width(12)

        Text(this.text)
          .fontSize(14)
          .fontColor('#444444')

        Blank().layoutWeight(1)

        Text('✓')
          .fontSize(16)
          .fontColor('#EEEEEE')
      }
      .width('100%')
      .padding({ top: 8, bottom: 8 })
      .alignItems(VerticalAlign.Center)

      Divider()
        .width('100%')
        .height(1)
        .color('#FAFAFA')
    }
    .width('100%')
  }
}