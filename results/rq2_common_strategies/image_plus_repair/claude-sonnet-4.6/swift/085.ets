// Color constants
const BOTANY_WHITE = '#FFFFFFFF';
const BOTANY_SURFACE = '#FFFAFAFA';
const BOTANY_TEXT_PRIMARY = '#FF1A1C19';
const BOTANY_TEXT_SECONDARY = '#FF757575';
const BOTANY_ACCENT = '#FF2E5E4E';
const COLOR_EEEEEE = '#FFEEEEEE';
const COLOR_E0E0E0 = '#FFE0E0E0';
const COLOR_CCCCCC = '#FFCCCCCC';

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

// TaskCard Component
@Component
struct TaskCard {
  task: Task = { id: 0, title: '', plantName: '', iconName: '', urgency: '' };
  @State isChecked: boolean = false;

  getIconByName(name: string): Resource {
    if (name === 'calendar') return $r('sys.symbol.calendar');
    if (name === 'bell.fill') return $r('sys.symbol.bell_fill');
    if (name === 'gearshape.fill') return $r('sys.symbol.gearshape_fill');
    return $r('sys.symbol.calendar');
  }

  build() {
    Column({ space: 0 }) {
      Row() {
        Stack() {
          Circle()
            .fill(this.isChecked ? BOTANY_ACCENT : '#FFFFFFFF')
            .width(40)
            .height(40)
          SymbolGlyph(this.getIconByName(this.task.iconName))
            .fontSize(20)
            .fontColor([this.isChecked ? '#FFFFFFFF' : BOTANY_TEXT_PRIMARY])
        }
        .width(40)
        .height(40)
        Blank()
      }
      .width('100%')

      Blank()

      Column({ space: 0 }) {
        Text(this.task.title)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(BOTANY_TEXT_PRIMARY)
        Text(this.task.plantName)
          .fontSize(12)
          .fontColor(BOTANY_TEXT_SECONDARY)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Blank().height(8)
        Text(this.isChecked ? 'DONE' : this.task.urgency)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? '#FFFFFFFF' : BOTANY_TEXT_PRIMARY)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .backgroundColor(this.isChecked ? BOTANY_ACCENT : COLOR_E0E0E0)
          .borderRadius(4)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .padding(16)
    .width(160)
    .height(180)
    .backgroundColor(BOTANY_SURFACE)
    .borderRadius(24)
    .border({
      width: this.isChecked ? 2 : 1,
      color: this.isChecked ? BOTANY_ACCENT : COLOR_EEEEEE
    })
    .onClick(() => {
      this.isChecked = !this.isChecked;
    })
  }
}

// PlantListItem Component
@Component
struct PlantListItem {
  plant: Plant = {
    id: 0,
    name: '',
    scientificName: '',
    location: '',
    daysUntilWater: 0,
    isHealthy: true
  };
  @State expanded: boolean = false;

  build() {
    Row() {
      Stack() {
        Column()
          .width(56)
          .height(56)
          .backgroundColor(COLOR_EEEEEE)
          .borderRadius(12)
        SymbolGlyph($r('sys.symbol.heart_fill'))
          .fontSize(24)
          .fontColor([this.plant.daysUntilWater === 0 ? BOTANY_ACCENT : COLOR_CCCCCC])
      }
      .width(56)
      .height(56)

      Blank().width(16)

      Column({ space: 0 }) {
        Text(this.plant.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(BOTANY_TEXT_PRIMARY)
        Text(this.plant.scientificName)
          .fontSize(12)
          .fontColor(BOTANY_TEXT_SECONDARY)
          .fontStyle(FontStyle.Italic)

        if (this.expanded) {
          Blank().height(8)
          Row() {
            Text('📍')
              .fontSize(12)
              .fontColor(BOTANY_TEXT_SECONDARY)
            Blank().width(4)
            Text(this.plant.location)
              .fontSize(10)
              .fontColor(BOTANY_TEXT_SECONDARY)
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
            .fontColor([BOTANY_ACCENT])
          Text('Water')
            .fontSize(10)
            .fontColor(BOTANY_ACCENT)
            .fontWeight(FontWeight.Bold)
        } else {
          Text(`${this.plant.daysUntilWater} days`)
            .fontSize(10)
            .fontColor(BOTANY_TEXT_SECONDARY)
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .alignItems(VerticalAlign.Center)
    .padding(16)
    .width('100%')
    .backgroundColor(BOTANY_SURFACE)
    .borderRadius(16)
    .margin({ left: 24, right: 24, top: 8, bottom: 8 })
    .onClick(() => {
      this.expanded = !this.expanded;
    })
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
      .fontColor(BOTANY_TEXT_PRIMARY)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
      .width('100%')
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
          .fontColor([BOTANY_TEXT_PRIMARY])
      }
      .width(40)
      .height(40)
      .backgroundColor(BOTANY_SURFACE)

      Blank()

      Button({ type: ButtonType.Circle }) {
        SymbolGlyph($r('sys.symbol.magnifyingglass'))
          .fontSize(20)
          .fontColor([BOTANY_TEXT_PRIMARY])
      }
      .width(40)
      .height(40)
      .backgroundColor(BOTANY_SURFACE)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

// BotanyNavItem Component
@Component
struct BotanyNavItem {
  iconName: string = '';
  isSelected: boolean = false;

  getIconByName(name: string): Resource {
    if (name === 'house.fill') return $r('sys.symbol.house_fill');
    if (name === 'calendar') return $r('sys.symbol.calendar');
    if (name === 'bell.fill') return $r('sys.symbol.bell_fill');
    if (name === 'gearshape.fill') return $r('sys.symbol.gearshape_fill');
    return $r('sys.symbol.house_fill');
  }

  build() {
    SymbolGlyph(this.getIconByName(this.iconName))
      .fontSize(24)
      .fontColor([BOTANY_TEXT_PRIMARY])
      .opacity(this.isSelected ? 1.0 : 0.4)
      .layoutWeight(1)
  }
}

// BotanyBottomBar Component
@Component
struct BotanyBottomBar {
  @State selectedTab: number = 0;

  build() {
    Row({ space: 0 }) {
      BotanyNavItem({ iconName: 'house.fill', isSelected: this.selectedTab === 0 })
        .onClick(() => { this.selectedTab = 0; })
      BotanyNavItem({ iconName: 'calendar', isSelected: this.selectedTab === 1 })
        .onClick(() => { this.selectedTab = 1; })
      Blank().width(32)
      BotanyNavItem({ iconName: 'bell.fill', isSelected: this.selectedTab === 2 })
        .onClick(() => { this.selectedTab = 2; })
      BotanyNavItem({ iconName: 'gearshape.fill', isSelected: this.selectedTab === 3 })
        .onClick(() => { this.selectedTab = 3; })
    }
    .width('100%')
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .backgroundColor(BOTANY_WHITE)
    .shadow({ radius: 5, color: '#0D000000', offsetX: 0, offsetY: -2 })
  }
}

// Main Content View
@Entry
@Component
struct BotanyContentView {
  tasks: Task[] = [
    { id: 1, title: 'Watering', plantName: 'Monstera Deliciosa', iconName: 'calendar', urgency: 'Today' },
    { id: 2, title: 'Fertilize', plantName: 'Fiddle Leaf Fig', iconName: 'bell.fill', urgency: 'Tomorrow' },
    { id: 3, title: 'Pruning', plantName: 'Snake Plant', iconName: 'gearshape.fill', urgency: 'Next Week' }
  ];

  plants: Plant[] = [
    { id: 1, name: 'Monstera', scientificName: 'Monstera deliciosa', location: 'Living Room', daysUntilWater: 0, isHealthy: true },
    { id: 2, name: 'Fiddle Leaf', scientificName: 'Ficus lyrata', location: 'Bedroom', daysUntilWater: 2, isHealthy: true },
    { id: 3, name: 'Snakey', scientificName: 'Sansevieria', location: 'Hallway', daysUntilWater: 5, isHealthy: true },
    { id: 4, name: 'Spider Plant', scientificName: 'Chlorophytum', location: 'Kitchen', daysUntilWater: 1, isHealthy: true },
    { id: 5, name: 'Peace Lily', scientificName: 'Spathiphyllum', location: 'Bathroom', daysUntilWater: 3, isHealthy: true }
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        // Top Bar
        BotanyTopBar()
          .padding({ top: 24, left: 24, right: 24, bottom: 8 })
          .backgroundColor(BOTANY_WHITE)

        // Scrollable Content
        Scroll() {
          Column({ space: 0 }) {
            // Header
            Column({ space: 0 }) {
              Text('Good Morning,')
                .fontSize(16)
                .fontColor(BOTANY_TEXT_SECONDARY)
              Text('My Jungle')
                .fontSize(34)
                .fontWeight(FontWeight.Bold)
                .fontColor(BOTANY_TEXT_PRIMARY)
                .letterSpacing(-1)
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
            .align(Alignment.Start)

            Blank().height(32)

            // Collection Section
            SectionHeader({ title: 'Your Collection' })

            ForEach(this.plants, (plant: Plant) => {
              PlantListItem({ plant: plant })
            }, (plant: Plant) => plant.id.toString())

            Blank().height(80)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
        .align(Alignment.Top)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BOTANY_WHITE)

      // FAB
      Row() {
        Blank()
        Button({ type: ButtonType.Circle }) {
          SymbolGlyph($r('sys.symbol.plus'))
            .fontSize(24)
            .fontColor(['#FFFFFFFF'])
        }
        .width(56)
        .height(56)
        .backgroundColor(BOTANY_TEXT_PRIMARY)
        .margin({ right: 24, bottom: 96 })
      }
      .width('100%')
      .zIndex(1)

      // Bottom Bar
      BotanyBottomBar()
        .width('100%')
        .zIndex(2)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BOTANY_WHITE)
  }
}