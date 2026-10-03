import window from '@ohos.window'

interface AccessPoint {
  name: string
  lastAccessed: string
  checked: boolean
}

@Entry
@Component
struct SecureKeyScreen {
  @State masterLocked: boolean = true
  @State accessPoints: AccessPoint[] = [
    { name: 'Main Entrance', lastAccessed: '2h ago', checked: false },
    { name: 'Garage Door', lastAccessed: '12m ago', checked: true },
    { name: 'Server Room', lastAccessed: 'Yesterday', checked: false }
  ]

  aboutToAppear(): void {
    window.getLastWindow(getContext(this)).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true)
    })
  }

  toggleAccessPoint(index: number): void {
    const next: AccessPoint[] = this.accessPoints.map((item: AccessPoint, itemIndex: number) => {
      if (itemIndex === index) {
        return {
          name: item.name,
          lastAccessed: item.lastAccessed,
          checked: !item.checked
        }
      }
      return item
    })
    this.accessPoints = next
  }

  build() {
    Scroll() {
      Column() {
        this.header()
        Blank().height(40)
        this.masterStatus()
        Blank().height(32)
        Text('My Access Points')
          .fontSize(31)
          .fontWeight(FontWeight.Bold)
          .fontColor('#454545')
          .width('100%')
        Blank().height(16)

        ForEach(this.accessPoints, (item: AccessPoint, index: number) => {
          this.accessPointRow(item, index)
        }, (item: AccessPoint) => item.name)

        Blank().height(32)
        Text('Recent Activity')
          .fontSize(31)
          .fontWeight(FontWeight.Bold)
          .fontColor('#454545')
          .width('100%')
        Blank().height(8)
        this.activityRow('10:42 AM', 'Main Gate unlocked', 'You')
        this.activityRow('09:15 AM', 'Guest Entry Denied', 'System')
        this.activityRow('08:30 AM', 'Garage Door opened', 'Alice')
      }
      .width('100%')
      .padding({ left: 48, right: 48, top: 52, bottom: 32 })
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
    .backgroundColor(Color.White)
  }

  @Builder
  header() {
    Row() {
      Column() {
        Text('Welcome back,')
          .fontSize(28)
          .fontColor('#858585')
          .fontWeight(FontWeight.Medium)
        Text('David Miller')
          .fontSize(47)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank().layoutWeight(1)

      Stack() {
        Circle()
          .width(96)
          .height(96)
          .fill('#F7F7F7')
          .stroke('#DEDEDE')
          .strokeWidth(2)
        Column() {
          Circle()
            .width(16)
            .height(16)
            .fill(Color.Black)
          Blank().height(5)
          Row()
            .width(33)
            .height(16)
            .backgroundColor(Color.Black)
            .borderRadius({ topLeft: 18, topRight: 18 })
        }
      }
      .width(96)
      .height(96)
      .margin({ top: 2 })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  masterStatus() {
    Column() {
      Stack() {
        Circle()
          .width(160)
          .height(160)
          .fill(Color.White)
          .stroke('#E5E5E5')
          .strokeWidth(4)
        this.lockIcon()
      }
      .width(160)
      .height(160)
      .onClick(() => {
        this.masterLocked = !this.masterLocked
      })

      Text(this.masterLocked ? 'SECURE' : 'UNLOCKED')
        .fontSize(43)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.masterLocked ? '#232323' : '#4CAF50')
        .letterSpacing(3)
        .margin({ top: 30 })
      Text(this.masterLocked ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
        .fontSize(28)
        .fontColor('#8A8A8A')
        .margin({ top: 12 })
    }
    .width('100%')
    .height(400)
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#F8F8F8')
    .border({
      width: 2,
      color: '#EEEEEE',
      radius: 48
    })
  }

  @Builder
  lockIcon() {
    Stack() {
      Row()
        .width(48)
        .height(44)
        .backgroundColor('#242424')
        .borderRadius(7)
        .margin({ top: 28 })
      Row()
        .width(30)
        .height(35)
        .border({
          width: 7,
          color: '#242424',
          radius: 15
        })
        .margin({ top: -22 })
      Circle()
        .width(12)
        .height(12)
        .fill(Color.White)
        .margin({ top: 28 })
    }
    .width(60)
    .height(70)
  }

  @Builder
  accessPointRow(item: AccessPoint, index: number) {
    Row() {
      Row() {
        Stack() {
          Text('⌂')
            .fontSize(38)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
        }
        .width(80)
        .height(80)
        .backgroundColor('#FBFBFB')
        .borderRadius(20)

        Column() {
          Text(item.name)
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
          Text(item.lastAccessed)
            .fontSize(23)
            .fontWeight(FontWeight.Medium)
            .fontColor('#C8C8C8')
            .margin({ top: 7 })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 32 })
      }
      .alignItems(VerticalAlign.Center)

      Blank().layoutWeight(1)
      this.toggle(item.checked, index)
    }
    .width('100%')
    .height(160)
    .padding({ left: 32, right: 30 })
    .backgroundColor(Color.White)
    .border({
      width: 2,
      color: '#EEEEEE',
      radius: 32
    })
    .margin({ bottom: 12 })
  }

  @Builder
  toggle(checked: boolean, index: number) {
    Stack() {
      Row()
        .width(104)
        .height(64)
        .backgroundColor(checked ? Color.Black : '#EEEEEE')
        .borderRadius(34)
      Circle()
        .width(48)
        .height(48)
        .fill(checked ? Color.White : '#8C8C8C')
        .align(checked ? Alignment.End : Alignment.Start)
        .margin({ left: checked ? 48 : 8, right: checked ? 8 : 48 })
    }
    .width(104)
    .height(64)
    .onClick(() => {
      this.toggleAccessPoint(index)
    })
  }

  @Builder
  activityRow(time: string, event: string, user: string) {
    Row() {
      Text(time)
        .fontSize(21)
        .fontColor('#888888')
        .width(120)
      Divider()
        .vertical(true)
        .height(40)
        .width(2)
        .color('#EEEEEE')
      Column() {
        Text(event)
          .fontSize(23)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
        Text(`by ${user}`)
          .fontSize(18)
          .fontColor('#888888')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 24 })
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
  }
}
