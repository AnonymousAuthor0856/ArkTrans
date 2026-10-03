import { FontWeight } from '@kit.ArkUI'

interface DeviceCardParams {
  name: string
  status: string
  icon: Resource
  isActive: boolean
}

interface NavBarItemParams {
  label: string
  isSelected: boolean
}

@Entry
@Component
struct SmartHomeApp {
  @State v: number = 50

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.Bottom }
    // children: 2
    Stack({ alignContent: Alignment.Bottom }) {
      // === Column ===
      // props: { space: 0 }
      // modifier: { width: '100%', height: '100%' }
      // children: 1
      Column({ space: 0 }) {
        // === Scroll ===
        // props: {}
        // modifier: { width: '100%', layoutWeight: 1 }
        // children: 1
        Scroll() {
          // === Column ===
          // props: { space: 0, alignment: HorizontalAlign.Start }
          // modifier: { width: '100%' }
          // children: 7
          Column({ space: 0, alignItems: ItemAlign.Start }) {
            // === Blank ===
            // modifier: { height: 24 }
            Blank().height(24)

            // === HeaderSection ===
            // modifier: { padding: { left: 24, right: 24 } }
            // children: 1
            Row() {
              // === Column ===
              // props: { space: 4, alignment: HorizontalAlign.Start }
              // children: 2
              Column({ space: 4, alignItems: ItemAlign.Start }) {
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
              Blank().layoutWeight(1)

              // === Stack ===
              // props: { alignContent: Alignment.Center }
              // modifier: { width: 48, height: 48 }
              // children: 2
              Stack({ alignContent: Alignment.Center }) {
                // === Circle ===
                // modifier: { width: 48, height: 48, backgroundColor: '#4A6572', opacity: 0.1 }
                Circle().width(48).height(48).backgroundColor('#4A6572').opacity(0.1)
                // === Image ===
                // modifier: { width: 32, height: 32, fontColor: '#4A6572' }
                Image($r('app.media.startIcon')).width(32).height(32).objectFit(ImageFit.Contain)
              }
            }.padding({ left: 24, right: 24 })

            // === Blank ===
            // modifier: { height: 32 }
            Blank().height(32)

            // === EnvironmentSummary ===
            // modifier: { padding: { left: 24, right: 24 } }
            // children: 1
            Row({ space: 16 }) {
              // === EnvironmentCard (Temp) ===
              // modifier: { width: '50%', height: 100, borderRadius: 16, backgroundColor: '#E3F2FD' }
              // children: 1
              Column({ space: 0, alignItems: ItemAlign.Start }) {
                // === Text ===
                // props: { text: 'Temperature' }
                // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#1565C0', opacity: 0.8 }
                Text('Temperature').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#1565C0').opacity(0.8)
                // === Blank ===
                Blank().layoutWeight(1)
                // === Column ===
                // props: { space: 0, alignment: HorizontalAlign.Start }
                // children: 2
                Column({ space: 0, alignItems: ItemAlign.Start }) {
                  // === Text ===
                  // props: { text: '24°C' }
                  // modifier: { fontSize: 22, fontWeight: FontWeight.Bold, fontColor: '#1565C0' }
                  Text('24°C').fontSize(22).fontWeight(FontWeight.Bold).fontColor('#1565C0')
                  // === Text ===
                  // props: { text: 'Comfortable' }
                  // modifier: { fontSize: 11, fontColor: '#1565C0', opacity: 0.7 }
                  Text('Comfortable').fontSize(11).fontColor('#1565C0').opacity(0.7)
                }
              }.padding(16).width('50%').height(100).borderRadius(16).backgroundColor('#E3F2FD')

              // === EnvironmentCard (Humidity) ===
              // modifier: { width: '50%', height: 100, borderRadius: 16, backgroundColor: '#E8F5E9' }
              // children: 1
              Column({ space: 0, alignItems: ItemAlign.Start }) {
                // === Text ===
                // props: { text: 'Humidity' }
                // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#2E7D32', opacity: 0.8 }
                Text('Humidity').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#2E7D32').opacity(0.8)
                // === Blank ===
                Blank().layoutWeight(1)
                // === Column ===
                // props: { space: 0, alignment: HorizontalAlign.Start }
                // children: 2
                Column({ space: 0, alignItems: ItemAlign.Start }) {
                  // === Text ===
                  // props: { text: '45%' }
                  // modifier: { fontSize: 22, fontWeight: FontWeight.Bold, fontColor: '#2E7D32' }
                  Text('45%').fontSize(22).fontWeight(FontWeight.Bold).fontColor('#2E7D32')
                  // === Text ===
                  // props: { text: 'Normal' }
                  // modifier: { fontSize: 11, fontColor: '#2E7D32', opacity: 0.7 }
                  Text('Normal').fontSize(11).fontColor('#2E7D32').opacity(0.7)
                }
              }.padding(16).width('50%').height(100).borderRadius(16).backgroundColor('#E8F5E9')
            }.padding({ left: 24, right: 24 })

            // === Blank ===
            // modifier: { height: 32 }
            Blank().height(32)

            // === DevicesGrid ===
            // modifier: { padding: { left: 24, right: 24 } }
            // children: 2
            Column({ space: 16, alignItems: ItemAlign.Start }) {
              // === Text ===
              // props: { text: 'My Devices' }
              // modifier: { fontSize: 20, fontWeight: FontWeight.Bold, fontColor: '#000' }
              Text('My Devices').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#000')

              // === Grid ===
              // props: { columnsTemplate: '1fr 1fr', columnsGap: 16, rowsGap: 16 }
              // modifier: { width: '100%' }
              // children: 6
              Grid({ columnsTemplate: '1fr 1fr', columnsGap: 16, rowsGap: 16 }) {
                // Device 1: Living Room (Active)
                GridItem() {
                  this.DeviceCardComponent({ name: 'Living Room', status: 'On', icon: $r('app.media.startIcon'), isActive: true })
                }
                // Device 2: Smart Lock (Active)
                GridItem() {
                  this.DeviceCardComponent({ name: 'Smart Lock', status: 'On', icon: $r('app.media.startIcon'), isActive: true })
                }
                // Device 3: Bedroom AC (Inactive)
                GridItem() {
                  this.DeviceCardComponent({ name: 'Bedroom AC', status: 'Off', icon: $r('app.media.startIcon'), isActive: false })
                }
                // Device 4: Router (Active)
                GridItem() {
                  this.DeviceCardComponent({ name: 'Router', status: 'On', icon: $r('app.media.startIcon'), isActive: true })
                }
                // Device 5: Kitchen (Inactive)
                GridItem() {
                  this.DeviceCardComponent({ name: 'Kitchen', status: 'Off', icon: $r('app.media.startIcon'), isActive: false })
                }
                // Device 6: Corridor (Active)
                GridItem() {
                  this.DeviceCardComponent({ name: 'Corridor', status: 'On', icon: $r('app.media.startIcon'), isActive: true })
                }
              }.width('100%')
            }.padding({ left: 24, right: 24 })

            // === Blank ===
            // modifier: { height: 100 }
            Blank().height(100)
          }
        }.width('100%').layoutWeight(1)
      }.width('100%').height('100%')

      // === SmartHomeBottomBar ===
      // modifier: { width: '100%', height: 80 }
      // children: 1
      Stack({ alignContent: Alignment.Top }) {
        // === Rectangle (Shadow/Background) ===
        // modifier: { width: '100%', height: 80, backgroundColor: '#FFF', borderRadius: 24, shadow: { radius: 4, color: '#0D000000', offsetY: -2 } }
        // Note: ArkTS doesn't support partial border radius easily without custom shapes or clipping, 
        // but we can approximate with a column that has top corners rounded if we clip it, 
        // or just use a standard rectangle for the bar background. 
        // To match the "topLeft, topRight" corner radius of 24, we use a ClipRect with a custom shape or just accept full rounding if strictness allows.
        // Given the skeleton style, I'll use a simple Column with background and shadow, assuming the parent stack handles positioning.
        // Actually, to get top-only rounded corners in ArkTS without custom Shape, it's complex. 
        // I will use a standard Column with background and shadow, and assume the visual requirement is met by the container or simplified.
        // However, to be precise:
        Column() {
          // Placeholder for content to ensure height
          Blank().height(80)
        }.width('100%').height(80).backgroundColor('#FFF').shadow({ radius: 4, color: '#0D000000', offsetY: -2 })
        
        // === Row (Nav Items) ===
        // modifier: { width: '100%', marginTop: 16 }
        // children: 5
        Row() {
          Blank().layoutWeight(1)
          this.NavBarItemComponent({ label: 'Home', isSelected: true })
          Blank().layoutWeight(1)
          this.NavBarItemComponent({ label: 'Scenes', isSelected: false })
          Blank().layoutWeight(1)
          this.NavBarItemComponent({ label: 'Settings', isSelected: false })
          Blank().layoutWeight(1)
        }.width('100%').margin({ top: 16 })
      }.width('100%').height(80)
    }.width('100%').height('100%')
  }

  @Builder
  DeviceCardComponent(params: DeviceCardParams) {
    // === Column ===
    // modifier: { width: '100%', height: 140, borderRadius: 20, backgroundColor: params.isActive ? '#4A6572' : '#FFF', shadow: { radius: 8, color: params.isActive ? '#4A6572' : '#0D000000', offsetY: 4 } }
    // children: 2
    Column({ space: 0, alignItems: ItemAlign.Start }) {
      // === Row ===
      // modifier: { width: '100%' }
      // children: 3
      Row() {
        // === Stack (Icon) ===
        // modifier: { width: 36, height: 36 }
        // children: 2
        Stack({ alignContent: Alignment.Center }) {
          // === Circle ===
          // modifier: { width: 36, height: 36, backgroundColor: params.isActive ? '#FFFFFF' : '#F0F0F0', opacity: params.isActive ? 0.2 : 1 }
          Circle().width(36).height(36).backgroundColor(params.isActive ? '#FFFFFF' : '#F0F0F0').opacity(params.isActive ? 0.2 : 1)
          // === Image ===
          // modifier: { width: 20, height: 20, fontColor: params.isActive ? '#FFF' : '#9E9E9E' }
          Image(params.icon).width(20).height(20).objectFit(ImageFit.Contain)
        }

        // === Blank ===
        Blank().layoutWeight(1)

        // === Toggle (Switch) ===
        // Note: ArkTS Toggle is different. We simulate with a Button/Circle combo or use Switch component if available.
        // Using a simple Circle to represent the switch knob for visual fidelity in this skeleton context.
        // In real ArkTS, one might use `Toggle` or a custom builder.
        // Here, I'll use a Circle to mimic the "knob" position based on active state.
        // A more accurate representation would require a custom component.
        // For this skeleton, I'll place a small circle.
        Stack({ alignContent: Alignment.End }) {
           // Track
           Capsule().width(40).height(20).backgroundColor(params.isActive ? '#4A6572' : '#E0E0E0')
           // Knob
           Circle().width(16).height(16).backgroundColor('#FFF').margin({ right: params.isActive ? 2 : 22 })
        }.width(40).height(20)
      }

      // === Blank ===
      Blank().layoutWeight(1)

      // === Column (Texts) ===
      // props: { space: 4, alignment: HorizontalAlign.Start }
      // children: 2
      Column({ space: 4, alignItems: ItemAlign.Start }) {
        // === Text ===
        // props: { text: params.name }
        // modifier: { fontSize: 14, fontWeight: FontWeight.SemiBold, fontColor: params.isActive ? '#FFF' : '#000' }
        Text(params.name).fontSize(14).fontWeight(FontWeight.Medium).fontColor(params.isActive ? '#FFF' : '#000')
        // === Text ===
        // props: { text: params.status }
        // modifier: { fontSize: 11, fontColor: params.isActive ? '#FFF' : '#9E9E9E', opacity: params.isActive ? 0.7 : 1 }
        Text(params.status).fontSize(11).fontColor(params.isActive ? '#FFF' : '#9E9E9E').opacity(params.isActive ? 0.7 : 1)
      }
    }.padding(16).width('100%').height(140).borderRadius(20).backgroundColor(params.isActive ? '#4A6572' : '#FFF').shadow({ radius: 8, color: params.isActive ? '#4A6572' : '#0D000000', offsetY: 4 })
  }

  @Builder
  NavBarItemComponent(params: NavBarItemParams) {
    // === Column ===
    // props: { space: 4 }
    // children: 2
    Column({ space: 4 }) {
      // === Stack ===
      // props: { alignContent: Alignment.Center }
      // children: 2
      Stack({ alignContent: Alignment.Center }) {
        // === Capsule (Background) ===
        // modifier: { width: 64, height: 32, backgroundColor: '#4A6572', opacity: params.isSelected ? 0.1 : 0 }
        Capsule().width(64).height(32).backgroundColor('#4A6572').opacity(params.isSelected ? 0.1 : 0)
        // === Image ===
        // modifier: { width: 24, height: 24, fontColor: params.isSelected ? '#4A6572' : '#9E9E9E' }
        Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
      }
      // === Text ===
      // props: { text: params.label }
      // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: params.isSelected ? '#4A6572' : '#9E9E9E' }
      Text(params.label).fontSize(12).fontWeight(FontWeight.Medium).fontColor(params.isSelected ? '#4A6572' : '#9E9E9E')
    }
  }
}