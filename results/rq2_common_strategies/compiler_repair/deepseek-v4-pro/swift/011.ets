@Entry
@Component
struct ForumPostView {
  @State private voteState: number = 1
  @State private commentText: string = ''

  private post: Post = {
    author: { name: 'user/compose_master', avatarColor: '#76FF03' },
    timestamp: '8 hours ago',
    title: 'The power of Jetpack Compose for single-file UIs',
    body: 'Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it\'s becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?',
    votes: 1337,
    commentCount: 42
  }

  private replies: Reply[] = [
    { id: 1, author: { name: 'dev/android_fan', avatarColor: '#FF006E' }, timestamp: '7h ago', text: 'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.', votes: 25 },
    { id: 2, author: { name: 'ux/designer_jane', avatarColor: '#00E5FF' }, timestamp: '5h ago', text: 'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.', votes: 18 }
  ]

  build() {
    Column({ space: 0 }) {
      // Top bar
      Row({ space: 16 }) {
        Button({ type: ButtonType.Normal }) {
          // Menu icon approximation
          Text('≡')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#00E5FF')
        }
        .width(50).height(50)

        Blank()

        Text('r/jetpackcompose')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E0E0FF')

        Blank()

        // Placeholder for symmetry
        Blank().width(50).height(50)
      }
      .padding({ left: 16, right: 16 })
      .width('100%')
      .height(60)
      .backgroundColor('#1C1C3A')

      // Main scrollable content
      List({ space: 0 }) {
        // Post card
        ListItem() {
          Row({ space: 12 }) {
            // Vote column
            Column({ space: 4 }) {
              Button({ type: ButtonType.Normal }) {
                Text('▲')
                  .fontSize(28)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(this.voteState == 1 ? '#FF006E' : '#444466')
              }
              .onClick(() => { this.voteState = this.voteState == 1 ? 0 : 1 })

              Text((this.post.votes + this.voteState - 1).toString())
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.voteState != 0 ? '#FF006E' : '#E0E0FF')

              Button({ type: ButtonType.Normal }) {
                Text('▼')
                  .fontSize(28)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(this.voteState == -1 ? '#00E5FF' : '#444466')
              }
              .onClick(() => { this.voteState = this.voteState == -1 ? 0 : -1 })
            }
            .width(60)
            .alignItems(HorizontalAlign.Center)

            // Content column
            Column({ space: 8 }) {
              // Author row
              Row({ space: 4 }) {
                Image('')
                  .width(28).height(28)
                  .borderRadius(14)
                  .backgroundColor(this.post.author.avatarColor)
                Text(this.post.author.name)
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(this.post.author.avatarColor)
                Text(this.post.timestamp)
                  .fontSize(14)
                  .fontColor('#444466')
              }

              Text(this.post.title)
                .fontSize(22)
                .fontWeight(FontWeight.Medium)
                .fontColor('#E0E0FF')
                .maxLines(2)

              Text(this.post.body)
                .fontSize(18)
                .fontColor('#C0C0E0')
                .maxLines(4)

              Row({ space: 20 }) {
                Text(this.post.commentCount.toString() + ' Comments')
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#444466')
                Text('Share')
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#444466')
              }
              .padding({ top: 8 })
            }
          }
          .padding(16)
          .width('100%')
          .backgroundColor('#1C1C3A')
        }

        // Section header
        ListItem() {
          Text('TOP COMMENTS')
            .fontSize(14)
            .fontColor('#444466')
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ left: 16, top: 8, bottom: 8 })
        }

        // Replies
        ForEach(this.replies, (reply: Reply) => {
          ListItem() {
            Row({ space: 12 }) {
              // Left color bar
              Column()
                .width(3).height(80)
                .backgroundColor(reply.author.avatarColor)
                .borderRadius(1.5)

              Column({ space: 4 }) {
                // Author row
                Row({ space: 4 }) {
                  Image('')
                    .width(28).height(28)
                    .borderRadius(14)
                    .backgroundColor(reply.author.avatarColor)
                  Text(reply.author.name)
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(reply.author.avatarColor)
                  Text(reply.timestamp)
                    .fontSize(14)
                    .fontColor('#444466')
                }

                Text(reply.text)
                  .fontSize(18)
                  .fontColor('#C0C0E0')
                  .maxLines(3)

                Row({ space: 12 }) {
                  Text(reply.votes.toString() + ' votes')
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#444466')
                  Text('Reply')
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#444466')
                }
              }
            }
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .width('100%')
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#10102E')

      // Bottom comment bar
      Column({ space: 0 }) {
        Divider()
          .height(1)
          .color('#444466')
          .width('100%')

        Row({ space: 12 }) {
          // Text input for comment
          TextInput({ placeholder: 'Add a comment...', text: this.commentText })
            .width('100%')
            .height(52)
            .backgroundColor('#2A2A4A')
            .borderRadius(20)
            .padding({ left: 16 })

          Button({ type: ButtonType.Normal }) {
            Text('POST')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
              .padding({ left: 16, right: 16 })
              .height(52)
          }
          .backgroundColor('#00E5FF')
          .borderRadius(20)
        }
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        .backgroundColor('#1C1C3A')
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
  }
}

interface Author {
  name: string
  avatarColor: string
}

interface Reply {
  id: number
  author: Author
  timestamp: string
  text: string
  votes: number
}

interface Post {
  author: Author
  timestamp: string
  title: string
  body: string
  votes: number
  commentCount: number
}