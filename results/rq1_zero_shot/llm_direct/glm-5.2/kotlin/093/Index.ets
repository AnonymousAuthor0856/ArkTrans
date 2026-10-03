// Index.ets
interface TeaPreset {
  name: string;
  temp: string;
  time: string;
  description: string;
}

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
  @State selectedTeaIndex: number = 0;

  build() {
    Column() {
      // Header
      Row() {
        Column() {
          Text("Tea Master")
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor("#000000")
          Text("Perfect brew, every time")
            .fontSize(14)
            .fontColor("#9E9E9E")
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)

        Blank() // Pushes settings icon to the right

        Image($r("app.media.settings_icon"))
          .width(24)
          .height(24)
          .fillColor("#000000")
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Visualization Circle
      Column() {
        Column() {
          Image($r("app.media.heart_icon"))
            .width(48)
            .height(48)
            .fillColor("#8D6E63")
            .margin({ bottom: 8 })
          Text(teaPresets[this.selectedTeaIndex].name)
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor("#000000")
        }
        .width(180)
        .height(180)
        .borderRadius(90)
        .backgroundColor("#F5F5F5")
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
      .width(220)
      .height(220)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .margin({ top: 32 })

      // Stats Row
      Row() {
        this.InfoItem("TEMP", teaPresets[this.selectedTeaIndex].temp)
        
        Divider()
          .vertical(true)
          .height(40)
          .width(1)
          .color("#E0E0E0")
          .margin({ left: 10, right: 10 })

        this.InfoItem("TIME", teaPresets[this.selectedTeaIndex].time)
        
        Divider()
          .vertical(true)
          .height(40)
          .width(1)
          .color("#E0E0E0")
          .margin({ left: 10, right: 10 })

        this.InfoItem("AMOUNT", "250ml")
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 40 })

      // Selection List
      Column() {
        Text("Select Variety")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor("#000000")
          .margin({ left: 4, bottom: 12 })

        // Horizontal Scroller for Tea Chips
        Row() {
          ForEach(teaPresets, (preset: TeaPreset, index: number) => {
            this.TeaChip(preset, index === this.selectedTeaIndex, () => {
              this.selectedTeaIndex = index;
            })
          })
        }
        .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 40 })

      // Spacer to push button down
      Blank()

      // Action Button
      Button({ type: ButtonType.Normal }) {
        Row() {
          Image($r("app.media.play_arrow_icon"))
            .width(20)
            .height(20)
            .fillColor("#FFFFFF")
            .margin({ right: 8 })
          Text("START TIMER")
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor("#FFFFFF")
        }
      }
      .width('100%')
      .height(56)
      .borderRadius(16)
      .backgroundColor("#000000")
      .margin({ bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    .backgroundColor("#FFFFFF")
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  InfoItem(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor("#9E9E9E")
        .letterSpacing(1)
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor("#000000")
        .margin({ top: 4 })
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  TeaChip(preset: TeaPreset, isSelected: boolean, onClick: () => void) {
    Text(preset.name)
      .fontSize(14)
      .fontWeight(isSelected ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(isSelected ? "#FFFFFF" : "#000000")
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      .borderRadius(50)
      .backgroundColor(isSelected ? "#000000" : "#FFFFFF")
      .border({ width: 1, color: isSelected ? "#000000" : "#E0E0E0" })
      .margin({ right: 12 })
      .onClick(onClick)
  }
}