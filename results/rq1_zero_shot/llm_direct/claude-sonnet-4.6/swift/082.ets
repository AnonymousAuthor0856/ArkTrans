import { router } from '@kit.ArkUI';

interface DeviceItem {
  id: number;
  name: string;
  status: string;
  icon: Resource;
  isActive: boolean;
}

@Entry
@Component
struct SmartHomeScreen {
  primaryColor: string = '#4A6572';
  backgroundColor: string = '#F5F6F8';

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column({ space: 0 }) {
          Blank().height(24)

          HeaderSection({ primaryColor: this.primaryColor })
            .padding({ left: 24, right: 24 })

          Blank().height(32)

          EnvironmentSummary()
            .padding({ left: 24, right: 24 })

          Blank().height(32)

          DevicesGrid({ primaryColor: this.primaryColor })
            .padding({ left: 24, right: 24 })

          Blank().height(100)
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
      .backgroundColor(this.backgroundColor)

      SmartHomeBottomBar({ primaryColor: this.primaryColor })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }
}

@Component
struct HeaderSection {
  primaryColor: string = '#4A6572';

  build() {
    Row() {
      Column({ space: 4 }) {
        Text('Welcome Home,')
          .fontSize(16)
          .fontColor('#808080')

        Text('Alex Johnson')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack() {
        Circle()
          .fill('#1A4A6572')
          .width(48)
          .height(48)

        Image($r('app.media.ic_person'))
          .width(32)
          .height(32)
          .fillColor(this.primaryColor)
          .objectFit(ImageFit.Contain)
      }
      .width(48)
      .height(48)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct EnvironmentSummary {
  build() {
    Row({ space: 16 }) {
      EnvironmentCard({
        title: 'Temperature',
        value: '24°C',
        subtitle: 'Comfortable',
        bgColor: '#E3F2FD',
        textColor: '#1565C0'
      })

      EnvironmentCard({
        title: 'Humidity',
        value: '45%',
        subtitle: 'Normal',
        bgColor: '#E8F5E9',
        textColor: '#2E7D32'
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct EnvironmentCard {
  title: string = '';
  value: string = '';
  subtitle: string = '';
  bgColor: string = '#FFFFFF';
  textColor: string = '#000000';

  build() {
    Column() {
      Text(this.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textColor)
        .opacity(0.8)
        .alignSelf(ItemAlign.Start)

      Blank()

      Column({ space: 0 }) {
        Text(this.value)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)
          .alignSelf(ItemAlign.Start)

        Text(this.subtitle)
          .fontSize(11)
          .fontColor(this.textColor)
          .opacity(0.7)
          .alignSelf(ItemAlign.Start)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(16)
    .layoutWeight(1)
    .height(100)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(this.bgColor)
    .borderRadius(16)
  }
}

@Component
struct DevicesGrid {
  primaryColor: string = '#4A6572';

  devices: DeviceItem[] = [
    { id: 1, name: 'Living Room', status: '2 Lights On', icon: $r('app.media.ic_house'), isActive: true },
    { id: 2, name: 'Smart Lock', status: 'Locked', icon: $r('app.media.ic_lock'), isActive: true },
    { id: 3, name: 'Bedroom AC', status: '22°C', icon: $r('app.media.ic_star'), isActive: false },
    { id: 4, name: 'Router', status: 'Online', icon: $r('app.media.ic_router'), isActive: true },
    { id: 5, name: 'Kitchen', status: 'All Off', icon: $r('app.media.ic_kitchen'), isActive: false },
    { id: 6, name: 'Corridor', status: 'Motion Detected', icon: $r('app.media.ic_bell'), isActive: true }
  ];

  build() {
    Column({ space: 16 }) {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .alignSelf(ItemAlign.Start)

      Grid() {
        ForEach(this.devices, (device: DeviceItem) => {
          GridItem() {
            DeviceCard({ device: device, primaryColor: this.primaryColor })
          }
        }, (device: DeviceItem) => device.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct DeviceCard {
  device: DeviceItem = {
    id: 0,
    name: '',
    status: '',
    icon: $r('app.media.ic_house'),
    isActive: false
  };
  primaryColor: string = '#4A6572';
  @State isChecked: boolean = false;

  aboutToAppear() {
    this.isChecked = this.device.isActive;
  }

  build() {
    Column() {
      Row() {
        Stack() {
          Circle()
            .fill(this.isChecked ? '#334D4D4D' : '#F0F0F0')
            .width(36)
            .height(36)

          Image(this.device.icon)
            .width(18)
            .height(18)
            .fillColor(this.isChecked ? '#FFFFFF' : '#808080')
            .objectFit(ImageFit.Contain)
        }
        .width(36)
        .height(36)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .selectedColor('#66FFFFFF')
          .switchPointColor('#FFFFFF')
          .onChange((isOn: boolean) => {
            this.isChecked = isOn;
          })
          .width(44)
          .height(26)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank()

      Column({ space: 4 }) {
        Text(this.device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isChecked ? '#FFFFFF' : '#000000')
          .alignSelf(ItemAlign.Start)

        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.isChecked ? '#B3FFFFFF' : '#808080')
          .alignSelf(ItemAlign.Start)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .padding(16)
    .height(140)
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(this.isChecked ? this.primaryColor : '#FFFFFF')
    .borderRadius(20)
    .shadow({
      radius: 8,
      color: this.isChecked ? '#4D4A6572' : '#0D000000',
      offsetX: 0,
      offsetY: 4
    })
  }
}

@Component
struct SmartHomeBottomBar {
  primaryColor: string = '#4A6572';

  build() {
    Row() {
      Blank()
      NavBarItem({ icon: $r('app.media.ic_home'), label: 'Home', isSelected: true, primaryColor: this.primaryColor })
      Blank()
      NavBarItem({ icon: $r('app.media.ic_scenes'), label: 'Scenes', isSelected: false, primaryColor: this.primaryColor })
      Blank()
      NavBarItem({ icon: $r('app.media.ic_settings'), label: 'Settings', isSelected: false, primaryColor: this.primaryColor })
      Blank()
    }
    .width('100%')
    .height(80)
    .backgroundColor('#FFFFFF')
    .borderRadius({ topLeft: 24, topRight: 24 })
    .shadow({
      radius: 4,
      color: '#0D000000',
      offsetX: 0,
      offsetY: -2
    })
    .padding({ top: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct NavBarItem {
  icon: Resource = $r('app.media.ic_home');
  label: string = '';
  isSelected: boolean = false;
  primaryColor: string = '#4A6572';

  build() {
    Column({ space: 4 }) {
      Stack() {
        if (this.isSelected) {
          Text('')
            .width(64)
            .height(32)
            .backgroundColor('#1A4A6572')
            .borderRadius(16)
        }

        Image(this.icon)
          .width(24)
          .height(24)
          .fillColor(this.isSelected ? this.primaryColor : '#808080')
          .objectFit(ImageFit.Contain)
      }
      .width(64)
      .height(32)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? this.primaryColor : '#808080')
    }
    .alignItems(HorizontalAlign.Center)
  }
}