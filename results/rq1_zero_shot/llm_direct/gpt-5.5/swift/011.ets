class Author {
  name: string
  avatarColor: ResourceColor

  constructor(name: string, avatarColor: ResourceColor) {
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

class AppColors {
  static readonly primary: ResourceColor = '#00E5FF'
  static readonly secondary: ResourceColor = '#FF00AA'
  static readonly tertiary: ResourceColor = '#76FF03'
  static readonly background: ResourceColor = '#101024'
  static readonly surface: ResourceColor = '#1C1C3A'
  static readonly surfaceVariant: ResourceColor = '#282850'
  static readonly outline: ResourceColor = '#44446A'
  static readonly warning: ResourceColor = '#FFD600'
  static readonly onPrimary: ResourceColor = '#000000'
  static readonly onSurface: ResourceColor = '#E0E0FF'
}

class AppTypography {
  static readonly title: number = 20
  static readonly headline: number = 22
  static readonly body: number = 18
  static readonly label: number = 16
  static readonly small: number = 14
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 12
  static readonly large: number = 20
}

class AppSpacing {
  static readonly xs: number = 6
  static readonly sm: number = 10
  static readonly md: number = 16
  static readonly lg: number = 20
  static readonly xl: number = 28
}

@Component
struct UpVoteArrow {
  color: ResourceColor = AppColors.outline
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Canvas(this.context)
      .width(28)
      .height(28)
      .onReady(() => {
        this.context.clearRect(0, 0, 28, 28)
        this.context.beginPath()
        this.context.moveTo(14, 0)
        this.context.lineTo(28, 14)
        this.context.lineTo(14, 28)
        this.context.lineTo(0, 14)
        this.context.closePath()
        this.context.fillStyle = this.color as string
        this.context.fill()
      })
  }
}

@Component
struct AuthorInfo {
  author: Author = new Author('', AppColors.primary)
  timestamp: string = ''

  build() {
    HStack({ space: AppSpacing.sm }) {
      Stack() {
        Circle()
          .width(28)
          .height(28)
          .fill(this.author.avatarColor)

        Circle()
          .width(10)
          .height(10)
          .fill('rgba(0, 0, 0, 0.2)')
      }
      .width(28)
      .height(28)

      Text(this.author.name)
        .fontSize(AppTypography.small)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.author.avatarColor)

      Text(this.timestamp)
        .fontSize(AppTypography.small)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.outline)
    }
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct InfoChip {
  text: string = ''

  build() {
    Text(this.text)
      .fontSize(AppTypography.small)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.outline)
  }
}

@Component
struct PostCard {
  post: Post = new Post(new Author('', AppColors.primary), '', '', '', 0, 0)
  voteState: number = 0
  onVote: (value: number) => void = () => {}

  build() {
    HStack({ space: AppSpacing.md }) {
      VStack({ space: AppSpacing.sm }) {
        Button() {
          UpVoteArrow({
            color: this.voteState === 1 ? AppColors.secondary : AppColors.outline
          })
        }
        .backgroundColor(Color.Transparent)
        .padding(0)
        .onClick(() => {
          this.onVote(this.voteState === 1 ? 0 : 1)
        })

        Text(`${this.post.votes + this.voteState - 1}`)
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? AppColors.secondary : AppColors.onSurface)

        Button() {
          UpVoteArrow({
            color: this.voteState === -1 ? AppColors.primary : AppColors.outline
          })
            .rotate({ angle: 180 })
        }
        .backgroundColor(Color.Transparent)
        .padding(0)
        .onClick(() => {
          this.onVote(this.voteState === -1 ? 0 : -1)
        })
      }
      .width(60)

      VStack({ space: AppSpacing.sm }) {
        AuthorInfo({
          author: this.post.author,
          timestamp: this.post.timestamp
        })

        Text(this.post.title)
          .fontSize(AppTypography.headline)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)
          .width('100%')

        Text(this.post.body)
          .fontSize(AppTypography.body)
          .fontWeight(FontWeight.Regular)
          .fontColor('rgba(224, 224, 255, 0.8)')
          .width('100%')

        HStack({ space: AppSpacing.xl }) {
          InfoChip({ text: `${this.post.commentCount} Comments` })
          InfoChip({ text: 'Share' })
        }
        .padding({ top: AppSpacing.sm })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .alignItems(VerticalAlign.Top)
    .padding(AppSpacing.lg)
    .width('100%')
    .backgroundColor(AppColors.surface)
  }
}

@Component
struct ReplyCard {
  reply: Reply = new Reply(0, new Author('', AppColors.primary), '', '', 0)

  build() {
    HStack({ space: AppSpacing.md }) {
      Rect()
        .width(3)
        .height('100%')
        .radius(1.5)
        .fill(this.reply.author.avatarColor)
        .opacity(0.5)

      VStack({ space: AppSpacing.xs }) {
        AuthorInfo({
          author: this.reply.author,
          timestamp: this.reply.timestamp
        })

        Text(this.reply.text)
          .fontSize(AppTypography.body)
          .fontWeight(FontWeight.Regular)
          .fontColor('rgba(224, 224, 255, 0.9)')
          .width('100%')

        HStack({ space: AppSpacing.md }) {
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
struct BackIcon {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Canvas(this.context)
      .width(24)
      .height(24)
      .onReady(() => {
        this.context.clearRect(0, 0, 24, 24)
        this.context.strokeStyle = AppColors.primary as string
        this.context.lineWidth = 3
        this.context.lineCap = 'round'
        this.context.lineJoin = 'round'

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
}

@Component
struct TopAppBar {
  build() {
    Stack() {
      Rect()
        .width('100%')
        .height(60)
        .fill(AppColors.surface)

      HStack() {
        Button() {
          Stack() {
            BackIcon()
          }
          .width(50)
          .height(50)
        }
        .backgroundColor(Color.Transparent)
        .padding(0)
        .onClick(() => {})

        Blank()

        Text('r/jetpackcompose')
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Blank()

        Rect()
          .width(50)
          .height(50)
          .fill(Color.Transparent)
      }
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .width('100%')
      .height(60)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(60)
    .backgroundColor(AppColors.surface)
  }
}

@Component
struct BottomCommentBar {
  @Link commentText: string

  build() {
    VStack({ space: 0 }) {
      Rect()
        .height(1)
        .width('100%')
        .fill('rgba(68, 68, 106, 0.3)')
        .margin({ left: AppSpacing.lg, right: AppSpacing.lg })

      HStack({ space: AppSpacing.md }) {
        Stack({ alignContent: Alignment.Start }) {
          RoundRect({ width: '100%', height: 52 })
            .fill(AppColors.surfaceVariant)
            .radius(AppShapes.large)

          if (this.commentText.length === 0) {
            Text('Add a comment...')
              .fontSize(AppTypography.body)
              .fontColor(AppColors.outline)
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
              .height(52)
          }

          TextInput({ text: this.commentText })
            .fontSize(AppTypography.body)
            .fontColor(AppColors.onSurface)
            .caretColor(AppColors.primary)
            .backgroundColor(Color.Transparent)
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
            .height(52)
            .width('100%')
            .onChange((value: string) => {
              this.commentText = value
            })
        }
        .layoutWeight(1)
        .height(52)

        Button() {
          Text('POST')
            .fontSize(AppTypography.label)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onPrimary)
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
        }
        .height(52)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.large)
        .onClick(() => {})
      }
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: AppSpacing.md
      })
      .backgroundColor(AppColors.surface)
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
  }
}

@Entry
@Component
struct ForumPostView {
  @State private voteState: number = 1
  @State private commentText: string = ''

  private post: Post = new Post(
    new Author('user/compose_master', AppColors.tertiary),
    '8 hours ago',
    'The power of Jetpack Compose for single-file UIs',
    'Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it\'s becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?',
    1337,
    42
  )

  private replies: Reply[] = [
    new Reply(
      1,
      new Author('dev/android_fan', AppColors.secondary),
      '7h ago',
      'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.',
      25
    ),
    new Reply(
      2,
      new Author('ux/designer_jane', AppColors.primary),
      '5h ago',
      'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.',
      18
    )
  ]

  build() {
    Column({ space: 0 }) {
      TopAppBar()

      Scroll() {
        Column({ space: 0 }) {
          PostCard({
            post: this.post,
            voteState: this.voteState,
            onVote: (newVote: number) => {
              this.voteState = newVote
            }
          })

          Text('TOP COMMENTS')
            .fontSize(AppTypography.small)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.outline)
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              top: AppSpacing.sm,
              bottom: AppSpacing.sm
            })

          ForEach(this.replies, (reply: Reply) => {
            ReplyCard({ reply: reply })
              .padding({
                left: AppSpacing.lg,
                right: AppSpacing.lg,
                top: AppSpacing.sm,
                bottom: AppSpacing.sm
              })
          }, (reply: Reply) => reply.id.toString())
        }
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor(AppColors.background)

      BottomCommentBar({ commentText: $commentText })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}