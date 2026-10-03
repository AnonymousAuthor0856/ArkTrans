@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        // Header Section
        Row() {
          Column({ space: 4 }) {
            Text('Welcome Home,')
              .fontSize(18)
              .fontColor('#9CA3AF')
            Text('Alex Johnson')
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor('#1F2937')
          }

          Blank()

          Image($r('app.media.startIcon'))
            .width(56)
            .height(56)
            .borderRadius(28)
            .backgroundColor('#E5E7EB')
            .objectFit(ImageFit.Contain)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 40, bottom: 24 })

        // Temperature Card
        Column({ space: 8 }) {
          Text('Temperature')
            .fontSize(16)
            .fontColor('#3B82F6')
          Text('24°C')
            .fontSize(36)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2563EB')
          Text('Comfortable')
            .fontSize(16)
            .fontColor('#60A5FA')
        }
        .width('100%')
        .padding(24)
        .backgroundColor('#DBEAFE')
        .borderRadius(24)
        .margin({ left: 24, right: 24, bottom: 32 })

        // My Devices Title
        Text('My Devices')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1F2937')
          .margin({ left: 24, bottom: 24 })

        // Devices Grid
        DeviceGridRow() {
          DeviceCard({
            props: {
              title: 'Living Room',
              status: 'On',
              isActive: true,
              iconType: 'home'
            }
          })
          DeviceCard({
            props: {
              title: 'Smart Lock',
              status: 'On',
              isActive: true,
              iconType: 'lock'
            }
          })
        }
        .margin({ left: 24, right: 24, bottom: 16 })

        DeviceGridRow() {
          DeviceCard({
            props: {
              title: 'Bedroom AC',
              status: 'Off',
              isActive: false,
              iconType: 'star'
            }
          })
          DeviceCard({
            props: {
              title: 'Router',
              status: 'On',
              isActive: true,
              iconType: 'location'
            }
          })
        }
        .margin({ left: 24, right: 24, bottom: 100 })

      }.width('100%').height('100%').backgroundColor('#F3F4F6')

      // Bottom Navigation Bar
      Row() {
        NavItem({
          props: { label: 'Home', iconType: 'home', isActive: true }
        })
        NavItem({
          props: { label: 'Scenes', iconType: 'star', isActive: false }
        })
        NavItem({
          props: { label: 'Settings', iconType: 'settings', isActive: false }
        })
      }
      .width('100%')
      .height(80)
      .backgroundColor('#F9FAFB')
      .position({ x: 0, y: -20 })
      .borderRadius({ topLeft: 24, topRight: 24 })
      .shadow({ radius: 10, color: '#00000010' })
    }
    .width('100%')
    .height('100%')
  }
}

// --- Sub-components & Helpers ---

interface DeviceProps {
  title: string;
  status: string;
  isActive: boolean;
  iconType: string;
}

@Component
struct DeviceCard {
  @Prop props: DeviceProps = { title: '', status: '', isActive: false, iconType: '' };

  build() {
    Column() {
      Row() {
        CircleIcon({ type: this.props.iconType, active: this.props.isActive })
        Blank()
        ToggleSwitch({ isOn: this.props.status === 'On' })
      }
      .width('100%')
      .margin({ bottom: 24 })

      Text(this.props.title)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.props.isActive ? '#FFFFFF' : '#1F2937')
      
      Text(this.props.status)
        .fontSize(14)
        .fontColor(this.props.isActive ? '#D1D5DB' : '#9CA3AF')
        .margin({ top: 4 })
    }
    .width('100%')
    .layoutWeight(1)
    .padding(20)
    .borderRadius(24)
    .backgroundColor(this.props.isActive ? '#4B6572' : '#FFFFFF')
    .shadow(this.props.isActive ? { radius: 10, color: '#00000020' } : { radius: 0 })
  }
}

@Component
struct DeviceGridRow {
  @BuilderParam slot: () => void;

  build() {
    Row({ space: 16 }) {
      this.slot()
    }
    .width('100%')
  }
}

@Component
struct CircleIcon {
  @Prop type: string;
  @Prop active: boolean;

  build() {
    Stack() {
      // Using startIcon as a placeholder for all icons to satisfy resource rules
      // In a real app, you would switch based on 'type'
      Image($r('app.media.startIcon'))
        .width(24)
        .height(24)
        .fillColor(this.active ? Color.White : Color.Gray)
    }
    .width(48)
    .height(48)
    .borderRadius(24)
    .backgroundColor(this.active ? '#6B8290' : '#F3F4F6')
  }
}

@Component
struct ToggleSwitch {
  @Prop isOn: boolean;

  build() {
    Stack() {
      Circle()
        .width(24)
        .height(24)
        .fillColor(Color.White)
        .position({ x: this.isOn ? 32 : 4, y: 4 })
    }
    .width(48)
    .height(32)
    .borderRadius(16)
    .backgroundColor(this.isOn ? Color.White : Color.Gray)
    .opacity(this.isOn ? 1 : 0.5)
  }
}

interface NavItemProps {
  label: string;
  iconType: string;
  isActive: boolean;
}

@Component
struct NavItem {
  @Prop props: NavItemProps = { label: '', iconType: '', isActive: false };

  build() {
    Column({ space: 4 }) {
      Stack() {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor(this.props.isActive ? '#4B6572' : '#9CA3AF')
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(this.props.isActive ? '#E5E7EB' : Color.Transparent)

      Text(this.props.label)
        .fontSize(14)
        .fontColor(this.props.isActive ? '#4B6572' : '#6B7280')
    }
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
  }
}