import { router } from '@kit.ArkUI';

@Entry
@Component
struct SmartHomeApp {
  @State private isDarkMode: boolean = false;

  build() {
    Column() {
      SmartHomeScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
  }
}

// MARK: - Models
interface DeviceItem {
  id: number;
  name: string;
  status: string;
  icon: Resource;
  isActive: boolean;
}

// MARK: - Main Screen
@Component
struct SmartHomeScreen {
  // Colors matching Android theme
  @State primaryColor: string = '#4A6572'; // #4A6572
  @State backgroundColor: string = '#F5F6F8'; // #F5F6F8

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
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

            // Extra padding for bottom bar
            Blank().height(100)
          }
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')

      SmartHomeBottomBar({ primaryColor: this.primaryColor })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor as Color)
  }
}

// MARK: - Components

@Component
struct HeaderSection {
  @Prop primaryColor: string;

  build() {
    Row() {
      Column({ space: 4 }) {
        Text("Welcome Home,")
          .fontSize(16)
          .fontColor('#9E9E9E')
        Text("Alex Johnson")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }

      Blank()

      Stack() {
        Circle()
          .fill(Color.Transparent)
          .width(48)
          .height(48)
          .backgroundColor('#E0E0E0')

        Image($r('app.media.ic_person'))
          .width(32)
          .height(32)
          .objectFit(ImageFit.Contain)
      }
    }
    .width('100%')
  }
}

@Component
struct EnvironmentSummary {
  build() {
    Row({ space: 16 }) {
      EnvironmentCard({
        title: "Temperature",
        value: "24°C",
        subtitle: "Comfortable",
        bgColor: "#E3F2FD",
        textColor: "#1565C0"
      })
      .layoutWeight(1)

      EnvironmentCard({
        title: "Humidity",
        value: "45%",
        subtitle: "Normal",
        bgColor: "#E8F5E9",
        textColor: "#2E7D32"
      })
      .layoutWeight(1)
    }
    .width('100%')
  }
}

@Component
struct EnvironmentCard {
  @Prop title: string;
  @Prop value: string;
  @Prop subtitle: string;
  @Prop bgColor: string;
  @Prop textColor: string;

  build() {
    Column({ space: 0 }) {
      Text(this.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textColor)
        .opacity(0.8)

      Blank()

      Column({ space: 0 }) {
        Text(this.value)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)
        Text(this.subtitle)
          .fontSize(11)
          .fontColor(this.textColor)
          .opacity(0.7)
      }
    }
    .width('100%')
    .height(100)
    .padding(16)
    .backgroundColor(this.bgColor as Color)
    .borderRadius(16)
  }
}

@Component
struct DevicesGrid {
  @Prop primaryColor: string;

  // Data from Android code
  private devices: DeviceItem[] = [
    { id: 1, name: "Living Room", status: "2 Lights On", icon: $r('app.media.ic_home'), isActive: true },
    { id: 2, name: "Smart Lock", status: "Locked", icon: $r('app.media.ic_lock'), isActive: true },
    { id: 3, name: "Bedroom AC", status: "22°C", icon: $r('app.media.ic_star'), isActive: false },
    { id: 4, name: "Router", status: "Online", icon: $r('app.media.ic_location'), isActive: true },
    { id: 5, name: "Kitchen", status: "All Off", icon: $r('app.media.ic_info'), isActive: false },
    { id: 6, name: "Corridor", status: "Motion Detected", icon: $r('app.media.ic_bell'), isActive: true }
  ];

  build() {
    Column({ space: 16 }) {
      Text("My Devices")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Grid() {
        ForEach(this.devices, (device: DeviceItem) => {
          GridItem() {
            DeviceCard({ device: device, primaryColor: this.primaryColor })
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .rowsGap(16)
      .columnsGap(16)
    }
    .width('100%')
  }
}

@Component
struct DeviceCard {
  @Prop device: DeviceItem;
  @Prop primaryColor: string;
  @State isChecked: boolean = false;

  aboutToAppear() {
    this.isChecked = this.device.isActive;
  }

  build() {
    Column({ space: 0 }) {
      Row() {
        Stack() {
          Circle()
            .fill(this.isChecked ? Color.White : '#F0F0F0' as Color)
            .width(36)
            .height(36)

          Image(this.device.icon)
            .width(14)
            .height(14)
            .objectFit(ImageFit.Contain)
        }

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .onChange((value: boolean) => {
            this.isChecked = value;
          })
          .width(40)
          .height(20)
          .backgroundColor(this.isChecked ? this.primaryColor as Color : '#E0E0E0' as Color)
          .selectedColor(this.primaryColor as Color)
      }
      .width('100%')

      Blank()

      Column({ space: 4 }) {
        Text(this.device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isChecked ? Color.White : '#000000' as Color)

        Text(this.isChecked ? "On" : "Off")
          .fontSize(11)
          .fontColor(this.isChecked ? Color.White : '#9E9E9E' as Color)
      }
    }
    .width('100%')
    .height(140)
    .padding(16)
    .backgroundColor(this.isChecked ? this.primaryColor as Color : Color.White)
    .borderRadius(20)
    .shadow({ radius: 8, color: this.isChecked ? this.primaryColor + '4D' : '#0000000D', offsetX: 0, offsetY: 4 })
  }
}

@Component
struct SmartHomeBottomBar {
  @Prop primaryColor: string;

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // Shadow layer
      Column()
        .width('100%')
        .height(80)
        .backgroundColor(Color.White)
        .borderRadius({ topLeft: 24, topRight: 24 })
        .shadow({ radius: 4, color: '#0000000D', offsetX: 0, offsetY: -2 })

      Row() {
        Blank()
        NavBarItem({ icon: $r('app.media.ic_home'), label: "Home", isSelected: true, primaryColor: this.primaryColor })
        Blank()
        NavBarItem({ icon: $r('app.media.ic_star'), label: "Scenes", isSelected: false, primaryColor: this.primaryColor })
        Blank()
        NavBarItem({ icon: $r('app.media.ic_settings'), label: "Settings", isSelected: false, primaryColor: this.primaryColor })
        Blank()
      }
      .padding({ top: 16 })
    }
    .width('100%')
    .height(80)
  }
}

@Component
struct NavBarItem {
  @Prop icon: Resource;
  @Prop label: string;
  @Prop isSelected: boolean;
  @Prop primaryColor: string;

  build() {
    Column({ space: 4 }) {
      Stack() {
        if (this.isSelected) {
          Capsule()
            .fillColor(this.primaryColor as Color)
            .opacity(0.1)
            .width(64)
            .height(32)
        }
        Image(this.icon)
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
      }
      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? this.primaryColor as Color : '#9E9E9E' as Color)
    }
  }
}