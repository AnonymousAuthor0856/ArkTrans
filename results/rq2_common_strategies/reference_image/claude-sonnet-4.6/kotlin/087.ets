/*
 * TeaBrewingScreen.ets  —  ArkTS / ArkUI port of the Compose sample
 *
 * Immersive (hidden) system bars — put this in EntryAbility.onWindowStageCreate
 * BEFORE windowStage.loadContent():
 *
 *   const win = windowStage.getMainWindowSync();
 *   win.setWindowLayoutFullScreen(true);
 *   win.setWindowSystemBarEnable([]);
 *   win.setWindowSystemBarProperties({
 *     navigationBarColor: '#FFFFFF',
 *     statusBarContentColor: '#000000'
 *   });
 */

// ---------- palette ----------
const BROWN: string = '#6D4C41';
const BROWN_SOFT: string = '#8D6E63';
const BROWN_TINT: string = '#EFEBE9';
const PINK: string = '#FFCDD2';
const BORDER_GREY: string = '#EEEEEE';
const TRACK_GREY: string = '#F5F5F5';
const CARD_BG: string = '#FAFAFA';
const HAIRLINE: string = '#FAFAFA';
const MUTED: string = '#9E9E9E';
const LABEL_GREY: string = '#BDBDBD';
const TEXT_BODY: string = '#424242';

@Entry
@Component
struct TeaBrewingScreen {
  @State secondsLeft: number = 120;
  @State totalSeconds: number = 120;
  @State running: boolean = false;

  private ringCtx: CanvasRenderingContext2D =
    new CanvasRenderingContext2D(new RenderingContextSettings(true));
  private leafCtx: CanvasRenderingContext2D =
    new CanvasRenderingContext2D(new RenderingContextSettings(true));

  private ringSize: number = 220;
  private strokeW: number = 12;
  private timerId: number = -1;

  // ---------- timer ----------
  private formatTime(): string {
    const m: number = Math.floor(this.secondsLeft / 60);
    const s: number = this.secondsLeft % 60;
    return (m < 10 ? '0' + m : '' + m) + ':' + (s < 10 ? '0' + s : '' + s);
  }

  private toggleTimer(): void {
    if (this.running) {
      this.running = false;
      if (this.timerId !== -1) {
        clearInterval(this.timerId);
        this.timerId = -1;
      }
      return;
    }
    if (this.secondsLeft <= 0) {
      this.secondsLeft = this.totalSeconds;
    }
    this.running = true;
    this.timerId = setInterval(() => {
      if (this.secondsLeft > 0) {
        this.secondsLeft -= 1;
        this.drawRing();
      } else {
        this.running = false;
        clearInterval(this.timerId);
        this.timerId = -1;
      }
    }, 1000);
  }

  private resetTimer(): void {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
    this.running = false;
    this.secondsLeft = this.totalSeconds;
    this.drawRing();
  }

  // ---------- canvas drawing ----------
  private drawRing(): void {
    const ctx = this.ringCtx;
    const c: number = this.ringSize / 2;
    const r: number = c - this.strokeW / 2 - 2;

    ctx.clearRect(0, 0, this.ringSize, this.ringSize);
    ctx.lineWidth = this.strokeW;
    ctx.lineCap = 'round';

    // full track
    ctx.strokeStyle = TRACK_GREY;
    ctx.beginPath();
    ctx.arc(c, c, r, 0, Math.PI * 2);
    ctx.stroke();

    // 240° sweep starting at 12 o'clock, clockwise
    const ratio: number = this.secondsLeft / this.totalSeconds;
    const start: number = -Math.PI / 2;
    const end: number = start + (240 * Math.PI / 180) * ratio;
    ctx.strokeStyle = BROWN;
    ctx.beginPath();
    ctx.arc(c, c, r, start, end);
    ctx.stroke();
  }

  private drawLeafIcon(): void {
    const ctx = this.leafCtx;
    ctx.clearRect(0, 0, 30, 30);
    ctx.lineWidth = 2;
    ctx.strokeStyle = BROWN;

    ctx.beginPath();
    ctx.arc(15, 15, 13, 0, Math.PI * 2);
    ctx.stroke();

    ctx.beginPath();
    ctx.moveTo(15, 7.5);
    ctx.lineTo(15, 22.5);
    ctx.stroke();
  }

  // ---------- UI blocks ----------
  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Good Morning,')
          .fontSize(14)
          .fontColor(MUTED)
        Text('Tea Master')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Stack() {
        Text('⚙')
          .fontSize(22)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
      .backgroundColor(TRACK_GREY)
      .borderRadius(24)
      .onClick(() => {
        // open settings
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TeaSelectionCard() {
    Row() {
      Stack() {
        Canvas(this.leafCtx)
          .width(30)
          .height(30)
          .onReady(() => {
            this.drawLeafIcon();
          })
      }
      .width(60)
      .height(60)
      .backgroundColor(BROWN_TINT)
      .borderRadius(30)

      Column() {
        Text('Earl Grey Reserve')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text('Black Tea · 95°C')
          .fontSize(12)
          .fontColor(BROWN_SOFT)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })

      Text('♥')
        .fontSize(20)
        .fontColor(PINK)
    }
    .width('100%')
    .padding(20)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(CARD_BG)
    .borderRadius(24)
    .border({ width: 1, color: BORDER_GREY })
  }

  @Builder
  TimerDisplay() {
    Stack() {
      Canvas(this.ringCtx)
        .width(this.ringSize)
        .height(this.ringSize)
        .onReady(() => {
          this.drawRing();
        })

      Column() {
        Text('Steeping')
          .fontSize(12)
          .fontColor(MUTED)
          .letterSpacing(2)
        Text(this.formatTime())
          .fontSize(45)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Color.Black)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(this.ringSize)
    .height(this.ringSize)
  }

  @Builder
  ControlButtons() {
    Row() {
      // reset
      Stack() {
        Text('↻')
          .fontSize(22)
          .fontColor(MUTED)
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .border({ width: 1, color: '#E0E0E0' })
      .onClick(() => {
        this.resetTimer();
      })

      Blank().width(24)

      // start / pause
      Button() {
        Row() {
          Text(this.running ? '⏸' : '▶')
            .fontSize(16)
            .fontColor(Color.White)
            .margin({ right: 8 })
          Text(this.running ? 'Pause' : 'Start')
            .fontSize(16)
            .fontColor(Color.White)
        }
        .alignItems(VerticalAlign.Center)
      }
      .width(120)
      .height(60)
      .borderRadius(24)
      .backgroundColor(BROWN)
      .onClick(() => {
        this.toggleTimer();
      })

      Blank().width(24)

      // add note
      Stack() {
        Text('+')
          .fontSize(24)
          .fontColor(MUTED)
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .border({ width: 1, color: '#E0E0E0' })
      .onClick(() => {
        // add note
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  StepItem(step: string, label: string) {
    Column() {
      Row() {
        Stack() {
          Text(step)
            .fontSize(11)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }
        .width(24)
        .height(24)
        .backgroundColor(TRACK_GREY)
        .borderRadius(12)

        Text(label)
          .fontSize(14)
          .fontColor(TEXT_BODY)
          .margin({ left: 12 })

        Blank()

        Text('✓')
          .fontSize(14)
          .fontColor(BORDER_GREY)
      }
      .width('100%')
      .padding({ top: 8, bottom: 8 })
      .alignItems(VerticalAlign.Center)

      Divider()
        .color(HAIRLINE)
        .strokeWidth(1)
    }
    .width('100%')
  }

  @Builder
  PreparationSteps() {
    Column() {
      Text('PREPARATION')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(LABEL_GREY)
        .letterSpacing(1)
        .width('100%')
        .margin({ bottom: 4 })

      this.StepItem('1', 'Boil fresh water to 95°C')
      this.StepItem('2', 'Add 1 tsp of loose leaf per cup')
      this.StepItem('3', 'Pour water and wait for timer')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      this.HeaderSection()

      this.TeaSelectionCard()
        .margin({ top: 32 })

      this.TimerDisplay()
        .margin({ top: 32 })

      this.ControlButtons()
        .margin({ top: 40 })

      Blank()
        .layoutWeight(1)

      this.PreparationSteps()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
  }

  aboutToDisappear(): void {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }
}