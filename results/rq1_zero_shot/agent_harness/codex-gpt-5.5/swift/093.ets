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
struct TeaBrewingScreen {
  @State private selectedTeaIndex: number = 0;
  private teaPresets: TeaPreset[] = [
    new TeaPreset('Sencha', '70°C', '1-2 min', 'Japanese green tea, grassy and fresh.'),
    new TeaPreset('Earl Grey', '98°C', '3-4 min', 'Black tea flavored with bergamot oil.'),
    new TeaPreset('Oolong', '85°C', '3-5 min', 'Traditional semi-oxidized Chinese tea.'),
    new TeaPreset('Chamomile', '100°C', '5 min', 'Herbal infusion, calming and caffeine-free.'),
    new TeaPreset('Matcha', '80°C', 'Whisk', 'Finely ground powder of green tea leaves.')
  ];

  private selectedTea(): TeaPreset {
    return this.teaPresets[this.selectedTeaIndex];
  }

  @Builder
  private HeaderSection() {
    Row() {
      Column({ space: 4 }) {
        Text('Tea Master')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text('Perfect brew, every time')
          .fontSize(12)
          .fontColor('#808080')
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
      Button('⚙')
        .fontSize(24)
        .fontColor(Color.Black)
        .backgroundColor(Color.Transparent)
    }
    .width('100%')
  }

  @Builder
  private BrewingVisualizer() {
    Stack() {
      Circle()
        .width(220)
        .height(220)
        .fill('#F5F5F5')
      Column({ space: 8 }) {
        Text('♥')
          .fontSize(48)
          .fontColor('#8D6E63')
        Text(this.selectedTea().name)
          .fontSize(22)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(Color.Black)
      }
    }
    .width(220)
    .height(220)
  }

  @Builder
  private VerticalDivider() {
    Rect()
      .width(1)
      .height(40)
      .fill('#E0E0E0')
  }

  @Builder
  private InfoItem(label: string, value: string) {
    Column({ space: 4 }) {
      Text(label)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#808080')
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
  }

  @Builder
  private BrewStatsRow() {
    Row() {
      this.InfoItem('TEMP', this.selectedTea().temp)
      Blank()
      this.VerticalDivider()
      Blank()
      this.InfoItem('TIME', this.selectedTea().time)
      Blank()
      this.VerticalDivider()
      Blank()
      this.InfoItem('AMOUNT', '250ml')
    }
    .width('100%')
  }

  @Builder
  private TeaChip(name: string, index: number) {
    Text(name)
      .fontSize(14)
      .fontWeight(this.selectedTeaIndex === index ? FontWeight.Bold : FontWeight.Regular)
      .fontColor(this.selectedTeaIndex === index ? Color.White : Color.Black)
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      .backgroundColor(this.selectedTeaIndex === index ? Color.Black : Color.White)
      .border({ width: 1, color: this.selectedTeaIndex === index ? Color.Black : '#E0E0E0' })
      .borderRadius(20)
      .onClick(() => {
        this.selectedTeaIndex = index;
      })
  }

  @Builder
  private TeaSelector() {
    Column({ space: 12 }) {
      Text('Select Variety')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .padding({ left: 4 })
        .width('100%')
        .textAlign(TextAlign.Start)
      Scroll() {
        Row({ space: 12 }) {
          ForEach(this.teaPresets, (preset: TeaPreset, index: number) => {
            this.TeaChip(preset.name, index)
          })
        }
        .padding({ left: 4, right: 4 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }

  @Builder
  private StartBrewButton() {
    Button('▶  START TIMER')
      .height(56)
      .width('100%')
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor(Color.White)
      .backgroundColor(Color.Black)
      .borderRadius(16)
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        this.HeaderSection()
          .padding({ top: 24, left: 24, right: 24 })
        Blank().height(32)
        this.BrewingVisualizer()
        Blank().height(40)
        this.BrewStatsRow()
          .padding({ left: 24, right: 24 })
        Blank().height(40)
        this.TeaSelector()
          .padding({ left: 24, right: 24 })
        Blank()
        this.StartBrewButton()
          .padding({ left: 24, right: 24, bottom: 32 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
