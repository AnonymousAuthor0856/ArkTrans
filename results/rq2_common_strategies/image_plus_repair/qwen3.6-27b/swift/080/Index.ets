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
    .backgroundColor('#FFFFFF')
  }
  
  @Builder
  buildHeader() {
    Row() {
      // Back button
      Button() {
        Image($r('app.media.back'))
          .width(24)
          .height(24)
          .fillColor('#000000')
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: '#E0E0E0', style: BorderStyle.Solid })
      .onClick(() => {
        router.back();
      })
      
      Blank()
      
      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
      
      Blank()
      
      // Favorite button
      Button() {
        Image(this.isFavorite ? $r('app.media.heart_filled') : $r('app.media.heart_outline'))
          .width(24)
          .height(24)
          .fillColor('#000000')
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: '#E0E0E0', style: BorderStyle.Solid })
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
      Image($r('app.media.cart_placeholder'))
        .width(80)
        .height(80)
        .objectFit(ImageFit.Contain)
    }
    .width('100%')
    .height(300)
    .borderRadius(32)
    .backgroundColor('#F5F5F5')
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
            .fontColor('#000000')
            .lineHeight(32)
          
          Text('Minimalist Series')
            .fontSize(16)
            .fontColor('#999999')
        }
        
        Blank()
        
        Text('$1299')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      
      // Rating section
      Row() {
        Image($r('app.media.star_filled'))
          .width(20)
          .height(20)
        
        Text('4.8')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .margin({ left: 4 })
        
        Text('(238 Reviews)')
          .fontSize(14)
          .fontColor('#999999')
          .margin({ left: 8 })
      }
      
      // Colors section
      Column({ space: 12 }) {
        Text('Colors')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
        
        Row({ space: 12 }) {
          this.buildColorSelector('#212121', 0)
          this.buildColorSelector('#795548', 1)
          this.buildColorSelector('#9E9E9E', 2)
        }
      }
    }
  }
  
  @Builder
  buildColorSelector(color: string, index: number) {
    Stack() {
      Circle()
        .width(32)
        .height(32)
        .fill(color)
      
      if (this.selectedColorIndex === index) {
        Circle()
          .width(32)
          .height(32)
          .border({ width: 2, color: '#999999', style: BorderStyle.Solid })
          .opacity(0.5)
        
        Circle()
          .width(10)
          .height(10)
          .fill('#FFFFFF')
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
        .fontColor('#FFFFFF')
        .backgroundColor('#000000')
        .borderRadius(16)
      
      Button() {
        Image($r('app.media.heart_filled'))
          .width(24)
          .height(24)
          .fillColor('#000000')
      }
      .width(56)
      .height(56)
      .borderRadius(16)
      .backgroundColor('#F5F5F5')
      .margin({ left: 16 })
    }
    .width('100%')
    .padding({ left: 24, right: 24, bottom: 24 })
  }
}