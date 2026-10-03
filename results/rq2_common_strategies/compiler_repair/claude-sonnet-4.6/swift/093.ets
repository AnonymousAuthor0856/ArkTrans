// Models
interface TeaPreset {
  id: number;
  name: string;
  temp: string;
  time: string;
  description: string;
}

const teaPresets: TeaPreset[] = [
  { id: 0, name: 'Sencha', temp: '70°C', time: '1-2 min', description: 'Japanese green tea, grassy and fresh.' },
  { id: 1, name: 'Earl Grey', temp: '98°C', time: '3-4 min', description: 'Black tea flavored with bergamot oil.' },
  { id: 2, name: 'Oolong', temp: '85°C', time: '3-5 min', description: 'Traditional semi-oxidized Chinese tea.' },
  { id: 3, name: 'Chamomile', temp: '100°C', time: '5 min', description: 'Herbal infusion, calming and caffeine-free.' },
  { id: 4, name: 'Matcha', temp: '80°C', time: 'Whisk', description: 'Finely ground powder of green tea leaves.' },
];

@Entry
@Component
struct TeaBrewingScreen {
  @State selectedTeaIndex: number = 0;

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(Color.White)

      Column({ space: 0 }) {
        HeaderSection()
          .margin({ top: 48, left: 24, right: 24 })

        Column().height(32)

        BrewingVisualizer({ tea: teaPresets[this.selectedTeaIndex] })

        Column().height(40)

        BrewStatsRow({ tea: teaPresets[this.selectedTeaIndex] })
          .margin({ left: 24, right: 24 })

        Column().height(40)

        TeaSelector({
          presets: teaPresets,
          selectedIndex: this.selectedTeaIndex,
          onSelect: (index: number) => {
            this.selectedTeaIndex = index;
          }
        })
          .margin({ left: 24, right: 24 })

        Blank()

        StartBrewButton()
          .margin({ left: 24, right: 24, bottom: 32 })
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column({ space: 4 }) {
        Text('Tea Master')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Text('Perfect brew, every time')
          .fontSize(12)
          .fontColor(Color.Gray)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button({ type: ButtonType.Normal }) {
        Text('⚙')
          .fontSize(24)
          .fontColor(Color.Black)
      }
      .backgroundColor(Color.Transparent)
      .width(40)
      .height(40)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BrewingVisualizer {
  tea: TeaPreset = teaPresets[0];

  build() {
    Stack() {
      Circle()
        .width(220)
        .height(220)
        .fill('#F5F5F5')

      Column({ space: 8 }) {
        Text('♥')
          .fontSize(48)
          .fontColor('#8D6E63')

        Text(this.tea.name)
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(220)
    .alignContent(Alignment.Center)
  }
}

@Component
struct BrewStatsRow {
  tea: TeaPreset = teaPresets[0];

  build() {
    Row() {
      InfoItem({ label: 'TEMP', value: this.tea.temp })

      Blank()

      VerticalDivider()

      Blank()

      InfoItem({ label: 'TIME', value: this.tea.time })

      Blank()

      VerticalDivider()

      Blank()

      InfoItem({ label: 'AMOUNT', value: '250ml' })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct VerticalDivider {
  build() {
    Column()
      .width(1)
      .height(40)
      .backgroundColor('#E0E0E0')
  }
}

@Component
struct InfoItem {
  label: string = '';
  value: string = '';

  build() {
    Column({ space: 4 }) {
      Text(this.label)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Gray)
        .letterSpacing(1)

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct TeaSelector {
  presets: TeaPreset[] = [];
  selectedIndex: number = 0;
  onSelect: (index: number) => void = () => {};

  build() {
    Column({ space: 12 }) {
      Text('Select Variety')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ left: 4 })

      Scroll() {
        Row({ space: 12 }) {
          ForEach(this.presets, (preset: TeaPreset, index: number) => {
            TeaChip({
              name: preset.name,
              isSelected: index === this.selectedIndex,
              onChipClick: () => {
                this.onSelect(index);
              }
            })
          }, (preset: TeaPreset) => preset.id.toString())
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
}

@Component
struct TeaChip {
  name: string = '';
  isSelected: boolean = false;
  onChipClick: () => void = () => {};

  build() {
    Button({ type: ButtonType.Normal }) {
      Text(this.name)
        .fontSize(14)
        .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal)
        .fontColor(this.isSelected ? Color.White : Color.Black)
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })
    }
    .backgroundColor(this.isSelected ? Color.Black : Color.White)
    .borderRadius(50)
    .borderWidth(1)
    .borderColor(this.isSelected ? Color.Black : '#E0E0E0')
    .onClick(() => {
      this.onChipClick();
    })
  }
}

@Component
struct StartBrewButton {
  build() {
    Button({ type: ButtonType.Normal }) {
      Row({ space: 8 }) {
        Text('▶')
          .fontSize(20)
          .fontColor(Color.White)

        Text('START TIMER')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(56)
    .backgroundColor(Color.Black)
    .borderRadius(16)
  }
}