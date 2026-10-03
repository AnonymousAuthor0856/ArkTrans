// BotanyApp.ets
// ArkTS (HarmonyOS ArkUI) translation of the SwiftUI "Botany" screen.

// ============================================================
// 1. Color Palette
// ============================================================
const BOTANY_WHITE: string = '#FFFFFF';
const BOTANY_SURFACE: string = '#FAFAFA';
const BOTANY_TEXT_PRIMARY: string = '#1A1C19';
const BOTANY_TEXT_SECONDARY: string = '#757575';
const BOTANY_ACCENT: string = '#2E5E4E';
const BOTANY_ACCENT_LIGHT: string = '#E8F5E9';
const BOTANY_CHIP: string = '#E0E0E0';
const BOTANY_BORDER: string = '#EEEEEE';
const BOTANY_ICON_BG: string = '#EEEEEE';
const BOTANY_ICON_MUTED: string = '#CCCCCC';

// ============================================================
// 2. Icon glyph helper
// (ArkTS has no SF Symbols; we map names to Unicode glyphs.)
// ============================================================
function iconGlyph(name: string): string {
  switch (name) {
    case 'menu':
      return '\u2630';
    case 'search':
      return '\u{1F50D}';
    case 'plus':
      return '+';
    case 'calendar':
      return '\u{1F4C5}';
    case 'bell':
      return '\u{1F514}';
    case 'gear':
      return '\u2699';
    case 'home':
      return '\u{1F3E0}';
    case 'heart':
      return '\u2665';
    case 'check':
      return '\u2713';
    case 'location':
      return '\u2316';
    default:
      return '\u2022';
  }
}

// ============================================================
// 3. Data Models
// ============================================================
class TaskItem {
  id: number;
  title: string;
  plantName: string;
  icon: string;
  urgency: string;

  constructor(id: number, title: string, plantName: string, icon: string, urgency: string) {
    this.id = id;
    this.title = title;
    this.plantName = plantName;
    this.icon = icon;
    this.urgency = urgency;
  }
}

class PlantItem {
  id: number;
  name: string;
  scientificName: string;
  location: string;
  daysUntilWater: number;
  isHealthy: boolean;

  constructor(id: number, name: string, scientificName: string, location: string, daysUntilWater: number) {
    this.id = id;
    this.name = name;
    this.scientificName = scientificName;
    this.location = location;
    this.daysUntilWater = daysUntilWater;
    this.isHealthy = true;
  }
}

// ============================================================
// 4. Top Bar
// ============================================================
@Component
struct BotanyTopBar {
  build() {
    Row() {
      this.CircleIconButton('menu')
      Blank()
      this.CircleIconButton('search')
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  CircleIconButton(name: string) {
    Stack() {
      Text(iconGlyph(name))
        .fontSize(18)
        .fontColor(BOTANY_TEXT_PRIMARY)
    }
    .width(40)
    .height(40)
    .backgroundColor(BOTANY_SURFACE)
    .borderRadius(20)
  }
}

// ============================================================
// 5. Task Card
// ============================================================
@Component
struct TaskCard {
  task: TaskItem = new TaskItem(0, '', '', 'calendar', '');
  @State isChecked: boolean = false;

  build() {
    Column() {
      Row() {
        Stack() {
          Circle()
            .width(40)
            .height(40)
            .fill(this.isChecked ? BOTANY_ACCENT : BOTANY_WHITE)
          Text(iconGlyph(this.task.icon))
            .fontSize(18)
            .fontColor(this.isChecked ? BOTANY_WHITE : BOTANY_TEXT_PRIMARY)
        }
        .width(40)
        .height(40)

        Blank()
      }
      .width('100%')

      Blank()

      Column() {
        Text(this.task.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(BOTANY_TEXT_PRIMARY)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Text(this.task.plantName)
          .fontSize(12)
          .fontColor(BOTANY_TEXT_SECONDARY)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Text(this.isChecked ? 'DONE' : this.task.urgency)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? BOTANY_WHITE : BOTANY_TEXT_PRIMARY)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .backgroundColor(this.isChecked ? BOTANY_ACCENT : BOTANY_CHIP)
          .borderRadius(4)
          .margin({ top: 8 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width(160)
    .height(180)
    .padding(16)
    .backgroundColor(BOTANY_SURFACE)
    .borderRadius(24)
    .border({
      width: this.isChecked ? 2 : 1,
      color: this.isChecked ? BOTANY_ACCENT : BOTANY_BORDER,
      radius: 24
    })
    .onClick(() => {
      animateTo({ duration: 200, curve: Curve.EaseInOut }, () => {
        this.isChecked = !this.isChecked;
      });
    })
  }
}

// ============================================================
// 6. Plant List Item
// ============================================================
@Component
struct PlantListItem {
  plant: PlantItem = new PlantItem(0, '', '', '', 0);
  @State expanded: boolean = false;

  build() {
    Column() {
      Row() {
        // Image placeholder
        Stack() {
          Text(iconGlyph('heart'))
            .fontSize(20)
            .fontColor(this.plant.daysUntilWater === 0 ? BOTANY_ACCENT : BOTANY_ICON_MUTED)
        }
        .width(56)
        .height(56)
        .backgroundColor(BOTANY_ICON_BG)
        .borderRadius(12)

        Column() {
          Text(this.plant.name)
            .fontSize(17)
            .fontWeight(FontWeight.Bold)
            .fontColor(BOTANY_TEXT_PRIMARY)
          Text(this.plant.scientificName)
            .fontSize(12)
            .fontStyle(FontStyle.Italic)
            .fontColor(BOTANY_TEXT_SECONDARY)

          if (this.expanded) {
            Row() {
              Text(iconGlyph('location'))
                .fontSize(12)
                .fontColor(BOTANY_TEXT_SECONDARY)
              Text(this.plant.location)
                .fontSize(10)
                .fontColor(BOTANY_TEXT_SECONDARY)
                .margin({ left: 4 })
            }
            .alignItems(VerticalAlign.Center)
            .margin({ top: 8 })
          }
        }
        .layoutWeight(1)
        .margin({ left: 16 })
        .alignItems(HorizontalAlign.Start)

        Column() {
          if (this.plant.daysUntilWater === 0) {
            Text(iconGlyph('check'))
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(BOTANY_ACCENT)
            Text('Water')
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor(BOTANY_ACCENT)
          } else {
            Text(`${this.plant.daysUntilWater} days`)
              .fontSize(10)
              .fontColor(BOTANY_TEXT_SECONDARY)
          }
        }
        .alignItems(HorizontalAlign.End)
      }
      .width('100%')
      .padding(16)
      .backgroundColor(BOTANY_SURFACE)
      .borderRadius(16)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 8, bottom: 8 })
    .onClick(() => {
      animateTo({ duration: 200, curve: Curve.EaseInOut }, () => {
        this.expanded = !this.expanded;
      });
    })
  }
}

// ============================================================
// 7. Bottom Bar
// ============================================================
@Component
struct BotanyBottomBar {
  @Prop selectedTab: number = 0;
  onTabSelected: (index: number) => void = (index: number) => {};

  build() {
    Row() {
      this.NavItem('home', 0)
      this.NavItem('calendar', 1)
      Row().width(32).height(1)
      this.NavItem('bell', 2)
      this.NavItem('gear', 3)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .backgroundColor(BOTANY_WHITE)
  }

  @Builder
  NavItem(name: string, index: number) {
    Column() {
      Text(iconGlyph(name))
        .fontSize(22)
        .fontColor(BOTANY_TEXT_PRIMARY)
        .opacity(this.selectedTab === index ? 1.0 : 0.4)
    }
    .layoutWeight(1)
    .onClick(() => {
      this.onTabSelected(index);
    })
  }
}

// ============================================================
// 8. Main Page
// ============================================================
@Entry
@Component
struct BotanyPage {
  @State tasks: TaskItem[] = [
    new TaskItem(1, 'Watering', 'Monstera Deliciosa', 'calendar', 'Today'),
    new TaskItem(2, 'Fertilize', 'Fiddle Leaf Fig', 'bell', 'Tomorrow'),
    new TaskItem(3, 'Pruning', 'Snake Plant', 'gear', 'Next Week')
  ];

  @State plants: PlantItem[] = [
    new PlantItem(1, 'Monstera', 'Monstera deliciosa', 'Living Room', 0),
    new PlantItem(2, 'Fiddle Leaf', 'Ficus lyrata', 'Bedroom', 2),
    new PlantItem(3, 'Snakey', 'Sansevieria', 'Hallway', 5),
    new PlantItem(4, 'Spider Plant', 'Chlorophytum', 'Kitchen', 1),
    new PlantItem(5, 'Peace Lily', 'Spathiphyllum', 'Bathroom', 3)
  ];

  @State selectedTab: number = 0;

  @Builder
  SectionHeader(title: string) {
    Text(title)
      .fontSize(22)
      .fontWeight(FontWeight.Bold)
      .fontColor(BOTANY_TEXT_PRIMARY)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // ---- Content layer ----
      Column() {
        BotanyTopBar()
          .padding({ left: 24, right: 24, top: 24, bottom: 8 })

        Scroll() {
          Column() {
            // Greeting header
            Column() {
              Text('Good Morning,')
                .fontSize(16)
                .fontColor(BOTANY_TEXT_SECONDARY)
              Text('My Jungle')
                .fontSize(34)
                .fontWeight(FontWeight.Bold)
                .fontColor(BOTANY_TEXT_PRIMARY)
                .letterSpacing(-1)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({ left: 24, right: 24, top: 16, bottom: 16 })

            // Pending tasks
            this.SectionHeader('Pending Tasks')

            Scroll() {
              Row({ space: 16 }) {
                ForEach(this.tasks, (task: TaskItem) => {
                  TaskCard({ task: task })
                }, (task: TaskItem) => task.id.toString())
              }
              .padding({ left: 24, right: 24 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .edgeEffect(EdgeEffect.Spring)
            .width('100%')
            .margin({ bottom: 32 })

            // Plant collection
            this.SectionHeader('Your Collection')

            ForEach(this.plants, (plant: PlantItem) => {
              PlantListItem({ plant: plant })
            }, (plant: PlantItem) => plant.id.toString())
          }
          .width('100%')
          .padding({ bottom: 80 })
        }
        .layoutWeight(1)
        .width('100%')
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BOTANY_WHITE)

      // ---- Floating action button ----
      Row() {
        Blank()
        Button() {
          Text(iconGlyph('plus'))
            .fontSize(28)
            .fontColor(BOTANY_WHITE)
        }
        .width(56)
        .height(56)
        .backgroundColor(BOTANY_TEXT_PRIMARY)
        .borderRadius(28)
        .onClick(() => {
        })
      }
      .width('100%')
      .padding({ left: 24, right: 24, bottom: 96 })

      // ---- Bottom navigation ----
      BotanyBottomBar({
        selectedTab: this.selectedTab,
        onTabSelected: (index: number) => {
          this.selectedTab = index;
        }
      })
        .width('100%')
        .shadow({ radius: 5, color: '#0D000000', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BOTANY_WHITE)
  }
}