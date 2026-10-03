import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - Color Utilities
// ArkTS does not support extension methods on built-in types like Color in the same way.
// We use a helper function to convert Hex strings to ArkUI Color objects.
function hexToColor(hex: string): Color {
  // Remove '#' if present
  const cleanHex = hex.replace('#', '');
  
  // Parse components
  const r = parseInt(cleanHex.substring(0, 2), 16) / 255;
  const g = parseInt(cleanHex.substring(2, 4), 16) / 255;
  const b = parseInt(cleanHex.substring(4, 6), 16) / 255;
  
  return new Color(`rgb(${Math.round(r * 255)}, ${Math.round(g * 255)}, ${Math.round(b * 255)})`);
}

// Theme Colors
const THEME = {
  primaryBlack: '#121212',
  textGrey: '#757575',
  backgroundWhite: '#FFFFFF',
  cardBackground: '#F9F9F9',
  promoCardBackground: '#F0F0F0',
  lightGreyBorder: '#EEEEEE',
  veryLightGreyBorder: '#E0E0E0'
};

// MARK: - Data Models
interface TeaGuide {
  id: number;
  name: string;
  origin: string;
  temp: string;
  time: string;
  colorCode: string; // Hex string
}

const sampleTeas: TeaGuide[] = [
  { id: 1, name: "Sencha Green", origin: "Japan", temp: "70°C / 158°F", time: "1-2 min", colorCode: "#8BC34A" },
  { id: 2, name: "Earl Grey", origin: "Blend", temp: "95°C / 203°F", time: "3-5 min", colorCode: "#795548" },
  { id: 3, name: "Silver Needle", origin: "China", temp: "80°C / 176°F", time: "3-4 min", colorCode: "#E0E0E0" },
  { id: 4, name: "Darjeeling", origin: "India", temp: "90°C / 194°F", time: "3 min", colorCode: "#D7CCC8" },
  { id: 5, name: "Chamomile", origin: "Egypt", temp: "100°C / 212°F", time: "5-7 min", colorCode: "#FFEB3B" },
  { id: 6, name: "Matcha", origin: "Japan", temp: "80°C / 176°F", time: "Whisk", colorCode: "#4CAF50" },
  { id: 7, name: "Oolong", origin: "Taiwan", temp: "85°C / 185°F", time: "3-5 min", colorCode: "#FF9800" }
];

// MARK: - UI Components

@Entry
@Component
struct ZenBrewAppView {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        // Main Scrollable Content
        Scroll() {
          Column({ space: 16 }) {
            // Top Bar
            Row() {
              Column() {
                Text('ZenBrew')
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(THEME.primaryBlack)
                  .letterSpacing(-0.5)
                
                Text('Mindful Steeping Guide')
                  .fontSize(14)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(THEME.textGrey)
                  .margin({ top: 2 })
              }
              
              Blank()
              
              Button() {
                Image($r('app.media.ic_settings')) // Placeholder for gear icon
                  .width(24)
                  .height(24)
                  .fillColor(THEME.primaryBlack)
              }
              .width(44)
              .height(44)
              .onClick(() => {
                console.info("Settings tapped");
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
              .fontWeight(FontWeight.SemiBold)
              .fontColor(THEME.primaryBlack)
              .textAlign(TextAlign.Start)
              .width('100%')
              .padding({ top: 8, bottom: 8, left: 20, right: 20 })

            // Tea List
            ForEach(sampleTeas, (tea: TeaGuide) => {
              TeaItemCard(tea: tea)
                .margin({ left: 20, right: 20 })
            }, (item: TeaGuide) => item.id.toString())

            // Bottom Spacer for FAB
            Blank().height(80)
          }
          .padding({ top: 10, bottom: 10 })
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(THEME.backgroundWhite)
        .scrollBar(BarState.Off)
        
        // Floating Action Button
        Button() {
          Row() {
            Image($r('app.media.ic_add')) // Placeholder for plus icon
              .width(20)
              .height(20)
              .fillColor(Color.White)
            
            Text('Custom Brew')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
              .margin({ left: 8 })
          }
          .justifyContent(FlexAlign.Center)
        }
        .height(56)
        .padding({ left: 24, right: 24 })
        .backgroundColor(THEME.primaryBlack)
        .borderRadius(16)
        .margin({ right: 20, bottom: 20 })
        .onClick(() => {
          console.info("Custom Brew tapped");
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(THEME.backgroundWhite)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(THEME.backgroundWhite)
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
          .fontColor('#808080') // Gray
          .margin({ bottom: 4 })
        
        Text('Use filtered water for a purer taste profile.')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(THEME.primaryBlack)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      
      Blank().width(16)
      
      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fillColor(Color.White)
        
        Image($r('app.media.ic_info')) // Placeholder for info icon
          .width(24)
          .height(24)
          .fillColor('#808080')
      }
    }
    .padding(24)
    .backgroundColor(THEME.promoCardBackground)
    .borderRadius(20)
  }
}

@Component
struct TeaItemCard {
  private tea: TeaGuide = { id: 0, name: "", origin: "", temp: "", time: "", colorCode: "" };

  build() {
    Row() {
      // Left Circle Identifier
      Stack() {
        Circle()
          .width(50)
          .height(50)
          .fillColor(Color.White)
          .border({ width: 2, color: this.tea.colorCode + '4D' }) // Add opacity ~0.3 (4D is approx 30% in hex)
        
        Text(this.tea.name.charAt(0))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.tea.colorCode)
      }
      
      Blank().width(16)
      
      // Info Column
      Column() {
        Text(this.tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(THEME.primaryBlack)
        
        Text(this.tea.origin)
          .fontSize(12)
          .fontColor(THEME.textGrey)
          .margin({ top: 2 })
        
        Blank().height(6)
        
        Row() {
          InfoBadge(label: this.tea.temp)
          Blank().width(8)
          InfoBadge(label: this.tea.time)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      
      // Play Button
      Button() {
        Image($r('app.media.ic_play')) // Placeholder for play icon
          .width(20)
          .height(20)
          .fillColor(THEME.primaryBlack)
      }
      .width(40)
      .height(40)
      .backgroundColor(Color.White)
      .borderRadius(20)
      .border({ width: 1, color: THEME.veryLightGreyBorder })
      .onClick(() => {
        console.info(`Play for ${this.tea.name} tapped`);
      })
    }
    .padding(16)
    .backgroundColor(THEME.cardBackground)
    .borderRadius(16)
    .border({ width: 1, color: THEME.lightGreyBorder })
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
      .border({ width: 1, color: THEME.veryLightGreyBorder })
  }
}