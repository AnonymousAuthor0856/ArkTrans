interface SceneItem {
  text: string;
  icon: string;
  isSelected: boolean;
}

interface DeviceItem {
  name: string;
  icon: string;
  isActive: boolean;
  accentColor: string;
  lightAccent: string;
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
    .alignItems(VerticalAlign.Center)
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .borderRadius(30)
    .backgroundColor(this.isSelected ? '#212121' : '#FFFFFF')
    .onClick(() => {})
  }
}

@Component
struct DeviceCard {
  @Prop name: string = '';
  @Prop icon: string = '';
  @Prop isActive: boolean = false;
  @Prop accentColor: string = '#FFC107';
  @Prop lightAccent: string = '#1AFFC107';
  @State switchState: boolean = false;

  aboutToAppear(): void {
    this.switchState = this.isActive;
  }

  build() {
    Column() {
      Row() {
        Stack() {
          Text(this.icon)
            .fontSize(24)
            .fontColor(this.switchState ? this.accentColor : '#888888')
        }
        .width(40)
        .height(40)
        .borderRadius(20)
        .backgroundColor(this.switchState ? this.lightAccent : '#F0F0F0')
        .alignContent(Alignment.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Column({ space: 4 }) {
        Text(this.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Text(this.switchState ? 'On' : 'Off')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.switchState ? this.accentColor : '#888888')
      }
      .alignItems(HorizontalAlign.Start)

      Row() {
        Toggle({ type: ToggleType.Switch, isOn: this.switchState })
          .selectedColor(this.accentColor)
          .switchPointColor('#FFFFFF')
          .width(41)
          .height(25)
          .onChange((isOn: boolean) => {
            this.switchState = isOn;
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
    }
    .padding(16)
    .width('100%')
    .aspectRatio(0.85)
    .borderRadius(20)
    .backgroundColor('#FFFFFF')
    .justifyContent(FlexAlign.SpaceBetween)
    .shadow({ radius: 2, color: '#14000000', offsetX: 0, offsetY: 1 })
  }
}

@Entry
@Component
struct SmartHomeDashboard {
  scenes: SceneItem[] = [
    { text: 'Home', icon: '🏠', isSelected: true },
    { text: 'Away', icon: '🔒', isSelected: false },
    { text: 'Sleep', icon: '★', isSelected: false }
  ];

  leftDevices: DeviceItem[] = [
    { name: 'Smart Lamp', icon: '★', isActive: true, accentColor: '#FFC107', lightAccent: '#1AFFC107' },
    { name: 'Thermostat', icon: '☰', isActive: true, accentColor: '#FF7043', lightAccent: '#1AFF7043' }
  ];

  rightDevices: DeviceItem[] = [
    { name: 'Main Lock', icon: '🔒', isActive: false, accentColor: '#4CAF50', lightAccent: '#1A4CAF50' },
    { name: 'Wi-Fi Router', icon: '⚙', isActive: true, accentColor: '#2196F3', lightAccent: '#1A2196F3' }
  ];

  build() {
    Scroll() {
      Column() {
        Row().height(16)

        Row() {
          Column({ space: 4 }) {
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
            Text('👤')
              .fontSize(24)
              .fontColor('#000000')
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor('#FFFFFF')
          .alignContent(Alignment.Center)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Row().height(32)

        Row() {
          Column({ space: 4 }) {
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

          Stack() {
            Text('🔔')
              .fontSize(24)
              .fontColor('#FFFFFF')
          }
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor('#33FFFFFF')
          .alignContent(Alignment.Center)
        }
        .width('100%')
        .padding(24)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .borderRadius(24)
        .backgroundColor('#5E60CE')
        .shadow({ radius: 8, color: '#335E60CE', offsetX: 0, offsetY: 4 })

        Row().height(32)

        Text('Scenes')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Row().height(16)

        Row({ space: 12 }) {
          ForEach(this.scenes, (item: SceneItem) => {
            SceneButton({ text: item.text, icon: item.icon, isSelected: item.isSelected })
          }, (item: SceneItem) => item.text)
        }
        .width('100%')

        Row().height(32)

        Text('Devices')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Row().height(16)

        Row({ space: 16 }) {
          Column({ space: 16 }) {
            ForEach(this.leftDevices, (item: DeviceItem) => {
              DeviceCard({ name: item.name, icon: item.icon, isActive: item.isActive, accentColor: item.accentColor, lightAccent: item.lightAccent })
            }, (item: DeviceItem) => item.name)
          }
          .layoutWeight(1)

          Column({ space: 16 }) {
            ForEach(this.rightDevices, (item: DeviceItem) => {
              DeviceCard({ name: item.name, icon: item.icon, isActive: item.isActive, accentColor: item.accentColor, lightAccent: item.lightAccent })
            }, (item: DeviceItem) => item.name)
          }
          .layoutWeight(1)
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)

        Row().height(24)
      }
      .width('100%')
      .padding(24)
      .backgroundColor('#F4F6F8')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F4F6F8')
    .scrollBar(BarState.Off)
  }
}
