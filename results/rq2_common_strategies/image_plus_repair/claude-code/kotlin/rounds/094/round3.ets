@Entry
@Component
struct SecureKeyScreen {
  @State masterLockState: boolean = true
  @State accessPoints: AccessPoint[] = [
    { id: '1', name: 'Main Entrance', status: 'Active', isLocked: true, lastAccessed: '2h ago' },
    { id: '2', name: 'Garage Door', status: 'Active', isLocked: false, lastAccessed: '12m ago' },
    { id: '3', name: 'Server Room', status: 'Restricted', isLocked: true, lastAccessed: 'Yesterday' }
  ]

  build() {
    Column() {
      Scroll() {
        Column() {
          this.HeaderSection()

          Blank().height(40)

          this.MasterStatusCard(this.masterLockState, () => {
            this.masterLockState = !this.masterLockState
          })

          Blank().height(32)

          Text('My Access Points')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#444444')
            .width('100%')

          Blank().height(16)

          this.AccessPointList()

          Blank().height(32)

          Text('Recent Activity')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#444444')
            .width('100%')

          Blank().height(16)

          this.ActivityLogItem('10:42 AM', 'Main Gate unlocked', 'You')
          this.ActivityLogItem('09:15 AM', 'Guest Entry Denied', 'System')
          this.ActivityLogItem('08:30 AM', 'Garage Door opened', 'Alice')
        }
        .padding({ left: 24, right: 24, top: 24, bottom: 24 })
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .backgroundColor(Color.White)
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
          .fontSize(16)
          .fontColor('#888888')
        Text('David Miller')
          .fontSize(32)
          .fontWeight(FontWeight.Bolder)
          .fontColor(Color.Black)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row() {
        // Profile icon circle
        Column() {
          Text('')
            .fontSize(24)
            .fontColor(Color.Black)
        }
        .width(48)
        .height(48)
        .borderRadius(24)
        .backgroundColor('#F5F5F5')
        .border({ width: 1, color: '#E0E0E0' })
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  MasterStatusCard(isLocked: boolean, onToggle: () => void) {
    Column() {
      // Status icon circle
      Column() {
        if (isLocked) {
          Text('')
            .fontSize(36)
            .fontColor('#212121')
        } else {
          Text('')
            .fontSize(36)
            .fontColor('#4CAF50')
        }
      }
      .width(80)
      .height(80)
      .borderRadius(40)
      .backgroundColor(Color.White)
      .border({ width: 2, color: isLocked ? 'rgba(33,33,33,0.1)' : 'rgba(76,175,80,0.1)' })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .onClick(() => onToggle())

      Blank().height(16)

      Text(isLocked ? 'SECURE' : 'UNLOCKED')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(isLocked ? '#212121' : '#4CAF50')
        .letterSpacing(2)

      Blank().height(8)

      Text(isLocked ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
        .fontSize(16)
        .fontColor('#888888')
    }
    .width('100%')
    .padding(24)
    .borderRadius(24)
    .backgroundColor('#F8F8F8')
    .border({ width: 1, color: '#EFEFEF' })
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  AccessPointList() {
    Column() {
      ForEach(this.accessPoints, (item: AccessPoint, index: number) => {
        this.AccessPointRow(item, index)
      }, (item: AccessPoint) => item.id)
    }
    .width('100%')
  }

  @Builder
  AccessPointRow(item: AccessPoint, index: number) {
    Row() {
      Row() {
        // Icon box
        Column() {
          Text('')
            .fontSize(20)
            .fontColor(Color.Black)
        }
        .width(40)
        .height(40)
        .borderRadius(10)
        .backgroundColor('#FAFAFA')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        Column() {
          Text(item.name)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
          Text(item.lastAccessed)
            .fontSize(12)
            .fontColor('#CCCCCC')
            .margin({ top: 2 })
        }
        .margin({ left: 16 })
        .alignItems(HorizontalAlign.Start)
      }

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: !item.isLocked })
        .onChange((isOn: boolean) => {
          this.accessPoints[index].isLocked = !isOn
        })
        .selectedColor(Color.Black)
        .switchPointColor(Color.White)
    }
    .width('100%')
    .padding(16)
    .borderRadius(16)
    .backgroundColor(Color.White)
    .border({ width: 1, color: '#EEEEEE' })
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: index < this.accessPoints.length - 1 ? 12 : 0 })
  }

  @Builder
  ActivityLogItem(time: string, event: string, user: string) {
    Row() {
      Text(time)
        .fontSize(12)
        .fontColor('#888888')
        .width(70)

      // Vertical divider
      Column() {
        Blank()
      }
      .width(1)
      .height(20)
      .backgroundColor('#EEEEEE')
      .margin({ left: 0, right: 0 })

      Column() {
        Text(event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
        Text('by ' + user)
          .fontSize(11)
          .fontColor('#888888')
          .margin({ top: 2 })
      }
      .margin({ left: 16 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .alignItems(VerticalAlign.Center)
  }
}

interface AccessPoint {
  id: string
  name: string
  status: string
  isLocked: boolean
  lastAccessed: string
}
