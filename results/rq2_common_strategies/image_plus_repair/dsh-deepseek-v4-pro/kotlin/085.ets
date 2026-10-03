// Translated from Kotlin/Jetpack Compose to ArkTS/ArkUI
// File: 085.ets

// --- Data Models ---
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
  icon: string;
  urgency: string;
}

// --- Color Palette (Strictly minimal/white based) ---
const BOTANY_WHITE: string = '#FFFFFF';
const BOTANY_SURFACE: string = '#FAFAFA';
const BOTANY_TEXT_PRIMARY: string = '#1A1C19';
const BOTANY_TEXT_SECONDARY: string = '#757575';
const BOTANY_ACCENT: string = '#2E5E4E';
const BOTANY_ACCENT_LIGHT: string = '#E8F5E9';
const BOTANY_BORDER: string = '#EEEEEE';
const BOTANY_CHIP_GREY: string = '#E0E0E0';
const BOTANY_GREY_ICON: string = '#CCCCCC';

@Entry
@Component
struct BotanyPage {
  private tasks: Task[] = [
    { id: 1, title: 'Watering', plantName: 'Monstera Deliciosa', icon: '📅', urgency: 'Today' },
    { id: 2, title: 'Fertilize', plantName: 'Fiddle Leaf Fig', icon: '🔔', urgency: 'Tomorrow' },
    { id: 3, title: 'Pruning', plantName: 'Snake Plant', icon: '⚙', urgency: 'Next Week' }
  ];

  private plants: Plant[] = [
    { id: 1, name: 'Monstera', scientificName: 'Monstera deliciosa', location: 'Living Room', daysUntilWater: 0, isHealthy: true },
    { id: 2, name: 'Fiddle Leaf', scientificName: 'Ficus lyrata', location: 'Bedroom', daysUntilWater: 2, isHealthy: true },
    { id: 3, name: 'Snakey', scientificName: 'Sansevieria', location: 'Hallway', daysUntilWater: 5, isHealthy: true },
    { id: 4, name: 'Spider Plant', scientificName: 'Chlorophytum', location: 'Kitchen', daysUntilWater: 1, isHealthy: true },
    { id: 5, name: 'Peace Lily', scientificName: 'Spathiphyllum', location: 'Bathroom', daysUntilWater: 3, isHealthy: true }
  ];

  @Builder
  SectionHeader(title: string) {
    Text(title)
      .fontSize(16)
      .fontWeight(FontWeight.Bold)
      .fontColor(BOTANY_TEXT_PRIMARY)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
  }

  @Builder
  BotanyTopBar() {
    Row() {
      Stack() {
        Text('☰')
          .fontSize(20)
          .fontColor(BOTANY_TEXT_PRIMARY)
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(BOTANY_SURFACE)
      .alignContent(Alignment.Center)
      .onClick(() => {})

      Stack() {
        Text('🔍')
          .fontSize(20)
          .fontColor(BOTANY_TEXT_PRIMARY)
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(BOTANY_SURFACE)
      .alignContent(Alignment.Center)
      .onClick(() => {})
    }
    .width('100%')
    .padding({ top: 24, left: 24, right: 24, bottom: 8 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BotanyNavItem(icon: string, isSelected: boolean) {
    Stack() {
      Text(icon)
        .fontSize(24)
        .fontColor(BOTANY_TEXT_PRIMARY)
        .opacity(isSelected ? 1 : 0.4)
    }
    .onClick(() => {})
  }

  @Builder
  BotanyBottomBar() {
    Row() {
      this.BotanyNavItem('🏠', true)
      this.BotanyNavItem('📅', false)
      Blank().width(32)
      this.BotanyNavItem('🔔', false)
      this.BotanyNavItem('⚙', false)
    }
    .width('100%')
    .backgroundColor(BOTANY_WHITE)
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BotanyFab() {
    Stack() {
      Text('+')
        .fontSize(24)
        .fontColor(BOTANY_WHITE)
    }
    .width(56)
    .height(56)
    .borderRadius(28)
    .backgroundColor(BOTANY_TEXT_PRIMARY)
    .alignContent(Alignment.Center)
    .margin({ right: 16, bottom: 96 })
    .onClick(() => {})
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.BotanyTopBar()

        Scroll() {
          Column() {
            Column() {
              Text('Good Morning,')
                .fontSize(16)
                .fontColor(BOTANY_TEXT_SECONDARY)
              Text('My Jungle')
                .fontSize(40)
                .fontWeight(FontWeight.Bold)
                .fontColor(BOTANY_TEXT_PRIMARY)
                .letterSpacing(-1)
            }
            .alignItems(HorizontalAlign.Start)
            .padding({ left: 24, right: 24, top: 16, bottom: 16 })

            this.SectionHeader('Pending Tasks')

            Scroll() {
              Row({ space: 16 }) {
                ForEach(this.tasks, (task: Task) => {
                  TaskCard({ task: task })
                }, (task: Task) => task.id.toString())
              }
              .padding({ left: 24, right: 24 })
            }
            .width('100%')
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)

            Blank().height(32)

            this.SectionHeader('Your Collection')

            ForEach(this.plants, (plant: Plant) => {
              PlantListItem({ plant: plant })
            }, (plant: Plant) => plant.id.toString())
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ bottom: 80 })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)

        this.BotanyBottomBar()
      }
      .width('100%')
      .height('100%')

      this.BotanyFab()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BOTANY_WHITE)
  }
}

@Component
struct TaskCard {
  task: Task = { id: 0, title: '', plantName: '', icon: '', urgency: '' };
  @State isChecked: boolean = false;

  build() {
    Column() {
      Stack() {
        Text(this.task.icon)
          .fontSize(20)
          .fontColor(this.isChecked ? BOTANY_WHITE : BOTANY_TEXT_PRIMARY)
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(this.isChecked ? BOTANY_ACCENT : BOTANY_WHITE)
      .alignContent(Alignment.Center)

      Column() {
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
          .fontSize(11)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? BOTANY_WHITE : BOTANY_TEXT_PRIMARY)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .backgroundColor(this.isChecked ? BOTANY_ACCENT : BOTANY_CHIP_GREY)
          .borderRadius(4)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width(160)
    .height(180)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(BOTANY_SURFACE)
    .borderRadius(24)
    .border({ width: this.isChecked ? 2 : 1, color: this.isChecked ? BOTANY_ACCENT : BOTANY_BORDER })
    .onClick(() => { this.isChecked = !this.isChecked })
  }
}

@Component
struct PlantListItem {
  plant: Plant = { id: 0, name: '', scientificName: '', location: '', daysUntilWater: 0, isHealthy: true };
  @State expanded: boolean = false;

  build() {
    Row() {
      Row() {
        Stack() {
          Text('♥')
            .fontSize(20)
            .fontColor(this.plant.daysUntilWater === 0 ? BOTANY_ACCENT : BOTANY_GREY_ICON)
        }
        .width(56)
        .height(56)
        .borderRadius(12)
        .backgroundColor(BOTANY_BORDER)
        .alignContent(Alignment.Center)

        Blank().width(16)

        Column() {
          Text(this.plant.name)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(BOTANY_TEXT_PRIMARY)
          Text(this.plant.scientificName)
            .fontSize(12)
            .fontStyle(FontStyle.Italic)
            .fontColor(BOTANY_TEXT_SECONDARY)

          if (this.expanded) {
            Blank().height(8)
            Row() {
              Text('📍')
                .fontSize(12)
                .fontColor(BOTANY_TEXT_SECONDARY)
              Blank().width(4)
              Text(this.plant.location)
                .fontSize(11)
                .fontColor(BOTANY_TEXT_SECONDARY)
            }
            .alignItems(VerticalAlign.Center)
          }
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Column() {
          if (this.plant.daysUntilWater === 0) {
            Text('✓')
              .fontSize(24)
              .fontColor(BOTANY_ACCENT)
            Text('Water')
              .fontSize(11)
              .fontWeight(FontWeight.Bold)
              .fontColor(BOTANY_ACCENT)
          } else {
            Text(this.plant.daysUntilWater.toString() + ' days')
              .fontSize(11)
              .fontColor(BOTANY_TEXT_SECONDARY)
          }
        }
        .alignItems(HorizontalAlign.End)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .padding(16)
      .borderRadius(16)
      .backgroundColor(BOTANY_SURFACE)
      .onClick(() => { this.expanded = !this.expanded })
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 8, bottom: 8 })
  }
}
