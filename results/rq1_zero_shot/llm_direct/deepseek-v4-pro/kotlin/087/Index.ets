import { display } from '@kit.ArkUI';

@Entry
@Component
struct TeaBrewingScreen {
  @State isPlaying: boolean = false;
  @State timerText: string = '02:00';

  // Colors
  private readonly primaryColor: string = '#6D4C41';
  private readonly secondaryColor: string = '#A1887F';
  private readonly lightGray: string = '#F5F5F5';
  private readonly borderColor: string = '#EEEEEE';
  private readonly cardBg: string = '#FAFAFA';
  private readonly white: string = '#FFFFFF';
  private readonly black: string = '#000000';
  private readonly gray: string = '#808080';
  private readonly darkGray: string = '#444444';
  private readonly lightRed: string = '#FFCDD2';
  private readonly iconBg: string = '#EFEBE9';

  build() {
    Column() {
      // Header Section
      this.HeaderSection();

      Blank().height(32);

      // Tea Selection Card
      this.TeaSelectionCard();

      Blank().height(32);

      // Timer Display
      this.TimerDisplay();

      Blank().height(40);

      // Control Buttons
      this.ControlButtons();

      Blank().layoutWeight(1);

      // Preparation Steps
      this.PreparationSteps();
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(this.white)
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Good Morning,')
          .fontSize(14)
          .fontColor(this.gray)
        Text('Tea Master')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.black)
      }
      .alignItems(HorizontalAlign.Start)

      Blank().layoutWeight(1)

      Button() {
        Text('⚙')
          .fontSize(22)
          .fontColor(this.black)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor(this.lightGray)
      .padding(0)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TeaSelectionCard() {
    Row() {
      // Tea Icon
      Column() {
        Text('🍃')
          .fontSize(28)
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor(this.iconBg)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Blank().width(16);

      Column() {
        Text('Earl Grey Reserve')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.black)
        Text('Black Tea • 95°C')
          .fontSize(12)
          .fontColor(this.secondaryColor)
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Text('♥')
        .fontSize(20)
        .fontColor(this.lightRed)
    }
    .width('100%')
    .padding(20)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(this.cardBg)
    .borderRadius(24)
    .border({ width: 1, color: this.borderColor })
  }

  @Builder
  TimerDisplay() {
    Stack() {
      // Progress Ring using Canvas
      Canvas(this.renderTimerRing)
        .width(220)
        .height(220)

      // Inner Content
      Column() {
        Text('STEEPING')
          .fontSize(12)
          .fontColor(this.gray)
          .letterSpacing(2)
        Text(this.timerText)
          .fontSize(48)
          .fontWeight(FontWeight.Light)
          .fontColor(this.black)
          .margin({ top: 8 })
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width(220)
    .height(220)
    .alignContent(Alignment.Center)
  }

  private renderTimerRing = (context: CanvasRenderingContext2D, width: number, height: number) => {
    const centerX = width / 2;
    const centerY = height / 2;
    const radius = Math.min(width, height) / 2 - 6;

    // Background circle
    context.beginPath();
    context.arc(centerX, centerY, radius, 0, 2 * Math.PI);
    context.strokeStyle = '#F5F5F5';
    context.lineWidth = 12;
    context.stroke();

    // Progress arc (240 degrees)
    context.beginPath();
    const startAngle = -Math.PI / 2;
    const endAngle = startAngle + (240 * Math.PI / 180);
    context.arc(centerX, centerY, radius, startAngle, endAngle);
    context.strokeStyle = '#6D4C41';
    context.lineWidth = 12;
    context.lineCap = 'round';
    context.stroke();
  }

  @Builder
  ControlButtons() {
    Row() {
      // Reset Button
      Button() {
        Text('↻')
          .fontSize(24)
          .fontColor(this.gray)
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor(this.white)
      .border({ width: 1, color: '#E0E0E0' })
      .padding(0)

      Blank().width(24);

      // Play/Pause Button
      Button() {
        Row() {
          Text(this.isPlaying ? '⏸' : '▶')
            .fontSize(18)
            .fontColor(this.white)
            .margin({ right: 8 })
          Text(this.isPlaying ? 'Pause' : 'Start')
            .fontSize(16)
            .fontColor(this.white)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width(120)
      .height(60)
      .borderRadius(24)
      .backgroundColor(this.primaryColor)
      .padding(0)
      .onClick(() => {
        this.isPlaying = !this.isPlaying;
      })

      Blank().width(24);

      // Add Note Button
      Button() {
        Text('+')
          .fontSize(24)
          .fontColor(this.gray)
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor(this.white)
      .border({ width: 1, color: '#E0E0E0' })
      .padding(0)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  PreparationSteps() {
    Column() {
      Text('PREPARATION')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#C0C0C0')
        .margin({ bottom: 12 })

      this.StepItem('1', 'Boil fresh water to 95°C');
      this.StepItem('2', 'Add 1 tsp of loose leaf per cup');
      this.StepItem('3', 'Pour water and wait for timer');
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  StepItem(step: string, text: string) {
    Column() {
      Row() {
        Column() {
          Text(step)
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.black)
        }
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(this.lightGray)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        Blank().width(12);

        Text(text)
          .fontSize(14)
          .fontColor(this.darkGray)

        Blank().layoutWeight(1);

        Text('✓')
          .fontSize(14)
          .fontColor(this.borderColor)
      }
      .width('100%')
      .padding({ top: 8, bottom: 8 })
      .alignItems(VerticalAlign.Center)

      Divider()
        .color(this.cardBg)
        .strokeWidth(1)
    }
    .width('100%')
  }
}