import router from '@ohos.router';

interface TeaPreset {
  id: number;
  name: string;
  temp: string;
  time: string;
  description: string;
}

@Entry
@Component
struct TeaBrewingScreen {
  private teaPresets: TeaPreset[] = [
    { id: 0, name: 'Sencha', temp: '70°C', time: '1-2 min', description: 'Japanese green tea, grassy and fresh.' },
    { id: 1, name: 'Earl Grey', temp: '98°C', time: '3-4 min', description: 'Black tea flavored with bergamot oil.' },
    { id: 2, name: 'Oolong', temp: '85°C', time: '3-5 min', description: 'Traditional semi-oxidized Chinese tea.' },
    { id: 3, name: 'Chamomile', temp: '100°C', time: '5 min', description: 'Herbal infusion, calming and caffeine-free.' },
    { id: 4, name: 'Matcha', temp: '80°C', time: 'Whisk', description: 'Finely ground powder of green tea leaves.' }
  ];

  @State selectedTeaIndex: number = 0;

  build() {
    Column() {
      // Header
      Row() {
        Column() {
          Text('Tea Master')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
          Text('Perfect brew, every time')
            .fontSize(12)
            .fontColor('#888888')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button({ type: ButtonType.Normal }) {
          Text('⚙')
            .fontSize(24)
            .fontColor('#000000')
        }
        .backgroundColor(Color.Transparent)
        .width(40)
        .height(40)
      }
      .width('100%')
      .padding({ top: 24, left: 24, right: 24 })
      .alignItems(VerticalAlign.Center)

      // Spacer
      Blank().height(32)

      // Brewing Visualizer
      Stack() {
        Circle()
          .width(220)
          .height(220)
          .fill('#F5F5F5')

        Column({ space: 8 }) {
          Text('♥')
            .fontSize(48)
            .fontColor('#8D6E63')

          Text(this.teaPresets[this.selectedTeaIndex].name)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
      }
      .width(220)
      .height(220)
      .alignContent(Alignment.Center)

      // Spacer
      Blank().height(40)

      // Stats Row
      Row() {
        Column({ space: 4 }) {
          Text('TEMP')
            .fontSize(11)
            .fontWeight(FontWeight.Bold)
            .fontColor('#888888')
            .letterSpacing(1)
          Text(this.teaPresets[this.selectedTeaIndex].temp)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
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
            .fontWeight(FontWeight.Bold)
            .fontColor('#888888')
            .letterSpacing(1)
          Text(this.teaPresets[this.selectedTeaIndex].time)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
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
            .fontWeight(FontWeight.Bold)
            .fontColor('#888888')
            .letterSpacing(1)
          Text('250ml')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Spacer
      Blank().height(40)

      // Tea Selector
      Column({ space: 12 }) {
        Text('Select Variety')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .padding({ left: 4 })
          .alignSelf(ItemAlign.Start)

        Scroll() {
          Row({ space: 12 }) {
            ForEach(this.teaPresets, (preset: TeaPreset, index: number) => {
              Button({ type: ButtonType.Normal }) {
                Text(preset.name)
                  .fontSize(14)
                  .fontWeight(index === this.selectedTeaIndex ? FontWeight.Bold : FontWeight.Normal)
                  .fontColor(index === this.selectedTeaIndex ? '#FFFFFF' : '#000000')
                  .padding({ left: 20, right: 20, top: 10, bottom: 10 })
              }
              .backgroundColor(index === this.selectedTeaIndex ? '#000000' : '#FFFFFF')
              .borderRadius(50)
              .borderWidth(1)
              .borderColor(index === this.selectedTeaIndex ? '#000000' : '#E0E0E0')
              .height(44)
              .onClick(() => {
                this.selectedTeaIndex = index;
              })
            })
          }
          .padding({ left: 4, right: 4 })
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
      .alignItems(HorizontalAlign.Start)

      Blank()

      // Start Brew Button
      Button({ type: ButtonType.Normal }) {
        Row({ space: 8 }) {
          Text('▶')
            .fontSize(20)
            .fontColor('#FFFFFF')
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
      .margin({ left: 24, right: 24, bottom: 32 })
      .padding({ left: 24, right: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .alignItems(HorizontalAlign.Center)
  }
}