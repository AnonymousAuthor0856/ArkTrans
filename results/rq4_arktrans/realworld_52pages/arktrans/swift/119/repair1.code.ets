import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Text('Trending Movies')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 50, bottom: 20 })

      List() {
        ListItem() {
          Row() {
            Image($r('app.media.startIcon'))
              .width(100)
              .height(150)
              .borderRadius(8)
              .objectFit(ImageFit.Cover)

            Column({ space: 8 }) {
              Text('Fight Club')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })

              Text('A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggressi...')
                .fontSize(14)
                .fontColor('#666666')
                .maxLines(3)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
            .layoutWeight(1)
            .margin({ left: 16 })

            Image($r('app.media.startIcon')) // Using startIcon as placeholder for chevron
              .width(24)
              .height(24)
              .fillColor('#CCCCCC')
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Color.White)
          .onClick(() => {
            router.pushUrl({
              url: 'pages/MovieDetailView',
              params: { movieID: '1' }
            });
          })
        }

        ListItem() {
          Divider().color('#E0E0E0')
        }

        ListItem() {
          Row() {
            Image($r('app.media.startIcon'))
              .width(100)
              .height(150)
              .borderRadius(8)
              .objectFit(ImageFit.Cover)

            Column({ space: 8 }) {
              Text('Pulp Fiction')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })

              Text('A burger-loving hit man, his philosophical partner, a drug-addled gangster\'s moll and a...')
                .fontSize(14)
                .fontColor('#666666')
                .maxLines(3)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
            .layoutWeight(1)
            .margin({ left: 16 })

            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#CCCCCC')
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Color.White)
          .onClick(() => {
            router.pushUrl({
              url: 'pages/MovieDetailView',
              params: { movieID: '2' }
            });
          })
        }

        ListItem() {
          Divider().color('#E0E0E0')
        }

        ListItem() {
          Row() {
            Image($r('app.media.startIcon'))
              .width(100)
              .height(150)
              .borderRadius(8)
              .objectFit(ImageFit.Cover)

            Column({ space: 8 }) {
              Text('The Godfather')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })

              Text('Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corl...')
                .fontSize(14)
                .fontColor('#666666')
                .maxLines(3)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
            .layoutWeight(1)
            .margin({ left: 16 })

            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#CCCCCC')
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Color.White)
          .onClick(() => {
            router.pushUrl({
              url: 'pages/MovieDetailView',
              params: { movieID: '3' }
            });
          })
        }
        
         ListItem() {
          Divider().color('#E0E0E0')
        }

        ListItem() {
           Row() {
              Image($r('app.media.startIcon'))
                .width(100)
                .height(150)
                .borderRadius(8)
                .objectFit(ImageFit.Cover)

              Column({ space: 8 }) {
                Text('The Shawshank Redemption')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
              }
              .layoutWeight(1)
              .margin({ left: 16 })
            }
            .width('100%')
            .padding(16)
            .backgroundColor(Color.White)
        }
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#F2F2F7')
      .borderRadius(16)
      .margin({ left: 20, right: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F2F2F7')
    .padding({ top: 0, left: 0, right: 0, bottom: 0 })
  }
}