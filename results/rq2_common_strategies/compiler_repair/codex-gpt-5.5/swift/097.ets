@Entry
@Component
struct Index {
  @State targetTemp: number = 21.5
  @State isActive: boolean = true

  private readonly pureWhite: string = '#FFFFFF'
  private readonly textBlack: string = '#1C1C1E'
  private readonly textGray: string = '#8E8E93'
  private readonly accentBlue: string = '#007AFF'
  private readonly softGrayBg: string = '#F2F2F7'
  private readonly lightGrayBg: string = '#F9F9F9'
  private readonly lightBorderGray: string = '#EEEEEE'
  private readonly disabledIconGray: string = '#D1D1D6'

  private adjustTemp(delta: number): void {
    let newTemp = this.targetTemp + delta
    if (newTemp < 16.0) {
      newTemp = 16.0
    }
    if (newTemp > 30.0) {
      newTemp = 30.0
    }
    this.targetTemp = Math.round(newTemp * 10) / 10
  }

  private progressValue(): number {
    return ((this.targetTemp - 16.0) / (30.0 - 16.0)) * 100
  }

  build() {
    Column() {
      this.HeaderSection()
      Blank().height(40)
      this.TemperatureDialSection()
      Blank().height(40)
      this.ControlGridSection()
      Blank()
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24, top: 16 })
    .backgroundColor(this.pureWhite)
  }

  @Builder
  HeaderSection() {
    Row() {
      Button() {
        Text('☰')
          .fontSize(28)
          .fontColor(this.textBlack)
      }
      .backgroundColor(Color.Transparent)
      Blank()
      Column() {
        Text('LIVING ROOM')
          .fontSize(13)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textGray)
          .letterSpacing(2)
        Text('Connected')
          .fontSize(11)
          .fontColor(this.accentBlue)
      }
      .alignItems(HorizontalAlign.Center)
      Blank()
      Button() {
        Text('⚙')
          .fontSize(28)
          .fontColor(this.textBlack)
      }
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
  }

  @Builder
  TemperatureDialSection() {
    Column() {
      Stack() {
        Circle()
          .width(240)
          .height(240)
          .fill(Color.Transparent)
          .stroke(this.softGrayBg)
          .strokeWidth(40)
        Progress({ value: this.progressValue(), total: 100, type: ProgressType.Ring })
          .width(240)
          .height(240)
          .color(this.isActive ? this.accentBlue : this.textGray)
          .backgroundColor(this.softGrayBg)
          .style({ strokeWidth: 40 })
        Stack() {
          Circle()
            .width(32)
            .height(32)
            .fill(this.pureWhite)
          Circle()
            .width(20)
            .height(20)
            .fill(this.isActive ? this.accentBlue : this.textGray)
        }
        .width(32)
        .height(32)
        .offset({ x: 68, y: -62 })
        Column() {
          Text(this.targetTemp.toFixed(1) + '°')
            .fontSize(45)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? this.textBlack : this.textGray)
          Text(this.isActive ? 'COOLING' : 'OFF')
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.textGray)
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(280)
      .height(280)

      Blank().height(32)

      Row() {
        this.RoundControlButton('⌄', -0.5)
        Toggle({ type: ToggleType.Switch, isOn: this.isActive })
          .selectedColor(this.textBlack)
          .onChange((value: boolean) => {
            this.isActive = value
          })
          .margin({ left: 32, right: 32 })
        this.RoundControlButton('⌃', 0.5)
      }
      .justifyContent(FlexAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  RoundControlButton(iconName: string, delta: number) {
    Button() {
      Text(iconName)
        .fontSize(28)
        .fontColor(this.isActive ? this.textBlack : this.disabledIconGray)
    }
    .width(56)
    .height(56)
    .borderRadius(28)
    .backgroundColor(this.isActive ? this.softGrayBg : this.lightGrayBg)
    .border({ width: this.isActive ? 0 : 1, color: this.lightBorderGray })
    .onClick(() => {
      if (this.isActive) {
        this.adjustTemp(delta)
      }
    })
  }

  @Builder
  ControlGridSection() {
    Column() {
      Text('QUICK ACTIONS')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.textGray)
        .width('100%')
        .margin({ bottom: 16 })
      Row() {
        this.QuickActionCard('↻', 'Fan Speed', 'Auto', false)
        Blank().width(16)
        this.QuickActionCard('♥', 'Eco Mode', 'On', true)
      }
      .width('100%')
      Blank().height(16)
      Row() {
        this.QuickActionCard('i', 'Timer', 'Set 2h', false)
        Blank().width(16)
        this.QuickActionCard('⌂', 'Away', 'Off', false)
      }
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  QuickActionCard(iconName: string, label: string, status: string, active: boolean) {
    Column() {
      Text(iconName)
        .fontSize(24)
        .fontColor(active ? this.pureWhite : this.textBlack)
      Blank()
      Column() {
        Text(label)
          .fontSize(13)
          .fontWeight(FontWeight.Bold)
          .fontColor(active ? this.pureWhite : this.textBlack)
        Text(status)
          .fontSize(11)
          .fontColor(this.textGray)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .height(100)
    .layoutWeight(1)
    .padding(16)
    .backgroundColor(active ? this.textBlack : this.softGrayBg)
    .borderRadius(20)
    .alignItems(HorizontalAlign.Start)
  }
}