@Entry
@Component
struct ThermostatScreen {
  @State currentTemp: number = 22
  @State targetTemp: number = 24
  @State isPowerOn: boolean = true
  @State selectedMode: string = 'Cool'

  private readonly grey: string = '#8E8E93'
  private readonly paleGrey: string = '#F5F5F5'
  private readonly cardBg: string = '#FAFAFA'
  private readonly circleBorder: string = '#EEEEEE'
  private readonly green: string = '#4CAF50'
  private readonly disabled: string = '#D4D4D4'

  build() {
    Column() {
      this.TopBar()

      Blank()
        .height(54)

      this.TemperatureControl()

      Blank()
        .layoutWeight(1)

      this.ModeSelection()

      Blank()
        .height(28)

      this.InfoCardsRow()

      Blank()
        .height(16)

      this.PowerSwitch()
    }
    .width('100%')
    .height('100%')
    .padding({
      left: 24,
      right: 24,
      top: 0,
      bottom: 14
    })
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.Start)
  }

  @Builder
  private TopBar() {
    Row() {
      Button() {
        Text('☰')
          .fontSize(29)
          .fontColor(this.grey)
          .fontWeight(FontWeight.Normal)
      }
      .width(56)
      .height(56)
      .backgroundColor(Color.Transparent)
      .padding(0)

      Blank()
        .layoutWeight(1)

      Column() {
        Text('LIVING ROOM')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.grey)
          .letterSpacing(6)
          .maxLines(1)

        Text(this.isPowerOn ? 'Active' : 'Off')
          .fontSize(21)
          .fontColor(this.isPowerOn ? this.green : this.grey)
          .margin({ top: 5 })
      }
      .height(58)
      .justifyContent(FlexAlign.Center)

      Blank()
        .layoutWeight(1)

      Button() {
        Text('⚙')
          .fontSize(41)
          .fontColor(this.grey)
          .fontWeight(FontWeight.Bold)
      }
      .width(56)
      .height(56)
      .backgroundColor(Color.Transparent)
      .padding(0)
    }
    .width('100%')
    .height(62)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  private TemperatureControl() {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(560)
        .height(560)
        .fill(Color.White)
        .stroke(this.circleBorder)
        .strokeWidth(2)

      Column() {
        Text(`${this.targetTemp}°`)
          .fontSize(132)
          .fontWeight(FontWeight.Lighter)
          .fontColor(this.isPowerOn ? Color.Black : this.disabled)
          .height(165)
          .maxLines(1)
          .textAlign(TextAlign.Center)

        Text(`CURRENT: ${this.currentTemp}°`)
          .fontSize(29)
          .fontColor(this.grey)
          .fontWeight(FontWeight.Normal)
          .margin({ top: 10 })
          .maxLines(1)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      if (this.isPowerOn) {
        Row() {
          Button() {
            Text('⌄')
              .fontSize(54)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Normal)
              .translate({ y: -6 })
          }
          .width(96)
          .height(96)
          .borderRadius(48)
          .backgroundColor(this.paleGrey)
          .padding(0)
          .onClick(() => {
            this.targetTemp -= 1
          })

          Blank()
            .layoutWeight(1)

          Button() {
            Text('+')
              .fontSize(52)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Normal)
          }
          .width(96)
          .height(96)
          .borderRadius(48)
          .backgroundColor(this.paleGrey)
          .padding(0)
          .onClick(() => {
            this.targetTemp += 1
          })
        }
        .width(436)
        .height(96)
        .alignItems(VerticalAlign.Center)
      }
    }
    .width(560)
    .height(560)
  }

  @Builder
  private ModeSelection() {
    Column() {
      Text('MODE')
        .fontSize(23)
        .fontColor(this.grey)
        .fontWeight(FontWeight.Bold)
        .maxLines(1)

      Row() {
        this.ModeButton('⌂', 'Auto')
        this.ModeButton('↻', 'Fan')
        this.ModeButton('★', 'Cool')
      }
      .width(410)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Top)
      .margin({ top: 32 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  private ModeButton(icon: string, label: string) {
    Column() {
      Button() {
        Text(icon)
          .fontSize(label === 'Auto' ? 47 : 49)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.modeIconColor(label))
          .textAlign(TextAlign.Center)
      }
      .width(120)
      .height(120)
      .borderRadius(60)
      .border({
        width: this.selectedMode === label && this.isPowerOn ? 0 : 2,
        color: this.selectedMode === label && this.isPowerOn ? Color.Transparent : '#E0E0E0'
      })
      .backgroundColor(this.selectedMode === label && this.isPowerOn ? Color.Black : Color.White)
      .padding(0)
      .enabled(this.isPowerOn)
      .onClick(() => {
        this.selectedMode = label
      })

      Text(label)
        .fontSize(24)
        .fontColor(this.isPowerOn ? this.grey : this.disabled)
        .margin({ top: 16 })
        .maxLines(1)
    }
    .width(120)
    .alignItems(HorizontalAlign.Center)
  }

  private modeIconColor(label: string): ResourceColor {
    if (!this.isPowerOn) {
      return this.disabled
    }
    return this.selectedMode === label ? Color.White : Color.Black
  }

  @Builder
  private InfoCardsRow() {
    Row() {
      this.InfoCard('ℹ', '45%', 'Humidity')

      Blank()
        .width(30)

      this.InfoCard('⌃', '12 kWh', 'Energy')
    }
    .width('100%')
  }

  @Builder
  private InfoCard(icon: string, value: string, title: string) {
    Column() {
      Text(icon)
        .fontSize(icon === 'ℹ' ? 43 : 52)
        .fontColor(this.grey)
        .fontWeight(FontWeight.Bold)
        .height(54)
        .textAlign(TextAlign.Start)

      Text(value)
        .fontSize(48)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 18 })
        .maxLines(1)
        .textAlign(TextAlign.Start)

      Text(title)
        .fontSize(25)
        .fontColor(this.grey)
        .margin({ top: 18 })
        .maxLines(1)
    }
    .layoutWeight(1)
    .height(220)
    .padding({
      left: 31,
      right: 20,
      top: 34,
      bottom: 28
    })
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .backgroundColor(this.cardBg)
    .borderRadius(30)
    .border({ width: 2, color: '#F0F0F0' })
  }

  @Builder
  private PowerSwitch() {
    Row() {
      Column() {
        Text('Master Power')
          .fontSize(31)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Medium)
          .maxLines(1)

        Text(this.isPowerOn ? 'System is running' : 'System is off')
          .fontSize(25)
          .fontColor(this.grey)
          .margin({ top: 4 })
          .maxLines(1)
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)

      Blank()
        .layoutWeight(1)

      Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
        .selectedColor(Color.Black)
        .width(104)
        .height(62)
        .onChange((value: boolean) => {
          this.isPowerOn = value
        })
    }
    .width('100%')
    .height(148)
    .padding({
      left: 39,
      right: 36,
      top: 26,
      bottom: 26
    })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(this.cardBg)
    .borderRadius(30)
  }
}
