const BOTANY_WHITE: string = '#FFFFFF';
const BOTANY_SURFACE: string = '#FAFAFA';
const BOTANY_TEXT_PRIMARY: string = '#1A1C19';
const BOTANY_TEXT_SECONDARY: string = '#757575';
const BOTANY_ACCENT: string = '#2E5E4E';
const BOTANY_GREY: string = '#E0E0E0';
const BOTANY_BORDER: string = '#EEEEEE';
const BOTANY_MUTED: string = '#CCCCCC';

class Plant {
  id: number;
  name: string;
  scientificName: string;
  location: string;
  daysUntilWater: number;
  isHealthy: boolean;

  constructor(
    id: number,
    name: string,
    scientificName: string,
    location: string,
    daysUntilWater: number,
    isHealthy: boolean = true
  ) {
    this.id = id;
    this.name = name;
    this.scientificName = scientificName;
    this.location = location;
    this.daysUntilWater = daysUntilWater;
    this.isHealthy = isHealthy;
  }
}

class PlantTask {
  id: number;
  title: string;
  plantName: string;
  iconName: string;
  urgency: string;

  constructor(id: number, title: string, plantName: string, iconName: string, urgency: string) {
    this.id = id;
    this.title = title;
    this.plantName = plantName;
    this.iconName = iconName;
    this.urgency = urgency;
  }
}

@Entry
@Component
struct BotanyApp {
  private tasks: PlantTask[] = [
    new PlantTask(1, 'Watering', 'Monstera Deliciosa', 'calendar', 'Today'),
    new PlantTask(2, 'Fertilize', 'Fiddle Leaf Fig', 'bell', 'Tomorrow'),
    new PlantTask(3, 'Pruning', 'Snake Plant', 'gear', 'Next Week')
  ];

  private plants: Plant[] = [
    new Plant(1, 'Monstera', 'Monstera deliciosa', 'Living Room', 0),
    new Plant(2, 'Fiddle Leaf', 'Ficus lyrata', 'Bedroom', 2),
    new Plant(3, 'Snakey', 'Sansevieria', 'Hallway', 5),
    new Plant(4, 'Spider Plant', 'Chlorophytum', 'Kitchen', 1),
    new Plant(5, 'Peace Lily', 'Spathiphyllum', 'Bathroom', 3)
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        BotanyTopBar()
          .width('100%')
          .padding({ top: 24, left: 24, right: 24, bottom: 8 })
          .backgroundColor(BOTANY_WHITE)

        Scroll() {
          Column() {
            Column() {
              Text('Good Morning,')
                .fontSize(24)
                .fontColor(BOTANY_TEXT_SECONDARY)
                .fontWeight(FontWeight.Regular)

              Text('My Jungle')
                .fontSize(48)
                .fontWeight(FontWeight.Bold)
                .fontColor(BOTANY_TEXT_PRIMARY)
                .letterSpacing(-1)
                .lineHeight(56)
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding({ left: 24, right: 24, top: 16, bottom: 16 })

            SectionHeader({ title: 'Pending Tasks' })

            Scroll() {
              Row({ space: 16 }) {
                ForEach(this.tasks, (task: PlantTask) => {
                  TaskCard({ task: task })
                }, (task: PlantTask) => task.id.toString())
              }
              .padding({ left: 24, right: 24 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .padding({ bottom: 32 })

            SectionHeader({ title: 'Your Collection' })

            ForEach(this.plants, (plant: Plant) => {
              PlantListItem({ plant: plant })
            }, (plant: Plant) => plant.id.toString())
          }
          .width('100%')
          .padding({ bottom: 96 })
          .alignItems(HorizontalAlign.Start)
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BOTANY_WHITE)

      Row() {
        Blank()
          .layoutWeight(1)

        Stack() {
          Text('+')
            .fontSize(42)
            .fontColor(BOTANY_WHITE)
            .fontWeight(FontWeight.Regular)
            .margin({ bottom: 4 })
        }
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor(BOTANY_TEXT_PRIMARY)
        .onClick(() => {
        })
      }
      .width('100%')
      .padding({ right: 24, bottom: 96 })
      .zIndex(1)

      BotanyBottomBar()
        .width('100%')
        .zIndex(2)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BOTANY_WHITE)
  }
}

@Component
struct SectionHeader {
  @Prop title: string = '';

  build() {
    Text(this.title)
      .fontSize(28)
      .fontWeight(FontWeight.Bold)
      .fontColor(BOTANY_TEXT_PRIMARY)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
  }
}

@Component
struct TaskCard {
  @Prop task: PlantTask = new PlantTask(0, '', '', 'calendar', '');
  @State private checked: boolean = false;

  private taskIcon(): string {
    if (this.task.iconName === 'calendar') {
      return '▦';
    }
    if (this.task.iconName === 'bell') {
      return '♟';
    }
    return '⚙';
  }

  build() {
    Column() {
      Row() {
        Stack() {
          Text(this.taskIcon())
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.checked ? BOTANY_WHITE : BOTANY_TEXT_PRIMARY)
        }
        .width(40)
        .height(40)
        .borderRadius(20)
        .backgroundColor(this.checked ? BOTANY_ACCENT : BOTANY_WHITE)

        Blank()
          .layoutWeight(1)
      }
      .width('100%')

      Blank()
        .layoutWeight(1)

      Column() {
        Text(this.task.title)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(BOTANY_TEXT_PRIMARY)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.task.plantName)
          .fontSize(16)
          .fontColor(BOTANY_TEXT_SECONDARY)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Blank()
          .height(8)

        Text(this.checked ? 'DONE' : this.task.urgency)
          .fontSize(13)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.checked ? BOTANY_WHITE : BOTANY_TEXT_PRIMARY)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .backgroundColor(this.checked ? BOTANY_ACCENT : BOTANY_GREY)
          .borderRadius(4)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width(160)
    .height(180)
    .padding(16)
    .backgroundColor(BOTANY_SURFACE)
    .borderRadius(24)
    .border({
      width: this.checked ? 2 : 1,
      color: this.checked ? BOTANY_ACCENT : BOTANY_BORDER,
      radius: 24
    })
    .onClick(() => {
      this.checked = !this.checked;
    })
  }
}

@Component
struct PlantListItem {
  @Prop plant: Plant = new Plant(0, '', '', '', 0);
  @State private expanded: boolean = false;

  build() {
    Row() {
      Stack() {
        Text('♥')
          .fontSize(28)
          .fontColor(this.plant.daysUntilWater === 0 ? BOTANY_ACCENT : BOTANY_MUTED)
      }
      .width(56)
      .height(56)
      .borderRadius(12)
      .backgroundColor(BOTANY_BORDER)

      Blank()
        .width(16)

      Column() {
        Text(this.plant.name)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(BOTANY_TEXT_PRIMARY)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.plant.scientificName)
          .fontSize(16)
          .fontColor(BOTANY_TEXT_SECONDARY)
          .fontStyle(FontStyle.Italic)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        if (this.expanded) {
          Blank()
            .height(8)

          Row() {
            Text('⌖')
              .fontSize(12)
              .fontColor(BOTANY_TEXT_SECONDARY)

            Blank()
              .width(4)

            Text(this.plant.location)
              .fontSize(12)
              .fontColor(BOTANY_TEXT_SECONDARY)
          }
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column() {
        if (this.plant.daysUntilWater === 0) {
          Stack() {
            Text('✓')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(BOTANY_WHITE)
          }
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor(BOTANY_ACCENT)

          Text('Water')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(BOTANY_ACCENT)
        } else {
          Text(this.plant.daysUntilWater.toString() + ' days')
            .fontSize(12)
            .fontColor(BOTANY_TEXT_SECONDARY)
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .alignItems(VerticalAlign.Center)
    .width('calc(100% - 48vp)')
    .padding(16)
    .margin({ left: 24, right: 24, top: 8, bottom: 8 })
    .backgroundColor(BOTANY_SURFACE)
    .borderRadius(16)
    .onClick(() => {
      this.expanded = !this.expanded;
    })
  }
}

@Component
struct BotanyTopBar {
  build() {
    Row() {
      Stack() {
        Text('☰')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(BOTANY_TEXT_PRIMARY)
          .margin({ bottom: 2 })
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(BOTANY_SURFACE)
      .onClick(() => {
      })

      Blank()
        .layoutWeight(1)

      Stack() {
        Text('⌕')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(BOTANY_TEXT_PRIMARY)
          .margin({ bottom: 2 })
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(BOTANY_SURFACE)
      .onClick(() => {
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BotanyBottomBar {
  @State private selectedTab: number = 0;

  build() {
    Row() {
      BotanyNavItem({ icon: '⌂', selected: this.selectedTab === 0 })
        .layoutWeight(1)
        .onClick(() => {
          this.selectedTab = 0;
        })

      BotanyNavItem({ icon: '▦', selected: this.selectedTab === 1 })
        .layoutWeight(1)
        .onClick(() => {
          this.selectedTab = 1;
        })

      Blank()
        .width(32)

      BotanyNavItem({ icon: '♟', selected: this.selectedTab === 2 })
        .layoutWeight(1)
        .onClick(() => {
          this.selectedTab = 2;
        })

      BotanyNavItem({ icon: '⚙', selected: this.selectedTab === 3 })
        .layoutWeight(1)
        .onClick(() => {
          this.selectedTab = 3;
        })
    }
    .width('100%')
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .backgroundColor(BOTANY_WHITE)
    .shadow({
      radius: 10,
      color: 'rgba(0, 0, 0, 0.05)',
      offsetX: 0,
      offsetY: -2
    })
  }
}

@Component
struct BotanyNavItem {
  @Prop icon: string = '';
  @Prop selected: boolean = false;

  build() {
    Stack() {
      Text(this.icon)
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(BOTANY_TEXT_PRIMARY)
        .opacity(this.selected ? 1.0 : 0.4)
    }
    .height(40)
    .width('100%')
  }
}