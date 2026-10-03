import { router } from '@kit.ArkUI';

// MARK: - 1. Color Palette
const BotanyColors = {
  botanyWhite: '#FFFFFFFF',
  botanySurface: '#FFFAFAFA',
  botanyTextPrimary: '#FF1A1C19',
  botanyTextSecondary: '#FF757575',
  botanyAccent: '#FF2E5E4E',
  botanyAccentLight: '#FFE8F5E9',
  lightGrey: '#FFEEEEEE',
  mediumGrey: '#FFE0E0E0',
  placeholderGrey: '#FFCCCCCC',
}

// MARK: - 2. Data Models
interface Plant {
  id: number;
  name: string;
  scientificName: string;
  location: string;
  daysUntilWater: number;
  isHealthy: boolean;
}

interface Task {
  id: number;
  title: string;
  plantName: string;
  iconName: string;
  urgency: string;
}

// MARK: - 3. Mock Data
const mockTasks: Task[] = [
  { id: 1, title: 'Watering', plantName: 'Monstera Deliciosa', iconName: 'calendar', urgency: 'Today' },
  { id: 2, title: 'Fertilize', plantName: 'Fiddle Leaf Fig', iconName: 'bell', urgency: 'Tomorrow' },
  { id: 3, title: 'Pruning', plantName: 'Snake Plant', iconName: 'settings', urgency: 'Next Week' },
];

const mockPlants: Plant[] = [
  { id: 1, name: 'Monstera', scientificName: 'Monstera deliciosa', location: 'Living Room', daysUntilWater: 0, isHealthy: true },
  { id: 2, name: 'Fiddle Leaf', scientificName: 'Ficus lyrata', location: 'Bedroom', daysUntilWater: 2, isHealthy: true },
  { id: 3, name: 'Snakey', scientificName: 'Sansevieria', location: 'Hallway', daysUntilWater: 5, isHealthy: true },
  { id: 4, name: 'Spider Plant', scientificName: 'Chlorophytum', location: 'Kitchen', daysUntilWater: 1, isHealthy: true },
  { id: 5, name: 'Peace Lily', scientificName: 'Spathiphyllum', location: 'Bathroom', daysUntilWater: 3, isHealthy: true },
];

// MARK: - 4. TaskCard Component
@Component
struct TaskCard {
  task: Task = { id: 0, title: '', plantName: '', iconName: '', urgency: '' };
  @State isChecked: boolean = false;

  build() {
    Column({ space: 0 }) {
      Row() {
        Stack() {
          Circle()
            .width(40)
            .height(40)
            .fill(this.isChecked ? BotanyColors.botanyAccent : '#FFFFFFFF')
          Image($r('app.media.ic_public_calendar'))
            .width(20)
            .height(20)
            .fillColor(this.isChecked ? '#FFFFFFFF' : BotanyColors.botanyTextPrimary)
        }
        .width(40)
        .height(40)
        Blank()
      }
      .width('100%')

      Blank()
        .layoutWeight(1)

      Column({ space: 0 }) {
        Text(this.task.title)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyColors.botanyTextPrimary)

        Text(this.task.plantName)
          .fontSize(12)
          .fontColor(BotanyColors.botanyTextSecondary)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Blank()
          .height(8)

        Text(this.isChecked ? 'DONE' : this.task.urgency)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? '#FFFFFFFF' : BotanyColors.botanyTextPrimary)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .backgroundColor(this.isChecked ? BotanyColors.botanyAccent : BotanyColors.mediumGrey)
          .borderRadius(4)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .padding(16)
    .width(160)
    .height(180)
    .backgroundColor(BotanyColors.botanySurface)
    .borderRadius(24)
    .border({
      width: this.isChecked ? 2 : 1,
      color: this.isChecked ? BotanyColors.botanyAccent : BotanyColors.lightGrey,
      radius: 24
    })
    .onClick(() => {
      animateTo({ duration: 200, curve: Curve.EaseInOut }, () => {
        this.isChecked = !this.isChecked;
      });
    })
  }
}

// MARK: - 5. PlantListItem Component
@Component
struct PlantListItem {
  plant: Plant = { id: 0, name: '', scientificName: '', location: '', daysUntilWater: 0, isHealthy: true };
  @State expanded: boolean = false;

  build() {
    Row({ space: 0 }) {
      Stack() {
        RoundedRect()
          .width(56)
          .height(56)
          .radiusWidth(12)
          .radiusHeight(12)
          .fill(BotanyColors.lightGrey)
        Image($r('app.media.ic_public_heart_filled'))
          .width(24)
          .height(24)
          .fillColor(this.plant.daysUntilWater === 0 ? BotanyColors.botanyAccent : BotanyColors.placeholderGrey)
      }
      .width(56)
      .height(56)

      Blank()
        .width(16)

      Column({ space: 0 }) {
        Text(this.plant.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyColors.botanyTextPrimary)

        Text(this.plant.scientificName)
          .fontSize(12)
          .fontColor(BotanyColors.botanyTextSecondary)
          .fontStyle(FontStyle.Italic)

        if (this.expanded) {
          Blank()
            .height(8)
          Row({ space: 0 }) {
            Image($r('app.media.ic_public_location'))
              .width(12)
              .height(12)
              .fillColor(BotanyColors.botanyTextSecondary)
            Blank()
              .width(4)
            Text(this.plant.location)
              .fontSize(10)
              .fontColor(BotanyColors.botanyTextSecondary)
          }
          .alignItems(VerticalAlign.Center)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column({ space: 0 }) {
        if (this.plant.daysUntilWater === 0) {
          Image($r('app.media.ic_public_ok_circle'))
            .width(24)
            .height(24)
            .fillColor(BotanyColors.botanyAccent)
          Text('Water')
            .fontSize(10)
            .fontColor(BotanyColors.botanyAccent)
            .fontWeight(FontWeight.Bold)
        } else {
          Text(`${this.plant.daysUntilWater} days`)
            .fontSize(10)
            .fontColor(BotanyColors.botanyTextSecondary)
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .alignItems(VerticalAlign.Center)
    .padding(16)
    .width('100%')
    .backgroundColor(BotanyColors.botanySurface)
    .borderRadius(16)
    .margin({ left: 24, right: 24, top: 8, bottom: 8 })
    .onClick(() => {
      animateTo({ duration: 200, curve: Curve.EaseInOut }, () => {
        this.expanded = !this.expanded;
      });
    })
  }
}

// MARK: - 6. BotanyTopBar Component
@Component
struct BotanyTopBar {
  build() {
    Row() {
      Button({ type: ButtonType.Circle }) {
        Image($r('app.media.ic_public_list'))
          .width(24)
          .height(24)
          .fillColor(BotanyColors.botanyTextPrimary)
      }
      .width(40)
      .height(40)
      .backgroundColor(BotanyColors.botanySurface)

      Blank()

      Button({ type: ButtonType.Circle }) {
        Image($r('app.media.ic_public_search'))
          .width(24)
          .height(24)
          .fillColor(BotanyColors.botanyTextPrimary)
      }
      .width(40)
      .height(40)
      .backgroundColor(BotanyColors.botanySurface)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: 24, right: 24, top: 24, bottom: 8 })
    .backgroundColor(BotanyColors.botanyWhite)
  }
}

// MARK: - 7. BotanyNavItem Component
@Component
struct BotanyNavItem {
  iconRes: Resource = $r('app.media.ic_public_home');
  isSelected: boolean = false;
  onSelect: () => void = () => {};

  build() {
    Button({ type: ButtonType.Normal }) {
      Image(this.iconRes)
        .width(24)
        .height(24)
        .fillColor(BotanyColors.botanyTextPrimary)
        .opacity(this.isSelected ? 1.0 : 0.4)
    }
    .backgroundColor(Color.Transparent)
    .layoutWeight(1)
    .onClick(() => {
      this.onSelect();
    })
  }
}

// MARK: - 8. BotanyBottomBar Component
@Component
struct BotanyBottomBar {
  @State selectedTab: number = 0;

  build() {
    Row({ space: 0 }) {
      BotanyNavItem({
        iconRes: $r('app.media.ic_public_home'),
        isSelected: this.selectedTab === 0,
        onSelect: () => { this.selectedTab = 0; }
      })

      BotanyNavItem({
        iconRes: $r('app.media.ic_public_calendar'),
        isSelected: this.selectedTab === 1,
        onSelect: () => { this.selectedTab = 1; }
      })

      Blank()
        .width(32)

      BotanyNavItem({
        iconRes: $r('app.media.ic_public_bell'),
        isSelected: this.selectedTab === 2,
        onSelect: () => { this.selectedTab = 2; }
      })

      BotanyNavItem({
        iconRes: $r('app.media.ic_public_settings'),
        isSelected: this.selectedTab === 3,
        onSelect: () => { this.selectedTab = 3; }
      })
    }
    .width('100%')
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .backgroundColor(BotanyColors.botanyWhite)
    .shadow({ radius: 5, color: '#0D000000', offsetX: 0, offsetY: -2 })
  }
}

// MARK: - 9. SectionHeader Component
@Component
struct SectionHeader {
  title: string = '';

  build() {
    Text(this.title)
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .fontColor(BotanyColors.botanyTextPrimary)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
      .width('100%')
  }
}

// MARK: - 10. Main Content View
@Entry
@Component
struct BotanyContentView {
  private tasks: Task[] = mockTasks;
  private plants: Plant[] = mockPlants;

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        BotanyTopBar()

        Scroll() {
          Column({ space: 0 }) {
            // Header Section
            Column({ space: 0 }) {
              Text('Good Morning,')
                .fontSize(16)
                .fontColor(BotanyColors.botanyTextSecondary)
              Text('My Jungle')
                .fontSize(34)
                .fontWeight(FontWeight.Bold)
                .letterSpacing(-1)
                .fontColor(BotanyColors.botanyTextPrimary)
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding({ left: 24, right: 24, top: 16, bottom: 16 })

            // Tasks Section
            SectionHeader({ title: 'Pending Tasks' })

            Scroll() {
              Row({ space: 16 }) {
                ForEach(this.tasks, (task: Task) => {
                  TaskCard({ task: task })
                }, (task: Task) => task.id.toString())
              }
              .padding({ left: 24, right: 24 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            Blank()
              .height(32)

            // Plants Section
            SectionHeader({ title: 'Your Collection' })

            ForEach(this.plants, (plant: Plant) => {
              PlantListItem({ plant: plant })
            }, (plant: Plant) => plant.id.toString())

            Blank()
              .height(80)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
        .backgroundColor(BotanyColors.botanyWhite)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BotanyColors.botanyWhite)

      // FAB Button
      Row() {
        Blank()
        Button({ type: ButtonType.Circle }) {
          Image($r('app.media.ic_public_add'))
            .width(24)
            .height(24)
            .fillColor('#FFFFFFFF')
        }
        .width(56)
        .height(56)
        .backgroundColor(BotanyColors.botanyTextPrimary)
        .margin({ right: 24, bottom: 96 })
      }
      .width('100%')
      .zIndex(1)

      // Bottom Navigation Bar
      BotanyBottomBar()
        .width('100%')
        .zIndex(2)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BotanyColors.botanyWhite)
  }
}