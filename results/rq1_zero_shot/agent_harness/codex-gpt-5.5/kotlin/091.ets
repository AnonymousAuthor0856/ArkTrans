@Entry
@Component
struct MainActivity {
  @State currentTemp: number = 22;
  @State targetTemp: number = 24;
  @State powerOn: boolean = true;
  @State selectedMode: string = 'Cool';

  @Builder
  TopBar() {
    Row() {
      Text('≡')
        .fontSize(24)
        .fontColor('#808080')
        .width(44)
        .textAlign(TextAlign.Center)
      Column() {
        Text('LIVING ROOM')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#808080')
        Text(this.powerOn ? 'Active' : 'Off')
          .fontSize(11)
          .fontColor(this.powerOn ? '#4CAF50' : '#D3D3D3')
      }
      .alignItems(HorizontalAlign.Center)
      Text('⚙')
        .fontSize(24)
        .fontColor('#808080')
        .width(44)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TemperatureControl() {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(280)
        .height(280)
        .fill('#FFFFFF')
        .stroke('#EEEEEE')
        .strokeWidth(1)
      Column() {
        Text(`${this.targetTemp}°`)
          .fontSize(96)
          .fontWeight(FontWeight.Light)
          .fontColor(this.powerOn ? '#000000' : '#D3D3D3')
        Text(`CURRENT: ${this.currentTemp}°`)
          .fontSize(14)
          .fontColor('#808080')
      }
      .alignItems(HorizontalAlign.Center)
      if (this.powerOn) {
        Text('+')
          .fontSize(24)
          .fontColor('#000000')
          .textAlign(TextAlign.Center)
          .width(48)
          .height(48)
          .lineHeight(48)
          .backgroundColor('#F5F5F5')
          .borderRadius(24)
          .position({ x: '78%', y: '41%' })
          .onClick(() => { this.targetTemp++; })
        Text('⌄')
          .fontSize(24)
          .fontColor('#000000')
          .textAlign(TextAlign.Center)
          .width(48)
          .height(48)
          .lineHeight(48)
          .backgroundColor('#F5F5F5')
          .borderRadius(24)
          .position({ x: '5%', y: '41%' })
          .onClick(() => { this.targetTemp--; })
      }
    }
    .width(280)
    .height(280)
  }

  @Builder
  ModeButton(icon: string, label: string) {
    Column() {
      Text(icon)
        .fontSize(24)
        .fontColor(this.selectedMode === label && this.powerOn ? '#FFFFFF' : this.powerOn ? '#000000' : '#D3D3D3')
        .textAlign(TextAlign.Center)
        .width(60)
        .height(60)
        .lineHeight(60)
        .backgroundColor(this.selectedMode === label && this.powerOn ? '#000000' : this.powerOn ? '#FFFFFF' : '#F5F5F5')
        .borderRadius(30)
        .border({ width: this.selectedMode === label ? 0 : 1, color: '#E0E0E0' })
        .onClick(() => {
          if (this.powerOn) {
            this.selectedMode = label;
          }
        })
      Text(label)
        .fontSize(11)
        .fontColor(this.powerOn ? '#808080' : '#D3D3D3')
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  InfoCard(title: string, value: string, icon: string) {
    Column({ space: 8 }) {
      Text(icon)
        .fontSize(20)
        .fontColor('#808080')
      Text(value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
      Text(title)
        .fontSize(12)
        .fontColor('#808080')
    }
    .layoutWeight(1)
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .border({ width: 1, color: '#F0F0F0' })
  }

  @Builder
  PowerSwitch() {
    Row() {
      Column() {
        Text('Master Power')
          .fontSize(16)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#000000')
        Text(this.powerOn ? 'System is running' : 'System is off')
          .fontSize(12)
          .fontColor('#808080')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      Toggle({ type: ToggleType.Switch, isOn: this.powerOn })
        .selectedColor('#000000')
        .onChange((value: boolean) => { this.powerOn = value; })
    }
    .width('100%')
    .padding({ left: 20, right: 20, top: 16, bottom: 16 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
  }

  build() {
    Column() {
      this.TopBar()
      Column() {
        Blank().height(10)
        this.TemperatureControl()

        Column() {
          Text('MODE')
            .fontSize(11)
            .fontWeight(FontWeight.Bold)
            .fontColor('#808080')
            .margin({ bottom: 16 })
          Row({ space: 12 }) {
            this.ModeButton('⌂', 'Auto')
            this.ModeButton('↻', 'Fan')
            this.ModeButton('★', 'Cool')
          }
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        Row({ space: 16 }) {
          this.InfoCard('Humidity', '45%', 'i')
          this.InfoCard('Energy', '12 kWh', '⌃')
        }
        .width('100%')

        this.PowerSwitch()
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: 24, right: 24, bottom: 40 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
