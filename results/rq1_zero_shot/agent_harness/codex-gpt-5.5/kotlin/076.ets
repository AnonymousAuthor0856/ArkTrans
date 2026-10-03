class DeviceItem {
  name: string;
  icon: string;
  active: boolean;
  accentColor: string;

  constructor(name: string, icon: string, active: boolean, accentColor: string) {
    this.name = name;
    this.icon = icon;
    this.active = active;
    this.accentColor = accentColor;
  }
}

@Entry
@Component
struct MainActivity {
  @State devices: DeviceItem[] = [
    new DeviceItem('Smart Lamp', '★', true, '#FFC107'),
    new DeviceItem('Thermostat', '≡', true, '#FF7043'),
    new DeviceItem('Main Lock', '⌂', false, '#4CAF50'),
    new DeviceItem('Wi-Fi Router', '⚙', true, '#2196F3')
  ];

  private toggleDevice(index: number, value: boolean): void {
    this.devices[index].active = value;
    this.devices = [...this.devices];
  }

  @Builder
  SceneButton(text: string, icon: string, selected: boolean) {
    Row({ space: 8 }) {
      Text(icon)
        .fontSize(18)
        .fontColor(selected ? '#FFFFFF' : '#000000')
      Text(text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(selected ? '#FFFFFF' : '#000000')
    }
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(selected ? '#212121' : '#FFFFFF')
    .borderRadius(30)
  }

  @Builder
  DeviceCard(device: DeviceItem, index: number) {
    Column() {
      Row() {
        Text(device.icon)
          .fontSize(24)
          .fontColor(device.active ? device.accentColor : '#808080')
          .textAlign(TextAlign.Center)
          .width(40)
          .height(40)
          .lineHeight(40)
          .backgroundColor(device.active ? `${device.accentColor}1A` : '#F0F0F0')
          .borderRadius(20)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

      Column() {
        Text(device.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Text(device.active ? 'On' : 'Off')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(device.active ? device.accentColor : '#808080')
          .margin({ top: 4 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Row() {
        Toggle({ type: ToggleType.Switch, isOn: device.active })
          .selectedColor(device.accentColor)
          .onChange((value: boolean) => {
            this.toggleDevice(index, value);
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .aspectRatio(0.85)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
  }

  build() {
    Scroll() {
      Column() {
        Blank().height(16)

        Row() {
          Column() {
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
          .layoutWeight(1)

          Text('●')
            .fontSize(24)
            .fontColor('#000000')
            .textAlign(TextAlign.Center)
            .width(48)
            .height(48)
            .lineHeight(48)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Column() {
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
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)

            Text('!')
              .fontSize(24)
              .fontColor('#FFFFFF')
              .textAlign(TextAlign.Center)
              .width(56)
              .height(56)
              .lineHeight(56)
              .backgroundColor('#33FFFFFF')
              .borderRadius(28)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .padding(24)
        .margin({ top: 32 })
        .backgroundColor('#5E60CE')
        .borderRadius(24)
        .shadow({ radius: 8, color: '#33000000', offsetY: 4 })

        Text('Scenes')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .width('100%')
          .margin({ top: 32, bottom: 16 })

        Row({ space: 12 }) {
          this.SceneButton('Home', '⌂', true)
          this.SceneButton('Away', '⌘', false)
          this.SceneButton('Sleep', '★', false)
        }
        .width('100%')

        Text('Devices')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .width('100%')
          .margin({ top: 32, bottom: 16 })

        Grid() {
          ForEach(this.devices, (device: DeviceItem, index: number) => {
            GridItem() {
              this.DeviceCard(device, index)
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(16)
        .rowsGap(16)
        .width('100%')

        Blank().height(24)
      }
      .width('100%')
      .padding(24)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F4F6F8')
    .scrollBar(BarState.Off)
  }
}
