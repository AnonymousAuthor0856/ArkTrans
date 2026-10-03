// Translated from Kotlin Jetpack Compose to ArkTS / ArkUI

interface TeaGuide {
  id: number;
  name: string;
  origin: string;
  temp: string;
  time: string;
  colorCode: string;
  borderColor: string;
}

const sampleTeas: TeaGuide[] = [
  { id: 1, name: 'Sencha Green', origin: 'Japan', temp: '70°C / 158°F', time: '1-2 min', colorCode: '#8BC34A', borderColor: 'rgba(139, 195, 74, 0.3)' },
  { id: 2, name: 'Earl Grey', origin: 'Blend', temp: '95°C / 203°F', time: '3-5 min', colorCode: '#795548', borderColor: 'rgba(121, 85, 72, 0.3)' },
  { id: 3, name: 'Silver Needle', origin: 'China', temp: '80°C / 176°F', time: '3-4 min', colorCode: '#E0E0E0', borderColor: 'rgba(224, 224, 224, 0.3)' },
  { id: 4, name: 'Darjeeling', origin: 'India', temp: '90°C / 194°F', time: '3 min', colorCode: '#D7CCC8', borderColor: 'rgba(215, 204, 200, 0.3)' },
  { id: 5, name: 'Chamomile', origin: 'Egypt', temp: '100°C / 212°F', time: '5-7 min', colorCode: '#FFEB3B', borderColor: 'rgba(255, 235, 59, 0.3)' },
  { id: 6, name: 'Matcha', origin: 'Japan', temp: '80°C / 176°F', time: 'Whisk', colorCode: '#4CAF50', borderColor: 'rgba(76, 175, 80, 0.3)' },
  { id: 7, name: 'Oolong', origin: 'Taiwan', temp: '85°C / 185°F', time: '3-5 min', colorCode: '#FF9800', borderColor: 'rgba(255, 152, 0, 0.3)' }
];

@Entry
@Component
struct ZenBrewApp {
  @Builder
  PromoCard(textColor: string) {
    Row() {
      Column() {
        Text('Tip of the day')
          .fontSize(12)
          .fontColor('#888888')
          .fontWeight(FontWeight.Bold)
          .padding({ bottom: 4 })
        Text('Use filtered water for a purer taste profile.')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(textColor)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Blank().width(16)

      Column() {
        Text('ℹ')
          .fontSize(22)
          .fontColor('#888888')
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .padding(24)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#F0F0F0')
    .borderRadius(20)
  }

  @Builder
  InfoBadge(label: string) {
    Text(label)
      .fontSize(11)
      .fontColor('#000000')
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor('#FFFFFF')
      .borderRadius(6)
      .border({ width: 1, color: '#E0E0E0' })
  }

  @Builder
  TeaItemCard(tea: TeaGuide, bgColor: string, titleColor: string, subtitleColor: string) {
    Row() {
      Column() {
        Text(tea.name.substring(0, 1))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(tea.colorCode)
      }
      .width(50)
      .height(50)
      .borderRadius(25)
      .backgroundColor('#FFFFFF')
      .border({ width: 2, color: tea.borderColor })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Blank().width(16)

      Column() {
        Text(tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(titleColor)
        Text(tea.origin)
          .fontSize(12)
          .fontColor(subtitleColor)
        Blank().height(6)
        Row() {
          this.InfoBadge(tea.temp)
          Blank().width(8)
          this.InfoBadge(tea.time)
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button() {
        Text('▶')
          .fontSize(14)
          .fontColor(titleColor)
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: '#E0E0E0' })
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(bgColor)
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Row() {
          Column() {
            Text('ZenBrew')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#121212')
              .letterSpacing(-0.5)
            Text('Mindful Steeping Guide')
              .fontSize(14)
              .fontColor('#757575')
              .fontWeight(FontWeight.Normal)
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)

          Button() {
            Text('⚙')
              .fontSize(22)
              .fontColor('#121212')
          }
          .width(48)
          .height(48)
          .backgroundColor(Color.Transparent)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 8 })
        .alignItems(VerticalAlign.Center)

        Scroll() {
          Column({ space: 16 }) {
            this.PromoCard('#121212')

            Text('Collections')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#121212')
              .width('100%')
              .padding({ top: 8, bottom: 8 })

            ForEach(sampleTeas, (tea: TeaGuide) => {
              this.TeaItemCard(tea, '#F9F9F9', '#121212', '#757575')
            }, (tea: TeaGuide) => tea.id.toString())

            Blank().height(80)
          }
          .width('100%')
          .padding({ left: 20, right: 20, top: 10, bottom: 10 })
        }
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')

      Button() {
        Row({ space: 8 }) {
          Text('+')
            .fontSize(22)
            .fontColor('#FFFFFF')
          Text('Custom Brew')
            .fontSize(16)
            .fontColor('#FFFFFF')
        }
      }
      .height(56)
      .borderRadius(16)
      .backgroundColor('#121212')
      .margin({ right: 20, bottom: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
