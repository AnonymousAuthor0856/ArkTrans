import { display } from '@kit.ArkUI';

@Entry
@Component
struct SmartHomeDashboard {
  @State lampSwitch: boolean = true;
  @State thermostatSwitch: boolean = true;
  @State lockSwitch: boolean = false;
  @State routerSwitch: boolean = true;

  build() {
    Column() {
      Scroll() {
        Column() {
          // Header
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
            .alignItems(HorizontalAlign.Start)

            Blank()
              .layoutWeight(1)

            Column() {
              Text('👤')
                .fontSize(24)
            }
            .width(48)
            .height(48)
            .borderRadius(24)
            .backgroundColor('#FFFFFF')
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          Blank().height(32)

          // Energy Usage Card
          Column() {
            Row() {
              Column() {
                Text('Energy Usage')
                  .fontSize(14)
                  .fontColor('#CCFFFFFF')
                Text('28.5 kWh')
                  .fontSize(32)
                  .fontColor('#FFFFFF')
                  .fontWeight(FontWeight.Bold)
                Text('Today')
                  .fontSize(12)
                  .fontColor('#99FFFFFF')
              }
              .alignItems(HorizontalAlign.Start)

              Blank()
                .layoutWeight(1)

              Column() {
                Text('🔔')
                  .fontSize(24)
              }
              .width(56)
              .height(56)
              .borderRadius(28)
              .backgroundColor('#33FFFFFF')
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .padding(24)
          }
          .width('100%')
          .borderRadius(24)
          .backgroundColor('#5E60CE')
          .shadow({ radius: 8, color: '#335E60CE', offsetY: 4 })

          Blank().height(32)

          // Scenes
          Text('Scenes')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')

          Blank().height(16)

          Row({ space: 12 }) {
            SceneButton({ text: 'Home', icon: '🏠', isSelected: true })
            SceneButton({ text: 'Away', icon: '🔒', isSelected: false })
            SceneButton({ text: 'Sleep', icon: '⭐', isSelected: false })
          }
          .width('100%')

          Blank().height(32)

          // Devices
          Text('Devices')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')

          Blank().height(16)

          Row({ space: 16 }) {
            Column({ space: 16 }) {
              DeviceCard({
                name: 'Smart Lamp',
                icon: '💡',
                isActive: this.lampSwitch,
                accentColor: '#FFC107',
                onToggle: (value: boolean) => { this.lampSwitch = value; }
              })
              DeviceCard({
                name: 'Thermostat',
                icon: '🌡️',
                isActive: this.thermostatSwitch,
                accentColor: '#FF7043',
                onToggle: (value: boolean) => { this.thermostatSwitch = value; }
              })
            }
            .layoutWeight(1)

            Column({ space: 16 }) {
              DeviceCard({
                name: 'Main Lock',
                icon: '🔒',
                isActive: this.lockSwitch,
                accentColor: '#4CAF50',
                onToggle: (value: boolean) => { this.lockSwitch = value; }
              })
              DeviceCard({
                name: 'Wi-Fi Router',
                icon: '📶',
                isActive: this.routerSwitch,
                accentColor: '#2196F3',
                onToggle: (value: boolean) => { this.routerSwitch = value; }
              })
            }
            .layoutWeight(1)
          }
          .width('100%')

          Blank().height(24)
        }
        .width('100%')
        .padding(24)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F4F6F8')
  }
}

@Component
struct SceneButton {
  @Prop text: string = '';
  @Prop icon: string = '';
  @Prop isSelected: boolean = false;

  build() {
    Row({ space: 8 }) {
      Text(this.icon)
        .fontSize(18)
        .fontColor(this.isSelected ? '#FFFFFF' : '#000000')
      Text(this.text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? '#FFFFFF' : '#000000')
    }
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .borderRadius(30)
    .backgroundColor(this.isSelected ? '#212121' : '#FFFFFF')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct DeviceCard {
  @Prop name: string = '';
  @Prop icon: string = '';
  @Prop @Watch('onIsActiveChanged') isActive: boolean = false;
  @Prop accentColor: string = '#000000';
  onToggle: (value: boolean) => void = () => {};
  @State internalSwitchState: boolean = false;

  aboutToAppear() {
    this.internalSwitchState = this.isActive;
  }

  onIsActiveChanged() {
    this.internalSwitchState = this.isActive;
  }

  build() {
    Column() {
      Row() {
        Column() {
          Text(this.icon)
            .fontSize(24)
            .fontColor(this.internalSwitchState ? this.accentColor : '#808080')
        }
        .width(40)
        .height(40)
        .borderRadius(20)
        .backgroundColor(this.internalSwitchState ? this.getAlphaColor(this.accentColor, 0.1) : '#F0F0F0')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Blank()
        .layoutWeight(1)

      Column() {
        Text(this.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Blank().height(4)
        Text(this.internalSwitchState ? 'On' : 'Off')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.internalSwitchState ? this.accentColor : '#808080')
      }
      .alignItems(HorizontalAlign.Start)

      Blank().height(8)

      Row() {
        Toggle({ type: ToggleType.Switch, isOn: this.internalSwitchState })
          .selectedColor(this.accentColor)
          .switchPointColor('#FFFFFF')
          .onChange((isOn: boolean) => {
            this.internalSwitchState = isOn;
            this.onToggle(isOn);
          })
          .width(42)
          .height(26)
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .aspectRatio(0.85)
    .padding(16)
    .borderRadius(20)
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 2, color: '#22000000', offsetY: 1 })
  }

  private getAlphaColor(hexColor: string, alpha: number): string {
    // Convert hex color to rgba with alpha
    const r = parseInt(hexColor.substring(1, 3), 16);
    const g = parseInt(hexColor.substring(3, 5), 16);
    const b = parseInt(hexColor.substring(5, 7), 16);
    const a = Math.round(alpha * 255);
    return `rgba(${r}, ${g}, ${b}, ${a / 255})`;
  }
}