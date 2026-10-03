import window from '@ohos.window';

class AccessPoint {
  id: string;
  name: string;
  status: string;
  isLocked: boolean;
  lastAccessed: string;

  constructor(id: string, name: string, status: string, isLocked: boolean, lastAccessed: string) {
    this.id = id;
    this.name = name;
    this.status = status;
    this.isLocked = isLocked;
    this.lastAccessed = lastAccessed;
  }
}

@Entry
@Component
struct SecureKeyScreen {
  @State masterLockState: boolean = true;

  aboutToAppear(): void {
    window.getLastWindow(getContext(this)).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
    });
  }

  build() {
    Scroll() {
      Column() {
        HeaderSection()

        Blank().height(40)

        MasterStatusCard({
          isLocked: this.masterLockState,
          onToggle: () => {
            this.masterLockState = !this.masterLockState;
          }
        })

        Blank().height(32)

        Text('My Access Points')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#444444')
          .width('100%')

        Blank().height(16)

        AccessPointList()

        Blank().height(32)

        Text('Recent Activity')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#444444')
          .width('100%')

        Blank().height(16)

        ActivityLogItem({
          time: '10:42 AM',
          event: 'Main Gate unlocked',
          user: 'You'
        })

        ActivityLogItem({
          time: '09:15 AM',
          event: 'Guest Entry Denied',
          user: 'System'
        })

        ActivityLogItem({
          time: '08:30 AM',
          event: 'Garage Door opened',
          user: 'Alice'
        })
      }
      .width('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .scrollBar(BarState.Off)
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
          .fontWeight(FontWeight.Bolder)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      Stack() {
        Text('👤')
          .fontSize(24)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')
      .border({
        width: 1,
        color: '#E0E0E0'
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct MasterStatusCard {
  @Prop isLocked: boolean;
  onToggle: () => void = () => {};

  build() {
    Column() {
      Stack() {
        Text(this.isLocked ? '🔒' : '✓')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isLocked ? '#212121' : '#4CAF50')
      }
      .width(80)
      .height(80)
      .borderRadius(40)
      .backgroundColor(Color.White)
      .border({
        width: 2,
        color: this.isLocked ? '#1A212121' : '#1A4CAF50'
      })
      .onClick(() => {
        this.onToggle();
      })

      Blank().height(16)

      Text(this.isLocked ? 'SECURE' : 'UNLOCKED')
        .fontSize(22)
        .fontWeight(FontWeight.Bolder)
        .fontColor(this.isLocked ? '#212121' : '#4CAF50')
        .letterSpacing(2)

      Blank().height(8)

      Text(this.isLocked ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
        .fontSize(14)
        .fontColor(Color.Gray)
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F8F8F8')
    .borderRadius(24)
    .border({
      width: 1,
      color: '#EFEFEF'
    })
  }
}

@Component
struct AccessPointList {
  private accessPoints: AccessPoint[] = [
    new AccessPoint('1', 'Main Entrance', 'Active', true, '2h ago'),
    new AccessPoint('2', 'Garage Door', 'Active', false, '12m ago'),
    new AccessPoint('3', 'Server Room', 'Restricted', true, 'Yesterday')
  ];

  build() {
    Column() {
      ForEach(this.accessPoints, (point: AccessPoint) => {
        AccessPointRow({ item: point })
      }, (point: AccessPoint) => point.id)
    }
    .width('100%')
    .gap(12)
  }
}

@Component
struct AccessPointRow {
  @Prop item: AccessPoint;
  @State checked: boolean = false;

  aboutToAppear(): void {
    this.checked = !this.item.isLocked;
  }

  build() {
    Row() {
      Row() {
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

        Blank().width(16)

        Column() {
          Text(this.item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)

          Text(this.item.lastAccessed)
            .fontSize(11)
            .fontColor('#D3D3D3')
        }
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(VerticalAlign.Center)

      Toggle({
        type: ToggleType.Switch,
        isOn: this.checked
      })
        .selectedColor(Color.Black)
        .switchPointColor(Color.White)
        .onChange((isOn: boolean) => {
          this.checked = isOn;
        })
    }
    .width('100%')
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({
      width: 1,
      color: '#EEEEEE'
    })
  }
}

@Component
struct ActivityLogItem {
  @Prop time: string;
  @Prop event: string;
  @Prop user: string;

  build() {
    Row() {
      Text(this.time)
        .fontSize(12)
        .fontColor(Color.Gray)
        .width(70)

      Divider()
        .vertical(true)
        .height(20)
        .strokeWidth(1)
        .color('#EEEEEE')

      Blank().width(16)

      Column() {
        Text(this.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)

        Text(`by ${this.user}`)
          .fontSize(11)
          .fontColor(Color.Gray)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding({
      top: 12,
      bottom: 12
    })
    .alignItems(VerticalAlign.Center)
  }
}