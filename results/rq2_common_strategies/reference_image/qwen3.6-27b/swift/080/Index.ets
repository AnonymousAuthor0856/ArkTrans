// entry/src/main/ets/pages/FurnitureDetailPage.ets
import { router } from '@kit.ArkUI';

@Entry
@Component
struct FurnitureDetailPage {
  @State private isFavorite: boolean = false;
  @State private selectedColorIndex: number = 0;
  
  build() {
    Column() {
      // Header
      this.buildHeader()
      
      // Scrollable content
      Scroll() {
        Column({ space: 24 }) {
          // Product image placeholder
          this.buildProductImage()
          
          // Product info section
          this.buildProductInfo()
        }
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      
      // Bottom action section
      this.buildBottomActions()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
  
  @Builder
  buildHeader() {
    Row() {
      // Back button
      Button() {
        Image($r('app.media.ic_back'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: Color('#E0E0E0'), style: BorderStyle.Solid })
      .onClick(() => {
        router.back();
      })
      
      Spacer()
      
      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(Color.Black)
      
      Spacer()
      
      // Favorite button
      Button() {
        Image(this.isFavorite ? $r('app.media.ic_heart_filled') : $r('app.media.ic_heart_outline'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: Color('#E0E0E0'), style: BorderStyle.Solid })
      .onClick(() => {
        this.isFavorite = !this.isFavorite;
      })
    }
    .width('100%')
    .padding({ top: 16, bottom: 16 })
  }
  
  @Builder
  buildProductImage() {
    Column() {
      Image($r('app.media.ic_cart_placeholder'))
        .width(80)
        .height(80)
        .objectFit(ImageFit.Contain)
    }
    .width('100%')
    .height(300)
    .borderRadius(32)
    .backgroundColor(Color('#F5F5F5'))
    .justifyContent(FlexAlign.Center)
  }
  
  @Builder
  buildProductInfo() {
    Column({ space: 24 }) {
      // Title and price row
      Row() {
        Column({ space: 8 }) {
          Text('Modern Lounge\nChair')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .lineHeight(32)
          
          Text('Minimalist Series')
            .fontSize(16)
            .fontColor(Color.Gray)
        }
        
        Spacer()
        
        Text('$1299')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      
      // Rating section
      Row() {
        Image($r('app.media.ic_star_filled'))
          .width(20)
          .height(20)
        
        Text('4.8')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ left: 4 })
        
        Text('(238 Reviews)')
          .fontSize(14)
          .fontColor(Color.Gray)
          .margin({ left: 8 })
      }
      
      // Colors section
      Column({ space: 12 }) {
        Text('Colors')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(Color.Black)
        
        Row({ space: 12 }) {
          this.buildColorSelector(Color('#212121'), 0)
          this.buildColorSelector(Color('#795548'), 1)
          this.buildColorSelector(Color('#9E9E9E'), 2)
        }
      }
    }
  }
  
  @Builder
  buildColorSelector(color: Color, index: number) {
    Stack() {
      Circle()
        .width(32)
        .height(32)
        .fill(color)
      
      if (this.selectedColorIndex === index) {
        Circle()
          .width(32)
          .height(32)
          .border({ width: 2, color: Color.Gray.opacity(0.5), style: BorderStyle.Solid })
        
        Circle()
          .width(10)
          .height(10)
          .fill(Color.White)
      }
    }
    .onClick(() => {
      this.selectedColorIndex = index;
    })
  }
  
  @Builder
  buildBottomActions() {
    Row() {
      Button('Add to Cart')
        .width('70%')
        .height(56)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .backgroundColor(Color.Black)
        .borderRadius(16)
      
      Button() {
        Image($r('app.media.ic_heart_filled'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(56)
      .height(56)
      .borderRadius(16)
      .backgroundColor(Color('#F5F5F5'))
      .margin({ left: 16 })
    }
    .width('100%')
    .padding({ left: 24, right: 24, bottom: 24 })
  }
}