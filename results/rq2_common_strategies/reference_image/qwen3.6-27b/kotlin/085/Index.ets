@Entry
@Component
struct BotanyApp {
  @State tasks: Task[] = [
    { id: 1, title: 'Watering', plantName: 'Monstera Deliciosa', icon: $r('app.media.ic_date_range'), urgency: 'Today' },
    { id: 2, title: 'Fertilize', plantName: 'Fiddle Leaf Fig', icon: $r('app.media.ic_notifications'), urgency: 'Tomorrow' }
  ];

  @State plants: Plant[] = [
    { id: 1, name: 'Monstera', scientificName: 'Monstera deliciosa', location: 'Living Room', daysUntilWater: 0 },
    { id: 2, name: 'Fiddle Leaf', scientificName: 'Ficus lyrata', location: 'Bedroom', daysUntilWater: 2 },
    { id: 3, name: 'Snakey', scientificName: 'Sansevieria', location: 'Hallway', daysUntilWater: 5 }
  ];

  build() {
    Column() {
      // Top Bar
      Row() {
        Button('', { type: ButtonType.Circle })
          .width(48)
          .height(48)
          .backgroundColor('#FAFAFA')
          .borderWidth(0)
          .fontColor(Color.Black)
          .icon($r('app.media.ic_menu'))
          .margin({ right: 'auto' })

        Button('', { type: ButtonType.Circle })
          .width(48)
          .height(48)
          .backgroundColor('#FAFAFA')
          .borderWidth(0)
          .fontColor(Color.Black)
          .icon($r('app.media.ic_search'))
      }
      .width('100%')
      .padding({ top: 20, bottom: 10 })

      // Header Text
      Column() {
        Text('Good Morning,')
          .fontSize(18)
          .fontColor('#757575')
          .fontWeight(FontWeight.Normal)
        
        Text('My Jungle')
          .fontSize(48)
          .fontColor('#1A1C19')
          .fontWeight(FontWeight.Bold)
          .letterSpacing(-1)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .padding({ left: 24, right: 24, top: 10, bottom: 20 })

      // Scrollable Content
      Scroll() {
        Column() {
          // Pending Tasks Section
          Text('Pending Tasks')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1A1C19')
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ left: 24, right: 24, bottom: 16 })

          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            ForEach(this.tasks, (task: Task) => {
              TaskCard(task)
            })
          }
          .width('100%')
          .padding({ left: 24, right: 24, bottom: 32 })

          // Collection Section
          Text('Your Collection')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1A1C19')
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ left: 24, right: 24, bottom: 16 })

          ForEach(this.plants, (plant: Plant) => {
            PlantListItem(plant)
          })
          
          // Spacer for Bottom Bar and FAB
          Blank().height(120)
        }
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Floating Action Button
      Button('+', { type: ButtonType.Circle })
        .width(56)
        .height(56)
        .backgroundColor('#1A1C19')
        .fontColor(Color.White)
        .fontSize(32)
        .position({ x: 'calc(100% - 60px)', y: 'calc(100% - 110px)' })
        .shadow({ radius: 10, color: '#00000020', offsetY: 4 })

      // Bottom Navigation
      Row() {
        NavItem($r('app.media.ic_home'), true)
        NavItem($r('app.media.ic_date_range'), false)
        NavItem($r('app.media.ic_notifications'), false)
        NavItem($r('app.media.ic_settings'), false)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
      .padding({ top: 20, bottom: 30 })
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

// --- Data Models ---

interface Task {
  id: number;
  title: string;
  plantName: string;
  icon: Resource;
  urgency: string;
}

interface Plant {
  id: number;
  name: string;
  scientificName: string;
  location: string;
  daysUntilWater: number;
}

// --- Components ---

@Component
struct TaskCard {
  @Prop task: Task;
  @State isChecked: boolean = false;

  build() {
    Column() {
      Row() {
        Circle({ width: 40, height: 40 })
          .fill(this.isChecked ? '#2E5E4E' : Color.White)
          .margin({ bottom: 'auto' })
          .child(
            Image(this.task.icon)
              .width(20)
              .height(20)
              .objectFit(ImageFit.Contain)
              .fillColor(this.isChecked ? Color.White : '#1A1C19')
          )
      }
      .width('100%')

      Column() {
        Text(this.task.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1C19')
        
        Text(this.task.plantName)
          .fontSize(14)
          .fontColor('#757575')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ top: 4, bottom: 8 })

        Text(this.isChecked ? 'DONE' : this.task.urgency)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? Color.White : '#1A1C19')
          .backgroundColor(this.isChecked ? '#2E5E4E' : '#E0E0E0')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(4)
          .width('fit-content')
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('48%')
    .height(180)
    .backgroundColor('#FAFAFA')
    .borderRadius(24)
    .border({ width: 1, color: this.isChecked ? '#2E5E4E' : '#EEEEEE', radius: 24 })
    .padding(16)
    .onClick(() => {
      this.isChecked = !this.isChecked;
    })
  }
}

@Component
struct PlantListItem {
  @Prop plant: Plant;
  @State expanded: boolean = false;

  build() {
    Row() {
      // Placeholder Image Box
      Row() {
        Image($r('app.media.ic_favorite'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .fillColor(this.plant.daysUntilWater === 0 ? '#2E5E4E' : '#CCCCCC')
      }
      .width(56)
      .height(56)
      .backgroundColor('#EEEEEE')
      .borderRadius(12)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text(this.plant.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1C19')
        
        Text(this.plant.scientificName)
          .fontSize(12)
          .fontColor('#757575')
          .fontStyle(FontStyle.Italic)
          .margin({ top: 2 })

        if (this.expanded) {
          Row() {
            Image($r('app.media.ic_location_on'))
              .width(12)
              .height(12)
              .objectFit(ImageFit.Contain)
              .fillColor('#757575')
            
            Text(this.plant.location)
              .fontSize(12)
              .fontColor('#757575')
              .margin({ left: 4 })
          }
          .margin({ top: 8 })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })

      // Status Indicator
      Column() {
        if (this.plant.daysUntilWater === 0) {
          Image($r('app.media.ic_check'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .fillColor('#2E5E4E')
          
          Text('Water')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E5E4E')
            .margin({ top: 2 })
        } else {
          Text(`${this.plant.daysUntilWater} days`)
            .fontSize(12)
            .fontColor('#757575')
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FAFAFA')
    .borderRadius(16)
    .margin({ left: 24, right: 24, bottom: 12 })
    .onClick(() => {
      this.expanded = !this.expanded;
    })
  }
}

@Component
struct NavItem {
  @Prop icon: Resource;
  @Prop isSelected: boolean;

  build() {
    Image(this.icon)
      .width(24)
      .height(24)
      .objectFit(ImageFit.Contain)
      .fillColor(this.isSelected ? '#1A1C19' : '#999999')
  }
}