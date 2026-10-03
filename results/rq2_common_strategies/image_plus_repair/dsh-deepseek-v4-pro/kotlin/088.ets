// Translated from Kotlin Jetpack Compose source 088.kt -> ArkTS/ArkUI
// ZenBreather breathing application

interface BreathingPattern {
  name: string;
  inhale: number;
  exhale: number;
}

@Component
struct BreathVisualizer {
  @Prop isPlaying: boolean = false;
  @Prop durationSum: number = 10;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  private scaleFactor: number = 1;
  private rotationAngle: number = 0;
  private timerId: number = -1;
  private startTime: number = 0;
  private wasPlaying: boolean = false;

  aboutToAppear(): void {
    this.timerId = setInterval(() => {
      this.tick();
    }, 30);
  }

  aboutToDisappear(): void {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }

  private tick(): void {
    if (this.isPlaying) {
      if (!this.wasPlaying) {
        this.startTime = Date.now();
      }
      const elapsed: number = Date.now() - this.startTime;
      const period: number = this.durationSum * 1000;
      const progress: number = (elapsed % period) / period;
      this.scaleFactor = 1 - 0.2 * Math.cos(progress * Math.PI * 2);
      this.rotationAngle = ((elapsed % 20000) / 20000) * 360;
    } else {
      this.scaleFactor = 1;
      this.rotationAngle = 0;
    }
    this.wasPlaying = this.isPlaying;
    this.draw();
  }

  private draw(): void {
    const w: number = this.ctx.width;
    const h: number = this.ctx.height;
    this.ctx.clearRect(0, 0, w, h);
    const radius: number = Math.min(w, h) / 2.5;
    this.ctx.save();
    this.ctx.translate(w / 2, h / 2);
    this.ctx.rotate(this.rotationAngle * Math.PI / 180);
    this.ctx.scale(this.scaleFactor, this.scaleFactor);

    this.ctx.beginPath();
    this.ctx.arc(0, 0, radius, 0, Math.PI * 2);
    this.ctx.fillStyle = "rgba(0,137,123,0.1)";
    this.ctx.fill();

    this.ctx.beginPath();
    this.ctx.arc(0, 0, radius, 0, Math.PI * 2);
    this.ctx.strokeStyle = "#00897B";
    this.ctx.lineWidth = 4;
    this.ctx.stroke();

    const petalCount: number = 8;
    const angleStep: number = 360 / petalCount;
    for (let i = 0; i < petalCount; i++) {
      const angle: number = i * angleStep;
      const rad: number = angle * Math.PI / 180;
      const endX: number = radius * 0.7 * Math.cos(rad);
      const endY: number = radius * 0.7 * Math.sin(rad);
      this.ctx.beginPath();
      this.ctx.moveTo(0, 0);
      this.ctx.lineTo(endX, endY);
      this.ctx.strokeStyle = "rgba(0,137,123,0.4)";
      this.ctx.lineWidth = 2;
      this.ctx.lineCap = "round";
      this.ctx.stroke();
      this.ctx.beginPath();
      this.ctx.arc(endX, endY, 6, 0, Math.PI * 2);
      this.ctx.fillStyle = "#00897B";
      this.ctx.fill();
    }
    this.ctx.restore();
  }

  build() {
    Canvas(this.ctx)
      .width("100%")
      .height("100%")
      .onReady(() => {
        this.draw();
      })
  }
}

@Entry
@Component
struct ZenBreatherPage {
  @State selectedPatternIndex: number = 0;
  @State isPlaying: boolean = false;
  private patterns: BreathingPattern[] = [
    { name: "Relax", inhale: 4, exhale: 6 },
    { name: "Balance", inhale: 5, exhale: 5 },
    { name: "Focus", inhale: 4, exhale: 4 }
  ];

  private currentPattern(): BreathingPattern {
    return this.patterns[this.selectedPatternIndex];
  }

  @Builder
  PatternCardBuilder(pattern: BreathingPattern, index: number) {
    Stack({ alignContent: Alignment.Center }) {
      Column() {
        if (index === this.selectedPatternIndex) {
          Text("✓")
            .fontSize(16)
            .fontColor("#00897B")
            .margin({ bottom: 4 })
        }
        Text(pattern.name)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(index === this.selectedPatternIndex ? "#00897B" : "#2D2D2D")
        Text(pattern.inhale + "-" + pattern.exhale)
          .fontSize(12)
          .fontColor("#9E9E9E")
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(100)
    .height(90)
    .borderRadius(20)
    .backgroundColor(index === this.selectedPatternIndex ? "rgba(0,137,123,0.05)" : "#F5F5F5")
    .border({
      width: 2,
      color: index === this.selectedPatternIndex ? "#00897B" : "#00000000",
      radius: 20
    })
    .padding(12)
    .onClick(() => {
      this.selectedPatternIndex = index;
      this.isPlaying = false;
    })
  }

  @Builder
  PlayPauseButtonBuilder() {
    Button() {
      Row() {
        Text(this.isPlaying ? "STOP SESSION" : "START BREATHING")
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(1)
          .fontColor("#FFFFFF")
        if (!this.isPlaying) {
          Text("▶")
            .fontSize(20)
            .fontColor("#FFFFFF")
            .margin({ left: 8 })
        }
      }
      .alignItems(VerticalAlign.Center)
    }
    .height(64)
    .width("100%")
    .borderRadius(32)
    .backgroundColor("#2D2D2D")
    .onClick(() => {
      this.isPlaying = !this.isPlaying;
    })
  }

  build() {
    Column() {
      Column() {
        Blank().height(48)

        Row() {
          Text("ZenBreather")
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(-1)
            .fontColor("#2D2D2D")
          Text("⚙")
            .fontSize(24)
            .fontColor("#9E9E9E")
        }
        .width("100%")
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Blank().height(60)

        Stack({ alignContent: Alignment.Center }) {
          BreathVisualizer({
            isPlaying: this.isPlaying,
            durationSum: this.currentPattern().inhale + this.currentPattern().exhale
          })
          Column() {
            Text(this.isPlaying ? "Breathe" : "Ready")
              .fontSize(24)
              .fontColor("#00897B")
              .fontWeight(FontWeight.Medium)
            Text(this.currentPattern().inhale + "s In / " + this.currentPattern().exhale + "s Out")
              .fontSize(14)
              .fontColor("#9E9E9E")
          }
          .alignItems(HorizontalAlign.Center)
        }
        .width(280)
        .height(280)

        Blank().layoutWeight(1)

        Text("Select Rhythm")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .width("100%")

        Blank().height(16)

        Row() {
          ForEach(this.patterns, (pattern: BreathingPattern, index: number) => {
            this.PatternCardBuilder(pattern, index)
          }, (pattern: BreathingPattern, index: number) => index + "_" + pattern.name)
        }
        .width("100%")
        .justifyContent(FlexAlign.SpaceBetween)

        Blank().height(32)
      }
      .width("100%")
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .padding({ left: 24, right: 24 })

      Row() {
        this.PlayPauseButtonBuilder()
      }
      .width("100%")
      .justifyContent(FlexAlign.Center)
      .padding(32)
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#FFFFFF")
  }
}
