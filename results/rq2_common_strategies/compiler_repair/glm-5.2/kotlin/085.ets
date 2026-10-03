// Index.ets

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
  icon: Resource;
  urgency: string;
}

const BotanyWhite: string = '#FFFFFF';
const BotanySurface: string = '#FAFAFA';
const BotanyTextPrimary: string = '#1A1C19';
const BotanyTextSecondary: string = '#757575';
const BotanyAccent: string = '#2E5E4E';
const BotanyAccentLight: string = '#E8F5E9';
const BotanyBorderLight: string = '#EEEEEE';
const BotanyChipBg: string = '#E0E0E0';

@Entry
@Component
struct BotanyApp {
  @State tasks: Task[] = [
    { id: 1, title: 'Watering', plantName: 'Monstera Deliciosa', icon: $r('sys.media.ohos_ic_public_clock'), urgency: 'Today' },
    { id: 2, title: 'Fertilize', plantName: 'Fiddle Leaf Fig', icon: $r('sys.media.ohos_ic_public_clock'), urgency: 'Tomorrow' },
    { id: 3, title: 'Pruning', plantName: 'Snake Plant', icon: $r('sys.media.ohos_ic_public_clock'), urgency: 'Next Week' }
  ];

  @State plants: Plant[] = [
    { id: 1, name: 'Monstera', scientificName: 'Monstera deliciosa', location: 'Living Room', daysUntilWater: 0, isHealthy: true },
    { id: 2, name: 'Fiddle Leaf', scientificName: 'Ficus lyrata', location: 'Bedroom', daysUntilWater: 2, isHealthy: true },
    { id: 3, name: 'Snakey', scientificName: 'Sansevieria', location: 'Hallway', daysUntilWater: 5, isHealthy: true },
    { id: 4, name: 'Spider Plant', scientificName: 'Chlorophytum', location: 'Kitchen', daysUntilWater: 1, isHealthy: true },
    { id: 5, name: 'Peace Lily', scientificName: 'Spathiphyllum', location: 'Bathroom', daysUntilWater: 3, isHealthy: true }
  ];

  @State checkedTasks: boolean[] = [false, false, false];
  @State expandedPlants: boolean[] = [false, false, false, false, false];

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        // Top Bar
        Row() {
          this.CircleButton($r('sys.media.ohos_ic_public_drawer'))
          this.CircleButton($r('sys.media.ohos_ic_public_search'))
        }
        .width('100%')
        .padding({ top: 48, left: 24, right: 24, bottom: 16 })
        .justifyContent(FlexAlign.SpaceBetween)

        // Content
        Scroll() {
          Column() {
            // Header
            Column() {
              Text('Good Morning,')
                .fontSize(16)
                .fontColor(BotanyTextSecondary)
              Text('My Jungle')
                .fontSize(48)
                .fontWeight(FontWeight.Bold)
                .fontColor(BotanyTextPrimary)
                .letterSpacing(-1)
            }
            .width('100%')
            .padding({ left: 24, right: 24, top: 16, bottom: 16 })
            .alignItems(HorizontalAlign.Start)

            // Pending Tasks
            Text('Pending Tasks')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(BotanyTextPrimary)
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })

            // Tasks List
            Scroll() {
              Row({ space: 16 }) {
                ForEach(this.tasks, (task: Task, index: number) => {
                  this.TaskCard(task, index)
                })
              }
              .padding({ left: 24, right: 24 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            Blank().height(32)

            // Collection Header
            Text('Your Collection')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(BotanyTextPrimary)
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })

            // Plants List
            ForEach(this.plants, (plant: Plant, index: number) => {
              this.PlantListItem(plant, index)
            })
          }
          .width('100%')
          .padding({ bottom: 100 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .align(Alignment.Top)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BotanyWhite)

      // FAB
      Button() {
        Image($r('sys.media.ohos_ic_public_add'))
          .width(24)
          .height(24)
          .fillColor(BotanyWhite)
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor(BotanyTextPrimary)
      .margin({ bottom: 96, right: 24 })

      // Bottom Bar
      Row() {
        this.NavItem($r('sys.media.ohos_ic_public_user'), true)
        this.NavItem($r('sys.media.ohos_ic_public_clock'), false)
        Blank().width(32)
        this.NavItem($r('sys.media.ohos_ic_public_comments'), false)
        this.NavItem($r('sys.media.ohos_ic_public_compass'), false)
      }
      .width('100%')
      .padding({ left: 48, right: 48, top: 24, bottom: 48 })
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor(BotanyWhite)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  CircleButton(icon: Resource) {
    Button() {
      Image(icon)
        .width(20)
        .height(20)
        .fillColor(BotanyTextPrimary)
    }
    .width(40)
    .height(40)
    .borderRadius(20)
    .backgroundColor(BotanySurface)
  }

  @Builder
  TaskCard(task: Task, index: number) {
    Column() {
      Row() {
        Column() {
          Image(task.icon)
            .width(20)
            .height(20)
            .fillColor(this.checkedTasks[index] ? BotanyWhite : BotanyTextPrimary)
        }
        .width(40)
        .height(40)
        .borderRadius(20)
        .backgroundColor(this.checkedTasks[index] ? BotanyAccent : BotanyWhite)
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.End)

      Blank()

      Column() {
        Text(task.title)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyTextPrimary)
        Text(task.plantName)
          .fontSize(12)
          .fontColor(BotanyTextSecondary)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Blank().height(8)

        Text(this.checkedTasks[index] ? 'DONE' : task.urgency)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.checkedTasks[index] ? BotanyWhite : BotanyTextPrimary)
          .backgroundColor(this.checkedTasks[index] ? BotanyAccent : BotanyChipBg)
          .borderRadius(4)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width(160)
    .height(180)
    .padding(16)
    .borderRadius(24)
    .backgroundColor(BotanySurface)
    .border({ width: this.checkedTasks[index] ? 2 : 1, color: this.checkedTasks[index] ? BotanyAccent : BotanyBorderLight })
    .onClick(() => {
      this.checkedTasks[index] = !this.checkedTasks[index];
    })
  }

  @Builder
  PlantListItem(plant: Plant, index: number) {
    Row() {
      Column() {
        Image($r('sys.media.ohos_ic_public_heart'))
          .width(24)
          .height(24)
          .fillColor(plant.daysUntilWater === 0 ? BotanyAccent : '#CCCCCC')
      }
      .width(56)
      .height(56)
      .borderRadius(12)
      .backgroundColor(BotanyBorderLight)
      .justifyContent(FlexAlign.Center)

      Blank().width(16)

      Column() {
        Text(plant.name)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyTextPrimary)
        Text(plant.scientificName)
          .fontSize(12)
          .fontColor(BotanyTextSecondary)
          .fontStyle(FontStyle.Italic)

        if (this.expandedPlants[index]) {
          Blank().height(8)
          Row() {
            Image($r('sys.media.ohos_ic_public_location'))
              .width(12)
              .height(12)
              .fillColor(BotanyTextSecondary)
            Blank().width(4)
            Text(plant.location)
              .fontSize(10)
              .fontColor(BotanyTextSecondary)
          }
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Column() {
        if (plant.daysUntilWater === 0) {
          Image($r('sys.media.ohos_ic_public_ok'))
            .width(24)
            .height(24)
            .fillColor(BotanyAccent)
          Text('Water')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(BotanyAccent)
        } else {
          Text(`${plant.daysUntilWater} days`)
            .fontSize(10)
            .fontColor(BotanyTextSecondary)
        }
      }
    }
    .width('100%')
    .padding(16)
    .borderRadius(16)
    .backgroundColor(BotanySurface)
    .margin({ left: 24, right: 24, top: 8, bottom: 8 })
    .onClick(() => {
      this.expandedPlants[index] = !this.expandedPlants[index];
    })
  }

  @Builder
  NavItem(icon: Resource, isSelected: boolean) {
    Column() {
      Image(icon)
        .width(24)
        .height(24)
        .fillColor(BotanyTextPrimary)
        .opacity(isSelected ? 1.0 : 0.4)
    }
  }
}