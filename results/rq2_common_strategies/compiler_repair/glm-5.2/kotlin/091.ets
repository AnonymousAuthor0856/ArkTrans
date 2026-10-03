@Entry
@Component
struct ThermostatScreen {
  @State currentTemp: number = 22;
  @State targetTemp: number = 24;
  @State isPowerOn: boolean = true;
  @State selectedMode: string = 'Cool';

  build() {
    Column() {
      // Top Bar
      Row() {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor(Color.Gray)
          .onClick(() => {})
          .margin({ left: 24, right: 24 })

        Column() {
          Text('LIVING ROOM')
            .fontSize(12)
            .fontColor(Color.Gray)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(2)
          if (this.isPowerOn) {
            Text('Active')
              .fontSize(10)
              .fontColor(Color.Green)
          } else {
            Text('Off')
              .fontSize(10)
              .fontColor(Color.Gray)
          }
        }
        .alignItems(HorizontalAlign.Center)

        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor(Color.Gray)
          .onClick(() => {})
          .margin({ left: 24, right: 24 })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ top: 24, bottom: 24 })

      // Main Content
      Column() {
        // Main Temperature Control
        Stack() {
          // Decorative Circle
          Column()
            .width(280)
            .height(280)
            .borderRadius(140)
            .backgroundColor(Color.White)
            .border({ width: 1, color: '#FFEEEEEE' })

          Column() {
            Text(`${this.targetTemp}°`)
              .fontSize(96)
              .fontWeight(FontWeight.Lighter)
              .fontColor(this.isPowerOn ? Color.Black : Color.Gray)
            Text(`CURRENT: ${this.currentTemp}°`)
              .fontSize(14)
              .fontColor(Color.Gray)
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)

          if (this.isPowerOn) {
            Row() {
              Text('+')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
            }
            .width(48)
            .height(48)
            .borderRadius(24)
            .backgroundColor('#FFF5F5F5')
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
            .onClick(() => { this.targetTemp++; })
            .position({ x: 220, y: 116 })

            Row() {
              Text('-')
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
            }
            .width(48)
            .height(48)
            .borderRadius(24)
            .backgroundColor('#FFF5F5F5')
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
            .onClick(() => { this.targetTemp--; })
            .position({ x: 12, y: 116 })
          }
        }
        .width(280)
        .height(280)
        .margin({ top: 10, bottom: 20 })

        // Mode Selection
        Column() {
          Text('MODE')
            .fontSize(10)
            .fontColor(Color.Gray)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 16 })

          Row() {
            this.ModeButton('A', 'Auto', this.selectedMode === 'Auto', this.isPowerOn, () => { this.selectedMode = 'Auto'; })
            this.ModeButton('F', 'Fan', this.selectedMode === 'Fan', this.isPowerOn, () => { this.selectedMode = 'Fan'; })
            this.ModeButton('C', 'Cool', this.selectedMode === 'Cool', this.isPowerOn, () => { this.selectedMode = 'Cool'; })
          }
          .justifyContent(FlexAlign.SpaceEvenly)
          .width('100%')
        }
        .margin({ bottom: 20 })

        // Info Cards
        Row() {
          this.InfoCard('Humidity', '45%', 'H')
          this.InfoCard('Energy', '12 kWh', 'E')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ bottom: 20 })

        // Power Switch
        Row() {
          Column() {
            Text('Master Power')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
            Text(this.isPowerOn ? 'System is running' : 'System is off')
              .fontSize(12)
              .fontColor(Color.Gray)
          }
          .alignItems(HorizontalAlign.Start)

          Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
            .selectedColor(Color.Black)
            .onChange((isOn: boolean) => { this.isPowerOn = isOn; })
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
        .backgroundColor('#FFF9F9F9')
        .borderRadius(16)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24, bottom: 40 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder ModeButton(iconText: string, label: string, isSelected: boolean, enabled: boolean, onClick: () => void) {
    Column() {
      Button({ type: ButtonType.Circle }) {
        Text(iconText)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(isSelected && enabled ? Color.White : (enabled ? Color.Black : Color.Gray))
      }
      .width(60)
      .height(60)
      .backgroundColor(isSelected && enabled ? Color.Black : Color.White)
      .border({ width: 1, color: isSelected && enabled ? Color.Black : '#FFE0E0E0' })
      .enabled(enabled)
      .onClick(onClick)

      Text(label)
        .fontSize(10)
        .fontColor(enabled ? Color.Gray : Color.Gray)
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder InfoCard(title: string, value: string, iconText: string) {
    Column() {
      Text(iconText)
        .fontSize(16)
        .fontColor(Color.Gray)
        .margin({ bottom: 8 })
      Text(value)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
      Text(title)
        .fontSize(12)
        .fontColor(Color.Gray)
        .margin({ top: 4 })
    }
    .layoutWeight(1)
    .padding(16)
    .backgroundColor('#FFF9F9F9')
    .borderRadius(16)
    .border({ width: 1, color: '#FFF0F0F0' })
    .margin({ right: 8 })
  }
}