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
  @State private masterLockState: boolean = true

  build() {
    Scroll() {
      Column() {
        HeaderSection()

        Blank().height(40)

        MasterStatusCard({
          isLocked: this.masterLockState,
          onToggle: () => {
            this.masterLockState = !this.masterLockState
          }
        })

        Blank().height(32)

        Text('My Access Points')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#444444')
          .width('100%')

        Blank().height(16)

        AccessPointList()

        Blank().height(32)

        Text('Recent Activity')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#444444')
          .width('100%')

        Blank().height(16)

        ActivityLogItem({
          time: '10:42 AM',
          event: 'Main Gate unlocked',
          user: 'You'
        })

        ActivityLogItem({
          time: '09:15 AM',
          event: 'Guest Entry Denied',
          user: 'System'
        })

        ActivityLogItem({
          time: '08:30 AM',
          event: 'Garage Door opened',
          user: 'Alice'
        })
      }
      .width('100%')
      .padding({
        left: 24,
        right: 24,
        top: 52,
        bottom: 40
      })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .scrollBar(BarState.Off)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('Welcome back,')
          .fontSize(16)
          .fontColor('#888888')
          .fontWeight(FontWeight.Regular)

        Text('David Miller')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 6 })
      }
      .alignItems(HorizontalAlign.Start)

      Stack({ alignContent: Alignment.Center }) {
        Column({ space: 3 }) {
          Blank()
            .width(9)
            .height(9)
            .borderRadius(5)
            .backgroundColor(Color.Black)

          Blank()
            .width(26)
            .height(13)
            .borderRadius(13)
            .backgroundColor(Color.Black)
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')
      .border({
        width: 1,
        color: '#E0E0E0'
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct MasterStatusCard {
  @Prop isLocked: boolean = true
  onToggle: () => void = () => {
  }

  private statusColor(): string {
    return this.isLocked ? '#212121' : '#4CAF50'
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        if (this.isLocked) {
          LockGlyph({ colorValue: this.statusColor() })
        } else {
          Text('✓')
            .fontSize(42)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.statusColor())
        }
      }
      .width(80)
      .height(80)
      .borderRadius(40)
      .backgroundColor(Color.White)
      .border({
        width: 2,
        color: this.isLocked ? '#E4E4E4' : '#DDF2DF'
      })
      .onClick(() => {
        this.onToggle()
      })

      Blank().height(16)

      Text(this.isLocked ? 'SECURE' : 'UNLOCKED')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.statusColor())
        .letterSpacing(2)

      Blank().height(8)

      Text(this.isLocked ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
        .fontSize(16)
        .fontColor('#888888')
    }
    .width('100%')
    .padding({
      left: 24,
      right: 24,
      top: 48,
      bottom: 48
    })
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F8F8F8')
    .borderRadius(24)
    .border({
      width: 1,
      color: '#EFEFEF'
    })
  }
}

@Component
struct LockGlyph {
  colorValue: string = '#212121'

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Blank()
        .width(24)
        .height(30)
        .borderRadius(12)
        .border({
          width: 4,
          color: this.colorValue
        })
        .translate({ y: -9 })

      Blank()
        .width(34)
        .height(28)
        .borderRadius(5)
        .backgroundColor(this.colorValue)
        .translate({ y: 10 })

      Blank()
        .width(10)
        .height(10)
        .borderRadius(5)
        .backgroundColor(Color.White)
        .translate({ y: 10 })
    }
    .width(50)
    .height(52)
  }
}

@Component
struct AccessPointList {
  private accessPoints: AccessPoint[] = [
    new AccessPoint('1', 'Main Entrance', 'Active', true, '2h ago'),
    new AccessPoint('2', 'Garage Door', 'Active', false, '12m ago'),
    new AccessPoint('3', 'Server Room', 'Restricted', true, 'Yesterday')
  ]

  build() {
    Column({ space: 12 }) {
      ForEach(this.accessPoints, (point: AccessPoint) => {
        AccessPointRow({ item: point })
      }, (point: AccessPoint) => point.id)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct AccessPointRow {
  item: AccessPoint = new AccessPoint('', '', '', true, '')
  @State private checked: boolean = false

  aboutToAppear() {
    this.checked = !this.item.isLocked
  }

  build() {
    Row() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Text('⌂')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }
        .width(40)
        .height(40)
        .borderRadius(10)
        .backgroundColor('#FAFAFA')

        Blank().width(16)

        Column() {
          Text(this.item.name)
            .fontSize(17)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)

          Text(this.item.lastAccessed)
            .fontSize(13)
            .fontWeight(FontWeight.Bold)
            .fontColor('#D0D0D0')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(VerticalAlign.Center)
      .layoutWeight(1)

      SecureSwitch({
        checked: this.checked,
        onChange: (value: boolean) => {
          this.checked = value
        }
      })
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({
      width: 1,
      color: '#EEEEEE'
    })
  }
}

@Component
struct SecureSwitch {
  @Prop checked: boolean = false
  onChange: (value: boolean) => void = () => {
  }

  build() {
    Row() {
      Blank()
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(this.checked ? Color.White : '#8E8E8E')
    }
    .width(56)
    .height(32)
    .padding(4)
    .borderRadius(16)
    .backgroundColor(this.checked ? Color.Black : '#EEEEEE')
    .justifyContent(this.checked ? FlexAlign.End : FlexAlign.Start)
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      this.onChange(!this.checked)
    })
  }
}

@Component
struct ActivityLogItem {
  time: string = ''
  event: string = ''
  user: string = ''

  build() {
    Row() {
      Text(this.time)
        .fontSize(13)
        .fontColor('#888888')
        .width(70)

      Blank()
        .width(1)
        .height(20)
        .backgroundColor('#EEEEEE')

      Blank().width(16)

      Column() {
        Text(this.event)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)

        Text('by ' + this.user)
          .fontSize(12)
          .fontColor('#888888')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .padding({
      top: 12,
      bottom: 12
    })
    .alignItems(VerticalAlign.Center)
  }
}