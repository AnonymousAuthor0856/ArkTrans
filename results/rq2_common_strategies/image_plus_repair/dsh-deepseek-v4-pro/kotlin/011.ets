interface AuthorModel {
  name: string
  avatarColor: string
}

interface ReplyModel {
  id: number
  author: AuthorModel
  timestamp: string
  text: string
  votes: number
  barColor: string
}

interface PostModel {
  author: AuthorModel
  timestamp: string
  title: string
  body: string
  votes: number
  commentCount: number
}

@Component
struct UpVoteArrow {
  @Prop color: string = '#44446A'
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Canvas(this.context)
      .width(24)
      .height(24)
      .onReady(() => {
        this.context.beginPath()
        this.context.moveTo(12, 0)
        this.context.lineTo(24, 12)
        this.context.lineTo(12, 24)
        this.context.lineTo(0, 12)
        this.context.closePath()
        this.context.fillStyle = this.color
        this.context.fill()
      })
  }
}

@Component
struct BackArrow {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Canvas(this.context)
      .width(20)
      .height(20)
      .onReady(() => {
        this.context.strokeStyle = '#00E5FF'
        this.context.lineWidth = 2
        this.context.beginPath()
        this.context.moveTo(0, 10)
        this.context.lineTo(20, 10)
        this.context.moveTo(0, 10)
        this.context.lineTo(10, 0)
        this.context.moveTo(0, 10)
        this.context.lineTo(10, 20)
        this.context.stroke()
      })
  }
}

@Entry
@Component
struct ForumPostPage {
  @State voteState: number = 1
  private post: PostModel = {
    author: { name: 'user/compose_master', avatarColor: '#76FF03' },
    timestamp: '8 hours ago',
    title: 'The power of Jetpack Compose for single-file UIs',
    body: "Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it's becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?",
    votes: 1337,
    commentCount: 42
  }
  private replies: ReplyModel[] = [
    {
      id: 1,
      author: { name: 'dev/android_fan', avatarColor: '#FF00AA' },
      timestamp: '7h ago',
      text: 'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.',
      votes: 25,
      barColor: '#80FF00AA'
    },
    {
      id: 2,
      author: { name: 'ux/designer_jane', avatarColor: '#00E5FF' },
      timestamp: '5h ago',
      text: 'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.',
      votes: 18,
      barColor: '#8000E5FF'
    },
    {
      id: 3,
      author: { name: 'newbie/coder', avatarColor: '#FFD600' },
      timestamp: '2h ago',
      text: 'I found it a bit overwhelming at first. Any tips for organizing the file?',
      votes: 3,
      barColor: '#80FFD600'
    }
  ]

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Text('r/jetpackcompose')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E0E0FF')
        Row() {
          BackArrow()
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
        .padding({ left: 12 })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#1C1C3A')

      Scroll() {
        Column() {
          this.PostCardBuilder()
          Text('TOP COMMENTS')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#44446A')
            .width('100%')
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          ForEach(this.replies, (reply: ReplyModel) => {
            this.ReplyCardBuilder(reply)
          }, (reply: ReplyModel) => reply.id.toString())
        }
        .width('100%')
        .padding({ top: 16, bottom: 16 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      Row({ space: 12 }) {
        Row() {
          Text('Add a comment...')
            .fontSize(16)
            .fontColor('#44446A')
        }
        .layoutWeight(1)
        .height(48)
        .borderRadius(16)
        .backgroundColor('#282850')
        .padding({ left: 16, right: 16 })
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Start)

        Button({ type: ButtonType.Normal }) {
          Text('POST')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
        }
        .height(48)
        .borderRadius(16)
        .backgroundColor('#00E5FF')
        .padding({ left: 16, right: 16 })
        .onClick(() => {})
      }
      .width('100%')
      .backgroundColor('#1C1C3A')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#101024')
  }

  @Builder
  PostCardBuilder() {
    Row({ space: 12 }) {
      Column({ space: 8 }) {
        UpVoteArrow({ color: this.voteState === 1 ? '#FF00AA' : '#44446A' })
          .onClick(() => {
            this.voteState = this.voteState === 1 ? 0 : 1
          })
        Text((this.post.votes + this.voteState - 1).toString())
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? '#FF00AA' : '#E0E0FF')
        UpVoteArrow({ color: this.voteState === -1 ? '#00E5FF' : '#44446A' })
          .onClick(() => {
            this.voteState = this.voteState === -1 ? 0 : -1
          })
      }
      .alignItems(HorizontalAlign.Center)

      Column({ space: 8 }) {
        this.AuthorInfoBuilder(this.post.author, this.post.timestamp)
        Text(this.post.title)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#E0E0FF')
        Text(this.post.body)
          .fontSize(16)
          .lineHeight(24)
          .fontColor('#CCE0E0FF')
        Row().height(8)
        Row({ space: 24 }) {
          this.InfoChipBuilder(this.post.commentCount.toString() + ' Comments')
          this.InfoChipBuilder('Share')
        }
      }
    }
    .width('100%')
    .backgroundColor('#1C1C3A')
    .padding(16)
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  ReplyCardBuilder(reply: ReplyModel) {
    Row({ space: 12 }) {
      Row()
        .width(2)
        .alignSelf(ItemAlign.Stretch)
        .borderRadius(2)
        .backgroundColor(reply.barColor)

      Column({ space: 4 }) {
        this.AuthorInfoBuilder(reply.author, reply.timestamp)
        Text(reply.text)
          .fontSize(16)
          .lineHeight(24)
          .fontColor('#E6E0E0FF')
        Row({ space: 12 }) {
          this.InfoChipBuilder(reply.votes.toString() + ' votes')
          this.InfoChipBuilder('Reply')
        }
        .alignItems(VerticalAlign.Center)
      }
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
  }

  @Builder
  AuthorInfoBuilder(author: AuthorModel, timestamp: string) {
    Row({ space: 8 }) {
      Stack() {
        Circle({ width: 16, height: 16 })
          .fill('#33000000')
      }
      .width(24)
      .height(24)
      .borderRadius(12)
      .backgroundColor(author.avatarColor)

      Text(author.name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(author.avatarColor)

      Text(timestamp)
        .fontSize(14)
        .fontColor('#44446A')
    }
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  InfoChipBuilder(text: string) {
    Text(text)
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor('#44446A')
  }
}
