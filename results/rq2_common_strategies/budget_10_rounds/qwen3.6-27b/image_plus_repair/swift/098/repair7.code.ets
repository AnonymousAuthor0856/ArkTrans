import { common } from '@kit.AbilityKit';

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
        Circle()
          .fill(Color.White)
          .width(48)
          .height(48)
        
        // Using a generic placeholder or system symbol if ic_info is not available in resources
        // Assuming standard icon resource exists as per original intent, but fixing compilation by ensuring valid reference structure
        // If $r('app.media.info_icon') fails due to missing resource, we might need a fallback, but here we keep the structure correct.
        Image($r('app.media.ic_info')) 
          .width(24)
          .height(24)
          .fillColor('#757575')
      }
    }
    .padding(24)
    .backgroundColor('#F0F0F0')
    .borderRadius(20)
  }
}

@Component
export struct InfoBadge {
  @Prop label: string;

  build() {
    Text(this.label)
      .fontSize(11)
      .fontColor(Color.Black)
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor(Color.White)
      .borderRadius(6)
      .border({ width: 1, color: '#E0E0E0', radius: 6 })
  }
}

@Component
export struct TeaItemCard {
  @State tea: TeaGuide = {
    id: 0,
    name: '',
    origin: '',
    temp: '',
    time: '',
    colorCode: '#FFFFFF'
  };

  aboutToAppear() {
    // Initialization if needed, though usually passed via constructor in newer ArkTS versions
    // For this fix, we rely on the parent passing it correctly. 
    // Note: @ObjectParam is deprecated/removed in favor of @State with initialization or direct property binding in some contexts.
    // However, to strictly fix compilation errors regarding 'Cannot find name ObjectParam', we switch to @State and ensure type safety.
  }

  build() {
    Row() {
      // Left Circle Identifier
      Stack() {
        Circle()
          .fill(Color.White)
          .width(50)
          .height(50)
          .border({ width: 2, color: this.tea.colorCode, radius: 25 })
        
        Text(this.tea.name.substring(0, 1))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.tea.colorCode)
      }

      Blank().width(16)

      // Main Content
      Column() {
        Text(this.tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor('#121212')
        
        Text(this.tea.origin)
          .fontSize(12)
          .fontColor('#757575')
        
        Blank().height(6)

        Row() {
          InfoBadge({ label: this.tea.temp })
          Blank().width(8)
          InfoBadge({ label: this.tea.time })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Play Button
      Button() {
        Image($r('app.media.ic_play')) // Placeholder for play icon
          .width(20)
          .height(20)
          .fillColor('#121212')
      }
      .type(ButtonType.Circle)
      .backgroundColor(Color.White)
      .border({ width: 1, color: '#E0E0E0', radius: 20 })
      .width(40)
      .height(40)
    }
    .padding(16)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE', radius: 16 })
  }
}

@Entry
@Component
struct ZenBrewAppView {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Scroll() {
        Column() {
          // Top Bar
          Row() {
            Column() {
              Text("ZenBrew")
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#121212')
                .letterSpacing(-0.5)
              
              Text("Mindful Steeping Guide")
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor('#757575')
            }
            .alignItems(HorizontalAlign.Start)
            
            Blank()
            
            Button() {
              Image($r('app.media.ic_settings')) // Placeholder for settings icon
                .width(24)
                .height(24)
                .fillColor('#121212')
            }
            .backgroundColor(Color.Transparent)
            .width(44)
            .height(44)
          }
          .width('100%')
          .padding({ left: 20, right: 20, top: 10 })

          // Promo Card
          PromoCard()
            .margin({ left: 20, right: 20 })

          // Collections Title
          Text("Collections")
            .fontSize(18)
            .fontWeight(FontWeight.Medium) // Fixed: SemiBold does not exist, use Medium or Bold
            .fontColor('#121212')
            .textAlign(TextAlign.Start)
            .width('100%')
            .padding({ top: 8, bottom: 8, left: 20, right: 20 })

          // Tea List
          ForEach(sampleTeas, (tea: TeaGuide) => {
            TeaItemCard({ tea: tea })
              .margin({ left: 20, right: 20 })
          })

          // Spacer for FAB
          Blank().height(80)
        }
        .padding({ top: 10, bottom: 10 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)

      // Floating Action Button
      Button() {
        Row() {
          Image($r('app.media.ic_add')) // Placeholder for add icon
            .width(20)
            .height(20)
            .fillColor(Color.White)
          
          Blank().width(8)
          
          Text("Custom Brew")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
        }
      }
      .backgroundColor('#121212')
      .borderRadius(16)
      .height(56)
      .padding({ left: 24, right: 24 })
      .margin({ right: 20, bottom: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}