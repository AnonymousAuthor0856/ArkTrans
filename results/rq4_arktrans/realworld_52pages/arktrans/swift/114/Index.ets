@Entry
@Component
struct Index {
  @State pageSelected: number = 0

  build() {
    Stack() {
      Scroll() {
        Column() {
          // Hero Section
          Stack() {
            TabView({ index: this.pageSelected }) {
              ForEach([0, 1, 2, 3], (item: number) => {
                Image($r('app.media.startIcon')).width('100%').height('100%')
              }, (item: number) => item.toString())
            }
            .onChange((index: number) => {
              this.pageSelected = index
            })
            .height('45%')

            Column() {
              Row() {
                Image($r('app.media.startIcon'))
                  .width(45).height(45)
                  .fillColor('#FFC107')
                  .shadow({ radius: 5, color: '#000000', offsetY: 2 })
                
                Text('MovieApp')
                  .fontColor('#FFFFFF')
                  .fontSize(32)
                  .fontWeight(FontWeight.Bold)
                  .margin({ left: 8 })
              }
              .padding({ top: 44, left: 20, right: 20 })
              .alignItems(VerticalAlign.Top)

              Blank()

              Row() {
                ForEach([0, 1, 2, 3], (item: number) => {
                  Rect()
                    .width(this.pageSelected === item ? 22 : 16)
                    .height(6)
                    .borderRadius(3)
                    .fill(this.pageSelected === item ? '#FFC107' : '#808080')
                    .margin({ right: 8 })
                }, (item: number) => item.toString())
              }
              .justifyContent(FlexAlign.End)
              .padding({ bottom: 30, left: 20, right: 20 })
            }
            .width('100%')
            .height('100%')
          }
          .height('45%')

          // Popular Section
          Column() {
            Row() {
              Text('Popular')
                .fontColor('#FFFFFF')
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
              Blank()
            }
            .width('100%')
            .padding({ left: 20, right: 20, top: 20 })

            Scroll() {
              Row() {
                ForEach([0, 1, 2], (item: number) => {
                  Column() {
                    Rect()
                      .width(200)
                      .height(120)
                      .borderRadius(12)
                      .fill('#808080')
                    
                    Rect()
                      .width(120)
                      .height(16)
                      .borderRadius(4)
                      .fill('#333333')
                      .margin({ top: 10 })
                      
                    Rect()
                      .width(100)
                      .height(16)
                      .borderRadius(4)
                      .fill('#333333')
                      .margin({ top: 8 })
                  }
                  .margin({ right: 15 })
                }, (item: number) => item.toString())
              }
              .padding({ left: 20, right: 20 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            
            Blank().height(20)
          }
          .width('100%')

          // New Releases Section
          Column() {
            Row() {
              Text('New Releases')
                .fontColor('#FFFFFF')
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
              Blank()
            }
            .width('100%')
            .padding({ left: 20, right: 20, top: 20 })

            Scroll() {
              Row() {
                ForEach([0, 1, 2], (item: number) => {
                  Column() {
                    Rect()
                      .width(200)
                      .height(120)
                      .borderRadius(12)
                      .fill('#808080')
                    
                    Rect()
                      .width(120)
                      .height(16)
                      .borderRadius(4)
                      .fill('#333333')
                      .margin({ top: 10 })
                      
                    Rect()
                      .width(100)
                      .height(16)
                      .borderRadius(4)
                      .fill('#333333')
                      .margin({ top: 8 })
                  }
                  .margin({ right: 15 })
                }, (item: number) => item.toString())
              }
              .padding({ left: 20, right: 20 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            
            Blank().height(20)
          }
          .width('100%')
          
          Blank().height(100)
        }
        .width('100%')
        .backgroundColor('#1E1E1E')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#1E1E1E')
    }
    .width('100%')
    .height('100%')
  }
}