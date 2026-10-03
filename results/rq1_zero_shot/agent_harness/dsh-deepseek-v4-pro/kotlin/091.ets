@Entry
@Component
struct Index {
  @State currentTemp: number = 22
  @State targetTemp: number = 24
  @State isPowerOn: boolean = true
  @State selectedMode: string = 'Cool'

  build() {
    Column() {
      Row() {
        Stack() {
          Text('☰').fontSize(24).fontColor('#9E9E9E')
        }
        .width(48).height(48)
        .onClick(() => {})

        Column() {
          Text('LIVING ROOM')
            .fontSize(12)
            .fontColor('#9E9E9E')
            .fontWeight(FontWeight.Bold)
            .letterSpacing(2)
          if (this.isPowerOn) {
            Text('Active').fontSize(10).fontColor('#4CAF50')
          } else {
            Text('Off').fontSize(10).fontColor('#D3D3D3')
          }
        }
        .alignItems(HorizontalAlign.Center)

        Stack() {
          Text('⚙').fontSize(24).fontColor('#9E9E9E')
        }
        .width(48).height(48)
        .onClick(() => {})
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column() {
        Blank().height(10)

        Stack({ alignContent: Alignment.Center }) {
          Column() {
            Text(this.targetTemp + '°')
              .fontSize(96)
              .fontWeight(FontWeight.Lighter)
              .fontColor(this.isPowerOn ? '#000000' : '#D3D3D3')
            Text('CURRENT: ' + this.currentTemp + '°')
              .fontSize(14)
              .fontColor('#9E9E9E')
          }
          .alignItems(HorizontalAlign.Center)

          if (this.isPowerOn) {
            Stack() {
              Text('+').fontSize(24).fontColor('#000000')
            }
            .width(48).height(48)
            .borderRadius(24)
            .backgroundColor('#F5F5F5')
            .position({ x: 212, y: 116 })
            .onClick(() => { this.targetTemp++ })

            Stack() {
              Text('▼').fontSize(24).fontColor('#000000')
            }
            .width(48).height(48)
            .borderRadius(24)
            .backgroundColor('#F5F5F5')
            .position({ x: 20, y: 116 })
            .onClick(() => { this.targetTemp-- })
          }
        }
        .width(280).height(280)
        .borderRadius(140)
        .backgroundColor('#FFFFFF')
        .border({ width: 1, color: '#EEEEEE' })

        Column() {
          Text('MODE')
            .fontSize(10)
            .fontColor('#9E9E9E')
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 16 })
          Row({ space: 12 }) {
            ModeButton({ icon: '⌂', label: 'Auto', isSelected: this.selectedMode == 'Auto', enabled: this.isPowerOn, onClick: () => { this.selectedMode = 'Auto' } })
            ModeButton({ icon: '↻', label: 'Fan', isSelected: this.selectedMode == 'Fan', enabled: this.isPowerOn, onClick: () => { this.selectedMode = 'Fan' } })
            ModeButton({ icon: '★', label: 'Cool', isSelected: this.selectedMode == 'Cool', enabled: this.isPowerOn, onClick: () => { this.selectedMode = 'Cool' } })
          }
        }
        .alignItems(HorizontalAlign.Center)

        Row({ space: 16 }) {
          InfoCard({ title: 'Humidity', value: '45%', icon: 'ⓘ' }).layoutWeight(1)
          InfoCard({ title: 'Energy', value: '12 kWh', icon: '▲' }).layoutWeight(1)
        }
        .width('100%')

        Row() {
          Column() {
            Text('Master Power').fontSize(16).fontWeight(FontWeight.Bold)
            Text(this.isPowerOn ? 'System is running' : 'System is off')
              .fontSize(12).fontColor('#9E9E9E')
          }
          Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
            .selectedColor('#000000')
            .switchPointColor('#FFFFFF')
            .onChange((isOn: boolean) => { this.isPowerOn = isOn })
        }
        .width('100%')
        .margin({ bottom: 40 })
        .backgroundColor('#F9F9F9')
        .borderRadius(16)
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 24, right: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct ModeButton {
  @Prop icon: string = ''
  @Prop label: string = ''
  @Prop isSelected: boolean = false
  @Prop enabled: boolean = true
  onClick: () => void = () => {}

  build() {
    const containerColor = (this.isSelected && this.enabled) ? '#000000' : (this.enabled ? '#FFFFFF' : '#F5F5F5')
    const contentColor = (this.isSelected && this.enabled) ? '#FFFFFF' : (this.enabled ? '#000000' : '#D3D3D3')
    const borderColor = (this.isSelected && this.enabled) ? '#000000' : '#E0E0E0'

    Column() {
      Button({ type: ButtonType.Circle }) {
        Text(this.icon).fontSize(24).fontColor(contentColor)
      }
      .width(60).height(60)
      .backgroundColor(containerColor)
      .border({ width: this.isSelected ? 0 : 1, color: borderColor })
      .enabled(this.enabled)
      .onClick(() => { this.onClick() })

      Blank().height(8)

      Text(this.label)
        .fontSize(10)
        .fontColor(this.enabled ? '#9E9E9E' : '#D3D3D3')
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct InfoCard {
  @Prop title: string = ''
  @Prop value: string = ''
  @Prop icon: string = ''

  build() {
    Column({ space: 8 }) {
      Text(this.icon).fontSize(20).fontColor('#9E9E9E')
      Text(this.value).fontSize(24).fontWeight(FontWeight.Bold)
      Text(this.title).fontSize(12).fontColor('#9E9E9E')
    }
    .padding(16)
    .borderRadius(16)
    .backgroundColor('#F9F9F9')
    .border({ width: 1, color: '#F0F0F0' })
  }
}
