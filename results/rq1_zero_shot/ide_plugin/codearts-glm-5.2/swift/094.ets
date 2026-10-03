class SkColors {
  static readonly black: string = '#FF000000'
  static readonly surface: string = '#FFF8F8F8'
  static readonly locked: string = '#FF212121'
  static readonly unlocked: string = '#FF4CAF50'
  static readonly border: string = '#FFEFEFEF'
  static readonly gray: string = '#FF808080'
  static readonly white: string = '#FFFFFFFF'
  static readonly headerBg: string = '#FFF5F5F5'
  static readonly headerStroke: string = '#FFE0E0E0'
  static readonly locked10: string = '#1A212121'
  static readonly unlocked10: string = '#1A4CAF50'
  static readonly iconBg: string = '#FFFAFAFA'
  static readonly rowBorder: string = '#FFEEEEEE'
  static readonly darkGray: string = '#FF333333'
  static readonly lightGray: string = '#FFCCCCCC'
}

class AccessPoint {
  name: string
  status: string
  isLocked: boolean
  lastAccessed: string

  constructor(name: string, status: string, isLocked: boolean, lastAccessed: string) {
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

  private accessPoints: AccessPoint[] = [
    new AccessPoint('Main Entrance', 'Active', true, '2h ago'),
    new AccessPoint('Garage Door', 'Active', false, '12m ago'),
    new AccessPoint('Server Room', 'Restricted', true, 'Yesterday'),
  ]

  build() {
    Stack() {
      Scroll() {
        Column() {
          Row() {
            Column() {
              Text('Welcome back,')
                .fontSize(14)
                .fontColor(SkColors.gray)
              Text('David Miller')
                .fontSize(24)
                .fontWeight(FontWeight.Black)
                .fontColor(SkColors.black)
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Stack() {
              Circle({ width: 48, height: 48 })
                .fill(SkColors.headerBg)
                .border({ width: 1, color: SkColors.headerStroke })
              Text('◉')
                .fontSize(20)
                .fontColor(SkColors.black)
            }
          }
          .margin({ top: 24 })

          Blank().height(40)

          Column() {
            Stack() {
              Circle({ width: 80, height: 80 })
                .fill(SkColors.white)
                .border({ width: 2, color: this.masterLockState ? SkColors.locked10 : SkColors.unlocked10 })
              Text(this.masterLockState ? '🔒' : '☑')
                .fontSize(36)
                .fontColor(this.masterLockState ? SkColors.locked : SkColors.unlocked)
            }
            .onClick(() => {
              this.masterLockState = !this.masterLockState
            })
            .margin({ bottom: 16 })

            Text(this.masterLockState ? 'SECURE' : 'UNLOCKED')
              .fontSize(22)
              .fontWeight(FontWeight.Black)
              .fontColor(this.masterLockState ? SkColors.locked : SkColors.unlocked)

            Text(this.masterLockState ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
              .fontSize(14)
              .fontColor(SkColors.gray)
              .margin({ top: 8 })
          }
          .padding(24)
          .backgroundColor(SkColors.surface)
          .borderRadius(24)
          .border({ width: 1, color: SkColors.border })

          Blank().height(32)

          Text('My Access Points')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(SkColors.darkGray)

          Blank().height(16)

          ForEach(this.accessPoints, (point: AccessPoint) => {
            AccessPointRow({ pName: point.name, pLastAccessed: point.lastAccessed, pIsLocked: point.isLocked })
          })

          Blank().height(32)

          Text('Recent Activity')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(SkColors.darkGray)

          Blank().height(16)

          ActivityLogItem({ time: '10:42 AM', event: 'Main Gate unlocked', user: 'You' })
          ActivityLogItem({ time: '09:15 AM', event: 'Guest Entry Denied', user: 'System' })
          ActivityLogItem({ time: '08:30 AM', event: 'Garage Door opened', user: 'Alice' })

          Blank().height(24)
        }
        .padding({ left: 24, right: 24 })
        .alignItems(HorizontalAlign.Start)
      }
      .scrollBar(BarState.Off)
    }
    .backgroundColor(SkColors.white)
    .width('100%')
    .height('100%')
  }
}

@Component
struct AccessPointRow {
  @Prop pName: string = ''
  @Prop pLastAccessed: string = ''
  @Prop pIsLocked: boolean = false
  @State checked: boolean = false

  aboutToAppear() {
    this.checked = !this.pIsLocked
  }

  build() {
    Row() {
      Row() {
        Stack() {
          Column() { Blank() }
            .width(40)
            .height(40)
            .backgroundColor(SkColors.iconBg)
            .borderRadius(10)
          Text('⌂')
            .fontSize(20)
            .fontColor(SkColors.black)
        }

        Column() {
          Text(this.pName)
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(SkColors.black)
          Text(this.pLastAccessed)
            .fontSize(11)
            .fontColor(SkColors.lightGray)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 16 })
      }

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: this.checked })
        .selectedColor(SkColors.black)
        .onChange((isOn: boolean) => {
          this.checked = isOn
        })
    }
    .padding(16)
    .backgroundColor(SkColors.white)
    .borderRadius(16)
    .border({ width: 1, color: SkColors.rowBorder })
    .margin({ top: 12 })
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
        .fontColor(SkColors.gray)
        .width(70)

      Column() { Blank() }
        .width(1)
        .height(20)
        .backgroundColor(SkColors.rowBorder)
        .margin({ right: 16 })

      Column() {
        Text(this.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(SkColors.black)
        Text(`by ${this.user}`)
          .fontSize(11)
          .fontColor(SkColors.gray)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Blank()
    }
    .padding({ top: 12, bottom: 12 })
  }
}