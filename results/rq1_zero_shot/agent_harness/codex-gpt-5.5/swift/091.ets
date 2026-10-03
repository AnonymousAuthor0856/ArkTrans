@Entry
@Component
struct ThermostatScreen {
  @State private currentTemp: number = 22;
  @State private targetTemp: number = 24;
  @State private isPowerOn: boolean = true;
  @State private selectedMode: string = 'Cool';

  @Builder
  private TopBar() {
    Row() {
      Button('☰')
        .fontSize(24)
        .fontColor('#808080')
        .backgroundColor(Color.Transparent)
      Blank()
      Column({ space: 2 }) {
        Text('LIVING ROOM')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#808080')
        Text(this.isPowerOn ? 'Active' : 'Off')
          .fontSize(11)
          .fontColor(this.isPowerOn ? '#4CAF50' : '#808080')
      }
      Blank()
      Button('⚙')
        .fontSize(24)
        .fontColor('#808080')
        .backgroundColor(Color.Transparent)
    }
    .width('100%')
  }

  @Builder
  private TemperatureControl() {
    Stack() {
      Circle()
        .width(280)
        .height(280)
        .fill(Color.White)
        .stroke('#EEEEEE')
        .strokeWidth(1)

      Column() {
        Text(`${this.targetTemp}°`)
          .fontSize(96)
          .fontWeight(FontWeight.Lighter)
          .fontColor(this.isPowerOn ? Color.Black : '#D3D3D3')
        Text(`CURRENT: ${this.currentTemp}°`)
          .fontSize(14)
          .fontColor('#808080')
      }

      if (this.isPowerOn) {
        Row() {
          Button('⌄')
            .width(48)
            .height(48)
            .fontSize(24)
            .fontColor(Color.Black)
            .backgroundColor('#F5F5F5')
            .borderRadius(24)
            .margin({ left: 20 })
            .onClick(() => {
              this.targetTemp -= 1;
            })
          Blank()
          Button('+')
            .width(48)
            .height(48)
            .fontSize(24)
            .fontColor(Color.Black)
            .backgroundColor('#F5F5F5')
            .borderRadius(24)
            .margin({ right: 20 })
            .onClick(() => {
              this.targetTemp += 1;
            })
        }
        .width(280)
      }
    }
    .width(280)
    .height(280)
  }

  @Builder
  private ModeButton(iconName: string, label: string) {
    Column({ space: 8 }) {
      Button(iconName)
        .width(60)
        .height(60)
        .fontSize(24)
        .fontColor(this.selectedMode === label && this.isPowerOn ? Color.White : (this.isPowerOn ? Color.Black : '#D3D3D3'))
        .backgroundColor(this.selectedMode === label && this.isPowerOn ? Color.Black : Color.White)
        .border({ width: this.selectedMode === label ? 0 : 1, color: '#E0E0E0' })
        .borderRadius(30)
        .enabled(this.isPowerOn)
        .onClick(() => {
          this.selectedMode = label;
        })
      Text(label)
        .fontSize(11)
        .fontColor(this.isPowerOn ? '#808080' : '#D3D3D3')
    }
  }

  @Builder
  private ModeSelection() {
    Column({ space: 16 }) {
      Text('MODE')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#808080')
      Row({ space: 12 }) {
        this.ModeButton('⌂', 'Auto')
        this.ModeButton('↻', 'Fan')
        this.ModeButton('★', 'Cool')
      }
    }
  }

  @Builder
  private InfoCard(title: string, value: string, iconName: string) {
    Column({ space: 8 }) {
      Text(iconName)
        .fontSize(20)
        .fontColor('#808080')
      Text(value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
      Text(title)
        .fontSize(12)
        .fontColor('#808080')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .layoutWeight(1)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .border({ width: 1, color: '#F0F0F0' })
  }

  @Builder
  private InfoCardsRow() {
    Row({ space: 16 }) {
      this.InfoCard('Humidity', '45%', 'i')
      this.InfoCard('Energy', '12 kWh', '⌃')
    }
    .width('100%')
  }

  @Builder
  private PowerSwitch() {
    Row() {
      Column({ space: 0 }) {
        Text('Master Power')
          .fontSize(16)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(Color.Black)
        Text(this.isPowerOn ? 'System is running' : 'System is off')
          .fontSize(12)
          .fontColor('#808080')
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
      Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
        .selectedColor(Color.Black)
        .onChange((isOn: boolean) => {
          this.isPowerOn = isOn;
        })
    }
    .padding(20)
    .width('100%')
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        this.TopBar()
          .padding({ left: 24, right: 24, top: 24, bottom: 24 })

        Blank().height(10)

        this.TemperatureControl()

        Blank()

        this.ModeSelection()

        Blank()

        this.InfoCardsRow()
          .padding({ left: 24, right: 24 })

        Blank()

        this.PowerSwitch()
          .padding({ left: 24, right: 24, bottom: 40 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
