@Entry
@Component
struct SecureKeyScreen {
  @State masterLockState: boolean = true;

  private accessPoints: AccessPoint[] = [
    { id: '1', name: 'Main Entrance', status: 'Active', isLocked: true, lastAccessed: '2h ago' },
    { id: '2', name: 'Garage Door', status: 'Active', isLocked: false, lastAccessed: '12m ago' },
    { id: '3', name: 'Server Room', status: 'Restricted', isLocked: true, lastAccessed: 'Yesterday' }
  ];

  private activityLogs: ActivityLog[] = [
    { time: '10:42 AM', event: 'Main Gate unlocked', user: 'You' },
    { time: '09:15 AM', event: 'Guest Entry Denied', user: 'System' },
    { time: '08:30 AM', event: 'Garage Door opened', user: 'Alice' }
  ];

  build() {
    Stack() {
      Scroll() {
        Column() {
          HeaderSection()
            .margin({ top: 24 })

          MasterStatusCard({ isLocked: $masterLockState })
            .margin({ top: 40 })

          Text('My Access Points')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .width('100%')
            .margin({ top: 32 })

          Column({ space: 12 }) {
            ForEach(this.accessPoints, (item: AccessPoint) => {
              AccessPointRow({ item: item })
            }, (item: AccessPoint) => item.id)
          }
          .margin({ top: 16 })

          Text('Recent Activity')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .width('100%')
            .margin({ top: 32 })

          Column({ space: 0 }) {
            ForEach(this.activityLogs, (log: ActivityLog, index: number) => {
              ActivityLogItem({ time: log.time, event: log.event, user: log.user })
            }, (log: ActivityLog, index: number) => index.toString())
          }
          .margin({ top: 16 })
        }
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 24 })
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

interface AccessPoint {
  id: string;
  name: string;
  status: string;
  isLocked: boolean;
  lastAccessed: string;
}

interface ActivityLog {
  time: string;
  event: string;
  user: string;
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column({ space: 2 }) {
        Text('Welcome back,')
          .fontSize(14)
          .fontColor('#8E8E93')

        Text('David Miller')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack() {
        Circle({ width: 48, height: 48 })
          .fill('#F5F5F5')

        Circle({ width: 47, height: 47 })
          .fill(Color.Transparent)
          .stroke('#E0E0E0')

        Text('person')
          .fontSize(20)
          .fontColor('#000000')
          .fontFamily('Material Icons')
      }
      .width(48)
      .height(48)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct MasterStatusCard {
  @Link isLocked: boolean;

  build() {
    Column({ space: 0 }) {
      Button() {
        Stack() {
          Circle({ width: 80, height: 80 })
            .fill('#FFFFFF')
            .stroke({ width: 2, color: this.isLocked ? 'rgba(33, 33, 33, 0.1)' : 'rgba(76, 175, 80, 0.1)' })

          Text(this.isLocked ? 'lock' : 'check_circle')
            .fontSize(36)
            .fontColor(this.isLocked ? '#212121' : '#4CAF50')
            .fontFamily('Material Icons')
        }
        .width(80)
        .height(80)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
      .onClick(() => {
        this.isLocked = !this.isLocked;
      })
      .margin({ bottom: 16 })

      Text(this.isLocked ? 'SECURE' : 'UNLOCKED')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.isLocked ? '#212121' : '#4CAF50')
        .letterSpacing(2)

      Text(this.isLocked ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
        .fontSize(14)
        .fontColor('#8E8E93')
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(24)
    .backgroundColor('#F7F7F7')
    .borderRadius(24)
    .border({ width: 1, color: '#EFEFEF' })
  }
}

@Component
struct AccessPointRow {
  @Prop item: AccessPoint = { id: '', name: '', status: '', isLocked: true, lastAccessed: '' };
  @State checked: boolean = false;

  aboutToAppear() {
    this.checked = !this.item.isLocked;
  }

  build() {
    Row() {
      Row({ space: 16 }) {
        Stack() {
          Row() {
          }
          .width(40)
          .height(40)
          .backgroundColor('#FAFAFA')
          .borderRadius(10)

          Text('home')
            .fontSize(20)
            .fontColor('#000000')
            .fontFamily('Material Icons')
        }
        .width(40)
        .height(40)

        Column({ space: 2 }) {
          Text(this.item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')

          Text(this.item.lastAccessed)
            .fontSize(11)
            .fontColor('#CCCCCC')
        }
        .alignItems(HorizontalAlign.Start)
      }

      Blank()

      Toggle({ isOn: this.checked, type: ToggleType.Switch })
        .onChange((value: boolean) => {
          this.checked = value;
        })
        .selectedColor('#000000')
        .switchPointColor(Color.White)
        .width(51)
        .height(31)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
  }
}

@Component
struct ActivityLogItem {
  @State time: string = '';
  @State event: string = '';
  @State user: string = '';

  build() {
    Row({ space: 0 }) {
      Text(this.time)
        .fontSize(12)
        .fontColor('#8E8E93')
        .width(70)
        .textAlign(TextAlign.Start)

      Rect()
        .fill('#EEEEEE')
        .width(1)
        .height(20)
        .margin({ right: 16 })

      Column({ space: 2 }) {
        Text(this.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')

        Text('by ' + this.user)
          .fontSize(11)
          .fontColor('#8E8E93')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .alignItems(VerticalAlign.Center)
  }
}
