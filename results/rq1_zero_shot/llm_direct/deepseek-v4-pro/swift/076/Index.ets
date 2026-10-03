@Entry
@Component
struct SmartHomeDashboard {
  @State lampOn: boolean = true
  @State thermostatOn: boolean = true
  @State lockOn: boolean = false
  @State routerOn: boolean = true

  build() {
    Column() {
      Scroll() {
        Column({ space: 0 }) {
          // Header
          Row() {
            Column({ space: 0 }) {
              Text('Good Morning,')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#808080')
              Text('Alex Johnson')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Stack() {
              Circle()
                .fill('#FFFFFF')
                .width(48)
                .height(48)
              Text('👤')
                .fontSize(24)
            }
          }
          .width('100%')
          .padding({ left: 24, right: 24 })

          Blank().height(32)

          // Energy Usage Card
          Column() {
            Row() {
              Column({ space: 0 }) {
                Text('Energy Usage')
                  .fontSize(14)
                  .fontColor('#CCFFFFFF')
                Text('28.5 kWh')
                  .fontSize(32)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#FFFFFF')
                Text('Today')
                  .fontSize(12)
                  .fontColor('#99FFFFFF')
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              Stack() {
                Circle()
                  .fill('#33FFFFFF')
                  .width(56)
                  .height(56)
                Text('🔔')
                  .fontSize(24)
              }
            }
            .width('100%')
            .padding(24)
          }
          .width('100%')
          .backgroundColor('#5E60CE')
          .borderRadius(24)
          .shadow({ radius: 8, color: '#1A000000', offsetX: 0, offsetY: 4 })
          .padding({ left: 24, right: 24 })

          Blank().height(32)

          // Scenes Section
          Text('Scenes')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .padding({ left: 24, right: 24 })
            .width('100%')
            .textAlign(TextAlign.Start)

          Blank().height(16)

          // Scenes Scroll
          Scroll() {
            Row({ space: 12 }) {
              SceneButton({ text: 'Home', icon: '🏠', isSelected: true })
              SceneButton({ text: 'Away', icon: '🔒', isSelected: false })
              SceneButton({ text: 'Sleep', icon: '⭐', isSelected: false })
            }
            .padding({ left: 24, right: 24 })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          Blank().height(32)

          // Devices Section
          Text('Devices')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .padding({ left: 24, right: 24 })
            .width('100%')
            .textAlign(TextAlign.Start)

          Blank().height(16)

          // Devices Grid
          Row({ space: 16 }) {
            Column({ space: 16 }) {
              DeviceCard({
                name: 'Smart Lamp',
                icon: '💡',
                isOn: this.lampOn,
                accentColor: '#FFC107',
                onToggle: (val: boolean) => { this.lampOn = val }
              })
              DeviceCard({
                name: 'Thermostat',
                icon: '🌡️',
                isOn: this.thermostatOn,
                accentColor: '#FF7043',
                onToggle: (val: boolean) => { this.thermostatOn = val }
              })
            }
            .layoutWeight(1)

            Column({ space: 16 }) {
              DeviceCard({
                name: 'Main Lock',
                icon: '🔐',
                isOn: this.lockOn,
                accentColor: '#4CAF50',
                onToggle: (val: boolean) => { this.lockOn = val }
              })
              DeviceCard({
                name: 'Wi-Fi Router',
                icon: '📶',
                isOn: this.routerOn,
                accentColor: '#2196F3',
                onToggle: (val: boolean) => { this.routerOn = val }
              })
            }
            .layoutWeight(1)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })

          Blank().height(24)
        }
        .width('100%')
        .padding({ top: 24, bottom: 24 })
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
      .align(Alignment.Top)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F4F6F8')
  }
}

@Component
struct SceneButton {
  text: string = ''
  icon: string = ''
  isSelected: boolean = false

  build() {
    Row({ space: 8 }) {
      Text(this.icon)
        .fontSize(18)
      Text(this.text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? '#FFFFFF' : '#000000')
    }
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .backgroundColor(this.isSelected ? '#212121' : '#FFFFFF')
    .borderRadius(30)
  }
}

@Component
struct DeviceCard {
  name: string = ''
  icon: string = ''
  isOn: boolean = false
  accentColor: string = '#000000'
  onToggle: (val: boolean) => void = () => {}

  build() {
    Column({ space: 0 }) {
      Row() {
        Stack() {
          Circle()
            .fill(this.isOn ? this.accentColor + '1A' : '#F0F0F0')
            .width(40)
            .height(40)
          Text(this.icon)
            .fontSize(20)
        }

        Blank()
      }
      .width('100%')

      Blank()
        .layoutWeight(1)

      Column({ space: 4 }) {
        Text(this.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Text(this.isOn ? 'On' : 'Off')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isOn ? this.accentColor : '#808080')
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')

      Blank()
        .layoutWeight(1)

      Row() {
        Blank()
        Toggle({ type: ToggleType.Switch, isOn: this.isOn })
          .selectedColor(this.accentColor)
          .onChange((isOn: boolean) => {
            this.onToggle(isOn)
          })
          .width(40)
          .height(24)
      }
      .width('100%')
    }
    .padding(16)
    .width('100%')
    .aspectRatio(0.85)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 2, color: '#0D000000', offsetX: 0, offsetY: 1 })
  }
}