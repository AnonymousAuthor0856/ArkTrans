import { router, window } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'

// MARK: - 1. Color Palette (Strictly minimal/white based)
const BotanyWhite = '#FFFFFF'
const BotanySurface = '#FFFAFAFA' // Very slight grey for contrast
const BotanyTextPrimary = '#1A1C19'
const BotanyTextSecondary = '#757575'
const BotanyAccent = '#2E5E4E' // Dark Green
const BotanyAccentLight = '#E8F5E9'
const BotanyGrayBorder = '#EEEEEE'
const BotanyGrayBg = '#E0E0E0'
const BotanyPlaceholder = '#EEEEEE'
const BotanyInactiveIcon = '#CCCCCC'

// MARK: - 2. Data Models
interface Plant {
  id: number;
  name: string;
  scientificName: string;
  location: string;
  daysUntilWater: number;
}

interface Task {
  id: number;
  title: string;
  plantName: string;
  iconName: string; // Using system icons or placeholder paths
  urgency: string;
}

@Entry
@Component
struct BotanyApp {
  @State tasks: Task[] = [
    { id: 1, title: "Watering", plantName: "Monstera Deliciosa", iconName: "calendar", urgency: "Today" },
    { id: 2, title: "Fertilize", plantName: "Fiddle Leaf Fig", iconName: "bell.fill", urgency: "Tomorrow" },
    { id: 3, title: "Pruning", plantName: "Snake Plant", iconName: "gearshape.fill", urgency: "Next Week" }
  ]

  @State plants: Plant[] = [
    { id: 1, name: "Monstera", scientificName: "Monstera deliciosa", location: "Living Room", daysUntilWater: 0 },
    { id: 2, name: "Fiddle Leaf", scientificName: "Ficus lyrata", location: "Bedroom", daysUntilWater: 2 },
    { id: 3, name: "Snakey", scientificName: "Sansevieria", location: "Hallway", daysUntilWater: 5 },
    { id: 4, name: "Spider Plant", scientificName: "Chlorophytum", location: "Kitchen", daysUntilWater: 1 },
    { id: 5, name: "Peace Lily", scientificName: "Spathiphyllum", location: "Bathroom", daysUntilWater: 3 }
  ]

  build() {
    Column() {
      Stack({ alignContent: Alignment.Bottom }) {
        // Background
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor(BotanyWhite)

        // Main Content
        Column() {
          // Top Bar
          BotanyTopBar()
            .padding({ top: 24, left: 24, right: 24, bottom: 8 })
            .backgroundColor(BotanyWhite)

          // Scrollable Content
          Scroll() {
            Column({ space: 0 }) {
              // Header
              Column({ space: 4 }) {
                Text("Good Morning,")
                  .fontSize(16)
                  .fontColor(BotanyTextSecondary)
                  .fontWeight(FontWeight.Regular)
                
                Text("My Jungle")
                  .fontSize(34)
                  .fontColor(BotanyTextPrimary)
                  .fontWeight(FontWeight.Bold)
                  .letterSpacing(-1)
              }
              .padding({ left: 24, right: 24, top: 16, bottom: 16 })
              .alignItems(HorizontalAlign.Start)

              // Tasks Section
              SectionHeader({ title: "Pending Tasks" })
              
              Scroll() {
                Row({ space: 16 }) {
                  ForEach(this.tasks, (task: Task) => {
                    TaskCard({ task: task })
                  }, (item: Task) => item.id.toString())
                }
                .padding({ left: 24, right: 24 })
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
              .height(200) // Fixed height for horizontal scroll container
              .margin({ bottom: 32 })

              // Collection Section
              SectionHeader({ title: "Your Collection" })

              ForEach(this.plants, (plant: Plant) => {
                PlantListItem({ plant: plant })
              }, (item: Plant) => item.id.toString())

              // Bottom padding for navigation bar
              Column().height(80)
            }
            .width('100%')
          }
          .layoutWeight(1)
          .scrollBar(BarState.Off)
        }
        .width('100%')
        .height('100%')

        // Floating Action Button (FAB)
        Column() {
          Row() {
            Button() {
              Image($r('app.media.ic_add')) // Placeholder for plus icon
                .width(24)
                .height(24)
                .fillColor(Color.White)
            }
            .type(ButtonType.Circle)
            .backgroundColor(BotanyTextPrimary)
            .width(56)
            .height(56)
            .margin({ right: 24, bottom: 96 })
          }
          .justifyContent(FlexAlign.End)
          .width('100%')
        }
        .zIndex(1)

        // Bottom Navigation Bar
        BotanyBottomBar()
          .width('100%')
          .backgroundColor(BotanyWhite)
          .shadow({ radius: 10, color: 'rgba(0,0,0,0.05)', offsetY: -2 })
          .zIndex(2)
      }
      .width('100%')
      .height('100%')
    }
    .backgroundColor(BotanyWhite)
  }
}

// MARK: - 5. SectionHeader
@Component
struct SectionHeader {
  controller: string = ""
  title: string = ""

  build() {
    Text(this.title)
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .fontColor(BotanyTextPrimary)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
  }
}

// MARK: - 6. TaskCard
@Component
struct TaskCard {
  task: Task = {} as Task
  @State isChecked: boolean = false

  build() {
    Column({ space: 0 }) {
      Row() {
        Stack() {
          Circle()
            .width(40)
            .height(40)
            .fill(this.isChecked ? BotanyAccent : BotanyWhite)
          
          Image($r('app.media.ic_calendar')) // Placeholder for icon
            .width(20)
            .height(20)
            .fillColor(this.isChecked ? Color.White : BotanyTextPrimary)
        }
        
        Blank()
      }
      
      Column().height(0)

      Column({ space: 0 }) {
        Text(this.task.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyTextPrimary)
        
        Text(this.task.plantName)
          .fontSize(12)
          .fontColor(BotanyTextSecondary)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        
        Column().height(8)

        // Status Chip
        Text(this.isChecked ? "DONE" : this.task.urgency)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? Color.White : BotanyTextPrimary)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .backgroundColor(this.isChecked ? BotanyAccent : BotanyGrayBg)
          .borderRadius(4)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(16)
    .width(160)
    .height(180)
    .backgroundColor(BotanySurface)
    .borderRadius(24)
    .border({
      width: this.isChecked ? 2 : 1,
      color: this.isChecked ? BotanyAccent : BotanyGrayBorder,
      radius: 24
    })
    .onClick(() => {
      this.isChecked = !this.isChecked
    })
  }
}

// MARK: - 7. PlantListItem
@Component
struct PlantListItem {
  plant: Plant = {} as Plant
  @State expanded: boolean = false

  build() {
    Row({ space: 16 }) {
      // Image Placeholder
      Stack() {
        Rect()
          .width(56)
          .height(56)
          .borderRadius(12)
          .fill(BotanyPlaceholder)
        
        Image($r('app.media.ic_heart')) // Placeholder for heart icon
          .width(24)
          .height(24)
          .fillColor(this.plant.daysUntilWater === 0 ? BotanyAccent : BotanyInactiveIcon)
      }

      Column({ space: 4 }) {
        Text(this.plant.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyTextPrimary)
        
        Text(this.plant.scientificName)
          .fontSize(12)
          .fontColor(BotanyTextSecondary)
          .fontStyle(FontStyle.Italic)

        if (this.expanded) {
          Column().height(8)
          
          Row({ space: 4 }) {
            Image($r('app.media.ic_location')) // Placeholder for location icon
              .width(12)
              .height(12)
              .fillColor(BotanyTextSecondary)
            
            Text(this.plant.location)
              .fontSize(10)
              .fontColor(BotanyTextSecondary)
          }
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // Right Side Info
      Column({ space: 4 }) {
        if (this.plant.daysUntilWater === 0) {
          Image($r('app.media.ic_check')) // Placeholder for check icon
            .width(24)
            .height(24)
            .fillColor(BotanyAccent)
          
          Text("Water")
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(BotanyAccent)
        } else {
          Text(`${this.plant.daysUntilWater} days`)
            .fontSize(10)
            .fontColor(BotanyTextSecondary)
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .padding(16)
    .backgroundColor(BotanySurface)
    .borderRadius(16)
    .margin({ left: 24, right: 24, top: 8, bottom: 8 })
    .onClick(() => {
      this.expanded = !this.expanded
    })
  }
}

// MARK: - 8. BotanyTopBar
@Component
struct BotanyTopBar {
  build() {
    Row() {
      Button() {
        Image($r('app.media.ic_menu')) // Placeholder for menu icon
          .width(24)
          .height(24)
          .fillColor(BotanyTextPrimary)
      }
      .type(ButtonType.Circle)
      .backgroundColor(BotanySurface)
      .width(40)
      .height(40)

      Blank()

      Button() {
        Image($r('app.media.ic_search')) // Placeholder for search icon
          .width(24)
          .height(24)
          .fillColor(BotanyTextPrimary)
      }
      .type(ButtonType.Circle)
      .backgroundColor(BotanySurface)
      .width(40)
      .height(40)
    }
  }
}

// MARK: - 9. BotanyBottomBar
@Component
struct BotanyBottomBar {
  @State selectedTab: number = 0

  build() {
    Row({ space: 0 }) {
      BotanyNavItem({ iconName: $r('app.media.ic_home'), isSelected: this.selectedTab === 0 })
        .onClick(() => { this.selectedTab = 0 })
      
      BotanyNavItem({ iconName: $r('app.media.ic_calendar'), isSelected: this.selectedTab === 1 })
        .onClick(() => { this.selectedTab = 1 })
      
      Column().width(32) // Spacer for FAB
      
      BotanyNavItem({ iconName: $r('app.media.ic_bell'), isSelected: this.selectedTab === 2 })
        .onClick(() => { this.selectedTab = 2 })
      
      BotanyNavItem({ iconName: $r('app.media.ic_settings'), isSelected: this.selectedTab === 3 })
        .onClick(() => { this.selectedTab = 3 })
    }
    .width('100%')
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .backgroundColor(BotanyWhite)
  }
}

// MARK: - 10. BotanyNavItem
@Component
struct BotanyNavItem {
  iconName: Resource = $r('app.media.ic_home')
  isSelected: boolean = false

  build() {
    Button() {
      Image(this.iconName)
        .width(24)
        .height(24)
        .fillColor(BotanyTextPrimary)
        .opacity(this.isSelected ? 1.0 : 0.4)
    }
    .type(ButtonType.Normal)
    .layoutWeight(1)
  }
}