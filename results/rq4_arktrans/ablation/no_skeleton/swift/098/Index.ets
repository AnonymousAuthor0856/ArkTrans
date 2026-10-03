// src/main/ets/model/TeaGuide.ets
export interface TeaGuide {
  id: number;
  name: string;
  origin: string;
  temp: string;
  time: string;
  colorCode: string;
}

export const sampleTeas: TeaGuide[] = [
  { id: 1, name: "Sencha Green", origin: "Japan", temp: "70°C / 158°F", time: "1-2 min", colorCode: '#8BC34A' },
  { id: 2, name: "Earl Grey", origin: "Blend", temp: "95°C / 203°F", time: "3-5 min", colorCode: '#795548' },
  { id: 3, name: "Silver Needle", origin: "China", temp: "80°C / 176°F", time: "3-4 min", colorCode: '#E0E0E0' },
  { id: 4, name: "Darjeeling", origin: "India", temp: "90°C / 194°F", time: "3 min", colorCode: '#D7CCC8' },
  { id: 5, name: "Chamomile", origin: "Egypt", temp: "100°C / 212°F", time: "5-7 min", colorCode: '#FFEB3B' },
  { id: 6, name: "Matcha", origin: "Japan", temp: "80°C / 176°F", time: "Whisk", colorCode: '#4CAF50' },
  { id: 7, name: "Oolong", origin: "Taiwan", temp: "85°C / 185°F", time: "3-5 min", colorCode: '#FF9800' }
];

// src/main/ets/components/PromoCard.ets
@Component
export struct PromoCard {
  build() {
    Row() {
      Column() {
        Text('Tip of the day')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#757575')
          .margin({ bottom: 4 })

        Text('Use filtered water for a purer taste profile.')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#121212')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Blank().width(16)

      Stack() {
        Circle().fill(Color.White).width(48).height(48)
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .fillColor('#757575')
      }
    }
    .padding(24)
    .backgroundColor('#F0F0F0')
    .borderRadius(20)
  }
}

// src/main/ets/components/InfoBadge.ets
@Component
export struct InfoBadge {
  @Prop label: string

  build() {
    Text(this.label)
      .fontSize(11)
      .fontColor('#000000')
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor('#FFFFFF')
      .borderRadius(6)
      .border({ width: 1, color: '#E0E0E0', radius: 6 })
  }
}

// src/main/ets/components/TeaItemCard.ets
import { TeaGuide } from '../model/TeaGuide';
import { InfoBadge } from './InfoBadge';

@Component
export struct TeaItemCard {
  @ObjectLink tea: TeaGuide

  build() {
    Row() {
      // Left Icon
      Stack() {
        Circle()
          .fill(Color.White)
          .width(50)
          .height(50)
          .border({ width: 2, color: this.tea.colorCode })
        
        Text(this.tea.name.charAt(0))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.tea.colorCode)
      }

      Blank().width(16)

      // Content
      Column() {
        Text(this.tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor('#121212')

        Text(this.tea.origin)
          .fontSize(12)
          .fontColor('#757575')
          .margin({ top: 2 })

        Row() {
          InfoBadge({ label: this.tea.temp })
          Blank().width(8)
          InfoBadge({ label: this.tea.time })
        }.margin({ top: 6 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Play Button
      Stack() {
        Circle().fill(Color.White).width(40).height(40).border({ width: 1, color: '#E0E0E0', radius: 20 })
        Image($r('app.media.startIcon'))
          .width(20)
          .height(20)
          .objectFit(ImageFit.Contain)
          .fillColor('#121212')
      }
    }
    .padding(16)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE', radius: 16 })
  }
}

// entry/src/main/ets/pages/Index.ets
import { sampleTeas, TeaGuide } from '../model/TeaGuide';
import { PromoCard } from '../components/PromoCard';
import { TeaItemCard } from '../components/TeaItemCard';

@Entry
@Component
struct Index {
  @State teas: TeaGuide[] = sampleTeas

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Scroll() {
        Column() {
          // Header
          Row() {
            Column() {
              Text('ZenBrew')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#121212')
                .letterSpacing(-0.5)
              
              Text('Mindful Steeping Guide')
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor('#757575')
            }.alignItems(HorizontalAlign.Start)

            Blank()

            // Settings Icon (using startIcon as placeholder per rules)
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .objectFit(ImageFit.Contain)
              .fillColor('#121212')
              .onClick(() => {
                console.info("Settings tapped")
              })
          }
          .width('100%')
          .padding({ left: 20, right: 20, top: 10 })

          // Promo Card
          PromoCard()
            .margin({ left: 20, right: 20 })

          // Collections Title
          Text('Collections')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#121212')
            .textAlign(TextAlign.Start)
            .width('100%')
            .padding({ left: 20, right: 20, top: 8, bottom: 8 })

          // List
          ForEach(this.teas, (tea: TeaGuide) => {
            TeaItemCard({ tea: tea })
              .margin({ left: 20, right: 20, bottom: 16 })
          }, (item: TeaGuide) => item.id.toString())

          // Bottom Spacer for FAB
          Blank().height(80)
        }
        .padding({ top: 10, bottom: 10 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      // FAB
      Button() {
        Row() {
          Image($r('app.media.startIcon'))
            .width(20)
            .height(20)
            .objectFit(ImageFit.Contain)
            .fillColor('#FFFFFF')
          
          Text('Custom Brew')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .height(56)
      .backgroundColor('#121212')
      .borderRadius(16)
      .margin({ right: 20, bottom: 20 })
      .onClick(() => {
        console.info("Custom Brew tapped")
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}