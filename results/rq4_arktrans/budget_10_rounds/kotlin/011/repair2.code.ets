@Entry
@Component
struct Index {
  @State voteState: number = 1

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Scaffold Content (LazyColumn) ===
      List() {
        // === PostCard ===
        ListItem() {
          Row({ space: 12 }) {
            // Vote Column
            Column({ space: 8 }) {
              .alignItems(HorizontalAlign.Center)
              
              // UpVoteArrow
              Button() {
                Image($r('app.media.startIcon'))
                  .width(24).height(24)
                  .fillColor(this.voteState == 1 ? '#FF00FF' : '#44446A')
                  .rotate({ angle: -90 })
              }
              
              Text((1337 + this.voteState - 1).toString())
                .fontSize(16).fontWeight(FontWeight.Bold)
                .fontColor(this.voteState != 0 ? '#FF00FF' : '#E0E0FF')

              // DownVoteArrow
              Button() {
                Stack({ alignContent: Alignment.Center }) {
                  Image($r('app.media.startIcon'))
                    .width(24).height(24)
                    .fillColor(this.voteState == -1 ? '#00FFFF' : '#44446A')
                    .rotate({ angle: 90 })
                }
              }
            }

            // Content Column
            Column({ space: 8 }) {
              // AuthorInfo
              Row({ space: 8 }) {
                .alignItems(VerticalAlign.Center)
                
                // Avatar
                Stack({ alignContent: Alignment.Center }) {
                  Image($r('app.media.startIcon'))
                    .width(24).height(24)
                    .fillColor('#55FF00')
                    .borderRadius(12)
                }.backgroundColor('#55FF00').width(24).height(24).borderRadius(12)

                Text('user/compose_master')
                  .fontSize(14).fontWeight(FontWeight.Bold)
                  .fontColor('#55FF00')
                
                Text('8 hours ago')
                  .fontSize(14)
                  .fontColor('#44446A')
              }

              Text('The power of Jetpack Compose for single-file UIs')
                .fontSize(20).fontWeight(FontWeight.Bold)
                .fontColor('#E0E0FF')

              Text('Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it\'s becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?')
                .fontSize(16)
                .fontColor('#E0E0FF')
                .lineHeight(24)

              Blank().height(16)

              // Chips Row
              Row({ space: 24 }) {
                Text('42 Comments')
                  .fontSize(14).fontWeight(FontWeight.Bold)
                  .fontColor('#44446A')
                
                Text('Share')
                  .fontSize(14).fontWeight(FontWeight.Bold)
                  .fontColor('#44446A')
              }
            }
          }
          .width('100%').backgroundColor('#1C1C3A').padding(16)
        }

        // === TOP COMMENTS Header ===
        ListItem() {
          Text('TOP COMMENTS')
            .fontSize(14).fontWeight(FontWeight.Bold)
            .fontColor('#44446A')
            .padding({ left: 16, top: 16, bottom: 8 })
        }

        // === ReplyCard ===
        ListItem() {
          Row({ space: 12 }) {
            // Thread Line
            Stack({ alignContent: Alignment.Center }) {
              Column() {
                .width(2).height('100%')
                .backgroundColor('#FF00FF')
                .opacity(0.5)
              }
            }.width(2).height('100%')

            // Comment Content
            Column({ space: 4 }) {
              // AuthorInfo
              Row({ space: 8 }) {
                .alignItems(VerticalAlign.Center)
                
                Stack({ alignContent: Alignment.Center }) {
                  Image($r('app.media.startIcon'))
                    .width(24).height(24)
                    .fillColor('#FF00FF')
                    .borderRadius(12)
                }.backgroundColor('#FF00FF').width(24).height(24).borderRadius(12)

                Text('dev/android_fan')
                  .fontSize(14).fontWeight(FontWeight.Bold)
                  .fontColor('#FF00FF')
                
                Text('7h ago')
                  .fontSize(14)
                  .fontColor('#44446A')
              }

              Text('Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.')
                .fontSize(16)
                .fontColor('#E0E0FF')
                .lineHeight(24)

              // Action Chips
              Row({ space: 12 }) {
                .alignItems(VerticalAlign.Center)
                
                Text('25 votes')
                  .fontSize(14).fontWeight(FontWeight.Bold)
                  .fontColor('#44446A')
                
                Text('Reply')
                  .fontSize(14).fontWeight(FontWeight.Bold)
                  .fontColor('#44446A')
              }
            }
          }
          .width('100%').padding({ left: 16, right: 16, top: 8, bottom: 8 })
        }
      }
      .layoutWeight(1)
      .backgroundColor('#101024')

      // === CenterAlignedTopAppBar ===
      Row({ space: 12 }) {
        .width('100%').height(56).padding(16)
        .backgroundColor('#101024')
        .justifyContent(FlexAlign.SpaceBetween)
        
        // Back Icon
        Button() {
          Image($r('app.media.startIcon'))
            .width(20).height(20)
            .fillColor('#00FFFF')
            .rotate({ angle: 90 })
        }

        Text('r/jetpackcompose')
          .fontSize(16).fontWeight(FontWeight.Medium)
          .fontColor('#E0E0FF')
        
        // Spacer to balance layout if needed, or use SpaceBetween
        Blank() 
      }

      // === Bottom Surface ===
      Column() {
        .width('100%')
        .backgroundColor('#1C1C3A')
        .shadow({ radius: 4, color: '#1A000000' })
        
        Row({ space: 12 }) {
          .width('100%').padding({ left: 16, right: 16, top: 12, bottom: 12 })
          .alignItems(VerticalAlign.Center)
          
          // Input Box
          Stack({ alignContent: Alignment.Start }) {
            Text('Add a comment...')
              .fontSize(16)
              .fontColor('#44446A')
          }
          .layoutWeight(1)
          .height(48)
          .backgroundColor('#282850')
          .borderRadius(16)
          .padding({ left: 16 })

          // Post Button
          Button() {
            Text('POST')
              .fontSize(14).fontWeight(FontWeight.Bold)
              .fontColor('#000000')
          }
          .backgroundColor('#00FFFF')
          .borderRadius(16)
          .padding({ left: 24, right: 24 })
        }
      }
    }
    .width('100%').height('100%')
  }
}