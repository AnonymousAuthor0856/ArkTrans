interface TeaPreset {
  name: string;
  temp: string;
  time: string;
  description: string;
}

const teaPresets: TeaPreset[] = [
  { name: 'Sencha', temp: '70°C', time: '1-2 min', description: 'Japanese green tea, grassy and fresh.' },
  { name: 'Earl Grey', temp: '98°C', time: '3-4 min', description: 'Black tea flavored with bergamot oil.' },
  { name: 'Oolong', temp: '85°C', time: '3-5 min', description: 'Traditional semi-oxidized Chinese tea.' },
  { name: 'Chamomile', temp: '100°C', time: '5 min', description: 'Herbal infusion, calming and caffeine-free.' },
  { name: 'Matcha', temp: '80°C', time: 'Whisk', description: 'Finely ground powder of green tea leaves.' }
];

@Entry
@Component
struct TeaMasterPage {
  @State selectedIndex: number = 0;

  build() {
    Column() {
      this.HeaderSection()

      Blank().height(32)

      this.BrewingVisualizer(teaPresets[this.selectedIndex])

      Blank().height(40)

      this.BrewStatsRow(teaPresets[this.selectedIndex])

      Blank().height(40)

      this.TeaSelector()

      Blank()

      this.StartBrewButton()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Tea Master')
          .fontSize(28)
          .fontColor('#000000')
          .fontWeight(FontWeight.Bold)
        Text('Perfect brew, every time')
          .fontSize(12)
          .fontColor('#888888')
      }
      .alignItems(HorizontalAlign.Start)

      Text('⚙')
        .fontSize(24)
        .fontColor('#000000')
        .onClick(() => {})
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BrewingVisualizer(tea: TeaPreset) {
    Stack() {
      Stack() {
        Column() {
          Text('♥')
            .fontSize(48)
            .fontColor('#8D6E63')
          Blank().height(8)
          Text(tea.name)
            .fontSize(22)
            .fontColor('#000000')
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(180)
      .height(180)
      .borderRadius(90)
      .backgroundColor('#F5F5F5')
      .alignContent(Alignment.Center)
    }
    .width(220)
    .height(220)
    .alignContent(Alignment.Center)
  }

  @Builder
  BrewStatsRow(tea: TeaPreset) {
    Row() {
      this.InfoItem('TEMP', tea.temp)
      this.VerticalDivider()
      this.InfoItem('TIME', tea.time)
      this.VerticalDivider()
      this.InfoItem('AMOUNT', '250ml')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  @Builder
  VerticalDivider() {
    Row()
      .height(40)
      .width(1)
      .backgroundColor('#E0E0E0')
  }

  @Builder
  InfoItem(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(11)
        .fontColor('#888888')
        .fontWeight(FontWeight.Bold)
        .letterSpacing(1)
      Blank().height(4)
      Text(value)
        .fontSize(16)
        .fontColor('#000000')
        .fontWeight(FontWeight.Medium)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  TeaSelector() {
    Column() {
      Text('Select Variety')
        .fontSize(14)
        .fontColor('#000000')
        .padding({ left: 4, bottom: 12 })

      Scroll() {
        Row({ space: 12 }) {
          ForEach(teaPresets, (preset: TeaPreset) => {
            this.TeaChip(preset, preset.name === teaPresets[this.selectedIndex].name)
          }, (preset: TeaPreset) => preset.name)
        }
        .padding({ left: 4, right: 4 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  TeaChip(preset: TeaPreset, isSelected: boolean) {
    Text(preset.name)
      .fontSize(14)
      .fontColor(isSelected ? '#FFFFFF' : '#000000')
      .fontWeight(isSelected ? FontWeight.Bold : FontWeight.Normal)
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      .backgroundColor(isSelected ? '#000000' : '#FFFFFF')
      .borderRadius(50)
      .border({ width: 1, color: isSelected ? '#000000' : '#E0E0E0' })
      .onClick(() => {
        for (let i = 0; i < teaPresets.length; i++) {
          if (teaPresets[i].name === preset.name) {
            this.selectedIndex = i;
            break;
          }
        }
      })
  }

  @Builder
  StartBrewButton() {
    Button() {
      Row() {
        Text('▶')
          .fontSize(20)
          .fontColor('#FFFFFF')
        Blank().width(8)
        Text('START TIMER')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(56)
    .backgroundColor('#000000')
    .borderRadius(16)
    .onClick(() => {})
  }
}
