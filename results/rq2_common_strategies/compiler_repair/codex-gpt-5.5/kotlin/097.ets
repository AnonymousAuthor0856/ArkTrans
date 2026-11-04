@Entry
@Component
struct Index {
  @State targetTemp: number = 21.5
  @State isActive: boolean = true

  build() {
    Column() {
      this.HeaderSection()
      this.TemperatureDialSection()
      this.ControlGridSection()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(Color.White)
  }

  @Builder
  HeaderSection() {
    Row() {
      Button('☰')
        .fontSize(22)
        .fontColor('#1C1C1E')
        .backgroundColor(Color.Transparent)
        .width(48)
        .height(48)
        .padding(0)
      Column() {
        Text('LIVING ROOM')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#8E8E93')
        Text('Connected')
          .fontSize(13)
          .fontColor('#007AFF')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Center)
      Button('⚙')
        .fontSize(22)
        .fontColor('#1C1C1E')
        .backgroundColor(Color.Transparent)
        .width(48)
        .height(48)
        .padding(0)
    }
    .width('100%')
    .padding({ top: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TemperatureDialSection() {
    Column() {
      Stack() {
        Circle()
          .width(240)
          .height(240)
          .fill(Color.Transparent)
          .stroke('#F2F2F7')
          .strokeWidth(40)
        Circle()
          .width(190)
          .height(190)
          .fill(Color.Transparent)
          .stroke(this.isActive ? '#007AFF' : '#8E8E93')
          .strokeWidth(24)
        Circle()
          .width(20)
          .height(20)
          .fill(this.isActive ? '#007AFF' : '#8E8E93')
          .margin({ left: 134, bottom: 134 })
        Column() {
          Text(this.formatTemp() + '°')
            .fontSize(48)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? '#1C1C1E' : '#8E8E93')
          Text(this.isActive ? 'COOLING' : 'OFF')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#8E8E93')
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(280)
      .height(280)

      Row() {
        this.RoundControlButton('⌄', -0.5)
        Toggle({ type: ToggleType.Switch, isOn: this.isActive })
          .selectedColor('#1C1C1E')
          .onChange((on: boolean) => {
            this.isActive = on
          })
          .margin({ left: 32, right: 32 })
        this.RoundControlButton('⌃', 0.5)
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .margin({ top: 32 })
    }
    .alignItems(HorizontalAlign.Center)
    .margin({ top: 40 })
  }

  @Builder
  RoundControlButton(icon: string, delta: number) {
    Button(icon)
      .fontSize(28)
      .fontColor(this.isActive ? '#1C1C1E' : '#D1D1D6')
      .width(56)
      .height(56)
      .borderRadius(28)
      .border({ width: this.isActive ? 0 : 1, color: '#EEEEEE' })
      .backgroundColor(this.isActive ? '#F2F2F7' : '#F9F9F9')
      .padding(0)
      .enabled(this.isActive)
      .onClick(() => {
        let next = this.targetTemp + delta
        if (next < 16) {
          next = 16
        }
        if (next > 30) {
          next = 30
        }
        this.targetTemp = Math.round(next * 10) / 10
      })
  }

  @Builder
  ControlGridSection() {
    Column() {
      Text('QUICK ACTIONS')
        .width('100%')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor('#8E8E93')
        .margin({ bottom: 16 })
      Row() {
        this.QuickActionCard('↻', 'Fan Speed', 'Auto', false)
        this.QuickActionCard('♥', 'Eco Mode', 'On', true)
      }
      .width('100%')
      .margin({ bottom: 16 })
      Row() {
        this.QuickActionCard('i', 'Timer', 'Set 2h', false)
        this.QuickActionCard('⌂', 'Away', 'Off', false)
      }
      .width('100%')
    }
    .width('100%')
    .margin({ top: 40 })
  }

  @Builder
  QuickActionCard(icon: string, label: string, status: string, active: boolean) {
    Column() {
      Text(icon)
        .fontSize(24)
        .fontColor(active ? Color.White : '#1C1C1E')
      Column() {
        Text(label)
          .fontSize(13)
          .fontWeight(FontWeight.Bold)
          .fontColor(active ? Color.White : '#1C1C1E')
        Text(status)
          .fontSize(12)
          .fontColor('#8E8E93')
          .margin({ top: 2 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .height(100)
    .layoutWeight(1)
    .padding(16)
    .borderRadius(20)
    .backgroundColor(active ? '#1C1C1E' : '#F2F2F7')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
    .margin({ left: 8, right: 8 })
  }

  formatTemp(): string {
    return this.targetTemp.toFixed(1)
  }
}
