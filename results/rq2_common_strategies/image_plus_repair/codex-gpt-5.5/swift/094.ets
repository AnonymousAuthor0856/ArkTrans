import window from '@ohos.window'

interface AccessPoint {
  id: string
  name: string
  lastAccessed: string
  checked: boolean
}

@Entry
@Component
struct SecureKeyApp {
  @State private masterLockState: boolean = true
  @State private accessPoints: AccessPoint[] = [
    { id: '1', name: 'Main Entrance', lastAccessed: '2h ago', checked: false },
    { id: '2', name: 'Garage Door', lastAccessed: '12m ago', checked: true },
    { id: '3', name: 'Server Room', lastAccessed: 'Yesterday', checked: false }
  ]

  aboutToAppear(): void {
    try {
      let win = window.getLastWindow(getContext(this))
      win.then((value: window.Window) => {
        value.setWindowLayoutFullScreen(true)
      })
    } catch (_) {
      // Full-screen layout is optional for preview environments.
    }
  }

  private toggleAccessPoint(index: number, value: boolean): void {
    let next: AccessPoint[] = this.accessPoints.slice()
    next[index] = {
      id: next[index].id,
      name: next[index].name,
      lastAccessed: next[index].lastAccessed,
      checked: value
    }
    this.accessPoints = next
  }

  build() {
    Scroll() {
      Column({ space: 0 }) {
        this.header()
        Blank().height(40)
        this.masterStatusCard()
        Blank().height(32)
        this.sectionTitle('My Access Points')
        Blank().height(16)

        Column({ space: 12 }) {
          ForEach(this.accessPoints, (item: AccessPoint, index: number) => {
            this.accessPointRow(item, index)
          }, (item: AccessPoint) => item.id)
        }

        Blank().height(32)
        this.sectionTitle('Recent Activity')
        Blank().height(16)
        this.activityLog()
        Blank().height(24)
      }
      .width('100%')
      .padding({ left: 48, right: 48, top: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .scrollBar(BarState.Off)
  }

  @Builder
  private header() {
    Row() {
      Column({ space: 2 }) {
        Text('Welcome back,')
          .fontSize(28)
          .fontColor('#929298')
          .fontWeight(FontWeight.Normal)
        Text('David Miller')
          .fontSize(48)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)
      }
      .alignItems(HorizontalAlign.Start)

      Blank().layoutWeight(1)

      Stack() {
        Circle()
          .width(98)
          .height(98)
          .fill('#F5F5F5')
          .border({ width: 2, color: '#E0E0E0' })
        Column() {
          Circle()
            .width(16)
            .height(16)
            .fill(Color.Black)
          Blank().height(6)
          Row() {
            Blank()
              .width(34)
              .height(15)
              .borderRadius(15)
              .backgroundColor(Color.Black)
          }
        }
      }
      .width(98)
      .height(98)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  private masterStatusCard() {
    Column({ space: 0 }) {
      Button({ type: ButtonType.Circle }) {
        Stack() {
          Circle()
            .width(160)
            .height(160)
            .fill(Color.White)
            .border({
              width: 4,
              color: this.masterLockState ? '#E4E4E4' : '#A8D5AA'
            })
          if (this.masterLockState) {
            Column() {
              Row() {
                Blank()
                  .width(38)
                  .height(38)
                  .border({ width: 7, color: '#212121' })
                  .borderRadius(22)
              }
              .clip(true)
              .height(35)
              Blank()
                .width(48)
                .height(42)
                .backgroundColor('#212121')
                .borderRadius(8)
            }
          } else {
            Text('✓')
              .fontSize(72)
              .fontColor('#4CAF50')
              .fontWeight(FontWeight.Bold)
          }
        }
      }
      .width(160)
      .height(160)
      .backgroundColor(Color.Transparent)
      .padding(0)
      .onClick(() => {
        this.masterLockState = !this.masterLockState
      })
      .margin({ bottom: 24 })

      Text(this.masterLockState ? 'SECURE' : 'UNLOCKED')
        .fontSize(44)
        .fontColor(this.masterLockState ? '#212121' : '#4CAF50')
        .fontWeight(FontWeight.Bold)
        .letterSpacing(4)

      Blank().height(8)

      Text(this.masterLockState
        ? 'All perimeter doors are locked.'
        : 'Perimeter access is currently open.')
        .fontSize(28)
        .fontColor('#929298')
    }
    .width('100%')
    .padding(48)
    .backgroundColor('#F8F8F8')
    .borderRadius(48)
    .border({ width: 2, color: '#EFEFEF' })
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  private sectionTitle(title: string) {
    Text(title)
      .fontSize(32)
      .fontColor('#333333')
      .fontWeight(FontWeight.Bold)
  }

  @Builder
  private accessPointRow(item: AccessPoint, index: number) {
    Row() {
      Row({ space: 16 }) {
        Stack() {
          Row()
            .width(80)
            .height(80)
            .backgroundColor('#FAFAFA')
            .borderRadius(20)
          Text('⌂')
            .fontSize(54)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
        }
        .width(80)
        .height(80)

        Column({ space: 2 }) {
          Text(item.name)
            .fontSize(32)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Medium)
          Text(item.lastAccessed)
            .fontSize(22)
            .fontColor('#C9C9C9')
        }
        .alignItems(HorizontalAlign.Start)
      }

      Blank().layoutWeight(1)

      Toggle({ type: ToggleType.Switch, isOn: item.checked })
        .selectedColor(Color.Black)
        .width(102)
        .height(62)
        .onChange((value: boolean) => {
          this.toggleAccessPoint(index, value)
        })
    }
    .width('100%')
    .padding(32)
    .backgroundColor(Color.White)
    .borderRadius(32)
    .border({ width: 2, color: '#EEEEEE' })
  }

  @Builder
  private activityLog() {
    Column() {
      this.activityLogItem('10:42 AM', 'Main Gate unlocked', 'You')
      this.activityLogItem('09:15 AM', 'Guest Entry Denied', 'System')
      this.activityLogItem('08:30 AM', 'Garage Door opened', 'Alice')
    }
    .width('100%')
  }

  @Builder
  private activityLogItem(time: string, event: string, user: string) {
    Row({ space: 0 }) {
      Text(time)
        .fontSize(22)
        .fontColor('#929298')
        .width(140)

      Blank()
        .width(2)
        .height(40)
        .backgroundColor('#EEEEEE')
        .margin({ right: 32 })

      Column({ space: 2 }) {
        Text(event)
          .fontSize(26)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Medium)
        Text(`by ${user}`)
          .fontSize(20)
          .fontColor('#929298')
      }
      .alignItems(HorizontalAlign.Start)

      Blank().layoutWeight(1)
    }
    .width('100%')
    .padding({ top: 24, bottom: 24 })
  }
}
