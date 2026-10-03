@Entry
@Component
struct ClimateControllerApp {
  @State targetTemp: number = 21.5;
  @State isActive: boolean = true;
  private minTemp: number = 16.0;
  private maxTemp: number = 30.0;

  // Colors
  private readonly PureWhite: ResourceColor = '#FFFFFF';
  private readonly TextBlack: ResourceColor = '#1C1C1E';
  private readonly TextGray: ResourceColor = '#8E8E93';
  private readonly AccentBlue: ResourceColor = '#007AFF';
  private readonly SoftGrayBg: ResourceColor = '#F2F2F7';

  aboutToAppear() {
    // Logic to clamp temperature
  }

  adjustTemp(delta: number) {
    let newTemp = this.targetTemp + delta;
    if (newTemp < this.minTemp) newTemp = this.minTemp;
    if (newTemp > this.maxTemp) newTemp = this.maxTemp;
    // Round to 1 decimal place
    this.targetTemp = Math.round(newTemp * 10) / 10;
  }

  build() {
    Column() {
      // Header Section
      Row() {
        Image('ic_menu') // Placeholder for Menu Icon
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .onClick(() => {})

        Column() {
          Text("LIVING ROOM")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(2)
            .fontColor(this.TextGray)
          Text("Connected")
            .fontSize(14)
            .fontColor(this.AccentBlue)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Center)

        Image('ic_settings') // Placeholder for Settings Icon
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .onClick(() => {})
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ top: 40, left: 24, right: 24 })

      Blank()
        .height(20)

      // Temperature Dial Section
      Column() {
        // The Dial Container
        Stack() {
          // Background Circle (Soft Gray)
          Canvas()
            .onReady((context: CanvasRenderingContext2D, size: Size) => {
              const centerX = size.width / 2;
              const centerY = size.height / 2;
              const radius = (size.width / 2) - 20; // Padding for stroke width
              
              context.beginPath();
              context.arc(centerX, centerY, radius, 0, 2 * Math.PI);
              context.lineWidth = 40;
              context.strokeStyle = '#F2F2F7';
              context.stroke();
            })
            .width(280)
            .height(280)

          // Active Arc Indicator
          Canvas()
            .onReady((context: CanvasRenderingContext2D, size: Size) => {
              const centerX = size.width / 2;
              const centerY = size.height / 2;
              const radius = (size.width / 2) - 20;
              
              // Calculate progress (0 to 1) based on temp range 16-30
              const progress = (this.targetTemp - this.minTemp) / (this.maxTemp - this.minTemp);
              
              // Start angle: 135 degrees (bottom-leftish) -> converted to radians
              // In Canvas, 0 is 3 o'clock. We want to start at roughly 7:30 position.
              // 135 deg in standard math is bottom-left. 
              // Let's map: 135deg start, sweep 270deg total.
              const startAngleDeg = 135;
              const totalSweepDeg = 270;
              const currentSweepDeg = totalSweepDeg * progress;
              
              const startAngleRad = (startAngleDeg * Math.PI) / 180;
              const endAngleRad = ((startAngleDeg + currentSweepDeg) * Math.PI) / 180;

              context.beginPath();
              context.arc(centerX, centerY, radius, startAngleRad, endAngleRad);
              context.lineWidth = 40;
              context.lineCap = 'round';
              context.strokeStyle = this.isActive ? '#007AFF' : '#8E8E93';
              context.stroke();

              // Draw Knob Indicator at the end of the arc
              const knobX = centerX + radius * Math.cos(endAngleRad);
              const knobY = centerY + radius * Math.sin(endAngleRad);

              // Outer white circle
              context.beginPath();
              context.arc(knobX, knobY, 16, 0, 2 * Math.PI);
              context.fillStyle = '#FFFFFF';
              context.fill();

              // Inner colored circle
              context.beginPath();
              context.arc(knobX, knobY, 10, 0, 2 * Math.PI);
              context.fillStyle = this.isActive ? '#007AFF' : '#8E8E93';
              context.fill();
            })
            .width(280)
            .height(280)

          // Center Text
          Column() {
            Text(`${this.targetTemp}°`)
              .fontSize(56)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.isActive ? this.TextBlack : this.TextGray)
            Text(this.isActive ? "COOLING" : "OFF")
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.TextGray)
              .margin({ top: 8 })
          }
          .alignItems(HorizontalAlign.Center)

        }
        .width(280)
        .height(280)

        Blank()
          .height(40)

        // Controls Row
        Row() {
          // Down Button
          Button() {
            Image('ic_arrow_down') // Placeholder
              .width(28)
              .height(28)
              .objectFit(ImageFit.Contain)
          }
          .width(56)
          .height(56)
          .backgroundColor(this.SoftGrayBg)
          .borderRadius(28)
          .enabled(this.isActive)
          .opacity(this.isActive ? 1 : 0.5)
          .onClick(() => this.adjustTemp(-0.5))

          // Power Switch
          Toggle({
            type: ToggleType.Switch,
            isOn: this.isActive
          })
          .width(52)
          .height(32)
          .selectedColor(this.TextBlack) // Track color when active
          .onChange((isOn: boolean) => {
            this.isActive = isOn;
          })

          // Up Button
          Button() {
            Image('ic_arrow_up') // Placeholder
              .width(28)
              .height(28)
              .objectFit(ImageFit.Contain)
          }
          .width(56)
          .height(56)
          .backgroundColor(this.SoftGrayBg)
          .borderRadius(28)
          .enabled(this.isActive)
          .opacity(this.isActive ? 1 : 0.5)
          .onClick(() => this.adjustTemp(0.5))
        }
        .justifyContent(FlexAlign.SpaceEvenly)
        .width('100%')
      }
      .alignItems(HorizontalAlign.Center)

      Blank()
        .height(40)

      // Quick Actions Grid
      Column() {
        Text("QUICK ACTIONS")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.TextGray)
          .margin({ bottom: 16 })

        Row() {
          // Card 1: Fan Speed
          Column() {
            Image('ic_refresh') // Placeholder
              .width(24)
              .height(24)
              .objectFit(ImageFit.Contain)
            
            Text("Fan Speed")
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.TextBlack)
              .margin({ top: 8 })
            
            Text("Auto")
              .fontSize(12)
              .fontColor(this.TextGray)
          }
          .width('48%')
          .height(100)
          .padding(16)
          .backgroundColor(this.SoftGrayBg)
          .borderRadius(20)
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.SpaceBetween)

          // Card 2: Eco Mode (Active)
          Column() {
            Image('ic_favorite') // Placeholder
              .width(24)
              .height(24)
              .objectFit(ImageFit.Contain)
              .fillColor('#FFFFFF') // White icon for dark bg
            
            Text("Eco Mode")
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .margin({ top: 8 })
            
            Text("On")
              .fontSize(12)
              .fontColor(this.TextGray)
          }
          .width('48%')
          .height(100)
          .padding(16)
          .backgroundColor(this.TextBlack)
          .borderRadius(20)
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .width('100%')
        
        // Note: Screenshot only shows one row of cards clearly, but code implies more.
        // Reproducing exactly what is visible in the crop.
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.PureWhite)
  }
}