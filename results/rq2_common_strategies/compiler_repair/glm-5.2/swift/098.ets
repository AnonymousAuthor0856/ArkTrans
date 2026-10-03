// ZenBrewApp.ets

// MARK: - Data Models
interface TeaGuide {
  id: number;
  name: string;
  origin: string;
  temp: string;
  time: string;
  colorCode: ResourceColor;
}

// MARK: - Mock Data
const sampleTeas: TeaGuide[] = [
  { id: 1, name: 'Sencha Green', origin: 'Japan', temp: '70°C / 158°F', time: '1-2 min', colorCode: '#8BC34A' },
  { id: 2, name: 'Earl Grey', origin: 'Blend', temp: '95°C / 203°F', time: '3-5 min', colorCode: '#795548' },
  { id: 3, name: 'Silver Needle', origin: 'China', temp: '80°C / 176°F', time: '3-4 min', colorCode: '#E0E0E0' },
  { id: 4, name: 'Darjeeling', origin: 'India', temp: '90°C / 194°F', time: '3 min', colorCode: '#D7CCC8' },
  { id: 5, name: 'Chamomile', origin: 'Egypt', temp: '100°C / 212°F', time: '5-7 min', colorCode: '#FFEB3B' },
  { id: 6, name: 'Matcha', origin: 'Japan', temp: '80°C / 176°F', time: 'Whisk', colorCode: '#4CAF50' },
  { id: 7, name: 'Oolong', origin: 'Taiwan', temp: '85°C / 185°F', time: '3-5 min', colorCode: '#FF9800' }
];

// MARK: - Main Application View
@Entry
@Component
struct ZenBrewAppView {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // Main Scrollable Content
      Scroll() {
        Column({ space: 16 }) {
          // Top App Bar
          Row() {
            Column() {
              Text('ZenBrew')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FF121212')
                .letterSpacing(-0.5)
              
              Text('Mindful Steeping Guide')
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor('#FF757575')
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Button() {
              Text('⚙')
                .fontSize(24)
                .fontColor('#FF121212')
            }
            .width(44)
            .height(44)
            .backgroundColor(Color.Transparent)
          }
          .width('100%')
          .padding({ left: 20, right: 20, top: 10 })

          // Promo Card
          PromoCard()
            .padding({ left: 20, right: 20 })

          // Collections Title
          Text('Collections')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF121212')
            .width('100%')
            .padding({ top: 8, bottom: 8, left: 20, right: 20 })

          // Tea List
          ForEach(sampleTeas, (tea: TeaGuide) => {
            TeaItemCard({ tea: tea })
              .padding({ left: 20, right: 20 })
          }, (tea: TeaGuide) => tea.id.toString())

          // Bottom Spacer to prevent FAB overlap
          Blank().height(80)
        }
        .padding({ top: 10, bottom: 10 })
      }
      .scrollBar(BarState.Off)
      .backgroundColor(Color.White)
      .width('100%')
      .height('100%')

      // Floating Action Button (FAB)
      Button() {
        Row({ space: 8 }) {
          Text('+')
            .fontSize(20)
            .fontColor(Color.White)
          
          Text('Custom Brew')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
        }
        .height(56)
        .padding({ left: 24, right: 24 })
      }
      .backgroundColor('#FF121212')
      .borderRadius(16)
      .margin({ right: 20, bottom: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

// MARK: - Promo Card Component
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
          .fontColor('#FF121212')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Blank().width(16)

      // Right Circular Icon
      Stack() {
        Circle({ width: 48, height: 48 })
          .fill(Color.White)
        
        Text('ℹ')
          .fontSize(24)
          .fontColor(Color.Gray)
      }
    }
    .padding(24)
    .backgroundColor('#FFF0F0F0')
    .borderRadius(20)
    .alignItems(VerticalAlign.Center)
  }
}

// MARK: - Tea Item Card Component
@Component
struct TeaItemCard {
  private tea: TeaGuide = {
    id: 0,
    name: '',
    origin: '',
    temp: '',
    time: '',
    colorCode: Color.Black
  };

  build() {
    Row() {
      // Left Circular Identifier
      Stack() {
        Circle({ width: 50, height: 50 })
          .fill(Color.White)
          .stroke(this.tea.colorCode)
          .strokeWidth(2)
          .opacity(0.3)
        
        Text(this.tea.name.charAt(0))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.tea.colorCode)
      }

      Blank().width(16)

      // Center Text Info
      Column() {
        Text(this.tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF121212')
        
        Text(this.tea.origin)
          .fontSize(12)
          .fontColor('#FF757575')
          .margin({ top: 2 })

        Blank().height(6)

        Row() {
          InfoBadge({ label: this.tea.temp })
          Blank().width(8)
          InfoBadge({ label: this.tea.time })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Right Play Button
      Button() {
        Text('▶')
          .fontSize(16)
          .fontColor('#FF121212')
      }
      .width(40)
      .height(40)
      .backgroundColor(Color.White)
      .borderRadius(20)
      .border({ width: 1, color: '#FFE0E0E0' })
    }
    .padding(16)
    .backgroundColor('#FFF9F9F9')
    .borderRadius(16)
    .border({ width: 1, color: '#FFEEEEEE' })
    .alignItems(VerticalAlign.Center)
  }
}

// MARK: - Info Badge Component
@Component
struct InfoBadge {
  private label: string = '';

  build() {
    Text(this.label)
      .fontSize(11)
      .fontColor(Color.Black)
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor(Color.White)
      .borderRadius(6)
      .border({ width: 1, color: '#FFE0E0E0' })
  }
}