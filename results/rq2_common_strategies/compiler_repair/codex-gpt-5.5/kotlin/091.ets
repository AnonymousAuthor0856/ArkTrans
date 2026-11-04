@Entry
@Component
struct Index {
  @State currentTemp: number = 22
  @State targetTemp: number = 24
  @State isPowerOn: boolean = true
  @State selectedMode: string = 'Cool'

  build() {
    Column() {
      this.TopBar()
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
            .fontColor(this.isPowerOn ? Color.Black : '#D3D3D3')
          Text('CURRENT: ' + this.currentTemp.toString() + '°')
            .fontSize(14)
            .fontColor(Color.Gray)
        }
        .alignItems(HorizontalAlign.Center)
        if (this.isPowerOn) {
          Button('+')
            .fontSize(24)
            .fontColor(Color.Black)
            .backgroundColor('#F5F5F5')
            .borderRadius(24)
            .width(48)
            .height(48)
            .padding(0)
            .margin({ left: 210 })
            .onClick(() => {
              this.targetTemp++
            })
          Button('⌄')
            .fontSize(24)
            .fontColor(Color.Black)
            .backgroundColor('#F5F5F5')
            .borderRadius(24)
            .width(48)
            .height(48)
            .padding(0)
            .margin({ right: 210 })
            .onClick(() => {
              this.targetTemp--
            })
        }
      }
      .width(280)
      .height(280)
      .margin({ top: 10 })

      Column() {
        Text('MODE')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
          .margin({ bottom: 16 })
        Row() {
          this.ModeButton('⌂', 'Auto')
          this.ModeButton('↻', 'Fan')
          this.ModeButton('★', 'Cool')
        }
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)

      Row() {
        this.InfoCard('Humidity', '45%', 'i')
        this.InfoCard('Energy', '12 kWh', '⌃')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
        Column() {
          Text('Master Power')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
          Text(this.isPowerOn ? 'System is running' : 'System is off')
            .fontSize(13)
            .fontColor(Color.Gray)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)

        Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
          .selectedColor(Color.Black)
          .onChange((on: boolean) => {
            this.isPowerOn = on
          })
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .borderRadius(16)
      .backgroundColor('#F9F9F9')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: 40 })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24 })
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(Color.White)
  }

  @Builder
  TopBar() {
    Row() {
      Button('☰')
        .fontSize(22)
        .fontColor(Color.Gray)
        .backgroundColor(Color.Transparent)
        .width(48)
        .height(48)
        .padding(0)
      Column() {
        Text('LIVING ROOM')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
        Text(this.isPowerOn ? 'Active' : 'Off')
          .fontSize(11)
          .fontColor(this.isPowerOn ? '#4CAF50' : '#D3D3D3')
      }
      .alignItems(HorizontalAlign.Center)
      Button('⚙')
        .fontSize(22)
        .fontColor(Color.Gray)
        .backgroundColor(Color.Transparent)
        .width(48)
        .height(48)
        .padding(0)
    }
    .width('100%')
    .padding({ top: 24, bottom: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  ModeButton(icon: string, label: string) {
    Column() {
      Button(icon)
        .fontSize(24)
        .fontColor(this.modeColor(label))
        .backgroundColor(this.modeBackground(label))
        .border({ width: this.selectedMode === label && this.isPowerOn ? 0 : 1, color: '#E0E0E0', radius: 30 })
        .width(60)
        .height(60)
        .borderRadius(30)
        .padding(0)
        .enabled(this.isPowerOn)
        .onClick(() => {
          this.selectedMode = label
        })
      Text(label)
        .fontSize(12)
        .fontColor(this.isPowerOn ? Color.Gray : '#D3D3D3')
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
    .margin({ left: 6, right: 6 })
  }

  @Builder
  InfoCard(title: string, value: string, icon: string) {
    Column() {
      Text(icon)
        .fontSize(20)
        .fontColor(Color.Gray)
      Text(value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ top: 8 })
      Text(title)
        .fontSize(13)
        .fontColor(Color.Gray)
        .margin({ top: 4 })
    }
    .layoutWeight(1)
    .padding(16)
    .border({ width: 1, color: '#F0F0F0', radius: 16 })
    .backgroundColor('#F9F9F9')
    .alignItems(HorizontalAlign.Start)
    .margin({ left: 8, right: 8 })
  }

  modeBackground(label: string): ResourceColor {
    if (this.selectedMode === label && this.isPowerOn) {
      return Color.Black
    }
    if (!this.isPowerOn) {
      return '#F5F5F5'
    }
    return Color.White
  }

  modeColor(label: string): ResourceColor {
    if (this.selectedMode === label && this.isPowerOn) {
      return Color.White
    }
    if (!this.isPowerOn) {
      return '#D3D3D3'
    }
    return Color.Black
  }
}
