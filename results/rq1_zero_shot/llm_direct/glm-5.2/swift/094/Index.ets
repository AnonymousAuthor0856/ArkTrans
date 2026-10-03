import { Stack, Text, Image, Button, ForEach, Toggle, Column, Row, Scroll, Color, ContentSlot, Length, App, Component } from '@arkui/core';

// MARK: - Models
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

// MARK: - Colors
class SecureColors {
  static readonly primary: Color = Color.BLACK;
  static readonly surface: Color = Color.rgb(0.97, 0.97, 0.97);
  static readonly locked: Color = Color.rgb(0.13, 0.13, 0.13);
  static readonly unlocked: Color = Color.rgb(0.30, 0.69, 0.31);
  static readonly border: Color = Color.rgb(0.94, 0.94, 0.94);
  static readonly textGray: Color = Color.GRAY;
  static readonly backgroundWhite: Color = Color.WHITE;
}

// MARK: - Main Screen
@Component
export struct SecureKeyScreen {
  @State masterLockState: boolean = true;

  private accessPoints: AccessPoint[] = [
    new AccessPoint("1", "Main Entrance", "Active", true, "2h ago"),
    new AccessPoint("2", "Garage Door", "Active", false, "12m ago"),
    new AccessPoint("3", "Server Room", "Restricted", true, "Yesterday")
  ];

  build(): void {
    Stack({ alignment: Alignment.TopStart }) {
      // Background
      Stack().backgroundColor(SecureColors.backgroundWhite).width('100%').height('100%');

      // Scrollable Content
      Scroll({ showScrollBar: false }) {
        Column({ space: 0 }) {
          // Header
          HeaderSection();

          // Spacer
          Stack().height(40);

          // Master Status Card
          MasterStatusCard({ isLocked: this.masterLockState, onToggle: () => { this.masterLockState = !this.masterLockState; } });

          // Spacer
          Stack().height(32);

          // Access Points Header
          Text("My Access Points")
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.rgb(0.2, 0.2, 0.2));

          // Spacer
          Stack().height(16);

          // Access Points List
          Column({ space: 12 }) {
            ForEach(this.accessPoints, (point: AccessPoint) => {
              AccessPointRow({ item: point });
            }, (point: AccessPoint) => point.id);
          }

          // Spacer
          Stack().height(32);

          // Recent Activity Header
          Text("Recent Activity")
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.rgb(0.2, 0.2, 0.2));

          // Spacer
          Stack().height(16);

          // Activity Log
          Column({ space: 0 }) {
            ActivityLogItem({ time: "10:42 AM", event: "Main Gate unlocked", user: "You" });
            ActivityLogItem({ time: "09:15 AM", event: "Guest Entry Denied", user: "System" });
            ActivityLogItem({ time: "08:30 AM", event: "Garage Door opened", user: "Alice" });
          }

          // Spacer
          Stack().height(24);
        }
        .padding({ left: 24, right: 24 });
      }
      .width('100%')
      .height('100%');
    }
    .width('100%')
    .height('100%');
  }
}

// MARK: - Components

@Component
export struct HeaderSection {
  build(): void {
    Row({ space: 0 }) {
      Column({ space: 2 }) {
        Text("Welcome back,")
          .fontSize(14)
          .fontColor(SecureColors.textGray);

        Text("David Miller")
          .fontSize(24)
          .fontWeight(FontWeight.Black)
          .fontColor(Color.BLACK);
      }
      .alignItems(HorizontalAlign.Start);

      // Spacer
      Stack().width('100%').layoutWeight(1);

      Stack() {
        Stack()
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor(Color.rgb(0.96, 0.96, 0.96))
          .border({ width: 1, color: Color.rgb(0.88, 0.88, 0.88) });

        Image($r('app.media.icon')) // Placeholder for person.fill
          .width(20)
          .height(20)
          .fillColor(Color.BLACK);
      }
      .width(48)
      .height(48);
    }
    .width('100%')
    .alignItems(VerticalAlign.Center);
  }
}

@Component
export struct MasterStatusCard {
  @Prop isLocked: boolean;
  onToggle: () => void;

  private get statusColor(): Color {
    return this.isLocked ? SecureColors.locked : SecureColors.unlocked;
  }

  build(): void {
    Column({ space: 0 }) {
      // Icon Button
      Button({ type: ButtonType.Normal, onClick: this.onToggle }) {
        Stack() {
          Stack()
            .width(80)
            .height(80)
            .borderRadius(40)
            .backgroundColor(Color.WHITE)
            .border({ width: 2, color: this.statusColor.withAlpha(0.1) });

          Image(this.isLocked ? $r('app.media.icon') : $r('app.media.icon')) // Placeholder for lock.fill / checkmark.circle.fill
            .width(36)
            .height(36)
            .fillColor(this.statusColor);
        }
        .width(80)
        .height(80);
      }
      .margin({ bottom: 16 })
      .backgroundColor(Color.TRANSPARENT);

      // Status Text
      Text(this.isLocked ? "SECURE" : "UNLOCKED")
        .fontSize(22)
        .fontWeight(FontWeight.Black)
        .letterSpacing(2)
        .fontColor(this.statusColor);

      // Spacer
      Stack().height(8);

      // Subtext
      Text(this.isLocked ? "All perimeter doors are locked." : "Perimeter access is currently open.")
        .fontSize(14)
        .fontColor(SecureColors.textGray);
    }
    .padding(24)
    .width('100%')
    .backgroundColor(SecureColors.surface)
    .borderRadius(24)
    .border({ width: 1, color: SecureColors.border });
  }
}

@Component
export struct AccessPointRow {
  item: AccessPoint;
  @State checked: boolean = false;

  aboutToAppear(): void {
    this.checked = !this.item.isLocked;
  }

  build(): void {
    Row({ space: 0 }) {
      Row({ space: 16 }) {
        Stack() {
          Stack()
            .width(40)
            .height(40)
            .borderRadius(10)
            .backgroundColor(Color.rgb(0.98, 0.98, 0.98));

          Image($r('app.media.icon')) // Placeholder for house.fill
            .width(20)
            .height(20)
            .fillColor(Color.BLACK);
        }
        .width(40)
        .height(40);

        Column({ space: 2 }) {
          Text(this.item.name)
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(Color.BLACK);

          Text(this.item.lastAccessed)
            .fontSize(11)
            .fontColor(Color.rgb(0.8, 0.8, 0.8));
        }
        .alignItems(HorizontalAlign.Start);
      }

      // Spacer
      Stack().width('100%').layoutWeight(1);

      Toggle({ type: ToggleType.Switch, isOn: $checked })
        .selectedColor(Color.BLACK);
    }
    .padding(16)
    .backgroundColor(Color.WHITE)
    .borderRadius(16)
    .border({ width: 1, color: Color.rgb(0.93, 0.93, 0.93) });
  }
}

@Component
export struct ActivityLogItem {
  time: string;
  event: string;
  user: string;

  build(): void {
    Row({ space: 0 }) {
      Text(this.time)
        .fontSize(12)
        .fontColor(SecureColors.textGray)
        .width(70)
        .textAlign(TextAlign.Start);

      Stack()
        .width(1)
        .height(20)
        .backgroundColor(Color.rgb(0.93, 0.93, 0.93))
        .margin({ right: 16 });

      Column({ space: 2 }) {
        Text(this.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.BLACK);

        Text(`by ${this.user}`)
          .fontSize(11)
          .fontColor(SecureColors.textGray);
      }
      .alignItems(HorizontalAlign.Start);

      // Spacer
      Stack().width('100%').layoutWeight(1);
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .alignItems(VerticalAlign.Center);
  }
}