import { display } from '@kit.ArkUI';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct ClimateControllerApp {
  @State targetTemp: number = 21.5;
  @State isActive: boolean = true;
  @State animatedProgress: number = 0.39;
  private animationTimer: number = -1;

  aboutToAppear() {
    this.animateProgress();
  }

  animateProgress() {
    const targetProgress = (this.targetTemp - 16) / 14;
    const startProgress = this.animatedProgress;
    const duration = 500;
    const startTime = Date.now();

    if (this.animationTimer !== -1) {
      clearInterval(this.animationTimer);
    }

    this.animationTimer = setInterval(() => {
      const elapsed = Date.now() - startTime;
      const progress = Math.min(elapsed / duration, 1);
      const eased = 1 - Math.pow(1 - progress, 3);
      this.animatedProgress = startProgress + (targetProgress - startProgress) * eased;

      if (progress >= 1) {
        clearInterval(this.animationTimer);
        this.animationTimer = -1;
      }
    }, 16);
  }

  adjustTemp(delta: number) {
    if (!this.isActive) return;
    const newTemp = Math.round((this.targetTemp + delta) * 10) / 10;
    this.targetTemp = Math.max(16, Math.min(30, newTemp));
    this.animateProgress();
  }

  @Builder
  HeaderSection() {
    Row() {
      Row({ space: 16 }) {
        Text('☰')
          .fontSize(24)
          .fontColor('#1C1C1E')
          .width(40)
          .height(40)
          .textAlign(TextAlign.Center)
          .onClick(() => {})

        Column({ space: 4 }) {
          Text('LIVING ROOM')
            .fontSize(12)
            .fontColor('#8E8E93')
            .fontWeight(FontWeight.Bold)
            .letterSpacing(2)
          Text('Connected')
            .fontSize(11)
            .fontColor('#007AFF')
        }
        .alignItems(HorizontalAlign.Center)

        Text('⚙')
          .fontSize(24)
          .fontColor('#1C1C1E')
          .width(40)
          .height(40)
          .textAlign(TextAlign.Center)
          .onClick(() => {})
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ top: 16 })
    }
  }

  @Builder
  TemperatureDialSection() {
    Column({ space: 32 }) {
      Stack() {
        // Background circle
        Circle()
          .width(240)
          .height(240)
          .fill('#F2F2F7')
          .strokeWidth(40)
          .stroke('#F2F2F7')

        // Arc indicator using Canvas
        Canvas(this.renderArc)
          .width(240)
          .height(240)

        // Center text
        Column({ space: 4 }) {
          Text(`${this.targetTemp.toFixed(1)}°`)
            .fontSize(48)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? '#1C1C1E' : '#8E8E93')
          Text(this.isActive ? 'COOLING' : 'OFF')
            .fontSize(14)
            .fontColor('#8E8E93')
            .fontWeight(FontWeight.Medium)
        }
        .align(Alignment.Center)
      }
      .width(280)
      .height(280)
      .align(Alignment.Center)

      // Controls
      Row({ space: 32 }) {
        // Down button
        Button() {
          Text('−')
            .fontSize(28)
            .fontColor(this.isActive ? '#1C1C1E' : '#D1D1D6')
        }
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor(this.isActive ? '#F2F2F7' : '#F9F9F9')
        .enabled(this.isActive)
        .onClick(() => this.adjustTemp(-0.5))

        // Power switch
        Toggle({ type: ToggleType.Switch, isOn: this.isActive })
          .selectedColor('#1C1C1E')
          .switchPointColor('#FFFFFF')
          .onChange((isOn: boolean) => {
            this.isActive = isOn;
          })

        // Up button
        Button() {
          Text('+')
            .fontSize(28)
            .fontColor(this.isActive ? '#1C1C1E' : '#D1D1D6')
        }
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor(this.isActive ? '#F2F2F7' : '#F9F9F9')
        .enabled(this.isActive)
        .onClick(() => this.adjustTemp(0.5))
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
  }

  private renderArc = (context: CanvasRenderingContext2D) => {
    const width = 240;
    const height = 240;
    const strokeWidth = 40;
    const startAngle = 135;
    const sweepAngle = 270 * this.animatedProgress;
    const centerX = width / 2;
    const centerY = height / 2;
    const radius = width / 2;

    context.clearRect(0, 0, width, height);

    // Draw arc
    context.beginPath();
    context.arc(centerX, centerY, radius, 
      (startAngle * Math.PI) / 180, 
      ((startAngle + sweepAngle) * Math.PI) / 180);
    context.strokeStyle = this.isActive ? '#007AFF' : '#8E8E93';
    context.lineWidth = strokeWidth;
    context.lineCap = 'round';
    context.stroke();

    // Draw knob
    const angleInRadians = ((startAngle + sweepAngle) * Math.PI) / 180;
    const knobX = centerX + radius * Math.cos(angleInRadians);
    const knobY = centerY + radius * Math.sin(angleInRadians);

    context.beginPath();
    context.arc(knobX, knobY, 16, 0, 2 * Math.PI);
    context.fillStyle = '#FFFFFF';
    context.fill();

    context.beginPath();
    context.arc(knobX, knobY, 10, 0, 2 * Math.PI);
    context.fillStyle = this.isActive ? '#007AFF' : '#8E8E93';
    context.fill();
  };

  @Builder
  QuickActionCard(label: string, status: string, icon: string, isActive: boolean = false) {
    Column({ space: 12 }) {
      Text(icon)
        .fontSize(24)
        .fontColor(isActive ? '#FFFFFF' : '#1C1C1E')

      Column({ space: 2 }) {
        Text(label)
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
          .fontColor(isActive ? '#FFFFFF' : '#1C1C1E')
        Text(status)
          .fontSize(11)
          .fontColor('#8E8E93')
      }
    }
    .width('100%')
    .height(100)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(isActive ? '#1C1C1E' : '#F2F2F7')
    .borderRadius(20)
  }

  @Builder
  ControlGridSection() {
    Column({ space: 16 }) {
      Text('QUICK ACTIONS')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#8E8E93')
        .width('100%')

      Row({ space: 16 }) {
        Column() {
          this.QuickActionCard('Fan Speed', 'Auto', '🔄')
        }
        .layoutWeight(1)

        Column() {
          this.QuickActionCard('Eco Mode', 'On', '❤️', true)
        }
        .layoutWeight(1)
      }
      .width('100%')

      Row({ space: 16 }) {
        Column() {
          this.QuickActionCard('Timer', 'Set 2h', '⏱')
        }
        .layoutWeight(1)

        Column() {
          this.QuickActionCard('Away', 'Off', '🏠')
        }
        .layoutWeight(1)
      }
      .width('100%')
    }
    .width('100%')
  }

  build() {
    Column({ space: 40 }) {
      this.HeaderSection()
      this.TemperatureDialSection()
      this.ControlGridSection()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
    .alignItems(HorizontalAlign.Center)
  }
}