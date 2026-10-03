interface AccessPoint {
  id: string
  name: string
  status: string
  isLocked: boolean
  lastAccessed: string
}

class SecureColors {
  static readonly primary: string = '#000000'
  static readonly surface: string = '#F8F8F8'
  static readonly locked: string = '#212121'
  static readonly unlocked: string = '#4CAF50'
  static readonly border: string = '#EFEFEF'
  static readonly textGray: string = '#8E8E93'
  static readonly backgroundWhite: string = '#FFFFFF'
}

@Entry
@Component
struct SecureKeyScreen {
  @State masterLockState: boolean = true

  private accessPoints: AccessPoint[] = [
    { id: '1', name: 'Main Entrance', status: 'Active', isLocked: true, lastAccessed: '2h ago' },
    { id: '2', name: 'Garage Door', status: 'Active', isLocked: false, lastAccessed: '12m ago' },
    { id: '3', name: 'Server Room', status: 'Restricted', isLocked: true, lastAccessed: 'Yesterday' }
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

          Column() {
            ForEach(this.accessPoints, (point: AccessPoint) => {
              AccessPointRow({ item: point })
            }, (point: AccessPoint) => point.id)
          }
          .width('100%')
          .space(12)

          Blank()
            .height(32)

          Text('Recent Activity')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .width('100%')

          Blank()
            .height(16)

          Column() {
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
      Column() {
        Text('Welcome back,')
          .fontSize(14)
          .fontColor(SecureColors.textGray)

        Text('David Miller')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(SecureColors.primary)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Stack() {
        UserIcon()
      }
      .width(48)
      .height(48)
      .backgroundColor('#F5F5F5')
      .borderRadius(24)
      .border({ width: 1, color: '#E0E0E0' })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct UserIcon {
  build() {
    Stack() {
      Stack()
        .width(16)
        .height(16)
        .borderRadius(8)
        .backgroundColor('#000000')
        .position({ x: 16, y: 10 })

      Stack()
        .width(30)
        .height(14)
        .borderRadius({ topLeft: 15, topRight: 15, bottomLeft: 4, bottomRight: 4 })
        .backgroundColor('#000000')
        .position({ x: 9, y: 30 })
    }
    .width(48)
    .height(48)
  }
}

@Component
struct MasterStatusCard {
  isLocked: boolean = true
  onToggle: () => void = () => {}

  private getStatusColor(): string {
    return this.isLocked ? SecureColors.locked : SecureColors.unlocked
  }

  build() {
    Column() {
      Stack() {
        Stack() {
          LockStatusIcon({
            isLocked: this.isLocked,
            color: this.getStatusColor()
          })
        }
        .width(80)
        .height(80)
        .backgroundColor('#FFFFFF')
        .borderRadius(40)
        .border({
          width: 2,
          color: this.isLocked ? '#E6E6E6' : '#334CAF50'
        })
      }
      .width(80)
      .height(80)
      .onClick(() => {
        this.onToggle()
      })

      Text(this.isLocked ? 'SECURE' : 'UNLOCKED')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.getStatusColor())
        .letterSpacing(2)
        .margin({ top: 16 })

      Text(this.isLocked ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
        .fontSize(14)
        .fontColor(SecureColors.textGray)
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(SecureColors.surface)
    .borderRadius(24)
    .border({ width: 1, color: SecureColors.border })
  }
}

@Component
struct LockStatusIcon {
  isLocked: boolean = true
  color: string = SecureColors.locked

  build() {
    Stack() {
      if (this.isLocked) {
        Stack() {
          Stack()
            .width(22)
            .height(24)
            .border({ width: 4, color: this.color })
            .borderRadius({ topLeft: 11, topRight: 11, bottomLeft: 5, bottomRight: 5 })
            .backgroundColor('#FFFFFF')
            .position({ x: 7, y: 0 })

          Stack()
            .width(30)
            .height(25)
            .backgroundColor(this.color)
            .borderRadius(5)
            .position({ x: 3, y: 15 })
        }
        .width(36)
        .height(40)
      } else {
        Stack() {
          Text('✓')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
        }
        .width(36)
        .height(36)
        .borderRadius(18)
        .backgroundColor(this.color)
      }
    }
    .width(40)
    .height(40)
  }
}

@Component
struct AccessPointRow {
  item: AccessPoint = { id: '', name: '', status: '', isLocked: true, lastAccessed: '' }
  @State checked: boolean = false

  aboutToAppear(): void {
    this.checked = !this.item.isLocked
  }

  build() {
    Row() {
      Row() {
        Stack() {
          Text('⌂')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .offset({ y: -1 })
        }
        .width(40)
        .height(40)
        .backgroundColor('#FAFAFA')
        .borderRadius(10)

        Column() {
          Text(this.item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')

          Text(this.item.lastAccessed)
            .fontSize(11)
            .fontColor('#CCCCCC')
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 16 })
      }
      .alignItems(VerticalAlign.Center)
      .layoutWeight(1)

      Stack({ alignContent: this.checked ? Alignment.CenterEnd : Alignment.CenterStart }) {
        Stack()
          .width(28)
          .height(28)
          .borderRadius(14)
          .backgroundColor('#FFFFFF')
      }
      .width(52)
      .height(32)
      .padding(2)
      .backgroundColor(this.checked ? '#000000' : '#E2E2E4')
      .borderRadius(16)
      .border({
        width: this.checked ? 0 : 1,
        color: '#D5D5D5'
      })
      .onClick(() => {
        this.checked = !this.checked
      })
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
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
        .fontSize(12)
        .fontColor(SecureColors.textGray)
        .width(70)

      Stack()
        .width(1)
        .height(20)
        .backgroundColor('#EEEEEE')
        .margin({ right: 16 })

      Column() {
        Text(this.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')

        Text(`by ${this.user}`)
          .fontSize(11)
          .fontColor(SecureColors.textGray)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .alignItems(VerticalAlign.Center)
  }
}