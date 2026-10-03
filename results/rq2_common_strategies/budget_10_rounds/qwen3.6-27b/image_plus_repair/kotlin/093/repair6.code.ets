import { router } from '@kit.ArkUI';

// --- Domain Models ---
interface TeaPreset {
  name: string;
  temp: string;
  time: string;
  description: string;
}

// --- Sample Data ---
const teaPresets: TeaPreset[] = [
  { name: "Sencha", temp: "70°C", time: "1-2 min", description: "Japanese green tea, grassy and fresh." },
  { name: "Earl Grey", temp: "98°C", time: "3-4 min", description: "Black tea flavored with bergamot oil." },
  { name: "Oolong", temp: "85°C", time: "3-5 min", description: "Traditional semi-oxidized Chinese tea." },
  { name: "Chamomile", temp: "100°C", time: "5 min", description: "Herbal infusion, calming and caffeine-free." },
  { name: "Matcha", temp: "80°C", time: "Whisk", description: "Finely ground powder of green tea leaves." }
];

@Entry
@Component
struct TeaBrewingScreen {
  @State selectedIndex: number = 0;

  build() {
    Column() {
      // Header Section
      this.HeaderSection()

      // Visualization Circle
      this.BrewingVisualizer(teaPresets[this.selectedIndex])

      // Stats Row
      this.BrewStatsRow(teaPresets[this.selectedIndex])

      // Selection List
      this.TeaSelector()

      // Spacer to push button down
      Blank()

      // Action Button
      this.StartBrewButton()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .padding({ left: 24, right: 24 })
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text("Tea Master")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        
        Text("Perfect brew, every time")
          .fontSize(14)
          .fontColor(Color.Gray)
          .margin({ top: 4 })
      }
      
      Image($r('app.media.settings')) // Ensure 'settings' image exists in media folder
        .width(24)
        .height(24)
        .fillColor(Color.Black)
        .onClick(() => {
          // Settings click handler
        })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .margin({ top: 40, bottom: 32 })
  }

  @Builder
  BrewingVisualizer(tea: TeaPreset) {
    Column() {
      Image($r('app.media.favorite')) // Ensure 'favorite' image exists in media folder
        .width(48)
        .height(48)
        .fillColor('#8D6E63') // Tea brown color
      
      Text(tea.name)
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 8 })
    }
    .width(180)
    .height(180)
    .borderRadius(90)
    .backgroundColor('#F5F5F5')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .margin({ bottom: 40 })
  }

  @Builder
  BrewStatsRow(tea: TeaPreset) {
    Row() {
      this.InfoItem("TEMP", tea.temp)
      Divider().vertical(true).color('#E0E0E0').margin({ left: 10, right: 10 })
      this.InfoItem("TIME", tea.time)
      Divider().vertical(true).color('#E0E0E0').margin({ left: 10, right: 10 })
      this.InfoItem("AMOUNT", "250ml")
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .margin({ bottom: 40 })
  }

  @Builder
  InfoItem(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(12)
        .fontColor(Color.Gray)
        .fontWeight(FontWeight.Bold)
        .letterSpacing(1)
      
      Text(value)
        .fontSize(18)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Medium)
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  TeaSelector() {
    Column() {
      Text("Select Variety")
        .fontSize(16)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 12 })
      
      List({ space: 12 }) {
        ForEach(teaPresets, (preset: TeaPreset, index: number) => {
          ListItem() {
            Text(preset.name)
              .fontSize(16)
              .fontWeight(this.selectedIndex === index ? FontWeight.Bold : FontWeight.Normal)
              .fontColor(this.selectedIndex === index ? Color.White : Color.Black)
              .textAlign(TextAlign.Center)
              .padding({ left: 20, right: 20, top: 10, bottom: 10 })
              .backgroundColor(this.selectedIndex === index ? Color.Black : Color.White)
              .borderWidth(1)
              .borderColor('#E0E0E0')
              .borderRadius(50)
              .onClick(() => {
                this.selectedIndex = index;
              })
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .height(50)
      .scrollable(ScrollDirection.Horizontal)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .margin({ bottom: 20 })
  }

  @Builder
  StartBrewButton() {
    Button() {
      Row() {
        Image($r('app.media.play_arrow')) // Ensure 'play_arrow' image exists in media folder
          .width(20)
          .height(20)
          .fillColor(Color.White)
        
        Text("START TIMER")
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ left: 8 })
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(56)
    .backgroundColor(Color.Black)
    .borderRadius(16)
    .onClick(() => {
      // Start timer logic
    })
  }
}