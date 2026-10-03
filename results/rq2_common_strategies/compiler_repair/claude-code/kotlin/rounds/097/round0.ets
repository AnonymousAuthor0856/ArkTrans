@Entry
@Component
struct ClimateControllerApp {
  @State targetTemp: number = 21.5;
  @State isActive: boolean = true;
  @State animatedProgress: number = 0;

  aboutToAppear() {
    this.animatedProgress = this.calcProgress();
  }

  private calcProgress(): number {
    return (this.targetTemp - 16.0) / (30.0 - 16.0);
  }

  adjustTemp(delta: number) {
    let newTemp = this.targetTemp + delta;
    if (newTemp < 16.0) newTemp = 16.0;
    if (newTemp > 30.0) newTemp = 30.0;
    this.targetTemp = Math.round(newTemp * 10) / 10;
    this.animatedProgress = this.calcProgress();
  }

  build() {
    Column() {
      // Header Section
      Row() {
        Image($r('app.media.ic_menu'))
          .width(24)
          .height(24)
          .fillColor('#FF1C1C1E')
          .padding(12)

        Column() {
          Text('LIVING ROOM')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF8E8E93')
            .letterSpacing(2)
          Text('Connected')
            .fontSize(12)
            .fontColor('#FF007AFF')
            .margin({ top: 2 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Image($r('app.media.ic_settings'))
          .width(24)
          .height(24)
          .fillColor('#FF1C1C1E')
          .padding(12)
      }
      .width('100%')
      .padding({ top: 16 })
      .alignItems(VerticalAlign.Center)

      // Temperature Dial Section
      Column() {
        Stack() {
          // Background circle track
          Canvas(this.trackCanvas)
            .width(240)
            .height(240)

          // Animated arc indicator
          Canvas(this.arcCanvas)
            .width(240)
            .height(240)

          // Center text
          Column() {
            Text(`${this.targetTemp}°`)
              .fontSize(56)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.isActive ? '#FF1C1C1E' : '#FF8E8E93')
            Text(this.isActive ? 'COOLING' : 'OFF')
              .fontSize(14)
              .fontColor('#FF8E8E93')
              .fontWeight(FontWeight.Medium)
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Center)
        }
        .width(280)
        .height(280)
        .alignContent(Alignment.Center)

        // Temperature controls row
        Row() {
          // Down button
          CircleControlButton({
            iconName: 'ic_arrow_down',
            enabled: this.isActive,
            onClick: () => this.adjustTemp(-0.5)
          })

          // Power switch
          Toggle({ type: ToggleType.Switch, isOn: this.isActive })
            .selectedColor('#FF1C1C1E')
            .switchPointColor('#FFFFFFFF')
            .onChange((isOn: boolean) => {
              this.isActive = isOn;
              this.animatedProgress = this.calcProgress();
            })

          // Up button
          CircleControlButton({
            iconName: 'ic_arrow_up',
            enabled: this.isActive,
            onClick: () => this.adjustTemp(0.5)
          })
        }
        .margin({ top: 32 })
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .margin({ top: 40 })
      .alignItems(HorizontalAlign.Center)

      // Control Grid Section
      Column() {
        Text('QUICK ACTIONS')
          .fontSize(11)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF8E8E93')
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
    .backgroundColor('#FFFFFFFF')
    .alignItems(HorizontalAlign.Center)
  }

  private trackCanvas = new CanvasRenderingContext2D();

  aboutToAppear_track() {
    this.trackCanvas.beginPath();
    this.trackCanvas.arc(120, 120, 100, 0, Math.PI * 2);
    this.trackCanvas.lineWidth = 40;
    this.trackCanvas.strokeStyle = '#FFF2F2F7';
    this.trackCanvas.lineCap = 'round';
    this.trackCanvas.stroke();
  }

  private get arcCanvas(): CanvasRenderingContext2D {
    let ctx = new CanvasRenderingContext2D();
    let centerX = 120;
    let centerY = 120;
    let radius = 100;
    let strokeWidth = 40;
    let startAngle = 135 * Math.PI / 180;
    let sweepAngle = 270 * this.animatedProgress * Math.PI / 180;
    let endAngle = startAngle + sweepAngle;

    // Draw arc
    ctx.beginPath();
    ctx.arc(centerX, centerY, radius, startAngle, endAngle);
    ctx.lineWidth = strokeWidth;
    ctx.strokeStyle = this.isActive ? '#FF007AFF' : '#FF8E8E93';
    ctx.lineCap = 'round';
    ctx.stroke();

    // Draw knob
    let knobAngle = endAngle;
    let knobX = centerX + radius * Math.cos(knobAngle);
    let knobY = centerY + radius * Math.sin(knobAngle);

    // Outer white circle
    ctx.beginPath();
    ctx.arc(knobX, knobY, 16, 0, Math.PI * 2);
    ctx.fillStyle = '#FFFFFFFF';
    ctx.fill();

    // Inner colored circle
    ctx.beginPath();
    ctx.arc(knobX, knobY, 10, 0, Math.PI * 2);
    ctx.fillStyle = this.isActive ? '#FF007AFF' : '#FF8E8E93';
    ctx.fill();

    return ctx;
  }
}

@Component
struct CircleControlButton {
  iconName: string = '';
  enabled: boolean = true;
  onClick: () => void = () => {};

  build() {
    Stack() {
      Image($r('app.media.' + this.iconName))
        .width(28)
        .height(28)
        .fillColor(this.enabled ? '#FF1C1C1E' : '#FFD1D1D6')
    }
    .width(56)
    .height(56)
    .backgroundColor(this.enabled ? '#FFF2F2F7' : '#FFF9F9F9')
    .border({ width: this.enabled ? 0 : 1, color: this.enabled ? 'transparent' : '#FFEEEEEE' })
    .borderRadius(28)
    .onClick(() => {
      if (this.enabled) {
        this.onClick();
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

  build() {
    Column() {
      Image($r('app.media.' + this.iconName))
        .width(24)
        .height(24)
        .fillColor(this.isActive ? '#FFFFFFFF' : '#FF1C1C1E')

      Column() {
        Text(this.label)
          .fontSize(12)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(this.isActive ? '#FFFFFFFF' : '#FF1C1C1E')
        Text(this.status)
          .fontSize(11)
          .fontColor('#FF8E8E93')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(100)
    .padding(16)
    .backgroundColor(this.isActive ? '#FF1C1C1E' : '#FFF2F2F7')
    .borderRadius(20)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }
}
