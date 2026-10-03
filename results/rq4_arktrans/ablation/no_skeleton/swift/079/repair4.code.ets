@Entry
@Component
struct SmartHomeApp {
  @State v: number = 0

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.Bottom }
    // modifier: { width: '100%', height: '100%' }
    // children: 2
    Stack({ alignContent: Alignment.Bottom }) {
      // === Column ===
      // props: { space: 0 }
      // modifier: { width: '100%', layoutWeight: 1 }
      // children: 1
      Column({ space: 0 }) {
        // === Scroll ===
        // props: { scroller: Scroller.new(this) }
        // modifier: { width: '100%' }
        // children: 1
        Scroll() {
          // === Column ===
          // props: { space: 0, alignment: HorizontalAlign.Start }
          // modifier: { width: '100%' }
          // children: 7
          Column({ space: 0, alignment: HorizontalAlign.Start }) {
            // === Blank ===
            // modifier: { height: 24 }
            Blank().height(24)

            // === HeaderSection ===
            // modifier: { padding: { left: 24, right: 24 } }
            // children: 1
            HeaderSection()

            // === Blank ===
            // modifier: { height: 32 }
            Blank().height(32)

            // === EnvironmentSummary ===
            // modifier: { padding: { left: 24, right: 24 } }
            // children: 1
            EnvironmentSummary()

            // === Blank ===
            // modifier: { height: 32 }
            Blank().height(32)

            // === DevicesGrid ===
            // modifier: { padding: { left: 24, right: 24 } }
            // children: 1
            DevicesGrid()

            // === Blank ===
            // modifier: { height: 100 }
            Blank().height(100)
          }.width('100%')
        }
      }.width('100%').layoutWeight(1)

      // === SmartHomeBottomBar ===
      // children: 1
      SmartHomeBottomBar()
    }.width('100%').height('100%')
  }
}

// MARK: - Models
interface DeviceItem {
  id: string;
  name: string;
  status: string;
  icon: Resource;
  isActive: boolean;
}

// MARK: - Components

@Component
struct HeaderSection {
  build() {
    // === Row ===
    // props: { verticalAlignment: VerticalAlign.Center }
    // modifier: { width: '100%' }
    // children: 3
    Row({ verticalAlignment: VerticalAlign.Center }) {
      // === Column ===
      // props: { space: 4, alignment: HorizontalAlign.Start }
      // modifier: { width: 'auto' }
      // children: 2
      Column({ space: 4, alignment: HorizontalAlign.Start }) {
        // === Text ===
        // props: { text: 'Welcome Home,' }
        // modifier: { fontSize: 16, fontColor: '#9E9E9E' }
        Text('Welcome Home,').fontSize(16).fontColor('#9E9E9E')

        // === Text ===
        // props: { text: 'Alex Johnson' }
        // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, fontColor: '#000' }
        Text('Alex Johnson').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#000')
      }

      // === Blank ===
      Blank()

      // === Stack ===
      // props: { alignContent: Alignment.Center }
      // modifier: { width: 48, height: 48, backgroundColor: '#F0F4F8', borderRadius: 24 }
      // children: 1
      Stack({ alignContent: Alignment.Center }) {
        // === Image ===
        // modifier: { width: 32, height: 32, objectFit: ImageFit.Contain }
        Image($r('app.media.startIcon')).width(32).height(32).objectFit(ImageFit.Contain)
      }.width(48).height(48).backgroundColor('#F0F4F8').borderRadius(24)
    }.width('100%')
  }
}

@Component
struct EnvironmentSummary {
  build() {
    // === Row ===
    // props: { space: 16 }
    // modifier: { width: '100%' }
    // children: 2
    Row({ space: 16 }) {
      // === EnvironmentCard ===
      // props: { title: 'Temperature', value: '24°C', subtitle: 'Comfortable', bgColor: '#E3F2FD', textColor: '#1565C0' }
      // modifier: { layoutWeight: 1 }
      // children: 1
      EnvironmentCard({ title: 'Temperature', value: '24°C', subtitle: 'Comfortable', bgColor: '#E3F2FD', textColor: '#1565C0' }).layoutWeight(1)

      // === EnvironmentCard ===
      // props: { title: 'Humidity', value: '45%', subtitle: 'Normal', bgColor: '#E8F5E9', textColor: '#2E7D32' }
      // modifier: { layoutWeight: 1 }
      // children: 1
      EnvironmentCard({ title: 'Humidity', value: '45%', subtitle: 'Normal', bgColor: '#E8F5E9', textColor: '#2E7D32' }).layoutWeight(1)
    }.width('100%')
  }
}

@Component
struct EnvironmentCard {
  @Prop title: string = ''
  @Prop value: string = ''
  @Prop subtitle: string = ''
  @Prop bgColor: string = ''
  @Prop textColor: string = ''

  build() {
    // === Column ===
    // props: { space: 0, alignment: HorizontalAlign.Start }
    // modifier: { width: '100%', height: 100, padding: 16, backgroundColor: this.bgColor, borderRadius: 16 }
    // children: 3
    Column({ space: 0, alignment: HorizontalAlign.Start }) {
      // === Text ===
      // props: { text: this.title }
      // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: this.textColor }
      Text(this.title).fontSize(12).fontWeight(FontWeight.Medium).fontColor(this.textColor)

      // === Blank ===
      Blank()

      // === Column ===
      // props: { space: 0, alignment: HorizontalAlign.Start }
      // modifier: { width: '100%' }
      // children: 2
      Column({ space: 0, alignment: HorizontalAlign.Start }) {
        // === Text ===
        // props: { text: this.value }
        // modifier: { fontSize: 22, fontWeight: FontWeight.Bold, fontColor: this.textColor }
        Text(this.value).fontSize(22).fontWeight(FontWeight.Bold).fontColor(this.textColor)

        // === Text ===
        // props: { text: this.subtitle }
        // modifier: { fontSize: 11, fontColor: this.textColor }
        Text(this.subtitle).fontSize(11).fontColor(this.textColor)
      }.width('100%')
    }.width('100%').height(100).padding(16).backgroundColor(this.bgColor).borderRadius(16)
  }
}

@Component
struct DevicesGrid {
  private devices: DeviceItem[] = []

  aboutToAppear() {
    this.devices = [
      { id: '1', name: 'Living Room', status: '2 Lights On', icon: $r('app.media.startIcon'), isActive: true },
      { id: '2', name: 'Smart Lock', status: 'Locked', icon: $r('app.media.startIcon'), isActive: true },
      { id: '3', name: 'Bedroom AC', status: '22°C', icon: $r('app.media.startIcon'), isActive: false },
      { id: '4', name: 'Router', status: 'Online', icon: $r('app.media.startIcon'), isActive: true },
      { id: '5', name: 'Kitchen', status: 'All Off', icon: $r('app.media.startIcon'), isActive: false },
      { id: '6', name: 'Corridor', status: 'Motion Detected', icon: $r('app.media.startIcon'), isActive: true }
    ]
  }

  build() {
    // === Column ===
    // props: { space: 16, alignment: HorizontalAlign.Start }
    // modifier: { width: '100%' }
    // children: 2
    Column({ space: 16, alignment: HorizontalAlign.Start }) {
      // === Text ===
      // props: { text: 'My Devices' }
      // modifier: { fontSize: 20, fontWeight: FontWeight.Bold, fontColor: '#000' }
      Text('My Devices').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#000')

      // === Grid ===
      // props: { columnsTemplate: '1fr 1fr', columnsGap: 16, rowsGap: 16 }
      // modifier: { width: '100%' }
      // children: 6
      Grid() {
        .columnsTemplate('1fr 1fr')
        .columnsGap(16)
        .rowsGap(16)
        ForEach(this.devices, (device: DeviceItem) => {
          // === GridItem ===
          // children: 1
          GridItem() {
            // === DeviceCard ===
            // props: { device: device }
            // children: 1
            DeviceCard({ device: device })
          }
        })
      }.width('100%')
    }.width('100%')
  }
}

@Component
struct DeviceCard {
  @State isChecked: boolean = false
  @Prop device: DeviceItem = {} as DeviceItem

  build() {
    // === Column ===
    // props: { space: 0, alignment: HorizontalAlign.Start }
    // modifier: { width: '100%', height: 140, padding: 16, backgroundColor: this.isChecked ? '#4A6572' : '#FFF', borderRadius: 20, shadow: { radius: 8, color: this.isChecked ? '#7F4A6572' : '#0D000000', offsetX: 0, offsetY: 4 } }
    // children: 3
    Column({ space: 0, alignment: HorizontalAlign.Start }) {
      // === Row ===
      // props: { space: 0 }
      // modifier: { width: '100%' }
      // children: 3
      Row({ space: 0 }) {
        // === Stack ===
        // props: { alignContent: Alignment.Center }
        // modifier: { width: 36, height: 36, backgroundColor: this.isChecked ? '#4DFFFFFF' : '#F0F0F0', borderRadius: 18 }
        // children: 1
        Stack({ alignContent: Alignment.Center }) {
          // === Image ===
          // modifier: { width: 14, height: 14, objectFit: ImageFit.Contain }
          Image(this.device.icon).width(14).height(14).objectFit(ImageFit.Contain)
        }.width(36).height(36).backgroundColor(this.isChecked ? '#4DFFFFFF' : '#F0F0F0').borderRadius(18)

        // === Blank ===
        Blank()

        // === Toggle ===
        // props: { type: ToggleType.Switch, isOn: this.isChecked }
        // modifier: { width: 40, height: 24 }
        Toggle({ type: ToggleType.Switch, isOn: this.isChecked }).width(40).height(24)
          .onChange((isOn: boolean) => {
            this.isChecked = isOn
          })
      }.width('100%')

      // === Blank ===
      Blank()

      // === Column ===
      // props: { space: 4, alignment: HorizontalAlign.Start }
      // modifier: { width: '100%' }
      // children: 2
      Column({ space: 4, alignment: HorizontalAlign.Start }) {
        // === Text ===
        // props: { text: this.device.name }
        // modifier: { fontSize: 14, fontWeight: FontWeight.SemiBold, fontColor: this.isChecked ? '#FFF' : '#000' }
        Text(this.device.name).fontSize(14).fontWeight(FontWeight.Bold).fontColor(this.isChecked ? '#FFF' : '#000')

        // === Text ===
        // props: { text: this.isChecked ? 'On' : 'Off' }
        // modifier: { fontSize: 11, fontColor: this.isChecked ? '#B3FFFFFF' : '#9E9E9E' }
        Text(this.isChecked ? 'On' : 'Off').fontSize(11).fontColor(this.isChecked ? '#B3FFFFFF' : '#9E9E9E')
      }.width('100%')
    }.width('100%').height(140).padding(16).backgroundColor(this.isChecked ? '#4A6572' : '#FFF').borderRadius(20).shadow({ radius: 8, color: this.isChecked ? '#7F4A6572' : '#0D000000', offsetX: 0, offsetY: 4 })
  }
}

@Component
struct SmartHomeBottomBar {
  build() {
    // === Stack ===
    // props: { alignContent: Alignment.Top }
    // modifier: { width: '100%', height: 80, backgroundColor: '#FFF', borderRadius: { topLeft: 24, topRight: 24 }, shadow: { radius: 4, color: '#0D000000', offsetX: 0, offsetY: -2 } }
    // children: 1
    Stack({ alignContent: Alignment.Top }) {
      // === Row ===
      // props: { space: 0 }
      // modifier: { width: '100%', padding: { top: 16 } }
      // children: 5
      Row({ space: 0 }) {
        // === Blank ===
        Blank()

        // === NavBarItem ===
        // props: { icon: $r('app.media.startIcon'), label: 'Home', isSelected: true }
        // children: 1
        NavBarItem({ icon: $r('app.media.startIcon'), label: 'Home', isSelected: true })

        // === Blank ===
        Blank()

        // === NavBarItem ===
        // props: { icon: $r('app.media.startIcon'), label: 'Scenes', isSelected: false }
        // children: 1
        NavBarItem({ icon: $r('app.media.startIcon'), label: 'Scenes', isSelected: false })

        // === Blank ===
        Blank()

        // === NavBarItem ===
        // props: { icon: $r('app.media.startIcon'), label: 'Settings', isSelected: false }
        // children: 1
        NavBarItem({ icon: $r('app.media.startIcon'), label: 'Settings', isSelected: false })
      }.width('100%').padding({ top: 16 })
    }.width('100%').height(80).backgroundColor('#FFF').borderRadius({ topLeft: 24, topRight: 24 }).shadow({ radius: 4, color: '#0D000000', offsetX: 0, offsetY: -2 })
  }
}

@Component
struct NavBarItem {
  @Prop icon: Resource = $r('app.media.startIcon')
  @Prop label: string = ''
  @Prop isSelected: boolean = false

  build() {
    // === Column ===
    // props: { space: 4 }
    // modifier: { width: 'auto' }
    // children: 2
    Column({ space: 4 }) {
      // === Stack ===
      // props: { alignContent: Alignment.Center }
      // modifier: { width: 64, height: 32, backgroundColor: this.isSelected ? '#1A4A6572' : '#FFF', borderRadius: 16 }
      // children: 1
      Stack({ alignContent: Alignment.Center }) {
        // === Image ===
        // modifier: { width: 24, height: 24, objectFit: ImageFit.Contain }
        Image(this.icon).width(24).height(24).objectFit(ImageFit.Contain)
      }.width(64).height(32).backgroundColor(this.isSelected ? '#1A4A6572' : '#FFF').borderRadius(16)

      // === Text ===
      // props: { text: this.label }
      // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: this.isSelected ? '#4A6572' : '#9E9E9E' }
      Text(this.label).fontSize(12).fontWeight(FontWeight.Medium).fontColor(this.isSelected ? '#4A6572' : '#9E9E9E')
    }.width('auto')
  }
}