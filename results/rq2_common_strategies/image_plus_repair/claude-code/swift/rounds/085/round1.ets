@Entry
@Component
struct BotanyApp {
  @State selectedTab: number = 0;
  @State taskChecked: boolean[] = [false, false, false];
  @State plantExpanded: boolean[] = [false, false, false, false, false];

  private tasks: Task[] = [
    { id: 1, title: 'Watering', plantName: 'Monstera Deliciosa', icon: '🗓', urgency: 'Today' },
    { id: 2, title: 'Fertilize', plantName: 'Fiddle Leaf Fig', icon: '🔔', urgency: 'Tomorrow' },
    { id: 3, title: 'Pruning', plantName: 'Snake Plant', icon: '⚙', urgency: 'Next Week' }
  ];

  private plants: Plant[] = [
    { id: 1, name: 'Monstera', scientificName: 'Monstera deliciosa', location: 'Living Room', daysUntilWater: 0 },
    { id: 2, name: 'Fiddle Leaf', scientificName: 'Ficus lyrata', location: 'Bedroom', daysUntilWater: 2 },
    { id: 3, name: 'Snakey', scientificName: 'Sansevieria', location: 'Hallway', daysUntilWater: 5 },
    { id: 4, name: 'Spider Plant', scientificName: 'Chlorophytum', location: 'Kitchen', daysUntilWater: 1 },
    { id: 5, name: 'Peace Lily', scientificName: 'Spathiphyllum', location: 'Bathroom', daysUntilWater: 3 }
  ];

  build() {
    Stack() {
      Column() {
        this.BotanyTopBar()

        Scroll() {
          Column() {
            Column() {
              Text('Good Morning,')
                .fontSize(16)
                .fontColor('#757575')
              Text('My Jungle')
                .fontSize(36)
                .fontWeight(FontWeight.Bold)
                .fontColor('#1A1C19')
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({ left: 24, right: 24, top: 16, bottom: 16 })

            this.SectionHeader('Pending Tasks')

            Scroll() {
              Row() {
                ForEach(this.tasks, (task: Task, index: number) => {
                  this.TaskCard(task, index)
                }, (task: Task) => task.id.toString())
              }
              .padding({ left: 24, right: 24 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .margin({ bottom: 32 })

            this.SectionHeader('Your Collection')

            ForEach(this.plants, (plant: Plant, index: number) => {
              this.PlantListItem(plant, index)
            }, (plant: Plant) => plant.id.toString())
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ bottom: 80 })
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      // FAB
      Column() {
        Blank()
        Row() {
          Blank()
          Button() {
            Text('+')
              .fontSize(32)
              .fontColor(Color.White)
          }
          .width(56)
          .height(56)
          .backgroundColor('#1A1C19')
          .borderRadius(28)
          .margin({ right: 24, bottom: 96 })
        }
      }
      .width('100%')
      .height('100%')

      // Bottom Bar
      Column() {
        Blank()
        this.BotanyBottomBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  BotanyTopBar() {
    Row() {
      Button() {
        Text('☰')
          .fontSize(20)
          .fontColor('#1A1C19')
      }
      .width(40)
      .height(40)
      .backgroundColor('#FAFAFA')
      .borderRadius(20)

      Blank()

      Button() {
        Text('⌕')
          .fontSize(22)
          .fontColor('#1A1C19')
      }
      .width(40)
      .height(40)
      .backgroundColor('#FAFAFA')
      .borderRadius(20)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 8 })
    .backgroundColor('#FFFFFF')
  }

  @Builder
  SectionHeader(title: string) {
    Text(title)
      .fontSize(22)
      .fontWeight(FontWeight.Bold)
      .fontColor('#1A1C19')
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
  }

  @Builder
  TaskCard(task: Task, index: number) {
    Column() {
      Row() {
        Stack() {
          Column()
            .width(40)
            .height(40)
            .borderRadius(20)
            .backgroundColor(this.taskChecked[index] ? '#2E5E4E' : '#FFFFFF')
          Text(task.icon)
            .fontSize(20)
            .fontColor(this.taskChecked[index] ? '#FFFFFF' : '#1A1C19')
        }
        Blank()
      }

      Blank()

      Column() {
        Text(task.title)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1C19')
        Text(task.plantName)
          .fontSize(12)
          .fontColor('#757575')
          .maxLines(1)
          .textOverflow(TextOverflow.Ellipsis)

        Blank()
          .height(8)

        Text(this.taskChecked[index] ? 'DONE' : task.urgency)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.taskChecked[index] ? '#FFFFFF' : '#1A1C19')
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .backgroundColor(this.taskChecked[index] ? '#2E5E4E' : '#E0E0E0')
          .borderRadius(4)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width(160)
    .height(180)
    .padding(16)
    .backgroundColor('#FAFAFA')
    .borderRadius(24)
    .border({
      width: this.taskChecked[index] ? 2 : 1,
      color: this.taskChecked[index] ? '#2E5E4E' : '#EEEEEE'
    })
    .margin({ right: index < this.tasks.length - 1 ? 16 : 0 })
    .onClick(() => {
      this.taskChecked[index] = !this.taskChecked[index];
    })
  }

  @Builder
  PlantListItem(plant: Plant, index: number) {
    Row() {
      Stack() {
        Column()
          .width(56)
          .height(56)
          .borderRadius(12)
          .backgroundColor('#EEEEEE')
        Text('♥')
          .fontSize(24)
          .fontColor(plant.daysUntilWater === 0 ? '#2E5E4E' : '#CCCCCC')
      }
      .width(56)
      .height(56)

      Blank()
        .width(16)

      Column() {
        Text(plant.name)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1C19')
        Text(plant.scientificName)
          .fontSize(12)
          .fontColor('#757575')
          .fontStyle(FontStyle.Italic)

        if (this.plantExpanded[index]) {
          Blank()
            .height(8)
          Row() {
            Text('◉')
              .fontSize(12)
              .fontColor('#757575')
            Blank()
              .width(4)
            Text(plant.location)
              .fontSize(10)
              .fontColor('#757575')
          }
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column() {
        if (plant.daysUntilWater === 0) {
          Text('✓')
            .fontSize(24)
            .fontColor('#2E5E4E')
          Text('Water')
            .fontSize(10)
            .fontColor('#2E5E4E')
            .fontWeight(FontWeight.Bold)
        } else {
          Text(plant.daysUntilWater + ' days')
            .fontSize(10)
            .fontColor('#757575')
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FAFAFA')
    .borderRadius(16)
    .margin({ left: 24, right: 24, top: 8, bottom: 8 })
    .onClick(() => {
      this.plantExpanded[index] = !this.plantExpanded[index];
    })
  }

  @Builder
  BotanyBottomBar() {
    Row() {
      this.BotanyNavItem('⌂', this.selectedTab === 0)
        .onClick(() => { this.selectedTab = 0; })
      this.BotanyNavItem('▦', this.selectedTab === 1)
        .onClick(() => { this.selectedTab = 1; })
      Blank()
        .width(32)
      this.BotanyNavItem('♪', this.selectedTab === 2)
        .onClick(() => { this.selectedTab = 2; })
      this.BotanyNavItem('⚙', this.selectedTab === 3)
        .onClick(() => { this.selectedTab = 3; })
    }
    .width('100%')
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 5, color: 'rgba(0,0,0,0.05)', offsetX: 0, offsetY: -2 })
  }

  @Builder
  BotanyNavItem(icon: string, isSelected: boolean) {
    Text(icon)
      .fontSize(24)
      .fontColor('#1A1C19')
      .opacity(isSelected ? 1.0 : 0.4)
      .layoutWeight(1)
      .textAlign(TextAlign.Center)
  }
}

interface Task {
  id: number;
  title: string;
  plantName: string;
  icon: string;
  urgency: string;
}

interface Plant {
  id: number;
  name: string;
  scientificName: string;
  location: string;
  daysUntilWater: number;
}
