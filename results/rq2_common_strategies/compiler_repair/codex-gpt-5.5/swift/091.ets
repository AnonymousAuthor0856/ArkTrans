@Entry
@Component
struct Index {
  @State currentTemp: number = 22
  @State targetTemp: number = 24
  @State isPowerOn: boolean = true
  @State selectedMode: string = 'Cool'

  private readonly lightGray: string = '#D3D3D3'
  private readonly surface: string = '#F9F9F9'
  private readonly borderLight: string = '#F0F0F0'
  private readonly controlBg: string = '#F5F5F5'

  build() {
    Stack() {
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
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  TopBar() {
    Row() {
      Button() {
        Text('☰')
          .fontSize(24)
          .fontColor(Color.Gray)
      }
      .backgroundColor(Color.Transparent)
      Blank()
      Column() {
        Text('LIVING ROOM')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
          .fontColor(Color.Gray)
        Text(this.isPowerOn ? 'Active' : 'Off')
          .fontSize(11)
          .fontColor(this.isPowerOn ? '#4CAF50' : Color.Gray)
      }
      .alignItems(HorizontalAlign.Center)
      Blank()
      Button() {
        Text('⚙')
          .fontSize(24)
          .fontColor(Color.Gray)
      }
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
  }

  @Builder
  TemperatureControl() {
    Stack() {
      Circle()
        .width(280)
        .height(280)
        .fill(Color.White)
        .stroke('#EEEEEE')
        .strokeWidth(1)
      Column() {
        Text(this.targetTemp.toString() + '°')
          .fontSize(96)
          .fontWeight(FontWeight.Lighter)
          .fontColor(this.isPowerOn ? Color.Black : this.lightGray)
        Text('CURRENT: ' + this.currentTemp.toString() + '°')
          .fontSize(14)
          .fontColor(Color.Gray)
      }
      .alignItems(HorizontalAlign.Center)
      if (this.isPowerOn) {
        Row() {
          Button() {
            Text('⌄')
              .fontSize(24)
              .fontColor(Color.Black)
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor(this.controlBg)
          .onClick(() => {
            this.targetTemp -= 1
          })
          Blank()
          Button() {
            Text('+')
              .fontSize(24)
              .fontColor(Color.Black)
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor(this.controlBg)
          .onClick(() => {
            this.targetTemp += 1
          })
        }
        .width(280)
        .padding({ left: 20, right: 20 })
      }
    }
    .width(280)
    .height(280)
  }

  @Builder
  ModeSelection() {
    Column() {
      Text('MODE')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Gray)
        .margin({ bottom: 16 })
      Row() {
        this.ModeButton('⌂', 'Auto')
        Blank().width(12)
        this.ModeButton('↻', 'Fan')
        Blank().width(12)
        this.ModeButton('★', 'Cool')
      }
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ModeButton(iconText: string, label: string) {
    Column() {
      Button() {
        Text(iconText)
          .fontSize(24)
          .fontColor(this.selectedMode === label && this.isPowerOn ? Color.White : (this.isPowerOn ? Color.Black : this.lightGray))
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor(this.selectedMode === label && this.isPowerOn ? Color.Black : Color.White)
      .border({ width: this.selectedMode === label ? 0 : 1, color: '#E0E0E0' })
      .onClick(() => {
        if (this.isPowerOn) {
          this.selectedMode = label
        }
      })
      Text(label)
        .fontSize(11)
        .fontColor(this.isPowerOn ? Color.Gray : this.lightGray)
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  InfoCardsRow() {
    Row() {
      this.InfoCard('Humidity', '45%', 'i')
      Blank().width(16)
      this.InfoCard('Energy', '12 kWh', '⌃')
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
  }

  @Builder
  InfoCard(title: string, value: string, iconText: string) {
    Column() {
      Text(iconText)
        .fontSize(20)
        .fontColor(Color.Gray)
      Text(value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ top: 8 })
      Text(title)
        .fontSize(12)
        .fontColor(Color.Gray)
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .layoutWeight(1)
    .backgroundColor(this.surface)
    .borderRadius(16)
    .border({ width: 1, color: this.borderLight })
  }

  @Builder
  PowerSwitch() {
    Row() {
      Column() {
        Text('Master Power')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text(this.isPowerOn ? 'System is running' : 'System is off')
          .fontSize(12)
          .fontColor(Color.Gray)
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
      Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
        .selectedColor(Color.Black)
        .onChange((value: boolean) => {
          this.isPowerOn = value
        })
    }
    .width('100%')
    .padding(20)
    .margin({ left: 24, right: 24, bottom: 40 })
    .backgroundColor(this.surface)
    .borderRadius(16)
  }
}