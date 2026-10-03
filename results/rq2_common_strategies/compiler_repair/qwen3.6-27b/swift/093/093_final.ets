import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - Models
interface TeaPreset {
  id: number;
  name: string;
  temp: string;
  time: string;
  description: string;
}

@Entry
@Component
struct TeaMasterApp {
  @State selectedTeaIndex: number = 0;

  // Sample Data
  private teaPresets: TeaPreset[] = [
    { id: 1, name: "Sencha", temp: "70°C", time: "1-2 min", description: "Japanese green tea, grassy and fresh." },
    { id: 2, name: "Earl Grey", temp: "98°C", time: "3-4 min", description: "Black tea flavored with bergamot oil." },
    { id: 3, name: "Oolong", temp: "85°C", time: "3-5 min", description: "Traditional semi-oxidized Chinese tea." },
    { id: 4, name: "Chamomile", temp: "100°C", time: "5 min", description: "Herbal infusion, calming and caffeine-free." },
    { id: 5, name: "Matcha", temp: "80°C", time: "Whisk", description: "Finely ground powder of green tea leaves." }
  ];

  build() {
    Column() {
      // Header
      this.HeaderSection()
        .padding({ top: 24, left: 24, right: 24 })

      Spacer().height(32)

      // Visualization
      this.BrewingVisualizer(this.teaPresets[this.selectedTeaIndex])

      Spacer().height(40)

      // Stats Row
      this.BrewStatsRow(this.teaPresets[this.selectedTeaIndex])
        .padding({ left: 24, right: 24 })

      Spacer().height(40)

      // Selection List
      this.TeaSelector(this.teaPresets, this.selectedTeaIndex)
        .padding({ left: 24, right: 24 })

      Spacer()

      // Action Button
      this.StartBrewButton()
        .padding({ left: 24, right: 24, bottom: 32 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .statusBarContentMode(StatusBarContentMode.LightContent)
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
          .fontSize(12)
          .fontColor(Color.Gray)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Spacer()

      Button() {
        Image($r('app.media.settings')) 
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .type(ButtonType.Circle)
      .borderWidth(0)
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BrewingVisualizer(tea: TeaPreset) {
    Stack() {
      Circle()
        .fill('#F5F5F5')
        .width(220)
        .height(220)

      Column() {
        // Using a generic heart shape or similar. In real app, use specific asset.
        // Simulating SF Symbol 'heart.fill' with a simple circle/shape or text emoji for demo
        Text("❤️") 
          .fontSize(48)
          .fontColor('#8D6E63')
        
        Text(tea.name)
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
          .margin({ top: 8 })
      }
    }
  }

  @Builder
  BrewStatsRow(tea: TeaPreset) {
    Row() {
      this.InfoItem("TEMP", tea.temp)
      
      Spacer()
      
      Divider()
        .vertical(true)
        .color('#E0E0E0')
        .height(40)
        .margin({ left: 12, right: 12 })
      
      this.InfoItem("TIME", tea.time)
      
      Spacer()
      
      Divider()
        .vertical(true)
        .color('#E0E0E0')
        .height(40)
        .margin({ left: 12, right: 12 })
      
      this.InfoItem("AMOUNT", "250ml")
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  InfoItem(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Gray)
        .letterSpacing(1)
      
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  TeaSelector(presets: TeaPreset[], selectedIndex: number) {
    Column() {
      Text("Select Variety")
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ left: 4, bottom: 12 })
        .alignSelf(ItemAlign.Start)

      Scroll() {
        Row() {
          ForEach(presets, (tea: TeaPreset) => {
            this.TeaChip(
              tea.name,
              presets.indexOf(tea) === selectedIndex,
              () => {
                this.selectedTeaIndex = presets.indexOf(tea);
              }
            )
            .margin({ right: 12 })
          })
        }
        .padding({ left: 4, right: 4 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  TeaChip(name: string, isSelected: boolean, onClick: () => void) {
    Button() {
      Text(name)
        .fontSize(14)
        .fontWeight(isSelected ? FontWeight.Bold : FontWeight.Normal)
        .fontColor(isSelected ? Color.White : Color.Black)
    }
    .onClick(onClick)
    .backgroundColor(isSelected ? Color.Black : Color.White)
    .borderWidth(1)
    .borderColor(isSelected ? Color.Black : '#E0E0E0')
    .borderRadius(20) // Capsule-like
    .padding({ left: 20, right: 20, top: 10, bottom: 10 })
  }

  @Builder
  StartBrewButton() {
    Button() {
      Row() {
        // Play icon simulation
        Text("▶")
          .fontSize(20)
          .fontColor(Color.White)
          .margin({ right: 8 })
        
        Text("START TIMER")
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .backgroundColor(Color.Black)
    .borderRadius(16)
    .height(56)
    .width('100%')
  }
}