class Plant {
  id: number;
  name: string;
  scientificName: string;
  location: string;
  daysUntilWater: number;
  expanded: boolean;

  constructor(id: number, name: string, scientificName: string, location: string, daysUntilWater: number) {
    this.id = id;
    this.name = name;
    this.scientificName = scientificName;
    this.location = location;
    this.daysUntilWater = daysUntilWater;
    this.expanded = false;
  }
}

class CareTask {
  id: number;
  title: string;
  plantName: string;
  icon: string;
  urgency: string;
  checked: boolean;

  constructor(id: number, title: string, plantName: string, icon: string, urgency: string) {
    this.id = id;
    this.title = title;
    this.plantName = plantName;
    this.icon = icon;
    this.urgency = urgency;
    this.checked = false;
  }
}

@Entry
@Component
struct MainActivity {
  @State tasks: CareTask[] = [
    new CareTask(1, 'Watering', 'Monstera Deliciosa', '▣', 'Today'),
    new CareTask(2, 'Fertilize', 'Fiddle Leaf Fig', '!', 'Tomorrow'),
    new CareTask(3, 'Pruning', 'Snake Plant', '⚙', 'Next Week')
  ];
  @State plants: Plant[] = [
    new Plant(1, 'Monstera', 'Monstera deliciosa', 'Living Room', 0),
    new Plant(2, 'Fiddle Leaf', 'Ficus lyrata', 'Bedroom', 2),
    new Plant(3, 'Snakey', 'Sansevieria', 'Hallway', 5),
    new Plant(4, 'Spider Plant', 'Chlorophytum', 'Kitchen', 1),
    new Plant(5, 'Peace Lily', 'Spathiphyllum', 'Bathroom', 3)
  ];

  private toggleTask(index: number): void {
    this.tasks[index].checked = !this.tasks[index].checked;
    this.tasks = [...this.tasks];
  }

  private togglePlant(index: number): void {
    this.plants[index].expanded = !this.plants[index].expanded;
    this.plants = [...this.plants];
  }

  @Builder
  TopBar() {
    Row() {
      Text('≡')
        .fontSize(22)
        .fontColor('#1A1C19')
        .textAlign(TextAlign.Center)
        .width(40)
        .height(40)
        .lineHeight(40)
        .backgroundColor('#FAFAFA')
        .borderRadius(20)
      Text('⌕')
        .fontSize(22)
        .fontColor('#1A1C19')
        .textAlign(TextAlign.Center)
        .width(40)
        .height(40)
        .lineHeight(40)
        .backgroundColor('#FAFAFA')
        .borderRadius(20)
    }
    .width('100%')
    .padding({ top: 24, left: 24, right: 24, bottom: 8 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
  }

  @Builder
  SectionHeader(title: string) {
    Text(title)
      .fontSize(16)
      .fontWeight(FontWeight.Bold)
      .fontColor('#1A1C19')
      .width('100%')
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
  }

  @Builder
  TaskCard(task: CareTask, index: number) {
    Column() {
      Row() {
        Text(task.icon)
          .fontSize(20)
          .fontColor(task.checked ? '#FFFFFF' : '#1A1C19')
          .textAlign(TextAlign.Center)
          .width(40)
          .height(40)
          .lineHeight(40)
          .backgroundColor(task.checked ? '#2E5E4E' : '#FFFFFF')
          .borderRadius(20)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Column() {
        Text(task.title)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1C19')
        Text(task.plantName)
          .fontSize(12)
          .fontColor('#757575')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Text(task.checked ? 'DONE' : task.urgency)
          .fontSize(11)
          .fontWeight(FontWeight.Bold)
          .fontColor(task.checked ? '#FFFFFF' : '#1A1C19')
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .backgroundColor(task.checked ? '#2E5E4E' : '#E0E0E0')
          .borderRadius(4)
          .margin({ top: 8 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width(160)
    .height(180)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#FAFAFA')
    .borderRadius(24)
    .border({ width: task.checked ? 2 : 1, color: task.checked ? '#2E5E4E' : '#EEEEEE' })
    .onClick(() => {
      this.toggleTask(index);
    })
  }

  @Builder
  PlantListItem(plant: Plant, index: number) {
    Row() {
      Text('♥')
        .fontSize(24)
        .fontColor(plant.daysUntilWater === 0 ? '#2E5E4E' : '#CCCCCC')
        .textAlign(TextAlign.Center)
        .width(56)
        .height(56)
        .lineHeight(56)
        .backgroundColor('#EEEEEE')
        .borderRadius(12)

      Column() {
        Text(plant.name)
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1C19')
        Text(plant.scientificName)
          .fontSize(12)
          .fontStyle(FontStyle.Italic)
          .fontColor('#757575')
        if (plant.expanded) {
          Row({ space: 4 }) {
            Text('⌖')
              .fontSize(12)
              .fontColor('#757575')
            Text(plant.location)
              .fontSize(11)
              .fontColor('#757575')
          }
          .margin({ top: 8 })
          .alignItems(VerticalAlign.Center)
        }
      }
      .layoutWeight(1)
      .margin({ left: 16 })
      .alignItems(HorizontalAlign.Start)

      Column() {
        if (plant.daysUntilWater === 0) {
          Text('✓')
            .fontSize(24)
            .fontColor('#2E5E4E')
          Text('Water')
            .fontSize(11)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E5E4E')
        } else {
          Text(`${plant.daysUntilWater} days`)
            .fontSize(11)
            .fontColor('#757575')
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FAFAFA')
    .borderRadius(16)
    .margin({ left: 24, right: 24, top: 8, bottom: 8 })
    .onClick(() => {
      this.togglePlant(index);
    })
  }

  @Builder
  BottomBar() {
    Row() {
      Text('⌂').fontSize(22).fontColor('#1A1C19')
      Text('▣').fontSize(22).fontColor('#661A1C19')
      Blank().width(32)
      Text('!').fontSize(22).fontColor('#661A1C19')
      Text('⚙').fontSize(22).fontColor('#661A1C19')
    }
    .width('100%')
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.TopBar()
        Scroll() {
          Column() {
            Column() {
              Text('Good Morning,')
                .fontSize(16)
                .fontColor('#757575')
              Text('My Jungle')
                .fontSize(40)
                .fontWeight(FontWeight.Bold)
                .fontColor('#1A1C19')
            }
            .width('100%')
            .padding({ left: 24, right: 24, top: 16, bottom: 16 })
            .alignItems(HorizontalAlign.Start)

            this.SectionHeader('Pending Tasks')
            Row({ space: 16 }) {
              ForEach(this.tasks, (task: CareTask, index: number) => {
                this.TaskCard(task, index)
              })
            }
            .padding({ left: 24, right: 24 })
            .width('100%')

            Blank().height(32)
            this.SectionHeader('Your Collection')
            ForEach(this.plants, (plant: Plant, index: number) => {
              this.PlantListItem(plant, index)
            })
            Blank().height(80)
          }
          .width('100%')
        }
        .layoutWeight(1)
        .width('100%')
        .scrollBar(BarState.Off)
        this.BottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      Text('+')
        .fontSize(28)
        .fontColor('#FFFFFF')
        .textAlign(TextAlign.Center)
        .width(56)
        .height(56)
        .lineHeight(56)
        .backgroundColor('#1A1C19')
        .borderRadius(28)
        .margin({ right: 24, bottom: 28 })
    }
    .width('100%')
    .height('100%')
  }
}
