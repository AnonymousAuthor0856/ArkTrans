@Entry
@Component
struct ZenBrewApp {
  @State sampleTeas: TeaGuide[] = [
    { id: 1, name: 'Sencha Green', origin: 'Japan', temp: '70°C / 158°F', time: '1-2 min', colorCode: '#8BC34A' },
    { id: 2, name: 'Earl Grey', origin: 'Blend', temp: '95°C / 203°F', time: '3-5 min', colorCode: '#795548' },
    { id: 3, name: 'Silver Needle', origin: 'China', temp: '80°C / 176°F', time: '3-4 min', colorCode: '#E0E0E0' },
    { id: 4, name: 'Darjeeling', origin: 'India', temp: '90°C / 194°F', time: '3 min', colorCode: '#D7CCC8' },
    { id: 5, name: 'Chamomile', origin: 'Egypt', temp: '100°C / 212°F', time: '5-7 min', colorCode: '#FFEB3B' },
    { id: 6, name: 'Matcha', origin: 'Japan', temp: '80°C / 176°F', time: 'Whisk', colorCode: '#4CAF50' },
    { id: 7, name: 'Oolong', origin: 'Taiwan', temp: '85°C / 185°F', time: '3-5 min', colorCode: '#FF9800' }
  ]

  build() {
    Stack() {
      Column() {
        // Top Bar
        Row() {
          Column() {
            Text('ZenBrew')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#121212')
            Text('Mindful Steeping Guide')
              .fontSize(14)
              .fontColor('#757575')
              .fontWeight(FontWeight.Normal)
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          // Settings icon
          Text('⚙')
            .fontSize(28)
            .fontColor('#121212')
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 12, bottom: 12 })

        Scroll() {
          Column({ space: 16 }) {
            // Promo Card
            this.PromoCard()

            // Collections Header
            Text('Collections')
              .fontSize(18)
              .fontWeight(600)
              .fontColor('#121212')
              .margin({ top: 8, bottom: 8 })

            // Tea Cards
            ForEach(this.sampleTeas, (tea: TeaGuide) => {
              this.TeaItemCard(tea)
            }, (tea: TeaGuide) => tea.id.toString())

            // Extra spacer for FAB
            Blank()
              .height(80)
          }
          .width('100%')
          .padding({ left: 20, right: 20, top: 10, bottom: 10 })
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      // Floating Action Button - Custom Brew
      Column() {
        Blank()
        Row() {
          Blank()
          Row() {
            Text('+')
              .fontSize(28)
              .fontColor('#FFFFFF')
              .fontWeight(FontWeight.Bold)
            Text('Custom Brew')
              .fontSize(16)
              .fontColor('#FFFFFF')
              .fontWeight(FontWeight.Medium)
              .margin({ left: 8 })
          }
          .height(56)
          .padding({ left: 24, right: 24 })
          .backgroundColor('#121212')
          .borderRadius(28)
          .margin({ right: 20, bottom: 24 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  PromoCard() {
    Row() {
      Column() {
        Text('Tip of the day')
          .fontSize(12)
          .fontColor('#757575')
          .fontWeight(FontWeight.Bold)
        Text('Use filtered water for a purer taste profile.')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#121212')
          .margin({ top: 8 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // Info circle
      Stack() {
        Circle({ width: 48, height: 48 })
          .fill('#FFFFFF')
        Text('i')
          .fontSize(20)
          .fontColor('#757575')
          .fontWeight(FontWeight.Bold)
          .fontStyle(FontStyle.Italic)
      }
      .width(48)
      .height(48)
    }
    .width('100%')
    .padding(24)
    .backgroundColor('#F0F0F0')
    .borderRadius(20)
  }

  @Builder
  TeaItemCard(tea: TeaGuide) {
    Row() {
      // Circle with initial
      Stack() {
        Circle({ width: 50, height: 50 })
          .fill('#FFFFFF')
          .stroke({ color: tea.colorCode + '4D', width: 2 })
        Text(tea.name.charAt(0))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(tea.colorCode)
      }
      .width(50)
      .height(50)

      Column() {
        Text(tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor('#121212')
        Text(tea.origin)
          .fontSize(12)
          .fontColor('#757575')
          .margin({ top: 2 })

        Row() {
          this.InfoBadge(tea.temp)
          Column() {
            this.InfoBadge(tea.time)
          }
          .margin({ left: 8 })
        }
        .margin({ top: 6 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      // Play button
      Stack() {
        Circle({ width: 40, height: 40 })
          .fill('#FFFFFF')
          .stroke({ color: '#E0E0E0', width: 1 })
        Text('▶')
          .fontSize(16)
          .fontColor('#121212')
          .margin({ left: 2 })
      }
      .width(40)
      .height(40)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
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
}

interface TeaGuide {
  id: number
  name: string
  origin: string
  temp: string
  time: string
  colorCode: string
}
