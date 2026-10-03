@Entry
@Component
struct SmartHomeDashboard {
  @State homeSelected: boolean = true;
  @State awaySelected: boolean = false;
  @State sleepSelected: boolean = false;
  @State lampOn: boolean = true;
  @State thermostatOn: boolean = true;
  @State lockOn: boolean = false;
  @State wifiOn: boolean = true;

  build() {
    Scroll() {
      Column() {
        Column()
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
            Text('👤')
              .fontSize(24)
              .fontColor('#000000')
          }
          .width(48)
          .height(48)
          .backgroundColor('#FFFFFF')
          .borderRadius(24)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Column()
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
              Text('🔔')
                .fontSize(24)
                .fontColor('#FFFFFF')
            }
            .width(56)
            .height(56)
            .backgroundColor('rgba(255, 255, 255, 0.2)')
            .borderRadius(28)
          }
          .width('100%')
          .padding(24)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .backgroundColor('#5E60CE')
        .borderRadius(24)
        .shadow({ radius: 12, color: 'rgba(94, 96, 206, 0.3)', offsetX: 0, offsetY: 4 })

        Column()
          .height(32)

        Text('Scenes')
          .fontSize(20)
          .fontColor('#000000')
          .fontWeight(FontWeight.Bold)
          .width('100%')

        Column()
          .height(16)

        Row() {
          SceneButton({
            text: 'Home',
            icon: '🏠',
            isSelected: this.homeSelected,
            onSelect: () => {
              this.homeSelected = true;
              this.awaySelected = false;
              this.sleepSelected = false;
            }
          })
          SceneButton({
            text: 'Away',
            icon: '🔒',
            isSelected: this.awaySelected,
            onSelect: () => {
              this.homeSelected = false;
              this.awaySelected = true;
              this.sleepSelected = false;
            }
          })
          SceneButton({
            text: 'Sleep',
            icon: '⭐',
            isSelected: this.sleepSelected,
            onSelect: () => {
              this.homeSelected = false;
              this.awaySelected = false;
              this.sleepSelected = true;
            }
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)

        Column()
          .height(32)

        Text('Devices')
          .fontSize(20)
          .fontColor('#000000')
          .fontWeight(FontWeight.Bold)
          .width('100%')

        Column()
          .height(16)

        Row() {
          Column() {
            DeviceCard({
              name: 'Smart Lamp',
              icon: '⭐',
              isActive: this.lampOn,
              accentColor: '#FFC107',
              onChange: (val: boolean) => { this.lampOn = val; }
            })
            Column()
              .height(16)
            DeviceCard({
              name: 'Thermostat',
              icon: '☰',
              isActive: this.thermostatOn,
              accentColor: '#FF7043',
              onChange: (val: boolean) => { this.thermostatOn = val; }
            })
          }
          .width('50%')
          .margin({ right: 8 })

          Column() {
            DeviceCard({
              name: 'Main Lock',
              icon: '🔒',
              isActive: this.lockOn,
              accentColor: '#4CAF50',
              onChange: (val: boolean) => { this.lockOn = val; }
            })
            Column()
              .height(16)
            DeviceCard({
              name: 'Wi-Fi Router',
              icon: '⚙',
              isActive: this.wifiOn,
              accentColor: '#2196F3',
              onChange: (val: boolean) => { this.wifiOn = val; }
            })
          }
          .width('50%')
          .margin({ left: 8 })
        }
        .width('100%')

        Column()
          .height(24)
      }
      .width('100%')
      .padding(24)
      .backgroundColor('#F4F6F8')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F4F6F8')
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
  }
}

@Component
struct SceneButton {
  text: string = '';
  icon: string = '';
  isSelected: boolean = false;
  onSelect?: () => void;

  build() {
    Row() {
      Text(this.icon)
        .fontSize(18)
      Text(this.text)
        .fontSize(14)
        .fontColor(this.isSelected ? '#FFFFFF' : '#000000')
        .fontWeight(FontWeight.Medium)
        .margin({ left: 8 })
    }
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .backgroundColor(this.isSelected ? '#212121' : '#FFFFFF')
    .borderRadius(30)
    .margin({ right: 12 })
    .onClick(() => {
      if (this.onSelect !== undefined) {
        this.onSelect();
      }
    })
  }
}

@Component
struct DeviceCard {
  name: string = '';
  icon: string = '';
  @Link isActive: boolean = false;
  accentColor: string = '#FFC107';
  onChange?: (val: boolean) => void;

  build() {
    Column() {
      Row() {
        Stack() {
          Text(this.icon)
            .fontSize(24)
            .fontColor(this.isActive ? this.accentColor : '#888888')
        }
        .width(40)
        .height(40)
        .backgroundColor(this.isActive ? this.accentColor + '1A' : '#F0F0F0')
        .borderRadius(20)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

      Column() {
        Text(this.name)
          .fontSize(16)
          .fontColor('#000000')
          .fontWeight(FontWeight.Bold)
        Text(this.isActive ? 'On' : 'Off')
          .fontSize(14)
          .fontColor(this.isActive ? this.accentColor : '#888888')
          .fontWeight(FontWeight.Medium)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')

      Row() {
        Toggle({ type: ToggleType.Switch, isOn: this.isActive })
          .selectedColor(this.accentColor)
          .switchPointColor('#FFFFFF')
          .onChange((isOn: boolean) => {
            this.isActive = isOn;
            if (this.onChange !== undefined) {
              this.onChange(isOn);
            }
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .aspectRatio(0.85)
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.08)', offsetX: 0, offsetY: 2 })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}
