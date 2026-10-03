// ThermostatScreen.ets
// ArkTS port of the SwiftUI thermostat UI (HarmonyOS NEXT / API 11+)

@Entry
@Component
struct ThermostatScreen {
  @State currentTemp: number = 22;
  @State targetTemp: number = 24;
  @State isPowerOn: boolean = true;
  @State selectedMode: string = 'Cool';

  private readonly cBlack: string = '#000000';
  private readonly cGray: string = '#757575';
  private readonly cDisabled: string = '#D4D4D4';
  private readonly cGreen: string = '#4CAF50';
  private readonly cCircleStroke: string = '#EEEEEE';
  private readonly cChipBg: string = '#F5F5F5';
  private readonly cChipStroke: string = '#E0E0E0';
  private readonly cCardBg: string = '#F9F9F9';
  private readonly cCardStroke: string = '#F0F0F0';

  build() {
    Column() {
      this.TopBar()

      Blank().height(10)

      this.TemperatureControl()

      Blank()

      this.ModeSelection()

      Blank()

      this.InfoCardsRow()

      Blank()

      this.PowerSwitch()
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 40 })
    .backgroundColor(Color.White)
  }

  // MARK: - Top Bar
  @Builder
  TopBar() {
    Row() {
      Text('☰')
        .fontSize(24)
        .fontColor(this.cGray)

      Blank()

      Column({ space: 2 }) {
        Text('LIVING ROOM')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
          .fontColor(this.cGray)

        Text(this.isPowerOn ? 'Active' : 'Off')
          .fontSize(11)
          .fontColor(this.isPowerOn ? this.cGreen : this.cDisabled)
      }
      .alignItems(HorizontalAlign.Center)

      Blank()

      Text('⚙')
        .fontSize(24)
        .fontColor(this.cGray)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  // MARK: - Temperature Circle Control
  @Builder
  TemperatureControl() {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(280)
        .height(280)
        .fill(Color.White)
        .stroke(this.cCircleStroke)
        .strokeWidth(1)

      Column({ space: 4 }) {
        Text(`${this.targetTemp}°`)
          .fontSize(96)
          .fontWeight(FontWeight.Lighter)
          .fontColor(this.isPowerOn ? this.cBlack : this.cDisabled)

        Text(`CURRENT: ${this.currentTemp}°`)
          .fontSize(14)
          .fontColor(this.cGray)
      }
      .alignItems(HorizontalAlign.Center)

      if (this.isPowerOn) {
        Row() {
          Button() {
            Text('⌄')
              .fontSize(24)
              .fontColor(this.cBlack)
          }
          .width(48)
          .height(48)
          .backgroundColor(this.cChipBg)
          .onClick(() => {
            this.targetTemp -= 1;
          })

          Blank()

          Button() {
            Text('+')
              .fontSize(24)
              .fontColor(this.cBlack)
          }
          .width(48)
          .height(48)
          .backgroundColor(this.cChipBg)
          .onClick(() => {
            this.targetTemp += 1;
          })
        }
        .width(280)
        .padding({ left: 20, right: 20 })
        .alignItems(VerticalAlign.Center)
      }
    }
    .width(280)
    .height(280)
  }

  // MARK: - Mode Selection
  @Builder
  ModeSelection() {
    Column({ space: 16 }) {
      Text('MODE')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.cGray)

      Row({ space: 12 }) {
        this.ModeButton('⌂', 'Auto', this.selectedMode === 'Auto')
        this.ModeButton('↻', 'Fan', this.selectedMode === 'Fan')
        this.ModeButton('★', 'Cool', this.selectedMode === 'Cool')
      }
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ModeButton(icon: string, label: string, isSelected: boolean) {
    Column({ space: 8 }) {
      Button() {
        Text(icon)
          .fontSize(24)
          .fontColor(
            isSelected && this.isPowerOn
              ? Color.White
              : (this.isPowerOn ? this.cBlack : this.cDisabled)
          )
      }
      .width(60)
      .height(60)
      .backgroundColor(isSelected && this.isPowerOn ? Color.Black : Color.White)
      .border({
        width: 1,
        color: isSelected ? Color.Transparent : this.cChipStroke
      })
      .enabled(this.isPowerOn)
      .onClick(() => {
        this.selectedMode = label;
      })

      Text(label)
        .fontSize(11)
        .fontColor(this.isPowerOn ? this.cGray : this.cDisabled)
    }
    .alignItems(HorizontalAlign.Center)
  }

  // MARK: - Info Cards
  @Builder
  InfoCardsRow() {
    Row({ space: 16 }) {
      this.InfoCard('ⓘ', '45%', 'Humidity')
      this.InfoCard('⌃', '12 kWh', 'Energy')
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  InfoCard(icon: string, value: string, title: string) {
    Column({ space: 8 }) {
      Text(icon)
        .fontSize(20)
        .fontColor(this.cGray)

      Text(value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.cBlack)

      Text(title)
        .fontSize(12)
        .fontColor(this.cGray)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .layoutWeight(1)
    .backgroundColor(this.cCardBg)
    .borderRadius(16)
    .border({ width: 1, color: this.cCardStroke })
  }

  // MARK: - Master Power Switch
  @Builder
  PowerSwitch() {
    Row() {
      Column({ space: 0 }) {
        Text('Master Power')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.cBlack)

        Text(this.isPowerOn ? 'System is running' : 'System is off')
          .fontSize(12)
          .fontColor(this.cGray)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
        .selectedColor(Color.Black)
        .onChange((isOn: boolean) => {
          this.isPowerOn = isOn;
        })
    }
    .width('100%')
    .padding(20)
    .backgroundColor(this.cCardBg)
    .borderRadius(16)
    .alignItems(VerticalAlign.Center)
  }
}