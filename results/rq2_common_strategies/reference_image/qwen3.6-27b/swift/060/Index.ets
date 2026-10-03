// App.ets
import { router } from '@kit.ArkUI';

@Entry
@Component
struct UnitConverterApp {
  @State active: string = 'Length'
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed']

  build() {
    Column() {
      // Title
      Text('Unit Converter')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')
        .textAlign(TextAlign.Center)
        .width('100%')

      // Map Area
      Column() {
        Text('Unit Map Visualization')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#0F172A')
        
        Text(`Active Unit: ${this.active}`)
          .fontSize(12)
          .fontColor('#0F172A')
          .margin({ top: 6 })
      }
      .width('100%')
      .height(240)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor('#E2E8F0')
      .borderRadius(14)
      .border({ width: 1, color: '#CBD5E1' })
      .padding(14)

      // Marker List
      Column() {
        ForEach(this.markers, (marker: string) => {
          this.MarkerBox(marker, this.active === marker)
        }, (item: string) => item)
      }
      .width('100%')
      .gap(10)

      Spacer().height(10)

      // Button Row
      Row() {
        ForEach(this.markers, (marker: string) => {
          Button(marker) {
            this.active = marker
          }
          .backgroundColor(this.active === marker ? '#2563EB' : '#E2E8F0')
          .fontColor(this.active === marker ? '#FFFFFF' : '#1E293B')
          .borderRadius(6)
          .height(40)
          .minWidth(80)
          .onClick(() => {
            this.active = marker
          })
        }, (item: string) => item)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .padding(14)
    .linearGradient({
      angle: 90,
      colors: [['#38BDF8', 0], ['#2563EB', 1]]
    })
    .opacity(0.15)
    .position({ x: 0, y: 0 })
    .zIndex(-1)
    
    // Background container to ensure gradient covers everything properly
    Stack() {
       Column() {
         // Re-declaring content inside stack for proper z-indexing if needed, 
         // but ArkTS linearGradient on the main column usually works well.
         // To match the screenshot exactly where background is behind everything:
       }
       .width('100%')
       .height('100%')
       .linearGradient({
         angle: 90,
         colors: [['#38BDF8', 0], ['#2563EB', 1]]
       })
       .opacity(0.15)
    }
    .width('100%')
    .height('100%')
    .position({x:0, y:0})
    .zIndex(-1)
  }

  @Builder
  MarkerBox(unit: string, isActive: boolean) {
    Column() {
      Text(unit)
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#0F172A')
      
      Text('Tap to convert')
        .fontSize(12)
        .fontColor('#0F172A')
        .margin({ top: 2 })
    }
    .width('100%')
    .height(80)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .padding(10)
    .backgroundColor(isActive ? '#38BDF8' : '#FFFFFF')
    .opacity(isActive ? 0.3 : 1) // The screenshot shows active box is lighter blue, likely secondary color with opacity
    .borderRadius(10)
    .border({ width: 1, color: '#CBD5E1' })
  }
}