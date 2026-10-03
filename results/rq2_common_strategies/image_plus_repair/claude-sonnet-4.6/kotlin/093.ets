import { router } from '@kit.ArkUI';

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
struct TeaBrewingScreen {
  @State selectedTea: TeaPreset = teaPresets[0];

  build() {
    Column({ space: 0 }) {
      // Header
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

        Button({ type: ButtonType.Circle }) {
          Text('⚙')
            .fontSize(22)
            .fontColor(Color.Black)
        }
        .width(44)
        .height(44)
        .backgroundColor(Color.Transparent)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ top: 24, left: 24, right: 24 })

      // Spacer
      Blank().height(32)

      // Brewing Visualizer
      Stack({ alignContent: Alignment.Center }) {
        Circle({ width: 180, height: 180 })
          .fill('#F5F5F5')

        Column({ space: 8 }) {
          Text('♥')
            .fontSize(48)
            .fontColor('#8D6E63')
          Text(this.selectedTea.name)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
      }
      .width(220)
      .height(220)

      // Spacer
      Blank().height(40)

      // Stats Row
      Row() {
        Column({ space: 4 }) {
          Text('TEMP')
            .fontSize(11)
            .fontColor(Color.Gray)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1)
          Text(this.selectedTea.temp)
            .fontSize(18)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)

        Divider()
          .vertical(true)
          .height(40)
          .color('#E0E0E0')
          .strokeWidth(1)

        Column({ space: 4 }) {
          Text('TIME')
            .fontSize(11)
            .fontColor(Color.Gray)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1)
          Text(this.selectedTea.time)
            .fontSize(18)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)

        Divider()
          .vertical(true)
          .height(40)
          .color('#E0E0E0')
          .strokeWidth(1)

        Column({ space: 4 }) {
          Text('AMOUNT')
            .fontSize(11)
            .fontColor(Color.Gray)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1)
          Text('250ml')
            .fontSize(18)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)

      // Spacer
      Blank().height(40)

      // Tea Selector
      Column({ space: 12 }) {
        Text('Select Variety')
          .fontSize(14)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Medium)
          .padding({ left: 4 })

        Scroll() {
          Row({ space: 12 }) {
            ForEach(teaPresets, (preset: TeaPreset) => {
              this.TeaChip(preset)
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
      .padding({ left: 24, right: 24 })

      // Flexible spacer
      Blank().layoutWeight(1)

      // Start Brew Button
      Button() {
        Row({ space: 8 }) {
          Text('▶')
            .fontSize(18)
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
      .margin({ left: 24, right: 24, bottom: 24 })
      .type(ButtonType.Normal)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  TeaChip(preset: TeaPreset) {
    Text(preset.name)
      .fontSize(14)
      .fontColor(this.selectedTea.name === preset.name ? Color.White : Color.Black)
      .fontWeight(this.selectedTea.name === preset.name ? FontWeight.Bold : FontWeight.Normal)
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      .backgroundColor(this.selectedTea.name === preset.name ? Color.Black : Color.White)
      .borderRadius(50)
      .border({
        width: 1,
        color: this.selectedTea.name === preset.name ? Color.Black : '#E0E0E0'
      })
      .onClick(() => {
        this.selectedTea = preset;
      })
  }
}