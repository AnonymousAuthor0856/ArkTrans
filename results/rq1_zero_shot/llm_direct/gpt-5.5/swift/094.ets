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

class SecureColors {
  static readonly primary: string = '#000000'
  static readonly surface: string = '#F8F8F8'
  static readonly locked: string = '#212121'
  static readonly unlocked: string = '#4CAF50'
  static readonly border: string = '#EFEFEF'
  static readonly textGray: string = '#808080'
  static readonly backgroundWhite: string = '#FFFFFF'
}

@Entry
@Component
struct SecureKeyScreen {
  @State private masterLockState: boolean = true

  private accessPoints: AccessPoint[] = [
    new AccessPoint('1', 'Main Entrance', 'Active', true, '2h ago'),
    new AccessPoint('2', 'Garage Door', 'Active', false, '12m ago'),
    new AccessPoint('3', 'Server Room', 'Restricted', true, 'Yesterday')
  ]

  build() {
    Stack() {
      Scroll() {
        Column() {
          HeaderSection()
            .margin({ top: 24 })

          Blank()
            .height(40)

          MasterStatusCard({
            isLocked: this.masterLockState,
            onToggle: () => {
              this.masterLockState = !this.masterLockState
            }
          })

          Blank()
            .height(32)

          Text('My Access Points')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .width('100%')

          Blank()
            .height(16)

          Column({ space: 12 }) {
            ForEach(this.accessPoints, (point: AccessPoint) => {
              AccessPointRow({ item: point })
            }, (point: AccessPoint) => point.id)
          }
          .width('100%')

          Blank()
            .height(32)

          Text('Recent Activity')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .width('100%')

          Blank()
            .height(16)

          Column({ space: 0 }) {
            ActivityLogItem({ time: '10:42 AM', event: 'Main Gate unlocked', user: 'You' })
            ActivityLogItem({ time: '09:15 AM', event: 'Guest Entry Denied', user: 'System' })
            ActivityLogItem({ time: '08:30 AM', event: 'Garage Door opened', user: 'Alice' })
          }
          .width('100%')

          Blank()
            .height(24)
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(SecureColors.backgroundWhite)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column({ space: 2 }) {
        Text('Welcome back,')
          .fontSize(14)
          .fontColor(SecureColors.textGray)

        Text('David Miller')
          .fontSize(24)
          .fontWeight(FontWeight.Black)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack() {
        Text('person')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')
      .border({ width: 1, color: '#E0E0E0' })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct MasterStatusCard {
  isLocked: boolean = true
  onToggle: () => void = () => {}

  private statusColor(): string {
    return this.isLocked ? SecureColors.locked : SecureColors.unlocked
  }

  private statusBorderColor(): string {
    return this.isLocked ? '#1A212121' : '#1A4CAF50'
  }

  build() {
    Column({ space: 0 }) {
      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Stack() {
          Text(this.isLocked ? 'lock' : '✓')
            .fontSize(this.isLocked ? 18 : 36)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.statusColor())
        }
        .width(80)
        .height(80)
        .borderRadius(40)
        .backgroundColor(Color.White)
        .border({ width: 2, color: this.statusBorderColor() })
      }
      .padding(0)
      .backgroundColor(Color.Transparent)
      .onClick(() => {
        this.onToggle()
      })
      .margin({ bottom: 16 })

      Text(this.isLocked ? 'SECURE' : 'UNLOCKED')
        .fontSize(22)
        .fontWeight(FontWeight.Black)
        .letterSpacing(2)
        .fontColor(this.statusColor())

      Blank()
        .height(8)

      Text(this.isLocked ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
        .fontSize(14)
        .fontColor(SecureColors.textGray)
    }
    .width('100%')
    .padding(24)
    .backgroundColor(SecureColors.surface)
    .borderRadius(24)
    .border({ width: 1, color: SecureColors.border })
    .alignItems(HorizontalAlign.Center)
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
      Row({ space: 16 }) {
        Stack() {
          Text('⌂')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }
        .width(40)
        .height(40)
        .borderRadius(10)
        .backgroundColor('#FAFAFA')

        Column({ space: 2 }) {
          Text(this.item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)

          Text(this.item.lastAccessed)
            .fontSize(11)
            .fontColor('#CCCCCC')
        }
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(VerticalAlign.Center)

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: this.checked })
        .selectedColor(Color.Black)
        .onChange((isOn: boolean) => {
          this.checked = isOn
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct ActivityLogItem {
  time: string = ''
  event: string = ''
  user: string = ''

  build() {
    Row({ space: 0 }) {
      Text(this.time)
        .fontSize(12)
        .fontColor(SecureColors.textGray)
        .width(70)
        .textAlign(TextAlign.Start)

      Divider()
        .vertical(true)
        .color('#EEEEEE')
        .strokeWidth(1)
        .height(20)
        .margin({ right: 16 })

      Column({ space: 2 }) {
        Text(this.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)

        Text(`by ${this.user}`)
          .fontSize(11)
          .fontColor(SecureColors.textGray)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .alignItems(VerticalAlign.Center)
  }
}