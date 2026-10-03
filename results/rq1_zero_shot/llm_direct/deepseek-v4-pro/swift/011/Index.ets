@Entry
@Component
struct ForumPostPage {
  @State private var voteState: number = 1
  @State private var commentText: string = ''

  private post: Post = new Post(
    new Author('user/compose_master', '#75FF03'),
    '8 hours ago',
    'The power of Jetpack Compose for single-file UIs',
    'Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it\'s becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?',
    1337,
    42
  )

  private replies: Reply[] = [
    new Reply(1, new Author('dev/android_fan', '#FF00AA'), '7h ago', 'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.', 25),
    new Reply(2, new Author('ux/designer_jane', '#00E5FF'), '5h ago', 'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.', 18)
  ]

  build() {
    Column() {
      TopAppBar()
      Scroll() {
        Column() {
          PostCard({
            post: this.post,
            voteState: this.voteState,
            onVote: (newVote: number) => {
              this.voteState = newVote
            }
          })

          Text('TOP COMMENTS')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#44446A')
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ left: 20, right: 20, top: 10, bottom: 10 })

          ForEach(this.replies, (reply: Reply) => {
            ReplyCard({ reply: reply })
              .padding({ left: 20, right: 20, top: 10, bottom: 10 })
          }, (reply: Reply) => reply.id.toString())
        }
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor('#101024')
      .scrollBar(BarState.Off)

      BottomCommentBar({ commentText: $commentText })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#101024')
  }
}

class Author {
  name: string
  avatarColor: string

  constructor(name: string, avatarColor: string) {
    this.name = name
    this.avatarColor = avatarColor
  }
}

class Reply {
  id: number
  author: Author
  timestamp: string
  text: string
  votes: number

  constructor(id: number, author: Author, timestamp: string, text: string, votes: number) {
    this.id = id
    this.author = author
    this.timestamp = timestamp
    this.text = text
    this.votes = votes
  }
}

class Post {
  author: Author
  timestamp: string
  title: string
  body: string
  votes: number
  commentCount: number

  constructor(author: Author, timestamp: string, title: string, body: string, votes: number, commentCount: number) {
    this.author = author
    this.timestamp = timestamp
    this.title = title
    this.body = body
    this.votes = votes
    this.commentCount = commentCount
  }
}

@Component
struct UpVoteArrow {
  @Prop color: string = '#44446A'

  build() {
    Column() {
      Polygon({ width: 28, height: 28 })
        .points([[14, 0], [28, 14], [14, 28], [0, 14]])
        .fill(this.color)
    }
    .width(28)
    .height(28)
  }
}

@Component
struct AuthorInfo {
  @Prop author: Author = new Author('', '#FFFFFF')
  @Prop timestamp: string = ''

  build() {
    Row({ space: 10 }) {
      Stack() {
        Circle()
          .fill(this.author.avatarColor)
          .width(28)
          .height(28)
        Circle()
          .fill('#33000000')
          .width(10)
          .height(10)
      }
      .width(28)
      .height(28)

      Text(this.author.name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.author.avatarColor)

      Text(this.timestamp)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#44446A')
    }
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct InfoChip {
  @Prop text: string = ''

  build() {
    Text(this.text)
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor('#44446A')
  }
}

@Component
struct PostCard {
  @Prop post: Post = new Post(new Author('', '#FFFFFF'), '', '', '', 0, 0)
  @Prop voteState: number = 0
  onVote: (vote: number) => void = () => {}

  build() {
    Row({ space: 16 }) {
      Column({ space: 10 }) {
        Button() {
          UpVoteArrow({ color: this.voteState === 1 ? '#FF00AA' : '#44446A' })
        }
        .width(28)
        .height(28)
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          this.onVote(this.voteState === 1 ? 0 : 1)
        })

        Text(`${this.post.votes + this.voteState - 1}`)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? '#FF00AA' : '#E0E0FF')

        Button() {
          UpVoteArrow({ color: this.voteState === -1 ? '#00E5FF' : '#44446A' })
            .rotate({ angle: 180 })
        }
        .width(28)
        .height(28)
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          this.onVote(this.voteState === -1 ? 0 : -1)
        })
      }
      .width(60)
      .alignItems(HorizontalAlign.Center)

      Column({ space: 10 }) {
        AuthorInfo({ author: this.post.author, timestamp: this.post.timestamp })

        Text(this.post.title)
          .fontSize(22)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#E0E0FF')
          .width('100%')

        Text(this.post.body)
          .fontSize(18)
          .fontWeight(FontWeight.Regular)
          .fontColor('#CCE0E0FF')
          .width('100%')

        Row({ space: 28 }) {
          InfoChip({ text: `${this.post.commentCount} Comments` })
          InfoChip({ text: 'Share' })
        }
        .margin({ top: 10 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .alignItems(VerticalAlign.Top)
    .padding(20)
    .width('100%')
    .backgroundColor('#1C1C3A')
  }
}

@Component
struct ReplyCard {
  @Prop reply: Reply = new Reply(0, new Author('', '#FFFFFF'), '', '', 0)

  build() {
    Row({ space: 16 }) {
      Rect()
        .fill(this.reply.author.avatarColor + '80')
        .width(3)
        .height('100%')
        .borderRadius(1.5)

      Column({ space: 6 }) {
        AuthorInfo({ author: this.reply.author, timestamp: this.reply.timestamp })

        Text(this.reply.text)
          .fontSize(18)
          .fontWeight(FontWeight.Regular)
          .fontColor('#E6E0E0FF')
          .width('100%')

        Row({ space: 16 }) {
          InfoChip({ text: `${this.reply.votes} votes` })
          InfoChip({ text: 'Reply' })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .alignItems(VerticalAlign.Top)
    .width('100%')
  }
}

@Component
struct TopAppBar {
  build() {
    Stack() {
      Rect()
        .fill('#1C1C3A')
        .width('100%')
        .height(60)

      Row() {
        Button() {
          Stack() {
            Line()
              .width(24)
              .height(3)
              .backgroundColor('#00E5FF')
              .position({ x: 12, y: 12 })

            Line()
              .width(12)
              .height(3)
              .backgroundColor('#00E5FF')
              .position({ x: 6, y: 6 })
              .rotate({ angle: -45, centerX: 0, centerY: 12 })

            Line()
              .width(12)
              .height(3)
              .backgroundColor('#00E5FF')
              .position({ x: 6, y: 18 })
              .rotate({ angle: 45, centerX: 0, centerY: 12 })
          }
          .width(24)
          .height(24)
        }
        .width(50)
        .height(50)
        .backgroundColor(Color.Transparent)

        Blank()

        Text('r/jetpackcompose')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E0E0FF')

        Blank()

        Rect()
          .fill(Color.Transparent)
          .width(50)
          .height(50)
      }
      .width('100%')
      .padding({ left: 20, right: 20 })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(60)
  }
}

@Component
struct BottomCommentBar {
  @Link commentText: string

  build() {
    Column({ space: 0 }) {
      Divider()
        .strokeWidth(1)
        .color('#44446A4D')
        .margin({ left: 20, right: 20 })

      Row({ space: 16 }) {
        Stack({ alignContent: Alignment.Start }) {
          Rect()
            .fill('#282850')
            .width('100%')
            .height(52)
            .borderRadius(20)

          if (this.commentText === '') {
            Text('Add a comment...')
              .fontSize(18)
              .fontWeight(FontWeight.Regular)
              .fontColor('#44446A')
              .padding({ left: 20, right: 20 })
          }

          TextInput({ placeholder: '', text: this.commentText })
            .fontSize(18)
            .fontColor('#E0E0FF')
            .padding({ left: 20, right: 20 })
            .height(52)
            .backgroundColor(Color.Transparent)
            .onChange((value: string) => {
              this.commentText = value
            })
        }
        .layoutWeight(1)

        Button('POST') {
        }
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .padding({ left: 20, right: 20 })
        .height(52)
        .backgroundColor('#00E5FF')
        .borderRadius(20)
      }
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .width('100%')
      .backgroundColor('#1C1C3A')
    }
    .width('100%')
  }
}