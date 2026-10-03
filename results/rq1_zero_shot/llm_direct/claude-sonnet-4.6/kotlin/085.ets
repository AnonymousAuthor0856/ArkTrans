import { curves } from '@kit.ArkUI';

// --- Data Models ---
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
  icon: Resource;
  urgency: string;

  constructor(id: number, title: string, plantName: string, icon: Resource, urgency: string) {
    this.id = id;
    this.title = title;
    this.plantName = plantName;
    this.icon = icon;
    this.urgency = urgency;
  }
}

// --- Color Palette ---
const BotanyWhite: string = '#FFFFFFFF';
const BotanySurface: string = '#FFFAFAFA';
const BotanyTextPrimary: string = '#FF1A1C19';
const BotanyTextSecondary: string = '#FF757575';
const BotanyAccent: string = '#FF2E5E4E';
const BotanyAccentLight: string = '#FFE8F5E9';

// --- Mock Data ---
const tasks: Task[] = [
  new Task(1, 'Watering', 'Monstera Deliciosa', $r('sys.media.ohos_ic_public_calendar'), 'Today'),
  new Task(2, 'Fertilize', 'Fiddle Leaf Fig', $r('sys.media.ohos_ic_public_sound'), 'Tomorrow'),
  new Task(3, 'Pruning', 'Snake Plant', $r('sys.media.ohos_ic_public_settings'), 'Next Week'),
];

const plants: Plant[] = [
  new Plant(1, 'Monstera', 'Monstera deliciosa', 'Living Room', 0),
  new Plant(2, 'Fiddle Leaf', 'Ficus lyrata', 'Bedroom', 2),
  new Plant(3, 'Snakey', 'Sansevieria', 'Hallway', 5),
  new Plant(4, 'Spider Plant', 'Chlorophytum', 'Kitchen', 1),
  new Plant(5, 'Peace Lily', 'Spathiphyllum', 'Bathroom', 3),
];

// --- TaskCard Component ---
@Component
struct TaskCard {
  task: Task = new Task(0, '', '', $r('sys.media.ohos_ic_public_calendar'), '');
  @State isChecked: boolean = false;

  build() {
    Column() {
      Row() {
        Stack() {
          Circle()
            .width(40)
            .height(40)
            .fill(this.isChecked ? BotanyAccent : '#FFFFFFFF')

          Image(this.task.icon)
            .width(20)
            .height(20)
            .fillColor(this.isChecked ? '#FFFFFFFF' : BotanyTextPrimary)
        }
        .width(40)
        .height(40)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Column() {
        Text(this.task.title)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyTextPrimary)

        Text(this.task.plantName)
          .fontSize(12)
          .fontColor(BotanyTextSecondary)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Blank().height(8)

        Text(this.isChecked ? 'DONE' : this.task.urgency)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? '#FFFFFFFF' : BotanyTextPrimary)
          .backgroundColor(this.isChecked ? BotanyAccent : '#FFE0E0E0')
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .borderRadius(4)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .width(160)
    .height(180)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(BotanySurface)
    .borderRadius(24)
    .border({
      width: this.isChecked ? 2 : 1,
      color: this.isChecked ? BotanyAccent : '#FFEEEEEE'
    })
    .onClick(() => {
      this.isChecked = !this.isChecked;
    })
  }
}

// --- PlantListItem Component ---
@Component
struct PlantListItem {
  plant: Plant = new Plant(0, '', '', '', 0);
  @State expanded: boolean = false;

  build() {
    Row() {
      Stack() {
        RoundedRect()

        Image($r('sys.media.ohos_ic_public_favor_filled'))
          .width(24)
          .height(24)
          .fillColor(this.plant.daysUntilWater === 0 ? BotanyAccent : '#FFCCCCCC')
      }
      .width(56)
      .height(56)
      .borderRadius(12)
      .backgroundColor('#FFEEEEEE')

      Blank().width(16)

      Column() {
        Text(this.plant.name)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyTextPrimary)

        Text(this.plant.scientificName)
          .fontSize(12)
          .fontColor(BotanyTextSecondary)
          .fontStyle(FontStyle.Italic)

        if (this.expanded) {
          Blank().height(8)
          Row() {
            Image($r('sys.media.ohos_ic_public_location'))
              .width(12)
              .height(12)
              .fillColor(BotanyTextSecondary)
            Blank().width(4)
            Text(this.plant.location)
              .fontSize(10)
              .fontColor(BotanyTextSecondary)
          }
          .alignItems(VerticalAlign.Center)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column() {
        if (this.plant.daysUntilWater === 0) {
          Image($r('sys.media.ohos_ic_public_ok'))
            .width(24)
            .height(24)
            .fillColor(BotanyAccent)
          Text('Water')
            .fontSize(10)
            .fontColor(BotanyAccent)
            .fontWeight(FontWeight.Bold)
        } else {
          Text(`${this.plant.daysUntilWater} days`)
            .fontSize(10)
            .fontColor(BotanyTextSecondary)
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(16)
    .borderRadius(16)
    .backgroundColor(BotanySurface)
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      this.expanded = !this.expanded;
    })
  }
}

// --- TopBar Component ---
@Component
struct BotanyTopBar {
  build() {
    Row() {
      Button({ type: ButtonType.Circle }) {
        Image($r('sys.media.ohos_ic_public_list_numbered'))
          .width(20)
          .height(20)
          .fillColor(BotanyTextPrimary)
      }
      .width(40)
      .height(40)
      .backgroundColor(BotanySurface)

      Button({ type: ButtonType.Circle }) {
        Image($r('sys.media.ohos_ic_public_search'))
          .width(20)
          .height(20)
          .fillColor(BotanyTextPrimary)
      }
      .width(40)
      .height(40)
      .backgroundColor(BotanySurface)
    }
    .width('100%')
    .padding({ top: 24, start: 24, end: 24, bottom: 8 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

// --- NavItem Component ---
@Component
struct BotanyNavItem {
  icon: Resource = $r('sys.media.ohos_ic_public_home');
  isSelected: boolean = false;

  build() {
    Button({ type: ButtonType.Normal }) {
      Image(this.icon)
        .width(24)
        .height(24)
        .fillColor(BotanyTextPrimary)
        .opacity(this.isSelected ? 1.0 : 0.4)
        .animation({
          duration: 300,
          curve: curves.easeInOut
        })
    }
    .backgroundColor(Color.Transparent)
    .width(48)
    .height(48)
  }
}

// --- BottomBar Component ---
@Component
struct BotanyBottomBar {
  build() {
    Row() {
      BotanyNavItem({ icon: $r('sys.media.ohos_ic_public_home'), isSelected: true })
      BotanyNavItem({ icon: $r('sys.media.ohos_ic_public_calendar'), isSelected: false })
      Blank().width(32)
      BotanyNavItem({ icon: $r('sys.media.ohos_ic_public_sound'), isSelected: false })
      BotanyNavItem({ icon: $r('sys.media.ohos_ic_public_settings'), isSelected: false })
    }
    .width('100%')
    .backgroundColor(BotanyWhite)
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

// --- Main Page ---
@Entry
@Component
struct BotanyApp {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        // TopBar
        BotanyTopBar()

        // Scrollable Content
        Scroll() {
          Column() {
            // Header
            Column() {
              Text('Good Morning,')
                .fontSize(16)
                .fontColor(BotanyTextSecondary)

              Text('My Jungle')
                .fontSize(45)
                .fontWeight(FontWeight.Bold)
                .fontColor(BotanyTextPrimary)
                .letterSpacing(-1)
            }
            .alignItems(HorizontalAlign.Start)
            .padding({ left: 24, right: 24, top: 16, bottom: 16 })
            .width('100%')

            // Tasks Section
            Text('Pending Tasks')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(BotanyTextPrimary)
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })
              .width('100%')
              .textAlign(TextAlign.Start)

            Scroll() {
              Row({ space: 16 }) {
                ForEach(tasks, (task: Task) => {
                  TaskCard({ task: task })
                }, (task: Task) => task.id.toString())
              }
              .padding({ left: 24, right: 24 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            Blank().height(32)

            // Collection Section
            Text('Your Collection')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(BotanyTextPrimary)
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })
              .width('100%')
              .textAlign(TextAlign.Start)

            ForEach(plants, (plant: Plant) => {
              PlantListItem({ plant: plant })
                .padding({ left: 24, right: 24, top: 8, bottom: 8 })
            }, (plant: Plant) => plant.id.toString())

            Blank().height(80)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .backgroundColor(BotanyWhite)

        // BottomBar
        BotanyBottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BotanyWhite)

      // FAB
      Button({ type: ButtonType.Circle }) {
        Image($r('sys.media.ohos_ic_public_add'))
          .width(24)
          .height(24)
          .fillColor('#FFFFFFFF')
      }
      .width(56)
      .height(56)
      .backgroundColor(BotanyTextPrimary)
      .margin({ right: 24, bottom: 90 })
    }
    .width('100%')
    .height('100%')
  }
}