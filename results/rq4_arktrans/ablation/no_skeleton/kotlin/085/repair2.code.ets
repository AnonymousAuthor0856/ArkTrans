@Entry
@Component
struct BotanyApp {
  @State tasks: Task[] = [
    { id: 1, title: 'Watering', plantName: 'Monstera Deliciosa', icon: $r('app.media.startIcon'), urgency: 'Today' },
    { id: 2, title: 'Fertilize', plantName: 'Fiddle Leaf Fig', icon: $r('app.media.startIcon'), urgency: 'Tomorrow' },
    { id: 3, title: 'Pruning', plantName: 'Snake Plant', icon: $r('app.media.startIcon'), urgency: 'Next Week' }
  ]

  @State plants: Plant[] = [
    { id: 1, name: 'Monstera', scientificName: 'Monstera deliciosa', location: 'Living Room', daysUntilWater: 0 },
    { id: 2, name: 'Fiddle Leaf', scientificName: 'Ficus lyrata', location: 'Bedroom', daysUntilWater: 2 },
    { id: 3, name: 'Snakey', scientificName: 'Sansevieria', location: 'Hallway', daysUntilWater: 5 },
    { id: 4, name: 'Spider Plant', scientificName: 'Chlorophytum', location: 'Kitchen', daysUntilWater: 1 },
    { id: 5, name: 'Peace Lily', scientificName: 'Spathiphyllum', location: 'Bathroom', daysUntilWater: 3 }
  ]

  build() {
    Stack() {
      Column() {
        // Top Bar
        Row() {
          Button() {
            Image($r('app.media.startIcon')).width(24).height(24)
          }.type(ButtonType.Circle).backgroundColor('#FAFAFA').margin({ top: 24, start: 24, bottom: 8 })

          Blank()

          Button() {
            Image($r('app.media.startIcon')).width(24).height(24)
          }.type(ButtonType.Circle).backgroundColor('#FAFAFA').margin({ top: 24, end: 24, bottom: 8 })
        }.width('100%')

        // Header Text
        Column() {
          Text('Good Morning,').fontColor('#757575').fontSize(16)
          Text('My Jungle').fontColor('#1A1C19').fontSize(48).fontWeight(FontWeight.Bold)
        }.padding({ left: 24, right: 24, top: 16, bottom: 16 })

        // Pending Tasks Section
        Column() {
          Text('Pending Tasks').fontColor('#1A1C19').fontSize(18).fontWeight(FontWeight.Bold)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })

          Scroll() {
            Row({ space: 16 }) {
              ForEach(this.tasks, (task: Task) => {
                TaskCard({ task: task })
              })
            }.padding({ left: 24, right: 24 })
          }.layoutWeight(1)
        }

        // Collection Section
        Column() {
          Text('Your Collection').fontColor('#1A1C19').fontSize(18).fontWeight(FontWeight.Bold)
            .padding({ left: 24, right: 24, top: 32, bottom: 12 })

          List() {
            ForEach(this.plants, (plant: Plant) => {
              ListItem() {
                PlantListItem({ plant: plant })
              }
            })
          }.layoutWeight(1)
        }
      }.width('100%').height('100%').backgroundColor('#FFFFFF')

      // Bottom Navigation
      Row() {
        NavItem({ isSelected: true })
        NavItem({ isSelected: false })
        Blank().width(32)
        NavItem({ isSelected: false })
        NavItem({ isSelected: false })
      }.width('100%').height(80).justifyContent(FlexAlign.SpaceBetween)
        .padding({ left: 48, right: 48 }).alignSelf(ItemAlign.End).margin({ bottom: 20 })

      // FAB
      Button() {
        Image($r('app.media.startIcon')).width(24).height(24)
      }.type(ButtonType.Circle).backgroundColor('#1A1C19').width(56).height(56)
        .shadow({ radius: 10, color: '#33000000' }).alignSelf(ItemAlign.End)
        .margin({ end: 24, bottom: 100 })
    }.width('100%').height('100%')
  }
}

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

@Component
struct TaskCard {
  private task: Task = {} as Task
  @State isChecked: boolean = false

  build() {
    Column() {
      Row() {
        Row() {
          Image(this.task.icon).width(20).height(20)
        }.width(40).height(40).borderRadius(20).justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .backgroundColor(this.isChecked ? '#2E5E4E' : '#FFFFFF')
      }.width('100%')

      Column() {
        Text(this.task.title).fontColor('#1A1C19').fontSize(14).fontWeight(FontWeight.Bold)
        Text(this.task.plantName).fontColor('#757575').fontSize(12).maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis })
        Blank().height(8)
        
        Row() {
          Text(this.isChecked ? 'DONE' : this.task.urgency)
            .fontColor(this.isChecked ? '#FFFFFF' : '#1A1C19')
            .fontSize(10).fontWeight(FontWeight.Bold)
        }.padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .backgroundColor(this.isChecked ? '#2E5E4E' : '#E0E0E0').borderRadius(4)
      }
    }.width(160).height(180).padding(16).backgroundColor('#FAFAFA').borderRadius(24)
      .border({ width: this.isChecked ? LengthMetrics(2) : LengthMetrics(1), color: this.isChecked ? '#2E5E4E' : '#EEEEEE' })
      .onClick(() => { this.isChecked = !this.isChecked })
  }
}

@Component
struct PlantListItem {
  private plant: Plant = {} as Plant
  @State expanded: boolean = false

  build() {
    Row() {
      // Placeholder Icon Box
      Row() {
        Image($r('app.media.startIcon'))
          .width(24).height(24)
          .objectFit(ImageFit.Contain)
          .opacity(this.plant.daysUntilWater === 0 ? 1 : 0.5)
      }.width(56).height(56).borderRadius(12).backgroundColor('#EEEEEE')
        .justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)

      Column() {
        Text(this.plant.name).fontColor('#1A1C19').fontSize(14).fontWeight(FontWeight.Bold)
        Text(this.plant.scientificName).fontColor('#757575').fontSize(12).fontStyle(FontStyle.Italic)
        
        if (this.expanded) {
          Row() {
            Image($r('app.media.startIcon')).width(12).height(12)
            Text(this.plant.location).fontColor('#757575').fontSize(10)
          }.margin({ top: 8 })
        }
      }.layoutWeight(1).margin({ left: 16 })

      Column() {
        if (this.plant.daysUntilWater === 0) {
          Image($r('app.media.startIcon')).width(24).height(24)
          Text('Water').fontColor('#2E5E4E').fontSize(10).fontWeight(FontWeight.Bold)
        } else {
          Text(`${this.plant.daysUntilWater} days`).fontColor('#757575').fontSize(10)
        }
      }
    }.width('100%').padding({ left: 24, right: 24, top: 8, bottom: 8 })
      .backgroundColor('#FAFAFA').borderRadius(16).padding(16)
      .onClick(() => { this.expanded = !this.expanded })
  }
}

@Component
struct NavItem {
  private isSelected: boolean = false

  build() {
    Button() {
      Image($r('app.media.startIcon')).width(24).height(24).opacity(this.isSelected ? 1 : 0.4)
    }.type(ButtonType.Circle).backgroundColor('transparent')
  }
}