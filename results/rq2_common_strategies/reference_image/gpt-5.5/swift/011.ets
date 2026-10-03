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

class AppColors {
  static readonly primary: string = '#00E5FF'
  static readonly secondary: string = '#FF00AA'
  static readonly tertiary: string = '#76FF03'
  static readonly background: string = '#101024'
  static readonly surface: string = '#1C1C3A'
  static readonly surfaceVariant: string = '#282850'
  static readonly outline: string = '#44446A'
  static readonly warning: string = '#FFD600'
  static readonly onPrimary: string = '#000000'
  static readonly onSurface: string = '#E0E0FF'
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
struct VoteDiamond {
  color: ResourceColor = AppColors.outline

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Stack()
        .width(20)
        .height(20)
        .backgroundColor(this.color)
        .rotate({ angle: 45 })
    }
    .width(28)
    .height(28)
  }
}

@Component
struct AuthorInfo {
  author: Author = new Author('', AppColors.primary)
  timestamp: string = ''

  build() {
    Row({ space: AppSpacing.sm }) {
      Stack({ alignContent: Alignment.Center }) {
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
  onVote: (value: number) => void = (value: number) => {}

  build() {
    Row({ space: AppSpacing.md }) {
      Column({ space: AppSpacing.sm }) {
        Button() {
          VoteDiamond({
            color: this.voteState === 1 ? AppColors.secondary : AppColors.outline
          })
        }
        .width(40)
        .height(36)
        .padding(0)
        .backgroundColor(Color.Transparent)
        .type(ButtonType.Normal)
        .stateEffect(false)
        .onClick(() => {
          this.onVote(this.voteState === 1 ? 0 : 1)
        })

        Text(`${this.post.votes + this.voteState - 1}`)
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? AppColors.secondary : AppColors.onSurface)

        Button() {
          VoteDiamond({
            color: this.voteState === -1 ? AppColors.primary : AppColors.outline
          })
        }
        .width(40)
        .height(36)
        .padding(0)
        .backgroundColor(Color.Transparent)
        .type(ButtonType.Normal)
        .stateEffect(false)
        .onClick(() => {
          this.onVote(this.voteState === -1 ? 0 : -1)
        })
      }
      .width(60)
      .alignItems(HorizontalAlign.Center)

      Column({ space: AppSpacing.sm }) {
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
          .fontColor(AppColors.onSurface)
          .opacity(0.8)
          .width('100%')

        Row({ space: AppSpacing.xl }) {
          InfoChip({ text: `${this.post.commentCount} Comments` })
          InfoChip({ text: 'Share' })
        }
        .margin({ top: AppSpacing.sm })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
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
    Row({ space: AppSpacing.md }) {
      Stack()
        .width(3)
        .height(174)
        .borderRadius(1.5)
        .backgroundColor(this.reply.author.avatarColor)
        .opacity(0.5)

      Column({ space: AppSpacing.xs }) {
        AuthorInfo({
          author: this.reply.author,
          timestamp: this.reply.timestamp
        })

        Text(this.reply.text)
          .fontSize(AppTypography.body)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
          .opacity(0.9)
          .width('100%')

        Row({ space: AppSpacing.md }) {
          InfoChip({ text: `${this.reply.votes} votes` })
          InfoChip({ text: 'Reply' })
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(VerticalAlign.Top)
    .width('100%')
  }
}

@Component
struct TopAppBar {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text('r/jetpackcompose')
        .fontSize(AppTypography.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Row() {
        Button() {
          Text('‹')
            .fontSize(56)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.primary)
            .margin({ bottom: 6 })
        }
        .width(50)
        .height(50)
        .padding(0)
        .backgroundColor(Color.Transparent)
        .type(ButtonType.Normal)
        .stateEffect(false)

        Blank()
          .layoutWeight(1)

        Blank()
          .width(50)
          .height(50)
      }
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .width('100%')
      .height(60)
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
    Column({ space: 0 }) {
      Divider()
        .strokeWidth(1)
        .color(AppColors.outline)
        .opacity(0.3)
        .margin({ left: AppSpacing.lg, right: AppSpacing.lg })

      Row({ space: AppSpacing.md }) {
        TextInput({
          text: this.commentText,
          placeholder: 'Add a comment...'
        })
          .layoutWeight(1)
          .height(52)
          .borderRadius(AppShapes.large)
          .backgroundColor(AppColors.surfaceVariant)
          .fontSize(AppTypography.body)
          .fontColor(AppColors.onSurface)
          .placeholderColor(AppColors.outline)
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
          .caretColor(AppColors.primary)
          .onChange((value: string) => {
            this.commentText = value
          })

        Button() {
          Text('POST')
            .fontSize(AppTypography.label)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onPrimary)
        }
        .width(84)
        .height(52)
        .borderRadius(AppShapes.large)
        .backgroundColor(AppColors.primary)
        .type(ButtonType.Normal)
        .stateEffect(true)
      }
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: AppSpacing.md
      })
      .width('100%')
      .backgroundColor(AppColors.surface)
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
  }
}

@Entry
@Component
struct ForumPostView {
  @State voteState: number = 1
  @State commentText: string = ''

  post: Post = new Post(
    new Author('user/compose_master', AppColors.tertiary),
    '8 hours ago',
    'The power of Jetpack Compose for single-file UIs',
    'Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it\'s becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?',
    1337,
    42
  )

  replies: Reply[] = [
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
      .width('100%')
      .backgroundColor(AppColors.background)

      BottomCommentBar({ commentText: $commentText })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}