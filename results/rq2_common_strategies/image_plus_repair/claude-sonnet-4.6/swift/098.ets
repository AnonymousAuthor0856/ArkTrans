// Color constants
const primaryBlack = '#FF121212';
const textGrey = '#FF757575';
const backgroundWhite = '#FFFFFFFF';
const cardBackground = '#FFF9F9F9';
const promoCardBackground = '#FFF0F0F0';
const lightGreyBorder = '#FFEEEEEE';
const veryLightGreyBorder = '#FFE0E0E0';

interface TeaGuide {
  id: number;
  name: string;
  origin: string;
  temp: string;
  time: string;
  colorCode: string;
}

const sampleTeas: TeaGuide[] = [
  { id: 1, name: 'Sencha Green', origin: 'Japan', temp: '70°C / 158°F', time: '1-2 min', colorCode: '#FF8BC34A' },
  { id: 2, name: 'Earl Grey', origin: 'Blend', temp: '95°C / 203°F', time: '3-5 min', colorCode: '#FF795548' },
  { id: 3, name: 'Silver Needle', origin: 'China', temp: '80°C / 176°F', time: '3-4 min', colorCode: '#FFE0E0E0' },
  { id: 4, name: 'Darjeeling', origin: 'India', temp: '90°C / 194°F', time: '3 min', colorCode: '#FFD7CCC8' },
  { id: 5, name: 'Chamomile', origin: 'Egypt', temp: '100°C / 212°F', time: '5-7 min', colorCode: '#FFFFEB3B' },
  { id: 6, name: 'Matcha', origin: 'Japan', temp: '80°C / 176°F', time: 'Whisk', colorCode: '#FF4CAF50' },
  { id: 7, name: 'Oolong', origin: 'Taiwan', temp: '85°C / 185°F', time: '3-5 min', colorCode: '#FFFF9800' },
];

@Component
struct InfoBadge {
  label: string = '';

  build() {
    Text(this.label)
      .fontSize(11)
      .fontColor('#FF000000')
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor(Color.White)
      .borderRadius(6)
      .border({ width: 1, color: veryLightGreyBorder })
  }
}

@Component
struct TeaItemCard {
  tea: TeaGuide = { id: 0, name: '', origin: '', temp: '', time: '', colorCode: '#FF000000' };

  build() {
    Row() {
      // Left circle identifier
      Stack() {
        Circle()
          .width(50)
          .height(50)
          .fill(Color.White)
          .stroke(this.tea.colorCode)
          .strokeWidth(2)
          .fillOpacity(1)
        Text(this.tea.name.charAt(0))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.tea.colorCode)
      }
      .width(50)
      .height(50)
      .clip(true)
      .borderRadius(25)

      Blank().width(16)

      Column() {
        Text(this.tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(primaryBlack)
        Text(this.tea.origin)
          .fontSize(12)
          .fontColor(textGrey)
        Blank().height(6)
        Row() {
          InfoBadge({ label: this.tea.temp })
          Blank().width(8)
          InfoBadge({ label: this.tea.time })
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Play button
      Stack() {
        Circle()
          .width(40)
          .height(40)
          .fill(Color.White)
          .stroke(veryLightGreyBorder)
          .strokeWidth(1)
        Text('▶')
          .fontSize(14)
          .fontColor(primaryBlack)
      }
      .width(40)
      .height(40)
      .onClick(() => {
        console.log('Play for ' + this.tea.name + ' tapped');
      })
    }
    .alignItems(VerticalAlign.Center)
    .padding(16)
    .width('100%')
    .backgroundColor(cardBackground)
    .borderRadius(16)
    .border({ width: 1, color: lightGreyBorder })
  }
}

@Component
struct PromoCard {
  build() {
    Row() {
      Column() {
        Text('Tip of the day')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
          .margin({ bottom: 4 })
        Text('Use filtered water for a purer taste profile.')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(primaryBlack)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Blank().width(16)

      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill(Color.White)
        Text('ℹ')
          .fontSize(24)
          .fontColor(Color.Gray)
      }
      .width(48)
      .height(48)
    }
    .alignItems(VerticalAlign.Center)
    .padding(24)
    .width('100%')
    .backgroundColor(promoCardBackground)
    .borderRadius(20)
  }
}

@Entry
@Component
struct ZenBrewAppView {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Scroll() {
        Column({ space: 16 }) {
          // Top bar
          Row() {
            Column() {
              Text('ZenBrew')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(primaryBlack)
                .letterSpacing(-0.5)
              Text('Mindful Steeping Guide')
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor(textGrey)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Button({ type: ButtonType.Normal }) {
              Text('⚙')
                .fontSize(22)
                .fontColor(primaryBlack)
            }
            .width(44)
            .height(44)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              console.log('Settings tapped');
            })
          }
          .width('100%')
          .alignItems(VerticalAlign.Top)
          .padding({ left: 20, right: 20, top: 10 })

          // Promo card
          PromoCard()
            .padding({ left: 20, right: 20 })

          // Collections title
          Text('Collections')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(primaryBlack)
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ top: 8, bottom: 8, left: 20, right: 20 })

          // Tea list
          ForEach(sampleTeas, (tea: TeaGuide) => {
            TeaItemCard({ tea: tea })
              .padding({ left: 20, right: 20 })
          }, (tea: TeaGuide) => tea.id.toString())

          // Bottom spacer for FAB
          Blank().height(80)
        }
        .padding({ top: 10, bottom: 10 })
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
      .backgroundColor(backgroundWhite)

      // FAB
      Button() {
        Row({ space: 8 }) {
          Text('+')
            .fontSize(20)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Medium)
          Text('Custom Brew')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
        }
        .alignItems(VerticalAlign.Center)
      }
      .height(56)
      .padding({ left: 24, right: 24 })
      .backgroundColor(primaryBlack)
      .borderRadius(16)
      .margin({ right: 20, bottom: 20 })
      .onClick(() => {
        console.log('Custom Brew tapped');
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(backgroundWhite)
  }
}