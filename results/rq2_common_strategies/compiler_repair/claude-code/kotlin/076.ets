@Entry
@Component
struct SmartHomeDashboard {
  @State sceneSelected: string = 'Home'
  @State lampOn: boolean = true
  @State thermostatOn: boolean = true
  @State lockOn: boolean = false
  @State routerOn: boolean = true

  build() {
    Column() {
      Column() {
        Blank()
          .height(16)

        Row() {
          Column() {
            Text('Good Morning,')
              .fontSize(16)
              .fontColor('#888888')
              .fontWeight(FontWeight.Medium)
            Text('Alex Johnson')
              .fontSize(24)
              .fontColor('#000000')
              .fontWeight(FontWeight.Bold)
              .margin({ top: 2 })
          }
          .alignItems(HorizontalAlign.Start)

          Stack() {
            Text('')
              .fontSize(24)
              .fontColor('#000000')
          }
          .width(48)
          .height(48)
          .backgroundColor('#FFFFFF')
          .borderRadius(24)
          .alignContent(Alignment.Center)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Blank()
          .height(32)

        Stack() {
          Row() {
            Column() {
              Text('Energy Usage')
                .fontSize(14)
                .fontColor('rgba(255, 255, 255, 0.8)')
              Text('28.5 kWh')
                .fontSize(32)
                .fontColor('#FFFFFF')
                .fontWeight(FontWeight.Bold)
                .margin({ top: 4 })
              Text('Today')
                .fontSize(12)
                .fontColor('rgba(255, 255, 255, 0.6)')
                .margin({ top: 4 })
            }
            .alignItems(HorizontalAlign.Start)

            Stack() {
              Text('')
                .fontSize(24)
                .fontColor('#FFFFFF')
            }
            .width(56)
            .height(56)
            .backgroundColor('rgba(255, 255, 255, 0.2)')
            .borderRadius(28)
            .alignContent(Alignment.Center)
          }
          .width('100%')
          .padding(24)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .backgroundColor('#5E60CE')
        .borderRadius(24)
        .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.15)', offsetY: 4 })

        Blank()
          .height(32)

        Text('Scenes')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .width('100%')

        Blank()
          .height(16)

        Row() {
          SceneButton({ text: 'Home', icon: '', isSelected: this.sceneSelected === 'Home',
            onTap: () => { this.sceneSelected = 'Home' } })
          SceneButton({ text: 'Away', icon: '', isSelected: this.sceneSelected === 'Away',
            onTap: () => { this.sceneSelected = 'Away' } })
          SceneButton({ text: 'Sleep', icon: '', isSelected: this.sceneSelected === 'Sleep',
            onTap: () => { this.sceneSelected = 'Sleep' } })
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)

        Blank()
          .height(32)

        Text('Devices')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .width('100%')

        Blank()
          .height(16)

        Row() {
          Column() {
            DeviceCard({ name: 'Smart Lamp', icon: '', isActive: this.lampOn, accentColor: '#FFC107',
              onToggle: (v: boolean) => { this.lampOn = v } })
            Blank()
              .height(16)
            DeviceCard({ name: 'Thermostat', icon: '', isActive: this.thermostatOn, accentColor: '#FF7043',
              onToggle: (v: boolean) => { this.thermostatOn = v } })
          }
          .layoutWeight(1)

          Blank()
            .width(16)

          Column() {
            DeviceCard({ name: 'Main Lock', icon: '', isActive: this.lockOn, accentColor: '#4CAF50',
              onToggle: (v: boolean) => { this.lockOn = v } })
            Blank()
              .height(16)
            DeviceCard({ name: 'Wi-Fi Router', icon: '', isActive: this.routerOn, accentColor: '#2196F3',
              onToggle: (v: boolean) => { this.routerOn = v } })
          }
          .layoutWeight(1)
        }
        .width('100%')

        Blank()
          .height(24)
      }
      .width('100%')
      .padding(24)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F4F6F8')
    .justifyContent(FlexAlign.Start)
  }
}

@Component
struct SceneButton {
  text: string = ''
  icon: string = ''
  isSelected: boolean = false
  onTap: () => void = () => {}

  build() {
    Stack() {
      Row() {
        Text(this.icon)
          .fontSize(18)
          .fontColor(this.isSelected ? '#FFFFFF' : '#000000')
        Blank()
          .width(8)
        Text(this.text)
          .fontSize(14)
          .fontColor(this.isSelected ? '#FFFFFF' : '#000000')
          .fontWeight(FontWeight.Medium)
      }
      .alignItems(VerticalAlign.Center)
    }
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .backgroundColor(this.isSelected ? '#212121' : '#FFFFFF')
    .borderRadius(30)
    .onClick(() => {
      this.onTap()
    })
  }
}

@Component
struct DeviceCard {
  name: string = ''
  icon: string = ''
  isActive: boolean = false
  accentColor: string = ''
  onToggle: (value: boolean) => void = (_v: boolean) => {}

  build() {
    Stack() {
      Column() {
        Row() {
          Stack() {
            Text(this.icon)
              .fontSize(24)
              .fontColor(this.isActive ? this.accentColor : '#888888')
          }
          .width(40)
          .height(40)
          .backgroundColor(this.isActive ? this.hexWithAlpha(this.accentColor, 0.1) : '#F0F0F0')
          .borderRadius(20)
          .alignContent(Alignment.Center)

          Blank()
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Column() {
          Text(this.name)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
          Blank()
            .height(4)
          Text(this.isActive ? 'On' : 'Off')
            .fontSize(14)
            .fontColor(this.isActive ? this.accentColor : '#888888')
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')

        Row() {
          Toggle({ type: ToggleType.Switch, isOn: this.isActive })
            .selectedColor(this.accentColor)
            .switchPointColor('#FFFFFF')
            .onChange((value: boolean) => {
              this.onToggle(value)
            })
            .scale({ x: 0.8, y: 0.8 })
        }
        .width('100%')
        .justifyContent(FlexAlign.End)
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .aspectRatio(0.85)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.08)', offsetY: 1 })
  }

  hexWithAlpha(hex: string, alpha: number): string {
    const r = parseInt(hex.slice(1, 3), 16)
    const g = parseInt(hex.slice(3, 5), 16)
    const b = parseInt(hex.slice(5, 7), 16)
    return `rgba(${r}, ${g}, ${b}, ${alpha})`
  }
}
