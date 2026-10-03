// entry/src/main/ets/MainPage.ets

import { router } from '@kit.ArkUI';

@Entry
@Component
struct SupplyHubApp {
  @State activeFilter: string = 'All'
  private filters: string[] = ['All', 'Atlantic', 'Pacific', 'Inland']
  
  // Data Models
  private cargoData: CargoItem[] = [
    { title: "Copper stack", id: "SH-014", fill: "78%" },
    { title: "Fiber reels", id: "SH-022", fill: "64%" },
    { title: "Agro crates", id: "SH-031", fill: "92%" },
    { title: "Glass kits", id: "SH-045", fill: "51%" },
    { title: "Steel mesh", id: "SH-057", fill: "88%" },
    { title: "Raw silica", id: "SH-063", fill: "43%" }
  ]

  build() {
    Column() {
      // Top Bar
      Row() {
        Circle({ width: 26, height: 26 })
          .fill('#2A1C14')
        
        Column() {
          Text('SupplyHub')
            .fontColor('#FBEFE0')
            .fontWeight(FontWeight.Medium)
            .fontSize(16)
          Text('Logistics grid')
            .fontColor('#FBEFE0')
            .opacity(0.7)
            .fontSize(12)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)

        Circle({ width: 26, height: 26 })
          .fill('#2A1C14')
      }
      .width('100%')
      .height(60)
      .padding({ left: 26, right: 26 })
      .backgroundColor('#19110D')
      .borderRadius(18)
      .margin({ bottom: 18 })

      // Main Scrollable Content
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
                .height(36)
                .margin({ right: 10, bottom: 10 })
                .onClick(() => {
                  this.activeFilter = filter
                })
            })
          }
          .width('100%')
          .margin({ bottom: 18 })

          // Section Title
          Text('Cargo grid')
            .fontColor('#FBEFE0')
            .fontSize(22)
            .fontWeight(FontWeight.SemiBold)
            .margin({ bottom: 18 })

          // Grid Layout
          GridContainer()
            .columnsTemplate('1fr 1fr')
            .rowsTemplate('auto auto')
            .width('100%')
            .gap(14)
            .margin({ bottom: 18 })
            .children({
              items: this.cargoData.slice(0, 4), // Show first 4 for visual match
              builder: (item: CargoItem) => {
                CargoCard(item)
              }
            })

          // Bottom Spacer to prevent overlap with fixed bar
          Blank().height(100)
        }
        .padding({ left: 26, right: 26 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Fixed Bottom Bar
      Row() {
        Column() {
          Text('Manifest filter')
            .fontColor('#FBEFE0')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
          Text(this.activeFilter)
            .fontColor('#FBEFE0')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ top: 4 })
        }
        
        Button('Dispatch')
          .type(ButtonType.Normal)
          .backgroundColor('#8B6B4C')
          .fontColor('#100C08')
          .borderRadius(18)
          .height(48)
          .width(140)
          .margin({ left: 20 })
      }
      .width('100%')
      .height(100)
      .padding({ left: 26, right: 26 })
      .backgroundColor('#19110D')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#100C08')
  }
}

// Helper Components and Types

interface CargoItem {
  title: string;
  id: string;
  fill: string;
}

@Component
struct CargoCard {
  @Prop item: CargoItem

  build() {
    Column() {
      // Image Placeholder Area
      Row() {
        Circle({ width: 60, height: 60 })
          .fill('#F2C57C')
          .opacity(0.4)
      }
      .width('100%')
      .height(90)
      .backgroundColor('#19110D')
      .borderRadius(10)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      
      Column() {
        Text(this.item.title)
          .fontColor('#FBEFE0')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .margin({ top: 14 })
        
        Text(this.item.id)
          .fontColor('#FBEFE0')
          .opacity(0.7)
          .fontSize(14)
          .margin({ top: 4 })
          
        Text(`Fill ${this.item.fill}`)
          .fontColor('#6ECE89')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .margin({ top: 4 })
      }
    }
    .width('100%')
    .padding(18)
    .backgroundColor('#2A1C14')
    .borderRadius(18)
  }
}

// Custom Grid Component to mimic LazyGrid behavior in a single file without complex imports
@Component
struct GridContainer {
  columnsTemplate: string = '1fr 1fr'
  rowsTemplate: string = 'auto auto'
  gap: number = 10
  
  @BuilderParam children: () => void

  build() {
    GridRow() {
      GridCol() {
        this.children()
      }
      GridCol() {
        this.children()
      }
    }
    .gridTemplateColumns(this.columnsTemplate)
    .gridTemplateRows(this.rowsTemplate)
    .rowGap(this.gap)
    .columnGap(this.gap)
  }
}

// Simple UI Primitives for cleaner code
@Component
struct Circle {
  @Prop width: number = 10
  @Prop height: number = 10

  build() {
    Circle({ width: `${this.width}`, height: `${this.height}` })
  }
}