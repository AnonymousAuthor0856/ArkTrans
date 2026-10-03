@Entry
@Component
struct Index {
  // Mock state variables to satisfy compilation requirements for dynamic bindings
  @State voteState: number = 0
  @State post: { votes: number, title: string, body: string } = { votes: 10, title: 'Post Title', body: 'Post Body Content' }
  @State author: { name: string, avatarColor: string } = { name: 'Author Name', avatarColor: '#FF5722' }

  build() {
    Stack() {
      Row({ space: 16 }) {
        Column({ space: 8 }) {
          Button('Upvote')
            .onClick(() => {
              this.voteState = this.voteState == 1 ? 0 : 1
            })
            .width(40)
            .height(40)
            .backgroundColor('#E0E0E0')
            .borderRadius(8)

          Text(`${this.post.votes + this.voteState - 1}`)
            .fontColor(this.voteState != 0 ? '#FF00AA' : '#DFDFFF')
            .fontWeight(FontWeight.Bold)
            .fontSize(20)

          Button('Downvote')
            .onClick(() => {
              this.voteState = this.voteState == -1 ? 0 : -1
            })
            .width(40)
            .height(40)
            .backgroundColor('#E0E0E0')
            .borderRadius(8)
        }
        .width(60)

        Column({ space: 8 }) {
          Row({ space: 8 }) {
            Stack() {
              Circle()
                .width(28)
                .height(28)
                .fill(this.author.avatarColor)
              
              Circle()
                .width(10)
                .height(10)
                .fill(Color.Black)
                .opacity(0.2)
            }

            Text(this.author.name)
              .fontColor(this.author.avatarColor)
              .fontWeight(FontWeight.Bold)
              .fontSize(12)

            Text('2h ago')
              .fontColor('#9CA3AF')
              .fontSize(12)
          }

          Text(this.post.title)
            .fontColor('#1F2937')
            .fontSize(24)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Text(this.post.body)
            .fontColor('#1F2937')
            .opacity(0.8)
            .fontSize(16)
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Row({ space: 24 }) {
            Text('Comments')
              .fontColor('#9CA3AF')
              .fontWeight(FontWeight.Bold)
              .fontSize(12)

            Text('Share')
              .fontColor('#9CA3AF')
              .fontWeight(FontWeight.Bold)
              .fontSize(12)
          }
          .padding({ top: 8 })
        }
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .padding(24)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
  }
}