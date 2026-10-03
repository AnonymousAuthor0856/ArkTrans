import { curves } from '@kit.ArkUI';

// Color Palette
const botanyWhite = '#FFFFFFFF';
const botanySurface = '#FFFAFAFA';
const botanyTextPrimary = '#FF1A1C19';
const botanyTextSecondary = '#FF757575';
const botanyAccent = '#FF2E5E4E';
const colorEEEEEE = '#FFEEEEEE';
const colorE0E0E0 = '#FFE0E0E0';
const colorCCCCCC = '#FFCCCCCC';

// Data Models
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

// Mock Data
const tasksData: Task[] = [
  { id: 1, title: 'Watering', plantName: 'Monstera Deliciosa', iconName: 'calendar', urgency: 'Today' },
  { id: 2, title: 'Fertilize', plantName: 'Fiddle Leaf Fig', iconName: 'bell', urgency: 'Tomorrow' },
  { id: 3, title: 'Pruning', plantName: 'Snake Plant', iconName: 'settings', urgency: 'Next Week' },
];

const plantsData: Plant[] = [
  { id: 1, name: 'Monstera', scientificName: 'Monstera deliciosa', location: 'Living Room', daysUntilWater: 0, isHealthy: true },
  { id: 2, name: 'Fiddle Leaf', scientificName: 'Ficus lyrata', location: 'Bedroom', daysUntilWater: 2, isHealthy: true },
  { id: 3, name: 'Snakey', scientificName: 'Sansevieria', location: 'Hallway', daysUntilWater: 5, isHealthy: true },
  { id: 4, name: 'Spider Plant', scientificName: 'Chlorophytum', location: 'Kitchen', daysUntilWater: 1, isHealthy: true },
  { id: 5, name: 'Peace Lily', scientificName: 'Spathiphyllum', location: 'Bathroom', daysUntilWater: 3, isHealthy: true },
];

// TaskCard Component
@Component
struct TaskCard {
  task: Task = { id: 0, title: '', plantName: '', iconName: '', urgency: '' };
  @State isChecked: boolean = false;

  getIconResource(iconName: string): Resource {
    if (iconName === 'bell') {
      return $r('sys.symbol.bell');
    } else if (iconName === 'settings') {
      return $r('sys.symbol.gearshape');
    } else {
      return $r('sys.symbol.calendar');
    }
  }

  build() {
    Column() {
      Row() {
        Stack() {
          Circle()
            .fill(this.isChecked ? botanyAccent : '#FFFFFFFF')
            .width(40)
            .height(40)
          SymbolGlyph(this.getIconResource(this.task.iconName))
            .fontSize(20)
            .fontColor([this.isChecked ? '#FFFFFFFF' : botanyTextPrimary])
        }
        .width(40)
        .height(40)

        Blank()
      }
      .width('100%')

      Blank()
        .layoutWeight(1)

      Column() {
        Text(this.task.title)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(botanyTextPrimary)
          .width('100%')

        Text(this.task.plantName)
          .fontSize(12)
          .fontColor(botanyTextSecondary)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')

        Blank().height(8)

        Text(this.isChecked ? 'DONE' : this.task.urgency)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? '#FFFFFFFF' : botanyTextPrimary)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .backgroundColor(this.isChecked ? botanyAccent : colorE0E0E0)
          .borderRadius(4)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .padding(16)
    .width(160)
    .height(180)
    .backgroundColor(botanySurface)
    .borderRadius(24)
    .border({
      width: this.isChecked ? 2 : 1,
      color: this.isChecked ? botanyAccent : colorEEEEEE,
      radius: 24
    })
    .onClick(() => {
      animateTo({ duration: 200, curve: Curve.EaseInOut }, () => {
        this.isChecked = !this.isChecked;
      });
    })
  }
}

// PlantListItem Component
@Component
struct PlantListItem {
  plant: Plant = { id: 0, name: '', scientificName: '', location: '', daysUntilWater: 0, isHealthy: true };
  @State expanded: boolean = false;

  build() {
    Row() {
      // Plant image placeholder using Stack with Column as background
      Stack() {
        Column()
          .width(56)
          .height(56)
          .backgroundColor(colorEEEEEE)
          .borderRadius(12)

        SymbolGlyph($r('sys.symbol.heart_fill'))
          .fontSize(24)
          .fontColor([this.plant.daysUntilWater === 0 ? botanyAccent : colorCCCCCC])
      }
      .width(56)
      .height(56)

      Blank().width(16)

      Column() {
        Text(this.plant.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(botanyTextPrimary)
          .width('100%')

        Text(this.plant.scientificName)
          .fontSize(12)
          .fontColor(botanyTextSecondary)
          .fontStyle(FontStyle.Italic)
          .width('100%')

        if (this.expanded) {
          Blank().height(8)
          Row() {
            Text('📍')
              .fontSize(12)
              .fontColor(botanyTextSecondary)
            Blank().width(4)
            Text(this.plant.location)
              .fontSize(10)
              .fontColor(botanyTextSecondary)
          }
          .alignItems(VerticalAlign.Center)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column() {
        if (this.plant.daysUntilWater === 0) {
          SymbolGlyph($r('sys.symbol.checkmark_circle_fill'))
            .fontSize(24)
            .fontColor([botanyAccent])
          Text('Water')
            .fontSize(10)
            .fontColor(botanyAccent)
            .fontWeight(FontWeight.Bold)
        } else {
          Text(`${this.plant.daysUntilWater} days`)
            .fontSize(10)
            .fontColor(botanyTextSecondary)
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .alignItems(VerticalAlign.Center)
    .padding(16)
    .width('100%')
    .backgroundColor(botanySurface)
    .borderRadius(16)
    .margin({ left: 24, right: 24, top: 8, bottom: 8 })
    .onClick(() => {
      animateTo({ duration: 200, curve: Curve.EaseInOut }, () => {
        this.expanded = !this.expanded;
      });
    })
  }
}

// BotanyTopBar Component
@Component
struct BotanyTopBar {
  build() {
    Row() {
      Button({ type: ButtonType.Circle }) {
        SymbolGlyph($r('sys.symbol.line_3_horizontal'))
          .fontSize(20)
          .fontColor([botanyTextPrimary])
      }
      .width(40)
      .height(40)
      .backgroundColor(botanySurface)

      Blank()

      Button({ type: ButtonType.Circle }) {
        SymbolGlyph($r('sys.symbol.magnifyingglass'))
          .fontSize(20)
          .fontColor([botanyTextPrimary])
      }
      .width(40)
      .height(40)
      .backgroundColor(botanySurface)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: 24, right: 24, top: 24, bottom: 8 })
    .backgroundColor(botanyWhite)
  }
}

// BotanyNavItem Component
@Component
struct BotanyNavItem {
  iconName: string = '';
  isSelected: boolean = false;
  onTap: () => void = () => {};

  getIconResource(iconName: string): Resource {
    if (iconName === 'house') {
      return $r('sys.symbol.house_fill');
    } else if (iconName === 'calendar') {
      return $r('sys.symbol.calendar');
    } else if (iconName === 'bell') {
      return $r('sys.symbol.bell_fill');
    } else {
      return $r('sys.symbol.gearshape_fill');
    }
  }

  build() {
    Button({ type: ButtonType.Normal }) {
      SymbolGlyph(this.getIconResource(this.iconName))
        .fontSize(24)
        .fontColor([botanyTextPrimary])
        .opacity(this.isSelected ? 1.0 : 0.4)
    }
    .backgroundColor(Color.Transparent)
    .layoutWeight(1)
    .onClick(() => {
      this.onTap();
    })
  }
}

// BotanyBottomBar Component
@Component
struct BotanyBottomBar {
  @State selectedTab: number = 0;

  build() {
    Row() {
      BotanyNavItem({
        iconName: 'house',
        isSelected: this.selectedTab === 0,
        onTap: () => {
          this.selectedTab = 0;
        }
      })
      BotanyNavItem({
        iconName: 'calendar',
        isSelected: this.selectedTab === 1,
        onTap: () => {
          this.selectedTab = 1;
        }
      })
      Blank().width(32)
      BotanyNavItem({
        iconName: 'bell',
        isSelected: this.selectedTab === 2,
        onTap: () => {
          this.selectedTab = 2;
        }
      })
      BotanyNavItem({
        iconName: 'settings',
        isSelected: this.selectedTab === 3,
        onTap: () => {
          this.selectedTab = 3;
        }
      })
    }
    .width('100%')
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .backgroundColor(botanyWhite)
    .shadow({ radius: 5, color: '#0D000000', offsetX: 0, offsetY: -2 })
  }
}

// SectionHeader Component
@Component
struct SectionHeader {
  title: string = '';

  build() {
    Text(this.title)
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .fontColor(botanyTextPrimary)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
      .width('100%')
  }
}

// Main Content View
@Entry
@Component
struct BotanyContentView {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(botanyWhite)

      // Main content
      Column() {
        // Top Bar
        BotanyTopBar()

        // Scrollable content
        Scroll() {
          Column() {
            // Header
            Column() {
              Text('Good Morning,')
                .fontSize(16)
                .fontColor(botanyTextSecondary)
                .width('100%')
              Text('My Jungle')
                .fontSize(34)
                .fontWeight(FontWeight.Bold)
                .letterSpacing(-1)
                .fontColor(botanyTextPrimary)
                .width('100%')
            }
            .alignItems(HorizontalAlign.Start)
            .padding({ left: 24, right: 24, top: 16, bottom: 16 })
            .width('100%')

            // Tasks Section
            SectionHeader({ title: 'Pending Tasks' })

            Scroll() {
              Row({ space: 16 }) {
                ForEach(tasksData, (task: Task) => {
                  TaskCard({ task: task })
                }, (task: Task) => task.id.toString())
              }
              .padding({ left: 24, right: 24 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .align(Alignment.Start)

            Blank().height(32)

            // Plants Section
            SectionHeader({ title: 'Your Collection' })

            ForEach(plantsData, (plant: Plant) => {
              PlantListItem({ plant: plant })
            }, (plant: Plant) => plant.id.toString())

            Blank().height(80)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
        .align(Alignment.Top)
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)

      // FAB
      Row() {
        Blank().layoutWeight(1)
        Button({ type: ButtonType.Circle }) {
          SymbolGlyph($r('sys.symbol.plus'))
            .fontSize(24)
            .fontColor(['#FFFFFFFF'])
        }
        .width(56)
        .height(56)
        .backgroundColor(botanyTextPrimary)
        .margin({ right: 24, bottom: 96 })
      }
      .width('100%')
      .zIndex(1)

      // Bottom Bar
      BotanyBottomBar()
        .zIndex(2)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(botanyWhite)
  }
}