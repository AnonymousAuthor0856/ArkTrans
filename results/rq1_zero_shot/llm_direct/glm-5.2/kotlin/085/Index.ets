// Index.ets
import { Length, ResourceStr } from '@ohos.arkui';

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
  icon: Resource;
  urgency: string;
}

// --- Color Palette ---
const BotanyWhite: string = '#FFFFFF';
const BotanySurface: string = '#FAFAFA';
const BotanyTextPrimary: string = '#1A1C19';
const BotanyTextSecondary: string = '#757575';
const BotanyAccent: string = '#2E5E4E';
const BotanyAccentLight: string = '#E8F5E9';
const BotanyBorder: string = '#EEEEEE';
const BotanyChipBg: string = '#E0E0E0';

// --- Mock Data ---
const tasksData: Task[] = [
  { id: 1, title: 'Watering', plantName: 'Monstera Deliciosa', icon: $r('sys.media.ohos_ic_public_clock'), urgency: 'Today' },
  { id: 2, title: 'Fertilize', plantName: 'Fiddle Leaf Fig', icon: $r('sys.media.ohos_ic_public_clock'), urgency: 'Tomorrow' },
  { id: 3, title: 'Pruning', plantName: 'Snake Plant', icon: $r('sys.media.ohos_ic_public_settings'), urgency: 'Next Week' }
];

const plantsData: Plant[] = [
  { id: 1, name: 'Monstera', scientificName: 'Monstera deliciosa', location: 'Living Room', daysUntilWater: 0, isHealthy: true },
  { id: 2, name: 'Fiddle Leaf', scientificName: 'Ficus lyrata', location: 'Bedroom', daysUntilWater: 2, isHealthy: true },
  { id: 3, name: 'Snakey', scientificName: 'Sansevieria', location: 'Hallway', daysUntilWater: 5, isHealthy: true },
  { id: 4, name: 'Spider Plant', scientificName: 'Chlorophytum', location: 'Kitchen', daysUntilWater: 1, isHealthy: true },
  { id: 5, name: 'Peace Lily', scientificName: 'Spathiphyllum', location: 'Bathroom', daysUntilWater: 3, isHealthy: true }
];

// --- Main Entry ---
@Entry
@Component
struct BotanyApp {
  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        BotanyTopBar()
        BotanyContent()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BotanyWhite)

      // Floating Action Button
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
      .position({ x: '80%', y: '85%' })
      .shadow({ radius: 10, color: 'rgba(0,0,0,0.2)', offsetX: 0, offsetY: 4 })
    }
    .width('100%')
    .height('100%')
  }
}

// --- Content ---
@Component
struct BotanyContent {
  build() {
    Column() {
      // Header
      Column() {
        Text('Good Morning,')
          .fontSize(16)
          .fontColor(BotanyTextSecondary)
          .margin({ bottom: 4 })
        Text('My Jungle')
          .fontSize(40)
          .fontColor(BotanyTextPrimary)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(-1)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding({ left: 24, right: 24, top: 16, bottom: 16 })

      // Tasks Header
      Text('Pending Tasks')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(BotanyTextPrimary)
        .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        .width('100%')

      // Tasks List (Horizontal Scroll)
      Scroll() {
        Row({ space: 16 }) {
          ForEach(tasksData, (task: Task) => {
            TaskCard({ task: task })
          })
        }
        .padding({ left: 24, right: 24 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
      .height(180)
      .margin({ bottom: 32 })

      // Collection Header
      Text('Your Collection')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(BotanyTextPrimary)
        .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        .width('100%')

      // Plants List (Vertical Scroll)
      Scroll() {
        Column() {
          ForEach(plantsData, (plant: Plant) => {
            PlantListItem({ plant: plant })
          })
        }
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .padding({ bottom: 80 })

      BotanyBottomBar()
    }
    .width('100%')
    .height('100%')
  }
}

// --- Components ---

@Component
struct TaskCard {
  @Prop task: Task;
  @State isChecked: boolean = false;

  build() {
    Column() {
      Row() {
        // Icon Circle
        Column() {
          Image(this.task.icon)
            .width(20)
            .height(20)
            .fillColor(this.isChecked ? BotanyWhite : BotanyTextPrimary)
        }
        .width(40)
        .height(40)
        .borderRadius(20)
        .backgroundColor(this.isChecked ? BotanyAccent : BotanyWhite)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Blank() // Spacer

      Column() {
        Text(this.task.title)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyTextPrimary)
        Text(this.task.plantName)
          .fontSize(12)
          .fontColor(BotanyTextSecondary)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ top: 2 })

        // Status Chip
        Row() {
          Text(this.isChecked ? 'DONE' : this.task.urgency)
            .fontSize(10)
            .fontColor(this.isChecked ? BotanyWhite : BotanyTextPrimary)
            .fontWeight(FontWeight.Bold)
        }
        .backgroundColor(this.isChecked ? BotanyAccent : BotanyChipBg)
        .borderRadius(4)
        .padding({ left: 6, right: 6, top: 2, bottom: 2 })
        .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width(160)
    .height(180)
    .padding(16)
    .borderRadius(24)
    .backgroundColor(BotanySurface)
    .border({ width: this.isChecked ? 2 : 1, color: this.isChecked ? BotanyAccent : BotanyBorder })
    .onClick(() => {
      this.isChecked = !this.isChecked;
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct PlantListItem {
  @Prop plant: Plant;
  @State isExpanded: boolean = false;

  build() {
    Row() {
      // Image Placeholder
      Column() {
        Image($r('sys.media.ohos_ic_public_favor')) // Using favor as abstract leaf/life symbol
          .width(24)
          .height(24)
          .fillColor(this.plant.daysUntilWater === 0 ? BotanyAccent : '#CCCCCC')
      }
      .width(56)
      .height(56)
      .borderRadius(12)
      .backgroundColor(BotanyBorder)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Blank().width(16)

      // Plant Info
      Column() {
        Text(this.plant.name)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyTextPrimary)
        Text(this.plant.scientificName)
          .fontSize(12)
          .fontColor(BotanyTextSecondary)
          .fontStyle(FontStyle.Italic)
          .margin({ top: 2 })

        if (this.isExpanded) {
          Row() {
            Image($r('sys.media.ohos_ic_public_location'))
              .width(12)
              .height(12)
              .fillColor(BotanyTextSecondary)
            Text(this.plant.location)
              .fontSize(10)
              .fontColor(BotanyTextSecondary)
              .margin({ left: 4 })
          }
          .margin({ top: 8 })
          .alignItems(VerticalAlign.Center)
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // Water Status
      Column() {
        if (this.plant.daysUntilWater === 0) {
          Image($r('sys.media.ohos_ic_public_select'))
            .width(24)
            .height(24)
            .fillColor(BotanyAccent)
          Text('Water')
            .fontSize(10)
            .fontColor(BotanyAccent)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 4 })
        } else {
          Text(`${this.plant.daysUntilWater} days`)
            .fontSize(10)
            .fontColor(BotanyTextSecondary)
        }
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .padding(16)
    .borderRadius(16)
    .backgroundColor(BotanySurface)
    .margin({ left: 24, right: 24, top: 4, bottom: 4 })
    .onClick(() => {
      this.isExpanded = !this.isExpanded;
    })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BotanyTopBar {
  build() {
    Row() {
      // Menu Button
      Column() {
        Image($r('sys.media.ohos_ic_public_more'))
          .width(20)
          .height(20)
          .fillColor(BotanyTextPrimary)
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(BotanySurface)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Blank() // Spacer

      // Search Button
      Column() {
        Image($r('sys.media.ohos_ic_public_search'))
          .width(20)
          .height(20)
          .fillColor(BotanyTextPrimary)
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(BotanySurface)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 8 })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct BotanyBottomBar {
  build() {
    Row() {
      BotanyNavItem({ icon: $r('sys.media.ohos_ic_public_home_page'), isSelected: true })
      BotanyNavItem({ icon: $r('sys.media.ohos_ic_public_clock'), isSelected: false })
      
      Blank().width(32) // Space for FAB

      BotanyNavItem({ icon: $r('sys.media.ohos_ic_public_notifications'), isSelected: false })
      BotanyNavItem({ icon: $r('sys.media.ohos_ic_public_settings'), isSelected: false })
    }
    .width('100%')
    .backgroundColor(BotanyWhite)
    .padding({ left: 48, right: 48, top: 24, bottom: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BotanyNavItem {
  icon: Resource;
  isSelected: boolean = false;

  build() {
    Column() {
      Image(this.icon)
        .width(24)
        .height(24)
        .fillColor(BotanyTextPrimary)
        .opacity(this.isSelected ? 1.0 : 0.4)
    }
    .width(40)
    .height(40)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}