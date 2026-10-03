// Models
interface DeviceItem {
  id: number;
  name: string;
  status: string;
  isActive: boolean;
}

@Entry
@Component
struct SmartHomeScreen {
  @State primaryColor: string = '#4A6572';
  @State bgColor: string = '#F5F6F8';

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F6F8')

      Column() {
        Scroll() {
          Column() {
            HeaderSection({ primaryColor: this.primaryColor })
              .margin({ top: 24, left: 24, right: 24 })

            EnvironmentSummarySection()
              .margin({ top: 32, left: 24, right: 24 })

            DevicesGridSection({ primaryColor: this.primaryColor })
              .margin({ top: 32, left: 24, right: 24 })

            Column().height(100)
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      SmartHomeBottomBar({ primaryColor: this.primaryColor })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct HeaderSection {
  @Prop primaryColor: string;

  build() {
    Row() {
      Column() {
        Text('Welcome Home,')
          .fontSize(16)
          .fontColor('#888888')
          .margin({ bottom: 4 })
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
        Text('👤')
          .fontSize(24)
          .fontColor(this.primaryColor)
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
struct EnvironmentSummarySection {
  build() {
    Row({ space: 16 }) {
      EnvironmentCard({
        title: 'Temperature',
        value: '24°C',
        subtitle: 'Comfortable',
        cardBgColor: '#E3F2FD',
        cardTextColor: '#1565C0'
      })
      EnvironmentCard({
        title: 'Humidity',
        value: '45%',
        subtitle: 'Normal',
        cardBgColor: '#E8F5E9',
        cardTextColor: '#2E7D32'
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct EnvironmentCard {
  @Prop title: string;
  @Prop value: string;
  @Prop subtitle: string;
  @Prop cardBgColor: string;
  @Prop cardTextColor: string;

  build() {
    Column() {
      Text(this.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.cardTextColor)
        .opacity(0.8)
        .alignSelf(ItemAlign.Start)

      Blank()

      Column() {
        Text(this.value)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.cardTextColor)
          .alignSelf(ItemAlign.Start)
        Text(this.subtitle)
          .fontSize(11)
          .fontColor(this.cardTextColor)
          .opacity(0.7)
          .alignSelf(ItemAlign.Start)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(16)
    .layoutWeight(1)
    .height(100)
    .backgroundColor(this.cardBgColor)
    .borderRadius(16)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct DevicesGridSection {
  @Prop primaryColor: string;
  @State devices: DeviceItem[] = [
    { id: 1, name: 'Living Room', status: '2 Lights On', isActive: true },
    { id: 2, name: 'Smart Lock', status: 'Locked', isActive: true },
    { id: 3, name: 'Bedroom AC', status: '22°C', isActive: false },
    { id: 4, name: 'Router', status: 'Online', isActive: true },
    { id: 5, name: 'Kitchen', status: 'All Off', isActive: false },
    { id: 6, name: 'Corridor', status: 'Motion Detected', isActive: true },
  ];

  build() {
    Column({ space: 16 }) {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .alignSelf(ItemAlign.Start)

      Grid() {
        ForEach(this.devices, (device: DeviceItem, index: number) => {
          GridItem() {
            DeviceCard({
              device: device,
              primaryColor: this.primaryColor,
              onToggle: (newVal: boolean) => {
                let updated: DeviceItem[] = [];
                for (let i = 0; i < this.devices.length; i++) {
                  if (i === index) {
                    updated.push({
                      id: device.id,
                      name: device.name,
                      status: device.status,
                      isActive: newVal
                    });
                  } else {
                    updated.push(this.devices[i]);
                  }
                }
                this.devices = updated;
              }
            })
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
  @Prop device: DeviceItem;
  @Prop primaryColor: string;
  onToggle: (val: boolean) => void = () => {};
  @State isChecked: boolean = false;

  aboutToAppear() {
    this.isChecked = this.device.isActive;
  }

  getDeviceEmoji(name: string): string {
    if (name === 'Living Room') return '🏠';
    if (name === 'Smart Lock') return '🔒';
    if (name === 'Bedroom AC') return '❄️';
    if (name === 'Router') return '📡';
    if (name === 'Kitchen') return '🍳';
    if (name === 'Corridor') return '🔔';
    return '💡';
  }

  build() {
    Column() {
      Row() {
        Stack() {
          Circle()
            .fill(this.isChecked ? '#334A6572' : '#F0F0F0')
            .width(36)
            .height(36)
          Text(this.getDeviceEmoji(this.device.name))
            .fontSize(16)
        }
        .width(36)
        .height(36)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .selectedColor('#FFFFFF')
          .switchPointColor(this.isChecked ? this.primaryColor : '#CCCCCC')
          .onChange((isOn: boolean) => {
            this.isChecked = isOn;
            this.onToggle(isOn);
          })
          .width(44)
          .height(26)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Blank()

      Column() {
        Text(this.device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isChecked ? '#FFFFFF' : '#000000')
          .alignSelf(ItemAlign.Start)
        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.isChecked ? '#FFFFFFB3' : '#888888')
          .margin({ top: 4 })
          .alignSelf(ItemAlign.Start)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .padding(16)
    .width('100%')
    .height(140)
    .backgroundColor(this.isChecked ? this.primaryColor : '#FFFFFF')
    .borderRadius(20)
    .shadow({
      radius: 8,
      color: this.isChecked ? '#4D4A6572' : '#0D000000',
      offsetX: 0,
      offsetY: 4
    })
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct SmartHomeBottomBar {
  @Prop primaryColor: string;

  build() {
    Row() {
      NavBarItem({ label: 'Home', emoji: '🏠', isSelected: true, primaryColor: this.primaryColor })
      Blank()
      NavBarItem({ label: 'Scenes', emoji: '⭐', isSelected: false, primaryColor: this.primaryColor })
      Blank()
      NavBarItem({ label: 'Settings', emoji: '⚙️', isSelected: false, primaryColor: this.primaryColor })
    }
    .width('100%')
    .height(80)
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .backgroundColor('#FFFFFF')
    .borderRadius({ topLeft: 24, topRight: 24, bottomLeft: 0, bottomRight: 0 })
    .shadow({
      radius: 8,
      color: '#1A000000',
      offsetX: 0,
      offsetY: -2
    })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct NavBarItem {
  @Prop emoji: string;
  @Prop label: string;
  @Prop isSelected: boolean;
  @Prop primaryColor: string;

  build() {
    Column({ space: 4 }) {
      Stack() {
        if (this.isSelected) {
          Row()
            .width(64)
            .height(32)
            .backgroundColor('#1A4A6572')
            .borderRadius(16)
        }
        Text(this.emoji)
          .fontSize(22)
          .fontColor(this.isSelected ? this.primaryColor : '#888888')
      }
      .width(64)
      .height(32)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? this.primaryColor : '#888888')
    }
    .alignItems(HorizontalAlign.Center)
  }
}