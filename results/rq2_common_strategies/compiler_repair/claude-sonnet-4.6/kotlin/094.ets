import { router } from '@kit.ArkUI';

// --- Domain Models ---
interface AccessPoint {
  id: string;
  name: string;
  status: string;
  isLocked: boolean;
  lastAccessed: string;
}

// --- Activity Log Item Component ---
@Component
struct ActivityLogItem {
  time: string = '';
  event: string = '';
  user: string = '';

  build() {
    Row() {
      Text(this.time)
        .fontSize(12)
        .fontColor('#888888')
        .width(70)

      Divider()
        .vertical(true)
        .height(20)
        .width(1)
        .color('#EEEEEE')

      Blank().width(16)

      Column() {
        Text(this.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')

        Text(`by ${this.user}`)
          .fontSize(11)
          .fontColor('#888888')
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .alignItems(VerticalAlign.Center)
  }
}

// --- Access Point Row Component ---
@Component
struct AccessPointRow {
  item: AccessPoint = { id: '', name: '', status: '', isLocked: false, lastAccessed: '' };
  @State checked: boolean = false;

  aboutToAppear() {
    this.checked = !this.item.isLocked;
  }

  build() {
    Row() {
      Row() {
        Stack() {
          Text('🏠')
            .fontSize(18)
        }
        .width(40)
        .height(40)
        .borderRadius(10)
        .backgroundColor('#FAFAFA')
        .alignContent(Alignment.Center)

        Blank().width(16)

        Column() {
          Text(this.item.name)
            .fontSize(15)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')

          Text(this.item.lastAccessed)
            .fontSize(11)
            .fontColor('#CCCCCC')
        }
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(VerticalAlign.Center)

      Toggle({ type: ToggleType.Switch, isOn: this.checked })
        .onChange((isOn: boolean) => {
          this.checked = isOn;
        })
        .selectedColor('#000000')
        .switchPointColor('#FFFFFF')
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#EEEEEE', radius: 16 })
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

// --- Access Point List Component ---
@Component
struct AccessPointList {
  private accessPoints: AccessPoint[] = [
    { id: '1', name: 'Main Entrance', status: 'Active', isLocked: true, lastAccessed: '2h ago' },
    { id: '2', name: 'Garage Door', status: 'Active', isLocked: false, lastAccessed: '12m ago' },
    { id: '3', name: 'Server Room', status: 'Restricted', isLocked: true, lastAccessed: 'Yesterday' }
  ];

  build() {
    Column({ space: 12 }) {
      ForEach(this.accessPoints, (point: AccessPoint) => {
        AccessPointRow({ item: point })
      })
    }
    .width('100%')
  }
}

// --- Master Status Card Component ---
@Component
struct MasterStatusCard {
  @Prop isLocked: boolean;
  onToggle: () => void = () => {};

  build() {
    Column() {
      Stack() {
        Circle()
          .width(80)
          .height(80)
          .fill('#FFFFFF')
          .stroke(this.isLocked ? 'rgba(33,33,33,0.1)' : 'rgba(76,175,80,0.1)')
          .strokeWidth(2)

        Text(this.isLocked ? '🔒' : '✅')
          .fontSize(32)
      }
      .width(80)
      .height(80)
      .alignContent(Alignment.Center)
      .onClick(() => {
        this.onToggle();
      })

      Blank().height(16)

      Text(this.isLocked ? 'SECURE' : 'UNLOCKED')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .letterSpacing(2)
        .fontColor(this.isLocked ? '#212121' : '#4CAF50')

      Blank().height(8)

      Text(this.isLocked ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
        .fontSize(14)
        .fontColor('#888888')
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .padding(24)
    .backgroundColor('#F8F8F8')
    .borderRadius(24)
    .border({ width: 1, color: '#EFEFEF', radius: 24 })
    .alignItems(HorizontalAlign.Center)
  }
}

// --- Header Section Component ---
@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('Welcome back,')
          .fontSize(14)
          .fontColor('#888888')

        Text('David Miller')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Start)

      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill('#F5F5F5')
          .stroke('#E0E0E0')
          .strokeWidth(1)

        Text('👤')
          .fontSize(22)
      }
      .width(48)
      .height(48)
      .alignContent(Alignment.Center)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

// --- Main Screen ---
@Component
struct SecureKeyScreen {
  @State masterLockState: boolean = true;

  build() {
    Scroll() {
      Column() {
        // Top Header
        HeaderSection()

        Blank().height(40)

        // Master Control Status
        MasterStatusCard({
          isLocked: this.masterLockState,
          onToggle: () => {
            this.masterLockState = !this.masterLockState;
          }
        })

        Blank().height(32)

        // Quick Access List Title
        Text('My Access Points')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#444444')
          .width('100%')
          .textAlign(TextAlign.Start)

        Blank().height(16)

        AccessPointList()

        Blank().height(32)

        // Recent Activity Title
        Text('Recent Activity')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#444444')
          .width('100%')
          .textAlign(TextAlign.Start)

        Blank().height(16)

        ActivityLogItem({ time: '10:42 AM', event: 'Main Gate unlocked', user: 'You' })
        ActivityLogItem({ time: '09:15 AM', event: 'Guest Entry Denied', user: 'System' })
        ActivityLogItem({ time: '08:30 AM', event: 'Garage Door opened', user: 'Alice' })

        Blank().height(32)
      }
      .padding(24)
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

// --- Entry Point ---
@Entry
@Component
struct Index {
  build() {
    Column() {
      SecureKeyScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}