class AppTokens {
  static readonly Colors = {
    black: '#FF000000',
    white: '#FFFFFFFF',
    gray: '#FF888888',
    lightGray: '#FFBDBDBD',
    green: '#FF4CAF50',
    circleBorder: '#FFEEEEEE',
    buttonBg: '#FFF5F5F5',
    cardBg: '#FFF9F9F9',
    modeBorder: '#FFE0E0E0',
    infoBorder: '#FFF0F0F0',
    transparent: '#00000000'
  }
}

@Entry
@Component
struct ThermostatScreen {
  @State currentTemp: number = 22
  @State targetTemp: number = 24
  @State isPowerOn: boolean = true
  @State selectedMode: string = 'Cool'

  build() {
    Column() {
      Row() {
        Text('☰')
          .fontSize(24)
          .fontColor(AppTokens.Colors.gray)
          .width(40)
          .height(40)
          .textAlign(TextAlign.Center)

        Column() {
          Text('LIVING ROOM')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(2)
            .fontColor(AppTokens.Colors.gray)
          if (this.isPowerOn) {
            Text('Active')
              .fontSize(10)
              .fontColor(AppTokens.Colors.green)
              .margin({ top: 2 })
          } else {
            Text('Off')
              .fontSize(10)
              .fontColor(AppTokens.Colors.lightGray)
              .margin({ top: 2 })
          }
        }
        .alignItems(HorizontalAlign.Center)

        Text('⚙')
          .fontSize(24)
          .fontColor(AppTokens.Colors.gray)
          .width(40)
          .height(40)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding({ top: 24, bottom: 24, left: 24, right: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Stack() {
        Column()
          .width(280)
          .height(280)
          .borderRadius(140)
          .backgroundColor(AppTokens.Colors.white)
          .border({ width: 1, color: AppTokens.Colors.circleBorder })

        Column() {
          Text(`${this.targetTemp}°`)
            .fontSize(96)
            .fontWeight(FontWeight.Light)
            .fontColor(this.isPowerOn ? AppTokens.Colors.black : AppTokens.Colors.lightGray)
          Text(`CURRENT: ${this.currentTemp}°`)
            .fontSize(14)
            .fontColor(AppTokens.Colors.gray)
            .margin({ top: 8 })
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        if (this.isPowerOn) {
          Row() {
            Text('+')
              .fontSize(24)
              .fontColor(AppTokens.Colors.black)
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor(AppTokens.Colors.buttonBg)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .position({ x: 212, y: 116 })
          .onClick(() => {
            this.targetTemp += 1
          })

          Row() {
            Text('↓')
              .fontSize(24)
              .fontColor(AppTokens.Colors.black)
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor(AppTokens.Colors.buttonBg)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .position({ x: 20, y: 116 })
          .onClick(() => {
            this.targetTemp -= 1
          })
        }
      }
      .width(280)
      .height(280)
      .margin({ top: 10 })

      Column() {
        Text('MODE')
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.gray)
          .margin({ bottom: 16 })

        Row() {
          ModeButton({
            icon: '⌂',
            label: 'Auto',
            isSelected: this.selectedMode === 'Auto',
            enabled: this.isPowerOn,
            onClick: () => {
              this.selectedMode = 'Auto'
            }
          })
          ModeButton({
            icon: '↻',
            label: 'Fan',
            isSelected: this.selectedMode === 'Fan',
            enabled: this.isPowerOn,
            onClick: () => {
              this.selectedMode = 'Fan'
            }
          })
            .margin({ left: 12 })
          ModeButton({
            icon: '★',
            label: 'Cool',
            isSelected: this.selectedMode === 'Cool',
            enabled: this.isPowerOn,
            onClick: () => {
              this.selectedMode = 'Cool'
            }
          })
            .margin({ left: 12 })
        }
        .justifyContent(FlexAlign.Center)
      }
      .alignItems(HorizontalAlign.Center)

      Row() {
        InfoCard({ title: 'Humidity', value: '45%', icon: 'ℹ' })
          .layoutWeight(1)
        InfoCard({ title: 'Energy', value: '12 kWh', icon: '↑' })
          .layoutWeight(1)
          .margin({ left: 16 })
      }
      .width('100%')

      Row() {
        Column() {
          Text('Master Power')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.black)
          Text(this.isPowerOn ? 'System is running' : 'System is off')
            .fontSize(12)
            .fontColor(AppTokens.Colors.gray)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)

        Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
          .selectedColor(AppTokens.Colors.black)
          .onChange((isOn: boolean) => {
            this.isPowerOn = isOn
          })
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .borderRadius(16)
      .backgroundColor(AppTokens.Colors.cardBg)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: 40 })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24 })
    .backgroundColor(AppTokens.Colors.white)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct ModeButton {
  @Prop icon: string
  @Prop label: string
  @Prop isSelected: boolean
  @Prop enabled: boolean
  onClick: () => void = () => {}

  build() {
    Column() {
      Row() {
        Text(this.icon)
          .fontSize(24)
          .fontColor(this.isSelected && this.enabled ? AppTokens.Colors.white :
            (this.enabled ? AppTokens.Colors.black : AppTokens.Colors.lightGray))
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor(this.isSelected && this.enabled ? AppTokens.Colors.black : AppTokens.Colors.white)
      .border({
        width: 1,
        color: this.isSelected && this.enabled ? AppTokens.Colors.black : AppTokens.Colors.modeBorder
      })
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .onClick(() => {
        if (this.enabled) {
          this.onClick()
        }
      })

      Text(this.label)
        .fontSize(10)
        .fontColor(this.enabled ? AppTokens.Colors.gray : AppTokens.Colors.lightGray)
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct InfoCard {
  @Prop title: string
  @Prop value: string
  @Prop icon: string

  build() {
    Column() {
      Text(this.icon)
        .fontSize(20)
        .fontColor(AppTokens.Colors.gray)
      Text(this.value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.black)
        .margin({ top: 8 })
      Text(this.title)
        .fontSize(12)
        .fontColor(AppTokens.Colors.gray)
        .margin({ top: 4 })
    }
    .padding(16)
    .borderRadius(16)
    .backgroundColor(AppTokens.Colors.cardBg)
    .border({ width: 1, color: AppTokens.Colors.infoBorder })
    .alignItems(HorizontalAlign.Start)
  }
}