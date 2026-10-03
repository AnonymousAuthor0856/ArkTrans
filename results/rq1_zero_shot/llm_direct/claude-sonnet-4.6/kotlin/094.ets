import { router } from '@kit.ArkUI';

// --- Domain Models ---
interface AccessPoint {
  id: string;
  name: string;
  status: string;
  isLocked: boolean;
  lastAccessed: string;
}

// --- Header Section ---
@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('Welcome back,')
          .fontSize(14)
          .fontColor('#FF9E9E9E')
          .fontWeight(FontWeight.Normal)

        Text('David Miller')
          .fontSize(22)
          .fontWeight(FontWeight.ExtraBold)
          .fontColor('#FF000000')
      }
      .alignItems(HorizontalAlign.Start)

      Box() {
        Image($r('app.media.ic_person'))
          .width(24)
          .height(24)
          .fillColor('#FF000000')
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#FFF5F5F5')
      .border({ width: 1, color: '#FFE0E0E0', radius: 24 })
      .justifyContent(FlexAlign.Center)
      .alignItems(ItemAlign.Center)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

// --- Master Status Card ---
@Component
struct MasterStatusCard {
  @Prop isLocked: boolean;
  onToggle: () => void = () => {};

  build() {
    Column() {
      Box() {
        Image(this.isLocked ? $r('app.media.ic_lock') : $r('app.media.ic_check_circle'))
          .width(36)
          .height(36)
          .fillColor(this.isLocked ? '#FF212121' : '#FF4CAF50')
      }
      .width(80)
      .height(80)
      .borderRadius(40)
      .backgroundColor('#FFFFFFFF')
      .border({
        width: 2,
        color: this.isLocked ? '#1A212121' : '#1A4CAF50',
        radius: 40
      })
      .justifyContent(FlexAlign.Center)
      .alignItems(ItemAlign.Center)
      .onClick(() => {
        this.onToggle();
      })

      Blank().height(16)

      Text(this.isLocked ? 'SECURE' : 'UNLOCKED')
        .fontSize(20)
        .fontWeight(FontWeight.Bolder)
        .letterSpacing(2)
        .fontColor(this.isLocked ? '#FF212121' : '#FF4CAF50')

      Blank().height(8)

      Text(this.isLocked ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
        .fontSize(14)
        .fontColor('#FF9E9E9E')
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#FFF8F8F8')
    .borderRadius(24)
    .border({ width: 1, color: '#FFEFEFEF', radius: 24 })
  }
}

// --- Access Point Row ---
@Component
struct AccessPointRow {
  @Prop item: AccessPoint;
  @State checked: boolean = false;

  aboutToAppear() {
    this.checked = !this.item.isLocked;
  }

  build() {
    Row() {
      Row() {
        Box() {
          Image($r('app.media.ic_home'))
            .width(20)
            .height(20)
            .fillColor('#FF000000')
        }
        .width(40)
        .height(40)
        .borderRadius(10)
        .backgroundColor('#FFFAFAFA')
        .justifyContent(FlexAlign.Center)
        .alignItems(ItemAlign.Center)

        Blank().width(16)

        Column() {
          Text(this.item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF000000')

          Text(this.item.lastAccessed)
            .fontSize(11)
            .fontColor('#FFBDBDBD')
        }
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(VerticalAlign.Center)

      Toggle({ type: ToggleType.Switch, isOn: this.checked })
        .selectedColor('#FF000000')
        .switchPointColor('#FFFFFFFF')
        .onChange((isOn: boolean) => {
          this.checked = isOn;
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFFFF')
    .border({ width: 1, color: '#FFEEEEEE', radius: 16 })
    .borderRadius(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

// --- Access Point List ---
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
      }, (point: AccessPoint) => point.id)
    }
    .width('100%')
  }
}

// --- Activity Log Item ---
@Component
struct ActivityLogItem {
  @Prop time: string;
  @Prop event: string;
  @Prop user: string;

  build() {
    Row() {
      Text(this.time)
        .fontSize(12)
        .fontColor('#FF9E9E9E')
        .width(70)

      Divider()
        .vertical(true)
        .height(20)
        .strokeWidth(1)
        .color('#FFEEEEEE')

      Blank().width(16)

      Column() {
        Text(this.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF000000')

        Text(`by ${this.user}`)
          .fontSize(11)
          .fontColor('#FF9E9E9E')
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
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
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF424242')
          .alignSelf(ItemAlign.Start)

        Blank().height(16)

        AccessPointList()

        Blank().height(32)

        Text('Recent Activity')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF424242')
          .alignSelf(ItemAlign.Start)

        Blank().height(16)

        ActivityLogItem({ time: '10:42 AM', event: 'Main Gate unlocked', user: 'You' })
        ActivityLogItem({ time: '09:15 AM', event: 'Guest Entry Denied', user: 'System' })
        ActivityLogItem({ time: '08:30 AM', event: 'Garage Door opened', user: 'Alice' })

        Blank().height(24)
      }
      .width('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFFFF')
    .scrollBar(BarState.Off)
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
    .backgroundColor('#FFFFFFFF')
  }
}