import { BusinessError } from '@kit.BasicServicesKit';
import { common, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false;
  @State selectedColorIndex: number = 0;

  build() {
    Column() {
      this.HeaderBar()
      
      Spacer().height(24)
      
      this.ProductImagePlaceholder()
      
      Spacer().height(32)
      
      this.ProductInfoSection()
      
      Spacer().layoutWeight(1)
      
      this.BottomActionSection()
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24 })
    .backgroundColor(Color.White)
  }

  @Builder
  HeaderBar() {
    Row() {
      Button() {
        Image($r('app.media.ic_arrow_back')) // Placeholder for icon, assuming standard vector asset or use SymbolGlyph
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .type(ButtonType.Normal)
      .borderRadius(24)
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)
      .border({ width: 1, color: Color.Gray, radius: 24 })
      .onClick(() => {
        // Back action
      })

      Text("Details")
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(Color.Black)

      Button() {
        Image($r('app.media.ic_favorite_border')) // Placeholder for icon
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .type(ButtonType.Normal)
      .borderRadius(24)
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)
      .border({ width: 1, color: Color.Gray, radius: 24 })
      .onClick(() => {
        // Favorite action
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  ProductImagePlaceholder() {
    Column() {
      Image($r('app.media.ic_shopping_cart')) // Placeholder for icon
        .width(80)
        .height(80)
        .fillColor(Color.Gray)
    }
    .width('100%')
    .height(300)
    .borderRadius(32)
    .backgroundColor('#F5F5F5')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ProductInfoSection() {
    Column() {
      Row() {
        Column() {
          Text("Modern Lounge Chair")
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .lineHeight(32)
          
          Spacer().height(8)
          
          Text("Minimalist Series")
            .fontSize(16)
            .fontColor(Color.Gray)
        }
        .layoutWeight(1)

        Text("$1299")
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Top)

      Spacer().height(24)

      Row() {
        Image($r('app.media.ic_star')) // Placeholder for icon
          .width(20)
          .height(20)
          .fillColor('#FFC107')
        
        Spacer().width(4)
        
        Text("4.8")
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        
        Spacer().width(8)
        
        Text("(238 Reviews)")
          .fontColor(Color.Gray)
          .fontSize(14)
      }
      .alignItems(VerticalAlign.Center)

      Spacer().height(24)

      Text("Colors")
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(Color.Black)

      Spacer().height(12)

      Row() {
        ForEach([
          { color: '#212121', index: 0 },
          { color: '#795548', index: 1 },
          { color: '#9E9E9E', index: 2 }
        ], (item: { color: string, index: number }) => {
          this.ColorSelector(item.color, item.index === this.selectedColorIndex, () => {
            this.selectedColorIndex = item.index;
          })
        }, (item: { color: string, index: number }) => item.index.toString())
      }
      .justifyContent(FlexAlign.Start)
      .columnGap(12)
    }
    .width('100%')
  }

  @Builder
  ColorSelector(color: string, isSelected: boolean, onClick: () => void) {
    Stack() {
      Circle()
        .width(32)
        .height(32)
        .fill(color)
      
      if (isSelected) {
        Circle()
          .width(10)
          .height(10)
          .fill(Color.White)
      }
    }
    .width(32)
    .height(32)
    .onClick(onClick)
    .border(isSelected ? { width: 2, color: Color.LightGray, radius: 16 } : undefined)
  }

  @Builder
  BottomActionSection() {
    Row() {
      Button("Add to Cart")
        .type(ButtonType.Capsule)
        .height(56)
        .layoutWeight(1)
        .backgroundColor(Color.Black)
        .fontColor(Color.White)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .borderRadius(16)
        .onClick(() => {
          // Add to cart action
        })

      Button() {
        Image($r('app.media.ic_favorite')) // Placeholder for icon
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .type(ButtonType.Capsule)
      .width(56)
      .height(56)
      .backgroundColor('#F5F5F5')
      .borderRadius(16)
      .onClick(() => {
        // Favorite action
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .columnGap(16)
  }
}