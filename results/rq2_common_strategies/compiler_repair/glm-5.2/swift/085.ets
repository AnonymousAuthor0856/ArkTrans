// BotanyApp.ets
// Converted from SwiftUI to ArkTS

// MARK: - 1. Color Palette
class BotanyColors {
  static readonly White: string = '#FFFFFFFF';
  static readonly Surface: string = '#FFFAFAFA';
  static readonly TextPrimary: string = '#FF1A1C19';
  static readonly TextSecondary: string = '#FF757575';
  static readonly Accent: string = '#FF2E5E4E';
  static readonly AccentLight: string = '#FFE8F5E9';
  static readonly Border: string = '#FFEEEEEE';
  static readonly ChipBg: string = '#FFE0E0E0';
  static readonly IconDisabled: string = '#FFCCCCCC';
}

// MARK: - 2. Data Models
class Plant {
  id: number;
  name: string;
  scientificName: string;
  location: string;
  daysUntilWater: number;
  isHealthy: boolean;

  constructor(id: number, name: string, scientificName: string, location: string, daysUntilWater: number, isHealthy: boolean = true) {
    this.id = id;
    this.name = name;
    this.scientificName = scientificName;
    this.location = location;
    this.daysUntilWater = daysUntilWater;
    this.isHealthy = isHealthy;
  }
}

class Task {
  id: number;
  title: string;
  plantName: string;
  iconName: Resource;
  urgency: string;

  constructor(id: number, title: string, plantName: string, iconName: Resource, urgency: string) {
    this.id = id;
    this.title = title;
    this.plantName = plantName;
    this.iconName = iconName;
    this.urgency = urgency;
  }
}

// MARK: - 3. Main Content View
@Entry
@Component
struct BotanyContentView {
  private tasks: Task[] = [
    new Task(1, "Watering", "Monstera Deliciosa", $r('sys.media.ohos_ic_public_calendar'), "Today"),
    new Task(2, "Fertilize", "Fiddle Leaf Fig", $r('sys.media.ohos_ic_public_notifications'), "Tomorrow"),
    new Task(3, "Pruning", "Snake Plant", $r('sys.media.ohos_ic_public_settings'), "Next Week")
  ];

  private plants: Plant[] = [
    new Plant(1, "Monstera", "Monstera deliciosa", "Living Room", 0),
    new Plant(2, "Fiddle Leaf", "Ficus lyrata", "Bedroom", 2),
    new Plant(3, "Snakey", "Sansevieria", "Hallway", 5),
    new Plant(4, "Spider Plant", "Chlorophytum", "Kitchen", 1),
    new Plant(5, "Peace Lily", "Spathiphyllum", "Bathroom", 3)
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top Bar
        BotanyTopBar()

        // Scrollable Content
        Scroll() {
          Column() {
            // Header
            Column() {
              Text("Good Morning,")
                .fontSize(16)
                .fontColor(BotanyColors.TextSecondary)
              Text("My Jungle")
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor(BotanyColors.TextPrimary)
            }
            .alignItems(HorizontalAlign.Start)
            .padding({ left: 24, right: 24, top: 16, bottom: 16 })

            // Tasks Section
            SectionHeader({ title: "Pending Tasks" })
            
            Scroll() {
              Row({ space: 16 }) {
                ForEach(this.tasks, (task: Task) => {
                  TaskCard({ task: task })
                })
              }
              .padding({ left: 24, right: 24 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .padding({ bottom: 32 })

            // Collection Section
            SectionHeader({ title: "Your Collection" })

            ForEach(this.plants, (plant: Plant) => {
              PlantListItem({ plant: plant })
            })
          }
          .padding({ bottom: 80 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .align(Alignment.Top)
      }

      // FAB
      Row() {
        Column() {
          Button({ type: ButtonType.Circle }) {
            Image($r('sys.media.ohos_ic_public_add'))
              .width(24)
              .height(24)
              .fillColor(Color.White)
          }
          .width(56)
          .height(56)
          .backgroundColor(BotanyColors.TextPrimary)
          .margin({ right: 24, bottom: 96 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.End)
      }
      .width('100%')

      // Bottom Bar
      BotanyBottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BotanyColors.White)
  }
}

// MARK: - 5. SectionHeader
@Component
struct SectionHeader {
  private title: string = '';

  build() {
    Text(this.title)
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .fontColor(BotanyColors.TextPrimary)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
  }
}

// MARK: - 6. TaskCard
@Component
struct TaskCard {
  private task: Task = new Task(0, '', '', $r('sys.media.ohos_ic_public_calendar'), '');
  @State isChecked: boolean = false;

  build() {
    Column() {
      Row() {
        Stack() {
          Circle({ width: 40, height: 40 })
            .fill(this.isChecked ? BotanyColors.Accent : Color.White)
          Image(this.task.iconName)
            .width(20)
            .height(20)
            .fillColor(this.isChecked ? Color.White : BotanyColors.TextPrimary)
        }
      }

      Blank() // Pushes content to bottom

      Column() {
        Text(this.task.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyColors.TextPrimary)
        Text(this.task.plantName)
          .fontSize(12)
          .fontColor(BotanyColors.TextSecondary)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        
        Blank().height(8)

        Text(this.isChecked ? "DONE" : this.task.urgency)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? Color.White : BotanyColors.TextPrimary)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .backgroundColor(this.isChecked ? BotanyColors.Accent : BotanyColors.ChipBg)
          .borderRadius(4)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .width(160)
    .height(180)
    .backgroundColor(BotanyColors.Surface)
    .borderRadius(24)
    .border({ width: this.isChecked ? 2 : 1, color: this.isChecked ? BotanyColors.Accent : BotanyColors.Border })
    .onClick(() => {
      this.isChecked = !this.isChecked;
    })
    .animation({ duration: 200, curve: Curve.EaseInOut })
  }
}

// MARK: - 7. PlantListItem
@Component
struct PlantListItem {
  private plant: Plant = new Plant(0, '', '', '', 0);
  @State expanded: boolean = false;

  build() {
    Row() {
      Stack() {
        Column()
          .width(56)
          .height(56)
          .backgroundColor(BotanyColors.Border)
          .borderRadius(12)
        Image($r('sys.media.ohos_ic_public_favor'))
          .width(24)
          .height(24)
          .fillColor(this.plant.daysUntilWater == 0 ? BotanyColors.Accent : BotanyColors.IconDisabled)
      }

      Blank().width(16)

      Column() {
        Text(this.plant.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyColors.TextPrimary)
        Text(this.plant.scientificName)
          .fontSize(12)
          .fontColor(BotanyColors.TextSecondary)
          .fontStyle(FontStyle.Italic)

        if (this.expanded) {
          Blank().height(8)
          Row() {
            Image($r('sys.media.ohos_ic_public_location'))
              .width(12)
              .height(12)
              .fillColor(BotanyColors.TextSecondary)
            Blank().width(4)
            Text(this.plant.location)
              .fontSize(10)
              .fontColor(BotanyColors.TextSecondary)
          }
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column() {
        if (this.plant.daysUntilWater == 0) {
          Image($r('sys.media.ohos_ic_public_ok'))
            .width(24)
            .height(24)
            .fillColor(BotanyColors.Accent)
          Text("Water")
            .fontSize(10)
            .fontColor(BotanyColors.Accent)
            .fontWeight(FontWeight.Bold)
        } else {
          Text(`${this.plant.daysUntilWater} days`)
            .fontSize(10)
            .fontColor(BotanyColors.TextSecondary)
        }
      }
    }
    .padding(16)
    .backgroundColor(BotanyColors.Surface)
    .borderRadius(16)
    .margin({ left: 24, right: 24, top: 8, bottom: 8 })
    .onClick(() => {
      this.expanded = !this.expanded;
    })
    .animation({ duration: 200, curve: Curve.EaseInOut })
  }
}

// MARK: - 8. BotanyTopBar
@Component
struct BotanyTopBar {
  build() {
    Row() {
      Button({ type: ButtonType.Circle }) {
        Image($r('sys.media.ohos_ic_public_menu'))
          .width(20)
          .height(20)
          .fillColor(BotanyColors.TextPrimary)
      }
      .width(40)
      .height(40)
      .backgroundColor(BotanyColors.Surface)

      Blank() // Spacer

      Button({ type: ButtonType.Circle }) {
        Image($r('sys.media.ohos_ic_public_search'))
          .width(20)
          .height(20)
          .fillColor(BotanyColors.TextPrimary)
      }
      .width(40)
      .height(40)
      .backgroundColor(BotanyColors.Surface)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 8 })
    .backgroundColor(BotanyColors.White)
  }
}

// MARK: - 9. BotanyBottomBar
@Component
struct BotanyBottomBar {
  @State selectedTab: number = 0;

  build() {
    Row() {
      BotanyNavItem({ iconName: $r('sys.media.ohos_ic_public_home'), isSelected: this.selectedTab == 0 })
        .onClick(() => { this.selectedTab = 0 })
      BotanyNavItem({ iconName: $r('sys.media.ohos_ic_public_calendar'), isSelected: this.selectedTab == 1 })
        .onClick(() => { this.selectedTab = 1 })
      
      Blank().width(32)

      BotanyNavItem({ iconName: $r('sys.media.ohos_ic_public_notifications'), isSelected: this.selectedTab == 2 })
        .onClick(() => { this.selectedTab = 2 })
      BotanyNavItem({ iconName: $r('sys.media.ohos_ic_public_settings'), isSelected: this.selectedTab == 3 })
        .onClick(() => { this.selectedTab = 3 })
    }
    .width('100%')
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .backgroundColor(BotanyColors.White)
    .shadow({ radius: 5, color: '#0D000000', offsetY: -2 })
  }
}

// MARK: - 10. BotanyNavItem
@Component
struct BotanyNavItem {
  private iconName: Resource = $r('sys.media.ohos_ic_public_home');
  private isSelected: boolean = false;

  build() {
    Column() {
      Image(this.iconName)
        .width(24)
        .height(24)
        .fillColor(BotanyColors.TextPrimary)
        .opacity(this.isSelected ? 1.0 : 0.4)
    }
    .layoutWeight(1)
  }
}