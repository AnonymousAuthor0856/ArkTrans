// src/main/ets/entryability/MainAbility.ets
import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

export default class MainAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    // Ability lifecycle management
  }

  onDestroy(): void {
    // Ability lifecycle management
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        return;
      }
    });
    
    // Hide system bars for immersive experience as per Kotlin source
    const mainWindow = windowStage.getMainWindowSync();
    mainWindow.setWindowLayoutFullScreen(true);
  }
}

// src/main/ets/pages/Index.ets
@Entry
@Component
struct Index {
  @State activeFilter: string = 'All'
  
  // Data Models
  private cargoCards: CargoCard[] = [
    { title: "Copper stack", id: "SH-014", fill: "78%" },
    { title: "Fiber reels", id: "SH-022", fill: "64%" },
    { title: "Agro crates", id: "SH-031", fill: "92%" },
    { title: "Glass kits", id: "SH-045", fill: "51%" },
    { title: "Steel mesh", id: "SH-057", fill: "88%" },
    { title: "Raw silica", id: "SH-063", fill: "43%" }
  ]

  private manifestEntries: ManifestEntry[] = [
    { origin: "Santiago", destination: "Lima", status: "Boarding" },
    { origin: "Mecca", destination: "Algiers", status: "At dock" },
    { origin: "Reykjavík", destination: "Oslo", status: "Delayed" },
    { origin: "Perth", destination: "Jakarta", status: "In flight" }
  ]

  private filters: string[] = ["All", "Atlantic", "Pacific", "Inland"]

  build() {
    Stack() {
      Column() {
        // === Top Bar ===
        Row() {
          // Left Icon Placeholder
          Circle({ width: 26, height: 26 }).fill('#2A1C14')
          
          Blank()
          
          // Center Title
          Column() {
            Text('SupplyHub').fontColor('#FBEFE0').fontSize(16).fontWeight(FontWeight.Medium)
            Text('Logistics grid').fontColor('#FBEFE0').opacity(0.7).fontSize(12).fontWeight(FontWeight.Medium)
          }
          
          Blank()
          
          // Right Icon Placeholder
          Circle({ width: 26, height: 26 }).fill('#2A1C14')
        }
        .width('100%')
        .height(56)
        .padding({ left: 18, right: 18 })
        .backgroundColor('#19110D')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // === Scrollable Content ===
        Scroll() {
          Column() {
            // Filter Chips
            Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
              ForEach(this.filters, (filter: string) => {
                Button(filter)
                  .type(ButtonType.Normal)
                  .backgroundColor(this.activeFilter === filter ? '#C27D38' : '#2A1C14')
                  .fontColor(this.activeFilter === filter ? '#100C08' : '#FBEFE0')
                  .borderRadius(10)
                  .padding({ left: 14, right: 14, top: 6, bottom: 6 })
                  .margin({ right: 10, bottom: 10 })
                  .onClick(() => {
                    this.activeFilter = filter
                  })
              })
            }
            .width('100%')
            .margin({ top: 18, bottom: 18 })

            // Section Header
            Text('Cargo grid')
              .fontColor('#FBEFE0')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 18 })

            // Grid Layout
            Grid() {
              ForEach(this.cargoCards, (card: CargoCard) => {
                GridItem() {
                  Column() {
                    // Image Placeholder Area
                    Row() {
                      Circle({ width: 60, height: 60 }).fill('#F2C57C').opacity(0.4)
                    }
                    .width('100%')
                    .height(90)
                    .backgroundColor('#19110D')
                    .borderRadius(10)
                    .justifyContent(FlexAlign.Center)
                    .alignItems(VerticalAlign.Center)
                    
                    Column() {
                      Text(card.title).fontColor('#FBEFE0').fontSize(16).fontWeight(FontWeight.Medium)
                      Text(card.id).fontColor('#FBEFE0').opacity(0.7).fontSize(14).margin({ top: 6 })
                      Text(`Fill ${card.fill}`).fontColor('#6ECE89').fontSize(12).fontWeight(FontWeight.Medium).margin({ top: 6 })
                    }
                    .margin({ top: 14 })
                  }
                  .width('100%')
                  .backgroundColor('#2A1C14')
                  .borderRadius(18)
                  .padding(18)
                }
              })
            }
            .columnsTemplate('1fr 1fr')
            .rowsGap(14)
            .columnsGap(14)
            .width('100%')
            .margin({ bottom: 18 })

            // Section Header
            Text('Route manifest')
              .fontColor('#FBEFE0')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 18 })

            // Manifest List
            List({ space: 14 }) {
              ForEach(this.manifestEntries, (entry: ManifestEntry) => {
                ListItem() {
                  Row() {
                    Column() {
                      Text(`${entry.origin} → ${entry.destination}`)
                        .fontColor('#FBEFE0')
                        .fontSize(16)
                        .fontWeight(FontWeight.Medium)
                      
                      Text(entry.status)
                        .fontColor(this.getStatusColor(entry.status))
                        .fontSize(14)
                        .margin({ top: 6 })
                    }
                    
                    Blank()
                    
                    Button('Details')
                      .type(ButtonType.Normal)
                      .backgroundColor('#C27D38')
                      .fontColor('#100C08')
                      .borderRadius(10)
                      .padding({ left: 14, right: 14, top: 10, bottom: 10 })
                  }
                  .width('100%')
                  .backgroundColor('#2A1C14')
                  .borderRadius(18)
                  .padding(18)
                  .justifyContent(FlexAlign.SpaceBetween)
                  .alignItems(VerticalAlign.Center)
                }
              })
            }
            .width('100%')
            .layoutWeight(1)
            
            // Bottom Spacer for the fixed bar
            Column().height(100)
          }
          .width('100%')
          .padding({ left: 26, right: 26, top: 18 })
        }
        .layoutWeight(1)
        
        // === Bottom Bar ===
        Row() {
          Column() {
            Text('Manifest filter').fontColor('#FBEFE0').fontSize(12).fontWeight(FontWeight.Medium)
            Text(this.activeFilter).fontColor('#FBEFE0').fontSize(16).fontWeight(FontWeight.Medium).margin({ top: 6 })
          }
          
          Blank()
          
          Button('Dispatch')
            .type(ButtonType.Normal)
            .backgroundColor('#8B6B4C')
            .fontColor('#100C08')
            .borderRadius(18)
            .padding({ left: 36, right: 36, top: 10, bottom: 10 })
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .height(100)
        .backgroundColor('#19110D')
        .padding({ left: 26, right: 26, top: 18, bottom: 18 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#100C08')
    }
    .width('100%')
    .height('100%')
  }

  getStatusColor(status: string): ResourceColor {
    switch (status) {
      case 'Delayed':
        return '#E19F41'
      case 'In flight':
        return '#6ECE89'
      default:
        return '#FBEFE0'
    }
  }
}

interface CargoCard {
  title: string
  id: string
  fill: string
}

interface ManifestEntry {
  origin: string
  destination: string
  status: string
}