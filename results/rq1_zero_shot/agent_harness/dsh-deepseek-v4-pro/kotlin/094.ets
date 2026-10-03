interface AccessPoint {
  id: string
  name: string
  status: string
  isLocked: boolean
  lastAccessed: string
}

const accessPoints: AccessPoint[] = [
  { id: '1', name: 'Main Entrance', status: 'Active', isLocked: true, lastAccessed: '2h ago' },
  { id: '2', name: 'Garage Door', status: 'Active', isLocked: false, lastAccessed: '12m ago' },
  { id: '3', name: 'Server Room', status: 'Restricted', isLocked: true, lastAccessed: 'Yesterday' }
]

@Entry
@Component
struct Index {
  @State masterLockState: boolean = true

  build() {
    Scroll() {
      Column() {
        HeaderSection()

        Blank().height(40)

        MasterStatusCard({ isLocked: this.masterLockState, onToggle: () => { this.masterLockState = !this.masterLockState } })

        Blank().height(32)

        Text('My Access Points').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#444444')

        Blank().height(16)

        AccessPointList()

        Blank().height(32)

        Text('Recent Activity').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#444444')

        Blank().height(16)

        ActivityLogItem({ time: '10:42 AM', event: 'Main Gate unlocked', user: 'You' })
        ActivityLogItem({ time: '09:15 AM', event: 'Guest Entry Denied', user: 'System' })
        ActivityLogItem({ time: '08:30 AM', event: 'Garage Door opened', user: 'Alice' })
      }
      .width('100%')
      .padding(24)
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
      Column() {
        Text('Welcome back,').fontSize(14).fontColor('#9E9E9E')
        Text('David Miller').fontSize(24).fontWeight(FontWeight.Bolder)
      }
      Stack() {
        Text('👤').fontSize(24).fontColor('#000000')
      }
      .width(48).height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')
      .border({ width: 1, color: '#E0E0E0' })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct MasterStatusCard {
  @Prop isLocked: boolean = true
  onToggle: () => void = () => {}

  build() {
    const statusColor = this.isLocked ? '#212121' : '#4CAF50'
    const statusText = this.isLocked ? 'SECURE' : 'UNLOCKED'
    const subText = this.isLocked ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.'
    const borderColor = this.isLocked ? 'rgba(33,33,33,0.1)' : 'rgba(76,175,80,0.1)'

    Column() {
      Stack() {
        Text(this.isLocked ? '🔒' : '✓').fontSize(36).fontColor(statusColor)
      }
      .width(80).height(80)
      .borderRadius(40)
      .backgroundColor('#FFFFFF')
      .border({ width: 2, color: borderColor })
      .onClick(() => { this.onToggle() })

      Blank().height(16)

      Text(statusText).fontSize(20).fontWeight(FontWeight.Bolder).letterSpacing(2).fontColor(statusColor)

      Blank().height(8)

      Text(subText).fontSize(14).fontColor('#9E9E9E')
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .borderRadius(24)
    .backgroundColor('#F8F8F8')
    .border({ width: 1, color: '#EFEFEF' })
  }
}

@Component
struct AccessPointList {
  build() {
    Column({ space: 12 }) {
      ForEach(accessPoints, (point: AccessPoint) => {
        AccessPointRow({ name: point.name, lastAccessed: point.lastAccessed, locked: point.isLocked })
      }, (point: AccessPoint) => point.id)
    }
  }
}

@Component
struct AccessPointRow {
  @Prop name: string = ''
  @Prop lastAccessed: string = ''
  @Prop locked: boolean = true
  @State checked: boolean = false

  aboutToAppear() {
    this.checked = !this.locked
  }

  build() {
    Row() {
      Row() {
        Stack() {
          Text('⌂').fontSize(20).fontColor('#000000')
        }
        .width(40).height(40)
        .borderRadius(10)
        .backgroundColor('#FAFAFA')

        Blank().width(16)

        Column() {
          Text(this.name).fontSize(16).fontWeight(FontWeight.Bold)
          Text(this.lastAccessed).fontSize(10).fontColor('#D3D3D3')
        }
      }
      .alignItems(VerticalAlign.Center)

      Toggle({ type: ToggleType.Switch, isOn: this.checked })
        .selectedColor('#000000')
        .switchPointColor('#FFFFFF')
        .onChange((isOn: boolean) => { this.checked = isOn })
    }
    .width('100%')
    .padding(16)
    .borderRadius(16)
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#EEEEEE' })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct ActivityLogItem {
  @Prop time: string = ''
  @Prop event: string = ''
  @Prop user: string = ''

  build() {
    Row() {
      Text(this.time).fontSize(12).fontColor('#9E9E9E').width(70)

      Divider()
        .vertical(true)
        .height(20)
        .width(1)
        .color('#EEEEEE')

      Blank().width(16)

      Column() {
        Text(this.event).fontSize(14).fontWeight(FontWeight.Medium)
        Text('by ' + this.user).fontSize(10).fontColor('#9E9E9E')
      }
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .alignItems(VerticalAlign.Center)
  }
}
