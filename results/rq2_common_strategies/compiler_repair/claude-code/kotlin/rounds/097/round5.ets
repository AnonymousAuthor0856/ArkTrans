@Entry
@Component
struct ClimateControllerApp {
  @State targetTemp: number = 21.5;
  @State isActive: boolean = true;
  private trackCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D();
  private arcCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D();

  aboutToAppear(): void {
    this.drawTrack();
    this.drawArc();
  }

  aboutToUpdate(): void {
    this.drawArc();
  }

  drawTrack(): void {
    let ctx: CanvasRenderingContext2D = this.trackCtx;
    ctx.clearRect(0, 0, 240, 240);
    ctx.beginPath();
    ctx.arc(120, 120, 100, Math.PI * 0.75, Math.PI * 2.25);
    ctx.lineWidth = 40;
    ctx.strokeStyle = '#F2F2F7';
    ctx.lineCap = 'round';
    ctx.stroke();
  }

  drawArc(): void {
    let ctx: CanvasRenderingContext2D = this.arcCtx;
    let centerX: number = 120;
    let centerY: number = 120;
    let radius: number = 100;
    let progress: number = (this.targetTemp - 16.0) / (30.0 - 16.0);
    let startAngle: number = Math.PI * 0.75;
    let sweepAngle: number = Math.PI * 1.5 * progress;
    let endAngle: number = startAngle + sweepAngle;
    let arcColor: string = this.isActive ? '#007AFF' : '#8E8E93';

    ctx.clearRect(0, 0, 240, 240);

    ctx.beginPath();
    ctx.arc(centerX, centerY, radius, startAngle, endAngle);
    ctx.lineWidth = 40;
    ctx.strokeStyle = arcColor;
    ctx.lineCap = 'round';
    ctx.stroke();

    let knobX: number = centerX + radius * Math.cos(endAngle);
    let knobY: number = centerY + radius * Math.sin(endAngle);

    ctx.beginPath();
    ctx.arc(knobX, knobY, 16, 0, Math.PI * 2);
    ctx.fillStyle = '#FFFFFF';
    ctx.fill();

    ctx.beginPath();
    ctx.arc(knobX, knobY, 10, 0, Math.PI * 2);
    ctx.fillStyle = arcColor;
    ctx.fill();
  }

  adjustTemp(delta: number): void {
    let newTemp: number = this.targetTemp + delta;
    if (newTemp < 16.0) newTemp = 16.0;
    if (newTemp > 30.0) newTemp = 30.0;
    this.targetTemp = Math.round(newTemp * 10) / 10;
  }

  build() {
    Column() {
      Row() {
        Text('☰')
          .fontSize(24)
          .fontColor('#1C1C1E')
          .padding(12)

        Column() {
          Text('LIVING ROOM')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#8E8E93')
            .letterSpacing(2)
          Text('Connected')
            .fontSize(12)
            .fontColor('#007AFF')
            .margin({ top: 2 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Text('⚙')
          .fontSize(24)
          .fontColor('#1C1C1E')
          .padding(12)
      }
      .width('100%')
      .padding({ top: 16 })
      .alignItems(VerticalAlign.Center)

      Column() {
        Stack() {
          Canvas(this.trackCtx)
            .width(240)
            .height(240)

          Canvas(this.arcCtx)
            .width(240)
            .height(240)

          Column() {
            Text(`${this.targetTemp}°`)
              .fontSize(56)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.isActive ? '#1C1C1E' : '#8E8E93')
            Text(this.isActive ? 'COOLING' : 'OFF')
              .fontSize(14)
              .fontColor('#8E8E93')
              .fontWeight(FontWeight.Medium)
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Center)
        }
        .width(280)
        .height(280)
        .alignContent(Alignment.Center)

        Row() {
          CircleControlButton({
            iconName: 'ic_arrow_down',
            isEnabled: this.isActive,
            onTap: () => this.adjustTemp(-0.5)
          })

          Toggle({ type: ToggleType.Switch, isOn: this.isActive })
            .selectedColor('#1C1C1E')
            .switchPointColor('#FFFFFF')
            .onChange((isOn: boolean): void => {
              this.isActive = isOn;
            })
            .margin({ left: 32, right: 32 })

          CircleControlButton({
            iconName: 'ic_arrow_up',
            isEnabled: this.isActive,
            onTap: () => this.adjustTemp(0.5)
          })
        }
        .margin({ top: 32 })
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .margin({ top: 40 })
      .alignItems(HorizontalAlign.Center)

      Column() {
        Text('QUICK ACTIONS')
          .fontSize(11)
          .fontWeight(FontWeight.Bold)
          .fontColor('#8E8E93')
          .margin({ bottom: 16 })

        Row() {
          QuickActionCard({
            iconName: 'ic_refresh',
            label: 'Fan Speed',
            status: 'Auto',
            isActive: false
          })
          .layoutWeight(1)

          QuickActionCard({
            iconName: 'ic_favorite',
            label: 'Eco Mode',
            status: 'On',
            isActive: true
          })
          .layoutWeight(1)
        }
        .width('100%')

        Row() {
          QuickActionCard({
            iconName: 'ic_info',
            label: 'Timer',
            status: 'Set 2h',
            isActive: false
          })
          .layoutWeight(1)

          QuickActionCard({
            iconName: 'ic_home',
            label: 'Away',
            status: 'Off',
            isActive: false
          })
          .layoutWeight(1)
        }
        .width('100%')
        .margin({ top: 16 })
      }
      .width('100%')
      .margin({ top: 40 })
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct CircleControlButton {
  iconName: string = '';
  isEnabled: boolean = true;
  onTap: () => void = () => {};

  build() {
    Stack() {
      if (this.iconName === 'ic_arrow_up') {
        Text('▲')
          .fontSize(20)
          .fontColor(this.isEnabled ? '#1C1C1E' : '#D1D1D6')
      } else {
        Text('▼')
          .fontSize(20)
          .fontColor(this.isEnabled ? '#1C1C1E' : '#D1D1D6')
      }
    }
    .width(56)
    .height(56)
    .backgroundColor(this.isEnabled ? '#F2F2F7' : '#F9F9F9')
    .border({ width: this.isEnabled ? 0 : 1, color: this.isEnabled ? 'transparent' : '#EEEEEE' })
    .borderRadius(28)
    .onClick((): void => {
      if (this.isEnabled) {
        this.onTap();
      }
    })
    .alignContent(Alignment.Center)
  }
}

@Component
struct QuickActionCard {
  iconName: string = '';
  label: string = '';
  status: string = '';
  isActive: boolean = false;
  @State iconChar: string = '•';

  aboutToAppear(): void {
    if (this.iconName === 'ic_refresh') {
      this.iconChar = '↻';
    } else if (this.iconName === 'ic_favorite') {
      this.iconChar = '♥';
    } else if (this.iconName === 'ic_info') {
      this.iconChar = 'ℹ';
    } else if (this.iconName === 'ic_home') {
      this.iconChar = '⌂';
    } else {
      this.iconChar = '•';
    }
  }

  build() {
    Column() {
      Text(this.iconChar)
        .fontSize(24)
        .fontColor(this.isActive ? '#FFFFFF' : '#1C1C1E')

      Column() {
        Text(this.label)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isActive ? '#FFFFFF' : '#1C1C1E')
        Text(this.status)
          .fontSize(11)
          .fontColor('#8E8E93')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(100)
    .padding(16)
    .backgroundColor(this.isActive ? '#1C1C1E' : '#F2F2F7')
    .borderRadius(20)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }
}
