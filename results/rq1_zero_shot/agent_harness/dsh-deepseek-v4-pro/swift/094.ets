// Translated from 094.swift (Secure Key App)

class AccessPoint {
  id: string
  name: string
  status: string
  isLocked: boolean
  lastAccessed: string
  constructor(id: string, name: string, status: string, isLocked: boolean, lastAccessed: string) {
    this.id = id
    this.name = name
    this.status = status
    this.isLocked = isLocked
    this.lastAccessed = lastAccessed
  }
}

@Entry
@Component
struct Index {
  build() {
    SecureKeyScreen()
  }
}

@Component
struct SecureKeyScreen {
  @State masterLockState: boolean = true
  accessPoints: AccessPoint[] = [
    new AccessPoint('1', 'Main Entrance', 'Active', true, '2h ago'),
    new AccessPoint('2', 'Garage Door', 'Active', false, '12m ago'),
    new AccessPoint('3', 'Server Room', 'Restricted', true, 'Yesterday')
  ]

  build() {
    Stack() {
      Scroll() {
        Column() {
          HeaderSection()
            .padding({ top: 24 })

          Blank().height(40)

          MasterStatusCard({
            isLocked: this.masterLockState,
            onToggle: () => { this.masterLockState = !this.masterLockState }
          })

          Blank().height(32)

          Text('My Access Points')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')

          Blank().height(16)

          Column({ space: 12 }) {
            ForEach(this.accessPoints, (point: AccessPoint) => {
              AccessPointRow({ item: point })
            }, (point: AccessPoint) => point.id)
          }

          Blank().height(32)

          Text('Recent Activity')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')

          Blank().height(16)

          Column() {
            ActivityLogItem({ time: '10:42 AM', event: 'Main Gate unlocked', user: 'You' })
            ActivityLogItem({ time: '09:15 AM', event: 'Guest Entry Denied', user: 'System' })
            ActivityLogItem({ time: '08:30 AM', event: 'Garage Door opened', user: 'Alice' })
          }

          Blank().height(24)
        }
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 24, right: 24 })
      }
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column({ space: 2 }) {
        Text('Welcome back,')
          .fontSize(14)
          .fontColor('#808080')
        Text('David Miller')
          .fontSize(24)
          .fontWeight(FontWeight.Bolder)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack() {
        Circle()
          .fill('#F5F5F5')
          .stroke('#E0E0E0')
          .strokeWidth(1)
          .width(48)
          .height(48)
        Text('👤')
          .fontSize(20)
          .fontColor('#000000')
      }
    }
    .width('100%')
  }
}

@Component
struct MasterStatusCard {
  @Prop isLocked: boolean = true
  onToggle: () => void = () => {}

  build() {
    Column() {
      Button() {
        Stack() {
          Circle()
            .fill('#FFFFFF')
            .stroke(this.isLocked ? '#1A212121' : '#1A4DB04F')
            .strokeWidth(2)
            .width(80)
            .height(80)
          Text(this.isLocked ? '🔒' : '✅')
            .fontSize(36)
            .fontColor(this.isLocked ? '#212121' : '#4DB04F')
        }
      }
      .onClick(() => { this.onToggle() })
      .padding({ bottom: 16 })

      Text(this.isLocked ? 'SECURE' : 'UNLOCKED')
        .fontSize(22)
        .fontWeight(FontWeight.Bolder)
        .letterSpacing(2)
        .fontColor(this.isLocked ? '#212121' : '#4DB04F')

      Blank().height(8)

      Text(this.isLocked ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
        .fontSize(14)
        .fontColor('#808080')
    }
    .padding(24)
    .width('100%')
    .backgroundColor('#F7F7F7')
    .borderRadius(24)
    .border({ width: 1, color: '#F0F0F0', radius: 24 })
  }
}

@Component
struct AccessPointRow {
  @Prop item: AccessPoint = new AccessPoint('', '', '', false, '')
  @State checked: boolean = false

  aboutToAppear(): void {
    this.checked = !this.item.isLocked
  }

  build() {
    Row() {
      Row({ space: 16 }) {
        Stack() {
          Text('⌂')
            .fontSize(20)
            .fontColor('#000000')
        }
        .width(40)
        .height(40)
        .backgroundColor('#FAFAFA')
        .borderRadius(10)

        Column({ space: 2 }) {
          Text(this.item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Semibold)
            .fontColor('#000000')
          Text(this.item.lastAccessed)
            .fontSize(11)
            .fontColor('#CCCCCC')
        }
        .alignItems(HorizontalAlign.Start)
      }

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: this.checked })
        .onChange((isOn: boolean) => { this.checked = isOn })
        .selectedColor('#000000')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .border({ width: 1, color: '#EDEDED', radius: 16 })
  }
}

@Component
struct ActivityLogItem {
  @Prop time: string = ''
  @Prop event: string = ''
  @Prop user: string = ''

  build() {
    Row() {
      Text(this.time)
        .fontSize(12)
        .fontColor('#808080')
        .width(70)
        .textAlign(TextAlign.Start)

      Divider({ vertical: true })
        .color('#EDEDED')
        .height(20)
        .margin({ right: 16 })

      Column({ space: 2 }) {
        Text(this.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
        Text('by ' + this.user)
          .fontSize(11)
          .fontColor('#808080')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
  }
}
