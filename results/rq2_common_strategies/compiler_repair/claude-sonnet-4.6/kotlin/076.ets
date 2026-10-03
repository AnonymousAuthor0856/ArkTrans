import { router } from '@kit.ArkUI';

@Entry
@Component
struct SmartHomeDashboard {
  @State smartLampOn: boolean = true;
  @State thermostatOn: boolean = true;
  @State mainLockOn: boolean = false;
  @State wifiRouterOn: boolean = true;
  @State selectedScene: string = 'Home';

  build() {
    Scroll() {
      Column() {
        // Header
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
          }
          .alignItems(HorizontalAlign.Start)

          Stack() {
            Circle()
              .width(48)
              .height(48)
              .fill('#FFFFFF')
            Text('👤')
              .fontSize(22)
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 16 })

        // Energy Card
        Column() {
          Row() {
            Column() {
              Text('Energy Usage')
                .fontColor('rgba(255,255,255,0.8)')
                .fontSize(14)
              Text('28.5 kWh')
                .fontColor('#FFFFFF')
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
              Text('Today')
                .fontColor('rgba(255,255,255,0.6)')
                .fontSize(12)
            }
            .alignItems(HorizontalAlign.Start)

            Stack() {
              Circle()
                .width(56)
                .height(56)
                .fill('rgba(255,255,255,0.2)')
              Text('🔔')
                .fontSize(24)
            }
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .padding(24)
        }
        .width('100%')
        .borderRadius(24)
        .backgroundColor('#5E60CE')
        .margin({ top: 32 })
        .shadow({ radius: 12, color: 'rgba(94,96,206,0.3)', offsetX: 0, offsetY: 4 })

        // Scenes Section
        Text('Scenes')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .width('100%')
          .margin({ top: 32, bottom: 16 })

        Row() {
          SceneButton({
            text: 'Home',
            icon: '🏠',
            isSelected: this.selectedScene === 'Home',
            onSelect: () => { this.selectedScene = 'Home'; }
          })
          SceneButton({
            text: 'Away',
            icon: '🔒',
            isSelected: this.selectedScene === 'Away',
            onSelect: () => { this.selectedScene = 'Away'; }
          })
          SceneButton({
            text: 'Sleep',
            icon: '⭐',
            isSelected: this.selectedScene === 'Sleep',
            onSelect: () => { this.selectedScene = 'Sleep'; }
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)

        // Devices Section
        Text('Devices')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .width('100%')
          .margin({ top: 32, bottom: 16 })

        Row() {
          // Left Column
          Column() {
            DeviceCard({
              name: 'Smart Lamp',
              icon: '💡',
              isActive: this.smartLampOn,
              accentColor: '#FFC107',
              accentColorLight: 'rgba(255,193,7,0.1)',
              onToggle: (val: boolean) => { this.smartLampOn = val; }
            })
            Blank().height(16)
            DeviceCard({
              name: 'Thermostat',
              icon: '🌡️',
              isActive: this.thermostatOn,
              accentColor: '#FF7043',
              accentColorLight: 'rgba(255,112,67,0.1)',
              onToggle: (val: boolean) => { this.thermostatOn = val; }
            })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)

          Blank().width(16)

          // Right Column
          Column() {
            DeviceCard({
              name: 'Main Lock',
              icon: '🔐',
              isActive: this.mainLockOn,
              accentColor: '#4CAF50',
              accentColorLight: 'rgba(76,175,80,0.1)',
              onToggle: (val: boolean) => { this.mainLockOn = val; }
            })
            Blank().height(16)
            DeviceCard({
              name: 'Wi-Fi Router',
              icon: '📡',
              isActive: this.wifiRouterOn,
              accentColor: '#2196F3',
              accentColorLight: 'rgba(33,150,243,0.1)',
              onToggle: (val: boolean) => { this.wifiRouterOn = val; }
            })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)

        Blank().height(24)
      }
      .padding(24)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F4F6F8')
    .scrollBar(BarState.Off)
  }
}

@Component
struct SceneButton {
  text: string = '';
  icon: string = '';
  isSelected: boolean = false;
  onSelect: () => void = () => {};

  build() {
    Row() {
      Text(this.icon)
        .fontSize(16)
      Text(this.text)
        .fontColor(this.isSelected ? '#FFFFFF' : '#000000')
        .fontWeight(FontWeight.Medium)
        .fontSize(14)
        .margin({ left: 6 })
    }
    .padding({ left: 16, right: 16, top: 10, bottom: 10 })
    .borderRadius(30)
    .backgroundColor(this.isSelected ? '#212121' : '#FFFFFF')
    .margin({ right: 10 })
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      this.onSelect();
    })
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.08)', offsetX: 0, offsetY: 2 })
  }
}

@Component
struct DeviceCard {
  name: string = '';
  icon: string = '';
  isActive: boolean = false;
  accentColor: string = '#000000';
  accentColorLight: string = 'rgba(0,0,0,0.1)';
  onToggle: (val: boolean) => void = () => {};
  @State switchState: boolean = false;

  aboutToAppear() {
    this.switchState = this.isActive;
  }

  build() {
    Column() {
      // Icon Row
      Row() {
        Stack() {
          Circle()
            .width(40)
            .height(40)
            .fill(this.switchState ? this.accentColorLight : '#F0F0F0')
          Text(this.icon)
            .fontSize(20)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

      // Name and Status
      Column() {
        Text(this.name)
          .fontWeight(FontWeight.Bold)
          .fontSize(15)
          .fontColor('#000000')
        Blank().height(4)
        Text(this.switchState ? 'On' : 'Off')
          .fontColor(this.switchState ? this.accentColor : '#888888')
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .margin({ top: 12 })

      // Toggle Row
      Row() {
        Toggle({ type: ToggleType.Switch, isOn: this.switchState })
          .selectedColor(this.accentColor)
          .switchPointColor('#FFFFFF')
          .onChange((isOn: boolean) => {
            this.switchState = isOn;
            this.onToggle(isOn);
          })
          .width(44)
          .height(26)
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .margin({ top: 12 })
    }
    .padding(16)
    .width('100%')
    .borderRadius(20)
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 6, color: 'rgba(0,0,0,0.06)', offsetX: 0, offsetY: 2 })
    .alignItems(HorizontalAlign.Start)
  }
}