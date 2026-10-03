// CoffeeDetailScreen.ets
import { router } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct CoffeeDetailScreen {
  @State isFavorite: boolean = false;
  @State selectedSize: string = 'M';
  
  build() {
    Column() {
      // Top Bar
      Row() {
        // Back button
        Button() {
          Image($r('app.media.arrow_back'))
            .width(24)
            .height(24)
            .fillColor(Color.Black)
        }
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          router.back();
        })
        
        Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center })
          .layoutWeight(1)
        
        Text('Details')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        
        Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center })
          .layoutWeight(1)
        
        // Favorite button
        Button() {
          Image(this.isFavorite ? $r('app.media.favorite_filled') : $r('app.media.favorite_border'))
            .width(24)
            .height(24)
            .fillColor(this.isFavorite ? Color.Red : Color.Black)
        }
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          this.isFavorite = !this.isFavorite;
        })
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 16, bottom: 16 })
      
      // Scrollable content
      Scroll() {
        Column() {
          // Product image placeholder
          Row() {
            Image($r('app.media.shopping_cart'))
              .width(80)
              .height(80)
              .fillColor(Color.Gray)
          }
          .width('100%')
          .height(240)
          .borderRadius(32)
          .backgroundColor('#F5F5F5')
          .justifyContent(FlexAlign.Center)
          
          // Product title and rating
          Column() {
            Text('Caramel Macchiato')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .margin({ top: 24 })
            
            Row() {
              Image($r('app.media.star'))
                .width(20)
                .height(20)
                .fillColor('#FFC107')
              
              Text('4.8')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
                .margin({ left: 4 })
              
              Text('(230 reviews)')
                .fontSize(14)
                .fontColor(Color.Gray)
                .margin({ left: 4 })
            }
            .margin({ top: 8 })
            
            // Description section
            Column() {
              Text('Description')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.Black)
                .margin({ top: 24 })
              
              Text('A Caramel Macchiato is a coffee drink that contains espresso, steamed milk, vanilla syrup and caramel drizzle. It is a sweet and creamy beverage that balances the rich flavor of coffee.')
                .fontSize(15)
                .lineHeight(22)
                .fontColor(Color.Gray)
                .maxLines(4)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .margin({ top: 12 })
            }
            
            // Size selection
            Column() {
              Text('Size')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.Black)
                .margin({ top: 24 })
              
              Row() {
                this.SizeOption('S', this.selectedSize === 'S')
                this.SizeOption('M', this.selectedSize === 'M')
                this.SizeOption('L', this.selectedSize === 'L')
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .margin({ top: 16 })
            }
            
            // Bottom spacing for fixed bar
            Column()
              .height(100)
          }
          .padding({ left: 24, right: 24 })
        }
      }
      .layoutWeight(1)
      
      // Bottom action bar
      this.BottomBarAction()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
  
  @Builder
  SizeOption(label: string, isSelected: boolean) {
    Button() {
      Text(label)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(isSelected ? '#6F4E37' : Color.Black)
    }
    .width(100)
    .height(48)
    .borderRadius(12)
    .border({
      width: 1,
      color: isSelected ? '#6F4E37' : '#E0E0E0',
      radius: 12
    })
    .backgroundColor(isSelected ? '#FFF4E0' : Color.White)
    .onClick(() => {
      this.selectedSize = label;
    })
  }
  
  @Builder
  BottomBarAction() {
    Row() {
      Column() {
        Text('Price')
          .fontSize(14)
          .fontColor(Color.Gray)
        
        Text('$ 4.50')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#6F4E37')
      }
      
      Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center })
        .layoutWeight(1)
      
      Button('Add to Cart')
        .width(200)
        .height(56)
        .borderRadius(16)
        .backgroundColor('#6F4E37')
        .fontColor(Color.White)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .padding(24)
    .backgroundColor(Color.White)
    .shadow({
      radius: 16,
      color: 'rgba(0, 0, 0, 0.1)',
      offsetX: 0,
      offsetY: -4
    })
  }
}