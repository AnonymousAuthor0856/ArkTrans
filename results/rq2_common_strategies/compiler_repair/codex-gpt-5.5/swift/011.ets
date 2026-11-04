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

class ForumPost {
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

@Entry
@Component
struct Index {
  @State voteState: number = 1
  @State commentText: string = ''

  private cPrimary: string = '#00E5FF'
  private cSecondary: string = '#FF00AA'
  private cTertiary: string = '#76FF03'
  private cBg: string = '#101024'
  private cSurface: string = '#1C1C3A'
  private cSurfaceVariant: string = '#282850'
  private cLine: string = '#44446A'
  private cWarning: string = '#FFD600'
  private cOnSurface: string = '#E0E0FF'
  private post: ForumPost = new ForumPost(
    new Author('user/compose_master', '#76FF03'),
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

  @Builder
  UpVoteArrow(color: string, down: boolean) {
    Text(down ? '◆' : '◆')
      .fontSize(28)
      .fontColor(color)
      .rotate({ angle: down ? 180 : 0 })
  }

  @Builder
  AuthorInfo(author: Author, timestamp: string) {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(28)
          .height(28)
          .fill(author.avatarColor)
        Circle()
          .width(10)
          .height(10)
          .fill('#33000000')
      }
      .width(28)
      .height(28)
      .margin({ right: 10 })
      Text(author.name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(author.avatarColor)
        .margin({ right: 10 })
      Text(timestamp)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.cLine)
    }
  }

  @Builder
  InfoChip(text: string) {
    Text(text)
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor(this.cLine)
  }

  @Builder
  PostCard(post: ForumPost) {
    Row() {
      Column() {
        Button() {
          this.UpVoteArrow(this.voteState === 1 ? this.cSecondary : this.cLine, false)
        }
        .width(44)
        .height(36)
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          this.voteState = this.voteState === 1 ? 0 : 1
        })

        Text((post.votes + this.voteState - 1).toString())
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? this.cSecondary : this.cOnSurface)
          .margin({ top: 10, bottom: 10 })

        Button() {
          this.UpVoteArrow(this.voteState === -1 ? this.cPrimary : this.cLine, true)
        }
        .width(44)
        .height(36)
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          this.voteState = this.voteState === -1 ? 0 : -1
        })
      }
      .width(60)
      .margin({ right: 16 })

      Column() {
        this.AuthorInfo(post.author, post.timestamp)
        Text(post.title)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.cOnSurface)
          .width('100%')
          .margin({ top: 10 })
        Text(post.body)
          .fontSize(18)
          .fontColor('#CCE0E0FF')
          .width('100%')
          .margin({ top: 10 })
        Row() {
          this.InfoChip(post.commentCount.toString() + ' Comments')
          Text('Share')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.cLine)
            .margin({ left: 28 })
        }
        .width('100%')
        .margin({ top: 10 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .padding(20)
    .backgroundColor(this.cSurface)
  }

  @Builder
  ReplyCard(reply: Reply) {
    Row() {
      Rect()
        .width(3)
        .height('100%')
        .radius(2)
        .fill(reply.author.avatarColor)
        .opacity(0.5)
        .margin({ right: 16 })
      Column() {
        this.AuthorInfo(reply.author, reply.timestamp)
        Text(reply.text)
          .fontSize(18)
          .fontColor('#E6E0E0FF')
          .width('100%')
          .margin({ top: 6 })
        Row() {
          this.InfoChip(reply.votes.toString() + ' votes')
          Text('Reply')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.cLine)
            .margin({ left: 16 })
        }
        .width('100%')
        .margin({ top: 6 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .padding({ left: 20, right: 20, top: 10, bottom: 10 })
  }

  @Builder
  TopAppBar() {
    Row() {
      Button('<')
        .width(50)
        .height(50)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.cPrimary)
        .backgroundColor(Color.Transparent)
      Blank()
      Text('r/jetpackcompose')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.cOnSurface)
      Blank()
      Blank().width(50).height(50)
    }
    .width('100%')
    .height(60)
    .padding({ left: 20, right: 20 })
    .backgroundColor(this.cSurface)
  }

  @Builder
  BottomCommentBar() {
    Column() {
      Divider()
        .color('#4D44446A')
        .margin({ left: 20, right: 20 })
      Row() {
        TextInput({ text: this.commentText, placeholder: 'Add a comment...' })
          .height(52)
          .layoutWeight(1)
          .fontSize(18)
          .fontColor(this.cOnSurface)
          .placeholderColor(this.cLine)
          .padding({ left: 20, right: 20 })
          .backgroundColor(this.cSurfaceVariant)
          .borderRadius(20)
          .onChange((value: string) => {
            this.commentText = value
          })
        Button('POST')
          .height(52)
          .padding({ left: 20, right: 20 })
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .backgroundColor(this.cPrimary)
          .borderRadius(20)
          .margin({ left: 16 })
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
    }
    .width('100%')
    .backgroundColor(this.cSurface)
  }

  build() {
    Column() {
      this.TopAppBar()
      Scroll() {
        Column() {
          this.PostCard(this.post)
          Text('TOP COMMENTS')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.cLine)
            .width('100%')
            .padding({ left: 20, right: 20, top: 10, bottom: 10 })
          ForEach(this.replies, (reply: Reply) => {
            this.ReplyCard(reply)
          }, (reply: Reply) => reply.id.toString())
        }
      }
      .layoutWeight(1)
      .backgroundColor(this.cBg)
      this.BottomCommentBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cBg)
  }
}
