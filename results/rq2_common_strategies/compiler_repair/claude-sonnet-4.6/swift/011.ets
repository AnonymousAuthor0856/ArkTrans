class ColorsToken {
  static primary: string = '#00E5FF'
  static secondary: string = '#FF00AA'
  static tertiary: string = '#76FF03'
  static background: string = '#101024'
  static surface: string = '#1C1C3A'
  static surfaceVariant: string = '#282850'
  static outline: string = '#444468'
  static warning: string = '#FFD600'
  static onPrimary: string = '#000000'
  static onSurface: string = '#E0E0FF'
}

class SpacingToken {
  static xs: number = 6
  static sm: number = 10
  static md: number = 16
  static lg: number = 20
  static xl: number = 28
}

class ShapesToken {
  static small: number = 6
  static medium: number = 12
  static large: number = 20
}

interface AuthorData {
  name: string
  avatarColor: string
}

interface ReplyData {
  id: number
  author: AuthorData
  timestamp: string
  text: string
  votes: number
}

interface PostData {
  author: AuthorData
  timestamp: string
  title: string
  body: string
  votes: number
  commentCount: number
}

@Component
struct UpVoteArrow {
  @Prop color: string = ColorsToken.outline
  @Prop flipped: boolean = false
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Canvas(this.context)
      .width(28)
      .height(28)
      .onReady(() => {
        const w = 28
        const h = 28
        this.context.clearRect(0, 0, w, h)
        this.context.fillStyle = this.color
        this.context.beginPath()
        if (!this.flipped) {
          this.context.moveTo(w / 2, 0)
          this.context.lineTo(w, h / 2)
          this.context.lineTo(w / 2, h)
          this.context.lineTo(0, h / 2)
        } else {
          this.context.moveTo(w / 2, h)
          this.context.lineTo(w, h / 2)
          this.context.lineTo(w / 2, 0)
          this.context.lineTo(0, h / 2)
        }
        this.context.closePath()
        this.context.fill()
      })
  }
}

@Component
struct AuthorInfo {
  @Prop authorName: string = ''
  @Prop avatarColor: string = ColorsToken.primary
  @Prop timestamp: string = ''

  build() {
    Row({ space: SpacingToken.sm }) {
      Stack() {
        Circle()
          .fill(this.avatarColor)
          .width(28)
          .height(28)
        Circle()
          .fill('rgba(0,0,0,0.2)')
          .width(10)
          .height(10)
      }

      Text(this.authorName)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.avatarColor)

      Text(this.timestamp)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(ColorsToken.outline)
    }
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct InfoChip {
  @Prop label: string = ''

  build() {
    Text(this.label)
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor(ColorsToken.outline)
  }
}

@Component
struct PostCard {
  @Prop post: PostData = {
    author: { name: '', avatarColor: '' } as AuthorData,
    timestamp: '',
    title: '',
    body: '',
    votes: 0,
    commentCount: 0
  }
  @Prop voteState: number = 0
  onVote: (v: number) => void = () => {}

  build() {
    Row({ space: SpacingToken.md }) {
      Column({ space: SpacingToken.sm }) {
        UpVoteArrow({
          color: this.voteState === 1 ? ColorsToken.secondary : ColorsToken.outline,
          flipped: false
        })
          .onClick(() => {
            this.onVote(this.voteState === 1 ? 0 : 1)
          })

        Text(`${this.post.votes + this.voteState - 1}`)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? ColorsToken.secondary : ColorsToken.onSurface)

        UpVoteArrow({
          color: this.voteState === -1 ? ColorsToken.primary : ColorsToken.outline,
          flipped: true
        })
          .onClick(() => {
            this.onVote(this.voteState === -1 ? 0 : -1)
          })
      }
      .width(60)
      .alignItems(HorizontalAlign.Center)

      Column({ space: SpacingToken.sm }) {
        AuthorInfo({
          authorName: this.post.author.name,
          avatarColor: this.post.author.avatarColor,
          timestamp: this.post.timestamp
        })

        Text(this.post.title)
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(ColorsToken.onSurface)
          .width('100%')

        Text(this.post.body)
          .fontSize(18)
          .fontColor(ColorsToken.onSurface)
          .opacity(0.8)
          .width('100%')

        Row({ space: SpacingToken.xl }) {
          InfoChip({ label: `${this.post.commentCount} Comments` })
          InfoChip({ label: 'Share' })
        }
        .margin({ top: SpacingToken.sm })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .padding(SpacingToken.lg)
    .width('100%')
    .alignItems(VerticalAlign.Top)
    .backgroundColor(ColorsToken.surface)
  }
}

@Component
struct ReplyCard {
  @Prop reply: ReplyData = {
    id: 0,
    author: { name: '', avatarColor: '' } as AuthorData,
    timestamp: '',
    text: '',
    votes: 0
  }

  build() {
    Row({ space: SpacingToken.md }) {
      Column()
        .width(3)
        .height('100%')
        .backgroundColor(this.reply.author.avatarColor)
        .opacity(0.5)
        .borderRadius(1.5)

      Column({ space: SpacingToken.xs }) {
        AuthorInfo({
          authorName: this.reply.author.name,
          avatarColor: this.reply.author.avatarColor,
          timestamp: this.reply.timestamp
        })

        Text(this.reply.text)
          .fontSize(18)
          .fontColor(ColorsToken.onSurface)
          .opacity(0.9)
          .width('100%')

        Row({ space: SpacingToken.md }) {
          InfoChip({ label: `${this.reply.votes} votes` })
          InfoChip({ label: 'Reply' })
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct TopAppBar {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Row() {
      Stack() {
        Canvas(this.context)
          .width(24)
          .height(24)
          .onReady(() => {
            this.context.strokeStyle = ColorsToken.primary
            this.context.lineWidth = 3
            this.context.lineCap = 'round'
            this.context.beginPath()
            this.context.moveTo(0, 12)
            this.context.lineTo(24, 12)
            this.context.stroke()
            this.context.beginPath()
            this.context.moveTo(0, 12)
            this.context.lineTo(12, 0)
            this.context.stroke()
            this.context.beginPath()
            this.context.moveTo(0, 12)
            this.context.lineTo(12, 24)
            this.context.stroke()
          })
      }
      .width(50)
      .height(50)
      .alignContent(Alignment.Center)

      Blank()

      Text('r/jetpackcompose')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(ColorsToken.onSurface)

      Blank()

      Row()
        .width(50)
        .height(50)
    }
    .width('100%')
    .height(60)
    .padding({ left: SpacingToken.lg, right: SpacingToken.lg })
    .backgroundColor(ColorsToken.surface)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BottomCommentBar {
  @Link commentText: string

  build() {
    Column({ space: 0 }) {
      Divider()
        .color(ColorsToken.outline)
        .opacity(0.3)
        .margin({ left: SpacingToken.lg, right: SpacingToken.lg })

      Row({ space: SpacingToken.md }) {
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(52)
            .borderRadius(ShapesToken.large)
            .backgroundColor(ColorsToken.surfaceVariant)

          if (this.commentText.length === 0) {
            Text('Add a comment...')
              .fontSize(18)
              .fontColor(ColorsToken.outline)
              .padding({ left: SpacingToken.lg, right: SpacingToken.lg })
              .height(52)
          }

          TextInput({ text: this.commentText, placeholder: '' })
            .fontSize(18)
            .fontColor(ColorsToken.onSurface)
            .backgroundColor(Color.Transparent)
            .height(52)
            .padding({ left: SpacingToken.lg, right: SpacingToken.lg })
            .onChange((val: string) => {
              this.commentText = val
            })
        }
        .layoutWeight(1)
        .height(52)

        Button('POST')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(ColorsToken.onPrimary)
          .height(52)
          .padding({ left: SpacingToken.lg, right: SpacingToken.lg })
          .backgroundColor(ColorsToken.primary)
          .borderRadius(ShapesToken.large)
      }
      .padding({
        left: SpacingToken.lg,
        right: SpacingToken.lg,
        top: SpacingToken.md,
        bottom: SpacingToken.md
      })
      .width('100%')
      .backgroundColor(ColorsToken.surface)
    }
    .width('100%')
  }
}

@Entry
@Component
struct ForumPostView {
  @State voteState: number = 1
  @State commentText: string = ''

  private post: PostData = {
    author: { name: 'user/compose_master', avatarColor: ColorsToken.tertiary } as AuthorData,
    timestamp: '8 hours ago',
    title: 'The power of Jetpack Compose for single-file UIs',
    body: 'Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it\'s becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?',
    votes: 1337,
    commentCount: 42
  }

  private replies: ReplyData[] = [
    {
      id: 1,
      author: { name: 'dev/android_fan', avatarColor: ColorsToken.secondary } as AuthorData,
      timestamp: '7h ago',
      text: 'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.',
      votes: 25
    },
    {
      id: 2,
      author: { name: 'ux/designer_jane', avatarColor: ColorsToken.primary } as AuthorData,
      timestamp: '5h ago',
      text: 'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.',
      votes: 18
    }
  ]

  build() {
    Column({ space: 0 }) {
      TopAppBar()

      Scroll() {
        Column({ space: 0 }) {
          PostCard({
            post: this.post,
            voteState: this.voteState,
            onVote: (v: number) => {
              this.voteState = v
            }
          })

          Text('TOP COMMENTS')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(ColorsToken.outline)
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({
              left: SpacingToken.lg,
              right: SpacingToken.lg,
              top: SpacingToken.sm,
              bottom: SpacingToken.sm
            })

          ForEach(this.replies, (reply: ReplyData) => {
            ReplyCard({ reply: reply })
              .padding({
                left: SpacingToken.lg,
                right: SpacingToken.lg,
                top: SpacingToken.sm,
                bottom: SpacingToken.sm
              })
          }, (reply: ReplyData) => reply.id.toString())
        }
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor(ColorsToken.background)
      .scrollBar(BarState.Off)

      BottomCommentBar({ commentText: $commentText })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ColorsToken.background)
  }
}