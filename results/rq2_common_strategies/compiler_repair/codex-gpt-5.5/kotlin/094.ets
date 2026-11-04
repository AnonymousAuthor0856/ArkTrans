class AccessPoint {
  id: string
  name: string
  status: string
  locked: boolean
  lastAccessed: string

  constructor(id: string, name: string, status: string, locked: boolean, lastAccessed: string) {
    this.id = id
    this.name = name
    this.status = status
    this.locked = locked
    this.lastAccessed = lastAccessed
  }
}

class ActivityItem {
  time: string
  event: string
  user: string

  constructor(time: string, event: string, user: string) {
    this.time = time
    this.event = event
    this.user = user
  }
}

@Entry
@Component
struct Index {
  @State masterLocked: boolean = true
  @State mainOpen: boolean = false
  @State garageOpen: boolean = true
  @State serverOpen: boolean = false

  private points: AccessPoint[] = [
    new AccessPoint('1', 'Main Entrance', 'Active', true, '2h ago'),
    new AccessPoint('2', 'Garage Door', 'Active', false, '12m ago'),
    new AccessPoint('3', 'Server Room', 'Restricted', true, 'Yesterday')
  ]

  private logs: ActivityItem[] = [
    new ActivityItem('10:42 AM', 'Main Gate unlocked', 'You'),
    new ActivityItem('09:15 AM', 'Guest Entry Denied', 'System'),
    new ActivityItem('08:30 AM', 'Garage Door opened', 'Alice')
  ]

  build() {
    Scroll() {
      Column() {
        this.HeaderSection()
        this.MasterStatusCard()
        Text('My Access Points')
          .width('100%')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#444444')
          .margin({ top: 32, bottom: 16 })
        ForEach(this.points, (point: AccessPoint) => {
          this.AccessPointRow(point)
        })
        Text('Recent Activity')
          .width('100%')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#444444')
          .margin({ top: 32, bottom: 16 })
        ForEach(this.logs, (log: ActivityItem) => {
          this.ActivityLogItem(log)
        })
      }
      .width('100%')
      .padding(24)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Welcome back,')
          .fontSize(14)
          .fontColor(Color.Gray)
        Text('David Miller')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill('#F5F5F5')
          .stroke('#E0E0E0')
          .strokeWidth(1)
        Text('人')
          .fontSize(24)
          .fontColor(Color.Black)
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  MasterStatusCard() {
    Column() {
      Stack() {
        Circle()
          .width(80)
          .height(80)
          .fill(Color.White)
          .stroke(this.masterLocked ? 'rgba(33,33,33,0.1)' : 'rgba(76,175,80,0.1)')
          .strokeWidth(2)
        Text(this.masterLocked ? '●' : '✓')
          .fontSize(36)
          .fontColor(this.masterLocked ? '#212121' : '#4CAF50')
          .fontWeight(FontWeight.Bold)
      }
      .onClick(() => {
        this.masterLocked = !this.masterLocked
      })

      Text(this.masterLocked ? 'SECURE' : 'UNLOCKED')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.masterLocked ? '#212121' : '#4CAF50')
        .margin({ top: 16 })
      Text(this.masterLocked ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
        .fontSize(14)
        .fontColor(Color.Gray)
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(24)
    .border({ width: 1, color: '#EFEFEF', radius: 24 })
    .backgroundColor('#F8F8F8')
    .alignItems(HorizontalAlign.Center)
    .margin({ top: 40 })
  }

  @Builder
  AccessPointRow(point: AccessPoint) {
    Row() {
      Row() {
        Stack() {
          Rect()
            .width(40)
            .height(40)
            .radius(10)
            .fill('#FAFAFA')
          Text('⌂')
            .fontSize(20)
            .fontColor(Color.Black)
        }
        Column() {
          Text(point.name)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
          Text(point.lastAccessed)
            .fontSize(12)
            .fontColor('#D3D3D3')
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 16 })
      }
      .alignItems(VerticalAlign.Center)

      Toggle({ type: ToggleType.Switch, isOn: this.isOpen(point.id) })
        .selectedColor(Color.Black)
        .onChange((on: boolean) => {
          this.setOpen(point.id, on)
        })
    }
    .width('100%')
    .padding(16)
    .border({ width: 1, color: '#EEEEEE', radius: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: 12 })
  }

  @Builder
  ActivityLogItem(log: ActivityItem) {
    Row() {
      Text(log.time)
        .fontSize(12)
        .fontColor(Color.Gray)
        .width(70)
      Divider()
        .vertical(true)
        .height(20)
        .color('#EEEEEE')
      Column() {
        Text(log.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
        Text('by ' + log.user)
          .fontSize(12)
          .fontColor(Color.Gray)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .alignItems(VerticalAlign.Center)
  }

  isOpen(id: string): boolean {
    if (id === '1') {
      return this.mainOpen
    }
    if (id === '2') {
      return this.garageOpen
    }
    return this.serverOpen
  }

  setOpen(id: string, open: boolean): void {
    if (id === '1') {
      this.mainOpen = open
    } else if (id === '2') {
      this.garageOpen = open
    } else {
      this.serverOpen = open
    }
  }
}
