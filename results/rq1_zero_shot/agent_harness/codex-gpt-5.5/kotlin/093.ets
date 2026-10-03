class TeaPreset {
  name: string;
  temp: string;
  time: string;
  description: string;

  constructor(name: string, temp: string, time: string, description: string) {
    this.name = name;
    this.temp = temp;
    this.time = time;
    this.description = description;
  }
}

@Entry
@Component
struct MainActivity {
  @State selectedIndex: number = 0;

  private presets: TeaPreset[] = [
    new TeaPreset('Sencha', '70°C', '1-2 min', 'Japanese green tea, grassy and fresh.'),
    new TeaPreset('Earl Grey', '98°C', '3-4 min', 'Black tea flavored with bergamot oil.'),
    new TeaPreset('Oolong', '85°C', '3-5 min', 'Traditional semi-oxidized Chinese tea.'),
    new TeaPreset('Chamomile', '100°C', '5 min', 'Herbal infusion, calming and caffeine-free.'),
    new TeaPreset('Matcha', '80°C', 'Whisk', 'Finely ground powder of green tea leaves.')
  ];

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Tea Master')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Text('Perfect brew, every time')
          .fontSize(12)
          .fontColor('#808080')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      Text('⚙')
        .fontSize(24)
        .fontColor('#000000')
        .width(44)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BrewingVisualizer(tea: TeaPreset) {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(180)
        .height(180)
        .fill('#F5F5F5')
      Column() {
        Text('♥')
          .fontSize(48)
          .fontColor('#8D6E63')
        Text(tea.name)
          .fontSize(20)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#000000')
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(220)
    .height(220)
  }

  @Builder
  InfoItem(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#808080')
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  BrewStatsRow(tea: TeaPreset) {
    Row() {
      this.InfoItem('TEMP', tea.temp)
      Divider().vertical(true).height(40).color('#E0E0E0')
      this.InfoItem('TIME', tea.time)
      Divider().vertical(true).height(40).color('#E0E0E0')
      this.InfoItem('AMOUNT', '250ml')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TeaChip(preset: TeaPreset, index: number) {
    Text(preset.name)
      .fontSize(14)
      .fontWeight(this.selectedIndex === index ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(this.selectedIndex === index ? '#FFFFFF' : '#000000')
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      .backgroundColor(this.selectedIndex === index ? '#000000' : '#FFFFFF')
      .border({ width: 1, color: this.selectedIndex === index ? '#000000' : '#E0E0E0' })
      .borderRadius(25)
      .onClick(() => {
        this.selectedIndex = index;
      })
  }

  @Builder
  TeaSelector() {
    Column() {
      Text('Select Variety')
        .fontSize(14)
        .fontColor('#000000')
        .width('100%')
        .margin({ left: 4, bottom: 12 })
      Row({ space: 12 }) {
        ForEach(this.presets, (preset: TeaPreset, index: number) => {
          this.TeaChip(preset, index)
        })
      }
      .width('100%')
      .padding({ left: 4, right: 4 })
    }
    .width('100%')
  }

  @Builder
  StartBrewButton() {
    Button('▶  START TIMER')
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor('#FFFFFF')
      .width('100%')
      .height(56)
      .backgroundColor('#000000')
      .borderRadius(16)
  }

  build() {
    Column() {
      this.HeaderSection()
      Blank().height(32)
      this.BrewingVisualizer(this.presets[this.selectedIndex])
      Blank().height(40)
      this.BrewStatsRow(this.presets[this.selectedIndex])
      Blank().height(40)
      this.TeaSelector()
      Blank().layoutWeight(1)
      this.StartBrewButton()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#FFFFFF')
  }
}
