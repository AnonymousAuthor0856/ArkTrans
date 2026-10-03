class ThColors {
  static readonly white: string = '#FFFFFFFF'
  static readonly black: string = '#FF000000'
  static readonly gray: string = '#FF808080'
  static readonly green: string = '#FF4CAF50'
  static readonly circleStroke: string = '#FFEEEEEE'
  static readonly lightGray: string = '#FFD4D4D4'
  static readonly buttonBg: string = '#FFF5F5F5'
  static readonly modeStroke: string = '#FFE0E0E0'
  static readonly infoBg: string = '#FFF9F9F9'
  static readonly infoBorder: string = '#FFF0F0F0'
}

@Entry
@Component
struct Index {
  @State currentTemp: number = 22
  @State targetTemp: number = 24
  @State isPowerOn: boolean = true
  @State selectedMode: string = 'Cool'

  build() {
    Stack() {
      Column() {
        Row() {
          Text('☰')
            .fontSize(24)
            .fontColor(ThColors.gray)

          Blank()

          Column() {
            Text('LIVING ROOM')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(ThColors.gray)

            Text(this.isPowerOn ? 'Active' : 'Off')
              .fontSize(11)
              .fontColor(this.isPowerOn ? ThColors.green : ThColors.gray)
              .margin({ top: 2 })
          }

          Blank()

          Text('⚙')
            .fontSize(24)
            .fontColor(ThColors.gray)
        }
        .padding({ left: 24, right: 24, top: 24, bottom: 24 })

        Blank().height(10)

        Stack() {
          Column() {
            Text(`${this.targetTemp}°`)
              .fontSize(96)
              .fontWeight(FontWeight.Lighter)
              .fontColor(this.isPowerOn ? ThColors.black : ThColors.lightGray)

            Text(`CURRENT: ${this.currentTemp}°`)
              .fontSize(14)
              .fontColor(ThColors.gray)
          }

          if (this.isPowerOn) {
            Row() {
              Text('▼')
                .fontSize(24)
                .fontColor(ThColors.black)
                .width(48)
                .height(48)
                .textAlign(TextAlign.Center)
                .backgroundColor(ThColors.buttonBg)
                .borderRadius(24)
                .onClick(() => {
                  this.targetTemp -= 1
                })

              Blank()

              Text('+')
                .fontSize(24)
                .fontColor(ThColors.black)
                .width(48)
                .height(48)
                .textAlign(TextAlign.Center)
                .backgroundColor(ThColors.buttonBg)
                .borderRadius(24)
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
        .backgroundColor(ThColors.white)
        .border({ width: 1, color: ThColors.circleStroke, radius: 140 })

        Blank()

        Column() {
          Text('MODE')
            .fontSize(11)
            .fontWeight(FontWeight.Bold)
            .fontColor(ThColors.gray)

          Row() {
            ModeButton({ iconName: '⌂', label: 'Auto', isSelected: this.selectedMode === 'Auto', isEnabled: this.isPowerOn })
              .onClick(() => { if (this.isPowerOn) this.selectedMode = 'Auto' })
            ModeButton({ iconName: '↻', label: 'Fan', isSelected: this.selectedMode === 'Fan', isEnabled: this.isPowerOn })
              .onClick(() => { if (this.isPowerOn) this.selectedMode = 'Fan' })
            ModeButton({ iconName: '★', label: 'Cool', isSelected: this.selectedMode === 'Cool', isEnabled: this.isPowerOn })
              .onClick(() => { if (this.isPowerOn) this.selectedMode = 'Cool' })
          }
          .margin({ top: 16 })
        }
        .margin({ top: 16 })

        Blank()

        Row() {
          Column() {
            Text('ⓘ')
              .fontSize(20)
              .fontColor(ThColors.gray)
            Text('45%')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(ThColors.black)
              .margin({ top: 8 })
            Text('Humidity')
              .fontSize(12)
              .fontColor(ThColors.gray)
          }
          .padding(16)
          .layoutWeight(1)
          .backgroundColor(ThColors.infoBg)
          .borderRadius(16)
          .border({ width: 1, color: ThColors.infoBorder })
          .alignItems(HorizontalAlign.Start)

          Column() {
            Text('▲')
              .fontSize(20)
              .fontColor(ThColors.gray)
            Text('12 kWh')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(ThColors.black)
              .margin({ top: 8 })
            Text('Energy')
              .fontSize(12)
              .fontColor(ThColors.gray)
          }
          .padding(16)
          .layoutWeight(1)
          .backgroundColor(ThColors.infoBg)
          .borderRadius(16)
          .border({ width: 1, color: ThColors.infoBorder })
          .alignItems(HorizontalAlign.Start)
          .margin({ left: 16 })
        }
        .padding({ left: 24, right: 24 })

        Blank()

        Row() {
          Column() {
            Text('Master Power')
              .fontSize(16)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(ThColors.black)
            Text(this.isPowerOn ? 'System is running' : 'System is off')
              .fontSize(12)
              .fontColor(ThColors.gray)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
            .selectedColor(ThColors.black)
            .onChange((isOn: boolean) => {
              this.isPowerOn = isOn
            })
        }
        .padding(20)
        .backgroundColor(ThColors.infoBg)
        .borderRadius(16)
        .padding({ left: 24, right: 24, bottom: 40 })
      }
    }
    .backgroundColor(ThColors.white)
    .width('100%')
    .height('100%')
  }
}

@Component
struct ModeButton {
  @Prop iconName: string = ''
  @Prop label: string = ''
  @Prop isSelected: boolean = false
  @Prop isEnabled: boolean = false

  build() {
    Column() {
      Text(this.iconName)
        .fontSize(24)
        .width(60)
        .height(60)
        .textAlign(TextAlign.Center)
        .fontColor(
          this.isSelected && this.isEnabled ? ThColors.white :
            (this.isEnabled ? ThColors.black : ThColors.lightGray)
        )
        .backgroundColor(this.isSelected && this.isEnabled ? ThColors.black : ThColors.white)
        .borderRadius(30)
        .border({ width: this.isSelected ? 0 : 1, color: ThColors.modeStroke })

      Text(this.label)
        .fontSize(11)
        .fontColor(this.isEnabled ? ThColors.gray : ThColors.lightGray)
        .margin({ top: 8 })
    }
    .margin({ right: 12 })
  }
}