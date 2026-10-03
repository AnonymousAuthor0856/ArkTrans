// SecureKeyApp.ets
import { router } from '@kit.ArkUI';

@Entry
@Component
struct SecureKeyApp {
  build() {
    Column() {
      SecureKeyScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

// Models
interface AccessPoint {
  id: string;
  name: string;
  status: string;
  isLocked: boolean;
  lastAccessed: string;
}

// Colors
const SecureColors = {
  primary: '#000000',
  surface: '#F8F8F8',
  locked: '#212121',
  unlocked: '#4CAF50',
  border: '#EFEFEF',
  textGray: '#808080',
  backgroundWhite: '#FFFFFF',
  lightGray: '#F5F5F5',
  borderLight: '#E0E0E0',
  borderMedium: '#EEEEEE',
  iconBg: '#FAFAFA',
  textLightGray: '#CCCCCC',
  textDarkGray: '#333333'
};

// Main Screen Component
@Component
struct SecureKeyScreen {
  @State masterLockState: boolean = true;
  
  private accessPoints: AccessPoint[] = [
    { id: '1', name: 'Main Entrance', status: 'Active', isLocked: true, lastAccessed: '2h ago' },
    { id: '2', name: 'Garage Door', status: 'Active', isLocked: false, lastAccessed: '12m ago' },
    { id: '3', name: 'Server Room', status: 'Restricted', isLocked: true, lastAccessed: 'Yesterday' }
  ];

  build() {
    Scroll() {
      Column({ space: 0 }) {
        // Header
        HeaderSection()
          .margin({ top: 24 })

        Blank()
          .height(40)

        // Master Status Card
        MasterStatusCard({ 
          isLocked: this.masterLockState,
          onToggle: () => {
            this.masterLockState = !this.masterLockState;
          }
        })

        Blank()
          .height(32)

        // Access Points Header
        Text('My Access Points')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(SecureColors.textDarkGray)
          .align(Alignment.Start)

        Blank()
          .height(16)

        // Access Points List
        Column({ space: 12 }) {
          ForEach(this.accessPoints, (point: AccessPoint) => {
            AccessPointRow({ item: point })
          }, (point: AccessPoint) => point.id)
        }

        Blank()
          .height(32)

        // Recent Activity Header
        Text('Recent Activity')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(SecureColors.textDarkGray)
          .align(Alignment.Start)

        Blank()
          .height(16)

        // Activity Log
        Column({ space: 0 }) {
          ActivityLogItem({ time: '10:42 AM', event: 'Main Gate unlocked', user: 'You' })
          ActivityLogItem({ time: '09:15 AM', event: 'Guest Entry Denied', user: 'System' })
          ActivityLogItem({ time: '08:30 AM', event: 'Garage Door opened', user: 'Alice' })
        }

        Blank()
          .height(24)
      }
      .padding({ left: 24, right: 24 })
      .align(Alignment.Start)
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
    .backgroundColor(SecureColors.backgroundWhite)
  }
}

// Header Section Component
@Component
struct HeaderSection {
  build() {
    Row() {
      Column({ space: 2 }) {
        Text('Welcome back,')
          .fontSize(14)
          .fontColor(SecureColors.textGray)
          .align(Alignment.Start)
        
        Text('David Miller')
          .fontSize(24)
          .fontWeight(FontWeight.Black)
          .fontColor(SecureColors.primary)
          .align(Alignment.Start)
      }
      .align(Alignment.Start)

      Blank()

      Stack() {
        Circle()
          .fill(SecureColors.lightGray)
          .width(48)
          .height(48)
          .stroke(SecureColors.borderLight, 1)

        Text('👤')
          .fontSize(20)
      }
      .width(48)
      .height(48)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

// Master Status Card Component
@Component
struct MasterStatusCard {
  @Prop isLocked: boolean;
  onToggle: () => void = () => {};

  private getStatusColor(): string {
    return this.isLocked ? SecureColors.locked : SecureColors.unlocked;
  }

  build() {
    Column({ space: 0 }) {
      // Icon Button
      Button({ type: ButtonType.Circle, stateEffect: true }) {
        Stack() {
          Circle()
            .fill('#FFFFFF')
            .width(80)
            .height(80)
            .stroke(this.getStatusColor() + '1A', 2)

          Text(this.isLocked ? '🔒' : '✅')
            .fontSize(36)
        }
        .width(80)
        .height(80)
      }
      .backgroundColor(Color.Transparent)
      .onClick(() => {
        this.onToggle();
      })
      .margin({ bottom: 16 })

      // Status Text
      Text(this.isLocked ? 'SECURE' : 'UNLOCKED')
        .fontSize(22)
        .fontWeight(FontWeight.Black)
        .fontColor(this.getStatusColor())
        .letterSpacing(2)

      Blank()
        .height(8)

      // Subtext
      Text(this.isLocked ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
        .fontSize(14)
        .fontColor(SecureColors.textGray)
    }
    .padding(24)
    .width('100%')
    .backgroundColor(SecureColors.surface)
    .borderRadius(24)
    .border({
      width: 1,
      color: SecureColors.border,
      radius: 24
    })
  }
}

// Access Point Row Component
@Component
struct AccessPointRow {
  @Prop item: AccessPoint;
  @State checked: boolean = false;

  aboutToAppear() {
    this.checked = !this.item.isLocked;
  }

  build() {
    Row() {
      Row({ space: 16 }) {
        Stack() {
          Rect()
            .fill(SecureColors.iconBg)
            .width(40)
            .height(40)
            .borderRadius(10)

          Text('🏠')
            .fontSize(20)
        }
        .width(40)
        .height(40)

        Column({ space: 2 }) {
          Text(this.item.name)
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(SecureColors.primary)
            .align(Alignment.Start)

          Text(this.item.lastAccessed)
            .fontSize(11)
            .fontColor(SecureColors.textLightGray)
            .align(Alignment.Start)
        }
        .align(Alignment.Start)
      }

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: this.checked })
        .selectedColor(SecureColors.primary)
        .onChange((isOn: boolean) => {
          this.checked = isOn;
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .border({
      width: 1,
      color: SecureColors.borderMedium,
      radius: 16
    })
    .alignItems(VerticalAlign.Center)
  }
}

// Activity Log Item Component
@Component
struct ActivityLogItem {
  @Prop time: string;
  @Prop event: string;
  @Prop user: string;

  build() {
    Row({ space: 0 }) {
      Text(this.time)
        .fontSize(12)
        .fontColor(SecureColors.textGray)
        .width(70)
        .align(Alignment.Start)

      Rect()
        .fill(SecureColors.borderMedium)
        .width(1)
        .height(20)
        .margin({ right: 16 })

      Column({ space: 2 }) {
        Text(this.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(SecureColors.primary)
          .align(Alignment.Start)

        Text(`by ${this.user}`)
          .fontSize(11)
          .fontColor(SecureColors.textGray)
          .align(Alignment.Start)
      }
      .align(Alignment.Start)

      Blank()
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .alignItems(VerticalAlign.Center)
  }
}