@Entry
@Component
struct ThermostatScreen {
  @State currentTemp: number = 22;
  @State targetTemp: number = 24;
  @State isPowerOn: boolean = true;
  @State selectedMode: string = 'Cool';

  build() {
    Stack() {
      Column() {
        // Top Bar
        Row() {
          Text('≡')
            .fontSize(28)
            .fontColor('#999999')
            .width(40)
            .height(40)
            .textAlign(TextAlign.Center)

          Blank()

          Column() {
            Text('LIVING ROOM')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor('#999999')
              .letterSpacing(2)
              .margin({ bottom: 2 })

            Text(this.isPowerOn ? 'Active' : 'Off')
              .fontSize(11)
              .fontColor(this.isPowerOn ? '#4CAF50' : '#999999')
          }

          Blank()

          Text('⚙')
            .fontSize(24)
            .fontColor('#999999')
            .width(40)
            .height(40)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 24, bottom: 24 })

        // Temperature Circle Control
        Stack() {
          // Background Circle
          Circle()
            .width(280)
            .height(280)
            .fill(Color.White)
            .strokeWidth(1)
            .stroke('#EEEEEE')

          // Text Content
          Column() {
            Text(`${this.targetTemp}°`)
              .fontSize(96)
              .fontWeight(FontWeight.Lighter)
              .fontColor(this.isPowerOn ? '#000000' : '#D4D4D4')
              .margin({ bottom: 4 })

            Text(`CURRENT: ${this.currentTemp}°`)
              .fontSize(14)
              .fontColor('#999999')
          }

          // Buttons
          if (this.isPowerOn) {
            Row() {
              Button() {
                Text('∨')
                  .fontSize(20)
                  .fontColor('#000000')
              }
              .width(48)
              .height(48)
              .borderRadius(24)
              .backgroundColor('#F5F5F5')
              .onClick(() => {
                this.targetTemp -= 1;
              })
              .margin({ left: 20 })

              Blank()

              Button() {
                Text('+')
                  .fontSize(24)
                  .fontColor('#000000')
              }
              .width(48)
              .height(48)
              .borderRadius(24)
              .backgroundColor('#F5F5F5')
              .onClick(() => {
                this.targetTemp += 1;
              })
              .margin({ right: 20 })
            }
            .width(280)
          }
        }
        .width(280)
        .height(280)

        Blank()

        // Mode Selection
        Column() {
          Text('MODE')
            .fontSize(11)
            .fontWeight(FontWeight.Bold)
            .fontColor('#999999')
            .letterSpacing(1)
            .margin({ bottom: 16 })

          Row() {
            this.ModeButtonBuilder('🏠', 'Auto', this.selectedMode === 'Auto', this.isPowerOn, () => {
              this.selectedMode = 'Auto';
            })
            this.ModeButtonBuilder('↻', 'Fan', this.selectedMode === 'Fan', this.isPowerOn, () => {
              this.selectedMode = 'Fan';
            })
            this.ModeButtonBuilder('★', 'Cool', this.selectedMode === 'Cool', this.isPowerOn, () => {
              this.selectedMode = 'Cool';
            })
          }
          .justifyContent(FlexAlign.Center)
        }

        Blank()

        // Info Cards Row
        Row() {
          this.InfoCardBuilder('ℹ', '45%', 'Humidity')
          this.InfoCardBuilder('∧', '12 kWh', 'Energy')
        }
        .width('100%')
        .padding({ left: 24, right: 24 })

        Blank()

        // Power Switch
        Row() {
          Column() {
            Text('Master Power')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
              .margin({ bottom: 2 })

            Text(this.isPowerOn ? 'System is running' : 'System is off')
              .fontSize(12)
              .fontColor('#999999')
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
            .selectedColor('#000000')
            .switchPointColor('#FFFFFF')
            .onChange((isOn: boolean) => {
              this.isPowerOn = isOn;
            })
        }
        .width('100%')
        .padding(20)
        .backgroundColor('#FAFAFA')
        .borderRadius(16)
        .margin({ left: 24, right: 24, bottom: 40 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  ModeButtonBuilder(icon: string, label: string, isSelected: boolean, isEnabled: boolean, action: () => void) {
    Column() {
      Button() {
        Text(icon)
          .fontSize(24)
          .fontColor(
            isSelected && isEnabled ? '#FFFFFF' :
              (isEnabled ? '#000000' : '#D4D4D4')
          )
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor(isSelected && isEnabled ? '#000000' : '#FFFFFF')
      .border({
        width: !isSelected ? 1 : 0,
        color: '#E0E0E0'
      })
      .onClick(() => {
        if (isEnabled) {
          action();
        }
      })
      .enabled(isEnabled)
      .margin({ bottom: 8 })

      Text(label)
        .fontSize(11)
        .fontColor(isEnabled ? '#999999' : '#D4D4D4')
    }
    .margin({ left: 6, right: 6 })
  }

  @Builder
  InfoCardBuilder(icon: string, value: string, title: string) {
    Column() {
      Text(icon)
        .fontSize(20)
        .fontColor('#999999')
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: 8 })

      Text(value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: 8 })

      Text(title)
        .fontSize(12)
        .fontColor('#999999')
        .width('100%')
        .textAlign(TextAlign.Start)
    }
    .padding(16)
    .layoutWeight(1)
    .backgroundColor('#FAFAFA')
    .borderRadius(16)
    .border({ width: 1, color: '#F0F0F0' })
    .alignItems(HorizontalAlign.Start)
    .margin({ right: title === 'Humidity' ? 8 : 0 })
  }
}