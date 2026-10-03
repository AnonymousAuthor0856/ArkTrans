const Colors = {
  primary: '#4A6572',
  onPrimary: '#FFFFFF',
  background: '#F5F6F8',
  surface: '#FFFFFF',
  onSurface: '#333333'
};

interface DeviceItem {
  name: string;
  status: string;
  icon: string;
  isActive: boolean;
}

const devices: DeviceItem[] = [
  { name: 'Living Room', status: '2 Lights On', icon: '⌂', isActive: true },
  { name: 'Smart Lock', status: 'Locked', icon: '🔒', isActive: true },
  { name: 'Bedroom AC', status: '22°C', icon: '★', isActive: false },
  { name: 'Router', status: 'Online', icon: '📍', isActive: true },
  { name: 'Kitchen', status: 'All Off', icon: 'ⓘ', isActive: false },
  { name: 'Corridor', status: 'Motion Detected', icon: '🔔', isActive: true }
];

@Entry
@Component
struct Index {
  build() {
    Column() {
      Scroll() {
        Column() {
          Blank().height(24)

          Row() {
            Column() {
              Text('Welcome Home,')
                .fontSize(16)
                .fontColor('#808080')
              Text('Alex Johnson')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(Colors.onSurface)
            }
            Stack() {
              Text('👤')
                .fontSize(32)
                .fontColor(Colors.primary)
            }
            .width(48)
            .height(48)
            .borderRadius(24)
            .backgroundColor('#1A4A6572')
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          Blank().height(32)

          Row({ space: 16 }) {
            EnvironmentCard({ title: 'Temperature', value: '24°C', subtitle: 'Comfortable', color: '#E3F2FD', textColor: '#1565C0' })
            EnvironmentCard({ title: 'Humidity', value: '45%', subtitle: 'Normal', color: '#E8F5E9', textColor: '#2E7D32' })
          }
          .width('100%')

          Blank().height(32)

          Column() {
            Text('My Devices')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)
            Blank().height(16)
            Grid() {
              ForEach(devices, (device: DeviceItem) => {
                DeviceCard({ name: device.name, icon: device.icon, isActive: device.isActive })
              }, (device: DeviceItem) => device.name)
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(16)
            .rowsGap(16)
            .height(440)
          }
        }
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)

      Row() {
        Column() {
          Text('⌂')
            .fontSize(24)
            .fontColor(Colors.primary)
          Text('Home')
            .fontSize(12)
            .fontColor(Colors.primary)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Column() {
          Text('★')
            .fontSize(24)
            .fontColor('#808080')
          Text('Scenes')
            .fontSize(12)
            .fontColor('#808080')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Column() {
          Text('⚙')
            .fontSize(24)
            .fontColor('#808080')
          Text('Settings')
            .fontSize(12)
            .fontColor('#808080')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .padding({ top: 12, bottom: 12 })
      .backgroundColor('#FFFFFF')
      .borderRadius({ topLeft: 24, topRight: 24 })
      .shadow({ radius: 8, color: '#22000000', offsetY: -4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}

@Component
struct EnvironmentCard {
  @Prop title: string = '';
  @Prop value: string = '';
  @Prop subtitle: string = '';
  @Prop color: string = '#FFFFFF';
  @Prop textColor: string = '#000000';

  build() {
    Column() {
      Text(this.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#CC' + this.textColor.substring(1))
      Column() {
        Text(this.value)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)
        Text(this.subtitle)
          .fontSize(11)
          .fontColor('#B3' + this.textColor.substring(1))
      }
    }
    .layoutWeight(1)
    .height(100)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .borderRadius(16)
    .backgroundColor(this.color)
  }
}

@Component
struct DeviceCard {
  @Prop name: string = '';
  @Prop icon: string = '';
  @Prop isActive: boolean = false;
  @State isChecked: boolean = false;

  aboutToAppear() {
    this.isChecked = this.isActive;
  }

  build() {
    Column() {
      Row() {
        Stack() {
          Text(this.icon)
            .fontSize(20)
            .fontColor(this.isChecked ? '#FFFFFF' : '#808080')
        }
        .width(36)
        .height(36)
        .borderRadius(18)
        .backgroundColor(this.isChecked ? '#33FFFFFF' : '#F0F0F0')

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .selectedColor(this.isChecked ? '#66FFFFFF' : '#00000000')
          .switchPointColor(this.isChecked ? '#FFFFFF' : '#808080')
          .onChange((isOn: boolean) => {
            this.isChecked = isOn;
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text(this.name)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? '#FFFFFF' : '#000000')
        Blank().height(4)
        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(12)
          .fontColor(this.isChecked ? '#B3FFFFFF' : '#B3000000')
      }
    }
    .width('100%')
    .height(140)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .borderRadius(20)
    .backgroundColor(this.isChecked ? Colors.primary : '#FFFFFF')
    .shadow({ radius: this.isChecked ? 8 : 2, color: '#22000000', offsetY: 4 })
  }
}
