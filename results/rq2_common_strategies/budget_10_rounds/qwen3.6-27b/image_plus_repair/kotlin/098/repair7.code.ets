@Entry
@Component
struct ZenBrewApp {
  @State teas: TeaGuide[] = [
    new TeaGuide(1, "Sencha Green", "Japan", "70°C / 158°F", "1-2 min", '#8BC34A'),
    new TeaGuide(2, "Earl Grey", "Blend", "95°C / 203°F", "3-5 min", '#795548'),
    new TeaGuide(3, "Silver Needle", "China", "80°C / 176°F", "3-4 min", '#E0E0E0'),
    new TeaGuide(4, "Darjeeling", "India", "90°C / 194°F", "3 min", '#D7CCC8'),
    new TeaGuide(5, "Chamomile", "Egypt", "100°C / 212°F", "5-7 min", '#FFEB3B'),
    new TeaGuide(6, "Matcha", "Japan", "80°C / 176°F", "Whisk", '#4CAF50'),
    new TeaGuide(7, "Oolong", "Taiwan", "85°C / 185°F", "3-5 min", '#FF9800')
  ];

  build() {
    Column() {
      // Header Section
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
            .margin({ top: 2 })
        }
        
        Image($r('app.media.settings')) // Placeholder for Settings Icon
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .onClick(() => {})
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Top)
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })

      // Scrollable Content
      Scroll() {
        Column() {
          // Promo Card
          PromoCard()

          // Collections Title
          Text('Collections')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#121212')
            .margin({ top: 24, bottom: 16 })

          // Tea List
          ForEach(this.teas, (tea: TeaGuide) => {
            TeaItemCard({ tea: tea })
          })

          // Bottom Spacer for FAB
          Blank().height(80)
        }
        .padding({ left: 20, right: 20 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Floating Action Button
      Button('+ Custom Brew', { type: ButtonType.Capsule })
        .backgroundColor('#121212')
        .fontColor(Color.White)
        .width(160)
        .height(56)
        .borderRadius(16)
        .position({ x: 'calc(100% - 180px)', y: 'calc(100% - 60px)' })
        .zIndex(10)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

class TeaGuide {
  id: number;
  name: string;
  origin: string;
  temp: string;
  time: string;
  colorCode: string;

  constructor(id: number, name: string, origin: string, temp: string, time: string, colorCode: string) {
    this.id = id;
    this.name = name;
    this.origin = origin;
    this.temp = temp;
    this.time = time;
    this.colorCode = colorCode;
  }
}

@Component
struct PromoCard {
  build() {
    Row() {
      Column({ space: 4 }) {
        Text('Tip of the day')
          .fontSize(12)
          .fontColor('#757575')
          .fontWeight(FontWeight.Bold)
        
        Text('Use filtered water for a purer taste profile.')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#121212')
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .layoutWeight(1)
      
      Circle({ width: 48, height: 48 })
        .fill('#FFFFFF')
        .margin({ left: 16 })
        .child(
          Image($r('app.media.info')) // Placeholder for Info Icon
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
        )
    }
    .width('100%')
    .padding(24)
    .backgroundColor('#F0F0F0')
    .borderRadius(20)
    .margin({ bottom: 16 })
  }
}

@Component
struct TeaItemCard {
  @Prop tea: TeaGuide;

  build() {
    Row() {
      // Visual Dot Identifier
      Circle({ width: 50, height: 50 })
        .fill('#FFFFFF')
        .border({ width: 2, color: this.tea.colorCode + '4D' }) // Hex with alpha approx
        .child(
          Text(this.tea.name.substring(0, 1))
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.tea.colorCode)
        )

      Column({ space: 6 }) {
        Text(this.tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor('#121212')
        
        Text(this.tea.origin)
          .fontSize(12)
          .fontColor('#757575')
        
        Row({ space: 8 }) {
          InfoBadge({ label: this.tea.temp })
          InfoBadge({ label: this.tea.time })
        }
      }
      .layoutWeight(1)
      .margin({ left: 16 })

      // Play Button
      Circle({ width: 40, height: 40 })
        .fill('#FFFFFF')
        .border({ width: 1, color: '#E0E0E0' })
        .child(
          Image($r('app.media.play')) // Placeholder for Play Icon
            .width(20)
            .height(20)
            .objectFit(ImageFit.Contain)
        )
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
    .margin({ bottom: 16 })
  }
}

@Component
struct InfoBadge {
  @Prop label: string;

  build() {
    Text(this.label)
      .fontSize(11)
      .fontColor('#000000')
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor('#FFFFFF')
      .borderRadius(6)
      .border({ width: 1, color: '#E0E0E0' })
  }
}