import { router } from '@kit.ArkUI';

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
  { id: 4, name: 'Matcha', temp: '80°C', time: 'Whisk', description: 'Finely ground powder of green tea leaves.' }
];

// Header Component
@Component
struct HeaderSection {
  build() {
    Row() {
      Column({ space: 4 }) {
        Text('Tea Master')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Text('Perfect brew, every time')
          .fontSize(12)
          .fontColor('#888888')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button({ type: ButtonType.Normal }) {
        Image($r('sys.media.ohos_ic_public_settings'))
          .width(24)
          .height(24)
          .fillColor('#000000')
      }
      .backgroundColor(Color.Transparent)
      .width(40)
      .height(40)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

// Brewing Visualizer Component
@Component
struct BrewingVisualizer {
  @Prop tea: TeaPreset = teaPresets[0];

  build() {
    Stack() {
      Circle()
        .width(220)
        .height(220)
        .fill('#F5F5F5')

      Column({ space: 8 }) {
        Image($r('sys.media.ohos_ic_public_heart'))
          .width(48)
          .height(48)
          .fillColor('#8D6E63')

        Text(this.tea.name)
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width(220)
    .height(220)
    .alignContent(Alignment.Center)
  }
}

// Info Item Component
@Component
struct InfoItem {
  @Prop label: string = '';
  @Prop value: string = '';

  build() {
    Column({ space: 4 }) {
      Text(this.label)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#888888')
        .letterSpacing(1)

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// Vertical Divider Component
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

// Brew Stats Row Component
@Component
struct BrewStatsRow {
  @Prop tea: TeaPreset = teaPresets[0];

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
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

// Tea Chip Component
@Component
struct TeaChip {
  @Prop name: string = '';
  @Prop isSelected: boolean = false;
  onClick: () => void = () => {};

  build() {
    Button(this.name, { type: ButtonType.Capsule })
      .fontSize(14)
      .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(this.isSelected ? '#FFFFFF' : '#000000')
      .backgroundColor(this.isSelected ? '#000000' : '#FFFFFF')
      .border({
        width: 1,
        color: this.isSelected ? '#000000' : '#E0E0E0',
        style: BorderStyle.Solid
      })
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      .onClick(() => {
        this.onClick();
      })
  }
}

// Tea Selector Component
@Component
struct TeaSelector {
  @Prop presets: TeaPreset[] = [];
  @Link selectedIndex: number;

  build() {
    Column({ space: 12 }) {
      Text('Select Variety')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .padding({ left: 4 })
        .alignSelf(ItemAlign.Start)

      Scroll() {
        Row({ space: 12 }) {
          ForEach(this.presets, (preset: TeaPreset, index: number) => {
            TeaChip({
              name: preset.name,
              isSelected: index === this.selectedIndex,
              onClick: () => {
                this.selectedIndex = index;
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

// Start Brew Button Component
@Component
struct StartBrewButton {
  build() {
    Button({ type: ButtonType.Normal }) {
      Row({ space: 8 }) {
        Image($r('sys.media.ohos_ic_public_play'))
          .width(20)
          .height(20)
          .fillColor('#FFFFFF')

        Text('START TIMER')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(56)
    .backgroundColor('#000000')
    .borderRadius(16)
  }
}

// Main Screen
@Component
struct TeaBrewingScreen {
  @State selectedTeaIndex: number = 0;

  build() {
    Stack() {
      Column({ space: 0 }) {
        HeaderSection()
          .padding({ top: 24, left: 24, right: 24 })

        Blank().height(32)

        BrewingVisualizer({ tea: teaPresets[this.selectedTeaIndex] })

        Blank().height(40)

        BrewStatsRow({ tea: teaPresets[this.selectedTeaIndex] })
          .padding({ left: 24, right: 24 })

        Blank().height(40)

        TeaSelector({
          presets: teaPresets,
          selectedIndex: $selectedTeaIndex
        })
        .padding({ left: 24, right: 24 })

        Blank()

        StartBrewButton()
          .padding({ left: 24, right: 24, bottom: 32 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

// Entry Point
@Entry
@Component
struct Index {
  build() {
    TeaBrewingScreen()
  }
}