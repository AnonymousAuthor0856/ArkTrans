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
  @State masterLockState: boolean = true
  @State pointChecked: boolean[] = [false, true, false]

  private readonly surface: string = '#F8F8F8'
  private readonly locked: string = '#212121'
  private readonly unlocked: string = '#4CAF50'
  private readonly cardBorder: string = '#EFEFEF'
  private readonly textGray: string = '#808080'
  private readonly accessPoints: AccessPoint[] = [
    new AccessPoint('1', 'Main Entrance', 'Active', true, '2h ago'),
    new AccessPoint('2', 'Garage Door', 'Active', false, '12m ago'),
    new AccessPoint('3', 'Server Room', 'Restricted', true, 'Yesterday')
  ]

  build() {
    Stack() {
      Scroll() {
        Column() {
          this.HeaderSection()
          Blank().height(40)
          this.MasterStatusCard()
          Blank().height(32)
          Text('My Access Points')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .width('100%')
          Blank().height(16)
          Column() {
            ForEach(this.accessPoints, (point: AccessPoint, index?: number) => {
              this.AccessPointRow(point, index === undefined ? 0 : index)
            }, (point: AccessPoint) => point.id)
          }
          .width('100%')
          Blank().height(32)
          Text('Recent Activity')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .width('100%')
          Blank().height(16)
          this.ActivityLogItem('10:42 AM', 'Main Gate unlocked', 'You')
          this.ActivityLogItem('09:15 AM', 'Guest Entry Denied', 'System')
          this.ActivityLogItem('08:30 AM', 'Garage Door opened', 'Alice')
          Blank().height(24)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 24 })
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
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
          .fontColor(this.textGray)
        Text('David Miller')
          .fontSize(24)
          .fontWeight(FontWeight.Bolder)
          .fontColor(Color.Black)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill('#F5F5F5')
          .stroke('#E0E0E0')
          .strokeWidth(1)
        Text('●')
          .fontSize(20)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
    }
    .width('100%')
  }

  @Builder
  MasterStatusCard() {
    Column() {
      Button() {
        Stack() {
          Circle()
            .width(80)
            .height(80)
            .fill(Color.White)
            .stroke(this.masterLockState ? '#1A212121' : '#1A4CAF50')
            .strokeWidth(2)
          Text(this.masterLockState ? '🔒' : '✓')
            .fontSize(36)
            .fontColor(this.masterLockState ? this.locked : this.unlocked)
        }
        .width(80)
        .height(80)
      }
      .backgroundColor(Color.Transparent)
      .margin({ bottom: 16 })
      .onClick(() => {
        this.masterLockState = !this.masterLockState
      })
      Text(this.masterLockState ? 'SECURE' : 'UNLOCKED')
        .fontSize(22)
        .fontWeight(FontWeight.Bolder)
        .letterSpacing(2)
        .fontColor(this.masterLockState ? this.locked : this.unlocked)
      Blank().height(8)
      Text(this.masterLockState ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
        .fontSize(14)
        .fontColor(this.textGray)
    }
    .width('100%')
    .padding(24)
    .backgroundColor(this.surface)
    .borderRadius(24)
    .border({ width: 1, color: this.cardBorder })
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  AccessPointRow(item: AccessPoint, index: number) {
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
        .width(40)
        .height(40)
        Column() {
          Text(item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
          Text(item.lastAccessed)
            .fontSize(11)
            .fontColor('#CCCCCC')
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 16 })
      }
      Blank()
      Toggle({ type: ToggleType.Switch, isOn: this.pointChecked[index] })
        .selectedColor(Color.Black)
        .onChange((value: boolean) => {
          this.pointChecked[index] = value
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
    .margin({ bottom: 12 })
  }

  @Builder
  ActivityLogItem(time: string, event: string, user: string) {
    Row() {
      Text(time)
        .fontSize(12)
        .fontColor(this.textGray)
        .width(70)
      Rect()
        .width(1)
        .height(20)
        .fill('#EEEEEE')
        .margin({ right: 16 })
      Column() {
        Text(event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
        Text('by ' + user)
          .fontSize(11)
          .fontColor(this.textGray)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
  }
}