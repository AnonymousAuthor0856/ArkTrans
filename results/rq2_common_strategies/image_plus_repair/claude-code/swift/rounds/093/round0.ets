@Entry
@Component
struct TeaMasterApp {
  @State selectedTeaIndex: number = 0;

  private teaPresets: TeaPreset[] = [
    { name: 'Sencha', temp: '70°C', time: '1-2 min', description: 'Japanese green tea, grassy and fresh.' },
    { name: 'Earl Grey', temp: '98°C', time: '3-4 min', description: 'Black tea flavored with bergamot oil.' },
    { name: 'Oolong', temp: '85°C', time: '3-5 min', description: 'Traditional semi-oxidized Chinese tea.' },
    { name: 'Chamomile', temp: '100°C', time: '5 min', description: 'Herbal infusion, calming and caffeine-free.' },
    { name: 'Matcha', temp: '80°C', time: 'Whisk', description: 'Finely ground powder of green tea leaves.' }
  ];

  build() {
    Stack() {
      Column() {
        HeaderSection()
          .margin({ top: 24, left: 24, right: 24 })

        BrewingVisualizer({ tea: this.teaPresets[this.selectedTeaIndex] })
          .margin({ top: 32 })

        BrewStatsRow({ tea: this.teaPresets[this.selectedTeaIndex] })
          .margin({ top: 40, left: 24, right: 24 })

        TeaSelector({
          presets: this.teaPresets,
          selectedIndex: $selectedTeaIndex
        })
          .margin({ top: 40, left: 24, right: 24 })

        Blank()

        StartBrewButton()
          .margin({ left: 24, right: 24, bottom: 32 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

interface TeaPreset {
  name: string;
  temp: string;
  time: string;
  description: string;
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('Tea Master')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text('Perfect brew, every time')
          .fontSize(12)
          .fontColor('#888888')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Image($r('sys.media.ohos_ic_public_settings'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .type(ButtonType.Circle)
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
  tea: TeaPreset;

  build() {
    Stack() {
      Circle({ width: 220, height: 220 })
        .fill('#F5F5F5')

      Column() {
        // Heart shape using Path
        Path()
          .commands(this.heartPathCommands())
          .fill('#8D6E63')
          .width(48)
          .height(48)

        Text(this.tea.name)
          .fontSize(22)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(Color.Black)
          .margin({ top: 8 })
      }
    }
    .width(220)
    .height(220)
  }

  private heartPathCommands(): string {
    return 'M 24 42 C 24 42 6 28 6 16 C 6 8 12 4 18 4 C 21 4 24 6 24 9 C 24 6 27 4 30 4 C 36 4 42 8 42 16 C 42 28 24 42 24 42 Z';
  }
}

@Component
struct BrewStatsRow {
  tea: TeaPreset;

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
  }
}

@Component
struct VerticalDivider {
  build() {
    Rect({ width: 1, height: 40 })
      .fill('#E0E0E0')
  }
}

@Component
struct InfoItem {
  label: string;
  value: string;

  build() {
    Column() {
      Text(this.label)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#888888')
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
struct TeaSelector {
  presets: TeaPreset[];
  @Link selectedIndex: number;

  build() {
    Column() {
      Text('Select Variety')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ left: 4 })

      Scroll() {
        Row() {
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
      .margin({ top: 12 })
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct TeaChip {
  name: string;
  isSelected: boolean;
  onClick: () => void;

  build() {
    Text(this.name)
      .fontSize(14)
      .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Regular)
      .fontColor(this.isSelected ? Color.White : Color.Black)
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      .backgroundColor(this.isSelected ? Color.Black : Color.White)
      .border({
        width: 1,
        color: this.isSelected ? Color.Black : '#E0E0E0'
      })
      .borderRadius(999)
      .onClick(() => {
        this.onClick();
      })
  }
}

@Component
struct StartBrewButton {
  build() {
    Button() {
      Row() {
        // Play icon using Path
        Path()
          .commands('M 8 5 L 8 19 L 18 12 Z')
          .fill(Color.White)
          .width(20)
          .height(20)

        Text('START TIMER')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ left: 8 })
      }
    }
    .type(ButtonType.Normal)
    .backgroundColor(Color.Black)
    .borderRadius(16)
    .height(56)
    .width('100%')
  }
}
