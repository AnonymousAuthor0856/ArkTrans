@Entry
@Component
struct SecureKeyScreen {
  @State masterLockState: boolean = true;

  build() {
    Column() {
      Scroll() {
        Column() {
          HeaderSection()

          MasterStatusCard({
            isLocked: this.masterLockState,
            onToggle: () => { this.masterLockState = !this.masterLockState; }
          })
            .margin({ top: 40 })

          Text('My Access Points')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#616161')
            .margin({ top: 32, bottom: 16 })

          AccessPointList()

          Text('Recent Activity')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#616161')
            .margin({ top: 32, bottom: 16 })

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
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('Welcome back,')
          .fontSize(14)
          .fontColor(Color.Gray)

        Text('David Miller')
          .fontSize(24)
          .fontWeight(FontWeight.ExtraBold)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Stack() {
        Image($r('sys.media.ohos_ic_public_profile'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#FFF5F5F5')
      .border({ width: 1, color: '#FFE0E0E0' })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct MasterStatusCard {
  @Link isLocked: boolean;
  onToggle: () => void = () => {};

  build() {
    Column() {
      Stack() {
        Image(this.isLocked ? $r('sys.media.ohos_ic_public_lock') : $r('sys.media.ohos_ic_public_yes'))
          .width(36)
          .height(36)
          .fillColor(this.isLocked ? '#FF212121' : '#FF4CAF50')
      }
      .width(80)
      .height(80)
      .borderRadius(40)
      .backgroundColor(Color.White)
      .border({
        width: 2,
        color: this.isLocked ? 'rgba(33,33,33,0.1)' : 'rgba(76,175,80,0.1)'
      })
      .onClick(() => {
        this.onToggle();
      })

      Text(this.isLocked ? 'SECURE' : 'UNLOCKED')
        .fontSize(22)
        .fontWeight(FontWeight.Black)
        .fontColor(this.isLocked ? '#FF212121' : '#FF4CAF50')
        .margin({ top: 16 })

      Text(this.isLocked ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
        .fontSize(14)
        .fontColor(Color.Gray)
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#FFF8F8F8')
    .borderRadius(24)
    .border({ width: 1, color: '#FFEFEFEF' })
  }
}

interface AccessPoint {
  id: string;
  name: string;
  status: string;
  isLocked: boolean;
  lastAccessed: string;
}

@Component
struct AccessPointList {
  private accessPoints: AccessPoint[] = [
    { id: '1', name: 'Main Entrance', status: 'Active', isLocked: true, lastAccessed: '2h ago' },
    { id: '2', name: 'Garage Door', status: 'Active', isLocked: false, lastAccessed: '12m ago' },
    { id: '3', name: 'Server Room', status: 'Restricted', isLocked: true, lastAccessed: 'Yesterday' }
  ];

  build() {
    Column({ space: 12 }) {
      ForEach(this.accessPoints, (item: AccessPoint) => {
        AccessPointRow({ item: item })
      }, (item: AccessPoint) => item.id)
    }
    .width('100%')
  }
}

@Component
struct AccessPointRow {
  @State checked: boolean = false;
  item: AccessPoint = { id: '', name: '', status: '', isLocked: true, lastAccessed: '' };

  aboutToAppear() {
    this.checked = !this.item.isLocked;
  }

  build() {
    Row() {
      Row() {
        Stack() {
          Image($r('sys.media.ohos_ic_public_home'))
            .width(20)
            .height(20)
            .fillColor(Color.Black)
        }
        .width(40)
        .height(40)
        .borderRadius(10)
        .backgroundColor('#FFFAFAFA')

        Column() {
          Text(this.item.name)
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)

          Text(this.item.lastAccessed)
            .fontSize(11)
            .fontColor(Color.LightGray)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 16 })
      }
      .alignItems(VerticalAlign.Center)
      .layoutWeight(1)

      Toggle({ type: ToggleType.Switch, isOn: this.checked })
        .onChange((isOn: boolean) => {
          this.checked = isOn;
        })
        .selectedColor(Color.Black)
        .switchPointColor(Color.White)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: '#FFEEEEEE' })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct ActivityLogItem {
  time: string = '';
  event: string = '';
  user: string = '';

  build() {
    Row() {
      Text(this.time)
        .fontSize(12)
        .fontColor(Color.Gray)
        .width(70)

      Divider()
        .vertical(true)
        .height(20)
        .width(1)
        .color('#FFEEEEEE')

      Column() {
        Text(this.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)

        Text('by ' + this.user)
          .fontSize(11)
          .fontColor(Color.Gray)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .alignItems(VerticalAlign.Center)
  }
}
