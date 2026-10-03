import { Colors } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'

// --- Data Models ---

interface TeaGuide {
  id: number;
  name: string;
  origin: string;
  temp: string;
  time: string;
  colorCode: string;
}

const sampleTeas: TeaGuide[] = [
  { id: 1, name: "Sencha Green", origin: "Japan", temp: "70°C / 158°F", time: "1-2 min", colorCode: '#8BC34A' },
  { id: 2, name: "Earl Grey", origin: "Blend", temp: "95°C / 203°F", time: "3-5 min", colorCode: '#795548' },
  { id: 3, name: "Silver Needle", origin: "China", temp: "80°C / 176°F", time: "3-4 min", colorCode: '#E0E0E0' },
  { id: 4, name: "Darjeeling", origin: "India", temp: "90°C / 194°F", time: "3 min", colorCode: '#D7CCC8' },
  { id: 5, name: "Chamomile", origin: "Egypt", temp: "100°C / 212°F", time: "5-7 min", colorCode: '#FFEB3B' },
  { id: 6, name: "Matcha", origin: "Japan", temp: "80°C / 176°F", time: "Whisk", colorCode: '#4CAF50' },
  { id: 7, name: "Oolong", origin: "Taiwan", temp: "85°C / 185°F", time: "3-5 min", colorCode: '#FF9800' }
];

@Entry
@Component
struct ZenBrewApp {
  @State teas: TeaGuide[] = sampleTeas;

  build() {
    Column() {
      // Top Bar
      Row() {
        Column() {
          Text("ZenBrew")
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(-0.5)
            .fontColor('#121212')
          
          Text("Mindful Steeping Guide")
            .fontSize(14)
            .fontColor('#757575')
            .fontWeight(FontWeight.Normal)
        }
        
        Flex({ justifyContent: FlexAlign.End }) {
          Button('', { type: ButtonType.Circle })
            .width(40)
            .height(40)
            .backgroundColor(Color.Transparent)
            .borderWidth(0)
            .onClick(() => {
              // Settings action
            })
            .stateEffect(false)
            .icon($r('app.media.settings')) 
        }
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 40, bottom: 10 })
      .alignItems(VerticalAlign.Center)

      // Scrollable Content
      Scroll() {
        Column() {
          PromoCard()
          
          Text("Collections")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .margin({ top: 16, bottom: 8 })
            .fontColor('#121212')

          ForEach(this.teas, (tea: TeaGuide) => {
            TeaItemCard({ tea: tea })
          })
          
          // Spacer for FAB
          Blank().height(80)
        }
        .padding({ left: 20, right: 20 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      
      // Floating Action Button
      Button("Custom Brew")
        .width('auto')
        .height(56)
        .backgroundColor('#121212')
        .fontColor(Color.White)
        .borderRadius(16)
        .margin({ right: 20, bottom: 30 })
        .position({ x: 'calc(100% - 140px)', y: 'calc(100% - 60px)' })
        .zIndex(10)
        .onClick(() => {
          // Custom Brew action
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct PromoCard {
  build() {
    Column() {
      Row() {
        Column() {
          Text("Tip of the day")
            .fontSize(12)
            .fontColor(Color.Gray)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 4 })
          
          Text("Use filtered water for a purer taste profile.")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#121212')
        }
        .layoutWeight(1)
        
        Blank().width(16)
        
        Row() {
          Image($r('app.media.info')) // Placeholder for icon
            .width(24)
            .height(24)
            .fillColor(Color.Gray)
        }
        .width(48)
        .height(48)
        .backgroundColor(Color.White)
        .borderRadius(24)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding(24)
    }
    .width('100%')
    .backgroundColor('#F0F0F0')
    .borderRadius(20)
    .margin({ bottom: 16 })
  }
}

@Component
struct TeaItemCard {
  @Prop tea: TeaGuide;

  build() {
    Column() {
      Row() {
        // Visual Dot identifier
        Row() {
          Text(this.tea.name.substring(0, 1))
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.tea.colorCode)
        }
        .width(50)
        .height(50)
        .backgroundColor(Color.White)
        .borderRadius(25)
        .border({ width: 2, color: this.tea.colorCode, radius: 25 })
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        
        Blank().width(16)
        
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
        .layoutWeight(1)
        
        Blank().width(16)
        
        // Play Button
        Button('', { type: ButtonType.Circle })
          .width(40)
          .height(40)
          .backgroundColor(Color.White)
          .border({ width: 1, color: '#E0E0E0', radius: 20 })
          .onClick(() => {
            // Start Timer action
          })
          .stateEffect(false)
          .icon($r('app.media.play')) 
      }
      .width('100%')
      .padding(16)
    }
    .width('100%')
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE', radius: 16 })
    .margin({ bottom: 16 })
  }
}

@Component
struct InfoBadge {
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