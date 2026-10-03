/*
 * Tea Master — ArkTS / ArkUI port of the Jetpack Compose TeaBrewingScreen.
 */

/* ------------------------------ Domain model ------------------------------ */

class TeaPreset {
  name: string;
  temp: string;
  steep: string;
  description: string;

  constructor(name: string, temp: string, steep: string, description: string) {
    this.name = name;
    this.temp = temp;
    this.steep = steep;
    this.description = description;
  }
}

/* ------------------------------- Sample data ------------------------------ */

const TEA_PRESETS: TeaPreset[] = [
  new TeaPreset('Sencha', '70°C', '1-2 min', 'Japanese green tea, grassy and fresh.'),
  new TeaPreset('Earl Grey', '98°C', '3-4 min', 'Black tea flavored with bergamot oil.'),
  new TeaPreset('Oolong', '85°C', '3-5 min', 'Traditional semi-oxidized Chinese tea.'),
  new TeaPreset('Chamomile', '100°C', '5 min', 'Herbal infusion, calming and caffeine-free.'),
  new TeaPreset('Matcha', '80°C', 'Whisk', 'Finely ground powder of green tea leaves.')
];

/* ----------------------------- Brewing circle ----------------------------- */

@Component
struct BrewingVisualizer {
  @Prop teaName: string = '';

  build() {
    Column() {
      SymbolGlyph($r('sys.symbol.heart_fill'))
        .fontSize(48)
        .fontColor(['#8D6E63'])
      Text(this.teaName)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ top: 8 })
    }
    .width(180)
    .height(180)
    .borderRadius(90)
    .backgroundColor('#F5F5F5')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}

/* ------------------------------ Stats readout ----------------------------- */

@Component
struct InfoItem {
  @Prop label: string = '';
  @Prop value: string = '';

  build() {
    Column() {
      Text(this.label)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#9E9E9E')
        .letterSpacing(1)
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct BrewStatsRow {
  @Prop temp: string = '';
  @Prop steep: string = '';
  @Prop amount: string = '250ml';

  build() {
    Row() {
      InfoItem({ label: 'TEMP', value: this.temp })
      Divider().vertical(true).height(40).strokeWidth(1).color('#E0E0E0')
      InfoItem({ label: 'TIME', value: this.steep })
      Divider().vertical(true).height(40).strokeWidth(1).color('#E0E0E0')
      InfoItem({ label: 'AMOUNT', value: this.amount })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
  }
}

/* --------------------------------- Chip ---------------------------------- */

@Component
struct TeaChip {
  @Prop name: string = '';
  @Prop isSelected: boolean = false;
  onTap: () => void = () => {};

  build() {
    Row() {
      Text(this.name)
        .fontSize(14)
        .fontColor(this.isSelected ? Color.White : Color.Black)
        .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal)
    }
    .padding({ left: 20, right: 20, top: 10, bottom: 10 })
    .backgroundColor(this.isSelected ? Color.Black : Color.White)
    .borderRadius(50)
    .border({ width: 1, color: this.isSelected ? Color.Black : '#E0E0E0' })
    .onClick(() => {
      this.onTap();
    })
  }
}

/* ------------------------------ Tea selector ------------------------------ */

@Component
struct TeaSelector {
  presets: TeaPreset[] = [];
  @Prop selectedIndex: number = 0;
  onSelect: (index: number) => void = () => {};

  build() {
    Column() {
      Text('Select Variety')
        .fontSize(14)
        .fontColor(Color.Black)
        .width('100%')
        .padding({ left: 4, bottom: 12 })

      Scroll() {
        Row({ space: 12 }) {
          ForEach(this.presets, (item: TeaPreset, index?: number) => {
            TeaChip({
              name: item.name,
              isSelected: this.selectedIndex === index,
              onTap: () => {
                this.onSelect(index!);
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
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

/* ------------------------------ Start button ------------------------------ */

@Component
struct StartBrewButton {
  onTap: () => void = () => {};

  build() {
    Button({ type: ButtonType.Normal, stateEffect: true }) {
      Row() {
        SymbolGlyph($r('sys.symbol.play_fill'))
          .fontSize(20)
          .fontColor([Color.White])
        Text('START TIMER')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ left: 8 })
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(56)
    .borderRadius(16)
    .backgroundColor(Color.Black)
    .padding(0)
    .onClick(() => {
      this.onTap();
    })
  }
}

/* --------------------------------- Screen --------------------------------- */

@Entry
@Component
struct TeaMasterPage {
  @State selectedIndex: number = 0;
  private presets: TeaPreset[] = TEA_PRESETS;

  private currentTea(): TeaPreset {
    return this.presets[this.selectedIndex];
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Tea Master')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text('Perfect brew, every time')
          .fontSize(12)
          .fontColor('#9E9E9E')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row() {
        SymbolGlyph($r('sys.symbol.gearshape'))
          .fontSize(24)
          .fontColor([Color.Black])
      }
      .width(40)
      .height(40)
      .justifyContent(FlexAlign.Center)
      .onClick(() => {
        // No-op, matches the Compose sample.
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      this.HeaderSection()

      BrewingVisualizer({ teaName: this.currentTea().name })
        .margin({ top: 32 })

      BrewStatsRow({
        temp: this.currentTea().temp,
        steep: this.currentTea().steep,
        amount: '250ml'
      })
        .margin({ top: 40 })

      TeaSelector({
        presets: this.presets,
        selectedIndex: this.selectedIndex,
        onSelect: (index: number) => {
          this.selectedIndex = index;
        }
      })
        .margin({ top: 40 })

      Blank()

      StartBrewButton({
        onTap: () => {
          // No-op, matches the Compose sample.
        }
      })
        .margin({ top: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}