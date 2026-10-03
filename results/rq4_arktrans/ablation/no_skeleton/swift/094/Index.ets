@Entry
@Component
struct SecureKeyApp {
  @State masterLockState: boolean = true

  build() {
    // === ZStack ===
    // props: {}
    // modifier: { width: '100%', height: '100%' }
    // children: 2
    Stack() {
      // === ColorRect (Background) ===
      // modifier: { width: '100%', height: '100%', backgroundColor: '#FFFFFF' }
      Column() {
        // Placeholder for background color
      }.width('100%').height('100%').backgroundColor('#FFFFFF')

      // === ScrollView ===
      // props: { barPosition: BarPosition.Outside, indicator: Indicator.Off }
      // modifier: { width: '100%', height: '100%' }
      // children: 1
      Scroll() {
        // === Column (Content Wrapper) ===
        // props: { space: 0 }
        // modifier: { width: '100%', padding: { left: 24, right: 24 } }
        // children: 9
        Column() {
          // === HeaderSection ===
          // modifier: { marginTop: 24 }
          Row() {
            Column({ space: 2 }) {
              Text('Welcome back,').fontSize(14).fontColor('#808080')
              Text('David Miller').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#000000')
            }
            Blank()
            Stack() {
              Circle().fill('#F5F5F5').width(48).height(48)
              Circle().stroke('#E0E0E0').strokeWidth(1).width(48).height(48)
              Image($r('app.media.startIcon')).width(20).height(20).objectFit(ImageFit.Contain)
            }
          }
          .margin({ top: 24 })

          // Spacer
          Column().height(40)

          // === MasterStatusCard ===
          // modifier: {}
          Column() {
            Button() {
              Stack() {
                Circle().fill('#FFFFFF').width(80).height(80)
                Circle().stroke(this.masterLockState ? '#2121211A' : '#4CAF501A').strokeWidth(2).width(80).height(80)
                // Using startIcon as placeholder for lock/checkmark based on rule 2
                Image($r('app.media.startIcon'))
                  .width(36).height(36)
                  .objectFit(ImageFit.Contain)
                  .fillColor(this.masterLockState ? '#212121' : '#4CAF50')
              }
            }
            .type(ButtonType.Circle)
            .backgroundColor('transparent')
            .borderWidth(0)
            .margin({ bottom: 16 })
            .onClick(() => {
              this.masterLockState = !this.masterLockState
            })

            Text(this.masterLockState ? 'SECURE' : 'UNLOCKED')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .letterSpacing(2)
              .fontColor(this.masterLockState ? '#212121' : '#4CAF50')

            Column().height(8)

            Text(this.masterLockState ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
              .fontSize(14)
              .fontColor('#808080')
          }
          .padding(24)
          .width('100%')
          .backgroundColor('#F8F8F8')
          .borderRadius(24)
          .border({ width: 1, color: '#EFEFEF' })

          // Spacer
          Column().height(32)

          // === Access Points Header ===
          Text('My Access Points').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#333333')

          // Spacer
          Column().height(16)

          // === Access Points List ===
          // props: { space: 12 }
          // children: 3
          Column({ space: 12 }) {
            // Item 1: Main Entrance
            AccessPointRowComponent({ name: 'Main Entrance', lastAccessed: '2h ago', isChecked: false })
            // Item 2: Garage Door
            AccessPointRowComponent({ name: 'Garage Door', lastAccessed: '12m ago', isChecked: true })
            // Item 3: Server Room
            AccessPointRowComponent({ name: 'Server Room', lastAccessed: 'Yesterday', isChecked: false })
          }

          // Spacer
          Column().height(32)

          // === Recent Activity Header ===
          Text('Recent Activity').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#333333')

          // Spacer
          Column().height(16)

          // === Activity Log ===
          // props: { space: 0 }
          // children: 3
          Column({ space: 0 }) {
            ActivityLogItemComponent({ time: '10:42 AM', event: 'Main Gate unlocked', user: 'You' })
            ActivityLogItemComponent({ time: '09:15 AM', event: 'Guest Entry Denied', user: 'System' })
            ActivityLogItemComponent({ time: '08:30 AM', event: 'Garage Door opened', user: 'Alice' })
          }

          // Spacer
          Column().height(24)
        }
      }
    }
    .width('100%').height('100%')
  }
}

// Component: AccessPointRow
@Component
struct AccessPointRowComponent {
  private name: string = ''
  private lastAccessed: string = ''
  @State isChecked: boolean = false

  constructor(props: { name: string, lastAccessed: string, isChecked: boolean }) {
    super()
    this.name = props.name
    this.lastAccessed = props.lastAccessed
    this.isChecked = props.isChecked
  }

  build() {
    // === Row ===
    // modifier: { padding: 16, backgroundColor: '#FFF', borderRadius: 16, border: { width: 1, color: '#EEEEEE' } }
    // children: 2
    Row() {
      // Left Content
      Row({ space: 16 }) {
        // Icon Box
        Stack() {
          Rect().fill('#FAFAFA').width(40).height(40).borderRadius(10)
          Image($r('app.media.startIcon')).width(20).height(20).objectFit(ImageFit.Contain)
        }

        // Texts
        Column({ space: 2 }) {
          Text(this.name).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#000000')
          Text(this.lastAccessed).fontSize(11).fontColor('#CCCCCC')
        }
      }

      Blank()

      // Toggle Switch Simulation
      Row() {
        if (this.isChecked) {
          Circle().fill('#000000').width(24).height(24).margin({ left: 24 })
        } else {
          Circle().fill('#FFFFFF').width(24).height(24).border({ width: 1, color: '#CCCCCC' }).margin({ left: 0 })
        }
      }
      .width(48).height(28).backgroundColor(this.isChecked ? '#000000' : '#E0E0E0').borderRadius(14)
      .onClick(() => {
        this.isChecked = !this.isChecked
      })
    }
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
  }
}

// Component: ActivityLogItem
@Component
struct ActivityLogItemComponent {
  private time: string = ''
  private event: string = ''
  private user: string = ''

  constructor(props: { time: string, event: string, user: string }) {
    super()
    this.time = props.time
    this.event = props.event
    this.user = props.user
  }

  build() {
    // === Row ===
    // modifier: { padding: { top: 12, bottom: 12 } }
    // children: 3
    Row() {
      Text(this.time).fontSize(12).fontColor('#808080').width(70).textAlign(TextAlign.Start)

      Column() {
        Divider().vertical(true).color('#EEEEEE').height(20)
      }.width(1).margin({ left: 16, right: 16 })

      Column({ space: 2 }) {
        Text(this.event).fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000')
        Text(`by ${this.user}`).fontSize(11).fontColor('#808080')
      }

      Blank()
    }
    .padding({ top: 12, bottom: 12 })
  }
}