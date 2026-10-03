import { BusinessError } from '@kit.BasicServicesKit';
import { common, UIAbility } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct SecureKeyApp {
  @State masterLockState: boolean = true;

  build() {
    Column() {
      Stack() {
        Color.White
          .width('100%')
          .height('100%')

        ScrollView({ indicator: IndicatorStyle.None }) {
          Column({ space: 0 }) {
            HeaderSection()
              .padding({ top: 24 })

            Blank().height(40)

            MasterStatusCard({ controller: { isLocked: this.masterLockState, onToggle: () => {
              this.masterLockState = !this.masterLockState;
            }}})

            Blank().height(32)

            Text("My Access Points")
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color('#333333'))

            Blank().height(16)

            Column({ space: 12 }) {
              ForEach(this.accessPoints, (point: AccessPoint) => {
                AccessPointRow({ controller: { item: point } })
              })
            }

            Blank().height(32)

            Text("Recent Activity")
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color('#333333'))

            Blank().height(16)

            Column({ space: 0 }) {
              ActivityLogItem({ controller: { time: "10:42 AM", event: "Main Gate unlocked", user: "You" }})
              ActivityLogItem({ controller: { time: "09:15 AM", event: "Guest Entry Denied", user: "System" }})
              ActivityLogItem({ controller: { time: "08:30 AM", event: "Garage Door opened", user: "Alice" }})
            }

            Blank().height(24)
          }
          .padding({ left: 24, right: 24 })
        }
      }
      .width('100%')
      .height('100%')
    }
    .backgroundColor(Color.White)
    .systemBarProperties({ statusBarContentColor: '#FFFFFF' })
  }

  private get accessPoints(): AccessPoint[] {
    return [
      { id: "1", name: "Main Entrance", status: "Active", isLocked: true, lastAccessed: "2h ago" },
      { id: "2", name: "Garage Door", status: "Active", isLocked: false, lastAccessed: "12m ago" },
      { id: "3", name: "Server Room", status: "Restricted", isLocked: true, lastAccessed: "Yesterday" }
    ];
  }
}

interface AccessPoint {
  id: string;
  name: string;
  status: string;
  isLocked: boolean;
  lastAccessed: string;
}

// MARK: - Components

@Component
struct HeaderSection {
  build() {
    Row() {
      Column({ space: 2 }) {
        Text("Welcome back,")
          .fontSize(14)
          .fontColor(Color.Gray)
        
        Text("David Miller")
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      
      Blank()
      
      Stack() {
        Circle()
          .fill(Color('#F5F5F5'))
          .width(48)
          .height(48)
          .border({ width: 1, color: Color('#E0E0E0') })
        
        Image($r('app.media.ic_person')) // Placeholder for system icon
          .width(20)
          .height(20)
          .objectFit(ImageFit.Contain)
          .fillColor(Color.Black)
      }
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct MasterStatusCard {
  @Prop controller: {
    isLocked: boolean;
    onToggle: () => void;
  }

  aboutToAppear() {
  }

  build() {
    Column({ space: 0 }) {
      Button({ type: ButtonType.Circle }) {
        Stack() {
          Circle()
            .fill(Color.White)
            .width(80)
            .height(80)
            .border({ width: 2, color: this.getStatusColor().withOpacity(0.1) })
          
          Image(this.controller.isLocked ? $r('app.media.ic_lock') : $r('app.media.ic_check'))
            .width(36)
            .height(36)
            .objectFit(ImageFit.Contain)
            .fillColor(this.getStatusColor())
        }
      }
      .onClick(() => {
        this.controller.onToggle();
      })
      .margin({ bottom: 16 })
      
      Text(this.controller.isLocked ? "SECURE" : "UNLOCKED")
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .letterSpacing(2)
        .fontColor(this.getStatusColor())
      
      Blank().height(8)
      
      Text(this.controller.isLocked ? "All perimeter doors are locked." : "Perimeter access is currently open.")
        .fontSize(14)
        .fontColor(Color.Gray)
    }
    .padding(24)
    .width('100%')
    .backgroundColor(Color('#F8F8F8'))
    .borderRadius(24)
    .border({ width: 1, color: Color('#EFEFEF'), radius: 24 })
  }

  private getStatusColor(): Color {
    return this.controller.isLocked ? Color('#212121') : Color('#4CAF50');
  }
}

@Component
struct AccessPointRow {
  @Prop controller: {
    item: AccessPoint;
  }
  @State checked: boolean = false;

  aboutToAppear() {
    this.checked = !this.controller.item.isLocked;
  }

  build() {
    Row() {
      Row({ space: 16 }) {
        Stack() {
          RoundedRectangle()
            .width(40)
            .height(40)
            .fill(Color('#FAFAFA'))
            .borderRadius(10)
          
          Image($r('app.media.ic_house'))
            .width(20)
            .height(20)
            .objectFit(ImageFit.Contain)
            .fillColor(Color.Black)
        }
        
        Column({ space: 2 }) {
          Text(this.controller.item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
          
          Text(this.controller.item.lastAccessed)
            .fontSize(11)
            .fontColor(Color('#CCCCCC'))
        }
      }
      
      Blank()
      
      Toggle({ type: ToggleType.Switch, isOn: this.checked })
        .onChange((isOn: boolean) => {
          this.checked = isOn;
        })
        .width(44)
        .height(24)
        .selectedColor(Color.Black)
    }
    .padding(16)
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: Color('#EEEEEE'), radius: 16 })
  }
}

@Component
struct ActivityLogItem {
  @Prop controller: {
    time: string;
    event: string;
    user: string;
  }

  build() {
    Row() {
      Text(this.controller.time)
        .fontSize(12)
        .fontColor(Color.Gray)
        .width(70)
        .textAlign(TextAlign.Start)
      
      Divider()
        .vertical(true)
        .color(Color('#EEEEEE'))
        .height(20)
        .margin({ left: 16, right: 16 })
      
      Column({ space: 2 }) {
        Text(this.controller.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
        
        Text(`by ${this.controller.user}`)
          .fontSize(11)
          .fontColor(Color.Gray)
      }
      
      Blank()
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .alignItems(VerticalAlign.Center)
  }
}