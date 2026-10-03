import { BusinessError } from '@kit.BasicServicesKit';
import { common, UIAbility } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

// MARK: - Models
interface DeviceItem {
  id: number;
  name: string;
  status: string;
  icon: string;
  isActive: boolean;
}

@Entry
@Component
struct SmartHomeApp {
  @State private devices: DeviceItem[] = [
    { id: 1, name: 'Living Room', status: '2 Lights On', icon: 'house.fill', isActive: true },
    { id: 2, name: 'Smart Lock', status: 'Locked', icon: 'lock.fill', isActive: true },
    { id: 3, name: 'Bedroom AC', status: '22°C', icon: 'star.fill', isActive: false },
    { id: 4, name: 'Router', status: 'Online', icon: 'location.circle.fill', isActive: true },
    { id: 5, name: 'Kitchen', status: 'All Off', icon: 'info.circle.fill', isActive: false },
    { id: 6, name: 'Corridor', status: 'Motion Detected', icon: 'bell.fill', isActive: true }
  ];

  build() {
    Column() {
      SmartHomeScreen({ devices: this.devices })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
  }
}

@Component
struct SmartHomeScreen {
  @Link devices: DeviceItem[];
  // Colors matching Android theme
  primaryColor: string = '#4A6572';
  backgroundColor: ResourceColor = Color.Gray;

  aboutToAppear() {
    this.backgroundColor = new Color('#F5F6F8');
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Scroll() {
          Column({ space: 0 }) {
            Column().height(24)
            
            HeaderSection({ primaryColor: this.primaryColor })
              .padding({ left: 24, right: 24 })
            
            Column().height(32)
            
            EnvironmentSummary()
              .padding({ left: 24, right: 24 })
            
            Column().height(32)
            
            DevicesGrid({ devices: $devices, primaryColor: this.primaryColor })
              .padding({ left: 24, right: 24 })
            
            // Extra padding for bottom bar
            Column().height(100)
          }
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      
      SmartHomeBottomBar({ primaryColor: this.primaryColor })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }
}

@Component
struct HeaderSection {
  @Prop primaryColor: string;

  build() {
    Row() {
      Column({ space: 4 }) {
        Text('Welcome Home,')
          .fontSize(16)
          .fontColor(Color.Gray)
        
        Text('Alex Johnson')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      
      Blank()
      
      Stack() {
        Circle()
          .fill(this.primaryColor)
          .opacity(0.1)
          .width(48)
          .height(48)
        
        Image($r('app.media.ic_person')) // Placeholder for system image
          .width(32)
          .height(32)
          .fillColor(this.primaryColor)
      }
    }
    .width('100%')
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
      
      Column()
      
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
    .backgroundColor(this.bgColor)
    .borderRadius(16)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct DevicesGrid {
  @Link devices: DeviceItem[];
  @Prop primaryColor: string;

  build() {
    Column({ space: 16 }) {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
      
      Grid() {
        ForEach(this.devices, (device: DeviceItem) => {
          GridItem() {
            DeviceCard({ device: device, primaryColor: this.primaryColor })
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('auto auto auto')
      .itemMargin(16)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
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
            .fill(this.isChecked ? Color.White : '#F0F0F0')
            .opacity(this.isChecked ? 0.2 : 1)
            .width(36)
            .height(36)
          
          Image($r('app.media.ic_house')) // Placeholder based on icon string logic would require dynamic resource loading
            .width(14)
            .height(14)
            .fillColor(this.isChecked ? Color.White : Color.Gray)
        }
        
        Blank()
        
        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .onChange((isOn: boolean) => {
            this.isChecked = isOn;
          })
          .width(40)
          .height(20)
          .selectedColor(this.primaryColor)
      }
      
      Column()
      
      Column({ space: 4 }) {
        Text(this.device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isChecked ? Color.White : Color.Black)
        
        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.isChecked ? Color.White : Color.Gray)
          .opacity(this.isChecked ? 0.7 : 1)
      }
    }
    .width('100%')
    .height(140)
    .padding(16)
    .backgroundColor(this.isChecked ? this.primaryColor : Color.White)
    .borderRadius(20)
    .shadow({ radius: 8, color: this.isChecked ? this.primaryColor : Color.Black, offsetY: 4 })
    .opacity(this.isChecked ? 1 : 0.95)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct SmartHomeBottomBar {
  @Prop primaryColor: string;

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column() {
        Row() {
          NavBarItem({ icon: 'house.fill', label: 'Home', isSelected: true, primaryColor: this.primaryColor })
          NavBarItem({ icon: 'star.fill', label: 'Scenes', isSelected: false, primaryColor: this.primaryColor })
          NavBarItem({ icon: 'gearshape.fill', label: 'Settings', isSelected: false, primaryColor: this.primaryColor })
        }
        .justifyContent(FlexAlign.SpaceAround)
        .padding({ top: 16 })
      }
      .width('100%')
      .height(80)
      .backgroundColor(Color.White)
      .borderRadius({ topLeft: 24, topRight: 24 })
      .shadow({ radius: 4, color: new Color('#000000').withOpacity(0.05), offsetY: -2 })
    }
    .width('100%')
    .height(80)
  }
}

@Component
struct NavBarItem {
  @Prop icon: string;
  @Prop label: string;
  @Prop isSelected: boolean;
  @Prop primaryColor: string;

  build() {
    Column({ space: 4 }) {
      Stack() {
        if (this.isSelected) {
          Capsule()
            .fill(this.primaryColor)
            .opacity(0.1)
            .width(64)
            .height(32)
        }
        Image($r('app.media.ic_home')) // Placeholder
          .width(24)
          .height(24)
          .fillColor(this.isSelected ? this.primaryColor : Color.Gray)
      }
      
      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? this.primaryColor : Color.Gray)
    }
  }
}