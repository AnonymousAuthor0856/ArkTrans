interface AccessPoint {
  id: string;
  name: string;
  status: string;
  isLocked: boolean;
  lastAccessed: string;
}

@Entry
@Component
struct SecureKeyScreen {
  @State masterLockState: boolean = true;
  @State accessPointStates: boolean[] = [false, true, false];

  private accessPoints: AccessPoint[] = [
    { id: '1', name: 'Main Entrance', status: 'Active', isLocked: true, lastAccessed: '2h ago' },
    { id: '2', name: 'Garage Door', status: 'Active', isLocked: false, lastAccessed: '12m ago' },
    { id: '3', name: 'Server Room', status: 'Restricted', isLocked: true, lastAccessed: 'Yesterday' }
  ];

  build() {
    Scroll() {
      Column() {
        // Header
        this.HeaderSection()

        Blank().height(40)

        // Master Status Card
        this.MasterStatusCard()

        Blank().height(32)

        // Access Points Header
        Text('My Access Points')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .alignSelf(ItemAlign.Start)

        Blank().height(16)

        // Access Points List
        Column({ space: 12 }) {
          ForEach(this.accessPoints, (point: AccessPoint, index: number) => {
            this.AccessPointRow(point, index)
          })
        }
        .width('100%')

        Blank().height(32)

        // Recent Activity Header
        Text('Recent Activity')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .alignSelf(ItemAlign.Start)

        Blank().height(16)

        // Activity Log
        Column() {
          this.ActivityLogItem('10:42 AM', 'Main Gate unlocked', 'You')
          this.ActivityLogItem('09:15 AM', 'Guest Entry Denied', 'System')
          this.ActivityLogItem('08:30 AM', 'Garage Door opened', 'Alice')
        }
        .width('100%')

        Blank().height(24)
      }
      .padding({ left: 24, right: 24 })
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .scrollBar(BarState.Off)
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
          .fontColor('#888888')
          .alignSelf(ItemAlign.Start)
        Text('David Miller')
          .fontSize(24)
          .fontWeight(FontWeight.Bolder)
          .fontColor(Color.Black)
          .alignSelf(ItemAlign.Start)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack() {
        Circle()
          .fill('#F5F5F5')
          .width(48)
          .height(48)
          .border({ width: 1, color: '#E0E0E0', radius: 24 })

        Text('👤')
          .fontSize(20)
      }
      .width(48)
      .height(48)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .margin({ top: 24 })
  }

  @Builder
  MasterStatusCard() {
    Column() {
      Stack() {
        Circle()
          .fill(Color.White)
          .width(80)
          .height(80)
          .border({
            width: 2,
            color: this.masterLockState ? 'rgba(33,33,33,0.1)' : 'rgba(76,175,80,0.1)',
            radius: 40
          })

        Text(this.masterLockState ? '🔒' : '✅')
          .fontSize(36)
      }
      .width(80)
      .height(80)
      .onClick(() => {
        this.masterLockState = !this.masterLockState;
      })
      .margin({ bottom: 16 })

      Text(this.masterLockState ? 'SECURE' : 'UNLOCKED')
        .fontSize(22)
        .fontWeight(FontWeight.Bolder)
        .letterSpacing(2)
        .fontColor(this.masterLockState ? '#212121' : '#4CAF50')

      Blank().height(8)

      Text(this.masterLockState ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
        .fontSize(14)
        .fontColor('#888888')
    }
    .padding(24)
    .width('100%')
    .backgroundColor('#F8F8F8')
    .borderRadius(24)
    .border({ width: 1, color: '#EFEFEF', radius: 24 })
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  AccessPointRow(item: AccessPoint, index: number) {
    Row() {
      Row({ space: 16 }) {
        Stack() {
          Column()
            .width(40)
            .height(40)
            .backgroundColor('#FAFAFA')
            .borderRadius(10)

          Text('🏠')
            .fontSize(20)
            .fontColor(Color.Black)
        }
        .width(40)
        .height(40)

        Column() {
          Text(item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
            .alignSelf(ItemAlign.Start)
          Text(item.lastAccessed)
            .fontSize(11)
            .fontColor('#CCCCCC')
            .alignSelf(ItemAlign.Start)
        }
        .alignItems(HorizontalAlign.Start)
      }

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: this.accessPointStates[index] })
        .selectedColor(Color.Black)
        .switchPointColor(Color.White)
        .onChange((isOn: boolean) => {
          this.accessPointStates[index] = isOn;
        })
    }
    .padding(16)
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE', radius: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  ActivityLogItem(time: string, event: string, user: string) {
    Row() {
      Text(time)
        .fontSize(12)
        .fontColor('#888888')
        .width(70)
        .textAlign(TextAlign.Start)

      Divider()
        .vertical(true)
        .height(20)
        .color('#EEEEEE')
        .strokeWidth(1)
        .margin({ right: 16 })

      Column() {
        Text(event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
          .alignSelf(ItemAlign.Start)
        Text(`by ${user}`)
          .fontSize(11)
          .fontColor('#888888')
          .alignSelf(ItemAlign.Start)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
    }
    .padding({ top: 12, bottom: 12 })
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}