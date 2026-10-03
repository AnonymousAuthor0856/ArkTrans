import { BusinessError } from '@kit.BasicServicesKit';
import { common, UIAbility } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct FurnitureApp {
  @State statusBarHeight: number = 0;

  aboutToAppear() {
    // Get status bar height to adjust padding if necessary, though we are hiding it.
    // In ArkTS, hiding status bar is done via window stage.
  }

  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct ContentView {
  build() {
    Column() {
      FurnitureDetailScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct FurnitureDetailScreen {
  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column() {
        // Header
        HeaderBar()
          .padding({ left: 24, right: 24, top: 16 })
        
        // Content Scrollable Area
        Scroll() {
          Column({ space: 0 }) {
            Blank().height(24)
            
            ProductImagePlaceholder()
            
            Blank().height(32)
            
            ProductInfoSection()
            
            Blank().height(24)
          }
          .padding({ left: 24, right: 24 })
          .alignItems(HorizontalAlign.Start)
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        
        // Bottom Actions (Sticky at bottom)
        BottomActionSection()
          .padding({ left: 24, right: 24, bottom: 24 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct HeaderBar {
  build() {
    Row() {
      Button() {
        Image($r('app.media.ic_arrow_left')) // Placeholder for system icon, using generic placeholder logic below
          .width(20)
          .height(20)
          .fillColor(Color.Black)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
      .borderWidth(1)
      .borderColor('#E0E0E0')
      .borderRadius(24)
      .width(48)
      .height(48)
      
      Blank()
      
      Text("Details")
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
      
      Blank()
      
      Button() {
        Image($r('app.media.ic_heart')) // Placeholder
          .width(20)
          .height(20)
          .fillColor(Color.Black)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
      .borderWidth(1)
      .borderColor('#E0E0E0')
      .borderRadius(24)
      .width(48)
      .height(48)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct ProductImagePlaceholder {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Rect()
        .fill('#F5F5F5')
        .borderRadius(32)
      
      Image($r('app.media.ic_cart')) // Placeholder
        .width(80)
        .height(80)
        .objectFit(ImageFit.Contain)
        .fillColor('#BDBDBD')
    }
    .width('100%')
    .height(300)
  }
}

@Component
struct ProductInfoSection {
  build() {
    Column({ space: 0 }) {
      Row({ space: 0 }) {
        Column({ space: 8 }) {
          Text("Modern Lounge\nChair")
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .lineHeight(32) // Approximating line spacing
            
          Text("Minimalist Series")
            .fontSize(16)
            .fontColor(Color.Gray)
        }
        .alignItems(HorizontalAlign.Start)
        
        Blank()
        
        Text("$1299")
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)
      
      Blank().height(24)
      
      Row({ space: 0 }) {
        Image($r('app.media.ic_star')) // Placeholder
          .width(20)
          .height(20)
          .fillColor('#FFC107')
        
        Blank().width(4)
        
        Text("4.8")
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        
        Blank().width(8)
        
        Text("(238 Reviews)")
          .fontSize(14)
          .fontColor(Color.Gray)
      }
      .width('100%')
      
      Blank().height(24)
      
      Text("Colors")
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
      
      Blank().height(12)
      
      Row({ space: 12 }) {
        ColorSelector({ color: '#212121', isSelected: true })
        ColorSelector({ color: '#795548', isSelected: false })
        ColorSelector({ color: '#9E9E9E', isSelected: false })
      }
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ColorSelector {
  @Prop color: string;
  @Prop isSelected: boolean;

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .fill(this.color)
        .width(32)
        .height(32)
      
      if (this.isSelected) {
        Circle()
          .stroke(Color.Gray)
          .opacity(0.5)
          .strokeWidth(2)
          .width(32)
          .height(32)
        
        Circle()
          .fill(Color.White)
          .width(10)
          .height(10)
      }
    }
  }
}

@Component
struct BottomActionSection {
  build() {
    Row({ space: 16 }) {
      Button("Add to Cart")
      .fontSize(16)
      .fontWeight(FontWeight.Bold)
      .fontColor(Color.White)
      .backgroundColor(Color.Black)
      .borderRadius(16)
      .height(56)
      .layoutWeight(1)
      
      Stack({ alignContent: Alignment.Center }) {
        Rect()
          .fill('#F5F5F5')
          .borderRadius(16)
          .width(56)
          .height(56)
        
        Image($r('app.media.ic_heart_fill')) // Placeholder
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
    }
    .width('100%')
  }
}