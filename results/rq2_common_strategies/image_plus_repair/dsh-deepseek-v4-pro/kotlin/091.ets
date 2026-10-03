@Entry
@Component
struct ThermostatPage {
  @State currentTemp: number = 22;
  @State targetTemp: number = 24;
  @State isPowerOn: boolean = true;
  @State selectedMode: string = 'Cool';

  private modeContainerColor(isSelected: boolean, enabled: boolean): string {
    if (!enabled) {
      return '#F5F5F5';
    }
    if (isSelected) {
      return '#000000';
    }
    return '#FFFFFF';
  }

  private modeContentColor(isSelected: boolean, enabled: boolean): string {
    if (!enabled) {
      return '#D3D3D3';
    }
    if (isSelected) {
      return '#FFFFFF';
    }
    return '#000000';
  }

  @Builder
  ModeButton(icon: string, label: string, isSelected: boolean, enabled: boolean, mode: string) {
    Column({ space: 8 }) {
      Column() {
        Text(icon)
          .fontSize(24)
          .fontColor(this.modeContentColor(isSelected, enabled))
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor(this.modeContainerColor(isSelected, enabled))
      .border({ width: isSelected ? 0 : 1, color: '#E0E0E0' })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .onClick(() => {
        if (enabled) {
          this.selectedMode = mode;
        }
      })

      Text(label)
        .fontSize(11)
        .fontColor(enabled ? '#808080' : '#D3D3D3')
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
    .padding(16)
    .borderRadius(16)
    .backgroundColor('#F9F9F9')
    .border({ width: 1, color: '#F0F0F0' })
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      // --- Top bar ---
      Row() {
        Text('☰')
          .fontSize(24)
          .fontColor('#808080')
          .onClick(() => {})

        Column() {
          Text('LIVING ROOM')
            .fontSize(12)
            .fontColor('#808080')
            .fontWeight(FontWeight.Bold)
            .letterSpacing(2)
          if (this.isPowerOn) {
            Text('Active')
              .fontSize(11)
              .fontColor('#4CAF50')
          } else {
            Text('Off')
              .fontSize(11)
              .fontColor('#D3D3D3')
          }
        }
        .alignItems(HorizontalAlign.Center)

        Text('⚙')
          .fontSize(24)
          .fontColor('#808080')
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // --- Content ---
      Column() {
        Row()
          .width('100%')
          .height(10)

        // --- Main Temperature Control ---
        Stack({ alignContent: Alignment.Center }) {
          Column()
            .width(280)
            .height(280)
            .borderRadius(140)
            .backgroundColor('#FFFFFF')
            .border({ width: 1, color: '#EEEEEE' })

          Column() {
            Text(`${this.targetTemp}°`)
              .fontSize(96)
              .fontWeight(FontWeight.Lighter)
              .fontColor(this.isPowerOn ? '#000000' : '#D3D3D3')
            Text(`CURRENT: ${this.currentTemp}°`)
              .fontSize(14)
              .fontColor('#808080')
          }
          .alignItems(HorizontalAlign.Center)

          if (this.isPowerOn) {
            Stack({ alignContent: Alignment.End }) {
              Column() {
                Text('+')
                  .fontSize(28)
                  .fontColor('#000000')
              }
              .width(48)
              .height(48)
              .borderRadius(24)
              .backgroundColor('#F5F5F5')
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
              .onClick(() => {
                this.targetTemp++;
              })
            }
            .width(280)
            .height(280)
            .padding(20)

            Stack({ alignContent: Alignment.Start }) {
              Column() {
                Text('−')
                  .fontSize(28)
                  .fontColor('#000000')
              }
              .width(48)
              .height(48)
              .borderRadius(24)
              .backgroundColor('#F5F5F5')
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
              .onClick(() => {
                this.targetTemp--;
              })
            }
            .width(280)
            .height(280)
            .padding(20)
          }
        }
        .width(280)
        .height(280)

        // --- Mode Selection ---
        Column() {
          Text('MODE')
            .fontSize(11)
            .fontColor('#808080')
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 16 })
          Row({ space: 12 }) {
            this.ModeButton('⌂', 'Auto', this.selectedMode === 'Auto', this.isPowerOn, 'Auto')
            this.ModeButton('⟳', 'Fan', this.selectedMode === 'Fan', this.isPowerOn, 'Fan')
            this.ModeButton('★', 'Cool', this.selectedMode === 'Cool', this.isPowerOn, 'Cool')
          }
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        // --- Info Cards ---
        Row({ space: 16 }) {
          this.InfoCard('Humidity', '45%', 'ℹ')
          this.InfoCard('Energy', '12 kWh', '▲')
        }
        .width('100%')

        // --- Power Switch ---
        Row() {
          Column({ space: 2 }) {
            Text('Master Power')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
            Text(this.isPowerOn ? 'System is running' : 'System is off')
              .fontSize(12)
              .fontColor('#808080')
          }
          .alignItems(HorizontalAlign.Start)

          Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
            .selectedColor('#000000')
            .switchPointColor('#FFFFFF')
            .onChange((isOn: boolean) => {
              this.isPowerOn = isOn;
            })
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
        .margin({ bottom: 40 })
        .borderRadius(16)
        .backgroundColor('#F9F9F9')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: 24, right: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
