@Entry
@Component
struct Index {
  @State votes: number = 0
  @State voteState: number = 0
  @State timestamp: string = '2 hours ago'
  @State authorName: string = 'u/user123'
  @State title: string = 'Post Title Here'
  @State body: string = 'This is the body of the post. It contains some text.'
  @State commentCount: number = 42
  @State replyText: string = 'This is a top comment reply.'
  @State replyVotes: number = 15

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // Scaffold Background
      Column() {
        .width('100%')
        .height('100%')
        .backgroundColor('#101024')
      }

      // Top App Bar
      Row() {
        Text('r/jetpackcompose')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E0E0FF')
        
        Blank()
        
        Button() {
          Image($r('app.media.startIcon'))
            .width(20)
            .height(20)
        }
        .backgroundColor(Color.Transparent)
        .borderRadius(8)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#1C1C3A')

      // Main Content List
      List() {
        ListItem() {
          // PostCard
          Row({ space: 12 }) {
            // Vote Column
            Column({ space: 8 }) {
              Button() {
                Image($r('app.media.startIcon'))
                  .width(24)
                  .height(24)
                  .fillColor(this.voteState === 1 ? '#9D4EDD' : '#44446A')
              }
              .backgroundColor(Color.Transparent)
              
              Text(`${this.votes + this.voteState - 1}`)
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.voteState !== 0 ? '#9D4EDD' : '#E0E0FF')
              
              Button() {
                Stack({ alignContent: Alignment.Center }) {
                  Image($r('app.media.startIcon'))
                    .width(24)
                    .height(24)
                    .fillColor(this.voteState === -1 ? '#9D4EDD' : '#44446A')
                }
                .width(24)
                .height(24)
              }
              .backgroundColor(Color.Transparent)
            }
            .alignItems(HorizontalAlign.Center)

            // Content Column
            Column({ space: 8 }) {
              // Author Info
              Row({ space: 8 }) {
                Stack({ alignContent: Alignment.Center }) {
                  Circle()
                    .width(24)
                    .height(24)
                    .fill('#7B2CBF')
                }
                .width(24)
                .height(24)
                
                Text(this.authorName)
                  .fontSize(12)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#7B2CBF')
                
                Text(this.timestamp)
                  .fontSize(12)
                  .fontColor('#44446A')
              }
              .alignItems(VerticalAlign.Center)

              Text(this.title)
                .fontSize(18)
                .fontColor('#E0E0FF')
              
              Text(this.body)
                .fontSize(14)
                .fontColor('#E0E0FF')
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })

              Column().height(16)

              // Action Chips
              Row({ space: 24 }) {
                Text(`${this.commentCount} Comments`)
                  .fontSize(12)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#44446A')
                  .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                  .backgroundColor('#282850')
                  .borderRadius(4)
                
                Text('Share')
                  .fontSize(12)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#44446A')
                  .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                  .backgroundColor('#282850')
                  .borderRadius(4)
              }
            }
          }
          .width('100%')
          .backgroundColor('#1C1C3A')
          .padding(16)
        }

        ListItem() {
          Text('TOP COMMENTS')
            .fontSize(12)
            .fontColor('#44446A')
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        }

        ListItem() {
          // ReplyCard
          Row({ space: 12 }) {
            // Thread Line
            Stack({ alignContent: Alignment.Center }) {
              Rect()
                .fill('#7B2CBF')
                .opacity(0.5)
            }
            .width(2)
            .height('100%')
            .borderRadius(2)

            Column({ space: 4 }) {
              // Author Info
              Row({ space: 8 }) {
                Stack({ alignContent: Alignment.Center }) {
                  Circle()
                    .width(24)
                    .height(24)
                    .fill('#7B2CBF')
                }
                .width(24)
                .height(24)
                
                Text(this.authorName)
                  .fontSize(12)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#7B2CBF')
                
                Text(this.timestamp)
                  .fontSize(12)
                  .fontColor('#44446A')
              }
              .alignItems(VerticalAlign.Center)

              Text(this.replyText)
                .fontSize(14)
                .fontColor('#E0E0FF')

              // Reply Actions
              Row({ space: 12 }) {
                Text(`${this.replyVotes} votes`)
                  .fontSize(12)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#44446A')
                  .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                  .backgroundColor('#282850')
                  .borderRadius(4)
                
                Text('Reply')
                  .fontSize(12)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#44446A')
                  .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                  .backgroundColor('#282850')
                  .borderRadius(4)
              }
              .alignItems(VerticalAlign.Center)
            }
          }
          .width('100%')
          .padding(16)
        }
        
        // Spacer for bottom bar visibility
        ListItem() {
          Column().height(80)
        }
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#101024')

      // Bottom Input Surface
      Column() {
        Row({ space: 12 }) {
          Stack({ alignContent: Alignment.Start }) {
            Text('Add a comment...')
              .fontSize(14)
              .fontColor('#44446A')
          }
          .width('100%')
          .height(48)
          .backgroundColor('#282850')
          .borderRadius(12)
          .padding({ left: 16, right: 16 })
          .layoutWeight(1)
          
          Button() {
            Text('POST')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
          }
          .backgroundColor('#9D4EDD')
          .borderRadius(12)
          .padding({ left: 16, right: 16 })
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      }
      .backgroundColor('#1C1C3A')
      .shadow({ radius: 4, color: '#1A000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
  }
}