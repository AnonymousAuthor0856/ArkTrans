import { router } from '@kit.ArkUI'
import { ImageVector, SymbolGlyph } from '@kit.ArkGraphics'

// --- Data Models ---

interface Plant {
  id: number;
  name: string;
  scientificName: string;
  location: string;
  daysUntilWater: number;
  isHealthy?: boolean;
}

interface Task {
  id: number;
  title: string;
  plantName: string;
  icon: symbol; // Using system symbols for icons
  urgency: string;
}

// --- Color Palette (Strictly minimal/white based) ---

const BotanyWhite = '#FFFFFF';
const BotanySurface = '#FAFAFA'; // Very slight grey for contrast
const BotanyTextPrimary = '#1A1C19';
const BotanyTextSecondary = '#757575';
const BotanyAccent = '#2E5E4E'; // Dark Green
const BotanyAccentLight = '#E8F5E9';

@Entry
@Component
struct BotanyApp {
  @State tasks: Task[] = [
    { id: 1, title: 'Watering', plantName: 'Monstera Deliciosa', icon: SymbolGlyph.SystemSymbolNames.calendar, urgency: 'Today' },
    { id: 2, title: 'Fertilize', plantName: 'Fiddle Leaf Fig', icon: SymbolGlyph.SystemSymbolNames.bell, urgency: 'Tomorrow' },
    { id: 3, title: 'Pruning', plantName: 'Snake Plant', icon: SymbolGlyph.SystemSymbolNames.gear, urgency: 'Next Week' }
  ];

  @State plants: Plant[] = [
    { id: 1, name: 'Monstera', scientificName: 'Monstera deliciosa', location: 'Living Room', daysUntilWater: 0 },
    { id: 2, name: 'Fiddle Leaf', scientificName: 'Ficus lyrata', location: 'Bedroom', daysUntilWater: 2 },
    { id: 3, name: 'Snakey', scientificName: 'Sansevieria', location: 'Hallway', daysUntilWater: 5 },
    { id: 4, name: 'Spider Plant', scientificName: 'Chlorophytum', location: 'Kitchen', daysUntilWater: 1 },
    { id: 5, name: 'Peace Lily', scientificName: 'Spathiphyllum', location: 'Bathroom', daysUntilWater: 3 }
  ];

  build() {
    Column() {
      Stack({ alignContent: Alignment.BottomEnd }) {
        LazyColumn({}) {
          ForEach(this.plants, (plant: Plant) => {
            PlantListItem(plant)
          })
        }
        .layoutWeight(1)
        .backgroundColor(BotanyWhite)
        .padding({ bottom: 80 }) // Space for bottom bar

        // Floating Action Button
        Row() {
          Image($r('sys.symbol.add'))
            .width(24)
            .height(24)
            .fillColor(Color.White)
        }
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor(BotanyTextPrimary)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .position({ right: 24, bottom: 80 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BotanyWhite)

      BotanyBottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BotanyWhite)
  }
}

@Component
struct BotanyTopBar {
  build() {
    Row() {
      Row() {
        Image($r('sys.symbol.line.3.horizontal'))
          .width(24)
          .height(24)
          .fillColor(BotanyTextPrimary)
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(BotanySurface)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Spacer().layoutWeight(1)

      Row() {
        Image($r('sys.symbol.magnifyingglass'))
          .width(24)
          .height(24)
          .fillColor(BotanyTextPrimary)
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(BotanySurface)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding({ top: 24, start: 24, end: 24, bottom: 8 })
  }
}

@Component
struct BotanyBottomBar {
  build() {
    Row() {
      BotanyNavItem(SymbolGlyph.SystemSymbolNames.house, true)
      BotanyNavItem(SymbolGlyph.SystemSymbolNames.calendar, false)
      Spacer().width(32) // Space for FAB
      BotanyNavItem(SymbolGlyph.SystemSymbolNames.bell, false)
      BotanyNavItem(SymbolGlyph.SystemSymbolNames.gear, false)
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
  @Prop icon: symbol;
  @Prop isSelected: boolean;

  build() {
    Column() {
      Image(this.icon)
        .width(24)
        .height(24)
        .fillColor(BotanyTextPrimary)
        .opacity(this.isSelected ? 1 : 0.4)
    }
    .onClick(() => {
      // Navigation logic would go here
    })
  }
}

@Component
struct SectionHeader {
  @Prop title: string;

  build() {
    Text(this.title)
      .fontWeight(FontWeight.Bold)
      .fontColor(BotanyTextPrimary)
      .fontSize(18)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
  }
}

@Component
struct TaskCard {
  @State isChecked: boolean = false;
  @Prop task: Task;

  build() {
    Column() {
      Row() {
        Row() {
          Image(this.task.icon)
            .width(20)
            .height(20)
            .fillColor(this.isChecked ? Color.White : BotanyTextPrimary)
        }
        .width(40)
        .height(40)
        .borderRadius(20)
        .backgroundColor(this.isChecked ? BotanyAccent : BotanyWhite)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

      Column() {
        Text(this.task.title)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyTextPrimary)
          .fontSize(14)

        Text(this.task.plantName)
          .fontColor(BotanyTextSecondary)
          .fontSize(12)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Spacer().height(8)

        Text(this.isChecked ? "DONE" : this.task.urgency)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? Color.White : BotanyTextPrimary)
          .fontSize(10)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .backgroundColor(this.isChecked ? BotanyAccent : '#E0E0E0')
          .borderRadius(4)
      }
    }
    .width(160)
    .height(180)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .borderRadius(24)
    .backgroundColor(BotanySurface)
    .border({ width: this.isChecked ? 2 : 1, color: this.isChecked ? BotanyAccent : '#EEEEEE' })
    .onClick(() => {
      this.isChecked = !this.isChecked;
    })
  }
}

@Component
struct PlantListItem {
  @State expanded: boolean = false;
  @Prop plant: Plant;

  build() {
    Row() {
      // "Image" Placeholder - Pure UI shapes
      Row() {
        Image($r('sys.symbol.heart'))
          .width(24)
          .height(24)
          .fillColor(this.plant.daysUntilWater === 0 ? BotanyAccent : '#CCCCCC')
      }
      .width(56)
      .height(56)
      .borderRadius(12)
      .backgroundColor('#EEEEEE')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Spacer().width(16)

      Column() {
        Text(this.plant.name)
          .fontWeight(FontWeight.Bold)
          .fontColor(BotanyTextPrimary)
          .fontSize(16)

        Text(this.plant.scientificName)
          .fontColor(BotanyTextSecondary)
          .fontSize(12)
          .fontStyle(FontStyle.Italic)

        if (this.expanded) {
          Spacer().height(8)
          Row() {
            Image($r('sys.symbol.location'))
              .width(12)
              .height(12)
              .fillColor(BotanyTextSecondary)
            Spacer().width(4)
            Text(this.plant.location)
              .fontColor(BotanyTextSecondary)
              .fontSize(10)
          }
        }
      }
      .layoutWeight(1)

      Column() {
        if (this.plant.daysUntilWater === 0) {
          Image($r('sys.symbol.checkmark.circle'))
            .width(24)
            .height(24)
            .fillColor(BotanyAccent)
          Text("Water")
            .fontWeight(FontWeight.Bold)
            .fontColor(BotanyAccent)
            .fontSize(10)
        } else {
          Text(`${this.plant.daysUntilWater} days`)
            .fontColor(BotanyTextSecondary)
            .fontSize(10)
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 8, bottom: 8 })
    .borderRadius(16)
    .backgroundColor(BotanySurface)
    .padding(16)
    .onClick(() => {
      this.expanded = !this.expanded;
    })
  }
}