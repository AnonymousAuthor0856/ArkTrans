import { window } from '@kit.ArkUI';

interface DialColors {
  pureWhite: Color;
  textBlack: Color;
  textGray: Color;
  accentBlue: Color;
  softGrayBg: Color;
}

interface ControlColors {
  pureWhite: Color;
  textBlack: Color;
  textGray: Color;
  softGrayBg: Color;
}

@Entry
@Component
struct ClimateControllerApp {
  @State targetTemp: number = 21.5;
  @State isActive: boolean = true;
  
  // Constants
  private readonly PURE_WHITE: Color = '#FFFFFF';
  private readonly TEXT_BLACK: Color = '#1C1C1E';
  private readonly TEXT_GRAY: Color = '#8E8E93';
  private readonly ACCENT_BLUE: Color = '#007AFF';
  private readonly SOFT_GRAY_BG: Color = '#F2F2F7';
  private readonly ACTIVE_ORANGE: Color = '#FF9500';
  private readonly MIN_TEMP: number = 16.0;
  private readonly MAX_TEMP: number = 30.0;

  aboutToAppear() {
    this.hideSystemBars();
  }

  private hideSystemBars() {
    try {
      const context = getContext(this);
      const windowClass: window.Window = (context as Context).getWindowSync();
      windowClass.setWindowLayoutFullScreen(true);
      windowClass.setWindowSystemBarProperties({
        statusBarColor: '#00000000',
        navigationBarColor: '#00000000',
        statusBarContentColor: '#FFFFFFFF',
        navigationBarContentColor: '#FFFFFFFF'
      });
    } catch (e) {
      console.error('Failed to set immersive mode');
    }
  }

  private adjustTemp(delta: number): void {
    let newTemp = this.targetTemp + delta;
    if (newTemp < this.MIN_TEMP) newTemp = this.MIN_TEMP;
    if (newTemp > this.MAX_TEMP) newTemp = this.MAX_TEMP;
    // Round to 1 decimal place
    this.targetTemp = Math.round(newTemp * 10) / 10;
  }

  build() {
    Column() {
      HeaderSection()
      
      Spacer().height(40)
      
      TemperatureDialSection({
        targetTemp: $targetTemp,
        isActive: $isActive,
        adjustTemp: (delta: number) => this.adjustTemp(delta),
        colors: {
          pureWhite: this.PURE_WHITE,
          textBlack: this.TEXT_BLACK,
          textGray: this.TEXT_GRAY,
          accentBlue: this.ACCENT_BLUE,
          softGrayBg: this.SOFT_GRAY_BG
        }
      })
      
      Spacer().height(40)
      
      ControlGridSection({
        isActive: $isActive,
        colors: {
          pureWhite: this.PURE_WHITE,
          textBlack: this.TEXT_BLACK,
          textGray: this.TEXT_GRAY,
          softGrayBg: this.SOFT_GRAY_BG
        }
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.PURE_WHITE)
    .padding({ left: 24, right: 24 })
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      // Menu Icon
      Button() {
        Image($r('app.media.ic_menu')) // Placeholder for menu icon
          .width(24)
          .height(24)
          .fillColor('#1C1C1E')
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)
      .borderWidth(0)
      
      Column() {
        Text("LIVING ROOM")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
          .fontColor('#8E8E93')
        
        Text("Connected")
          .fontSize(12)
          .fontColor('#007AFF')
      }
      .alignItems(HorizontalAlign.Center)
      
      // Settings Icon
      Button() {
        Image($r('app.media.ic_settings')) // Placeholder for settings icon
          .width(24)
          .height(24)
          .fillColor('#1C1C1E')
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)
      .borderWidth(0)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ top: 16 })
  }
}

@Component
struct TemperatureDialSection {
  @Link targetTemp: number;
  @Link isActive: boolean;
  @Prop adjustTemp: (delta: number) => void;
  @Prop colors: DialColors;

  build() {
    Column() {
      // Dial Container
      Stack() {
        // Background Circle
        CanvasRenderingContext2D()
          .draw((context: CanvasRenderingContext2D, size: Size) => {
            context.beginPath();
            context.arc(size.width / 2, size.height / 2, size.width / 2 - 20, 0, 2 * Math.PI);
            context.lineWidth = 40;
            context.strokeStyle = '#F2F2F7';
            context.stroke();
          })
          .width(240)
          .height(240)

        // Animated Arc
        CanvasRenderingContext2D()
          .draw((context: CanvasRenderingContext2D, size: Size) => {
            const progress = (this.targetTemp - 16) / (30 - 16);
            const startAngle = 135 * Math.PI / 180;
            const sweepAngle = 270 * Math.PI / 180 * progress;
            
            context.beginPath();
            context.arc(size.width / 2, size.height / 2, size.width / 2 - 20, startAngle, startAngle + sweepAngle);
            context.lineWidth = 40;
            context.lineCap = 'round';
            context.strokeStyle = this.isActive ? '#007AFF' : '#8E8E93';
            context.stroke();

            // Knob Indicator
            const knobAngle = startAngle + sweepAngle;
            const radius = size.width / 2 - 20;
            const centerX = size.width / 2;
            const centerY = size.height / 2;
            const knobX = centerX + radius * Math.cos(knobAngle);
            const knobY = centerY + radius * Math.sin(knobAngle);

            context.beginPath();
            context.arc(knobX, knobY, 16, 0, 2 * Math.PI);
            context.fillStyle = '#FFFFFF';
            context.fill();

            context.beginPath();
            context.arc(knobX, knobY, 10, 0, 2 * Math.PI);
            context.fillStyle = this.isActive ? '#007AFF' : '#8E8E93';
            context.fill();
          })
          .width(240)
          .height(240)

        // Center Text
        Column() {
          Text(`${this.targetTemp}°`)
            .fontSize(48)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? '#1C1C1E' : '#8E8E93')
          
          Text(this.isActive ? "COOLING" : "OFF")
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#8E8E93')
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(280)
      .height(280)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      Spacer().height(32)

      // Controls Row
      Row() {
        RoundControlButton({
          iconType: 'down',
          onClick: () => this.adjustTemp(-0.5),
          enabled: this.isActive,
          colors: this.colors
        })

        Toggle({ type: ToggleType.Switch })
          .switchStyle(SwitchStyle.Outline)
          .selected(this.isActive)
          .onChange((isOn: boolean) => {
            this.isActive = isOn;
          })
          .width(51)
          .height(31)
          .backgroundColor(this.isActive ? '#1C1C1E' : '#F2F2F7')
          .borderWidth(this.isActive ? 0 : 1)
          .borderColor(this.isActive ? Color.Transparent : '#E5E5EA')

        RoundControlButton({
          iconType: 'up',
          onClick: () => this.adjustTemp(0.5),
          enabled: this.isActive,
          colors: this.colors
        })
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct RoundControlButton {
  @Prop iconType: string;
  @Prop onClick: () => void;
  @Prop enabled: boolean;
  @Prop colors: DialColors;

  build() {
    Button() {
      Image(this.iconType === 'up' ? $r('app.media.ic_arrow_up') : $r('app.media.ic_arrow_down'))
        .width(28)
        .height(28)
        .fillColor(this.enabled ? '#1C1C1E' : '#D1D1D6')
    }
    .width(56)
    .height(56)
    .backgroundColor(this.enabled ? '#F2F2F7' : '#F9F9F9')
    .borderRadius(28)
    .onClick(() => {
      if (this.enabled) {
        this.onClick();
      }
    })
    .enabled(this.enabled)
  }
}

@Component
struct ControlGridSection {
  @Link isActive: boolean;
  @Prop colors: ControlColors;

  build() {
    Column() {
      Text("QUICK ACTIONS")
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor('#8E8E93')
        .margin({ bottom: 16 })

      Row() {
        QuickActionCard({
          label: "Fan Speed",
          status: "Auto",
          isActive: false,
          colors: this.colors
        })
        .layoutWeight(1)
        
        QuickActionCard({
          label: "Eco Mode",
          status: "On",
          isActive: true,
          colors: this.colors
        })
        .layoutWeight(1)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ bottom: 16 })

      Row() {
        QuickActionCard({
          label: "Timer",
          status: "Set 2h",
          isActive: false,
          colors: this.colors
        })
        .layoutWeight(1)
        
        QuickActionCard({
          label: "Away",
          status: "Off",
          isActive: false,
          colors: this.colors
        })
        .layoutWeight(1)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
  }
}

@Component
struct QuickActionCard {
  @Prop label: string;
  @Prop status: string;
  @Prop isActive: boolean;
  @Prop colors: ControlColors;

  build() {
    Column() {
      // Icon Placeholder
      Image($r('app.media.ic_placeholder'))
        .width(24)
        .height(24)
        .fillColor(this.isActive ? '#FFFFFF' : '#1C1C1E')
      
      Column() {
        Text(this.label)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isActive ? '#FFFFFF' : '#1C1C1E')
        
        Text(this.status)
          .fontSize(12)
          .fontColor('#8E8E93')
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(100)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(this.isActive ? '#1C1C1E' : '#F2F2F7')
    .borderRadius(20)
  }
}