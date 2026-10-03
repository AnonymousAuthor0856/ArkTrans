// TeaBrewingScreen.ets

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
          .fontColor('#8A8A8A')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Text('⚙')
        .fontSize(24)
        .fontColor(Color.Black)
        .onClick(() => {
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct BrewingVisualizer {
  @Prop tea: TeaPreset;

  build() {
    Stack({ alignContent: Alignment.Center }) {
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
    }
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
        .fontColor('#8A8A8A')

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct VerticalDivider {
  build() {
    Divider()
      .vertical(true)
      .height(40)
      .strokeWidth(1)
      .color('#E0E0E0')
  }
}

@Component
struct BrewStatsRow {
  @Prop tea: TeaPreset;

  build() {
    Row() {
      InfoItem({ label: 'TEMP', value: this.tea.temp })
        .layoutWeight(1)

      VerticalDivider()

      InfoItem({ label: 'TIME', value: this.tea.time })
        .layoutWeight(1)

      VerticalDivider()

      InfoItem({ label: 'AMOUNT', value: '250ml' })
        .layoutWeight(1)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TeaChip {
  name: string = '';
  isSelected: boolean = false;
  onClick: () => void = () => {
  };

  build() {
    Text(this.name)
      .fontSize(14)
      .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(this.isSelected ? Color.White : Color.Black)
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      .backgroundColor(this.isSelected ? Color.Black : Color.White)
      .borderRadius(20)
      .border({
        width: 1,
        color: this.isSelected ? Color.Black : '#E0E0E0'
      })
      .onClick(() => {
        this.onClick();
      })
  }
}

@Component
struct TeaSelector {
  presets: TeaPreset[] = [];
  @Link selectedIndex: number;
  private scroller: Scroller = new Scroller();

  build() {
    Column({ space: 12 }) {
      Text('Select Variety')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .padding({ left: 4 })

      Scroll(this.scroller) {
        Row({ space: 12 }) {
          ForEach(this.presets, (item: TeaPreset, index: number) => {
            TeaChip({
              name: item.name,
              isSelected: index === this.selectedIndex,
              onClick: () => {
                this.selectedIndex = index;
              }
            })
          }, (item: TeaPreset) => item.name)
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
struct StartBrewButton {
  build() {
    Button({ type: ButtonType.Normal, stateEffect: true }) {
      Row({ space: 8 }) {
        Text('▶')
          .fontSize(20)
          .fontColor(Color.White)

        Text('START TIMER')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(56)
    .backgroundColor(Color.Black)
    .borderRadius(16)
    .onClick(() => {
    })
  }
}

@Entry
@Component
struct TeaBrewingScreen {
  private presets: TeaPreset[] = [
    new TeaPreset('Sencha', '70°C', '1-2 min', 'Japanese green tea, grassy and fresh.'),
    new TeaPreset('Earl Grey', '98°C', '3-4 min', 'Black tea flavored with bergamot oil.'),
    new TeaPreset('Oolong', '85°C', '3-5 min', 'Traditional semi-oxidized Chinese tea.'),
    new TeaPreset('Chamomile', '100°C', '5 min', 'Herbal infusion, calming and caffeine-free.'),
    new TeaPreset('Matcha', '80°C', 'Whisk', 'Finely ground powder of green tea leaves.')
  ];

  @State selectedIndex: number = 0;

  build() {
    Column() {
      HeaderSection()
        .margin({ top: 24, left: 24, right: 24 })

      BrewingVisualizer({ tea: this.presets[this.selectedIndex] })
        .margin({ top: 32 })

      BrewStatsRow({ tea: this.presets[this.selectedIndex] })
        .margin({ top: 40, left: 24, right: 24 })

      TeaSelector({
        presets: this.presets,
        selectedIndex: $selectedIndex
      })
        .margin({ top: 40, left: 24, right: 24 })

      Blank()

      StartBrewButton()
        .margin({ left: 24, right: 24, bottom: 32 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}