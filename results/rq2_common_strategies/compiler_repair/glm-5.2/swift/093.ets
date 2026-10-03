// TeaMasterApp.ets
interface TeaPreset {
  name: string;
  temp: string;
  time: string;
  description: string;
}

@Entry
@Component
struct TeaMasterApp {
  private teaPresets: TeaPreset[] = [
    { name: "Sencha", temp: "70°C", time: "1-2 min", description: "Japanese green tea, grassy and fresh." },
    { name: "Earl Grey", temp: "98°C", time: "3-4 min", description: "Black tea flavored with bergamot oil." },
    { name: "Oolong", temp: "85°C", time: "3-5 min", description: "Traditional semi-oxidized Chinese tea." },
    { name: "Chamomile", temp: "100°C", time: "5 min", description: "Herbal infusion, calming and caffeine-free." },
    { name: "Matcha", temp: "80°C", time: "Whisk", description: "Finely ground powder of green tea leaves." }
  ];

  @State selectedTeaIndex: number = 0;

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column().width('100%').height('100%').backgroundColor('#FFFFFF')

      // Main Content
      Column() {
        // Header
        this.HeaderSection()

        // Spacer
        Blank().height(32)

        // Visualization
        this.BrewingVisualizer(this.teaPresets[this.selectedTeaIndex])

        // Spacer
        Blank().height(40)

        // Stats Row
        Row() {
          this.InfoItem("TEMP", this.teaPresets[this.selectedTeaIndex].temp)
          Blank()
          this.VerticalDivider()
          Blank()
          this.InfoItem("TIME", this.teaPresets[this.selectedTeaIndex].time)
          Blank()
          this.VerticalDivider()
          Blank()
          this.InfoItem("AMOUNT", "250ml")
        }
        .width('100%')
        .padding({ left: 24, right: 24 })

        // Spacer
        Blank().height(40)

        // Selection List
        Column() {
          Text("Select Variety")
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .margin({ left: 4, bottom: 12 })

          // Horizontal Scroll
          Scroll() {
            Row({ space: 12 }) {
              ForEach(this.teaPresets, (tea: TeaPreset, index: number) => {
                Text(tea.name)
                  .fontSize(14)
                  .fontWeight(index === this.selectedTeaIndex ? FontWeight.Bold : FontWeight.Normal)
                  .fontColor(index === this.selectedTeaIndex ? '#FFFFFF' : '#000000')
                  .padding({ left: 20, right: 20, top: 10, bottom: 10 })
                  .backgroundColor(index === this.selectedTeaIndex ? '#000000' : '#FFFFFF')
                  .border({
                    width: 1,
                    color: index === this.selectedTeaIndex ? '#000000' : '#E0E0E0',
                    radius: 20
                  })
                  .onClick(() => {
                    this.selectedTeaIndex = index;
                  })
              })
            }
            .padding({ left: 4, right: 4 })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')
        }
        .width('100%')
        .padding({ left: 24, right: 24 })

        // Spacer
        Blank()

        // Action Button
        Button() {
          Row() {
            Text('▶').fontSize(20).fontColor('#FFFFFF')
            Text("START TIMER")
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
              .margin({ left: 8 })
          }
          .width('100%')
          .height(56)
          .justifyContent(FlexAlign.Center)
        }
        .backgroundColor('#000000')
        .borderRadius(16)
        .width('100%')
        .margin({ bottom: 32 })
        .padding({ left: 24, right: 24 })
      }
      .width('100%')
      .height('100%')
      .padding({ top: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  // Header Component
  @Builder HeaderSection() {
    Row() {
      Column() {
        Text("Tea Master")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Text("Perfect brew, every time")
          .fontSize(12)
          .fontColor('#808080')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Text('⚙')
        .fontSize(24)
        .fontColor('#000000')
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
  }

  // Brewing Visualizer Component
  @Builder BrewingVisualizer(tea: TeaPreset) {
    Stack({ alignContent: Alignment.Center }) {
      // Background Circle
      Circle({ width: 220, height: 220 })
        .fill('#F5F5F5')

      // Inner Content
      Column() {
        Text('♥')
          .fontSize(48)
          .fontColor('#8D6E63')
        Text(tea.name)
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .margin({ top: 8 })
      }
    }
    .width(220)
    .height(220)
  }

  // Info Item Component
  @Builder InfoItem(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#808080')
        .letterSpacing(1)
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  // Vertical Divider Component
  @Builder VerticalDivider() {
    Column()
      .width(1)
      .height(40)
      .backgroundColor('#E0E0E0')
  }
}