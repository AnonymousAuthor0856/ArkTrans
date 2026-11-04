class DeviceItem {
  name: string
  status: string
  icon: string
  active: boolean

  constructor(name: string, status: string, icon: string, active: boolean) {
    this.name = name
    this.status = status
    this.icon = icon
    this.active = active
  }
}

@Entry
@Component
struct Index {
  @State livingOn: boolean = true
  @State lockOn: boolean = true
  @State bedroomOn: boolean = false
  @State routerOn: boolean = true
  @State kitchenOn: boolean = false
  @State corridorOn: boolean = true

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          this.HeaderSection()
          this.EnvironmentSummary()
          this.DevicesGrid()
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 24, bottom: 96 })
      }
      .width('100%')
      .height('100%')

      this.SmartHomeBottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Welcome Home,')
          .fontSize(16)
          .fontColor(Color.Gray)
        Text('Alex Johnson')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill('rgba(74,101,114,0.1)')
        Text('◉')
          .fontSize(30)
          .fontColor('#4A6572')
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  EnvironmentSummary() {
    Row() {
      this.EnvironmentCard('Temperature', '24°C', 'Comfortable', '#E3F2FD', '#1565C0')
      Column() {}
        .width(16)
      this.EnvironmentCard('Humidity', '45%', 'Normal', '#E8F5E9', '#2E7D32')
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .margin({ top: 32 })
  }

  @Builder
  EnvironmentCard(title: string, value: string, subtitle: string, color: string, textColor: string) {
    Column() {
      Text(title)
        .fontSize(13)
        .fontColor(textColor)
        .opacity(0.8)
      Column() {
        Text(value)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(textColor)
        Text(subtitle)
          .fontSize(12)
          .fontColor(textColor)
          .opacity(0.7)
          .margin({ top: 2 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .layoutWeight(1)
    .height(100)
    .padding(16)
    .borderRadius(16)
    .backgroundColor(color)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  DevicesGrid() {
    Column() {
      Text('My Devices')
        .width('100%')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
      Row() {
        Column() {
          this.DeviceCard('Living Room', '2 Lights On', '⌂', this.livingOn, () => {
            this.livingOn = !this.livingOn
          })
          this.DeviceCard('Bedroom AC', '22°C', '★', this.bedroomOn, () => {
            this.bedroomOn = !this.bedroomOn
          })
          this.DeviceCard('Kitchen', 'All Off', 'i', this.kitchenOn, () => {
            this.kitchenOn = !this.kitchenOn
          })
        }
        .layoutWeight(1)

        Column() {
          this.DeviceCard('Smart Lock', 'Locked', '●', this.lockOn, () => {
            this.lockOn = !this.lockOn
          })
          this.DeviceCard('Router', 'Online', '⌖', this.routerOn, () => {
            this.routerOn = !this.routerOn
          })
          this.DeviceCard('Corridor', 'Motion Detected', '!', this.corridorOn, () => {
            this.corridorOn = !this.corridorOn
          })
        }
        .layoutWeight(1)
        .margin({ left: 16 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)
      .margin({ top: 16 })
    }
    .width('100%')
    .margin({ top: 32 })
  }

  @Builder
  DeviceCard(name: string, status: string, icon: string, isChecked: boolean, toggle: () => void) {
    Column() {
      Row() {
        Stack() {
          Circle()
            .width(36)
            .height(36)
            .fill(isChecked ? 'rgba(255,255,255,0.2)' : '#F0F0F0')
          Text(icon)
            .fontSize(20)
            .fontColor(isChecked ? Color.White : Color.Gray)
            .fontWeight(FontWeight.Bold)
        }

        Toggle({ type: ToggleType.Switch, isOn: isChecked })
          .selectedColor(isChecked ? 'rgba(255,255,255,0.4)' : '#D0D0D0')
          .onChange(() => {
            toggle()
          })
          .width(44)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text(name)
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
          .fontColor(isChecked ? Color.White : Color.Black)
        Text(isChecked ? 'On' : 'Off')
          .fontSize(12)
          .fontColor(isChecked ? 'rgba(255,255,255,0.7)' : Color.Gray)
          .margin({ top: 4 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .height(140)
    .width('100%')
    .padding(16)
    .borderRadius(20)
    .backgroundColor(isChecked ? '#4A6572' : Color.White)
    .justifyContent(FlexAlign.SpaceBetween)
    .shadow({ radius: isChecked ? 12 : 4, color: isChecked ? 'rgba(74,101,114,0.24)' : 'rgba(0,0,0,0.08)', offsetY: isChecked ? 8 : 2 })
    .margin({ bottom: 16 })
  }

  @Builder
  SmartHomeBottomBar() {
    Row() {
      this.NavItem('⌂', 'Home', true)
      this.NavItem('★', 'Scenes', false)
      this.NavItem('⚙', 'Settings', false)
    }
    .width('100%')
    .height(72)
    .padding({ left: 20, right: 20 })
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.White)
    .borderRadius({ topLeft: 24, topRight: 24 })
    .shadow({ radius: 12, color: 'rgba(0,0,0,0.12)', offsetY: -2 })
  }

  @Builder
  NavItem(icon: string, label: string, selected: boolean) {
    Column() {
      Text(icon)
        .fontSize(22)
        .fontColor(selected ? '#4A6572' : Color.Gray)
      Text(label)
        .fontSize(12)
        .fontColor(selected ? '#4A6572' : Color.Gray)
        .margin({ top: 2 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}
