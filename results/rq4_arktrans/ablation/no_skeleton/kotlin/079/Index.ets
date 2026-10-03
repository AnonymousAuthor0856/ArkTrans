@Entry
@Component
struct SmartHomeScreen {
  @State devices: DeviceItem[] = [
    { name: 'Living Room', status: '2 Lights On', icon: $r('app.media.startIcon'), isActive: true },
    { name: 'Smart Lock', status: 'Locked', icon: $r('app.media.startIcon'), isActive: true },
    { name: 'Bedroom AC', status: '22°C', icon: $r('app.media.startIcon'), isActive: false },
    { name: 'Router', status: 'Online', icon: $r('app.media.startIcon'), isActive: true },
    { name: 'Kitchen', status: 'All Off', icon: $r('app.media.startIcon'), isActive: false },
    { name: 'Corridor', status: 'Motion Detected', icon: $r('app.media.startIcon'), isActive: true }
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // === Main Content Column ===
      // props: { space: 32 }
      // modifier: { width: '100%', height: '100%', padding: { left: 24, right: 24, top: 24 }, backgroundColor: '#F5F6F8' }
      // children: 3
      Column({ space: 32 }) {
        // === Header Section ===
        // props: { space: 0 }
        // modifier: { width: '100%' }
        // children: 2
        Row() {
          // === Left Text Column ===
          // props: { space: 4 }
          // children: 2
          Column({ space: 4 }) {
            // === Text ===
            // props: { text: 'Welcome Home,' }
            // modifier: { fontSize: 16, color: '#9E9E9E' }
            Text('Welcome Home,').fontSize(16).fontColor('#9E9E9E')
            // === Text ===
            // props: { text: 'Alex Johnson' }
            // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, color: '#333333' }
            Text('Alex Johnson').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#333333')
          }

          // === Blank ===
          Blank()

          // === Avatar Box ===
          // modifier: { width: 48, height: 48, borderRadius: 24, backgroundColor: '#788D96' }
          // children: 1
          Row() {
            Image($r('app.media.startIcon')).width(32).height(32)
          }.width(48).height(48).borderRadius(24).backgroundColor('#788D96').justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
        }.width('100%').justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center)

        // === Environment Summary ===
        // props: { space: 16 }
        // modifier: { width: '100%' }
        // children: 2
        Row({ space: 16 }) {
          // === Temperature Card ===
          // modifier: { width: '50%', height: 100, borderRadius: 16, backgroundColor: '#E3F2FD', padding: 16 }
          // children: 1
          Column() {
            // === Text ===
            // props: { text: 'Temperature' }
            // modifier: { fontSize: 14, color: '#1565C0' }
            Text('Temperature').fontSize(14).fontColor('#1565C0')
            // === Blank ===
            Blank()
            // === Value Column ===
            // props: { space: 4 }
            // children: 2
            Column({ space: 4 }) {
              // === Text ===
              // props: { text: '24°C' }
              // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, color: '#1565C0' }
              Text('24°C').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#1565C0')
              // === Text ===
              // props: { text: 'Comfortable' }
              // modifier: { fontSize: 12, color: '#1565C0' }
              Text('Comfortable').fontSize(12).fontColor('#1565C0')
            }
          }.width('50%').height(100).borderRadius(16).backgroundColor('#E3F2FD').padding(16).justifyContent(FlexAlign.SpaceBetween)

          // === Humidity Card ===
          // modifier: { width: '50%', height: 100, borderRadius: 16, backgroundColor: '#E8F5E9', padding: 16 }
          // children: 1
          Column() {
            // === Text ===
            // props: { text: 'Humidity' }
            // modifier: { fontSize: 14, color: '#2E7D32' }
            Text('Humidity').fontSize(14).fontColor('#2E7D32')
            // === Blank ===
            Blank()
            // === Value Column ===
            // props: { space: 4 }
            // children: 2
            Column({ space: 4 }) {
              // === Text ===
              // props: { text: '45%' }
              // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, color: '#2E7D32' }
              Text('45%').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#2E7D32')
              // === Text ===
              // props: { text: 'Normal' }
              // modifier: { fontSize: 12, color: '#2E7D32' }
              Text('Normal').fontSize(12).fontColor('#2E7D32')
            }
          }.width('50%').height(100).borderRadius(16).backgroundColor('#E8F5E9').padding(16).justifyContent(FlexAlign.SpaceBetween)
        }.width('100%')

        // === Devices Grid Section ===
        // props: { space: 16 }
        // modifier: { width: '100%', layoutWeight: 1 }
        // children: 2
        Column({ space: 16 }) {
          // === Text ===
          // props: { text: 'My Devices' }
          // modifier: { fontSize: 24, fontWeight: FontWeight.Bold, color: '#333333' }
          Text('My Devices').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#333333')

          // === Grid ===
          // props: { columnsTemplate: '1fr 1fr', columnsGap: 16, rowsGap: 16 }
          // modifier: { width: '100%' }
          // children: 6
          Grid() {
            ForEach(this.devices, (device: DeviceItem) => {
              GridItem() {
                // === Device Card ===
                // modifier: { width: '100%', height: 140, borderRadius: 20, backgroundColor: device.isActive ? '#4A6572' : '#FFF', shadow: { radius: device.isActive ? 8 : 2, color: '#1F000000' }, padding: 16 }
                // children: 1
                Column() {
                  // === Top Row ===
                  // props: { space: 0 }
                  // modifier: { width: '100%' }
                  // children: 2
                  Row() {
                    // === Icon Circle ===
                    // modifier: { width: 36, height: 36, borderRadius: 18, backgroundColor: device.isActive ? '#788D96' : '#F0F0F0' }
                    // children: 1
                    Row() {
                      Image(device.icon).width(20).height(20)
                    }.width(36).height(36).borderRadius(18).backgroundColor(device.isActive ? '#788D96' : '#F0F0F0').justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)

                    // === Blank ===
                    Blank()

                    // === Switch ===
                    // props: { type: SwitchType.Switch, isOn: device.isActive }
                    // modifier: { width: 32, height: 16 }
                    Toggle({ type: ToggleType.Switch, isOn: device.isActive }).width(32).height(16)
                  }.width('100%').justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center)

                  // === Blank ===
                  Blank()

                  // === Bottom Text Column ===
                  // props: { space: 4 }
                  // children: 2
                  Column({ space: 4 }) {
                    // === Text ===
                    // props: { text: device.name }
                    // modifier: { fontSize: 16, fontWeight: FontWeight.SemiBold, color: device.isActive ? '#FFF' : '#333333' }
                    Text(device.name).fontSize(16).fontWeight(FontWeight.Medium).fontColor(device.isActive ? '#FFF' : '#333333')
                    // === Text ===
                    // props: { text: device.isActive ? 'On' : 'Off' }
                    // modifier: { fontSize: 12, color: device.isActive ? '#B0BEC5' : '#9E9E9E' }
                    Text(device.isActive ? 'On' : 'Off').fontSize(12).fontColor(device.isActive ? '#B0BEC5' : '#9E9E9E')
                  }
                }.width('100%').height(140).borderRadius(20).backgroundColor(device.isActive ? '#4A6572' : '#FFF').shadow({ radius: device.isActive ? 8 : 2, color: '#1F000000' }).padding(16).justifyContent(FlexAlign.SpaceBetween)
              }
            })
          }.columnsTemplate('1fr 1fr').columnsGap(16).rowsGap(16).width('100%')
        }.width('100%').layoutWeight(1)
      }.width('100%').height('100%').padding({ left: 24, right: 24, top: 24 }).backgroundColor('#F5F6F8')

      // === Bottom Navigation Bar ===
      // modifier: { width: '100%', height: 80, backgroundColor: '#FFF', borderRadius: { topLeft: 24, topRight: 24 }, shadow: { radius: 8, color: '#1F000000' }, padding: { top: 16, bottom: 16 } }
      // children: 1
      Row() {
        // === Nav Item: Home ===
        // modifier: { width: '33.33%', height: '100%' }
        // children: 1
        Column() {
          // === Icon Circle ===
          // modifier: { width: 48, height: 32, borderRadius: 16, backgroundColor: '#788D96' }
          // children: 1
          Row() {
            Image($r('app.media.startIcon')).width(24).height(24)
          }.width(48).height(32).borderRadius(16).backgroundColor('#788D96').justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
          // === Text ===
          // props: { text: 'Home' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, color: '#4A6572', marginTop: 4 }
          Text('Home').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#4A6572').margin({ top: 4 })
        }.width('33.33%').height('100%').justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)

        // === Nav Item: Scenes ===
        // modifier: { width: '33.33%', height: '100%' }
        // children: 1
        Column() {
          // === Icon ===
          // modifier: { width: 24, height: 24 }
          Image($r('app.media.startIcon')).width(24).height(24)
          // === Text ===
          // props: { text: 'Scenes' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, color: '#757575', marginTop: 4 }
          Text('Scenes').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#757575').margin({ top: 4 })
        }.width('33.33%').height('100%').justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)

        // === Nav Item: Settings ===
        // modifier: { width: '33.33%', height: '100%' }
        // children: 1
        Column() {
          // === Icon ===
          // modifier: { width: 24, height: 24 }
          Image($r('app.media.startIcon')).width(24).height(24)
          // === Text ===
          // props: { text: 'Settings' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, color: '#757575', marginTop: 4 }
          Text('Settings').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#757575').margin({ top: 4 })
        }.width('33.33%').height('100%').justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)
      }.width('100%').height(80).backgroundColor('#FFF').borderRadius({ topLeft: 24, topRight: 24 }).shadow({ radius: 8, color: '#1F000000' }).padding({ top: 16, bottom: 16 })
    }.width('100%').height('100%')
  }
}

interface DeviceItem {
  name: string;
  status: string;
  icon: Resource;
  isActive: boolean;
}