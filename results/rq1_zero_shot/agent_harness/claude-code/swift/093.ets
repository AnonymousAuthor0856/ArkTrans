@Entry
@Component
struct TeaMasterApp {
  @State selectedTeaIndex: number = 0;

  aboutToAppear() {
    StatusBarUtils.hideStatusBar();
  }

  build() {
    Stack() {
      TeaBrewingScreen({ selectedTeaIndex: $selectedTeaIndex })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

interface TeaPreset {
  id: string;
  name: string;
  temp: string;
  time: string;
  description: string;
}

@Component
struct TeaBrewingScreen {
  @Link selectedTeaIndex: number;

  private teaPresets: TeaPreset[] = [
    { id: '1', name: 'Sencha', temp: '70°C', time: '1-2 min', description: 'Japanese green tea, grassy and fresh.' },
    { id: '2', name: 'Earl Grey', temp: '98°C', time: '3-4 min', description: 'Black tea flavored with bergamot oil.' },
    { id: '3', name: 'Oolong', temp: '85°C', time: '3-5 min', description: 'Traditional semi-oxidized Chinese tea.' },
    { id: '4', name: 'Chamomile', temp: '100°C', time: '5 min', description: 'Herbal infusion, calming and caffeine-free.' },
    { id: '5', name: 'Matcha', temp: '80°C', time: 'Whisk', description: 'Finely ground powder of green tea leaves.' }
  ];

  build() {
    Stack() {
      Column() {
        HeaderSection()
          .margin({ top: 24, left: 24, right: 24 })

        Blank()
          .height(32)

        BrewingVisualizer({ tea: this.teaPresets[this.selectedTeaIndex] })

        Blank()
          .height(40)

        BrewStatsRow({ tea: this.teaPresets[this.selectedTeaIndex] })
          .margin({ left: 24, right: 24 })

        Blank()
          .height(40)

        TeaSelector({ presets: this.teaPresets, selectedIndex: $selectedTeaIndex })
          .margin({ left: 24, right: 24 })

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
          .fontColor(Color.Gray)
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
      .onClick(() => {})
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BrewingVisualizer {
  @Prop tea: TeaPreset;

  build() {
    Stack() {
      Circle({ width: 220, height: 220 })
        .fill('#F5F5F5')

      Column() {
        // heart shape approximated with a custom path icon
        Text('♥')
          .fontSize(48)
          .fontColor('#8D6E63')

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
  @Prop label: string = '';
  @Prop value: string = '';

  build() {
    Column() {
      Text(this.label)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Gray)
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
  @Prop presets: TeaPreset[] = [];
  @Link selectedIndex: number;

  build() {
    Column() {
      Text('Select Variety')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ left: 4, bottom: 12 })

      Scroll() {
        Row() {
          ForEach(this.presets, (item: TeaPreset, index: number) => {
            TeaChip({
              name: item.name,
              isSelected: index === this.selectedIndex,
              onClick: () => { this.selectedIndex = index; }
            })
            .margin({ right: index < this.presets.length - 1 ? 12 : 0 })
          }, (item: TeaPreset) => item.id)
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
  @Prop name: string = '';
  @Prop isSelected: boolean = false;
  @Prop onClick: () => void = () => {};

  build() {
    Text(this.name)
      .fontSize(14)
      .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(this.isSelected ? Color.White : Color.Black)
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      .backgroundColor(this.isSelected ? Color.Black : Color.White)
      .border({
        width: 1,
        color: this.isSelected ? Color.Black : '#E0E0E0'
      })
      .borderRadius(999)
      .onClick(() => { this.onClick(); })
  }
}

@Component
struct StartBrewButton {
  build() {
    Button() {
      Row() {
        Text('▶')
          .fontSize(20)
          .fontColor(Color.White)
        Text('START TIMER')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ left: 8 })
      }
    }
    .width('100%')
    .height(56)
    .backgroundColor(Color.Black)
    .borderRadius(16)
    .onClick(() => {})
  }
}

namespace StatusBarUtils {
  export function hideStatusBar(): void {
    // Status bar hiding handled by window manager in production
  }
}
