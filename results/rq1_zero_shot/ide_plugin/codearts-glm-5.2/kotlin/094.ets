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

class AppTokens {
  static readonly Colors = {
    black: '#FF000000',
    white: '#FFFFFFFF',
    gray: '#FF888888',
    lightGray: '#FFBDBDBD',
    darkGray: '#FF444444',
    secureBlack: '#FF212121',
    secureGreen: '#FF4CAF50',
    secureGreen10: '#1A4CAF50',
    secureBlack10: '#1A212121',
    cardBg: '#FFF8F8F8',
    cardBorder: '#FFEFEFEF',
    avatarBg: '#FFF5F5F5',
    avatarBorder: '#FFE0E0E0',
    rowBorder: '#FFEEEEEE',
    iconBg: '#FFFAFAFA',
    divider: '#FFEEEEEE'
  }
}

@Entry
@Component
struct SecureKeyScreen {
  @State masterLockState: boolean = true

  private accessPoints: AccessPoint[] = [
    new AccessPoint('1', 'Main Entrance', 'Active', true, '2h ago'),
    new AccessPoint('2', 'Garage Door', 'Active', false, '12m ago'),
    new AccessPoint('3', 'Server Room', 'Restricted', true, 'Yesterday')
  ]

  build() {
    Scroll() {
      Column() {
        Row() {
          Column() {
            Text('Welcome back,')
              .fontSize(14)
              .fontColor(AppTokens.Colors.gray)
            Text('David Miller')
              .fontSize(24)
              .fontWeight(FontWeight.Bolder)
              .fontColor(AppTokens.Colors.black)
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Row() {
            Text('☻')
              .fontSize(24)
              .fontColor(AppTokens.Colors.black)
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor(AppTokens.Colors.avatarBg)
          .border({ width: 1, color: AppTokens.Colors.avatarBorder })
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Column() {
          Row() {
            Text(this.masterLockState ? '🔒' : '✓')
              .fontSize(36)
              .fontColor(this.masterLockState ? AppTokens.Colors.secureBlack : AppTokens.Colors.secureGreen)
          }
          .width(80)
          .height(80)
          .borderRadius(40)
          .backgroundColor(AppTokens.Colors.white)
          .border({ width: 2, color: this.masterLockState ? AppTokens.Colors.secureBlack10 : AppTokens.Colors.secureGreen10 })
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .onClick(() => {
            this.masterLockState = !this.masterLockState
          })

          Text(this.masterLockState ? 'SECURE' : 'UNLOCKED')
            .fontSize(22)
            .fontWeight(FontWeight.Bolder)
            .letterSpacing(2)
            .fontColor(this.masterLockState ? AppTokens.Colors.secureBlack : AppTokens.Colors.secureGreen)
            .margin({ top: 16 })

          Text(this.masterLockState ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
            .fontSize(14)
            .fontColor(AppTokens.Colors.gray)
            .margin({ top: 8 })
        }
        .width('100%')
        .padding(24)
        .borderRadius(24)
        .backgroundColor(AppTokens.Colors.cardBg)
        .border({ width: 1, color: AppTokens.Colors.cardBorder })
        .alignItems(HorizontalAlign.Center)
        .margin({ top: 40 })

        Text('My Access Points')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.darkGray)
          .margin({ top: 32 })

        ForEach(this.accessPoints, (point: AccessPoint) => {
          AccessPointRow({
            name: point.name,
            lastAccessed: point.lastAccessed,
            initialChecked: !point.isLocked
          })
            .margin({ top: 12 })
        })

        Text('Recent Activity')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.darkGray)
          .margin({ top: 32 })

        ActivityLogItem({ time: '10:42 AM', event: 'Main Gate unlocked', user: 'You' })
        ActivityLogItem({ time: '09:15 AM', event: 'Guest Entry Denied', user: 'System' })
        ActivityLogItem({ time: '08:30 AM', event: 'Garage Door opened', user: 'Alice' })
      }
      .width('100%')
      .padding(24)
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
  }
}

@Component
struct AccessPointRow {
  @Prop name: string
  @Prop lastAccessed: string
  @Prop initialChecked: boolean
  @State checked: boolean = false

  aboutToAppear() {
    this.checked = this.initialChecked
  }

  build() {
    Row() {
      Row() {
        Row() {
          Text('⌂')
            .fontSize(20)
            .fontColor(AppTokens.Colors.black)
        }
        .width(40)
        .height(40)
        .borderRadius(10)
        .backgroundColor(AppTokens.Colors.iconBg)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        Column() {
          Text(this.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.black)
          Text(this.lastAccessed)
            .fontSize(10)
            .fontColor(AppTokens.Colors.lightGray)
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 16 })
      }
      .alignItems(VerticalAlign.Center)
      .layoutWeight(1)

      Toggle({ type: ToggleType.Switch, isOn: this.checked })
        .selectedColor(AppTokens.Colors.black)
        .onChange((isOn: boolean) => {
          this.checked = isOn
        })
    }
    .width('100%')
    .padding(16)
    .borderRadius(16)
    .backgroundColor(AppTokens.Colors.white)
    .border({ width: 1, color: AppTokens.Colors.rowBorder })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct ActivityLogItem {
  @Prop time: string
  @Prop event: string
  @Prop user: string

  build() {
    Row() {
      Text(this.time)
        .fontSize(12)
        .fontColor(AppTokens.Colors.gray)
        .width(70)

      Column()
        .width(1)
        .height(20)
        .backgroundColor(AppTokens.Colors.divider)

      Column() {
        Text(this.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.black)
        Text(`by ${this.user}`)
          .fontSize(10)
          .fontColor(AppTokens.Colors.gray)
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .alignItems(VerticalAlign.Center)
  }
}