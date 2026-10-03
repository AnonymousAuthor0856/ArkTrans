@Entry
@Component
struct Index {
  @Builder
  sceneButton(text: string, icon: string, isSelected: boolean) {
    Row({ space: 8 }) {
      Text(icon)
        .fontSize(18)
        .fontColor(isSelected ? '#FFFFFF' : '#000000')
      Text(text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(isSelected ? '#FFFFFF' : '#000000')
    }
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .borderRadius(30)
    .backgroundColor(isSelected ? '#212121' : '#FFFFFF')
    .onClick(() => {
    })
  }

  build() {
    Column() {
      Scroll() {
        Column() {
          Blank().height(16)

          Row() {
            Column() {
              Text('Good Morning,')
                .fontSize(16)
                .fontColor('#808080')
                .fontWeight(FontWeight.Medium)
              Text('Alex Johnson')
                .fontSize(24)
                .fontColor('#000000')
                .fontWeight(FontWeight.Bold)
            }
            Stack() {
              Text('👤')
                .fontSize(24)
                .fontColor('#000000')
            }
            .width(48)
            .height(48)
            .borderRadius(24)
            .backgroundColor('#FFFFFF')
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          Blank().height(32)

          Row() {
            Column() {
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
            Stack() {
              Text('🔔')
                .fontSize(24)
                .fontColor('#FFFFFF')
            }
            .width(56)
            .height(56)
            .borderRadius(28)
            .backgroundColor('#33FFFFFF')
          }
          .width('100%')
          .padding(24)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .borderRadius(24)
          .backgroundColor('#5E60CE')
          .shadow({ radius: 8, color: '#22000000', offsetY: 4 })

          Blank().height(32)

          Text('Scenes')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')

          Blank().height(16)

          Row({ space: 12 }) {
            this.sceneButton('Home', '⌂', true)
            this.sceneButton('Away', '🔒', false)
            this.sceneButton('Sleep', '★', false)
          }
          .width('100%')

          Blank().height(32)

          Text('Devices')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')

          Blank().height(16)

          Row({ space: 16 }) {
            Column() {
              DeviceCard({ name: 'Smart Lamp', icon: '★', isActive: true, accentColor: '#FFC107' })
              Blank().height(16)
              DeviceCard({ name: 'Thermostat', icon: '☰', isActive: true, accentColor: '#FF7043' })
            }
            .layoutWeight(1)

            Column() {
              DeviceCard({ name: 'Main Lock', icon: '🔒', isActive: false, accentColor: '#4CAF50' })
              Blank().height(16)
              DeviceCard({ name: 'Wi-Fi Router', icon: '⚙', isActive: true, accentColor: '#2196F3' })
            }
            .layoutWeight(1)
          }
          .width('100%')

          Blank().height(24)
        }
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F4F6F8')
    .padding(24)
  }
}

@Component
struct DeviceCard {
  @Prop name: string = '';
  @Prop icon: string = '';
  @Prop isActive: boolean = false;
  @Prop accentColor: string = '#000000';
  @State switchState: boolean = false;

  aboutToAppear() {
    this.switchState = this.isActive;
  }

  build() {
    Column() {
      Row() {
        Stack() {
          Text(this.icon)
            .fontSize(20)
            .fontColor(this.switchState ? this.accentColor : '#808080')
        }
        .width(40)
        .height(40)
        .borderRadius(20)
        .backgroundColor(this.switchState ? '#1A' + this.accentColor.substring(1) : '#F0F0F0')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Column() {
        Text(this.name)
          .fontWeight(FontWeight.Bold)
          .fontSize(16)
          .fontColor('#000000')
        Blank().height(4)
        Text(this.switchState ? 'On' : 'Off')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.switchState ? this.accentColor : '#808080')
      }

      Row() {
        Toggle({ type: ToggleType.Switch, isOn: this.switchState })
          .selectedColor(this.accentColor)
          .switchPointColor('#FFFFFF')
          .onChange((isOn: boolean) => {
            this.switchState = isOn;
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .aspectRatio(0.85)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .borderRadius(20)
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 2, color: '#12000000', offsetY: 2 })
  }
}
